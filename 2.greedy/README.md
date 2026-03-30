# 🎨 Coloreo de Grafos (Greedy Coloring) en Zig

Este código implementa dos versiones del algoritmo Greedy para el coloreo de grafos, utilizando una representación eficiente de matriz de adyacencia triangular.

### 📂 Problema: [Coloreo de Grafos (Greedy)](https://en.wikipedia.org/wiki/Greedy_coloring)

- **Fuente:** Algoritmos y estructuras de datos.
- **Concepto:** Algoritmos Ávidos (Greedy) / Teoría de Grafos

#### 🧠 1. Lógica del Algoritmo

> Queremos asignar un color a cada nodo de un grafo de forma que dos nodos conectados no tengan el mismo color. El enfoque Greedy decide el color de cada nodo basándose en los colores ya asignados a sus vecinos, eligiendo siempre el **primer color disponible** (el de menor índice).
>
> **En este repo hay dos enfoques:**
>
> 1. **El "Manual" (`greedy`):** Intenta pintar todos los nodos posibles con el color 0, luego remueve esos nodos del conjunto de "no coloreados" y repite el proceso con el color 1, y así sucesivamente. Es conceptualmente simple pero menos eficiente por el manejo de la lista de nodos.
> 2. **El "Optimizado" (`greedy_opt`):** Recorre cada nodo una sola vez. Para el nodo actual, marca qué colores ya están siendo usados por sus vecinos y le asigna el primero que esté libre. Es mucho más directo y rapido.

#### 📊 2. Complejidad (Big O)

| Versión          | Tiempo   | Espacio  | Justificación                                                                                                        |
| :--------------- | :------- | :------- | :------------------------------------------------------------------------------------------------------------------- |
| **`greedy`**     | $O(V^3)$ | $O(V^2)$ | Por cada color ($V$), recorre los nodos ($V$) y por cada uno realiza un `orderedRemove` que desplaza el array ($V$). |
| **`greedy_opt`** | $O(V^2)$ | $O(V^2)$ | Realiza un loop sobre los nodos ($V$) y por cada uno chequea sus vecinos ($V$) en la matriz.                         |

> **Nota sobre el Espacio:** La representación del grafo utiliza una **Matriz de Adyacencia Triangular**. En lugar de una matriz $N \times N$, se usa un array plano de tamaño $\frac{n(n-1)}{2}$, lo que optimiza el uso de memoria para grafos no dirigidos.

#### 🛠️ Detalles de Implementación

- **`greedy`**: Utiliza un `ArenaAllocator` para gestionar la memoria de las listas temporales de nodos y colores. El cuello de botella es el `orderedRemove` dentro de los loops.
- **`greedy_opt`**: Utiliza un array de booleanos de tamaño fijo $V$ (`color_is_forbidden`) para marcar rápidamente qué colores no se pueden usar, logrando una ejecución mucho más limpia y rápida.

---

_Hecho con ❤️ en Zig._
