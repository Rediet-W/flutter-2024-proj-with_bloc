import { Injectable, NotFoundException } from '@nestjs/common';
import { InjectModel } from '@nestjs/mongoose';
import mongoose from 'mongoose';
import { updateItemDto } from './dto/update-item.dto';
import { items } from './schemas/items.schemas';

@Injectable()
export class ItemsService {
  constructor(
    @InjectModel(items.name)
    private itemsModel:mongoose.Model<items>,
    ) {}

    async findAll(){
      const items = await this.itemsModel.find();
      return items;

    }

    async create(items:items):Promise<items>{
      const res = await this.itemsModel.create(items)
      return res

    }
    // ... (other imports and service setup)

    
    async update(id: string, updateData: updateItemDto): Promise<items> {
      const updatedItem = await this.itemsModel.findByIdAndUpdate(id, updateData, { new: true }).exec();

      if (!updatedItem) {
        throw new NotFoundException(`Item with ID "${id}" not found`);
      }

      return updatedItem;
    }

    async remove(id: string): Promise<any> {
      const result = await this.itemsModel.findByIdAndDelete(id).exec();
  
      if (!result) {
        throw new NotFoundException(`Item with ID "${id}" not found`);
      }
  
      return result;
    }

    
}

