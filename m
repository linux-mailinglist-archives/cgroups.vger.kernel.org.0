Return-Path: <cgroups+bounces-14146-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wGccAo9vnGmcGAQAu9opvQ
	(envelope-from <cgroups+bounces-14146-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Mon, 23 Feb 2026 16:17:35 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C1DC1789EF
	for <lists+cgroups@lfdr.de>; Mon, 23 Feb 2026 16:17:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 818C4300CC27
	for <lists+cgroups@lfdr.de>; Mon, 23 Feb 2026 15:12:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03B5D36607A;
	Mon, 23 Feb 2026 15:12:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Kqj2g8lG"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5679E35CB9B
	for <cgroups@vger.kernel.org>; Mon, 23 Feb 2026 15:12:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771859574; cv=none; b=jz0Vdp79WA/MY3CFfHj4YkmR0QAmp8KSLZ6jGOLJODF7+njd9mqS+UCYp4dZKgP53sxPB/cahOsYlDeB/4Aw345Ppkjb4dvt0/EsclXUUJ+r0qZSCgGpGVAQsY6kgfD6xg8vIUZLLCZERbwNoI+VIzAIGR2QHnabEC/5soyuSa0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771859574; c=relaxed/simple;
	bh=CYkBXoTf/dSuKGzEl9Jo4E5MEUaThQGWXjgL1xUJ8PI=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q0EG3XHL40Zwzz0LKJSdI86O5u5WETD6fcqOD/lScv4srz83IQ73u/nMXFWtc1eEBLnxT+4dH+1dH6k66+ep3/sM2drM3v1ZO+R0U/9D6I3yrTDy4Y+2lu/x8pm/SfTK7xxCWAwpbfcuyxAKjxxtP5huo0cDhIOndJq+iGKuGis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Kqj2g8lG; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-59e4a04f059so5708570e87.2
        for <cgroups@vger.kernel.org>; Mon, 23 Feb 2026 07:12:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771859572; x=1772464372; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ztMTHoPevsynxwNBJLriX2EMDeNpsudFj4ZJFPjQr+o=;
        b=Kqj2g8lGmeJGcfAmXbZ75DDhL1rY/3pcx2Cd5RhMiblttUJUAvFzIxJirtfX9/w14h
         BPlMY6ylStBX/bKkLwgPczx0928yEtOWJ4MoJf5SDjTK+4eLMfOX7XiH+B80imFXYhjY
         Y84ul8bO72o/Rj4PSBa4Axbk+8FQnS3/vTaoKvBKfTtSDAaUIzZP9cogy9bqzA/Vlrbc
         eNWWsXqXCA4G1t7sWVL6fb2siNA/XGfbjOAEan1aiO+QFNcXyOXyppD3+XMP1Cu8iVlZ
         /vp5PTn2C8bEvTduT1XSrXtmMQK/GtRTYvlkT1q5W1ifxawRW/kMVmCZRLVCuZtISFms
         U7cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771859572; x=1772464372;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ztMTHoPevsynxwNBJLriX2EMDeNpsudFj4ZJFPjQr+o=;
        b=dAh+g6SzUj+pcgnRdQyazgUJuYO2W7fpfEh2H5FJEUGj47PyUdU1iC1V+LOJs5/cxa
         05zPZGr0U8aKkaI/5mQUH1Ln7l6U77vYhcKmZZ/PSBnuurBMr/q19tThmEug5pCQmxIH
         F8Ye+BEyZZR5bBbAQT3n3SIehyXWb0vnVyQ6QlErTYb/jeVHW59TzpSe1I3UNAFtplEq
         GBlffMYSnEd/wIpHyGDZVomR0lxqI03PzGzLmUSoLkJR8/L1xbzgG5ATl5dIpl8dVCya
         SJKWkGykkd4K4FxeIqfA/y5yq51QPKtrGvutqgcyXKe4G8id/VjNnqwpT1CIZj7rRqmA
         6Icg==
X-Forwarded-Encrypted: i=1; AJvYcCVJLBRLTQrKMle/5eEPhrYfkDh6Tf3YZnyNmfpn767LdnbNx5CV5V3AklFE3dCov78ThI1hRUcu@vger.kernel.org
X-Gm-Message-State: AOJu0YxAsMNpG6ifFUpEUyJBvrmemwFZaL+3fvhKrthLm7ZA1nXKeB8x
	efxYBK2REtxccgvl7nj4Ki3CT1oe4xAgSD/acC8/rW+ZTg/i9L6sFG0z
X-Gm-Gg: AZuq6aJhhUyeyDMX+0sXQeee7BGT9oXTz6kOZpJ8W11GM3U5h9r+2wWsey9coEQlt/V
	XSw7baKZAHYiq4R1ClM+ybUsVjTMl0psU2aPS6ymxq+hj5Y2+2gI6hISD4F+FAKYLh7vitZZQdc
	xqDi03RDXe20ZMqxx/7EBHIQZ819FxHnIx6zwQ77Y4FR+czdMLWPwFozjIq52JI2dnYD9+FpHj+
	PUFe+L3hnAJwBYbHkiH03e0g7+X2ZdUhlZVf5/fcPOO+2ZMupLOXU0fVfttmC8VyVSLVeZudHDQ
	+/mtcRU64dHfN8RmVCW/PGDPvRLV5TD0zX3y4RGzIyxsQ2E7ylvNOG+thkDVCCObimjcLSXjaWG
	CIP7hanoYrlfCYBV0BmVNvfAdEIRrT+KCq3CoHgire1n6YJRvXqckKb96SpXPO8Xm6B8VzGbW1K
	KBNWzMLwzxM8C2l1j+CL7nFEFj1FAfbrRpUqt7VmRwLgrryzgb0N2c
X-Received: by 2002:a05:6512:3a96:b0:59d:e589:c973 with SMTP id 2adb3069b0e04-5a0ed9b038fmr2771294e87.48.1771859571444;
        Mon, 23 Feb 2026 07:12:51 -0800 (PST)
Received: from pc636 (host-90-233-215-147.mobileonline.telia.com. [90.233.215.147])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5a0eeb458bcsm1610898e87.62.2026.02.23.07.12.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Feb 2026 07:12:51 -0800 (PST)
From: Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date: Mon, 23 Feb 2026 16:12:48 +0100
To: Johannes Weiner <hannes@cmpxchg.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Uladzislau Rezki <urezki@gmail.com>,
	Joshua Hahn <joshua.hahnjy@gmail.com>,
	Michal Hocko <mhocko@suse.com>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Muchun Song <muchun.song@linux.dev>, linux-mm@kvack.org,
	cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] mm: memcontrol: switch to native NR_VMALLOC vmstat
 counter
