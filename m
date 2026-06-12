Return-Path: <cgroups+bounces-16881-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 3D/IAUd7K2qG+QMAu9opvQ
	(envelope-from <cgroups+bounces-16881-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Fri, 12 Jun 2026 05:21:43 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 85EAF6766A2
	for <lists+cgroups@lfdr.de>; Fri, 12 Jun 2026 05:21:42 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linux.dev header.s=key1 header.b=IF6AbNNJ;
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-16881-lists+cgroups=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="cgroups+bounces-16881-lists+cgroups=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linux.dev;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 8DD3F30055A2
	for <lists+cgroups@lfdr.de>; Fri, 12 Jun 2026 03:21:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CF3C311C15;
	Fri, 12 Jun 2026 03:21:30 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from out-188.mta1.migadu.com (out-188.mta1.migadu.com [95.215.58.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 078582F7EF3
	for <cgroups@vger.kernel.org>; Fri, 12 Jun 2026 03:21:28 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781234490; cv=none; b=hIO37s5a3IuL56ZpwhY56q6+NCRSywB6Cy6y8yA5RLkBKvfrrxu50MhYJcXTrK8ac+TaTxSD4qts+FiUkK1CQoDfHhOjHEg4sEgyxOWUkJf2ltysNNWRdPMG0wdUhUrxUlp90ANSU3HuhX81sgh9mST1Cpj9J3P3apLzyUWO3lo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781234490; c=relaxed/simple;
	bh=IUXY3T9zSokWlbDpMrr33UGRZSEdPLQmiGZGDwooAGk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Isxi/mVc0zu+RUV3BuphUb+Q71pOaaB8q6WKoeuc10iUGNGvJs7GOWJtNG3RIukPMF/qBKMlnqrlJIrYH5a1fu46Br5GCOv4bVVbDWmOLk439beX/iXN2mdnrzq+xL81Ub3h1wUwVBDb+tnyp6GCToMpQN5+w+48Jj4NYma05Gw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=IF6AbNNJ; arc=none smtp.client-ip=95.215.58.188
Date: Fri, 12 Jun 2026 11:21:00 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1781234476;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ucOrcwvIS+R+Z2bG2Pdy61JNFx4i3uJGRkqwOfdveDc=;
	b=IF6AbNNJHEumf0qjYw2tthCa+czfyc1aIgni5OFaOiCD49/mZS3SB6JyVpu9M5JP4hQVZt
	jcn//NZ4eF8E5u1xIAjVJqx4YcwIc7Zc5P8iCHQrMfmdHMfjVhXzRi5tTpU3QkpEi2je/c
	PtxQ/itq38gOnr74PMWrSAWGdwET3pg=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Hao Li <hao.li@linux.dev>
To: "Vlastimil Babka (SUSE)" <vbabka@kernel.org>
Cc: Harry Yoo <harry@kernel.org>, Christoph Lameter <cl@gentwo.org>, 
	David Rientjes <rientjes@google.com>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Suren Baghdasaryan <surenb@google.com>, Alexei Starovoitov <ast@kernel.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Johannes Weiner <hannes@cmpxchg.org>, 
	Michal Hocko <mhocko@kernel.org>, Shakeel Butt <shakeel.butt@linux.dev>, 
	Alexander Potapenko <glider@google.com>, Marco Elver <elver@google.com>, 
	Dmitry Vyukov <dvyukov@google.com>, kasan-dev@googlegroups.com, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, cgroups@vger.kernel.org
Subject: Re: [PATCH v2 11/16] mm/slab: allow kmem_cache_alloc_bulk() with any
 gfp flags
Message-ID: <ait6ojueVi38-s85@fedora>
References: <20260610-slab_alloc_flags-v2-0-7190909db118@kernel.org>
 <20260610-slab_alloc_flags-v2-11-7190909db118@kernel.org>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260610-slab_alloc_flags-v2-11-7190909db118@kernel.org>
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:vbabka@kernel.org,m:harry@kernel.org,m:cl@gentwo.org,m:rientjes@google.com,m:roman.gushchin@linux.dev,m:surenb@google.com,m:ast@kernel.org,m:akpm@linux-foundation.org,m:hannes@cmpxchg.org,m:mhocko@kernel.org,m:shakeel.butt@linux.dev,m:glider@google.com,m:elver@google.com,m:dvyukov@google.com,m:kasan-dev@googlegroups.com,m:linux-mm@kvack.org,m:linux-kernel@vger.kernel.org,m:cgroups@vger.kernel.org,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[hao.li@linux.dev,cgroups@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	RCVD_COUNT_THREE(0.00)[3];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-16881-lists,cgroups=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hao.li@linux.dev,cgroups@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.dev:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[fedora:mid,vger.kernel.org:from_smtp,linux.dev:dkim,linux.dev:from_mime,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 85EAF6766A2

On Wed, Jun 10, 2026 at 05:40:13PM +0200, Vlastimil Babka (SUSE) wrote:
> The last user of gfpflags_allow_spinning() in slab is
> alloc_from_pcs_bulk(), which is only called from
> kmem_cache_alloc_bulk().
> 
> It turns out that gfpflags_allow_spinning() is not necessary, because
> kmem_cache_alloc_bulk() is only expected to be called from context that
> does allow spinning, so simply replace it with 'true'.
> 
> With that, we can remove the "@flags must allow spinning" part of the
> kernel doc, as there is no more connection to the gfp flags in the slab
> implementation.
> 
> Also remove a comment in alloc_slab_obj_exts() because there should be
> no more false positives possible due to gfp_allowed_mask during early
> boot.
> 
> Signed-off-by: Vlastimil Babka (SUSE) <vbabka@kernel.org>
> ---
>  mm/slub.c | 11 ++---------
>  1 file changed, 2 insertions(+), 9 deletions(-)
> 
> diff --git a/mm/slub.c b/mm/slub.c
> index 0b9974bfcb24..ef457e07db83 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -2171,12 +2171,6 @@ int alloc_slab_obj_exts(struct slab *slab, struct kmem_cache *s,
>  
>  	sz = obj_exts_alloc_size(s, slab, gfp);
>  
> -	/*
> -	 * Note that allow_spin may be false during early boot and its
> -	 * restricted GFP_BOOT_MASK. Due to kmalloc_nolock() only supporting
> -	 * architectures with cmpxchg16b, early obj_exts will be missing for
> -	 * very early allocations on those.
> -	 */
>  	if (unlikely(!allow_spin))
>  		vec = kmalloc_nolock(sz, __GFP_ZERO | __GFP_NO_OBJ_EXT,
>  				     slab_nid(slab));
> @@ -4867,7 +4861,7 @@ unsigned int alloc_from_pcs_bulk(struct kmem_cache *s, gfp_t gfp, size_t size,
>  		}
>  
>  		full = barn_replace_empty_sheaf(barn, pcs->main,
> -						gfpflags_allow_spinning(gfp));
> +						/* allow_spin = */ true);

we can remove the `gfp` arg as this function no longer use it.

>  
>  		if (full) {
>  			stat(s, BARN_GET);
> @@ -7333,8 +7327,7 @@ static bool __kmem_cache_alloc_bulk(struct kmem_cache *s, gfp_t flags,
>   * Allocate @size objects from @s and places them into @p.  @size must be larger
>   * than 0.
>   *
> - * Interrupts must be enabled when calling this function and @flags must allow
> - * spinning.
> + * Interrupts must be enabled when calling this function.
>   *
>   * Unlike alloc_pages_bulk(), this function does not check for already allocated
>   * objects in @p, and thus the caller does not need to zero it.
> 
> -- 
> 2.54.0
> 

