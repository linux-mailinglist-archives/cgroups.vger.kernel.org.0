Return-Path: <cgroups+bounces-12947-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 210DFCFF2A9
	for <lists+cgroups@lfdr.de>; Wed, 07 Jan 2026 18:43:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id AEE6A3046DBE
	for <lists+cgroups@lfdr.de>; Wed,  7 Jan 2026 17:41:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21901395DA6;
	Wed,  7 Jan 2026 17:33:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="VwvCMpAP";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="MeynhhRU";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="2gY2pQ7p";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="liITzl9A"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEF17395D80
	for <cgroups@vger.kernel.org>; Wed,  7 Jan 2026 17:33:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767807237; cv=none; b=nFckHwLkrkKetz/I6YE5PcVb/VZcLvpWTlFfBjsdWRF2rhdwDejbBkPlqjNM9nnIfOw6taMgxwNp6hS37Pr3IsmUskm5mlfe80RlmDWGLkK+Ho4ln6G3OQN2eEqGfB7stXVra3oWwrNZvJfuY5GOEiEtC13T4xKIKjkF06hMjFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767807237; c=relaxed/simple;
	bh=9oSFyuNT8vFXKUDQcpJoblc0paE7RkcrYd3rBDyVjW4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pn2u29msXDbGb/fsUqqJSXh2xhpBqpXLnqv+YwxE99ap2XHXlcmfFJInbVoHPguvyX4ahz9o6to+y66/T1RAaY5F8xdEt2prAlQry+9D9D3//A4UiArHo2vf6Anx69KS7lXlLPTF24K5m3BhtEr+VqwKsUPx11NEMq0PQ+9D7zk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=VwvCMpAP; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=MeynhhRU; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=2gY2pQ7p; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=liITzl9A; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id EEE8F5BCD3;
	Wed,  7 Jan 2026 17:33:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1767807233; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=HzkHQmvrK/B1YkN+O5Sdmu0pHn50wpfwPqP+1PsfPWM=;
	b=VwvCMpAPQcx6BYiezhcexughsPtKPZcxFTeCCQ+ekQZFnIRFUf+1sY7MaKhP5u2mhPRDEv
	wM50lYbg2QmIA8emYBLXjwWyLUac0gONEPIMFKLVtFK40N8PqhlLFPwZ+nToPuZoa9pUzd
	cDmBVOa7qkaAIizyA3T04mMl/uD3hpw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1767807233;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=HzkHQmvrK/B1YkN+O5Sdmu0pHn50wpfwPqP+1PsfPWM=;
	b=MeynhhRUmSAf9tODh6Bi7gWJSCpMDhpEe/R515HuxkoBSx8N17MIs+WDKlhat4adfBLQ3N
	txVmohiYnnk9w9AA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1767807232; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=HzkHQmvrK/B1YkN+O5Sdmu0pHn50wpfwPqP+1PsfPWM=;
	b=2gY2pQ7pGGYy05qp7vN2ZDagoEx5vBJF/Uj4t4A6T8cOP5kKvWku/uJV70/W5jX3vmeUfy
	9btzwrrBEvlToiLRR7DXiOG62zSMjasI47rfjpMFO7UugIFN31aacOyfL4Gt13zgcI8sCc
	wrNUWYFVCrKpc6yMDF1KRxZg/+Y0e/c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1767807232;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=HzkHQmvrK/B1YkN+O5Sdmu0pHn50wpfwPqP+1PsfPWM=;
	b=liITzl9AwLfKI4RsqDQgBrXDOu4GDBY5oyhmRnUwYDk8WhDK1BBnjYJpUkImDU++XFuZo2
	FwVYE3ADl3wH0UBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C36623EA63;
	Wed,  7 Jan 2026 17:33:52 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 9b7qLgCZXmktfAAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Wed, 07 Jan 2026 17:33:52 +0000
Message-ID: <8c67dcbe-f393-4da6-8d24-f9da79c246c4@suse.cz>
Date: Wed, 7 Jan 2026 18:33:52 +0100
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V5 8/8] mm/slab: place slabobj_ext metadata in unused
 space within s->size
