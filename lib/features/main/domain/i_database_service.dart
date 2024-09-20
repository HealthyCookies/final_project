abstract interface class IDatabaseService<T> {
  Future<void> insertData(List<T> data);

  Future<void> updateData(List<T> data);

  Future<void> deleteData(List<T> data);

  Future<List<T>> getData(int limit, int offset);
}
