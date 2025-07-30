import 'package:ada/core/theme/app_colors.dart';
import 'package:ada/core/widgets/custom_text_form_field.dart';
import 'package:ada/features/home_note_app/data/repo/note_repo_impl.dart';
import 'package:ada/features/home_note_app/ui/cubit/note_cubit.dart';
import 'package:ada/features/home_note_app/ui/views/widgets/custom_appbar.dart';
import 'package:ada/features/home_note_app/ui/views/widgets/custom_card_note.dart';
import 'package:ada/features/home_note_app/ui/views/widgets/custom_graid_view.dart';
import 'package:ada/features/home_note_app/ui/views/widgets/custom_recent_note.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomeNoteApp extends StatelessWidget {
  const HomeNoteApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => NoteCubit(NoteRepoImpl())..getUserData(),
      child: BlocBuilder<NoteCubit, NoteState>(
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(toolbarHeight: 0),
            body: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Padding(
                padding: EdgeInsets.all(22.0.r),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    CustomAppbar(),
                    16.verticalSpace,
                    CustomTextFormField(
                      hintText: "Search",
                      hintStyle: TextStyle(
                        color: AppColor.textGray,
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    22.verticalSpace,
                    CustomGridView(),
                    20.verticalSpace,
                    Text(
                      "Recent Notes",
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    16.verticalSpace,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CustomRecentNote(isSelected: true),
                        12.horizontalSpace,
                        CustomRecentNote(
                          title: "UX Design",
                          description:
                              "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Maecenas sed diam cum ligula justo. Nisi, consectetur elementum.",
                        ),
                      ],
                    ),
                    12.verticalSpace,
                    BlocBuilder<NoteCubit, NoteState>(
                      builder: (context, state) {
                        if (state is NoteLoading) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                        if (state is NoteError) {
                          return Center(
                            child: Text(
                              state.message,
                              style: TextStyle(
                                color: Colors.red,
                                fontSize: 16.sp,
                              ),
                            ),
                          );
                        }
                        if (state is NoteSuccess) {
                          return ListView.separated(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemBuilder:
                                (context, index) =>
                                    CustomCardNote(note: state.notes[index]),
                            separatorBuilder:
                                (context, index) => 12.verticalSpace,
                            itemCount: state.notes.length,
                          );
                        }
                        return SizedBox();
                      },
                    ),
                  ],
                ),
              ),
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) => const AddNoteDialog(),
                );
              },
              child: Icon(Icons.note_add_outlined),
            ),
          );
        },
      ),
    );
  }
}

class AddNoteDialog extends StatelessWidget {
  const AddNoteDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => NoteCubit(NoteRepoImpl()),
      child: BlocConsumer<NoteCubit, NoteState>(
        listener: (context, state) {
          if (state is NoteAddedSuccess) {
            Navigator.pop(context);
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(state.message)));
          } else if (state is NoteError) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(state.message)));
          }
        },
        builder: (context, state) {
          final cubit = context.read<NoteCubit>();

          return AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            title: const Text('Add Note'),
            content: SingleChildScrollView(
              child: Column(
                children: [
                  TextField(
                    controller: cubit.titleController,
                    decoration: const InputDecoration(
                      labelText: 'Title',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 16),
                  TextField(
                    controller: cubit.contentController,
                    decoration: const InputDecoration(
                      labelText: 'Content',
                      border: OutlineInputBorder(),
                    ),
                    maxLines: 4,
                  ),
                ],
              ),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Cancel'),
              ),
              ElevatedButton(
                onPressed:
                    state is AddNoteLoading ? null : () => cubit.addNote(),
                child:
                    state is AddNoteLoading
                        ? const SizedBox(
                          height: 16,
                          width: 16,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        )
                        : const Text('Save'),
              ),
            ],
          );
        },
      ),
    );
  }
}
