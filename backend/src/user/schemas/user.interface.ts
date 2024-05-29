import mongoose, { Document, Schema } from 'mongoose';



// This interface extends Mongoose's Document to include your user fields
export interface UserDocument extends Document {
  fullname: string;
  email: string;
  password: string;

}

export const UserSchema = new Schema<UserDocument>({
  fullname: { type: String, unique: true, required: true },
  email: { type: String, required: true },
  password: { type: String, required: true },
});

export const UserModel = mongoose.model<UserDocument>('User', UserSchema);
