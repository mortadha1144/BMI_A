import 'package:flutter/material.dart';
import 'package:udemy/shared/cubit/cubit.dart';

Widget defaultButton({
  double width = double.infinity,
  Color background = Colors.blue,
  bool isUpperCase = true,
  double radius = 10,
  required Function() onPressed,
  required String text,
}) =>
    Container(
      width: width,
      height: 40,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(radius),
        color: background,
      ),
      child: MaterialButton(
        onPressed: onPressed,
        child: Text(
          isUpperCase ? text.toUpperCase() : text,
          style: const TextStyle(color: Colors.white),
        ),
      ),
    );

Widget defaultFormField({
  required TextEditingController controller,
  required TextInputType type,
  void Function(String)? onSubmit,
  void Function(String)? onChange,
  void Function()? onTap,
  bool isPassword = false,
  required String? Function(String?)? validate,
  required String label,
  required IconData prefixIcon,
  IconData? suffixIcon,
  void Function()? suffixIconOnPressed,
  bool isClickable = true,
}) =>
    TextFormField(
      controller: controller,
      keyboardType: type,
      obscureText: isPassword,
      enabled: isClickable,
      onFieldSubmitted: onSubmit,
      onChanged: onChange,
      onTap: onTap,
      validator: validate,
      decoration: InputDecoration(
        labelText: label,
        border: const OutlineInputBorder(),
        prefixIcon: Icon(prefixIcon),
        suffixIcon: IconButton(
          icon: Icon(suffixIcon),
          onPressed: suffixIcon != null ? suffixIconOnPressed : null,
        ),
      ),
    );

Widget buildTaskItem(Map model, context) => Padding(
      padding: const EdgeInsets.all(20.0),
      child: Row(
        children: [
          CircleAvatar(
            radius: 40,
            child: Text('${model['time']}'),
          ),
          const SizedBox(
            width: 20,
          ),
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  '${model['title']}',
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  '${model['date']}',
                  style: const TextStyle(color: Colors.grey),
                ),
              ],
            ),
          ),
          const SizedBox(
            width: 20,
          ),
          IconButton(
            onPressed: () {
              AppCubit.get(context).updateData(
                status: 'done',
                id: model['id'],
              );
            },
            icon: const Icon(
              Icons.check_box,
              color: Colors.green,
            ),
          ),
          IconButton(
            onPressed: () {
              AppCubit.get(context).updateData(
                status: 'archived',
                id: model['id'],
              );
            },
            icon: const Icon(
              Icons.archive,
              color: Colors.black45,
            ),
          ),
        ],
      ),
    );

Widget buildArticleItem()=> Padding(
  padding: const EdgeInsets.all(20.0),
  child: Row(
    children: [
      Container(
        width: 120,
        height: 120,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(
            10,
          ),
          image: const DecorationImage(
              image: NetworkImage(
                  'https://img.youm7.com/large/201909281023402340.jpg'),
              fit: BoxFit.cover),
        ),
      ),
      const SizedBox(
        width: 20,
      ),
      Expanded(
        child: SizedBox(
          height: 120,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Expanded(
                child: Text(
                  'Title',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                  maxLines: 4,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Text(
                '2022-11-20T11:30:00Z',
                style: TextStyle(color: Colors.grey),
              ),
            ],
          ),
        ),
      )
    ],
  ),
);

Widget myDivider()=>Padding(
  padding: const EdgeInsetsDirectional.only(start: 20),
  child: Divider(
    thickness: 0.7,
    color: Colors.grey[400],
  ),
);
