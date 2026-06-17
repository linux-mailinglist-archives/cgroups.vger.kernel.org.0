Return-Path: <cgroups+bounces-17049-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id I4SmGcq1MmqJ4AUAu9opvQ
	(envelope-from <cgroups+bounces-17049-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Wed, 17 Jun 2026 16:57:14 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E93069AB86
	for <lists+cgroups@lfdr.de>; Wed, 17 Jun 2026 16:57:13 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=XgFp1k9P;
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-17049-lists+cgroups=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="cgroups+bounces-17049-lists+cgroups=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 75D503002F75
	for <lists+cgroups@lfdr.de>; Wed, 17 Jun 2026 14:57:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDC4F405C30;
	Wed, 17 Jun 2026 14:57:06 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20FDF44BC97;
	Wed, 17 Jun 2026 14:57:03 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781708226; cv=none; b=XYdTvJYGmS32bHM1dj0vCqVSDLnZI5HLqIKJ5lIXGOaJyXicg4H/pUG47ysxDDQ4krCtv+ltuyQK7r9+7ipvTd23kr4phHDWuJyFIFiNUgVh1Cz/Xq6DSkCJt0pdbTGjEFaL5ed+rS7x+GyetBUHXFVT5dd6pHT6UoLNRFvsvHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781708226; c=relaxed/simple;
	bh=wmM6sI66JIelazf0lQlD2kB+QRS5EgACQWkLhjdJt2g=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=tYDCIIWD3W/DjS4IV+1OxO/ty/keoYBXcJORy3hLo7cmtV8gApCbmOwcmGYzXanljw1uRxA0x7dP9ZKWy/lD8Nbb63eThb9CT45P8ZY/xI0N1t6AqpanI40K7+sqxb/mKuS9b5VAAHe/Cebg5ghjahFMWK5QewjA+u+NdtucJXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XgFp1k9P; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 451D51F000E9;
	Wed, 17 Jun 2026 14:56:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781708223;
	bh=JrfGjOmOPJXcDh++I3CnLLhJP9P9yWCrcpWYJkVADXo=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To;
	b=XgFp1k9P/dScG/0MwNL3xeu3uWnqakesjXiQFGSgyEt3sIBFxG92nv/pZKKSRsUIJ
	 Svg5oTYzHqshNPe6Bf937iNLaGYCcLXOU/owaCO3Fbt3atKKVFEHWIffFo/kUVBWSc
	 rHVvDzp6BrCUbJm6DW9utKp2bLcMSCfO7PxZ4xoNc4hJb/+Yz/zTJuu3mb1iZNCKWH
	 hgGym3kRiqcsOuN+7XR7Av1KKkpGeNaewcK0a6hi3J3BRk+iG9dnywc0jaYn7xGPKJ
	 biElo+NdDsqqsWPFvAnxEU5HW1xnthPmSMu0iXVcWyaUIUj6LcxF14fiPPg7tMw/En
	 F/0DhwG/BRaXg==
Message-ID: <1bf749a4-1519-4d14-a0a7-6d8a56a6c850@kernel.org>
Date: Wed, 17 Jun 2026 16:56:58 +0200
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 14/15] mm/slab: remove __GFP_NO_OBJ_EXT usage from
 alloc_slab_obj_exts()
Content-Language: en-US
From: "Vlastimil Babka (SUSE)" <vbabka@kernel.org>
To: Harry Yoo <harry@kernel.org>
Cc: Hao Li <hao.li@linux.dev>, Christoph Lameter <cl@gentwo.org>,
 David Rientjes <rientjes@google.com>,
 Roman Gushchin <roman.gushchin@linux.dev>,
 Suren Baghdasaryan <surenb@google.com>, Alexei Starovoitov <ast@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>,
 Shakeel Butt <shakeel.butt@linux.dev>,
 Alexander Potapenko <glider@google.com>, Marco Elver <elver@google.com>,
 Dmitry Vyukov <dvyukov@google.com>, kasan-dev@googlegroups.com,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org, cgroups@vger.kernel.org
References: <20260615-slab_alloc_flags-v3-0-ce1146d140fb@kernel.org>
 <20260615-slab_alloc_flags-v3-14-ce1146d140fb@kernel.org>
 <78b67a9b-44e5-4649-957a-9d42bfaa098e@kernel.org>
 <26c29e4b-09b1-424a-b4e4-3358aac20115@kernel.org>
Autocrypt: addr=vbabka@kernel.org; keydata=
 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
