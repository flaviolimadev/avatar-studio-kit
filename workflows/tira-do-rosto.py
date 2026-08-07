#!/usr/bin/env -S uv run --script
# /// script
# dependencies = ["opencv-python-headless", "numpy"]
# ///
"""
Tira de conferência de uma REGIÃO DO ROSTO ao longo de um clipe.

Existe porque recorte por coordenada fixa não funciona: o enquadramento muda dentro do próprio
clipe (o sujeito se aproxima, inclina a cabeça) e o mesmo `crop=` que pegava os olhos passa a pegar
a testa. Errei isso três vezes seguidas e quase concluí "não pisca" por defeito de recorte, não do
vídeo. Aqui o YuNet acha o rosto em CADA quadro e o recorte segue os pontos dele.

Uso:
  uv run workflows/tira-do-rosto.py <video> --regiao olhos|sobrancelha|boca [--de 0] [--ate 99] [-n 15] [-o saida.png]
"""
import argparse
import os
import sys

import cv2
import numpy as np

REPO = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
MODEL = os.path.join(REPO, "assets", "models", "face_detection_yunet_2023mar.onnx")

ap = argparse.ArgumentParser()
ap.add_argument("video")
ap.add_argument("--regiao", default="olhos", choices=["olhos", "sobrancelha", "boca"])
ap.add_argument("--de", type=float, default=0)
ap.add_argument("--ate", type=float, default=1e9)
ap.add_argument("-n", type=int, default=15)
ap.add_argument("-o", default=None)
a = ap.parse_args()

cap = cv2.VideoCapture(a.video)
fps = cap.get(cv2.CAP_PROP_FPS) or 24
w = int(cap.get(cv2.CAP_PROP_FRAME_WIDTH))
h = int(cap.get(cv2.CAP_PROP_FRAME_HEIGHT))
total = int(cap.get(cv2.CAP_PROP_FRAME_COUNT))
det = cv2.FaceDetectorYN.create(MODEL, "", (w, h), 0.7)

ini, fim = int(a.de * fps), min(total, int(a.ate * fps))
alvos = np.linspace(ini, max(ini + 1, fim - 1), a.n).astype(int)

faixas = []
for n in alvos:
    cap.set(cv2.CAP_PROP_POS_FRAMES, int(n))
    ok, frame = cap.read()
    if not ok:
        continue
    _, faces = det.detect(frame)
    if faces is None or len(faces) == 0:
        continue
    f = faces[0]
    olho_dx, olho_dy, olho_ex, olho_ey = f[4], f[5], f[6], f[7]
    boca_y = (f[11] + f[13]) / 2
    cx = (olho_dx + olho_ex) / 2
    largura = abs(olho_ex - olho_dx) * 2.6            # sobra dos dois lados
    if a.regiao == "olhos":
        cy, altura = (olho_dy + olho_ey) / 2, abs(olho_ex - olho_dx) * 0.55
    elif a.regiao == "sobrancelha":
        # a sobrancelha fica acima do olho, a ~35% da distância olho→boca
        cy = (olho_dy + olho_ey) / 2 - (boca_y - (olho_dy + olho_ey) / 2) * 0.35
        altura = abs(olho_ex - olho_dx) * 0.50
    else:
        cy, altura = boca_y, abs(olho_ex - olho_dx) * 0.70
    x0, x1 = int(max(0, cx - largura / 2)), int(min(w, cx + largura / 2))
    y0, y1 = int(max(0, cy - altura / 2)), int(min(h, cy + altura / 2))
    corte = frame[y0:y1, x0:x1]
    if corte.size:
        faixas.append(cv2.resize(corte, (360, max(1, int(360 * corte.shape[0] / corte.shape[1])))))

if not faixas:
    sys.exit("nenhum rosto detectado no intervalo pedido")

alt = min(f.shape[0] for f in faixas)
tira = np.vstack([f[:alt] for f in faixas])
saida = a.o or os.path.splitext(a.video)[0] + f"-{a.regiao}.png"
cv2.imwrite(saida, tira)
print(f"{len(faixas)} quadros · {a.regiao} · {a.de:.1f}s→{min(a.ate, total/fps):.1f}s → {saida}")
