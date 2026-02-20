Return-Path: <cgroups+bounces-14074-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OOKwFr3bmGmTNgMAu9opvQ
	(envelope-from <cgroups+bounces-14074-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Fri, 20 Feb 2026 23:10:05 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BD89816B1DC
	for <lists+cgroups@lfdr.de>; Fri, 20 Feb 2026 23:10:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DD802303131B
	for <lists+cgroups@lfdr.de>; Fri, 20 Feb 2026 22:09:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1538E30F931;
	Fri, 20 Feb 2026 22:09:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="GTyA4VOW"
X-Original-To: cgroups@vger.kernel.org
Received: from out-186.mta0.migadu.com (out-186.mta0.migadu.com [91.218.175.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 570392FF153
	for <cgroups@vger.kernel.org>; Fri, 20 Feb 2026 22:09:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771625386; cv=none; b=chhdmg7n2EfnU/c2XcJ77n6ZF0KS2xZgGjR1yngdTvzRiYsarvYrHCPS+bTF2n+X6CVdpKRcfuKkmA2USKV2Hjo0suzESPAmPewfZav0OXanUMwS2w3fA4yABBBrvV+UMa4KzjNsTJ2R/0oy1PBYAu8I9PdtJWS1x1jNoOmjVR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771625386; c=relaxed/simple;
	bh=S+0Y6DfpwFix6vlxsNRVx7ARwV3j9KnXOSbZXeyKeBU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b4ozZTznX22bmQ+guGILRGRFrjMaqlHSjP7aLYkEpGAjhYbt9VYABIUrYoIR5qK8x4EA+ch2uONH/7JmSa9TeZEweTbstJQd18d/rdB5oJ/hBPVBeJbZZk1GCbnX+RJvIdr3v8FdNtuMwRWznBmUxwOy1ATNyfw64kMmwr0jKn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=GTyA4VOW; arc=none smtp.client-ip=91.218.175.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Fri, 20 Feb 2026 14:09:28 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1771625373;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=bMcpQEUmQPBfSHE/XsFFGAO79A7tRmTzeXgyD6t0vqU=;
	b=GTyA4VOWkcp/D3+UgQRVXcg0nUbDJZuVwMWrhkq8xt2zoFpEYEYArzx40OrtD3f+yFGrSu
	q/skB1MhRSv5lfsszeTX172W2sdttYgXZoh6DGEM6hqJMHhzotH2TexkLuio74cY71uc32
	ctHmYlWTLWgvZsdzpTgRLwORojKBBLo=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Johannes Weiner <hannes@cmpxchg.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	Uladzislau Rezki <urezki@gmail.com>, Joshua Hahn <joshua.hahnjy@gmail.com>, 
	Michal Hocko <mhocko@suse.com>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Muchun Song <muchun.song@linux.dev>, linux-mm@kvack.org, cgroups@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] mm: vmalloc: streamline vmalloc memory accounting
Message-ID: <aZjaxAi-AzyOYzNT@linux.dev>
References: <20260220191035.3703800-1-hannes@cmpxchg.org>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260220191035.3703800-1-hannes@cmpxchg.org>
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[linux-foundation.org,gmail.com,suse.com,linux.dev,kvack.org,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-14074-lists,cgroups=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linux.dev:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[shakeel.butt@linux.dev,cgroups@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: BD89816B1DC
X-Rspamd-Action: no action

On Fri, Feb 20, 2026 at 02:10:34PM -0500, Johannes Weiner wrote:
[...]
>  static struct vmap_area *__find_vmap_area(unsigned long addr, struct rb_root *root)
>  {
>  	struct rb_node *n = root->rb_node;
> @@ -3463,11 +3457,11 @@ void vfree(const void *addr)
>  		 * High-order allocs for huge vmallocs are split, so
>  		 * can be freed as an array of order-0 allocations
>  		 */
> +		if (!(vm->flags & VM_MAP_PUT_PAGES))
> +			dec_node_page_state(page, NR_VMALLOC);
>  		__free_page(page);
>  		cond_resched();
>  	}
> -	if (!(vm->flags & VM_MAP_PUT_PAGES))
> -		atomic_long_sub(vm->nr_pages, &nr_vmalloc_pages);
>  	kvfree(vm->pages);
>  	kfree(vm);
>  }
> @@ -3655,6 +3649,8 @@ vm_area_alloc_pages(gfp_t gfp, int nid,
>  			continue;
>  		}
>  
> +		mod_node_page_state(page, NR_VMALLOC, 1 << large_order);

mod_node_page_state() takes 'struct pglist_data *pgdat', you need to use
page_pgdat(page) as first param.

> +
>  		split_page(page, large_order);
>  		for (i = 0; i < (1U << large_order); i++)
>  			pages[nr_allocated + i] = page + i;
> @@ -3675,6 +3671,7 @@ vm_area_alloc_pages(gfp_t gfp, int nid,
>  	if (!order) {
>  		while (nr_allocated < nr_pages) {
>  			unsigned int nr, nr_pages_request;
> +			int i;
>  
>  			/*
>  			 * A maximum allowed request is hard-coded and is 100
> @@ -3698,6 +3695,9 @@ vm_area_alloc_pages(gfp_t gfp, int nid,
>  							nr_pages_request,
>  							pages + nr_allocated);
>  
> +			for (i = nr_allocated; i < nr_allocated + nr; i++)
> +				inc_node_page_state(pages[i], NR_VMALLOC);
> +
>  			nr_allocated += nr;
>  
>  			/*
> @@ -3722,6 +3722,8 @@ vm_area_alloc_pages(gfp_t gfp, int nid,
>  		if (unlikely(!page))
>  			break;
>  
> +		mod_node_page_state(page, NR_VMALLOC, 1 << order);

Same here.

With above fixes, you can add:

Acked-by: Shakeel Butt <shakeel.butt@linux.dev>

