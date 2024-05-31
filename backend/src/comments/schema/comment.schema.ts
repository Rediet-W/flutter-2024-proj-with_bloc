import { Prop, Schema, SchemaFactory } from '@nestjs/mongoose';
import { Document, ObjectId } from 'mongoose';

@Schema({ timestamps: true })
export class Comment extends Document {
  @Prop({ required: true })
  content:string;
  @Prop({ required: true })
  userId: String;
  @Prop()
  postId: String;
}

export const CommentSchema = SchemaFactory.createForClass(Comment);
