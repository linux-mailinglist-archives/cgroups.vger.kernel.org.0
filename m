Return-Path: <cgroups+bounces-17085-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id QcyqH787NWrrpQYAu9opvQ
	(envelope-from <cgroups+bounces-17085-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Fri, 19 Jun 2026 14:53:19 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 814626A5DCF
	for <lists+cgroups@lfdr.de>; Fri, 19 Jun 2026 14:53:18 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=arm.com header.s=foss header.b=LTCcKpXW;
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-17085-lists+cgroups=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="cgroups+bounces-17085-lists+cgroups=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=arm.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id AC5A83004C9A
	for <lists+cgroups@lfdr.de>; Fri, 19 Jun 2026 12:53:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC1D1372EC5;
	Fri, 19 Jun 2026 12:53:11 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8357E372EDB;
	Fri, 19 Jun 2026 12:53:09 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781873591; cv=none; b=qjXi62j0+cY0ZKwBR3bGG43g+qBrPEVAiGs9kciZ8jBZkzGhihJf0pZYdc5GbqCIyX+v3wL0XW4pbP7NK82I2hAuQNvGmTNgFKwZsLz5MAoBPG+j6aN1p5AHu6mm7M/i48crkYandxShWDNfCbMGKBWKN1gn15APPbzeQcZcHrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781873591; c=relaxed/simple;
	bh=ZoYK/NfeRfrHjjGWAH0i3x+/+ZWvMjwFdDPoyC/BlfI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AMuLLLfzgYqA8Q9H84IaNPJ38sKeOcvzGfPQXA/JQgO8WZQIES4ADxbvLOP5HHyrHYcRS42OFXeZVg8r3kp9XBbmTBTiJXfwWJP2QZJs0XuyQrbyGZN7nDajlPTah5aWqqOHUUUJjVC9aK9DuVbGyH/tcf+13KpDcB5fAE9CSMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=LTCcKpXW; arc=none smtp.client-ip=217.140.110.172
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1F5B5339;
	Fri, 19 Jun 2026 05:53:04 -0700 (PDT)
Received: from [10.163.166.1] (unknown [10.163.166.1])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DA8CB3F62B;
	Fri, 19 Jun 2026 05:53:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1781873588; bh=ZoYK/NfeRfrHjjGWAH0i3x+/+ZWvMjwFdDPoyC/BlfI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=LTCcKpXWRTWAIFxamoizT7xDCcTR7bQKWKNZb8mQcqZBOHyNXFy6XRDMvhiJzf7NF
	 vjuI2ht2lUlzVSjiuT212vEyL0HT8WwjdvEcdcgKfJW2L7z9d24FytiaegrlOFOSIC
	 m4V68+uHN8IUY01HLtBscTTRGmVsbQo+cLN6nUd4=
Message-ID: <15973e53-5774-428c-96c4-675eea600788@arm.com>
Date: Fri, 19 Jun 2026 18:23:01 +0530
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [REGRESSION] [PATCH v2 1/2] mm: vmalloc: streamline vmalloc memory
 accounting
To: Johannes Weiner <hannes@cmpxchg.org>,
 Andrew Morton <akpm@linux-foundation.org>
Cc: Uladzislau Rezki <urezki@gmail.com>, Joshua Hahn
 <joshua.hahnjy@gmail.com>, Michal Hocko <mhocko@suse.com>,
 Roman Gushchin <roman.gushchin@linux.dev>,
 Shakeel Butt <shakeel.butt@linux.dev>, Muchun Song <muchun.song@linux.dev>,
 linux-mm@kvack.org, cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
 Ryan Roberts <ryan.roberts@arm.com>
References: <20260223160147.3792777-1-hannes@cmpxchg.org>
Content-Language: en-US
From: Aishwarya Rambhadran <aishwarya.rambhadran@arm.com>
In-Reply-To: <20260223160147.3792777-1-hannes@cmpxchg.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[arm.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[arm.com:s=foss];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORWARDED(0.00)[lists@lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[12];
	TAGGED_FROM(0.00)[bounces-17085-lists,cgroups=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:hannes@cmpxchg.org,m:akpm@linux-foundation.org,m:urezki@gmail.com,m:joshua.hahnjy@gmail.com,m:mhocko@suse.com,m:roman.gushchin@linux.dev,m:shakeel.butt@linux.dev,m:muchun.song@linux.dev,m:linux-mm@kvack.org,m:cgroups@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:ryan.roberts@arm.com,m:joshuahahnjy@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[aishwarya.rambhadran@arm.com,cgroups@vger.kernel.org];
	FREEMAIL_CC(0.00)[gmail.com,suse.com,linux.dev,kvack.org,vger.kernel.org,arm.com];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[aishwarya.rambhadran@arm.com,cgroups@vger.kernel.org];
	DKIM_TRACE(0.00)[arm.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,vger.kernel.org:from_smtp,arm.com:dkim,arm.com:mid,arm.com:from_mime,cmpxchg.org:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 814626A5DCF

Hi Johannes,

We have observed kernel performance regressions in vmalloc benchmarks
when comparing v7.0 mainline results against later releases in the v7.1
cycle.
The regressions were detected by Fastpath, our automated kernel
performance benchmark and regression tracking framework.
Independent bisections on multiple arm64 systems consistently
identify this patch as the root cause. The regressions are reproducible
on both AWS Graviton3 & AmpereOne systems.

Fastpath bisection details :
Benchmark - micromm/vmalloc
Test - fix_size_alloc_test: p:512, h:1, l:100000
Good Kernel - v7.0
Bad Kernel - v7.1-rc4

The measured regression for the above test is approximately 32.5%
on AWS Graviton3. Similar regressions are observed across multiple
tests within the vmalloc benchmark suite as well as on AmpereOne.

Below given are the performance benchmark results of vmalloc
suite generated by Fastpath Tool, for v7.1 kernel version relative to
the base version v7.0, executed on the AWS Graviton3 SUT. Label (R)
mean statistically significant regression, where "statistically 
significant"
means the 95% confidence intervals do not overlap.

v7.0 (base) | v7.1
-------------------------------------------------------------------
fix_align_alloc_test: p:1, h:0, l:500000
895106.67 | (R) -10.73%

fix_size_alloc_test: p:1, h:0, l:500000
336785.00 | (R) -7.31%

fix_size_alloc_test: p:4, h:0, l:500000
529652.83 | (R) -13.11%

fix_size_alloc_test: p:16, h:0, l:500000
1043412.50 | (R) -21.92%

fix_size_alloc_test: p:16, h:1, l:500000
1015795.83 | (R) -22.02%

fix_size_alloc_test: p:64, h:0, l:100000
643074.33 | (R) -25.91%

fix_size_alloc_test: p:64, h:1, l:100000
607604.00 | (R) -27.31%

fix_size_alloc_test: p:256, h:0, l:100000
2367906.50 | (R) -27.67%

fix_size_alloc_test: p:256, h:1, l:100000
2275464.67 | (R) -28.66%

fix_size_alloc_test: p:512, h:0, l:100000
4696069.17 | (R) -28.15%

fix_size_alloc_test: p:512, h:1, l:100000
3767292.00 | (R) -32.65%

full_fit_alloc_test: p:1, h:0, l:500000
493884.17 | (R) -12.38%

kvfree_rcu_1_arg_vmalloc_test: p:1, h:0, l:500000
354542.83 | -2.31%

kvfree_rcu_2_arg_vmalloc_test: p:1, h:0, l:500000
358082.83 | -1.53%

long_busy_list_alloc_test: p:1, h:0, l:500000
5490101.33 | (R) -25.85%

pcpu_alloc_test: p:1, h:0, l:500000
193634.00 | -1.53%

random_size_align_alloc_test: p:1, h:0, l:500000
1200206.83 | (R) -11.88%

random_size_alloc_test: p:1, h:0, l:500000
2875736.33 | (R) -24.41%

vm_map_ram_test: p:1, h:0, l:500000
81204.33 | -0.28%
-------------------------------------------------------------------

The regression signal appears stable across repeated runs.
Have you seen similar effects before, or is there an expected
behavioral change associated with the conversion from the
custom atomic accounting to vmstat counters that could
explain this result ?

We would be happy to provide additional performance data,
kernel configurations or any other details if useful.

Thank you.
Aishwarya Rambhadran

On 23/02/26 9:31 PM, Johannes Weiner wrote:
> Use a vmstat counter instead of a custom, open-coded atomic. This has
> the added benefit of making the data available per-node, and prepares
> for cleaning up the memcg accounting as well.
>
> Acked-by: Shakeel Butt <shakeel.butt@linux.dev>
> Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
> ---
>   fs/proc/meminfo.c       |  3 ++-
>   include/linux/mmzone.h  |  1 +
>   include/linux/vmalloc.h |  3 ---
>   mm/vmalloc.c            | 19 ++++++++++---------
>   mm/vmstat.c             |  1 +
>   5 files changed, 14 insertions(+), 13 deletions(-)
>
> V2:
> - Fix mod_node_page_state() pgdat argument (Shakeel)
>
> diff --git a/fs/proc/meminfo.c b/fs/proc/meminfo.c
> index a458f1e112fd..549793f44726 100644
> --- a/fs/proc/meminfo.c
> +++ b/fs/proc/meminfo.c
> @@ -126,7 +126,8 @@ static int meminfo_proc_show(struct seq_file *m, void *v)
>   	show_val_kb(m, "Committed_AS:   ", committed);
>   	seq_printf(m, "VmallocTotal:   %8lu kB\n",
>   		   (unsigned long)VMALLOC_TOTAL >> 10);
> -	show_val_kb(m, "VmallocUsed:    ", vmalloc_nr_pages());
> +	show_val_kb(m, "VmallocUsed:    ",
> +		    global_node_page_state(NR_VMALLOC));
>   	show_val_kb(m, "VmallocChunk:   ", 0ul);
>   	show_val_kb(m, "Percpu:         ", pcpu_nr_pages());
>   
> diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
> index fc5d6c88d2f0..64df797d45c6 100644
> --- a/include/linux/mmzone.h
> +++ b/include/linux/mmzone.h
> @@ -220,6 +220,7 @@ enum node_stat_item {
>   	NR_KERNEL_MISC_RECLAIMABLE,	/* reclaimable non-slab kernel pages */
>   	NR_FOLL_PIN_ACQUIRED,	/* via: pin_user_page(), gup flag: FOLL_PIN */
>   	NR_FOLL_PIN_RELEASED,	/* pages returned via unpin_user_page() */
> +	NR_VMALLOC,
>   	NR_KERNEL_STACK_KB,	/* measured in KiB */
>   #if IS_ENABLED(CONFIG_SHADOW_CALL_STACK)
>   	NR_KERNEL_SCS_KB,	/* measured in KiB */
> diff --git a/include/linux/vmalloc.h b/include/linux/vmalloc.h
> index e8e94f90d686..3b02c0c6b371 100644
> --- a/include/linux/vmalloc.h
> +++ b/include/linux/vmalloc.h
> @@ -286,8 +286,6 @@ int unregister_vmap_purge_notifier(struct notifier_block *nb);
>   #ifdef CONFIG_MMU
>   #define VMALLOC_TOTAL (VMALLOC_END - VMALLOC_START)
>   
> -unsigned long vmalloc_nr_pages(void);
> -
>   int vm_area_map_pages(struct vm_struct *area, unsigned long start,
>   		      unsigned long end, struct page **pages);
>   void vm_area_unmap_pages(struct vm_struct *area, unsigned long start,
> @@ -304,7 +302,6 @@ static inline void set_vm_flush_reset_perms(void *addr)
>   #else  /* !CONFIG_MMU */
>   #define VMALLOC_TOTAL 0UL
>   
> -static inline unsigned long vmalloc_nr_pages(void) { return 0; }
>   static inline void set_vm_flush_reset_perms(void *addr) {}
>   #endif /* CONFIG_MMU */
>   
> diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> index e286c2d2068c..a5fc7795aafd 100644
> --- a/mm/vmalloc.c
> +++ b/mm/vmalloc.c
> @@ -1063,14 +1063,8 @@ static BLOCKING_NOTIFIER_HEAD(vmap_notify_list);
>   static void drain_vmap_area_work(struct work_struct *work);
>   static DECLARE_WORK(drain_vmap_work, drain_vmap_area_work);
>   
> -static __cacheline_aligned_in_smp atomic_long_t nr_vmalloc_pages;
>   static __cacheline_aligned_in_smp atomic_long_t vmap_lazy_nr;
>   
> -unsigned long vmalloc_nr_pages(void)
> -{
> -	return atomic_long_read(&nr_vmalloc_pages);
> -}
> -
>   static struct vmap_area *__find_vmap_area(unsigned long addr, struct rb_root *root)
>   {
>   	struct rb_node *n = root->rb_node;
> @@ -3463,11 +3457,11 @@ void vfree(const void *addr)
>   		 * High-order allocs for huge vmallocs are split, so
>   		 * can be freed as an array of order-0 allocations
>   		 */
> +		if (!(vm->flags & VM_MAP_PUT_PAGES))
> +			dec_node_page_state(page, NR_VMALLOC);
>   		__free_page(page);
>   		cond_resched();
>   	}
> -	if (!(vm->flags & VM_MAP_PUT_PAGES))
> -		atomic_long_sub(vm->nr_pages, &nr_vmalloc_pages);
>   	kvfree(vm->pages);
>   	kfree(vm);
>   }
> @@ -3655,6 +3649,8 @@ vm_area_alloc_pages(gfp_t gfp, int nid,
>   			continue;
>   		}
>   
> +		mod_node_page_state(page_pgdat(page), NR_VMALLOC, 1 << large_order);
> +
>   		split_page(page, large_order);
>   		for (i = 0; i < (1U << large_order); i++)
>   			pages[nr_allocated + i] = page + i;
> @@ -3675,6 +3671,7 @@ vm_area_alloc_pages(gfp_t gfp, int nid,
>   	if (!order) {
>   		while (nr_allocated < nr_pages) {
>   			unsigned int nr, nr_pages_request;
> +			int i;
>   
>   			/*
>   			 * A maximum allowed request is hard-coded and is 100
> @@ -3698,6 +3695,9 @@ vm_area_alloc_pages(gfp_t gfp, int nid,
>   							nr_pages_request,
>   							pages + nr_allocated);
>   
> +			for (i = nr_allocated; i < nr_allocated + nr; i++)
> +				inc_node_page_state(pages[i], NR_VMALLOC);
> +
>   			nr_allocated += nr;
>   
>   			/*
> @@ -3722,6 +3722,8 @@ vm_area_alloc_pages(gfp_t gfp, int nid,
>   		if (unlikely(!page))
>   			break;
>   
> +		mod_node_page_state(page_pgdat(page), NR_VMALLOC, 1 << order);
> +
>   		/*
>   		 * High-order allocations must be able to be treated as
>   		 * independent small pages by callers (as they can with
> @@ -3864,7 +3866,6 @@ static void *__vmalloc_area_node(struct vm_struct *area, gfp_t gfp_mask,
>   			vmalloc_gfp_adjust(gfp_mask, page_order), node,
>   			page_order, nr_small_pages, area->pages);
>   
> -	atomic_long_add(area->nr_pages, &nr_vmalloc_pages);
>   	/* All pages of vm should be charged to same memcg, so use first one. */
>   	if (gfp_mask & __GFP_ACCOUNT && area->nr_pages)
>   		mod_memcg_page_state(area->pages[0], MEMCG_VMALLOC,
> diff --git a/mm/vmstat.c b/mm/vmstat.c
> index d6e814c82952..bc199c7cd07b 100644
> --- a/mm/vmstat.c
> +++ b/mm/vmstat.c
> @@ -1270,6 +1270,7 @@ const char * const vmstat_text[] = {
>   	[I(NR_KERNEL_MISC_RECLAIMABLE)]		= "nr_kernel_misc_reclaimable",
>   	[I(NR_FOLL_PIN_ACQUIRED)]		= "nr_foll_pin_acquired",
>   	[I(NR_FOLL_PIN_RELEASED)]		= "nr_foll_pin_released",
> +	[I(NR_VMALLOC)]				= "nr_vmalloc",
>   	[I(NR_KERNEL_STACK_KB)]			= "nr_kernel_stack",
>   #if IS_ENABLED(CONFIG_SHADOW_CALL_STACK)
>   	[I(NR_KERNEL_SCS_KB)]			= "nr_shadow_call_stack",


