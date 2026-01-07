Return-Path: <cgroups+bounces-12943-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 32E54CFEF73
	for <lists+cgroups@lfdr.de>; Wed, 07 Jan 2026 17:55:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A474534EB99B
	for <lists+cgroups@lfdr.de>; Wed,  7 Jan 2026 16:45:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E315335B127;
	Wed,  7 Jan 2026 14:56:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="IVfmxpSj";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="y7o0Ld2c";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="IVfmxpSj";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="y7o0Ld2c"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0024A35A95E
	for <cgroups@vger.kernel.org>; Wed,  7 Jan 2026 14:56:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767797805; cv=none; b=UvozmvqNwebF+oDBzOes54J+cerNhWtUsVQ1WRYMHQq4lo3u5H/NwgesaHwfxf8yqi6SdWvDCMsUtTRnm/9hxIlK4jAIHmQVfkyMIT2ZnmBRO+r3aNjEWvOZJH15QNF8YzFXSFrGTmlAYseDwP3DINLvQNobMd3jndi7T4XIghs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767797805; c=relaxed/simple;
	bh=NZG9lowQx8XORAM5gbORLY3DW3F31wKXP839ej9sJxc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Okvm/EIYF1DS5FKJX1Nqxp6Bskviz9cfFNLw6s3wrm9GoRD38sAb/tpbnV545auGG6evpZXKYoOXung/rsjeJUjm/J1ZBfOcMWeh6L9HtMSfYKNNoGx5G93Z6yzj3ZAdNT3Z8DX3M2O42QmXCrXtMldTQlDLkcBnxtpF9Jh6wDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=IVfmxpSj; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=y7o0Ld2c; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=IVfmxpSj; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=y7o0Ld2c; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 109EB33698;
	Wed,  7 Jan 2026 14:56:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1767797802; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=3pNbEV2X9F3dC2FKpEusaXu9Rk21HMKvaDGthzwuF1I=;
	b=IVfmxpSjzCgbKWfkYGb5epWy5sM6fs1eWgraxZK8ieYVQwrHpUFS7FKovc7/LEswSKLidY
	Ngq9VLOrOD9PUA9YEGG7pNr5h9xjujlMw82ei2xZPfqZTZ1aHGthpTwZOECN2sOW9uWlhX
	F1pV29B82HQ5NohmOugR+BFuoFsvzQo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1767797802;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=3pNbEV2X9F3dC2FKpEusaXu9Rk21HMKvaDGthzwuF1I=;
	b=y7o0Ld2clnRcKX2TzaDs0Uyz/Ty7ptfzebm2gZ6Eg0w4BmKRJ+5KUh8r4zg4IXQUGsq5h8
	7p+0+x1qosJFMZAQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=IVfmxpSj;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=y7o0Ld2c
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1767797802; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=3pNbEV2X9F3dC2FKpEusaXu9Rk21HMKvaDGthzwuF1I=;
	b=IVfmxpSjzCgbKWfkYGb5epWy5sM6fs1eWgraxZK8ieYVQwrHpUFS7FKovc7/LEswSKLidY
	Ngq9VLOrOD9PUA9YEGG7pNr5h9xjujlMw82ei2xZPfqZTZ1aHGthpTwZOECN2sOW9uWlhX
	F1pV29B82HQ5NohmOugR+BFuoFsvzQo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1767797802;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=3pNbEV2X9F3dC2FKpEusaXu9Rk21HMKvaDGthzwuF1I=;
	b=y7o0Ld2clnRcKX2TzaDs0Uyz/Ty7ptfzebm2gZ6Eg0w4BmKRJ+5KUh8r4zg4IXQUGsq5h8
	7p+0+x1qosJFMZAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id DB13C3EA63;
	Wed,  7 Jan 2026 14:56:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id CG4qNSl0XmmzXwAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Wed, 07 Jan 2026 14:56:41 +0000
Message-ID: <473d479c-4eae-4589-b8c2-e2a29e8e6bc1@suse.cz>
Date: Wed, 7 Jan 2026 15:56:41 +0100
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V5 4/8] mm/slab: abstract slabobj_ext access via new
 slab_obj_ext() helper
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
 <20260105080230.13171-5-harry.yoo@oracle.com>
From: Vlastimil Babka <vbabka@suse.cz>
Autocrypt: addr=vbabka@suse.cz; keydata=
 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
 m6M14QORSWTLRg==
