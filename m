Return-Path: <cgroups+bounces-14147-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WEeMH6RynGmcGAQAu9opvQ
	(envelope-from <cgroups+bounces-14147-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Mon, 23 Feb 2026 16:30:44 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 2062F178BEA
	for <lists+cgroups@lfdr.de>; Mon, 23 Feb 2026 16:30:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 819493033034
	for <lists+cgroups@lfdr.de>; Mon, 23 Feb 2026 15:30:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA7A72EA72A;
	Mon, 23 Feb 2026 15:30:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P3xZ116q"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B7132E9729
	for <cgroups@vger.kernel.org>; Mon, 23 Feb 2026 15:30:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771860639; cv=none; b=o0h1XCQ38WS6y6zkGrCXDHOiLB/Yfst4uyFMbobmB52Mi5Kh8HfPS1mJyfBYWN/RSzfeQ+V+awlNc3j4y+KOv59OxLFiVmKqEqVjC1TxZ9ad1jtYWHOmM9rgfeWhIzpcaVhsQA2nCLiZvFVPlw3PuFW2jFmai4SnzfhPe/s7Kgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771860639; c=relaxed/simple;
	bh=XlP0FwapCvgJ0yTPMzXoQu1EYX4B+6+Dz4s3lyVeuBM=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WoJXCvfPXtbiLdly/n5Wl0sW6VYwtz13cxvi+S45E4DAs4yY4dqIxio+wND/o6yNSs6JiGppa2UCzzmRf1TwJUrUlIKXrzdhLHbTK7P4g3N/EalVn6eGiZLR6u0zIA2c7Jhiz+/toAvJcGx5VHbEf8yLlKabOZ683P+AcsVDgdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P3xZ116q; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-3870d178a9aso36120151fa.0
        for <cgroups@vger.kernel.org>; Mon, 23 Feb 2026 07:30:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771860636; x=1772465436; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8Mks/OfOs14ryWESFq0ukBN3EdWq9QlH027cW2Z5oAM=;
        b=P3xZ116qeQajttkn4tFML0DR8BLa6qURDYUNzSh2vtbTQlVTU6GuxTB5CSfFXzvCVP
         8qfa15VYFMLOXYt96seG/8qGf3jJ9oSCuSVgybwmsax/uySTV2XL26X8vVC+fArNeXQ6
         FHY6Etcf/G8oNg6/9hjrleGdUx5gEkqMo27QB23wWuVI6x3o0kQt23WZV4jSwm05XZtQ
         lSlb0ylinlhW0gTZt1BKdT9voHhCQASTDojkFJJ2St+xLYyKaJuQZHioWgY+mGGZCtAI
         Xvii35OOCla53uijPIc2/MJtmShEi4uKQGcKxLVgg7KklWDev902W71mHJYhP3OJwcsa
         xPgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771860636; x=1772465436;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8Mks/OfOs14ryWESFq0ukBN3EdWq9QlH027cW2Z5oAM=;
        b=dnaeJq//l3WKT5Yc9jktudNEPcjm64+cwpc6BcBOXzf2zvMmI29gMtzAJ8wS6qHIqC
         L4Ms4bjvN8bSJ5huLrGRUAaMdqdMHxvG4YDktifD/7MNjVqmBpav692uOeiTjvqFEpWK
         yDesCHCBFU995N0wwHMZt/57LC5+bbGd0nFIJGm6JtHCmjqXHV4aqISrFztELvfxJszG
         DTa6vd7EzIHaIGgekIarCNExcDfqAiai5bnE1ylIpUsBgpg2Nu45TcOAiG+ryDxRcknP
         zw23JrkTbX88RUKWdl0u412WE7l2VMRzFhrtjospeSHGcIvHkKrKwV5iW8uoDO5yA4//
         2FGw==
X-Forwarded-Encrypted: i=1; AJvYcCXKSfiKSusiBBx12HD5TyOHz647DdN/vSTl8a5Jmw5tEShh7qC4ZEa1OvpYdx6b+m3N5w2rx/5a@vger.kernel.org
X-Gm-Message-State: AOJu0YwiW75+XMCN8D7BbbKnMvIgYul/j9Ghhx+V3+3WEr2d3pn2HPSG
	tAe31UvSJG/4w9olALWs7JwRoV62xbkOeiZ+X+0bJmh48MS/3HzXWvnZ
X-Gm-Gg: ATEYQzyjaNgQsYaXsgQ896umvU97ahIU63xILwxaTW899rrYyVL25uhAB1sPX0dKVHe
	+VE7d6WAtdwfIOhFDu/E1/8Ql9LcHXuvfnN1uDsmOXV4iaEO+8Z9A8hHtHfAmuQ9AaXq7pZc79a
	GQGPar7U1qkLFbahBtBFpwr98FbWjzY90W4XAldP4oaQG5akyvt16W7n3B3yexGx2xkYIqh7Z6u
	MmmIYmqXM+kdgHs5NldV8LaqrmyGZJQ231NztusGP6LzGv1a9g1NSqn7cS3DIyrv+o+S9KziVxf
	eGOTmrWLnepz9tXOW3T6db6YHlnsfBvkxBAwF9bmXQGwYlZj3PF52DYpynUhVcQz0vQDq3IuItO
	98w+lRtoI+ITv/lBE0dh2AZG8qQFH7kTcZjH3Wv5z6sMYS+4NFMkcgZDl1XFQKJlaEOHq2XWNk2
	OXdzwOFenMZUXJJlK52V3RtH/Z/iNpn9Ar+KZzeSrXmRzNlEkPqWjj
X-Received: by 2002:a2e:be83:0:b0:386:8ea2:ef7 with SMTP id 38308e7fff4ca-389a5de6217mr31159511fa.32.1771860635535;
        Mon, 23 Feb 2026 07:30:35 -0800 (PST)
Received: from pc636 (host-90-233-215-147.mobileonline.telia.com. [90.233.215.147])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-389a7a201fbsm16328941fa.22.2026.02.23.07.30.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Feb 2026 07:30:35 -0800 (PST)
From: Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date: Mon, 23 Feb 2026 16:30:32 +0100
To: Johannes Weiner <hannes@cmpxchg.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Uladzislau Rezki <urezki@gmail.com>,
	Joshua Hahn <joshua.hahnjy@gmail.com>,
	Michal Hocko <mhocko@suse.com>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Muchun Song <muchun.song@linux.dev>, linux-mm@kvack.org,
	cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] mm: vmalloc: streamline vmalloc memory accounting
