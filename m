Return-Path: <cgroups+bounces-12628-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 64F58CDB3FF
	for <lists+cgroups@lfdr.de>; Wed, 24 Dec 2025 04:23:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id ABB6530D8914
	for <lists+cgroups@lfdr.de>; Wed, 24 Dec 2025 03:19:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BD062D0C8F;
	Wed, 24 Dec 2025 03:19:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="gvXFAIgR"
X-Original-To: cgroups@vger.kernel.org
Received: from out-184.mta0.migadu.com (out-184.mta0.migadu.com [91.218.175.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1230230EF6F
	for <cgroups@vger.kernel.org>; Wed, 24 Dec 2025 03:19:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766546362; cv=none; b=MBcfScxL4Hd0fANGFnkSfSGBLdLykP0nZfisRb/b/rcgf8t6dhivbUsLesl52+jmKffxiqsxgNDrr5EGFp0RMowGLvgCZs+7o8tINO+AowpaMJ5qE4efpUgxrM/Vs8nq/KvHQsexhZP5UbaNU2A5yPZEp0itJ7VzZ11mH7jUqyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766546362; c=relaxed/simple;
	bh=a7cx7pOZ00gaHhbilJT7o2Us9frLr9jTqVgm9vYawJk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TeO6Kmt3qmd+W0GrBxxTlbxDTMHxLVez+MNyHGTEDbpi4+BlhJ5l5PQQ6w8s5RAP9Rb6b1415+o+8eaCjzIEvZeea9rK6G7BWcS2lZqq8e5zjdeiGE3UG90sBbAUh4nYi9W1i8XgTFshXse7tcajamWMbHvfpsMWZUf3S0Q2A6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=gvXFAIgR; arc=none smtp.client-ip=91.218.175.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Wed, 24 Dec 2025 11:18:56 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1766546351;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8oswkuqTYHUBzus0t0fqLYz06bL+cZstFaMSGw9VGWQ=;
	b=gvXFAIgRJN5XCpsXXDgESzfw6K7sQjtFNBY0ViOC6cMza5FexO6DA4TatMuwduoGECeldY
	gMwgwGWI+jqBq5jmqfD2nK/46pXPjW6wkz/iM346nkf9M/OxcJSoNCdkh1AK0GqdbsRBq9
	uwtNuJ3ZXv1iQ6rofxLmrnVXH7OYOKY=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Hao Li <hao.li@linux.dev>
To: Harry Yoo <harry.yoo@oracle.com>
Cc: akpm@linux-foundation.org, vbabka@suse.cz, andreyknvl@gmail.com, 
	cl@gentwo.org, dvyukov@google.com, glider@google.com, hannes@cmpxchg.org, 
	linux-mm@kvack.org, mhocko@kernel.org, muchun.song@linux.dev, rientjes@google.com, 
	roman.gushchin@linux.dev, ryabinin.a.a@gmail.com, shakeel.butt@linux.dev, 
	surenb@google.com, vincenzo.frascino@arm.com, yeoreum.yun@arm.com, tytso@mit.edu, 
	adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org, 
	cgroups@vger.kernel.org
Subject: Re: [PATCH V4 7/8] mm/slab: save memory by allocating slabobj_ext
 array from leftover
Message-ID: <c6owr44jdncf7q5zqgq4wn4pm57ai4cd3upauwmwszopuddf5g@52mkqbe2m27j>
References: <20251222110843.980347-1-harry.yoo@oracle.com>
 <20251222110843.980347-8-harry.yoo@oracle.com>
 <graryni6wadpi3ytfq7zimj2kbmm7dumxvhxtzmxndrv5s2y67@ju4cdnsmos6e>
 <aUq1x_BowqYpHZAQ@hyeyoo>
 <zex6wgdlxk5vgwm7ou657fdmi27xnxihdndlszfa2chghamfuz@grhtfqw7gm7o>
 <aUrCXYdziRWP9PfV@hyeyoo>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aUrCXYdziRWP9PfV@hyeyoo>
X-Migadu-Flow: FLOW_OUT

On Wed, Dec 24, 2025 at 01:25:01AM +0900, Harry Yoo wrote:
> On Wed, Dec 24, 2025 at 12:08:36AM +0800, Hao Li wrote:
> > On Wed, Dec 24, 2025 at 12:31:19AM +0900, Harry Yoo wrote:
> > > On Tue, Dec 23, 2025 at 11:08:32PM +0800, Hao Li wrote:
> > > > On Mon, Dec 22, 2025 at 08:08:42PM +0900, Harry Yoo wrote:
> > > > > The leftover space in a slab is always smaller than s->size, and
> > > > > kmem caches for large objects that are not power-of-two sizes tend to have
> > > > > a greater amount of leftover space per slab. In some cases, the leftover
> > > > > space is larger than the size of the slabobj_ext array for the slab.
> > > > > 
> > > > > An excellent example of such a cache is ext4_inode_cache. On my system,
> > > > > the object size is 1144, with a preferred order of 3, 28 objects per slab,
> > > > > and 736 bytes of leftover space per slab.
> > > > > 
> > > > > Since the size of the slabobj_ext array is only 224 bytes (w/o mem
> > > > > profiling) or 448 bytes (w/ mem profiling) per slab, the entire array
> > > > > fits within the leftover space.
> > > > > 
> > > > > Allocate the slabobj_exts array from this unused space instead of using
> > > > > kcalloc() when it is large enough. The array is allocated from unused
> > > > > space only when creating new slabs, and it doesn't try to utilize unused
> > > > > space if alloc_slab_obj_exts() is called after slab creation because
> > > > > implementing lazy allocation involves more expensive synchronization.
> > > > > 
> > > > > The implementation and evaluation of lazy allocation from unused space
> > > > > is left as future-work. As pointed by Vlastimil Babka [1], it could be
> > > > > beneficial when a slab cache without SLAB_ACCOUNT can be created, and
> > > > > some of the allocations from the cache use __GFP_ACCOUNT. For example,
> > > > > xarray does that.
> > > > > 
> > > > > To avoid unnecessary overhead when MEMCG (with SLAB_ACCOUNT) and
> > > > > MEM_ALLOC_PROFILING are not used for the cache, allocate the slabobj_ext
> > > > > array only when either of them is enabled.
> > > > > 
> > > > > [ MEMCG=y, MEM_ALLOC_PROFILING=n ]
> > > > > 
> > > > > Before patch (creating ~2.64M directories on ext4):
> > > > >   Slab:            4747880 kB
> > > > >   SReclaimable:    4169652 kB
> > > > >   SUnreclaim:       578228 kB
> > > > > 
> > > > > After patch (creating ~2.64M directories on ext4):
> > > > >   Slab:            4724020 kB
> > > > >   SReclaimable:    4169188 kB
> > > > >   SUnreclaim:       554832 kB (-22.84 MiB)
> > > > > 
> > > > > Enjoy the memory savings!
> > > > > 
> > > > > Link: https://lore.kernel.org/linux-mm/48029aab-20ea-4d90-bfd1-255592b2018e@suse.cz
> > > > > Signed-off-by: Harry Yoo <harry.yoo@oracle.com>
> > > > > ---
> > > > >  mm/slub.c | 156 ++++++++++++++++++++++++++++++++++++++++++++++++++++--
> > > > >  1 file changed, 151 insertions(+), 5 deletions(-)
> > > > > 
> > > > > diff --git a/mm/slub.c b/mm/slub.c
> > > > > index 39c381cc1b2c..3fc3d2ca42e7 100644
> > > > > --- a/mm/slub.c
> > > > > +++ b/mm/slub.c
> > > > > @@ -886,6 +886,99 @@ static inline unsigned long get_orig_size(struct kmem_cache *s, void *object)
> > > > >  	return *(unsigned long *)p;
> > > > >  }
> > > > >  
> > > > > +#ifdef CONFIG_SLAB_OBJ_EXT
> > > > > +
> > > > > +/*
> > > > > + * Check if memory cgroup or memory allocation profiling is enabled.
> > > > > + * If enabled, SLUB tries to reduce memory overhead of accounting
> > > > > + * slab objects. If neither is enabled when this function is called,
> > > > > + * the optimization is simply skipped to avoid affecting caches that do not
> > > > > + * need slabobj_ext metadata.
> > > > > + *
> > > > > + * However, this may disable optimization when memory cgroup or memory
> > > > > + * allocation profiling is used, but slabs are created too early
> > > > > + * even before those subsystems are initialized.
> > > > > + */
> > > > > +static inline bool need_slab_obj_exts(struct kmem_cache *s)
> > > > > +{
> > > > > +	if (memcg_kmem_online() && (s->flags & SLAB_ACCOUNT))
> > > > > +		return true;
> > > > > +
> > > > > +	if (mem_alloc_profiling_enabled())
> > > > > +		return true;
> > > > > +
> > > > > +	return false;
> > > > > +}
> > > > > +
> > > > > +static inline unsigned int obj_exts_size_in_slab(struct slab *slab)
> > > > > +{
> > > > > +	return sizeof(struct slabobj_ext) * slab->objects;
> > > > > +}
> > > > > +
> > > > > +static inline unsigned long obj_exts_offset_in_slab(struct kmem_cache *s,
> > > > > +						    struct slab *slab)
> > > > > +{
> > > > > +	unsigned long objext_offset;
> > > > > +
> > > > > +	objext_offset = s->red_left_pad + s->size * slab->objects;
> > > > 
> > > > Hi Harry,
> > > 
> > > Hi Hao, thanks for the review!
> > > Hope you're doing well.
> > 
> > Thanks Harry. Hope you are too!
> > 
> > > 
> > > > As s->size already includes s->red_left_pad
> > > 
> > > Great question. It's true that s->size includes s->red_left_pad,
> > > but we have also a redzone right before the first object:
> > > 
> > >   [ redzone ] [ obj 1 | redzone ] [ obj 2| redzone ] [ ... ]
> > > 
> > > So we have (slab->objects + 1) red zones and so
> > 
> > I have a follow-up question regarding the redzones. Unless I'm missing
> > some detail, it seems the left redzone should apply to each object as
> > well. If so, I would expect the memory layout to be:
> > 
> > [left redzone | obj 1 | right redzone], [left redzone | obj 2 | right redzone], [ ... ]
> > 
> > In `calculate_sizes()`, I see:
> > 
> > if ((flags & SLAB_RED_ZONE) && size == s->object_size)
> >     size += sizeof(void *);
> 
> Yes, this is the right redzone,
> 
> > ...
> > ...
> > if (flags & SLAB_RED_ZONE) {
> >     size += s->red_left_pad;
> > }
> 
> This is the left red zone.
> Both of them are included in the size...
> 
> Oh god, I was confused, thanks for the correction!

Glad it helped!

> 
> > Could you please confirm whether my understanding is correct, or point
> > out what I'm missing?
> 
> I think your understanding is correct.
> 
> Hmm, perhaps we should update the "Object layout:" comment above
> check_pad_bytes() to avoid future confusion?

Yes, exactly. That’s a good idea. Also, I feel the layout description in
the check_pad_bytes() comment isn’t very intuitive and can be a bit hard
to follow. I think it might be clearer if we explicitly list out each
field. What do you think about that?

> 
> > > > do we still need > s->red_left_pad here?
> > > 
> > > I think this is still needed.
> > > 
> > > -- 
> > > Cheers,
> > > Harry / Hyeonggon
> 
> -- 
> Cheers,
> Harry / Hyeonggon

