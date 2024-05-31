import { Controller, Get, Post, Body, Param, Patch, Delete, UseGuards, Query } from '@nestjs/common';
import { CommentService } from './comment.service';
import { CreateCommentDto } from './dto/create-comment.dto';
import { UpdateCommentDto } from './dto/update-comment.dto';
import { Comment } from './schema/comment.schema';
import { RolesGuard } from 'src/auth/roles/role.guard';
import { AuthGuard } from '@nestjs/passport';
import { Roles } from 'src/auth/roles/role.decorator';
import { Role } from 'src/auth/roles/role.enum';
import { ObjectId } from 'mongoose';

@Controller('comments')
export class CommentController {
  constructor(private readonly commentService: CommentService) {}

  @Post()
  async create(@Body() createCommentDto: CreateCommentDto): Promise<Comment> {
    return this.commentService.create(createCommentDto);
  }

  @Get()
  async findAll(@Query('postId') postId?: string): Promise<Comment[]> {
    if (postId) {
      return this.commentService.findAllByPostId(postId);
    }
    return this.commentService.findAll();
  }

  // @Get(':id')
  // async findOne(@Param('id') id: string): Promise<Comment> {
  //   return this.commentService.findOne(id);
  // }

  @Patch(':id')
  @UseGuards(AuthGuard('jwt'), RolesGuard)
  @Roles(Role.Admin)
  async update(
    @Param('id') id: string,
    @Body() updateCommentDto: UpdateCommentDto,
  ): Promise<Comment> {
    return this.commentService.update(id, updateCommentDto);
  }

  @Delete(':id')
  @UseGuards(AuthGuard('jwt'), RolesGuard)
  @Roles(Role.Admin)
  async deleteItem(@Param('id') id: string): Promise<Comment> {
    return this.commentService.remove(id);
  }
}
