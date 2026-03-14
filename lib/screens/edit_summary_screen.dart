import 'package:after_call/models/deadline.dart';
import 'package:after_call/sevices/call_record_service.dart';
import 'package:after_call/theme.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

class EditSummaryScreen extends StatefulWidget {
  final String recordId;

  const EditSummaryScreen({super.key, required this.recordId});

  @override
  State<EditSummaryScreen> createState() => _EditSummaryScreenState();
}

class _EditSummaryScreenState extends State<EditSummaryScreen> {
  late TextEditingController _summaryController;
  late List<TextEditingController> _actionControllers;
  late List<Deadline> _deadlines;
  bool _isSaving = false;

  @override
  void initState() {
    super.initState();
    final recordService = context.read<CallRecordService>();
    final record = recordService.getRecordById(widget.recordId);

    if (record != null) {
      _summaryController = TextEditingController(text: record.summary);
      _actionControllers =
          record.actionItems
              .map((item) => TextEditingController(text: item))
              .toList();
      _deadlines = List.from(record.deadlines);
    } else {
      _summaryController = TextEditingController();
      _actionControllers = [];
      _deadlines = [];
    }
  }

  @override
  void dispose() {
    _summaryController.dispose();
    for (var controller in _actionControllers) {
      controller.dispose();
    }
    super.dispose();
  }

  void _addActionItem() {
    setState(() {
      _actionControllers.add(TextEditingController());
    });
  }

  void _removeActionItem(int index) {
    if (_actionControllers[index].text.isNotEmpty) {
      _showDeleteDialog(
        'Delete Action Item',
        'Are you sure you want to delete this action item?',
        () {
          setState(() {
            _actionControllers[index].dispose();
            _actionControllers.removeAt(index);
          });
        },
      );
    } else {
      setState(() {
        _actionControllers[index].dispose();
        _actionControllers.removeAt(index);
      });
    }
  }

