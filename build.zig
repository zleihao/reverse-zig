const std = @import("std");

pub fn build(b: *std.Build) !void {
    const target = b.standardTargetOptions(.{});
    const optimize = b.standardOptimizeOption(.{});

    const reverse_module = b.addModule("reverse", .{
        .root_source_file = b.path("modules/reverse.zig"),
        .target = target,
        .optimize = optimize,
    });

    const exe = b.addExecutable(.{
        .name = "reverse-zig",
        .root_source_file = b.path("src/main.zig"),
        .target = target,
        .optimize = optimize,
        .strip = true,
    });

    exe.root_module.addImport("reverse", reverse_module);
    b.installArtifact(exe);

    const cmd = b.addRunArtifact(exe);
    if (b.args) |args| {
        cmd.addArgs(args);
    }
    cmd.step.dependOn(&exe.step);

    const run = b.step("run", "");
    run.dependOn(&cmd.step);

    const testing = b.addTest(.{
        .root_source_file = b.path("modules/reverse.zig"),
        .target = target,
        .optimize = optimize,
    });
    const run_test = b.addRunArtifact(testing);

    const run_test_step = b.step("test", "");
    run_test_step.dependOn(&run_test.step);
}
