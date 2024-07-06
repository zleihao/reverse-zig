const std = @import("std");

///将数据依 bit 为单位进行逆序
pub fn Reverse() type {
    return struct {
        const Self = @This();

        pub fn reverse_byte(val: u8) u8 {
            var x = val;
            x = (((x & 0xaa) >> 1) | ((x & 0x55) << 1));
            x = (((x & 0xcc) >> 2) | ((x & 0x33) << 2));

            return ((x >> 4) | (x << 4));
        }

        pub fn reverse_word(val: u32) u32 {
            var x = val;
            // Swap adjacent bits
            x = (((x >> 1) & 0x55555555) | ((x & 0x55555555) << 1));
            // Swap adjacent pairs
            x = (((x >> 2) & 0x33333333) | ((x & 0x33333333) << 2));
            // Swap nibbles
            x = (((x >> 4) & 0x0f0f0f0f) | ((x & 0x0f0f0f0f) << 4));
            // Swap bytes
            x = (((x >> 8) & 0x00ff00ff) | ((x & 0x00ff00ff) << 8));
            // Swap 16-bit halves
            return ((x >> 16) | (x << 16));
        }
    };
}

test "Test data in reverse order" {
    const reverse = Reverse();

    try std.testing.expectEqual(0x6a, reverse.reverse_byte(0x56));
    try std.testing.expectEqual(0xa5a55a5a, reverse.reverse_word(0x5a5aa5a5));
}
