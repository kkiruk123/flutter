import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'dart:ui' as ui;

class AndroidLarge1 extends StatelessWidget {
  AndroidLarge1();

  @override
  Widget build(BuildContext context) {
    return CustomPaint(painter: AndroidLarge1Painter());
  }
}

class AndroidLarge1Painter extends CustomPainter {
  AndroidLarge1Painter();

  @override
  void paint(Canvas canvas, Size size) {
    canvas.drawColor(Colors.transparent, BlendMode.screen);
    var frame = Offset.zero & size;
    canvas.translate(494.0000000000, 84.0000000000);

// 15:13 : Android Large - 1 (COMPONENT)
    var draw_15_13 = (Canvas canvas, Rect container) {
      var frame = Rect.fromLTWH(
          -494.0000000000,
          -84.0000000000,
          (container.width - (0.0)),
          (container.height -
              (0.0))) /* H:LEFT_RIGHT V:TOP_BOTTOM F:(l:-494,t:-84,r:494,b:494,w:360,h:800) */;
      canvas.save();
      canvas.transform(Float64List.fromList([
        1.0000000000,
        0.0,
        0.0,
        0.0,
        0.0,
        1.0000000000,
        0.0,
        0.0,
        0.0,
        0.0,
        1.0,
        0.0,
        frame.left,
        frame.top,
        0.0,
        1.0
      ]));
      canvas.drawRect(Offset.zero & frame.size,
          (Paint()..color = _ColorCatalog.instance.color_0));

// 15:14 : hello world !! (TEXT)
      var draw_15_14 = (Canvas canvas, Rect container) {
        var frame = Rect.fromLTWH(
            ((container.width / 2.0) - (60.0000000000)),
            ((container.height / 2.0) - 7.0000000000),
            120.0000000000,
            24.0000000000) /* H:CENTER V:CENTER F:(l:120,t:393,r:120,b:120,w:120,h:24) */;
        canvas.save();
        canvas.transform(Float64List.fromList([
          1.0000000000,
          0.0,
          0.0,
          0.0,
          0.0,
          1.0000000000,
          0.0,
          0.0,
          0.0,
          0.0,
          1.0,
          0.0,
          frame.left,
          frame.top,
          0.0,
          1.0
        ]));
        var style_0 = _TextStyleCatalog.instance.ui_TextStyle_0;
        var paragraphStyle = ui.ParagraphStyle(
          fontFamily: 'Inter',
          textAlign: TextAlign.center,
          fontSize: 20.0000000000,
          fontWeight: FontWeight.w400,
        );
        var paragraphBuilder = ui.ParagraphBuilder(paragraphStyle)
          ..pushStyle(style_0);
        paragraphBuilder.addText("hello world !!");
        var paragraph = paragraphBuilder.build();
        paragraph.layout(new ui.ParagraphConstraints(width: frame.width));
        canvas.drawParagraph(paragraph, Offset.zero);
        canvas.restore();
      };
      draw_15_14(canvas, frame);
      canvas.restore();
    };
    draw_15_13(canvas, frame);
  }

  @override
  SemanticsBuilderCallback get semanticsBuilder {
    return (Size size) => [];
  }

  @override
  bool shouldRebuildSemantics(AndroidLarge1Painter oldDelegate) {
    return shouldRepaint(oldDelegate);
  }

  @override
  bool shouldRepaint(AndroidLarge1Painter oldDelegate) {
    return false;
  }
}

class _PathCatalog {
  _PathCatalog() {}

  static final _PathCatalog instance = _PathCatalog();
}

class _PaintCatalog {
  _PaintCatalog() {}

  static final _PaintCatalog instance = _PaintCatalog();
}

class _EffectCatalog {
  _EffectCatalog() {}

  static final _EffectCatalog instance = _EffectCatalog();
}

class _ColorCatalog {
  _ColorCatalog() {
    this.color_0 = Color.fromARGB(255, 255, 255, 255);
    this.color_1 = Color.fromARGB(255, 0, 0, 0);
  }

  Color color_0 = Color.fromARGB(0, 0, 0, 0);

  Color color_1 = Color.fromARGB(0, 0, 0, 0);

  static final _ColorCatalog instance = _ColorCatalog();
}

class _TextStyleCatalog {
  _TextStyleCatalog() {
    this.ui_TextStyle_0 = ui.TextStyle(
      fontFamily: 'Inter',
      color: _ColorCatalog.instance.color_1,
      fontSize: 20.0000000000,
      fontWeight: FontWeight.w400,
    );
  }

  ui.TextStyle ui_TextStyle_0 = ui.TextStyle();

  static final _TextStyleCatalog instance = _TextStyleCatalog();
}

class Data {
  Data({required this.isVisible});

  final bool isVisible;

  @override
  bool operator ==(o) => o is Data && isVisible == o.isVisible;
  @override
  int get hashcode {
    int result = 17;
    result = 37 * result + (this.isVisible?.hashCode ?? 0);
    return result;
  }
}

class TextData extends Data {
  TextData({isVisible, required this.text}) : super(isVisible: isVisible);

  final String text;

  @override
  bool operator ==(o) =>
      o is TextData && isVisible == o.isVisible && text == o.text;
  @override
  int get hashcode {
    int result = 17;
    result = 37 * result + (this.isVisible?.hashCode ?? 0);
    result = 37 * result + (this.text?.hashCode ?? 0);
    return result;
  }
}

class VectorData extends Data {
  VectorData({isVisible}) : super(isVisible: isVisible);

  @override
  bool operator ==(o) => o is VectorData && isVisible == o.isVisible;
  @override
  int get hashcode {
    int result = 17;
    result = 37 * result + (this.isVisible?.hashCode ?? 0);
    return result;
  }
}
