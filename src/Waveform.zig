const std = @import("std");
const print = std.debug.print;

const qt = @import("libqt6zig");
const QWidget = qt.QWidget;
const QPaintEvent = qt.QPaintEvent;
const QStylePainter = qt.QStylePainter;
const QColor = qt.QColor;
const QMouseEvent = qt.QMouseEvent;
const QCursor = qt.QCursor;

pub const Waveform = struct {
    widget: QWidget = undefined,

    var point_counter: u8 = 0;
    const points: [10]Point = [_]Point{ Point{.x = 0.5, .y = 0.5} } ++ [_]Point{undefined} ** 9;

    const dba = struct {
        min: i8 = -5,
        max: i8 = 5,
    };

    const frequency = struct {
        min: u16 = 200,
        max: u16 = 3_000,
    };

    // 0 <= x,y <= 1
    const Point = struct {
        x: f16,
        y: f16,
    };

    pub fn init(alloc: std.mem.Allocator) *Waveform {
        var self = alloc.create(Waveform) catch @panic("Failed allocation of Waveform");
        self.widget = QWidget.New2();

        self.widget.OnPaintEvent(onPaintEvent);
        self.widget.OnMousePressEvent(onMousePressEvent);
        self.widget.OnMouseDoubleClickEvent(onMouseDoubleClickEvent);
        self.widget.OnMouseMoveEvent(onMouseMoveEvent);
        self.widget.OnMouseReleaseEvent(onMouseReleaseEvent);

        return self;
    }

    pub fn deinit(self: *Waveform, alloc: std.mem.Allocator) void {
        self.widget.Delete();
        alloc.destroy(self);
    }

    fn onPaintEvent(widget: QWidget, _: QPaintEvent) callconv(.c) void {
        const painter = QStylePainter.New(widget);
        defer painter.Delete();

        std.debug.print(".", .{});

        painter.FillRect6(
            widget.Rect(),
            qt.QColor.FromRgb2(50,50,50),
        );
        
        for (0..point_counter) |i| {
            _ = i;
            //create cubic
        }   
        //draw path
    }
    

    // Single left mouse button press
    fn onMousePressEvent(widget: QWidget, _: QMouseEvent) callconv(.c) void {
        const cursorPos = widget.MapFromGlobal2(QCursor.Pos()); 
        print("Press\n", .{});
        print("X: {d}, Y: {d}\n", .{cursorPos.X(), cursorPos.Y()});
        print("X: {d}, Y: {d}\n", .{widget.Rect().Width(), widget.Rect().Height()});
    }

    fn onMouseDoubleClickEvent(widget: QWidget, _: QMouseEvent) callconv(.c) void {
        _ = widget;
        print("Double\n", .{});
    }

    fn onMouseMoveEvent(widget: QWidget, _: QMouseEvent) callconv(.c) void {
        _ = widget;
        print("Move\n", .{});
    }

    fn onMouseReleaseEvent(widget: QWidget, _: QMouseEvent) callconv(.c) void {
        _ = widget;
        print("Release\n", .{});
    }

    fn addPoint(self: *Waveform, x: u16, y: u16) !void {
        if (self.counter == self.points.len) {
            return error.AAAAAAAAAAAAAAAAAAAAAHHHH_HELP_ME;
        }
        self.points[self.point_counter] = Point{
            .x = x,
            .y = y,
        };
        for (0..self.point_counter) |i| {
            // if (self.points[i].x > )
            _ = i;
            return;
        }
    }

    fn removePoint(self: *Waveform) void {
        if (self.point_counter == 1) {
            return;
        }
    }
};