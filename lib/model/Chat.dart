class Chat {
  final message,
      fromUser,
      toUser,
      createdAt,
      updatedAt,
      messageState,
      replyFrom,
      uuid;

  Chat({
    this.toUser,
    this.message,
    this.fromUser,
    this.createdAt,
    this.updatedAt,
    this.messageState,
    this.replyFrom,
    this.uuid,
  });
}
