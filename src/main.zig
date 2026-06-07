const std = @import("std");
const print = std.debug.print;

const qt = @import("libqt6zig");
const QApplication = qt.QApplication;
const QWidget = qt.QWidget;
const QHBoxLayout = qt.QHBoxLayout;
const QVBoxLayout = qt.QVBoxLayout;
const QPushButton = qt.QPushButton;
const QLabel = qt.QLabel;
const QSlider = qt.QSlider;

const Context = @import("Context.zig").Context;
const Waveform = @import("Waveform.zig").Waveform;


var context: Context = .{};

pub fn main(init: std.process.Init) !void {
    const gpa = init.gpa;

    const argv = try qt.init(init.gpa, init.minimal.args);
    defer qt.deinit(init.gpa, argv);

    var argc: i32 = @intCast(argv.len);
    const qapp = QApplication.New(init.arena.allocator(), &argc, argv);
    defer qapp.Delete();

    const window = QWidget.New2();
    defer window.Delete();
    
    const main_layout = QHBoxLayout.New(window);

    const waveform = Waveform.init(gpa);
    defer waveform.deinit(gpa);

    main_layout.AddWidget(waveform.widget);
    waveform.widget.Resize(300,300);

    const volume_slider = QSlider.New2();
    main_layout.AddWidget(volume_slider);

    window.Show();

    _ = QApplication.Exec();
}
