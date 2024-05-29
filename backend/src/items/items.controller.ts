import { items } from './schemas/items.schemas';

import { Body, Controller, Delete, Get, Param, Post, Put, UploadedFile, UseInterceptors } from '@nestjs/common';
import { FileInterceptor } from '@nestjs/platform-express/multer/interceptors/file.interceptor';
import { Roles } from '../auth/roles/role.decorator'; // Adjust the path as needed
import { updateItemDto } from './dto/update-item.dto'; // Assume you have a DTO for updating items
import { ItemsService } from './items.service';

@Controller('items')
export class ItemsController {
  constructor(private itemsService: ItemsService) {}

  @Get()
  async getAllitems(): Promise<items[]> {
    return this.itemsService.findAll();
  }

  @Post()
  @UseInterceptors(FileInterceptor('picture'))
  async createItem(
    @Body('description') description: string,
    @UploadedFile() file: Express.Multer.File,
  ) {
    // Here, 'file.buffer' contains the binary data of the uploaded file
    // and 'description' contains the text from the description field

    const createdItem = await this.itemsService.create({
      description, picture: file.buffer,
      category: ''
    });
    return createdItem;
  }

  @Put(':id') // Route for updating an item
  @Roles('admin')
  async updateItem(
    @Param('id') id: string,
    @Body() updateData: updateItemDto
  ): Promise<items> {
    return this.itemsService.update(id, updateData);
  }

  @Delete(':id') // Route for deleting an item
  @Roles('admin')
  async deleteItem(
    @Param('id') id: string
  ): Promise<any> {
    return this.itemsService.remove(id);
  }
}
