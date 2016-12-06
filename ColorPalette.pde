import java.util.Map;

// カラーパレットタイプ
public static class ColorScheme {
  public static class Order {
    static int Identity           = 0; // 0 1c　同じ色相の色のみを用いた配色。色相の個性を全面に出せるが、色相差がないため、静かでおとなしいイメージを作ることができる。単調になりがちなので、明度や彩度差をもたせてコントラストを取る事が多い。
    static int Analogy            = 1; // 30 2c 色相環で隣り合った色で作る配色。やわらかい印象になりやすく、アイデンティティより単調さを避けれる。この配色も明度や彩度に大きくコントラストをとるとうまくいきやすい。失敗しにくい配色。
    static int Intermediate       = 2; // 90 2c 色相環で90度の位置にある色同士を使った配色。色相に中程度のコントラストがあり、バランスよく安定感がある配色。
    static int Dyad               = 3; // 180 2c 色相環で反対側に位置する補色の関係にある色の組み合わせ。インパクトが強くなる。色立体の中心を中点として正反対の位置にあるのがポイント。つまり、赤の明度を上げた場合、補色である緑の明度は落とす。コンプリメンタリー（Complementary）とも呼ばれる。
    static int Opornent           = 4; // 180 +- 30-60 2c インターミディエートとコンプリメンタリーの間での2色配色。派手すぎず、コンプリメンタリーよりも調和させやすい。
    static int SplitComplementary = 5; // 180 +- 30 2c 補色の両隣りの色を使った3色配色。この配色もコンプリメンタリーよりも調和しやすい。
    static int Triad              = 6; // 360/3 色相環を三等分した位置にある3色での配色。バランスの取れた配色の組み合わせ。
    static int Tetrad             = 7; // 360/4 色相環を四等分した位置にある色もしくは2組の補色での配色。2組の補色同士の色なのでカラフルな色合いになる。色数を増やす必要がある場合に試してみる価値あり。
    static int Pentad             = 8; // 360/5 色相環を5つに分けた色、もしくはトライアドに白と黒を加えた5色の配色。
    static int Hexad              = 9; // 360/6 色相環を正六角形分けた6色、もしくはテトラードに白と黒を加えた6色の配色。
  }
}

// 色システム
// 色のブレンドの設定など
public class ColorPalette {
  // 色情報
  public class Item {
    public color Color;
  }
  public ColorPalette() {
    colors = new HashMap<Integer,Item>();
  }

  public HashMap<Integer,Item> colors;
  public int Scheme = 0;
  
  public void draw(PApplet applet, int _width, int _height)
  { 
    applet.pushMatrix();
    applet.pushStyle();
    applet.ellipseMode(CORNER);
    applet.noStroke();
    int ellipseSize = _width/colors.size();
    // TODO : いい感じに表示する
    for(int i = 0; i < colors.size(); i++) {
      applet.fill(colors.get(i).Color);
      applet.ellipse(i*ellipseSize,0,ellipseSize,ellipseSize);
    }
    applet.popStyle();
    applet.popMatrix();
  }
  
  public void Generate(int angle, int saturation, int brightness)
  {
    pushStyle();
    int hue = 120;
    colorMode(HSB,360,100,100,255);
    for(int i = 0; i < 3; i++) {
      Item item = new Item();
      item.Color = color((i*hue+angle)%360, saturation, brightness);
      colors.put(i,item);
    }
    popStyle();
  }
  
  public color KeyColor()
  {
    return colors.get(0).Color; 
  }
  
  public color SubColor()
  {
    return colors.get(1).Color;
  }
  
  public color AccentColor()
  {
    return colors.get(2).Color;
  }
}