Content-Language: en-US
To: Harry Yoo <harry.yoo@oracle.com>, akpm@linux-foundation.org
Cc: andreyknvl@gmail.com, cl@gentwo.org, dvyukov@google.com,
 glider@google.com, hannes@cmpxchg.org, linux-mm@kvack.org,
 mhocko@kernel.org, muchun.song@linux.dev, rientjes@google.com,
 roman.gushchin@linux.dev, ryabinin.a.a@gmail.com, shakeel.butt@linux.dev,
 surenb@google.com, vincenzo.frascino@arm.com, yeoreum.yun@arm.com,
 tytso@mit.edu, adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
 linux-kernel@vger.kernel.org, cgroups@vger.kernel.org, hao.li@linux.dev
References: <20260105080230.13171-1-harry.yoo@oracle.com>
 <20260105080230.13171-9-harry.yoo@oracle.com>
From: Vlastimil Babka <vbabka@suse.cz>
Autocrypt: addr=vbabka@suse.cz; keydata=
 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
 m6M14QORSWTLRg==
In-Reply-To: <20260105080230.13171-9-harry.yoo@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.997];
	MIME_GOOD(-0.10)[text/plain];
	TAGGED_RCPT(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[23];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,gentwo.org,google.com,cmpxchg.org,kvack.org,kernel.org,linux.dev,arm.com,mit.edu,dilger.ca,vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oracle.com:email]
X-Spam-Level: 
X-Spam-Flag: NO
X-Spam-Score: -2.80