In-Reply-To: <26c29e4b-09b1-424a-b4e4-3358aac20115@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:harry@kernel.org,m:hao.li@linux.dev,m:cl@gentwo.org,m:rientjes@google.com,m:roman.gushchin@linux.dev,m:surenb@google.com,m:ast@kernel.org,m:akpm@linux-foundation.org,m:hannes@cmpxchg.org,m:mhocko@kernel.org,m:shakeel.butt@linux.dev,m:glider@google.com,m:elver@google.com,m:dvyukov@google.com,m:kasan-dev@googlegroups.com,m:linux-mm@kvack.org,m:linux-kernel@vger.kernel.org,m:cgroups@vger.kernel.org,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[vbabka@kernel.org,cgroups@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	TAGGED_FROM(0.00)[bounces-17049-lists,cgroups=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vbabka@kernel.org,cgroups@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 5E93069AB86

On 6/17/26 16:36, Vlastimil Babka (SUSE) wrote:
>  
>> With some comments below.
>> 
>> I was worried that perhaps replacing SLAB_ALLOC_NO_RECURSE with
>> __GFP_NO_OBJ_EXT will create a cycle of
>> 
>> alloc_slab_obj_exts(SLAB_ALLOC_DEFAULT)
>> -> kmalloc_flags(SLAB_ALLOC_NO_RECURSE)
>> -> alloc_from_pcs(SLAB_ALLOC_NO_RECURSE)
>> -> refill_objects(SLAB_ALLOC_DEFAULT)
>> -> new_slab(SLAB_ALLOC_DEFAULT)
>> -> account_slab(SLAB_ALLOC_DEFAULT)
>> -> alloc_slab_obj_exts(SLAB_ALLOC_DEFAULT)
>> 
>> with __GFP_NO_OBJ_EXT, it would have been passed to refill_objects(),
>> but SLAB_ALLOC_NO_RECURSE is not. However this cycle does not exist
>> because alloc_slab_obj_exts() clears __GFP_ACCOUNT (as part of
>> OBJCG_CLEAR_MASK) and memory profiling itself does not invoke
>> alloc_slab_obj_exts() when allocating new slabs if SLAB_ACCOUNT is not
>> set (which is interesting, by the way).
> 
> Hm yeah I think we should propagate alloc_flags to refill_objects() etc, to 
> avoid later surprise. But can be done as a later cleanup.

It's also not a new hazard I think because while previously gfp flags with
__GFP_NO_OBJ_EXT would could be propagated more thoroughly than alloc_flags
for obj_exts only __alloc_tagging_slab_alloc_hook() looks at them, and
alloc_slab_obj_exts() (from account_slab()) didn't either, so the amount of
(finite) recursion is the same I think.

>> Also alloc_slab_obj_exts() propagating SLAB_ALLOC_NEW_SLAB to
>> kmalloc_flags() is little bit confusing because it does not have any
>> effect due to SLAB_ALLOC_NO_RECURSE.
> 
> OK let's address this one by this fixup:
> 
> diff --git a/mm/slub.c b/mm/slub.c
> index fc5b8c85b690..dc4b4ae874ce 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -2164,6 +2164,7 @@ int alloc_slab_obj_exts(struct slab *slab, struct kmem_cache *s,
>  {
>  	const bool allow_spin = alloc_flags_allow_spinning(alloc_flags);
>  	unsigned int objects = objs_per_slab(s, slab);
> +	bool new_slab = alloc_flags & SLAB_ALLOC_NEW_SLAB;
>  	unsigned long new_exts;
>  	unsigned long old_exts;
>  	struct slabobj_ext *vec;
> @@ -2173,6 +2174,7 @@ int alloc_slab_obj_exts(struct slab *slab, struct kmem_cache *s,
>  	/* Prevent recursive extension vector allocation */
>  	gfp |= __GFP_NO_OBJ_EXT;
>  	alloc_flags |= SLAB_ALLOC_NO_RECURSE;
> +	alloc_flags &= ~SLAB_ALLOC_NEW_SLAB;
>  
>  	sz = obj_exts_alloc_size(s, slab, gfp);
>  
> @@ -2203,7 +2205,7 @@ int alloc_slab_obj_exts(struct slab *slab, struct kmem_cache *s,
>  	old_exts = READ_ONCE(slab->obj_exts);
>  	handle_failed_objexts_alloc(old_exts, vec, objects);
>  
> -	if (alloc_flags & SLAB_ALLOC_NEW_SLAB) {
> +	if (new_slab) {
>  		/*
>  		 * If the slab is brand new and nobody can yet access its
>  		 * obj_exts, no synchronization is required and obj_exts can
> 


