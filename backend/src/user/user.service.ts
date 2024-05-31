import { Injectable, NotFoundException } from '@nestjs/common';
import { user  } from '../auth/schemas/user.schema';
import { InjectModel } from '@nestjs/mongoose';
import { Model } from 'mongoose';


@Injectable()
export class UserService {
  constructor(
    @InjectModel(user.name)
    private userModel: Model<user>,
    
  ) {}

  // Method to update user password
  async updatePassword(userId: string, newPassword: string): Promise<void> {
    const user = await this.userModel.findById(userId);
    if (!user) {
      throw new NotFoundException('User not found');
    }
    user.password = newPassword;
    await user.save();
  }

  // Method to get all information about a user
  async getUserInfo(userId: string): Promise<user> {
    const user = await this.userModel.findById(userId);
    if (!user) {
      throw new NotFoundException('User not found');
    }
    return user;
  }

  // Method to delete a user
  async deleteUser(userId: string): Promise<void> {
    const result = await this.userModel.findByIdAndDelete(userId);
    if (!result) {
      throw new NotFoundException('User not found');
    }
  }
}
