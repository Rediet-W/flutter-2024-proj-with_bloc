import { Controller, Get, Param, Delete, Patch, Body, UseGuards } from '@nestjs/common';
import { UserService } from './user.service';
import { AuthGuard } from '@nestjs/passport';

@Controller('users')

export class UserController {
  constructor(private readonly userService: UserService) {}

  @Patch(':id/password')
  @UseGuards(AuthGuard('jwt'))
  async updatePassword(
    @Param('id') userId: string,
    @Body('newPassword') newPassword: string,
  ): Promise<void> {
    await this.userService.updatePassword(userId, newPassword);
  }

  @Get(':id')
  @UseGuards(AuthGuard('jwt'))
  async getUserInfo(@Param('id') userId: string): Promise<any> {
    return await this.userService.getUserInfo(userId);
  }

  @Delete(':id')
  @UseGuards(AuthGuard('jwt'))
  async deleteUser(@Param('id') userId: string): Promise<void> {
    await this.userService.deleteUser(userId);
  }
}