Message-ID: <aZxymBwx67pMn1ZP@pc636>
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
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-14147-lists,cgroups=lfdr.de];
	FREEMAIL_CC(0.00)[linux-foundation.org,gmail.com,suse.com,linux.dev,kvack.org,vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	MISSING_XM_UA(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[urezki@gmail.com,cgroups@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[cgroups];
	RCPT_COUNT_SEVEN(0.00)[11];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[cmpxchg.org:email]
X-Rspamd-Queue-Id: 2062F178BEA
X-Rspamd-Action: no action

On Fri, Feb 20, 2026 at 02:10:34PM -0500, Johannes Weiner wrote:
> Use a vmstat counter instead of a custom, open-coded atomic. This has
> the added benefit of making the data available per-node, and prepares
> for cleaning up the memcg accounting as well.
> 
> Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
> ---
>  fs/proc/meminfo.c       |  3 ++-
>  include/linux/mmzone.h  |  1 +
>  include/linux/vmalloc.h |  3 ---
>  mm/vmalloc.c            | 19 ++++++++++---------
>  mm/vmstat.c             |  1 +
>  5 files changed, 14 insertions(+), 13 deletions(-)
> 
> diff --git a/fs/proc/meminfo.c b/fs/proc/meminfo.c
> index a458f1e112fd..549793f44726 100644
> --- a/fs/proc/meminfo.c
> +++ b/fs/proc/meminfo.c
> @@ -126,7 +126,8 @@ static int meminfo_proc_show(struct seq_file *m, void *v)
>  	show_val_kb(m, "Committed_AS:   ", committed);
>  	seq_printf(m, "VmallocTotal:   %8lu kB\n",
>  		   (unsigned long)VMALLOC_TOTAL >> 10);
> -	show_val_kb(m, "VmallocUsed:    ", vmalloc_nr_pages());
> +	show_val_kb(m, "VmallocUsed:    ",
> +		    global_node_page_state(NR_VMALLOC));
>  	show_val_kb(m, "VmallocChunk:   ", 0ul);
>  	show_val_kb(m, "Percpu:         ", pcpu_nr_pages());
>  
> diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
> index fc5d6c88d2f0..64df797d45c6 100644
> --- a/include/linux/mmzone.h
> +++ b/include/linux/mmzone.h
> @@ -220,6 +220,7 @@ enum node_stat_item {
>  	NR_KERNEL_MISC_RECLAIMABLE,	/* reclaimable non-slab kernel pages */
>  	NR_FOLL_PIN_ACQUIRED,	/* via: pin_user_page(), gup flag: FOLL_PIN */
>  	NR_FOLL_PIN_RELEASED,	/* pages returned via unpin_user_page() */
> +	NR_VMALLOC,
>  	NR_KERNEL_STACK_KB,	/* measured in KiB */
>  #if IS_ENABLED(CONFIG_SHADOW_CALL_STACK)
>  	NR_KERNEL_SCS_KB,	/* measured in KiB */
> diff --git a/include/linux/vmalloc.h b/include/linux/vmalloc.h
> index e8e94f90d686..3b02c0c6b371 100644
> --- a/include/linux/vmalloc.h
> +++ b/include/linux/vmalloc.h
> @@ -286,8 +286,6 @@ int unregister_vmap_purge_notifier(struct notifier_block *nb);
>  #ifdef CONFIG_MMU
>  #define VMALLOC_TOTAL (VMALLOC_END - VMALLOC_START)
>  
> -unsigned long vmalloc_nr_pages(void);
> -
>  int vm_area_map_pages(struct vm_struct *area, unsigned long start,
>  		      unsigned long end, struct page **pages);
>  void vm_area_unmap_pages(struct vm_struct *area, unsigned long start,
> @@ -304,7 +302,6 @@ static inline void set_vm_flush_reset_perms(void *addr)
>  #else  /* !CONFIG_MMU */
>  #define VMALLOC_TOTAL 0UL
>  
> -static inline unsigned long vmalloc_nr_pages(void) { return 0; }
>  static inline void set_vm_flush_reset_perms(void *addr) {}
>  #endif /* CONFIG_MMU */
>  
> diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> index e286c2d2068c..a49a46de9c4f 100644
> --- a/mm/vmalloc.c
> +++ b/mm/vmalloc.c
> @@ -1063,14 +1063,8 @@ static BLOCKING_NOTIFIER_HEAD(vmap_notify_list);
>  static void drain_vmap_area_work(struct work_struct *work);
>  static DECLARE_WORK(drain_vmap_work, drain_vmap_area_work);
>  
> -static __cacheline_aligned_in_smp atomic_long_t nr_vmalloc_pages;
>  static __cacheline_aligned_in_smp atomic_long_t vmap_lazy_nr;
>  
> -unsigned long vmalloc_nr_pages(void)
> -{
> -	return atomic_long_read(&nr_vmalloc_pages);
> -}
> -
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
> +
>  		/*
Can we move *_node_page_stat() to the end of the vm_area_alloc_pages()?

Or mod_node_page_state in first place should be invoked on high-order
page before split(to avoid of looping over small pages afterword)?

I mean it would be good to place to the one solid place. If it is possible
of course.

--
Uladzislau Rezk

