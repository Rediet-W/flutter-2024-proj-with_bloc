import { ObjectId } from "mongoose";

export class UpdateCommentDto {
  readonly content: string;
  readonly postId: ObjectId;
  readonly userId:ObjectId;
  }
  