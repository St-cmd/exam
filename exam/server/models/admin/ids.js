'use strict';

import mongoose from 'mongoose'

const idsSchema = new mongoose.Schema({
	question_id: Number,
});

const Ids = mongoose.model('Ids', idsSchema);

Ids.findOne((err, data) => {
	if (!data) {
		const newIds = new Ids({
			question_id: 0
		});
		newIds.save();
	}
})
export default Ids