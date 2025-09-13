const std = @import("std");
const builtin = @import("builtin");

pub fn main() !void {
    if (builtin.os.tag == .windows) {
        std.debug.print(
            "Zap (facil.io) is not supported on Windows. Use WSL or Linux to run the HTTP server.\n",
            .{},
        );
        std.debug.print("Build succeeded without starting the server.\n", .{});
        return;
    } else {
        const zap = @import("zap");
        const Handler = struct {
            pub fn on_request(r: zap.Request) void {
                if (r.path) |the_path| {
                    std.debug.print("PATH: {s}\n", .{the_path});
                }

                if (r.query) |the_query| {
                    std.debug.print("QUERY: {s}\n", .{the_query});
                }

                r.sendBody("<html><body><h1>Hello from ZAP!!!</h1></body></html>") catch return;
            }
        };

        var listener = zap.HttpListener.init(.{
            .port = 3000,
            .on_request = Handler.on_request,
            .log = true,
            .max_clients = 100000,
        });
        try listener.listen();

        std.debug.print("Listening on 0.0.0.0:3000\n", .{});

        zap.start(.{
            .threads = 2,
            .workers = 1, // 1 worker enables sharing state between threads
        });
    }
}
