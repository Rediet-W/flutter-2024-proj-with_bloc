import { ObjectId } from "mongoose";

export class CreateCommentDto {
    readonly content: string;
    readonly postId: ObjectId;
    readonly userId: ObjectId;
  }
  