In-Reply-To: <20260105080230.13171-5-harry.yoo@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	ARC_NA(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	RCVD_TLS_ALL(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[23];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,gentwo.org,google.com,cmpxchg.org,kvack.org,kernel.org,linux.dev,arm.com,mit.edu,dilger.ca,vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	TO_DN_SOME(0.00)[]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spam-Level: 
X-Rspamd-Queue-Id: 109EB33698
X-Spam-Flag: NO
X-Spam-Score: -3.01

On 1/5/26 09:02, Harry Yoo wrote:
> Currently, the slab allocator assumes that slab->obj_exts is a pointer
> to an array of struct slabobj_ext objects. However, to support storage
> methods where struct slabobj_ext is embedded within objects, the slab
> allocator should not make this assumption. Instead of directly
> dereferencing the slabobj_exts array, abstract access to
> struct slabobj_ext via helper functions.
> 
> Introduce a new API slabobj_ext metadata access:
> 
>   slab_obj_ext(slab, obj_exts, index) - returns the pointer to
>   struct slabobj_ext element at the given index.
> 
> Directly dereferencing the return value of slab_obj_exts() is no longer
> allowed. Instead, slab_obj_ext() must always be used to access
> individual struct slabobj_ext objects.
> 
> Convert all users to use these APIs.
> No functional changes intended.
> 

> +/*
> + * slab_obj_ext - get the pointer to the slab object extension metadata
> + * associated with an object in a slab.
> + * @slab: a pointer to the slab struct
> + * @obj_exts: a pointer to the object extension vector
> + * @index: an index of the object
> + *
> + * Returns a pointer to the object extension associated with the object.
> + */
> +static inline struct slabobj_ext *slab_obj_ext(struct slab *slab,
> +					       unsigned long obj_exts,
> +					       unsigned int index)
> +{
> +	struct slabobj_ext *obj_ext;
> +
> +	VM_WARN_ON_ONCE(!slab_obj_exts(slab));
> +	VM_WARN_ON_ONCE(obj_exts != slab_obj_exts(slab));

The first check seems redundant given we have the second one? If we get
passed obj_ext 0 and slab_obj_exts() is also 0, it will blow up quickly anyway.

> +
> +	obj_ext = (struct slabobj_ext *)obj_exts;
> +	return &obj_ext[index];
>  }
>  
>  int alloc_slab_obj_exts(struct slab *slab, struct kmem_cache *s,
> @@ -533,7 +558,13 @@ int alloc_slab_obj_exts(struct slab *slab, struct kmem_cache *s,
>  
>  #else /* CONFIG_SLAB_OBJ_EXT */
>  
> -static inline struct slabobj_ext *slab_obj_exts(struct slab *slab)
> +static inline unsigned long slab_obj_exts(struct slab *slab)
> +{
> +	return 0;
> +}
> +
> +static inline struct slabobj_ext *slab_obj_ext(struct slab *slab,
> +					       unsigned int index)

Hmm this is missing the obj_exts parameter? Either will not compile
!CONFIG_SLAB_OBJ_EXT or isn't reachable in that config anyway?

>  {
>  	return NULL;
>  }
> @@ -550,7 +581,7 @@ static inline enum node_stat_item cache_vmstat_idx(struct kmem_cache *s)
>  bool __memcg_slab_post_alloc_hook(struct kmem_cache *s, struct list_lru *lru,
>  				  gfp_t flags, size_t size, void **p);
>  void __memcg_slab_free_hook(struct kmem_cache *s, struct slab *slab,
> -			    void **p, int objects, struct slabobj_ext *obj_exts);
> +			    void **p, int objects, unsigned long obj_exts);
>  #endif
>  
>  void kvfree_rcu_cb(struct rcu_head *head);
> diff --git a/mm/slub.c b/mm/slub.c
> index 0e32f6420a8a..84bd4f23dc4a 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c

<snip>

> @@ -2176,7 +2178,7 @@ int alloc_slab_obj_exts(struct slab *slab, struct kmem_cache *s,
>  
>  static inline void free_slab_obj_exts(struct slab *slab)
>  {
> -	struct slabobj_ext *obj_exts;
> +	unsigned long obj_exts;

I think in this function we could leave it as pointer.

>  	obj_exts = slab_obj_exts(slab);

And do a single cast here.

>  	if (!obj_exts) {
> @@ -2196,11 +2198,11 @@ static inline void free_slab_obj_exts(struct slab *slab)
>  	 * NULL, therefore replace NULL with CODETAG_EMPTY to indicate that
>  	 * the extension for obj_exts is expected to be NULL.
>  	 */
> -	mark_objexts_empty(obj_exts);
> +	mark_objexts_empty((struct slabobj_ext *)obj_exts);
>  	if (unlikely(READ_ONCE(slab->obj_exts) & OBJEXTS_NOSPIN_ALLOC))
> -		kfree_nolock(obj_exts);
> +		kfree_nolock((void *)obj_exts);
>  	else
> -		kfree(obj_exts);
> +		kfree((void *)obj_exts);
>  	slab->obj_exts = 0;
>  }

And avoid those 3 above.
Unless it gets more complicated with later patches...



