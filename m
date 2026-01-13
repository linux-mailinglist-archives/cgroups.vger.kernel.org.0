Return-Path: <cgroups+bounces-13155-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 120C1D1921F
	for <lists+cgroups@lfdr.de>; Tue, 13 Jan 2026 14:42:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8818C3021FB6
	for <lists+cgroups@lfdr.de>; Tue, 13 Jan 2026 13:42:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5BD13904E0;
	Tue, 13 Jan 2026 13:42:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="nGoKTJWe";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="E2Mp9Ca3";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="nGoKTJWe";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="E2Mp9Ca3"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C54A18B0A
	for <cgroups@vger.kernel.org>; Tue, 13 Jan 2026 13:42:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768311739; cv=none; b=c24RAIrQEqiCaprhtjLzSQdb/9fBN53qJXp4I5XsRiKcT+psWhQg1lCgprqdsdEDaC12kRuhc4xk6xt5/DAKvKJbq1vIXvgn2ukrB/grIvx29U05z3gyWHnhWL9lDO5bgL4DPm3XI8QPBTEdKRgY3ixC6WeROh2hy+MoFuHPcIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768311739; c=relaxed/simple;
	bh=yJmHBOxPz6h3xJmYlyrKbgmqu9NFwRtfe6wRVSzsdo8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pZQANEwFjL1rtPTddo3CkIpmWOztbUVe+cilYSyERES+00ymQuvUk9ErVCjD+XzF27Npr+pARgyoZLwVrhxkCvsQw/ja+zfN8jEulzVVzeam6E2CJ0JktLUW/1FR6aIrCrj3pCMNYTtbu8+Xi2pUF65cZQpZ4RdruR+KKSr3cDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=nGoKTJWe; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=E2Mp9Ca3; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=nGoKTJWe; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=E2Mp9Ca3; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id AD85A33684;
	Tue, 13 Jan 2026 13:42:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1768311736; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/TzvRGR1KE9XUBBxJVkEgxb8mxuBXEejZtD+0orpA3o=;
	b=nGoKTJWeEC3lBzosfNcmG5WjK2mWcV/6C0RsBD8KtQF7130YkGviQ9Bxhy2wwkn9qGEeYL
	1F7C8LV6t0hj2OxqRZAOpvVy1mxP+RgV3EQD7raUwTk1wo4ESiwcHlmaNL0gDmhSlqrDUv
	dM9kpE8HhuAgnj2gqmWeR/NSK0yFQBA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1768311736;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/TzvRGR1KE9XUBBxJVkEgxb8mxuBXEejZtD+0orpA3o=;
	b=E2Mp9Ca3a+CLu011DZYGuRHUPra97yCY2tLLxJZjgCZA6NiJajt58DKE83fdGYfizA1kAB
	qXpIZO0Nq7MIWLBg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1768311736; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/TzvRGR1KE9XUBBxJVkEgxb8mxuBXEejZtD+0orpA3o=;
	b=nGoKTJWeEC3lBzosfNcmG5WjK2mWcV/6C0RsBD8KtQF7130YkGviQ9Bxhy2wwkn9qGEeYL
	1F7C8LV6t0hj2OxqRZAOpvVy1mxP+RgV3EQD7raUwTk1wo4ESiwcHlmaNL0gDmhSlqrDUv
	dM9kpE8HhuAgnj2gqmWeR/NSK0yFQBA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1768311736;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/TzvRGR1KE9XUBBxJVkEgxb8mxuBXEejZtD+0orpA3o=;
	b=E2Mp9Ca3a+CLu011DZYGuRHUPra97yCY2tLLxJZjgCZA6NiJajt58DKE83fdGYfizA1kAB
	qXpIZO0Nq7MIWLBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 93F993EA63;
	Tue, 13 Jan 2026 13:42:16 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id yXfsI7hLZmmXHwAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Tue, 13 Jan 2026 13:42:16 +0000
Message-ID: <7475bece-04e0-43a1-8e0b-4af191c004f0@suse.cz>
Date: Tue, 13 Jan 2026 14:42:16 +0100
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V6 9/9] mm/slab: place slabobj_ext metadata in unused
 space within s->size
To: Harry Yoo <harry.yoo@oracle.com>
Cc: akpm@linux-foundation.org, andreyknvl@gmail.com, cl@gentwo.org,
 dvyukov@google.com, glider@google.com, hannes@cmpxchg.org,
 linux-mm@kvack.org, mhocko@kernel.org, muchun.song@linux.dev,
 rientjes@google.com, roman.gushchin@linux.dev, ryabinin.a.a@gmail.com,
 shakeel.butt@linux.dev, surenb@google.com, vincenzo.frascino@arm.com,
 yeoreum.yun@arm.com, tytso@mit.edu, adilger.kernel@dilger.ca,
 linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
 cgroups@vger.kernel.org, hao.li@linux.dev
