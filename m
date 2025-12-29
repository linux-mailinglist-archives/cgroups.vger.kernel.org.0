Return-Path: <cgroups+bounces-12801-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 34F9ACE69F0
	for <lists+cgroups@lfdr.de>; Mon, 29 Dec 2025 12:57:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6901E3014DA0
	for <lists+cgroups@lfdr.de>; Mon, 29 Dec 2025 11:57:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 329552D97AC;
	Mon, 29 Dec 2025 11:57:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="oluR3wP3"
X-Original-To: cgroups@vger.kernel.org
Received: from out-183.mta0.migadu.com (out-183.mta0.migadu.com [91.218.175.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41FCC2D9EE3
	for <cgroups@vger.kernel.org>; Mon, 29 Dec 2025 11:57:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767009430; cv=none; b=a+YBPkYHZtdmnRC0DE3DNUtZxVeFWJ11TI08lYcZCO16VfIKuB3nSRpkAvJ82tOHUgmuSFh5gt58wRRzrOdcMaWg1M7PlTeOYIgTUf/ZGvEwDZyc3LZSAD8ETG6n9b25UDe1idzeHO2R/mAYoY9l1q6y6cKsm6PBheOZHQES5hI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767009430; c=relaxed/simple;
	bh=pmRoNC71/hNG7M8ZGkLRrht9Cdm3GLFwzlM6IsEbM24=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lVlSkK0alCtpSDqqJtB8qzqSQlIcdMJ/o1DyGzWaOxGUoAXIlheICVVNiLHn9fSV8rR5hLNNpmMo3Rv1PtG2AVzxwNbyHruv4oEAPuMcOchrU+gA1HTVTFVzGumAxczKIL8RLASucq8XS9UlwPQiKlN3kaP48vGzjhhyqoXBk5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=oluR3wP3; arc=none smtp.client-ip=91.218.175.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Mon, 29 Dec 2025 19:56:42 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1767009413;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bB3emZmucVN1uPHpduAK6KhrmkIMJw57149J91Ece0c=;
	b=oluR3wP3aHDwiT/bP9WayJPD+hzp2XQ6wGg7CCwyfQD2cegoRosNsfJs59n7HJt+3F5NfK
	zlnshSAvfyYAHQHLkQLjj8wPHUYKzbPKJSi6ndlHGHNfsF+IQmcxCsRhywBtamWUYV7m4Z
	mgl3ma8uo4IuE0Gf/lUQlY0W6OuKlzA=
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
Subject: Re: [PATCH] slub: clarify object field layout comments
Message-ID: <k52hessiwmea5aozrs6vs7riecvoqkbhxyrtismbg5f6fl447e@p4w3ru3wvf4c>
References: <20251222110843.980347-1-harry.yoo@oracle.com>
 <20251222110843.980347-8-harry.yoo@oracle.com>
 <graryni6wadpi3ytfq7zimj2kbmm7dumxvhxtzmxndrv5s2y67@ju4cdnsmos6e>
 <aUq1x_BowqYpHZAQ@hyeyoo>
 <zex6wgdlxk5vgwm7ou657fdmi27xnxihdndlszfa2chghamfuz@grhtfqw7gm7o>
 <aUrCXYdziRWP9PfV@hyeyoo>
 <c6owr44jdncf7q5zqgq4wn4pm57ai4cd3upauwmwszopuddf5g@52mkqbe2m27j>
 <aUt_1uDe05diks7b@hyeyoo>
 <z7d52kjvlzxohbly42flhtebqc7knfvilierrjr4r5776rxhgy@lcqmkcpzklse>
 <aVIoyh9fXoxKTUSa@hyeyoo>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aVIoyh9fXoxKTUSa@hyeyoo>
X-Migadu-Flow: FLOW_OUT

On Mon, Dec 29, 2025 at 04:07:54PM +0900, Harry Yoo wrote:
> On Wed, Dec 24, 2025 at 08:51:14PM +0800, Hao Li wrote:
> > The comments above check_pad_bytes() document the field layout of a
> > single object. Rewrite them to improve clarity and precision.
> > 
> > Also update an outdated comment in calculate_sizes().
> > 
> > Suggested-by: Harry Yoo <harry.yoo@oracle.com>
> > Signed-off-by: Hao Li <hao.li@linux.dev>
> > ---
> > Hi Harry, this patch adds more detailed object layout documentation. Let
> > me know if you have any comments.
> 
> Hi Hao, thanks for improving it!
> It looks much clearer now.

Hi Harry,

Thanks for the review and the Acked-by!

> 
> few nits below.
> 
> > + * Object field layout:
> > + *
> > + * [Left redzone padding] (if SLAB_RED_ZONE)
> > + *   - Field size: s->red_left_pad
> > + *   - Filled with 0xbb (SLUB_RED_INACTIVE) for inactive objects and
> > + *     0xcc (SLUB_RED_ACTIVE) for objects in use when SLAB_RED_ZONE.
> 
> nit: although it becomes clear after reading the Notes: section,
> I would like to make it clear that object address starts here (after
> the left redzone) and the left redzone is right before each object.

Good point. I’ll make this explicit in v2.

> 
> > + * [Object bytes]
> > + *   - Field size: s->object_size
> > + *   - Object payload bytes.
> > + *   - If the freepointer may overlap the object, it is stored inside
> > + *     the object (typically near the middle).
> > + *   - Poisoning uses 0x6b (POISON_FREE) and the last byte is
> > + *     0xa5 (POISON_END) when __OBJECT_POISON is enabled.
> > + *
> > + * [Word-align padding] (right redzone when SLAB_RED_ZONE is set)
> > + *   - Field size: s->inuse - s->object_size
> > + *   - If redzoning is enabled and ALIGN(size, sizeof(void *)) adds no
> > + *     padding, explicitly extend by one word so the right redzone is
> > + *     non-empty.
> > + *   - Filled with 0xbb (SLUB_RED_INACTIVE) for inactive objects and
> > + *     0xcc (SLUB_RED_ACTIVE) for objects in use when SLAB_RED_ZONE.
> > + *
> > + * [Metadata starts at object + s->inuse]
> > + *   - A. freelist pointer (if freeptr_outside_object)
> > + *   - B. alloc tracking (SLAB_STORE_USER)
> > + *   - C. free tracking (SLAB_STORE_USER)
> > + *   - D. original request size (SLAB_KMALLOC && SLAB_STORE_USER)
> > + *   - E. KASAN metadata (if enabled)
> > + *
> > + * [Mandatory padding] (if CONFIG_SLUB_DEBUG && SLAB_RED_ZONE)
> > + *   - One mandatory debug word to guarantee a minimum poisoned gap
> > + *     between metadata and the next object, independent of alignment.
> > + *   - Filled with 0x5a (POISON_INUSE) when SLAB_POISON is set.
> >
> > + * [Final alignment padding]
> > + *   - Any bytes added by ALIGN(size, s->align) to reach s->size.
> > + *   - Filled with 0x5a (POISON_INUSE) when SLAB_POISON is set.
> > + *
> > + * Notes:
> > + * - Redzones are filled by init_object() with SLUB_RED_ACTIVE/INACTIVE.
> > + * - Object contents are poisoned with POISON_FREE/END when __OBJECT_POISON.
> > + * - The trailing padding is pre-filled with POISON_INUSE by
> > + *   setup_slab_debug() when SLAB_POISON is set, and is validated by
> > + *   check_pad_bytes().
> > + * - The first object pointer is slab_address(slab) +
> > + *   (s->red_left_pad if redzoning); subsequent objects are reached by
> > + *   adding s->size each time.
> > + *
> > + * If slabcaches are merged then the object_size and inuse boundaries are
> > + * mostly ignored. Therefore no slab options that rely on these boundaries
> >   * may be used with merged slabcaches.
> 
> For the last paragraph, perhaps it'll be clearer to say:
> 
>   "If a slab cache flag relies on specific metadata to exist at a fixed
>    offset, the flag must be included in SLAB_NEVER_MERGE to prevent
>    merging. Otherwise, the cache would misbehave as s->object_size and
>    s->inuse are adjusted during cache merging"

Agreed. I’ll reword that paragraph along your suggestion to emphasize
the fixed-offset metadata requirement.

> 
> Otherwise looks great to me, so please feel free to add:
> Acked-by: Harry Yoo <harry.yoo@oracle.com>

I'll include this Acked-by in v2. Thanks!

-- 
Thanks
Hao
> 
> -- 
> Cheers,
> Harry / Hyeonggon

