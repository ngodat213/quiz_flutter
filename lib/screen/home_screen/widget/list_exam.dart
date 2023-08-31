import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quiz_flutter/models/models.dart';
import 'package:quiz_flutter/screen/home_screen/cubit/home_cubit.dart';
import 'package:quiz_flutter/screen/home_screen/widget/card_exam.dart';
import 'package:quiz_flutter/themes/text_styles.dart';

class ListExam extends StatefulWidget {
  const ListExam({
    super.key,
  });

  @override
  State<ListExam> createState() => _ListExamState();
}

class _ListExamState extends State<ListExam> {
  @override
  void initState() {
    super.initState();
    context.read<HomeCubit>().getQuiz();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        if (state is LoadedQuizState) {
          List<Quiz> quizs = state.quizs;
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Today test', style: TxtStyle.title),
              const SizedBox(height: 8),
              Text('Here is your test list for today',
                  style: TxtStyle.hintStyle),
              const SizedBox(height: 8),
              SizedBox(
                height: 180,
                child: ListView.builder(
                  itemCount: 5,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return CardExam(
                      title: quizs[index].title,
                      lesson: quizs[index].lessons.length,
                    );
                  },
                ),
              )
            ],
          );
        } else {
          return Container();
        }
      },
    );
  }
}
