import 'package:anime_ui_jg/models/anime.dart';
import 'package:anime_ui_jg/models/nav_bar.dart';
import 'package:anime_ui_jg/utils/anime_ui_colors.dart';
import 'package:anime_ui_jg/widgets/sliver_header_delegate.dart';
import 'package:flutter/material.dart';
//import 'package:flutter/widgets.dart';
//import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            const Body(),
            NavBar(),
          ],
        ),
      ),
    );
  }
}

class NavBar extends StatelessWidget {
  NavBar({
    super.key,
  });

  final _index = ValueNotifier<int>(0);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        height: kBottomNavigationBarHeight * 1.4,
        decoration: BoxDecoration(
          color: AnimeUiColors.background,
          boxShadow: [
            BoxShadow(
              color: AnimeUiColors.cyan.withOpacity(.45),
              spreadRadius: 7.5,
              blurRadius: 15,
            ),
          ],
        ),
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Row(
          children: List.generate(
            itemsNavBar.length,
            (index) => Expanded(
              child: ValueListenableBuilder<int>(
                  valueListenable: _index,
                  builder: (_, value, __) {
                    return GestureDetector(
                      onTap: () => _index.value = index,
                      child: Material(
                        color: Colors.transparent,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SvgPicture.asset(itemsNavBar[index].path,
                                colorFilter: const ColorFilter.mode(
                                    AnimeUiColors.cyan, BlendMode.srcIn)),
                            const SizedBox(height: 5),
                            Text(
                              itemsNavBar[index].name,
                              style: Theme.of(context)
                                  .textTheme
                                  .labelLarge
                                  ?.copyWith(
                                    color: (index == value)
                                        ? AnimeUiColors.cyan
                                        : Colors.white,
                                  ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }),
            ),
          ),
        ),
      ),
    );
  }
}

class Body extends StatelessWidget {
  const Body({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const CustomScrollView(
      slivers: [
        Header(),
        Trends(),
        Recents(),
        Aviable(),
        SliverToBoxAdapter(child: SizedBox(height: kBottomNavigationBarHeight * 1.4))
      ],
    );
  }
}

class Aviable extends StatelessWidget {
  const Aviable({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
          padding: const EdgeInsets.only(top: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                child: Text('Aviable: Kimetsu No Jaiba',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        color: Colors.white, fontWeight: FontWeight.bold)),
              ),
              AspectRatio(
                  aspectRatio: 16 / 9,
                  child: Stack(
                    children: [
                      Positioned.fill(
                        child: Image.asset(
                          'assets/images/kimetsu.png',
                          fit: BoxFit.cover,
                        ),
                      ),
                      Align(
                          child: SvgPicture.asset('assets/icons/play.svg',
                              width: 80)),
                    ],
                  ))
            ],
          )),
    );
  }
}

class Trends extends StatelessWidget {
  const Trends({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const SliverToBoxAdapter(
      child: Padding(
        padding: EdgeInsets.only(top: 10),
        child: AspectRatio(
          aspectRatio: 16 / 12,
          child: Column(
            children: [
              HeaderTrends(),
              ListTrends(),
            ],
          ),
        ),
      ),
    );
  }
}

class Recents extends StatelessWidget {
  const Recents({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.only(top: 20),
        child: AspectRatio(
          aspectRatio: 16 / 6,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Text('Recently added',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        color: Colors.white, fontWeight: FontWeight.bold)),
              ),
              const ListRecents(),
            ],
          ),
        ),
      ),
    );
  }
}

class ListRecents extends StatelessWidget {
  const ListRecents({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: LayoutBuilder(
        builder: (_, constraints) {
          return ListView.builder(
              itemCount: recentsData.length,
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.only(left: 20, top: 10),
              itemBuilder: (_, index) {
                return Padding(
                  padding: const EdgeInsets.only(right: 20),
                  child: SizedBox(
                    height: constraints.maxHeight,
                    width: constraints.maxWidth * .25,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.asset(recentsData[index].poster,
                          fit: BoxFit.cover),
                    ),
                  ),
                );
              });
        },
      ),
    );
  }
}

class ListTrends extends StatelessWidget {
  const ListTrends({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(child: LayoutBuilder(
      builder: (_, constraints) {
        return ListView.builder(
          itemCount: trendsData.length,
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.only(top: 10, left: 20),
          itemBuilder: (_, index) {
            final anime = trendsData[index];
            final style = Theme.of(context)
                .textTheme
                .labelLarge
                ?.copyWith(color: Colors.white, fontWeight: FontWeight.w600);
            return Padding(
                padding: const EdgeInsets.only(right: 20),
                child: SizedBox(
                  height: constraints.maxHeight,
                  width: constraints.maxWidth * .375,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Expanded(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.asset(anime.poster, fit: BoxFit.cover),
                        ),
                      ),
                      const SizedBox(height: 15),
                      Text(
                        anime.name,
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium
                            ?.copyWith(
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 7.5),
                      Row(
                        children: [
                          SvgPicture.asset('assets/icons/lupita.svg'),
                          const SizedBox(width: 5),
                          Text(
                            'Score: ${anime.score}',
                            style: style,
                          ),
                          const SizedBox(width: 7.5),
                          Text(
                            '#${anime.number}',
                            style: style?.copyWith(color: AnimeUiColors.cyan),
                          )
                        ],
                      )
                    ],
                  ),
                ));
          },
        );
      },
    ));
  }
}

class HeaderTrends extends StatelessWidget {
  const HeaderTrends({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          Expanded(
            child: Text(
              'Trends',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
            ),
          ),
          Text(
            'View all',
            style: Theme.of(context).textTheme.titleSmall?.copyWith(
                color: AnimeUiColors.cyan, fontWeight: FontWeight.w700),
          ),
        ],
      ),
    );
  }
}

class Header extends StatelessWidget {
  const Header({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SliverPersistentHeader(
      floating: true,
      delegate: SliverCustomHeaderDelegate(
        minHeight: 60,
        maxHeight: 60,
        child: Container(
          color: AnimeUiColors.background,
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      'Chrunchycroll Pro',
                      style: Theme.of(context)
                          .textTheme
                          .titleLarge
                          ?.copyWith(color: AnimeUiColors.cyan),
                    ),
                  ),
                  const Icon(Icons.search, color: Colors.white, size: 30),
                ],
              ),
              const SizedBox(height: 5),
              Text(
                'What would you like to watch today?',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: Colors.white,
                    ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
