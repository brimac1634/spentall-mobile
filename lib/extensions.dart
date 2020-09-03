extension IsSameDay on DateTime {
  bool isSameDay(DateTime otherDate) {
    return this.year == otherDate.year &&
        this.month == otherDate.month &&
        this.day == otherDate.day;
  }
}