  void _showDeleteDialog(String title, String message, VoidCallback onConfirm) {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: Text(title),
            content: Text(message),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(AppRadius.lg),
            ),
            actions: [
              TextButton(
                onPressed: () => context.pop(),
                child: Text(
                  'Cancel',
                  style: context.textStyles.bodyMedium?.withColor(
                    context.colors.onSurfaceVariant,
                  ),
                ),
              ),
              TextButton(
                onPressed: () {
                  context.pop();
                  onConfirm();
                },
                child: Text(
                  'Delete',
                  style: context.textStyles.bodyMedium?.semiBold.withColor(
                    context.colors.error,
                  ),
                ),
              ),
            ],
          ),
    );
  }

  Future<void> _addDeadline() async {
    final result = await showModalBottomSheet<Deadline?>(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(AppRadius.xl)),
      ),
      builder: (context) => _AddDeadlineBottomSheet(),
    );

    if (result != null) {
      setState(() {
        _deadlines.add(result);
      });
    }
  }

  void _removeDeadline(int index) {
    _showDeleteDialog(
      'Delete Deadline',
      'Are you sure you want to delete this deadline?',
      () {
        setState(() => _deadlines.removeAt(index));
      },
    );
  }

  Future<void> _save() async {
    if (_isSaving) return;

    setState(() => _isSaving = true);

    final recordService = context.read<CallRecordService>();
    final record = recordService.getRecordById(widget.recordId);

    if (record != null) {
      final updatedRecord = record.copyWith(
        summary: _summaryController.text,
        actionItems:
            _actionControllers
                .map((c) => c.text)
                .where((text) => text.isNotEmpty)
                .toList(),
        deadlines: _deadlines,
        updatedAt: DateTime.now(),
      );

      await recordService.updateRecord(updatedRecord);
      if (mounted) {
        setState(() => _isSaving = false);
        context.pop();
      }
    } else {
      setState(() => _isSaving = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.colors.surfaceDim,
      appBar: AppBar(
        backgroundColor: context.colors.surface, // Uses theme surface color
        foregroundColor: context.colors.onSurface, // Uses theme text/icon color
        elevation: 0,
        scrolledUnderElevation: 0,
        surfaceTintColor: Colors.transparent,
        leading: IconButton(
          onPressed: () => context.pop(),
          icon: Icon(
            Icons.arrow_back_rounded,
            color: context.colors.onSurface, // Theme icon color
          ),
        ),
        title: Text(
          'Edit Summary',
          style: context.textStyles.titleLarge?.semiBold.copyWith(
            color: context.colors.onSurface, // Theme text color
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: AppSpacing.sm),
            child: ElevatedButton(
              onPressed: _save,
              style: ElevatedButton.styleFrom(
                backgroundColor: context.colors.primary, // Theme primary color
                foregroundColor:
                    context.colors.onPrimary, // Theme onPrimary color
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(AppRadius.md),
                ),
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.lg,
                  vertical: AppSpacing.sm,
                ),
              ),
              child:
                  _isSaving
                      ? SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color:
                              context.colors.onPrimary, // Theme spinner color
                        ),
                      )
                      : Text(
                        'Save',
                        style: context.textStyles.labelLarge?.semiBold.copyWith(
                          color:
                              context
                                  .colors
                                  .onPrimary, // Theme button text color
                        ),
                      ),
            ),
          ),
        ],
      ),

      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.xl,
            vertical: AppSpacing.lg,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Summary Section
              Card(
                margin: EdgeInsets.zero,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(AppRadius.lg),
                ),
                color: context.colors.surface,
                child: Padding(
                  padding: const EdgeInsets.all(AppSpacing.lg),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.note_outlined,
                            color: context.colors.primary,
                            size: 20,
                          ),
                          const SizedBox(width: AppSpacing.sm),
                          Text(
                            'Summary',
                            style: context.textStyles.titleMedium?.semiBold,
                          ),
                        ],
                      ),
                      const SizedBox(height: AppSpacing.md),
                      TextField(
                        controller: _summaryController,
                        maxLines: 5,
                        minLines: 3,
                        style: context.textStyles.bodyLarge,
                        decoration: InputDecoration(
                          hintText: 'Enter call summary...',
                          hintStyle: context.textStyles.bodyMedium?.withColor(
                            context.colors.onSurfaceVariant.withOpacity(0.6),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(AppRadius.md),
                            borderSide: BorderSide(
                              color: context.colors.outline.withOpacity(0.3),
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(AppRadius.md),
                            borderSide: BorderSide(
                              color: context.colors.outline.withOpacity(0.3),
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(AppRadius.md),
                            borderSide: BorderSide(
                              color: context.colors.primary,
                              width: 2,
                            ),
                          ),
                          filled: true,
                          fillColor: context.colors.surfaceContainerLowest,
                          contentPadding: const EdgeInsets.all(AppSpacing.md),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: AppSpacing.xl),

              // Action Items Section
              Card(
                margin: EdgeInsets.zero,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(AppRadius.lg),
                ),
                color: context.colors.surface,
                child: Padding(
                  padding: const EdgeInsets.all(AppSpacing.lg),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Icon(
                                Icons.checklist_outlined,
                                color: context.colors.primary,
                                size: 20,
                              ),
                              const SizedBox(width: AppSpacing.sm),
                              Text(
                                'Action Items',
                                style: context.textStyles.titleMedium?.semiBold,
                              ),
                            ],
                          ),
                          IconButton(
                            onPressed: _addActionItem,
                            icon: Icon(
                              Icons.add_circle_rounded,
                              color: context.colors.primary,
                              size: 28,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: AppSpacing.md),
                      if (_actionControllers.isEmpty)
                        Container(
                          padding: const EdgeInsets.all(AppSpacing.lg),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(AppRadius.md),
                            color: context.colors.surfaceContainer,
                          ),
                          child: Row(
                            children: [
                              Icon(
                                Icons.info_outline_rounded,
                                color: context.colors.onSurfaceVariant,
                                size: 18,
                              ),
                              const SizedBox(width: AppSpacing.sm),
                              Expanded(
                                child: Text(
                                  'No action items yet. Add tasks or follow-ups from the call.',
                                  style: context.textStyles.bodySmall
                                      ?.withColor(
                                        context.colors.onSurfaceVariant,
                                      ),
                                ),
                              ),
                            ],
                          ),
                        )
                      else
                        ..._actionControllers.asMap().entries.map((entry) {
                          final index = entry.key;
                          final controller = entry.value;
                          return Container(
                            margin: const EdgeInsets.only(
                              bottom: AppSpacing.md,
                            ),
                            decoration: BoxDecoration(
                              color: context.colors.surfaceContainerLow,
                              borderRadius: BorderRadius.circular(AppRadius.md),
                              border: Border.all(
                                color: context.colors.outline.withOpacity(0.1),
                              ),
                            ),
                            child: Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(
                                    left: AppSpacing.md,
                                  ),
                                  child: Container(
                                    width: 20,
                                    height: 20,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                        color: context.colors.onSurfaceVariant
                                            .withOpacity(0.3),
                                      ),
                                    ),
                                    child: Center(
                                      child: Text(
                                        '${index + 1}',
                                        style:
                                            context
                                                .textStyles
                                                .labelSmall
                                                ?.medium,
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(width: AppSpacing.md),
                                Expanded(
                                  child: TextField(
                                    controller: controller,
                                    style: context.textStyles.bodyMedium,
                                    decoration: InputDecoration(
                                      hintText: 'Enter action item...',
                                      hintStyle: context.textStyles.bodyMedium
                                          ?.withColor(
                                            context.colors.onSurfaceVariant
                                                .withOpacity(0.6),
                                          ),
                                      border: InputBorder.none,
                                      contentPadding:
                                          const EdgeInsets.symmetric(
                                            vertical: AppSpacing.md,
                                          ),
                                    ),
                                  ),
                                ),
                                IconButton(
                                  onPressed: () => _removeActionItem(index),
                                  icon: Icon(
                                    Icons.remove_circle_outline,
                                    color: context.colors.error.withOpacity(
                                      0.7,
                                    ),
                                    size: 22,
                                  ),
                                ),
                              ],
                            ),
                          );
                        }),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: AppSpacing.xl),

              // Deadlines Section
              Card(
                margin: EdgeInsets.zero,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(AppRadius.lg),
                ),
                color: context.colors.surface,
                child: Padding(
                  padding: const EdgeInsets.all(AppSpacing.lg),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Icon(
                                Icons.calendar_today_outlined,
                                color: context.colors.primary,
                                size: 20,
                              ),
                              const SizedBox(width: AppSpacing.sm),
                              Text(
                                'Deadlines',
                                style: context.textStyles.titleMedium?.semiBold,
                              ),
                            ],
                          ),
                          IconButton(
                            onPressed: _addDeadline,
                            icon: Icon(
                              Icons.add_circle_rounded,
                              color: context.colors.primary,
                              size: 28,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: AppSpacing.md),
                      if (_deadlines.isEmpty)
                        Container(
                          padding: const EdgeInsets.all(AppSpacing.lg),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(AppRadius.md),
                            color: context.colors.surfaceContainer,
                          ),
                          child: Row(
                            children: [
                              Icon(
                                Icons.info_outline_rounded,
                                color: context.colors.onSurfaceVariant,
                                size: 18,
                              ),
                              const SizedBox(width: AppSpacing.sm),
                              Expanded(
                                child: Text(
                                  'No deadlines set. Add important dates or follow-up deadlines.',
                                  style: context.textStyles.bodySmall
                                      ?.withColor(
                                        context.colors.onSurfaceVariant,
                                      ),
                                ),
                              ),
                            ],
                          ),
                        )
                      else
                        ..._deadlines.asMap().entries.map((entry) {
                          final index = entry.key;
                          final deadline = entry.value;
                          final isOverdue = deadline.dueDate.isBefore(
                            DateTime.now(),
                          );
                          final isToday =
                              deadline.dueDate.day == DateTime.now().day &&
                              deadline.dueDate.month == DateTime.now().month &&
                              deadline.dueDate.year == DateTime.now().year;

                          return Container(
                            margin: const EdgeInsets.only(
                              bottom: AppSpacing.md,
                            ),
                            decoration: BoxDecoration(
                              color:
                                  isOverdue
                                      ? context.colors.errorContainer
                                      : isToday
                                      ? context.colors.primaryContainer
                                      : context.colors.surfaceContainer,
                              borderRadius: BorderRadius.circular(AppRadius.md),
                              border: Border.all(
                                color:
                                    isOverdue
                                        ? context.colors.error.withOpacity(0.2)
                                        : isToday
                                        ? context.colors.primary.withOpacity(
                                          0.2,
                                        )
                                        : context.colors.outline.withOpacity(
                                          0.1,
                                        ),
                              ),
                            ),
                            child: ListTile(
                              leading: Container(
                                width: 40,
                                height: 40,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color:
                                      isOverdue
                                          ? context.colors.error
                                          : isToday
                                          ? context.colors.primary
                                          : context.colors.primary.withOpacity(
                                            0.1,
                                          ),
                                ),
                                child: Center(
                                  child: Icon(
                                    isOverdue
                                        ? Icons.warning_amber_rounded
                                        : isToday
                                        ? Icons.today_rounded
                                        : Icons.calendar_month_rounded,
                                    color:
                                        isOverdue || isToday
                                            ? Colors.white
                                            : context.colors.primary,
                                    size: 20,
                                  ),
                                ),
                              ),
                              title: Text(
                                deadline.description,
                                style: context.textStyles.bodyMedium?.medium,
                                overflow: TextOverflow.ellipsis, // Add this
                                maxLines: 1, // Limit to 1 line
                              ),
                              subtitle: Text(
                                DateFormat(
                                  'MMM d, yyyy • h:mm a',
                                ).format(deadline.dueDate),
                                style: context.textStyles.labelSmall?.withColor(
                                  isOverdue
                                      ? context.colors.error
                                      : isToday
                                      ? context.colors.primary
                                      : context.colors.onSurfaceVariant,
                                ),
                                overflow: TextOverflow.ellipsis, // Add this
                                maxLines: 1, // Limit to 1 line
                              ),
                              trailing: SizedBox(
                                width: 40, // Fixed width
                                child: IconButton(
                                  onPressed: () => _removeDeadline(index),
                                  icon: Icon(
                                    Icons.delete_outline,
                                    color: context.colors.error.withOpacity(
                                      0.7,
                                    ),
                                    size: 20,
                                  ),
                                  padding: EdgeInsets.zero, // Remove padding
                                ),
                              ),
                              contentPadding: const EdgeInsets.symmetric(
                                horizontal: AppSpacing.sm,
                                vertical: AppSpacing.xs,
                              ),
                              minLeadingWidth: 40, // Set minimum leading width
                            ),
                          );
                        }),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: AppSpacing.xxxl),
            ],
          ),
        ),
      ),
    );
  }
}

