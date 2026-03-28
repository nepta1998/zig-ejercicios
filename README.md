# Ejercicios de Algoritmos en Zig

Practica de algoritmos y estructuras de datos implementados en [Zig](https://ziglang.org/).

## Estructura

Cada ejercicio vive en su propia carpeta numerada:

```
<num>.<tema>/
├── src/
│   ├── main.zig      # Punto de entrada
│   └── root.zig      # Logica del ejercicio
└── build.zig         # Configuracion de compilacion
```

## Ejercicios

| # | Tema | Descripcion |
|---|------|-------------|
| 1 | [holamundo](./1.holamundo/) | Introduccion a Zig: imports, allocators, testing y fuzzing |
| 2 | [greedy](./2.greedy/) | Algoritmo greedy para coloreo de grafos |

## Requisitos

- Zig 0.13+ ([instalar](https://ziglang.org/download/))

## Ejecutar un ejercicio

```bash
cd <num>.<tema>
zig build run
```

## Ejecutar tests

```bash
zig build test
```
