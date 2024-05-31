import { Module } from '@nestjs/common';
import { MongooseModule } from '@nestjs/mongoose';
import { ItemsController } from './items.controller';
import { ItemsService } from './items.service';
import { ItemsSchema } from './schemas/items.schemas';

@Module({
  imports:[MongooseModule.forFeature([{name:'items',schema:ItemsSchema}])],
  controllers: [ItemsController],
  providers: [ItemsService]
})
export class ItemsModule {}