On 1/5/26 09:02, Harry Yoo wrote:
> When a cache has high s->align value and s->object_size is not aligned
> to it, each object ends up with some unused space because of alignment.
> If this wasted space is big enough, we can use it to store the
> slabobj_ext metadata instead of wasting it.
> 
> On my system, this happens with caches like kmem_cache, mm_struct, pid,
> task_struct, sighand_cache, xfs_inode, and others.
> 
> To place the slabobj_ext metadata within each object, the existing
> slab_obj_ext() logic can still be used by setting:
> 
>   - slab->obj_exts = slab_address(slab) + s->red_left_zone +
>                      (slabobj_ext offset)
>   - stride = s->size
> 
> slab_obj_ext() doesn't need know where the metadata is stored,
> so this method works without adding extra overhead to slab_obj_ext().
> 
> A good example benefiting from this optimization is xfs_inode
> (object_size: 992, align: 64). To measure memory savings, 2 millions of
> files were created on XFS.
> 
> [ MEMCG=y, MEM_ALLOC_PROFILING=n ]
> 
> Before patch (creating ~2.64M directories on xfs):
>   Slab:            5175976 kB
>   SReclaimable:    3837524 kB
>   SUnreclaim:      1338452 kB
> 
> After patch (creating ~2.64M directories on xfs):
>   Slab:            5152912 kB
>   SReclaimable:    3838568 kB
>   SUnreclaim:      1314344 kB (-23.54 MiB)
> 
> Enjoy the memory savings!
> 
> Suggested-by: Vlastimil Babka <vbabka@suse.cz>
> Signed-off-by: Harry Yoo <harry.yoo@oracle.com>
> ---
>  include/linux/slab.h |  9 ++++++
>  mm/slab_common.c     |  6 ++--
>  mm/slub.c            | 73 ++++++++++++++++++++++++++++++++++++++++++--
>  3 files changed, 83 insertions(+), 5 deletions(-)
> 
> diff --git a/include/linux/slab.h b/include/linux/slab.h
> index 4554c04a9bd7..da512d9ab1a0 100644
> --- a/include/linux/slab.h
> +++ b/include/linux/slab.h
> @@ -59,6 +59,9 @@ enum _slab_flag_bits {
>  	_SLAB_CMPXCHG_DOUBLE,
>  #ifdef CONFIG_SLAB_OBJ_EXT
>  	_SLAB_NO_OBJ_EXT,
> +#endif
> +#if defined(CONFIG_SLAB_OBJ_EXT) && defined(CONFIG_64BIT)
> +	_SLAB_OBJ_EXT_IN_OBJ,
>  #endif
>  	_SLAB_FLAGS_LAST_BIT
>  };
> @@ -244,6 +247,12 @@ enum _slab_flag_bits {
>  #define SLAB_NO_OBJ_EXT		__SLAB_FLAG_UNUSED
>  #endif
>  
> +#if defined(CONFIG_SLAB_OBJ_EXT) && defined(CONFIG_64BIT)
> +#define SLAB_OBJ_EXT_IN_OBJ	__SLAB_FLAG_BIT(_SLAB_OBJ_EXT_IN_OBJ)
> +#else
> +#define SLAB_OBJ_EXT_IN_OBJ	__SLAB_FLAG_UNUSED
> +#endif
> +
>  /*
>   * ZERO_SIZE_PTR will be returned for zero sized kmalloc requests.
>   *
> diff --git a/mm/slab_common.c b/mm/slab_common.c
> index c4cf9ed2ec92..f0a6db20d7ea 100644
> --- a/mm/slab_common.c
> +++ b/mm/slab_common.c
> @@ -43,11 +43,13 @@ DEFINE_MUTEX(slab_mutex);
>  struct kmem_cache *kmem_cache;
>  
>  /*
> - * Set of flags that will prevent slab merging
> + * Set of flags that will prevent slab merging.
> + * Any flag that adds per-object metadata should be included,
> + * since slab merging can update s->inuse that affects the metadata layout.
>   */
>  #define SLAB_NEVER_MERGE (SLAB_RED_ZONE | SLAB_POISON | SLAB_STORE_USER | \
>  		SLAB_TRACE | SLAB_TYPESAFE_BY_RCU | SLAB_NOLEAKTRACE | \
> -		SLAB_FAILSLAB | SLAB_NO_MERGE)
> +		SLAB_FAILSLAB | SLAB_NO_MERGE | SLAB_OBJ_EXT_IN_OBJ)
>  
>  #define SLAB_MERGE_SAME (SLAB_RECLAIM_ACCOUNT | SLAB_CACHE_DMA | \
>  			 SLAB_CACHE_DMA32 | SLAB_ACCOUNT)
> diff --git a/mm/slub.c b/mm/slub.c
> index 50b74324e550..43fdbff9d09b 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -977,6 +977,39 @@ static inline bool obj_exts_in_slab(struct kmem_cache *s, struct slab *slab)
>  {
>  	return false;
>  }
> +
> +#endif
> +
> +#if defined(CONFIG_SLAB_OBJ_EXT) && defined(CONFIG_64BIT)
> +static bool obj_exts_in_object(struct kmem_cache *s)
> +{
> +	return s->flags & SLAB_OBJ_EXT_IN_OBJ;

So this is a property of the cache.

> +}
> +
> +static unsigned int obj_exts_offset_in_object(struct kmem_cache *s)
> +{
> +	unsigned int offset = get_info_end(s);
> +
> +	if (kmem_cache_debug_flags(s, SLAB_STORE_USER))
> +		offset += sizeof(struct track) * 2;
> +
> +	if (slub_debug_orig_size(s))
> +		offset += sizeof(unsigned long);
> +
> +	offset += kasan_metadata_size(s, false);
> +
> +	return offset;
> +}
> +#else
> +static inline bool obj_exts_in_object(struct kmem_cache *s)
> +{
> +	return false;
> +}
> +
> +static inline unsigned int obj_exts_offset_in_object(struct kmem_cache *s)
> +{
> +	return 0;
> +}
>  #endif
>  
>  #ifdef CONFIG_SLUB_DEBUG
> @@ -1277,6 +1310,9 @@ static void print_trailer(struct kmem_cache *s, struct slab *slab, u8 *p)
>  
>  	off += kasan_metadata_size(s, false);
>  
> +	if (obj_exts_in_object(s))
> +		off += sizeof(struct slabobj_ext);
> +
>  	if (off != size_from_object(s))
>  		/* Beginning of the filler is the free pointer */
>  		print_section(KERN_ERR, "Padding  ", p + off,
> @@ -1446,7 +1482,10 @@ check_bytes_and_report(struct kmem_cache *s, struct slab *slab,
>   * 	A. Free pointer (if we cannot overwrite object on free)
>   * 	B. Tracking data for SLAB_STORE_USER
>   *	C. Original request size for kmalloc object (SLAB_STORE_USER enabled)
> - *	D. Padding to reach required alignment boundary or at minimum
> + *	D. KASAN alloc metadata (KASAN enabled)
> + *	E. struct slabobj_ext to store accounting metadata
> + *	   (SLAB_OBJ_EXT_IN_OBJ enabled)
> + *	F. Padding to reach required alignment boundary or at minimum
>   * 		one word if debugging is on to be able to detect writes
>   * 		before the word boundary.
>   *
> @@ -1474,6 +1513,9 @@ static int check_pad_bytes(struct kmem_cache *s, struct slab *slab, u8 *p)
>  
>  	off += kasan_metadata_size(s, false);
>  
> +	if (obj_exts_in_object(s))
> +		off += sizeof(struct slabobj_ext);
> +
>  	if (size_from_object(s) == off)
>  		return 1;
>  
> @@ -2280,7 +2322,8 @@ static inline void free_slab_obj_exts(struct slab *slab)
>  		return;
>  	}
>  
> -	if (obj_exts_in_slab(slab->slab_cache, slab)) {
> +	if (obj_exts_in_slab(slab->slab_cache, slab) ||
> +			obj_exts_in_object(slab->slab_cache)) {

Here we check that property to determine if we can return early and not do
kfree().

>  		slab->obj_exts = 0;
>  		return;
>  	}
> @@ -2326,6 +2369,23 @@ static void alloc_slab_obj_exts_early(struct kmem_cache *s, struct slab *slab)
>  			obj_exts |= MEMCG_DATA_OBJEXTS;
>  		slab->obj_exts = obj_exts;
>  		slab_set_stride(slab, sizeof(struct slabobj_ext));
> +	} else if (obj_exts_in_object(s)) {
> +		unsigned int offset = obj_exts_offset_in_object(s);

But we reach this only when need_slab_obj_exts() is true above. So there
might be slabs from caches where obj_exts_in_object() is true, but still
have obj_exts allocated by kmalloc, and we leak them in
free_slab_obj_exts(). (and we perform some incorrect action wherever else
obj_exts_in_object() is checked) AFAIU?

So I think we need to check obj_exts_in_slab() (in the simplified way I
suggested for patch 7/8) first, and only look at obj_exts_in_object()
afterwards to distinguish the exact layout where needed? (i.e.
free_slab_obj_exts() is fine to just check obj_exts_in_slab()).

> +		obj_exts = (unsigned long)slab_address(slab);
> +		obj_exts += s->red_left_pad;
> +		obj_exts += offset;
> +
> +		get_slab_obj_exts(obj_exts);
> +		for_each_object(addr, s, slab_address(slab), slab->objects)
> +			memset(kasan_reset_tag(addr) + offset, 0,
> +			       sizeof(struct slabobj_ext));
> +		put_slab_obj_exts(obj_exts);
> +
> +		if (IS_ENABLED(CONFIG_MEMCG))
> +			obj_exts |= MEMCG_DATA_OBJEXTS;
> +		slab->obj_exts = obj_exts;
> +		slab_set_stride(slab, s->size);
>  	}
>  }
>  
> @@ -8023,6 +8083,7 @@ static int calculate_sizes(struct kmem_cache_args *args, struct kmem_cache *s)
>  {
>  	slab_flags_t flags = s->flags;
>  	unsigned int size = s->object_size;
> +	unsigned int aligned_size;
>  	unsigned int order;
>  
>  	/*
> @@ -8132,7 +8193,13 @@ static int calculate_sizes(struct kmem_cache_args *args, struct kmem_cache *s)
>  	 * offset 0. In order to align the objects we have to simply size
>  	 * each object to conform to the alignment.
>  	 */
> -	size = ALIGN(size, s->align);
> +	aligned_size = ALIGN(size, s->align);
> +#if defined(CONFIG_SLAB_OBJ_EXT) && defined(CONFIG_64BIT)
> +	if (aligned_size - size >= sizeof(struct slabobj_ext))
> +		s->flags |= SLAB_OBJ_EXT_IN_OBJ;
> +#endif
> +	size = aligned_size;
> +
>  	s->size = size;
>  	s->reciprocal_size = reciprocal_value(size);
>  	order = calculate_order(size);


