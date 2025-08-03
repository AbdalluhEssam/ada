import 'package:ada/core/theme/app_colors.dart';
import 'package:ada/core/widgets/custom_text_form_field.dart';
import 'package:ada/features/home_note_app/ui/cubit/note_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddNote extends StatelessWidget {
  const AddNote({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Note'),
        centerTitle: true,
        elevation: 0,
      ),
      body: BlocConsumer<NoteCubit, NoteState>(
        listener: (context, state) {
          if (state is NoteAddedSuccess) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text('Note Added Successfully!')));

            Navigator.pop(context);
          }
        },
        builder: (context, state) {
          final cubit = context.read<NoteCubit>();
          if (state is NoteLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Card(
              elevation: 6,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Form(
                  key: cubit.formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      CustomTextFormField(
                        hintText: 'Title',
                        controller: cubit.titleController,
                        hintStyle: TextStyle(
                          color: Colors.grey,
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter a title';
                          }
                          return null;
                        },
                        prefixIcon: Icon(Icons.title),
                      ),
                      const SizedBox(height: 20),
                      CustomTextFormField(
                        hintText: 'Content',
                        controller: cubit.contentController,
                        hintStyle: TextStyle(
                          color: Colors.grey,
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter a Content';
                          }
                          return null;
                        },
                        prefixIcon: Icon(Icons.notes),
                        maxLines: 6,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        heroTag: 'saveNote',
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        backgroundColor: AppColor.primaryColor,
        onPressed: () {
          context.read<NoteCubit>().addNote();
        },
        label: const Text('Save'),
        icon: const Icon(Icons.save),
      ),
    );
  }
}
