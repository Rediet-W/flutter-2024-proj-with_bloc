import { Prop, Schema, SchemaFactory } from "@nestjs/mongoose";


@Schema({
  timestamps:true
})
export class items{

  @Prop()
  description:string;

  @Prop()
  category:string;

  @Prop({type:Buffer})
  picture:Buffer;
  @Prop()
  location:string;
  @Prop()
  time:string;
  
}

export const ItemsSchema = SchemaFactory.createForClass(items)