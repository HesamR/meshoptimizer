const std = @import("std");

pub fn build(b: *std.Build) void {
    const target = b.standardTargetOptions(.{});
    const optimize = b.standardOptimizeOption(.{});

    const lib = b.addStaticLibrary(.{
        .name = "meshoptimizer",
        .target = target,
        .optimize = optimize,
    });

    lib.linkLibC();
    lib.linkLibCpp();

    const root = "c-src/";

    lib.addCSourceFiles(.{
        .files = &.{
            root ++ "allocator.cpp",
            root ++ "clusterizer.cpp",
            root ++ "indexcodec.cpp",
            root ++ "indexgenerator.cpp",
            root ++ "overdrawanalyzer.cpp",
            root ++ "overdrawoptimizer.cpp",
            root ++ "quantization.cpp",
            root ++ "simplifier.cpp",
            root ++ "spatialorder.cpp",
            root ++ "stripifier.cpp",
            root ++ "vcacheanalyzer.cpp",
            root ++ "vcacheoptimizer.cpp",
            root ++ "vertexcodec.cpp",
            root ++ "vertexfilter.cpp",
            root ++ "vfetchanalyzer.cpp",
            root ++ "vfetchoptimizer.cpp",
        },

        .flags = &.{
            "-std=c++11",
        },
    });

    const module = b.addModule("main", .{
        .root_source_file = .{ .path = "src/meshoptimizer.zig" },
    });

    module.linkLibrary(lib);
}
