Return-Path: <cgroups+bounces-16128-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gE5DJZG1DWrC2QUAu9opvQ
	(envelope-from <cgroups+bounces-16128-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Wed, 20 May 2026 15:22:25 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 999DD58EB25
	for <lists+cgroups@lfdr.de>; Wed, 20 May 2026 15:22:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 246453041FEF
	for <lists+cgroups@lfdr.de>; Wed, 20 May 2026 13:20:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8B7D39DBD6;
	Wed, 20 May 2026 13:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ll5IJNSF"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 284813CBE71
	for <cgroups@vger.kernel.org>; Wed, 20 May 2026 13:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779283228; cv=none; b=BGQAS9sycEX4fCAfPj8k1Nz3ePIcHcPbM3PfTyQmIIMuEFLAIvvEAGeOjemM+mRhg2OG5eN3gIJ840w+4hgfZ9T0/oFbqY7y/LWbGgaQsOVrRt3UKUIbPgRUFYuvBoH5s9+ke9SIczfJiAhSSeFN4UxHDcMmIBjcmkY977NHoCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779283228; c=relaxed/simple;
	bh=LJ46FUNvspi004sp1Zosl6Ca/D5nqgWvLAw6LZ+5iFE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=P88A9MjBRnOcMeV553HvlmOJ/rrRWfq5DhlBuKnEsTiO/5vGWQyJoAnRhhG0pmgH3JukDszR2aqYjgd9H44Uv+HDqZ9UN5xtYkHW7xHgRNQ/2pbjRcNiO82asVUxAXtf9VZd7KkvRvD1K6yNs7g0RhHe26LYq7Rild5wNL2oyv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ll5IJNSF; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-48e8132c6d0so32373935e9.1
        for <cgroups@vger.kernel.org>; Wed, 20 May 2026 06:20:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779283225; x=1779888025; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NglNKIPq1qLVfrKsWY3QACNOviMl7btMLa/RT1SC8Fg=;
        b=Ll5IJNSFp8qndSdp47Vk33Jf8bpUNQ43Gb7bugwCQ89S7mapnnQq2Tx6YuvOBU+6+U
         PFCvlKw1lMSvjdh0n71ZyGZhtmvqn8ktkpdJ4NA3CMBLrVL+8j80Odv5u50qvWeqxrz/
         cWCA4o8d9oLkdcKD+Efalb5DRNb3/6S7d8eRhCzg7SFSKR9f5Y6GfYY1nusu0Wrl0pZT
         5gBQ6+GHBnDocgvaiLuLFTx92dkm+SJ0udHDUiW8IRtKGTiNma6cAK5kh/c0qhILZsCH
         nTh8/Oyxdr5nOXWpZiYDXncJ8twFTcVh0CDUxnYBlTBOX+gPREB18V2GInlReYCo3OUR
         ICEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779283225; x=1779888025;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=NglNKIPq1qLVfrKsWY3QACNOviMl7btMLa/RT1SC8Fg=;
        b=s8VWlo5o2tw5fBTuOQcv2yVT46SqOYhQhjzcaXYjDxxy3mb+ZIswLoN3g3IbgytyTC
         WoH4Hw4C64cI2+ay8Udtnajxiv7rHkUcI8qJ3ZC9xRcPV7WFAWW7RD8nBa1ExqmNArdv
         YAZjp/41GFmRdnOdlOYYAcgiGUCz0S9Jf+vLCB9EsVXzUSivso5jpqBMabumS7R8F6jf
         3Oy08I0eIhWC6LgRYA2ra0LvfdaxF8/ehpHuILW/lUt0FyhA4abf7Hh9/kYFzCSXMNwO
         Eq0ggAX/whqVGxQGTZD1OrggFzCZ7YVR76rbRM511tlAMOitAviPd4Cu2fEtLhN6yk72
         5IPA==
X-Forwarded-Encrypted: i=1; AFNElJ9ZQD+f8wKLYxN8QAfCRk9QwZkKW3y5xskwT57aUZby++V7oP5wGWTKLOszzeJKmvBdeXZP99lF@vger.kernel.org
X-Gm-Message-State: AOJu0YwpHroTP+3IW9jyPBEtqGYh/GC98kzCUv7Ol3tRJo6nSdmPsy7+
	s7VgqrrckoO6DM5/QOB8Ndj2O09UVva3Q0Gde6UbEDHfEdm15pZV6pNP
X-Gm-Gg: Acq92OHAaaXCtHJ5SG34cHTGNHeuAZCtHIPWQHBmGp1k6xmOGi7iTwZCEhq4LVlBfti
	TTMYBVbNGn5ylSdHVFtmkqrg4SbdL/vNXWrQCY8sIVtIBbIZZbWeeVJCLHLcBIOdwakSxMT2sj+
	A75jni/a56FtJx72JV7+XZyPV9iJCqQ31rL/kRlPnmivC+aa83i9SvRmWmgwi8FkHfNJ3o1dig7
	QDifYNgZrBcNamxpu0aWy0avfQJG2CKAmB/WRHMYTBxJRJ4LPJIvcDACMGArFSDBn8Kol2JwlSy
	1RqJE0jZKz+w/QHUt47RFLJ5pzCQ+M1Sx6lC1ZIVSPOs1aRrUshz7ncZfaZJgJdKmxb/PkpjiZ9
	buYWQS7dCxL4qTa71oFrjWz+86VssIF6rPnbe8O1VyE2AE3G8GJZuxoG+xLozXSrrccrQS9FRen
	DJxWEesdAcTw6RH62ENpEfDwBsDUrOGNTp/6CpDDuLuBNmxcRZUPhSQlLWVwwAAIZn
X-Received: by 2002:a05:600c:470e:b0:48d:361:4df6 with SMTP id 5b1f17b1804b1-48fe60eabbcmr353411015e9.9.1779283225112;
        Wed, 20 May 2026 06:20:25 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48fe4dac000sm406738105e9.0.2026.05.20.06.20.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 May 2026 06:20:24 -0700 (PDT)
Date: Wed, 20 May 2026 14:20:23 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: Andrew Morton <akpm@linux-foundation.org>, Johannes Weiner
 <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>, Roman Gushchin
 <roman.gushchin@linux.dev>, Muchun Song <muchun.song@linux.dev>, Qi Zheng
 <qi.zheng@linux.dev>, Alexandre Ghiti <alex@ghiti.fr>, Joshua Hahn
 <joshua.hahnjy@gmail.com>, Harry Yoo <harry@kernel.org>, Meta kernel team
 <kernel-team@meta.com>, linux-mm@kvack.org, cgroups@vger.kernel.org,
 linux-kernel@vger.kernel.org, kernel test robot <oliver.sang@intel.com>
Subject: Re: [PATCH 2/4] memcg: uint16_t for nr_bytes in obj_stock_pcp
Message-ID: <20260520142023.6eae5ec7@pumpkin>
In-Reply-To: <20260520053123.2709959-3-shakeel.butt@linux.dev>
References: <20260520053123.2709959-1-shakeel.butt@linux.dev>
	<20260520053123.2709959-3-shakeel.butt@linux.dev>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-16128-lists,cgroups=lfdr.de];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[15];
	FREEMAIL_CC(0.00)[linux-foundation.org,cmpxchg.org,kernel.org,linux.dev,ghiti.fr,gmail.com,meta.com,kvack.org,vger.kernel.org,intel.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[davidlaightlinux@gmail.com,cgroups@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:email,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,intel.com:email]
X-Rspamd-Queue-Id: 999DD58EB25
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, 19 May 2026 22:31:20 -0700
Shakeel Butt <shakeel.butt@linux.dev> wrote:

> Currently struct obj_stock_pcp stores nr_bytes in an 'unsigned int'
> which is 4 bytes on 64-bit machines. Switch the field to uint16_t to
> shrink the per-CPU cache.
> 
> The kernel supports PAGE_SIZE_4KB, _8KB, _16KB, _32KB, _64KB and
> _256KB (see HAVE_PAGE_SIZE_* in arch/Kconfig). After the
> PAGE_SIZE-aligned flush in __refill_obj_stock(), the sub-page
> remainder fits in uint16_t up through 64KiB pages where PAGE_SIZE - 1
> == U16_MAX, but on 256KiB pages PAGE_SIZE - 1 == 0x3FFFF exceeds
> U16_MAX. The accumulator also needs to stay within uint16_t between
> page-aligned flushes on 64KiB pages where PAGE_SIZE itself is
> U16_MAX + 1.
> 
> Accumulate the new total in an 'unsigned int' local, then:
> 
>   1. Flush whenever the accumulator would hit U16_MAX. Together with
>      the existing allow_uncharge flush at PAGE_SIZE, this keeps the
>      uint16_t safe on PAGE_SIZE <= 64KiB.
> 
>   2. On configs with PAGE_SHIFT > 16 (PAGE_SIZE_256KB on hexagon and
>      powerpc 44x), push any sub-page remainder above U16_MAX into
>      objcg->nr_charged_bytes via atomic_add before storing back, so
>      the store cannot silently truncate. The PAGE_SHIFT > 16 guard
>      folds the branch out at compile time on smaller page sizes.
> 
> Signed-off-by: Shakeel Butt <shakeel.butt@linux.dev>
> Tested-by: kernel test robot <oliver.sang@intel.com>
> ---
>  mm/memcontrol.c | 33 +++++++++++++++++++++++++++------
>  1 file changed, 27 insertions(+), 6 deletions(-)
> 
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index d7c162946719..b3d63d9f267c 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -2019,7 +2019,7 @@ static DEFINE_PER_CPU_ALIGNED(struct memcg_stock_pcp, memcg_stock) = {
>  
>  struct obj_stock_pcp {
>  	local_trylock_t lock;
> -	unsigned int nr_bytes;
> +	uint16_t nr_bytes;
>  	struct obj_cgroup *cached_objcg;
>  	int16_t node_id;

You might want to move it to this hole.
The size of 'lock' depends on kernel build options.

-- David

>  	int nr_slab_reclaimable_b;
> @@ -3331,6 +3331,7 @@ static void __refill_obj_stock(struct obj_cgroup *objcg,
>  			       bool allow_uncharge)
>  {
>  	unsigned int nr_pages = 0;
> +	unsigned int stock_nr_bytes;
>  
>  	if (!stock) {
>  		nr_pages = nr_bytes >> PAGE_SHIFT;
> @@ -3339,21 +3340,41 @@ static void __refill_obj_stock(struct obj_cgroup *objcg,
>  		goto out;
>  	}
>  
> +	stock_nr_bytes = stock->nr_bytes;
>  	if (READ_ONCE(stock->cached_objcg) != objcg) { /* reset if necessary */
>  		drain_obj_stock(stock);
>  		obj_cgroup_get(objcg);
> -		stock->nr_bytes = atomic_read(&objcg->nr_charged_bytes)
> +		stock_nr_bytes = atomic_read(&objcg->nr_charged_bytes)
>  				? atomic_xchg(&objcg->nr_charged_bytes, 0) : 0;
>  		WRITE_ONCE(stock->cached_objcg, objcg);
>  
>  		allow_uncharge = true;	/* Allow uncharge when objcg changes */
>  	}
> -	stock->nr_bytes += nr_bytes;
> +	stock_nr_bytes += nr_bytes;
> +
> +	/* Since stock->nr_bytes is uint16_t, don't refill >= U16_MAX */
> +	if ((allow_uncharge && (stock_nr_bytes > PAGE_SIZE)) ||
> +	    stock_nr_bytes >= U16_MAX) {
> +		nr_pages = stock_nr_bytes >> PAGE_SHIFT;
> +		stock_nr_bytes &= (PAGE_SIZE - 1);
> +
> +		/*
> +		 * On configs with PAGE_SHIFT > 16 (PAGE_SIZE_256KB on
> +		 * hexagon and powerpc 44x), the sub-page remainder can
> +		 * still exceed U16_MAX. Push the excess back to
> +		 * objcg->nr_charged_bytes so the store into uint16_t
> +		 * cannot silently truncate; folded out at compile time
> +		 * on smaller page sizes.
> +		 */
> +		if (PAGE_SHIFT > 16 && stock_nr_bytes > U16_MAX) {
> +			unsigned int kept = stock_nr_bytes & U16_MAX;
>  
> -	if (allow_uncharge && (stock->nr_bytes > PAGE_SIZE)) {
> -		nr_pages = stock->nr_bytes >> PAGE_SHIFT;
> -		stock->nr_bytes &= (PAGE_SIZE - 1);
> +			atomic_add(stock_nr_bytes - kept,
> +				   &objcg->nr_charged_bytes);
> +			stock_nr_bytes = kept;
> +		}
>  	}
> +	stock->nr_bytes = stock_nr_bytes;
>  
>  out:
>  	if (nr_pages)