// Separate widget for the bottom sheet to manage its own state
class _AddDeadlineBottomSheet extends StatefulWidget {
  @override
  State<_AddDeadlineBottomSheet> createState() =>
      _AddDeadlineBottomSheetState();
}

class _AddDeadlineBottomSheetState extends State<_AddDeadlineBottomSheet> {
  final TextEditingController _descController = TextEditingController();
  late DateTime _selectedDate;
  late TimeOfDay _selectedTime;
  bool _showError = false; // Track validation error

  @override
  void initState() {
    super.initState();
    _selectedDate = DateTime.now().add(const Duration(days: 7));
    _selectedTime = TimeOfDay.now();
  }

  @override
  void dispose() {
    _descController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.only(
          top: AppSpacing.lg,
          left: AppSpacing.xl,
          right: AppSpacing.xl,
          bottom: MediaQuery.of(context).viewInsets.bottom + AppSpacing.xl,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Add Deadline',
                  style: context.textStyles.titleLarge?.semiBold,
                ),
                IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: Icon(
                    Icons.close,
                    color: context.colors.onSurfaceVariant,
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.lg),
            TextField(
              controller: _descController,
              decoration: InputDecoration(
                labelText: 'Description',
                labelStyle: context.textStyles.bodyMedium,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(AppRadius.md),
                  borderSide: BorderSide(
                    color:
                        _showError
                            ? context.colors.error.withOpacity(0.8)
                            : context.colors.outline.withOpacity(0.3),
                    width: _showError ? 2 : 1,
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(AppRadius.md),
                  borderSide: BorderSide(
                    color:
                        _showError
                            ? context.colors.error.withOpacity(0.8)
                            : context.colors.outline.withOpacity(0.3),
                    width: _showError ? 2 : 1,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(AppRadius.md),
                  borderSide: BorderSide(
                    color:
                        _showError
                            ? context
                                .colors
                                .error // Red border when error
                            : context.colors.primary, // Normal border
                    width: 2,
                  ),
                ),
                errorText: _showError ? 'Description is required' : null,
                errorStyle: context.textStyles.labelSmall?.withColor(
                  context.colors.error,
                ),
                contentPadding: const EdgeInsets.all(AppSpacing.md),
                hintText: 'Enter deadline description...',
                hintStyle: context.textStyles.bodyMedium?.withColor(
                  context.colors.onSurfaceVariant.withOpacity(0.6),
                ),
              ),
              style: context.textStyles.bodyLarge,
              autofocus: true,
              onChanged: (value) {
                // Clear error when user starts typing
                if (_showError && value.trim().isNotEmpty) {
                  setState(() {
                    _showError = false;
                  });
                }
              },
            ),
            const SizedBox(height: AppSpacing.lg),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(AppRadius.md),
                border: Border.all(
                  color: context.colors.outline.withOpacity(0.3),
                ),
              ),
              child: Column(
                children: [
                  ListTile(
                    leading: Icon(
                      Icons.calendar_today_outlined,
                      color: context.colors.primary,
                    ),
                    title: Text(
                      'Due Date',
                      style: context.textStyles.bodyMedium?.medium,
                    ),
                    subtitle: Text(
                      DateFormat('EEEE, MMMM d, yyyy').format(_selectedDate),
                      style: context.textStyles.bodySmall?.withColor(
                        context.colors.onSurfaceVariant,
                      ),
                    ),
                    trailing: Icon(
                      Icons.chevron_right,
                      color: context.colors.onSurfaceVariant,
                    ),
                    onTap: () async {
                      final date = await showDatePicker(
                        context: context,
                        initialDate: _selectedDate,
                        firstDate: DateTime.now(),
                        lastDate: DateTime.now().add(const Duration(days: 365)),
                        builder:
                            (context, child) => Theme(
                              data: Theme.of(context).copyWith(
                                dialogTheme: DialogThemeData(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(
                                      AppRadius.lg,
                                    ),
                                  ),
                                ),
                              ),
                              child: child!,
                            ),
                      );
                      if (date != null) {
                        setState(() => _selectedDate = date);
                      }
                    },
                  ),
                  const Divider(height: 1, indent: 72),
                  ListTile(
                    leading: Icon(
                      Icons.access_time_outlined,
                      color: context.colors.primary,
                    ),
                    title: Text(
                      'Time',
                      style: context.textStyles.bodyMedium?.medium,
                    ),
                    subtitle: Text(
                      _selectedTime.format(context),
                      style: context.textStyles.bodySmall?.withColor(
                        context.colors.onSurfaceVariant,
                      ),
                    ),
                    trailing: Icon(
                      Icons.chevron_right,
                      color: context.colors.onSurfaceVariant,
                    ),
                    onTap: () async {
                      final time = await showTimePicker(
                        context: context,
                        initialTime: _selectedTime,
                        builder:
                            (context, child) => Theme(
                              data: Theme.of(context).copyWith(
                                dialogTheme: DialogThemeData(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(
                                      AppRadius.lg,
                                    ),
                                  ),
                                ),
                              ),
                              child: child!,
                            ),
                      );
                      if (time != null) {
                        setState(() => _selectedTime = time);
                      }
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(height: AppSpacing.xl),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () => Navigator.pop(context),
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                        vertical: AppSpacing.lg,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(AppRadius.lg),
                      ),
                      side: BorderSide(
                        color: context.colors.outline.withOpacity(0.3),
                      ),
                    ),
                    child: Text(
                      'Cancel',
                      style: context.textStyles.bodyMedium?.medium.withColor(
                        context.colors.onSurfaceVariant,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: AppSpacing.md),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      if (_descController.text.trim().isEmpty) {
                        // Show error on text field
                        setState(() {
                          _showError = true;
                        });
                      } else {
                        final deadlineDate = DateTime(
                          _selectedDate.year,
                          _selectedDate.month,
                          _selectedDate.day,
                          _selectedTime.hour,
                          _selectedTime.minute,
                        );
                        Navigator.pop(
                          context,
                          Deadline(
                            description: _descController.text.trim(),
                            dueDate: deadlineDate,
                          ),
                        );
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                        vertical: AppSpacing.lg,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(AppRadius.lg),
                      ),
                      backgroundColor: context.colors.primary,
                    ),
                    child: Text(
                      'Add Deadline',
                      style: context.textStyles.bodyMedium?.semiBold.withColor(
                        context.colors.onPrimary,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
