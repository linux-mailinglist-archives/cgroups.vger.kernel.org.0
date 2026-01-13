Return-Path: <cgroups+bounces-13147-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id E41E6D18EEF
	for <lists+cgroups@lfdr.de>; Tue, 13 Jan 2026 13:52:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id E5A8A30260A9
	for <lists+cgroups@lfdr.de>; Tue, 13 Jan 2026 12:45:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E624638F939;
	Tue, 13 Jan 2026 12:44:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="K67Cdn3S";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="zxU1APvI";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="K67Cdn3S";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="zxU1APvI"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0461638F25A
	for <cgroups@vger.kernel.org>; Tue, 13 Jan 2026 12:44:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768308289; cv=none; b=fRu57dw9ajKZIbKpAd+FfnINRBjQW9F/RbxtAPpzJt03LJaiMvpKL+eY8sSEBng6VtLjGGiiI6/S9OjwGW7KFu8LDtRirtFyf43PlvQusTAKqiXQ7HngOCcxUFWFr9lTqz9zMrS09AWvJcSZi68qu4Qf7u5W5p/RT8cm2rJ2w3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768308289; c=relaxed/simple;
	bh=ij0SCfWxz4GVrzvoUzt92UkvKKBMUFwxa3P6SLVwvYw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iChLgALqzNysv8BqT/CyY9dy0Koc2w/9GUrE0vzBvcNhUB2sVJrf2gs6YMcpOdbkIdcY1VpU6XzRAqkHUKOgygYVLCl0LudBBw3yd2y0ISzjXm5c1oYgPRNxmMAjiSl91olW+6LI5KkZu6g6OrqzllNdkJDlALgZG5gQyhb6h9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=K67Cdn3S; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=zxU1APvI; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=K67Cdn3S; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=zxU1APvI; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 0673433684;
	Tue, 13 Jan 2026 12:44:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1768308286; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3BYnIltIsPKs/CGQ9ft9ry0PJhQG3lj+kfXFjWwd6nw=;
	b=K67Cdn3SOUv93HIrhrEBLx0e+jAmt+RUP97YzIXJfiMe6OR1Zscg+Bv2oc3sW7TJGVdmhx
	xpxoaaBJvhSslfTef2nQYfmO8cjGfob6+nPw8GLzPJ9Z95ZLLcrTpmd0b+lIgvNIqsmFgu
	39HnI9uLTyB+Syha7Lmh7gj6dcdSKGg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1768308286;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3BYnIltIsPKs/CGQ9ft9ry0PJhQG3lj+kfXFjWwd6nw=;
	b=zxU1APvIwO0MBG6S8o6DMZwyJWL1DB6GEtq8WkKNZhXWC2qQ7Y1fvrOXt5fVdsU46gdlUk
	UWXWXL4cR10h93DQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1768308286; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3BYnIltIsPKs/CGQ9ft9ry0PJhQG3lj+kfXFjWwd6nw=;
	b=K67Cdn3SOUv93HIrhrEBLx0e+jAmt+RUP97YzIXJfiMe6OR1Zscg+Bv2oc3sW7TJGVdmhx
	xpxoaaBJvhSslfTef2nQYfmO8cjGfob6+nPw8GLzPJ9Z95ZLLcrTpmd0b+lIgvNIqsmFgu
	39HnI9uLTyB+Syha7Lmh7gj6dcdSKGg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1768308286;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3BYnIltIsPKs/CGQ9ft9ry0PJhQG3lj+kfXFjWwd6nw=;
	b=zxU1APvIwO0MBG6S8o6DMZwyJWL1DB6GEtq8WkKNZhXWC2qQ7Y1fvrOXt5fVdsU46gdlUk
	UWXWXL4cR10h93DQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E3C6B3EA63;
	Tue, 13 Jan 2026 12:44:45 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id GX5lNz0+ZmnoZAAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Tue, 13 Jan 2026 12:44:45 +0000
Message-ID: <2cdff2ed-a45d-47e9-94ef-f8ecd178bbae@suse.cz>
Date: Tue, 13 Jan 2026 13:44:45 +0100
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V6 8/9] mm/slab: move [__]ksize and slab_ksize() to
 mm/slub.c
