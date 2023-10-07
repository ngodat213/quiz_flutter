import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quiz_flutter/generated/l10n.dart';
import 'package:quiz_flutter/manager/manager_path_routes.dart';
import 'package:quiz_flutter/models/models.dart';
import 'package:quiz_flutter/screen/home_screen/cubit/home_cubit.dart';
import 'package:quiz_flutter/screen/home_screen/widget/card_exam.dart';
import 'package:quiz_flutter/screen/quiz_screen/cubit/quiz_cubit.dart';
import 'package:quiz_flutter/themes/dimens.dart';
import 'package:quiz_flutter/themes/text_styles.dart';
import 'package:quiz_flutter/utils/base_navigation.dart';

class ListExam extends StatefulWidget {
  const ListExam({
    super.key,
  });

  @override
  State<ListExam> createState() => _ListExamState();
}

class _ListExamState extends State<ListExam> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        List<Quiz> quizs = state.quizs;
        if (state.status == HomeStatus.isNotEmpty) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(S.of(context).todayTest, style: TxtStyle.title),
                  Text(S.of(context).all, style: TxtStyle.pMainColor),
                ],
              ),
              const SizedBox(height: Dimens.HEIGHT_8),
              Text(S.of(context).todayTestTitle, style: TxtStyle.hintStyle),
              const SizedBox(height: Dimens.HEIGHT_8),
              SizedBox(
                height: Dimens.HEIGHT_200,
                child: ListView.builder(
                  itemCount: quizs.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        context.read<QuizCubit>().quizChanged(quizs[index]);
                        BaseNavigation.push(context,
                            routeName: ManagerRoutes.quizScreen);
                      },
                      child: CardExam(
                        quiz: quizs[index],
                        image: 'lib/res/images/read_image$index.svg',
                      ),
                    );
                  },
                ),
              )
            ],
          );
        }
        return Container();
      },
    );
  }
}
