pub const Context = struct {

    var volume: f16 = 0.25;
    var color: NoiseColor = .white;

    const NoiseColor = enum {
        white,
        brown,
    };
};