References: <20260113061845.159790-1-harry.yoo@oracle.com>
 <20260113061845.159790-10-harry.yoo@oracle.com>
 <fecd4166-618d-4d69-be02-d9b3e8f0f271@suse.cz> <aWZCHIYsFSaGzRYu@hyeyoo>
 <aWZJWkbosy9A_XBD@hyeyoo>
Content-Language: en-US
From: Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <aWZJWkbosy9A_XBD@hyeyoo>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
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
	FREEMAIL_CC(0.00)[linux-foundation.org,gmail.com,gentwo.org,google.com,cmpxchg.org,kvack.org,kernel.org,linux.dev,arm.com,mit.edu,dilger.ca,vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.cz:mid]
X-Spam-Flag: NO
X-Spam-Score: -2.80
X-Spam-Level: 

On 1/13/26 2:32 PM, Harry Yoo wrote:
> On Tue, Jan 13, 2026 at 10:01:16PM +0900, Harry Yoo wrote:
>> On Tue, Jan 13, 2026 at 01:50:31PM +0100, Vlastimil Babka wrote:
>>> On 1/13/26 7:18 AM, Harry Yoo wrote:
>>>
>>> Does this look OK to you or was there a reason you didn't do it? :)
>>>
>>> diff --git a/mm/slub.c b/mm/slub.c
>>> index ba15df4ca417..deb69bd9646a 100644
>>> --- a/mm/slub.c
>>> +++ b/mm/slub.c
>>> @@ -981,8 +981,7 @@ static inline bool obj_exts_in_slab(struct kmem_cache *s, struct slab *slab)
>>>  #if defined(CONFIG_SLAB_OBJ_EXT) && defined(CONFIG_64BIT)
>>>  static bool obj_exts_in_object(struct kmem_cache *s, struct slab *slab)
>>>  {
>>> -       return obj_exts_in_slab(s, slab) &&
>>> -              (slab_get_stride(slab) == s->size);
>>> +       return obj_exts_in_slab(s, slab) && (s->flags & SLAB_OBJ_EXT_IN_OBJ);
>>
>> There was a reason why I didn't do it :)
>>
>> In alloc_slab_obj_exts_early(), when both
>> obj_exts_fit_within_slab_leftover() and (s->flags & SLAB_OBJ_EXT_IN_OBJ)
>> returns true, it allocates the metadata from the slab's leftover space.
>>
>> I noticed it as I saw a slab error in slab_pad_check() complaining that
>> the padding area was overwritten, but turned out the problem was
>> because obj_exts_in_object() returning true when it shouldn't.
> 
> Perhaps a comment like this?
> 
> diff --git a/mm/slub.c b/mm/slub.c
> index ba15df4ca417..c40c3559039e 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -981,6 +981,15 @@ static inline bool obj_exts_in_slab(struct kmem_cache *s, struct slab *slab)
>  #if defined(CONFIG_SLAB_OBJ_EXT) && defined(CONFIG_64BIT)
>  static bool obj_exts_in_object(struct kmem_cache *s, struct slab *slab)
>  {
> +	/*
> +	 * When SLAB_OBJ_EXT_IN_OBJ is set, slabobj_ext metadata can be stored
> +	 * in one of two ways:
> +	 * 1. As an array in the slab's leftover space (after the last object)
> +	 * 2. Inline with each object (within s->size)
> +	 *
> +	 * The actual placement is determined by the stride size rather than
> +	 * the SLAB_OBJ_EXT_IN_OBJ flag itself.
> +	 */
>  	return obj_exts_in_slab(s, slab) &&
>  	       (slab_get_stride(slab) == s->size);
>  }

I meanwhile wrote this one. I think the part about depending on slab's size
is important so one doesn't wonder why we don't simply clear SLAB_OBJ_EXT_IN_OBJ
if it fits within_slab_leftover. As discussed off-list, will use it. Thanks!

--- a/mm/slub.c
+++ b/mm/slub.c
@@ -981,6 +981,12 @@ static inline bool obj_exts_in_slab(struct kmem_cache *s, struct slab *slab)
 #if defined(CONFIG_SLAB_OBJ_EXT) && defined(CONFIG_64BIT)
 static bool obj_exts_in_object(struct kmem_cache *s, struct slab *slab)
 {
+       /*
+        * Note we cannot rely on the SLAB_OBJ_EXT_IN_OBJ flag here and need to
+        * check the stride. A cache can have SLAB_OBJ_EXT_IN_OBJ set, but
+        * allocations within_slab_leftover are preferred. And those may be
+        * possible or not depending on the particular slab's size.
+        */
        return obj_exts_in_slab(s, slab) &&
               (slab_get_stride(slab) == s->size);
 }


