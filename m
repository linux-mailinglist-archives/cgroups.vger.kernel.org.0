Return-Path: <cgroups+bounces-12612-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D1FBCD9E70
	for <lists+cgroups@lfdr.de>; Tue, 23 Dec 2025 17:09:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4F5B3301AD08
	for <lists+cgroups@lfdr.de>; Tue, 23 Dec 2025 16:09:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2AD72D060B;
	Tue, 23 Dec 2025 16:09:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="cPqc7w7/"
X-Original-To: cgroups@vger.kernel.org
Received: from out-188.mta1.migadu.com (out-188.mta1.migadu.com [95.215.58.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CB152C11FE
	for <cgroups@vger.kernel.org>; Tue, 23 Dec 2025 16:09:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766506165; cv=none; b=W6DbNUU2v3zJ9bsifvRrYjGL0I3FLwbudw1VheUBXr6N5NLQxMb63gJgj0RKgo2QUyRC2uBRFdyukR92xlsWVCuVfe9Xo86EkunKvu9mxGZZ0zKqeYcE5rWhBUNysYDfiYRjVklWQQt4euH+vKiFttPboua3X38gkfsuyGumGE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766506165; c=relaxed/simple;
	bh=+mkM12VOSqYq3Sm3SYBV9r0WBa1ytL5YLvM+fQAw0vc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nJfbvXthylvDj0c01dTLykR13/PL2rH+1kZtfl9rETOc0LSaS6po7QGClBFxu8qh3hZuRtJN82vsFHHVXBPnP9HO1ptSLOL8VaCNkEnP4wsoJWqDkvjMUodLppTm/MrxSXLsGzB62Y6KoIksXPNSndEZpuas2TmsHKXJL2dV8tQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=cPqc7w7/; arc=none smtp.client-ip=95.215.58.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Wed, 24 Dec 2025 00:08:36 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1766506150;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=XRHlLJkSrDB1D+zQb/dTsxZCxO2afpT1zq6PqLAXbQI=;
	b=cPqc7w7/X07bIpzdwHmn07rHMzYNpXBSdG1IgEJ46i2zRsqyHBXmjfxhEd5baz5OXordbo
	Bn+9LNtFqXM+ET5Z7M4bSQqrmaBtluoU/X3UhPwT/GaHbeo4OPGs2NdHWf+YSNJolJXl4X
	jawKc5iy3spTfUKyWXJ+AyPq+6hOTcU=
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
Message-ID: <zex6wgdlxk5vgwm7ou657fdmi27xnxihdndlszfa2chghamfuz@grhtfqw7gm7o>
References: <20251222110843.980347-1-harry.yoo@oracle.com>
 <20251222110843.980347-8-harry.yoo@oracle.com>
 <graryni6wadpi3ytfq7zimj2kbmm7dumxvhxtzmxndrv5s2y67@ju4cdnsmos6e>
 <aUq1x_BowqYpHZAQ@hyeyoo>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aUq1x_BowqYpHZAQ@hyeyoo>
X-Migadu-Flow: FLOW_OUT

On Wed, Dec 24, 2025 at 12:31:19AM +0900, Harry Yoo wrote:
> On Tue, Dec 23, 2025 at 11:08:32PM +0800, Hao Li wrote:
> > On Mon, Dec 22, 2025 at 08:08:42PM +0900, Harry Yoo wrote:
> > > The leftover space in a slab is always smaller than s->size, and
> > > kmem caches for large objects that are not power-of-two sizes tend to have
> > > a greater amount of leftover space per slab. In some cases, the leftover
> > > space is larger than the size of the slabobj_ext array for the slab.
> > > 
> > > An excellent example of such a cache is ext4_inode_cache. On my system,
> > > the object size is 1144, with a preferred order of 3, 28 objects per slab,
> > > and 736 bytes of leftover space per slab.
> > > 
> > > Since the size of the slabobj_ext array is only 224 bytes (w/o mem
> > > profiling) or 448 bytes (w/ mem profiling) per slab, the entire array
> > > fits within the leftover space.
> > > 
> > > Allocate the slabobj_exts array from this unused space instead of using
> > > kcalloc() when it is large enough. The array is allocated from unused
> > > space only when creating new slabs, and it doesn't try to utilize unused
> > > space if alloc_slab_obj_exts() is called after slab creation because
> > > implementing lazy allocation involves more expensive synchronization.
> > > 
> > > The implementation and evaluation of lazy allocation from unused space
> > > is left as future-work. As pointed by Vlastimil Babka [1], it could be
> > > beneficial when a slab cache without SLAB_ACCOUNT can be created, and
> > > some of the allocations from the cache use __GFP_ACCOUNT. For example,
> > > xarray does that.
> > > 
> > > To avoid unnecessary overhead when MEMCG (with SLAB_ACCOUNT) and
> > > MEM_ALLOC_PROFILING are not used for the cache, allocate the slabobj_ext
> > > array only when either of them is enabled.
> > > 
> > > [ MEMCG=y, MEM_ALLOC_PROFILING=n ]
> > > 
> > > Before patch (creating ~2.64M directories on ext4):
> > >   Slab:            4747880 kB
> > >   SReclaimable:    4169652 kB
> > >   SUnreclaim:       578228 kB
> > > 
> > > After patch (creating ~2.64M directories on ext4):
> > >   Slab:            4724020 kB
> > >   SReclaimable:    4169188 kB
> > >   SUnreclaim:       554832 kB (-22.84 MiB)
> > > 
> > > Enjoy the memory savings!
> > > 
> > > Link: https://lore.kernel.org/linux-mm/48029aab-20ea-4d90-bfd1-255592b2018e@suse.cz
> > > Signed-off-by: Harry Yoo <harry.yoo@oracle.com>
> > > ---
> > >  mm/slub.c | 156 ++++++++++++++++++++++++++++++++++++++++++++++++++++--
> > >  1 file changed, 151 insertions(+), 5 deletions(-)
> > > 
> > > diff --git a/mm/slub.c b/mm/slub.c
> > > index 39c381cc1b2c..3fc3d2ca42e7 100644
> > > --- a/mm/slub.c
> > > +++ b/mm/slub.c
> > > @@ -886,6 +886,99 @@ static inline unsigned long get_orig_size(struct kmem_cache *s, void *object)
> > >  	return *(unsigned long *)p;
> > >  }
> > >  
> > > +#ifdef CONFIG_SLAB_OBJ_EXT
> > > +
> > > +/*
> > > + * Check if memory cgroup or memory allocation profiling is enabled.
> > > + * If enabled, SLUB tries to reduce memory overhead of accounting
> > > + * slab objects. If neither is enabled when this function is called,
> > > + * the optimization is simply skipped to avoid affecting caches that do not
> > > + * need slabobj_ext metadata.
> > > + *
> > > + * However, this may disable optimization when memory cgroup or memory
> > > + * allocation profiling is used, but slabs are created too early
> > > + * even before those subsystems are initialized.
> > > + */
> > > +static inline bool need_slab_obj_exts(struct kmem_cache *s)
> > > +{
> > > +	if (memcg_kmem_online() && (s->flags & SLAB_ACCOUNT))
> > > +		return true;
> > > +
> > > +	if (mem_alloc_profiling_enabled())
> > > +		return true;
> > > +
> > > +	return false;
> > > +}
> > > +
> > > +static inline unsigned int obj_exts_size_in_slab(struct slab *slab)
> > > +{
> > > +	return sizeof(struct slabobj_ext) * slab->objects;
> > > +}
> > > +
> > > +static inline unsigned long obj_exts_offset_in_slab(struct kmem_cache *s,
> > > +						    struct slab *slab)
> > > +{
> > > +	unsigned long objext_offset;
> > > +
> > > +	objext_offset = s->red_left_pad + s->size * slab->objects;
> > 
> > Hi Harry,
> 
> Hi Hao, thanks for the review!
> Hope you're doing well.

Thanks Harry. Hope you are too!

> 
> > As s->size already includes s->red_left_pad
> 
> Great question. It's true that s->size includes s->red_left_pad,
> but we have also a redzone right before the first object:
> 
>   [ redzone ] [ obj 1 | redzone ] [ obj 2| redzone ] [ ... ]
> 
> So we have (slab->objects + 1) red zones and so

I have a follow-up question regarding the redzones. Unless I'm missing
some detail, it seems the left redzone should apply to each object as
well. If so, I would expect the memory layout to be:

[left redzone | obj 1 | right redzone], [left redzone | obj 2 | right redzone], [ ... ]

In `calculate_sizes()`, I see:

if ((flags & SLAB_RED_ZONE) && size == s->object_size)
    size += sizeof(void *);
...
...
if (flags & SLAB_RED_ZONE) {
    size += s->red_left_pad;
}

Could you please confirm whether my understanding is correct, or point
out what I'm missing?

> 
> > do we still need > s->red_left_pad here?
> 
> I think this is still needed.
> 
> -- 
> Cheers,
> Harry / Hyeonggon