Message-ID: <aZxucOEcpJDzSBgg@pc636>
References: <20260220191035.3703800-1-hannes@cmpxchg.org>
 <20260220191035.3703800-2-hannes@cmpxchg.org>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260220191035.3703800-2-hannes@cmpxchg.org>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-14146-lists,cgroups=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[cmpxchg.org:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 6C1DC1789EF
X-Rspamd-Action: no action

On Fri, Feb 20, 2026 at 02:10:35PM -0500, Johannes Weiner wrote:
> Eliminates the custom memcg counter and results in a single,
> consolidated accounting call in vmalloc code.
> 
> Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
> ---
>  include/linux/memcontrol.h |  1 -
>  mm/memcontrol.c            |  4 ++--
>  mm/vmalloc.c               | 16 ++++------------
>  3 files changed, 6 insertions(+), 15 deletions(-)
> 
> diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
> index 67f154de10bc..c7cc4e50e59a 100644
> --- a/include/linux/memcontrol.h
> +++ b/include/linux/memcontrol.h
> @@ -35,7 +35,6 @@ enum memcg_stat_item {
>  	MEMCG_SWAP = NR_VM_NODE_STAT_ITEMS,
>  	MEMCG_SOCK,
>  	MEMCG_PERCPU_B,
> -	MEMCG_VMALLOC,
>  	MEMCG_KMEM,
>  	MEMCG_ZSWAP_B,
>  	MEMCG_ZSWAPPED,
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index 129eed3ff5bb..fef5bdd887e0 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -317,6 +317,7 @@ static const unsigned int memcg_node_stat_items[] = {
>  	NR_SHMEM_THPS,
>  	NR_FILE_THPS,
>  	NR_ANON_THPS,
> +	NR_VMALLOC,
>  	NR_KERNEL_STACK_KB,
>  	NR_PAGETABLE,
>  	NR_SECONDARY_PAGETABLE,
> @@ -339,7 +340,6 @@ static const unsigned int memcg_stat_items[] = {
>  	MEMCG_SWAP,
>  	MEMCG_SOCK,
>  	MEMCG_PERCPU_B,
> -	MEMCG_VMALLOC,
>  	MEMCG_KMEM,
>  	MEMCG_ZSWAP_B,
>  	MEMCG_ZSWAPPED,
> @@ -1359,7 +1359,7 @@ static const struct memory_stat memory_stats[] = {
>  	{ "sec_pagetables",		NR_SECONDARY_PAGETABLE		},
>  	{ "percpu",			MEMCG_PERCPU_B			},
>  	{ "sock",			MEMCG_SOCK			},
> -	{ "vmalloc",			MEMCG_VMALLOC			},
> +	{ "vmalloc",			NR_VMALLOC			},
>  	{ "shmem",			NR_SHMEM			},
>  #ifdef CONFIG_ZSWAP
>  	{ "zswap",			MEMCG_ZSWAP_B			},
> diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> index a49a46de9c4f..8773bc0c4734 100644
> --- a/mm/vmalloc.c
> +++ b/mm/vmalloc.c
> @@ -3446,9 +3446,6 @@ void vfree(const void *addr)
>  
>  	if (unlikely(vm->flags & VM_FLUSH_RESET_PERMS))
>  		vm_reset_perms(vm);
> -	/* All pages of vm should be charged to same memcg, so use first one. */
> -	if (vm->nr_pages && !(vm->flags & VM_MAP_PUT_PAGES))
> -		mod_memcg_page_state(vm->pages[0], MEMCG_VMALLOC, -vm->nr_pages);
>  	for (i = 0; i < vm->nr_pages; i++) {
>  		struct page *page = vm->pages[i];
>  
> @@ -3458,7 +3455,7 @@ void vfree(const void *addr)
>  		 * can be freed as an array of order-0 allocations
>  		 */
>  		if (!(vm->flags & VM_MAP_PUT_PAGES))
> -			dec_node_page_state(page, NR_VMALLOC);
> +			mod_lruvec_page_state(page, NR_VMALLOC, -1);
>  		__free_page(page);
>  		cond_resched();
>  	}
> @@ -3649,7 +3646,7 @@ vm_area_alloc_pages(gfp_t gfp, int nid,
>  			continue;
>  		}
>  
> -		mod_node_page_state(page, NR_VMALLOC, 1 << large_order);
> +		mod_lruvec_page_state(page, NR_VMALLOC, 1 << large_order);
>  
>  		split_page(page, large_order);
>  		for (i = 0; i < (1U << large_order); i++)
> @@ -3696,7 +3693,7 @@ vm_area_alloc_pages(gfp_t gfp, int nid,
>  							pages + nr_allocated);
>  
>  			for (i = nr_allocated; i < nr_allocated + nr; i++)
> -				inc_node_page_state(pages[i], NR_VMALLOC);
> +				mod_lruvec_page_state(pages[i], NR_VMALLOC, 1);
>  
>  			nr_allocated += nr;
>  
> @@ -3722,7 +3719,7 @@ vm_area_alloc_pages(gfp_t gfp, int nid,
>  		if (unlikely(!page))
>  			break;
>  
> -		mod_node_page_state(page, NR_VMALLOC, 1 << order);
> +		mod_lruvec_page_state(page, NR_VMALLOC, 1 << order);
>  
>  		/*
>  		 * High-order allocations must be able to be treated as
> @@ -3866,11 +3863,6 @@ static void *__vmalloc_area_node(struct vm_struct *area, gfp_t gfp_mask,
>  			vmalloc_gfp_adjust(gfp_mask, page_order), node,
>  			page_order, nr_small_pages, area->pages);
>  
> -	/* All pages of vm should be charged to same memcg, so use first one. */
> -	if (gfp_mask & __GFP_ACCOUNT && area->nr_pages)
> -		mod_memcg_page_state(area->pages[0], MEMCG_VMALLOC,
> -				     area->nr_pages);
> -
>  	/*
>  	 * If not enough pages were obtained to accomplish an
>  	 * allocation request, free them via vfree() if any.
> -- 
> 2.53.0
> 
LGTM:

Reviewed-by: Uladzislau Rezki (Sony) <urezki@gmail.com>


