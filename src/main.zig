const std = @import("std");
const rev = @import("./reverse.zig");

pub fn main() !void {
    std.debug.print("这是一个将数据依 bit 为单位进行逆序的demo!", .{});
}

test "Test data in reverse order" {
    const reverse = rev.Reverse();

    try std.testing.expectEqual(0x6a, reverse.reverse_byte(0x56));
    try std.testing.expectEqual(0xa5a55a5a, reverse.reverse_word(0x5a5aa5a5));
}