To: Harry Yoo <harry.yoo@oracle.com>, akpm@linux-foundation.org
Cc: andreyknvl@gmail.com, cl@gentwo.org, dvyukov@google.com,
 glider@google.com, hannes@cmpxchg.org, linux-mm@kvack.org,
 mhocko@kernel.org, muchun.song@linux.dev, rientjes@google.com,
 roman.gushchin@linux.dev, ryabinin.a.a@gmail.com, shakeel.butt@linux.dev,
 surenb@google.com, vincenzo.frascino@arm.com, yeoreum.yun@arm.com,
 tytso@mit.edu, adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
 linux-kernel@vger.kernel.org, cgroups@vger.kernel.org, hao.li@linux.dev
References: <20260113061845.159790-1-harry.yoo@oracle.com>
 <20260113061845.159790-9-harry.yoo@oracle.com>
From: Vlastimil Babka <vbabka@suse.cz>
Content-Language: en-US
In-Reply-To: <20260113061845.159790-9-harry.yoo@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Score: -2.80
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[oracle.com:email,suse.cz:mid,imap1.dmz-prg2.suse.org:helo]
X-Spam-Level: 
X-Spam-Flag: NO

On 1/13/26 7:18 AM, Harry Yoo wrote:
> To access SLUB's internal implementation details beyond cache flags in
> ksize(), move __ksize(), ksize(), and slab_ksize() to mm/slub.c.
> 
> Signed-off-by: Harry Yoo <harry.yoo@oracle.com>
> ---
>  mm/slab.h        | 25 --------------
>  mm/slab_common.c | 61 ----------------------------------
>  mm/slub.c        | 86 ++++++++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 86 insertions(+), 86 deletions(-)
> 
> diff --git a/mm/slab.h b/mm/slab.h
> index 5176c762ec7c..957586d68b3c 100644
> --- a/mm/slab.h
> +++ b/mm/slab.h
> @@ -665,31 +665,6 @@ void kvfree_rcu_cb(struct rcu_head *head);
>  
>  size_t __ksize(const void *objp);
>  
> -static inline size_t slab_ksize(const struct kmem_cache *s)
> -{
> -#ifdef CONFIG_SLUB_DEBUG
> -	/*
> -	 * Debugging requires use of the padding between object
> -	 * and whatever may come after it.
> -	 */
> -	if (s->flags & (SLAB_RED_ZONE | SLAB_POISON))
> -		return s->object_size;
> -#endif
> -	if (s->flags & SLAB_KASAN)
> -		return s->object_size;
> -	/*
> -	 * If we have the need to store the freelist pointer
> -	 * back there or track user information then we can
> -	 * only use the space before that information.
> -	 */
> -	if (s->flags & (SLAB_TYPESAFE_BY_RCU | SLAB_STORE_USER))
> -		return s->inuse;
> -	/*
> -	 * Else we can use all the padding etc for the allocation
> -	 */
> -	return s->size;
> -}
> -
>  static inline unsigned int large_kmalloc_order(const struct page *page)
>  {
>  	return page[1].flags.f & 0xff;
> diff --git a/mm/slab_common.c b/mm/slab_common.c
> index c4cf9ed2ec92..aed91fd6fd10 100644
> --- a/mm/slab_common.c
> +++ b/mm/slab_common.c
> @@ -983,43 +983,6 @@ void __init create_kmalloc_caches(void)
>  						       0, SLAB_NO_MERGE, NULL);
>  }
>  
> -/**
> - * __ksize -- Report full size of underlying allocation
> - * @object: pointer to the object
> - *
> - * This should only be used internally to query the true size of allocations.
> - * It is not meant to be a way to discover the usable size of an allocation
> - * after the fact. Instead, use kmalloc_size_roundup(). Using memory beyond
> - * the originally requested allocation size may trigger KASAN, UBSAN_BOUNDS,
> - * and/or FORTIFY_SOURCE.
> - *
> - * Return: size of the actual memory used by @object in bytes
> - */
> -size_t __ksize(const void *object)

Think it could be also static and not in slab.h? I'll make that change
locally.


