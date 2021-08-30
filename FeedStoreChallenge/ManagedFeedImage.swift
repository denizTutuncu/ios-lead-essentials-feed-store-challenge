//
//  ManagedFeedImage.swift
//  FeedStoreChallenge
//
//  Created by Deniz Tutuncu on 8/30/21.
//  Copyright © 2021 Essential Developer. All rights reserved.
//

import CoreData

@objc(ManagedFeedImage)
final class ManagedFeedImage: NSManagedObject {
	@NSManaged var id: UUID
	@NSManaged var imageDescription: String?
	@NSManaged var location: String?
	@NSManaged var url: URL
	@NSManaged var cache: ManagedCache?
}

extension ManagedFeedImage {
	var local: LocalFeedImage {
		return LocalFeedImage(id: id, description: imageDescription, location: location, url: url)
	}

	static func images(from localFeed: [LocalFeedImage], in context: NSManagedObjectContext) -> NSOrderedSet {
		NSOrderedSet(array: localFeed.map { local in
			let managed = ManagedFeedImage(context: context)
			managed.id = local.id
			managed.imageDescription = local.description
			managed.location = local.location
			managed.url = local.url
			return managed
		})
	}
}
