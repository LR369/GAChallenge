import 'dart:async';

import 'package:flame/components.dart';

enum TreeState { soil, seed, seedling, tree, unhealthyTree, plant }

class Tree extends SpriteGroupComponent with HasGameRef {
  SpriteGroupComponent<TreeState> treeComponent =
      SpriteGroupComponent<TreeState>();

  List<Vector2> pngSizes = [Vector2.all(30)];
  @override
  FutureOr<void> onLoad() async {
    super.onLoad();
    final soilSprite = await gameRef.loadSprite("soil.png");
    final seedSprite = await gameRef.loadSprite("seeded.png");
    final seedlingSprite = await gameRef.loadSprite("seedling.png");
    final plantSprite = await gameRef.loadSprite("plant.png");
    final treeSprite = await gameRef.loadSprite("tree.png");
    final unhealthyTreeSprite = await gameRef.loadSprite("tree.png");
    // anchor = Anchor.center;

    sprites = {
      TreeState.soil: soilSprite,
      TreeState.seed: seedSprite,
      TreeState.seedling: seedlingSprite,
      TreeState.plant: plantSprite,
      TreeState.tree: treeSprite,
      TreeState.unhealthyTree: unhealthyTreeSprite,
    };

    current = TreeState.soil;
    treeComponent = SpriteGroupComponent<TreeState>(
      sprites: {
        TreeState.soil: soilSprite,
        TreeState.seed: seedSprite,
        TreeState.seedling: seedlingSprite,
        TreeState.plant: plantSprite,
        TreeState.tree: treeSprite,
        TreeState.unhealthyTree: unhealthyTreeSprite
      },
      current: TreeState.soil,
      size: Vector2(10, 10),
    );
    size = Vector2.all(100);
    anchor = Anchor.center;
    opacity = 0;
    //add(treeComponent);
  }

  void changeTreeSpriteState() {
    if (current == TreeState.soil) {
      current = TreeState.seed;
    } else if (current == TreeState.seed) {
      current = TreeState.seedling;
    } else if (current == TreeState.seedling) {
      current = TreeState.plant;
      size = Vector2(20, 150);
    } else if (current == TreeState.plant) {
      current = TreeState.tree;
      size = Vector2(100, 300);
    } else if (current == TreeState.tree) {
      current = TreeState.soil;
      size = Vector2(100, 300);
    }
  }

  void unhealthyTreeSpriteState() {
    current = TreeState.unhealthyTree;
  }

  void disapppearTree() {
    opacity = 0;
  }
}
