const std = @import("std");
const _2_greedy = @import("_2_greedy");

const Graph = struct {
    nv: i32,
    g: std.ArrayList(i32),
    allocator: std.mem.Allocator,

    pub fn init(allocator: std.mem.Allocator, n: i32) !Graph {
        const val_i32 = @divTrunc(n * (n - 1), 2);
        const size: usize = @intCast(val_i32);
        var list: std.ArrayList(i32) = .empty;
        try list.resize(allocator, size);
        @memset(list.items, 0);
        return Graph{
            .nv = n,
            .g = list,
            .allocator = allocator,
        };
    }

    // Liberar memoria (destructor manual)
    pub fn deinit(self: *Graph) void {
        self.g.deinit(self.allocator);
    }

    // Método para acceder a la arista (retorna un puntero para poder modificarlo)
    pub fn edge(self: *Graph, i: i32, j: i32) *i32 {
        if (j >= i) {
            const idx: usize = @intCast(@divTrunc(i * (i - 1), 2) + j);
            return &self.g.items[idx];
        } else {
            const idx: usize = @intCast(@divTrunc(j * (j - 1), 2) + i);
            return &self.g.items[idx];
        }
    }
};

pub fn main() !void {
    var seed: u64 = undefined;
    try std.posix.getrandom(std.mem.asBytes(&seed));

    var prng = std.Random.DefaultPrng.init(seed);
    const random = prng.random();

    const n: i32 = 4;

    var graph = try Graph.init(std.heap.page_allocator, n);
    defer graph.deinit();

    for (0..@intCast(n)) |i| {
        for (i + 1..@intCast(n)) |j| {
            const bit = random.uintAtMost(u1, 1);

            // Usamos @intCast para los índices y el valor
            graph.edge(@intCast(i), @intCast(j)).* = @intCast(bit);

            std.debug.print("({d},{d})={d} ", .{ i, j, bit });
        }
        std.debug.print("\n", .{});
    }

    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    const allocator = gpa.allocator();
    defer _ = gpa.deinit();
    var table_col: std.ArrayList(i32) = .empty;
    defer table_col.deinit(allocator);
    try table_col.resize(allocator, n);
    @memset(table_col.items, -1);
    try greedy(&graph, n, &table_col);
    for (table_col.items) |c| {
        std.debug.print("{d} ", .{c});
    }
    std.debug.print("\n", .{});
}

fn greedyc(g: *Graph, no_col: *std.ArrayList(i32), new_color: *std.ArrayList(i32), color: i32, table_col: *std.ArrayList(i32), allocator: std.mem.Allocator) !void {
    new_color.clearRetainingCapacity();
    for (no_col.items) |q| {
        var adj: bool = false;
        for (new_color.items) |w| {
            if (g.edge(q, w).* == 1) {
                adj = true;
                break;
            }
        }
        if (!adj) {
            table_col.items[@intCast(q)] = color;
            try new_color.append(allocator, q);
        }
    }
}
fn greedy(g: *Graph, nv: i32, table_col: *std.ArrayList(i32)) !void {
    var color: i32 = 0;
    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    const allocator = gpa.allocator();
    defer _ = gpa.deinit();
    var no_col: std.ArrayList(i32) = .empty;
    defer no_col.deinit(allocator);
    var new_color: std.ArrayList(i32) = .empty;
    defer new_color.deinit(allocator);
    var idx: i32 = 0;
    while (idx < nv) : (idx += 1) {
        try no_col.append(allocator, idx);
    }
    while (no_col.items.len != 0) {
        try greedyc(g, &no_col, &new_color, color, table_col, allocator);
        for (new_color.items) |q| {
            var left: usize = 0;
            var right = no_col.items.len;
            while (left < right) {
                const mid = left + (right - left) / 2;
                if (no_col.items[mid] == q) {
                    _ = no_col.orderedRemove(mid);
                    break;
                } else if (no_col.items[mid] < q) {
                    left = mid + 1;
                } else {
                    right = mid;
                }
            }
        }
        color += 1;
    }
}

fn greedy_opt() void {}
