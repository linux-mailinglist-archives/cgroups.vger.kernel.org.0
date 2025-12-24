Return-Path: <cgroups+bounces-12651-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CEF5ECDC3EA
	for <lists+cgroups@lfdr.de>; Wed, 24 Dec 2025 13:43:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 32DC5300A9EF
	for <lists+cgroups@lfdr.de>; Wed, 24 Dec 2025 12:43:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5EF03164B8;
	Wed, 24 Dec 2025 12:43:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ehY7dE1f"
X-Original-To: cgroups@vger.kernel.org
Received: from out-177.mta1.migadu.com (out-177.mta1.migadu.com [95.215.58.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BD7E25524C
	for <cgroups@vger.kernel.org>; Wed, 24 Dec 2025 12:43:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766580235; cv=none; b=ccUaN5e0XPTLn5/4kvpfPe6pkb8kWhmeTUenwFcwfjhID2nuTpbIIvtNTxH0A++fGWoHZtfwNTygE9vWSd/Jnu/PzKae9OfR4Nl8uQctcVmQ1IdNSycCSPXaWZuAaLEjWq/FvZ+rRrqZ7cLaKB0YF6hQKWbxQq0iNWjJoix6OFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766580235; c=relaxed/simple;
	bh=V+Y0/JmpXHcMGKrmGye+hgR+MiVO43R4JULpGORiILg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fqMCPowJhLFNlzfp9nxnu3mkfxWHI6nRvuzaFBu21Dk9ALVXcp0/nZR0fDxAnQUnTK0KIlZ+Z6tRWtlkRN8tw18tk3Rdq2jhZprxqX7zcDieRPmSHpTL/4yFUnD58uqMxtbqOsTLP2YSCXTwESyX5v175YiGIbp3Fx6vxsLn2BI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ehY7dE1f; arc=none smtp.client-ip=95.215.58.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Wed, 24 Dec 2025 20:43:17 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1766580229;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SSxxcIkOsePQBMv0NHiDzMDYFYBXainz4dldKVuXcSk=;
	b=ehY7dE1fIVynOFJxKj/+1pXUCaEnCa7cUcMBuR+TBXprP47LgmHQCpzFz9wS8sOzFg/ZTu
	os+redn0r/9JtRRm5mAEUKg2TdpGwzreEP+LJoWX0dF0RGMit+BkxS5L0xFGF9vUEMMHDT
	ebxNymTTMRWjYMeGfW2Zbg+iqMUP2GQ=
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
Subject: Re: [PATCH V4 8/8] mm/slab: place slabobj_ext metadata in unused
 space within s->size
Message-ID: <hofqvftaj7ofgdvzb56hvjgk7chxkb5gfsj3324e7wal72mjll@7m4s7adnk35j>
References: <20251222110843.980347-1-harry.yoo@oracle.com>
 <20251222110843.980347-9-harry.yoo@oracle.com>
 <l2xww4mysued3fjc2jzzy6cjrq5guygsxesmfqrhv2laxigpaq@ghj7xitfq7fh>
 <aUuKgRlI60Hw3-Et@hyeyoo>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aUuKgRlI60Hw3-Et@hyeyoo>
X-Migadu-Flow: FLOW_OUT

On Wed, Dec 24, 2025 at 03:38:57PM +0900, Harry Yoo wrote:
> On Wed, Dec 24, 2025 at 01:33:59PM +0800, Hao Li wrote:
> > On Mon, Dec 22, 2025 at 08:08:43PM +0900, Harry Yoo wrote:
> > > When a cache has high s->align value and s->object_size is not aligned
> > > to it, each object ends up with some unused space because of alignment.
> > > If this wasted space is big enough, we can use it to store the
> > > slabobj_ext metadata instead of wasting it.
> > > 
> > > On my system, this happens with caches like kmem_cache, mm_struct, pid,
> > > task_struct, sighand_cache, xfs_inode, and others.
> > > 
> > > To place the slabobj_ext metadata within each object, the existing
> > > slab_obj_ext() logic can still be used by setting:
> > > 
> > >   - slab->obj_exts = slab_address(slab) + s->red_left_zone +
> > >                      (slabobj_ext offset)
> > >   - stride = s->size
> > > 
> > > slab_obj_ext() doesn't need know where the metadata is stored,
> > > so this method works without adding extra overhead to slab_obj_ext().
> > > 
> > > A good example benefiting from this optimization is xfs_inode
> > > (object_size: 992, align: 64). To measure memory savings, 2 millions of
> > > files were created on XFS.
> > > 
> > > [ MEMCG=y, MEM_ALLOC_PROFILING=n ]
> > > 
> > > Before patch (creating ~2.64M directories on xfs):
> > >   Slab:            5175976 kB
> > >   SReclaimable:    3837524 kB
> > >   SUnreclaim:      1338452 kB
> > > 
> > > After patch (creating ~2.64M directories on xfs):
> > >   Slab:            5152912 kB
> > >   SReclaimable:    3838568 kB
> > >   SUnreclaim:      1314344 kB (-23.54 MiB)
> > > 
> > > Enjoy the memory savings!
> > > 
> > > Suggested-by: Vlastimil Babka <vbabka@suse.cz>
> > > Signed-off-by: Harry Yoo <harry.yoo@oracle.com>
> > > ---
> > >  include/linux/slab.h |  9 ++++++
> > >  mm/slab_common.c     |  6 ++--
> > >  mm/slub.c            | 73 ++++++++++++++++++++++++++++++++++++++++++--
> > >  3 files changed, 83 insertions(+), 5 deletions(-)
> > > 
> > > diff --git a/include/linux/slab.h b/include/linux/slab.h
> > > index 4554c04a9bd7..da512d9ab1a0 100644
> > > --- a/include/linux/slab.h
> > > +++ b/include/linux/slab.h
> > > @@ -59,6 +59,9 @@ enum _slab_flag_bits {
> > >  	_SLAB_CMPXCHG_DOUBLE,
> > >  #ifdef CONFIG_SLAB_OBJ_EXT
> > >  	_SLAB_NO_OBJ_EXT,
> > > +#endif
> > > +#if defined(CONFIG_SLAB_OBJ_EXT) && defined(CONFIG_64BIT)
> > > +	_SLAB_OBJ_EXT_IN_OBJ,
> > >  #endif
> > >  	_SLAB_FLAGS_LAST_BIT
> > >  };
> > > @@ -244,6 +247,12 @@ enum _slab_flag_bits {
> > >  #define SLAB_NO_OBJ_EXT		__SLAB_FLAG_UNUSED
> > >  #endif
> > >  
> > > +#if defined(CONFIG_SLAB_OBJ_EXT) && defined(CONFIG_64BIT)
> > > +#define SLAB_OBJ_EXT_IN_OBJ	__SLAB_FLAG_BIT(_SLAB_OBJ_EXT_IN_OBJ)
> > > +#else
> > > +#define SLAB_OBJ_EXT_IN_OBJ	__SLAB_FLAG_UNUSED
> > > +#endif
> > > +
> > >  /*
> > >   * ZERO_SIZE_PTR will be returned for zero sized kmalloc requests.
> > >   *
> > > diff --git a/mm/slab_common.c b/mm/slab_common.c
> > > index c4cf9ed2ec92..f0a6db20d7ea 100644
> > > --- a/mm/slab_common.c
> > > +++ b/mm/slab_common.c
> > > @@ -43,11 +43,13 @@ DEFINE_MUTEX(slab_mutex);
> > >  struct kmem_cache *kmem_cache;
> > >  
> > >  /*
> > > - * Set of flags that will prevent slab merging
> > > + * Set of flags that will prevent slab merging.
> > > + * Any flag that adds per-object metadata should be included,
> > > + * since slab merging can update s->inuse that affects the metadata layout.
> > >   */
> > >  #define SLAB_NEVER_MERGE (SLAB_RED_ZONE | SLAB_POISON | SLAB_STORE_USER | \
> > >  		SLAB_TRACE | SLAB_TYPESAFE_BY_RCU | SLAB_NOLEAKTRACE | \
> > > -		SLAB_FAILSLAB | SLAB_NO_MERGE)
> > > +		SLAB_FAILSLAB | SLAB_NO_MERGE | SLAB_OBJ_EXT_IN_OBJ)
> > >  
> > >  #define SLAB_MERGE_SAME (SLAB_RECLAIM_ACCOUNT | SLAB_CACHE_DMA | \
> > >  			 SLAB_CACHE_DMA32 | SLAB_ACCOUNT)
> > > diff --git a/mm/slub.c b/mm/slub.c
> > > index 3fc3d2ca42e7..78f0087c8e48 100644
> > > --- a/mm/slub.c
> > > +++ b/mm/slub.c
> > > @@ -977,6 +977,39 @@ static inline bool obj_exts_in_slab(struct kmem_cache *s, struct slab *slab)
> > >  {
> > >  	return false;
> > >  }
> > > +
> > > +#endif
> > > +
> > > +#if defined(CONFIG_SLAB_OBJ_EXT) && defined(CONFIG_64BIT)
> > > +static bool obj_exts_in_object(struct kmem_cache *s)
> > > +{
> > > +	return s->flags & SLAB_OBJ_EXT_IN_OBJ;
> > > +}
> > > +
> > > +static unsigned int obj_exts_offset_in_object(struct kmem_cache *s)
> > > +{
> > > +	unsigned int offset = get_info_end(s);
> > > +
> > > +	if (kmem_cache_debug_flags(s, SLAB_STORE_USER))
> > > +		offset += sizeof(struct track) * 2;
> > > +
> > > +	if (slub_debug_orig_size(s))
> > > +		offset += sizeof(unsigned long);
> > > +
> > > +	offset += kasan_metadata_size(s, false);
> > > +
> > > +	return offset;
> > > +}
> > > +#else
> > > +static inline bool obj_exts_in_object(struct kmem_cache *s)
> > > +{
> > > +	return false;
> > > +}
> > > +
> > > +static inline unsigned int obj_exts_offset_in_object(struct kmem_cache *s)
> > > +{
> > > +	return 0;
> > > +}
> > >  #endif
> > >  
> > >  #ifdef CONFIG_SLUB_DEBUG
> > > @@ -1277,6 +1310,9 @@ static void print_trailer(struct kmem_cache *s, struct slab *slab, u8 *p)
> > >  
> > >  	off += kasan_metadata_size(s, false);
> > >  
> > > +	if (obj_exts_in_object(s))
> > > +		off += sizeof(struct slabobj_ext);
> > > +
> > >  	if (off != size_from_object(s))
> > >  		/* Beginning of the filler is the free pointer */
> > >  		print_section(KERN_ERR, "Padding  ", p + off,
> > > @@ -1446,7 +1482,10 @@ check_bytes_and_report(struct kmem_cache *s, struct slab *slab,
> > >   * 	A. Free pointer (if we cannot overwrite object on free)
> > >   * 	B. Tracking data for SLAB_STORE_USER
> > >   *	C. Original request size for kmalloc object (SLAB_STORE_USER enabled)
> > > - *	D. Padding to reach required alignment boundary or at minimum
> > > + *	D. KASAN alloc metadata (KASAN enabled)
> > > + *	E. struct slabobj_ext to store accounting metadata
> > > + *	   (SLAB_OBJ_EXT_IN_OBJ enabled)
> > > + *	F. Padding to reach required alignment boundary or at minimum
> > >   * 		one word if debugging is on to be able to detect writes
> > >   * 		before the word boundary.
> > >   *
> > > @@ -1474,6 +1513,9 @@ static int check_pad_bytes(struct kmem_cache *s, struct slab *slab, u8 *p)
> > >  
> > >  	off += kasan_metadata_size(s, false);
> > >  
> > > +	if (obj_exts_in_object(s))
> > > +		off += sizeof(struct slabobj_ext);
> > > +
> > >  	if (size_from_object(s) == off)
> > >  		return 1;
> > >  
> > > @@ -2280,7 +2322,8 @@ static inline void free_slab_obj_exts(struct slab *slab)
> > >  		return;
> > >  	}
> > >  
> > > -	if (obj_exts_in_slab(slab->slab_cache, slab)) {
> > > +	if (obj_exts_in_slab(slab->slab_cache, slab) ||
> > > +			obj_exts_in_object(slab->slab_cache)) {
> > >  		slab->obj_exts = 0;
> > >  		return;
> > >  	}
> > > @@ -2326,6 +2369,23 @@ static void alloc_slab_obj_exts_early(struct kmem_cache *s, struct slab *slab)
> > >  			obj_exts |= MEMCG_DATA_OBJEXTS;
> > >  		slab->obj_exts = obj_exts;
> > >  		slab_set_stride(slab, sizeof(struct slabobj_ext));
> > > +	} else if (obj_exts_in_object(s)) {
> > > +		unsigned int offset = obj_exts_offset_in_object(s);
> > > +
> > > +		obj_exts = (unsigned long)slab_address(slab);
> > > +		obj_exts += s->red_left_pad;
> > > +		obj_exts += obj_exts_offset_in_object(s);
> > 
> > Hi, Harry
> > 
> > It looks like this could just be simplified to obj_exts += offset, right?
> 
> Right! Will do in v5.
> 
> > > +
> > > +		get_slab_obj_exts(obj_exts);
> > > +		for_each_object(addr, s, slab_address(slab), slab->objects)
> > > +			memset(kasan_reset_tag(addr) + offset, 0,
> > > +			       sizeof(struct slabobj_ext));
> > > +		put_slab_obj_exts(obj_exts);
> > > +
> > > +		if (IS_ENABLED(CONFIG_MEMCG))
> > > +			obj_exts |= MEMCG_DATA_OBJEXTS;
> > > +		slab->obj_exts = obj_exts;
> > > +		slab_set_stride(slab, s->size);
> > >  	}
> > >  }
> > >  
> > > @@ -8023,6 +8083,7 @@ static int calculate_sizes(struct kmem_cache_args *args, struct kmem_cache *s)
> > >  {
> > >  	slab_flags_t flags = s->flags;
> > >  	unsigned int size = s->object_size;
> > > +	unsigned int aligned_size;
> > >  	unsigned int order;
> > >  
> > >  	/*
> > > @@ -8132,7 +8193,13 @@ static int calculate_sizes(struct kmem_cache_args *args, struct kmem_cache *s)
> > >  	 * offset 0. In order to align the objects we have to simply size
> > >  	 * each object to conform to the alignment.
> > >  	 */
> > > -	size = ALIGN(size, s->align);
> > > +	aligned_size = ALIGN(size, s->align);
> > > +#if defined(CONFIG_SLAB_OBJ_EXT) && defined(CONFIG_64BIT)
> > > +	if (aligned_size - size >= sizeof(struct slabobj_ext))
> > > +		s->flags |= SLAB_OBJ_EXT_IN_OBJ;
> > > +#endif
> > > +	size = aligned_size;
> > > +
> > 
> > One more thought: in calculate_sizes() we add some extra padding when
> > SLAB_RED_ZONE is enabled:
> > 
> > if (flags & SLAB_RED_ZONE) {
> > 	/*
> > 	 * Add some empty padding so that we can catch
> > 	 * overwrites from earlier objects rather than let
> > 	 * tracking information or the free pointer be
> > 	 * corrupted if a user writes before the start
> > 	 * of the object.
> > 	 */
> > 	size += sizeof(void *);
> > 	...
> > }
> > 
> > 
> > From what I understand, this additional padding ends up being placed
> > after the KASAN allocation metadata.
> 
> Right.
> 
> > Since it’s only "extra" padding (i.e., it doesn’t seem strictly required
> > for the layout), and your patch would reuse this area — together with
> > the final padding introduced by `size = ALIGN(size, s->align);`
> 
> Very good point!
> Nah, it wasn't intentional to reuse the extra padding.
> 
> > for objext, it seems like this padding may no longer provide much benefit.
> > Do you think it would make sense to remove this extra padding
> > altogether?
> 
> I think when debugging flags are enabled it'd still be useful to have,

Absolutely — I’m with you on this.

After thinking about it again, I agree it’s better to keep it.

Without that mandatory extra word, we could end up with "no trailing
padding at all" in cases where ALIGN(size, s->align) doesn’t actually
add any bytes.

> I'll try to keep the padding area after obj_ext (so that overwrites from
> the previous object won't overwrite the metadata).

Agree — we should make sure there is at least sizeof(void *) of extra
space after obj_exts when SLAB_RED_ZONE is enabled, so POISON_INUSE has
somewhere to go.

> 
> Thanks a lot!

Happy to help.

-- 
Thanks,
Hao
> 
> -- 
> Cheers,
> Harry / Hyeonggon

