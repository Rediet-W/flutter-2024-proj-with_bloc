import { Injectable, NotFoundException } from '@nestjs/common';
import { InjectModel } from '@nestjs/mongoose';
import { Model, ObjectId, UpdateQuery } from 'mongoose';
import { Comment } from './schema/comment.schema';
import { CreateCommentDto } from './dto/create-comment.dto';
import { UpdateCommentDto } from './dto/update-comment.dto';

@Injectable()
export class CommentService {
  constructor(
    @InjectModel(Comment.name) private readonly commentModel: Model<Comment>,
  ) {}

  async create(createCommentDto: CreateCommentDto): Promise<Comment> {
    const createdComment = new this.commentModel(createCommentDto);
    return createdComment.save();
  }

  async findAll(): Promise<Comment[]> {
    const comments = await this.commentModel.find().exec();
    return comments.map(comment => {
      return {
        ...comment.toJSON(),
        id: comment._id.toString(),
      };
    });
  }

  async findAllByPostId(postId: string): Promise<Comment[]> {
    console.log(postId  )
    return this.commentModel.find({ postId:postId }).exec();
  }

  async findOne(id: ObjectId): Promise<Comment> {
    const comment = await this.commentModel.findById(id).exec();
    if (!comment) {
      throw new NotFoundException(`Comment with ID "${id}" not found`);
    }
    return comment;
  }

  async update(id: string, updateCommentDto: UpdateCommentDto): Promise<Comment> {
    const result = await this.commentModel.findByIdAndUpdate(
      id,
      updateCommentDto as UpdateQuery<Comment>,
      { new: true }
    ).exec();

    if (!result) {
      throw new NotFoundException(`Comment with ID "${id}" not found`);
    }
    return result as Comment;
  }

  async remove(id: string): Promise<any> {
    const result = await this.commentModel.findByIdAndDelete(id).exec();

    if (!result) {
      throw new NotFoundException(`Comment with ID "${id}" not found`);
    }

    return result;
  }
}
