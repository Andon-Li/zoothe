const std = @import("std");
const print = std.debug.print;

const qt = @import("libqt6zig");
const QWidget = qt.QWidget;
const QPaintEvent = qt.QPaintEvent;
const QStylePainter = qt.QStylePainter;
const QColor = qt.QColor;
const QMouseEvent = qt.QMouseEvent;
const QCursor = qt.QCursor;
const QPainterPath = qt.QPainterPath;
const QPointF = qt.QPointF;

pub const Waveform = struct {
    widget: QWidget = undefined,

    var points_counter: u8 = 3;
    var points: [10]Point = [_]Point{ 
        Point{.x = 0.0, .y = 0.4}, 
        Point{.x = 0.8, .y = 0.5},
        Point{.x = 1.0, .y = 0.8},
        } ++ [_]Point{undefined} ** 7;

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
        x: f64,
        y: f64,
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

        painter.FillRect6(
            widget.Rect(),
            qt.QColor.FromRgb2(50,50,50),
        );
        
        const path = QPainterPath.New2(QPointF.New5(
            points[0].x,
            points[0].y * @as(f64 ,@floatFromInt(widget.Height()))
        ));

        for (1..points_counter) |i| {
            path.CubicTo2(
                (points[i-1].x + (points[i].x - points[i-1].x)/2) * @as(f64 ,@floatFromInt(widget.Width())), 
                points[i-1].y * @as(f64 ,@floatFromInt(widget.Height())), 
                ((points[i-1].x + (points[i].x - points[i-1].x)/2) * @as(f64 ,@floatFromInt(widget.Width()))), 
                points[i].y * @as(f64 ,@floatFromInt(widget.Height())), 
                points[i].x * @as(f64 ,@floatFromInt(widget.Width())), 
                points[i].y * @as(f64 ,@floatFromInt(widget.Height()))
            );
        }
        
        painter.DrawPath(path);

        for (points) |point| {
            painter.DrawEllipse3(
                @trunc(point.x * widget.Width() - 10), 
                @trunc(point.y * widget.Height() - 10), 
                20, 
                20
                );
        }
    }
    

    // Single left mouse button press
    fn onMousePressEvent(widget: QWidget, _: QMouseEvent) callconv(.c) void {

        if (points_counter >= points.len) {
            return;
        }

        const cursorPos = widget.MapFromGlobal2(QCursor.Pos());

        const new_point: Point = .{
            .x = cursorPos.X() / @as(f64, @floatFromInt(widget.Width())),
            .y = cursorPos.Y() / @as(f64, @floatFromInt(widget.Height())),
        };
        print("{d:.3}\n", .{new_point.x});

        for (0..points_counter-1) |i| {
            if (points[i].x > new_point.x) {

                var j: u8 = points_counter;
                while (j > i) : (j -= 1) {
                    points[j] = points[j-1];
                } else {
                    points[i] = new_point;
                    points_counter += 1;
                }
                break;
            }
        } else {
            points[points_counter] = new_point;
            points_counter += 1;
        }

        widget.Update();
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

    fn closestPointDist() .{ , u16} {
        const cursorPos = widget.MapFromGlobal2(QCursor.Pos());

        for 

        const new_point: Point = .{
            .x = cursorPos.X() / @as(f64, @floatFromInt(widget.Width())),
            .y = cursorPos.Y() / @as(f64, @floatFromInt(widget.Height())),
        };
    }
};