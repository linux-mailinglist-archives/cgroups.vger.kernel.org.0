Return-Path: <cgroups+bounces-13955-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UgupIWLIj2l9TgEAu9opvQ
	(envelope-from <cgroups+bounces-13955-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Sat, 14 Feb 2026 01:57:06 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 39CD513A329
	for <lists+cgroups@lfdr.de>; Sat, 14 Feb 2026 01:57:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 15323301BEE2
	for <lists+cgroups@lfdr.de>; Sat, 14 Feb 2026 00:57:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D14831DE894;
	Sat, 14 Feb 2026 00:57:02 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8CFA1B4257;
	Sat, 14 Feb 2026 00:56:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771030622; cv=none; b=K421zcdH2jEmnIDqaGVVsugLyl3Im3qgqVuTDYrKar228tqCIyfGfNpTXtk8Y3t8qV+5LlD7vPBaDq7UkQATrpu1DN18e4SmxUNmm4s9zvYlEO3zatHfnI5p69QhyxWXyLz41RtvE0msT+RfHZ4WSv+a1hIzLQltImBTl5BswvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771030622; c=relaxed/simple;
	bh=6lrl2zwtHTEWqL5rziYNgUXc18UcYAQ8wiVP1VFgwsY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bqoJ6UvLRdL+SqNryPYMM3CcUF12DAcp6J1mC0CPE8fseAKgoLzNpZovyLY7YK298aevf+cZTDPgenfXCewwXVl/xnuIYee1q3C+s517cZQRD6nHV+knDMJloEKUoH6vBdKvXIc1TalYBJ53F58WGjxCVd8/9eXpnZ2GpNDPef8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.198])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4fCVwz5VNHzYQtHj;
	Sat, 14 Feb 2026 08:56:51 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 13C1740539;
	Sat, 14 Feb 2026 08:56:56 +0800 (CST)
Received: from [10.67.111.176] (unknown [10.67.111.176])
	by APP4 (Coremail) with SMTP id gCh0CgB3I_RWyI9ppdNrHQ--.4951S2;
	Sat, 14 Feb 2026 08:56:55 +0800 (CST)
Message-ID: <f96cb0e5-da3d-422a-aa14-2a52f5f0aad9@huaweicloud.com>
Date: Sat, 14 Feb 2026 08:56:54 +0800
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] memcg: consolidate private id refcount get/put helpers
To: Kairui Song <ryncsn@gmail.com>, cgroups@vger.kernel.org,
 linux-mm@kvack.org
Cc: Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>,
 Roman Gushchin <roman.gushchin@linux.dev>,
 Shakeel Butt <shakeel.butt@linux.dev>, Muchun Song <muchun.song@linux.dev>,
 Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org,
 Kairui Song <kasong@tencent.com>
References: <20260213-memcg-privid-v1-1-d8cb7afcf831@tencent.com>
Content-Language: en-US
From: Chen Ridong <chenridong@huaweicloud.com>
In-Reply-To: <20260213-memcg-privid-v1-1-d8cb7afcf831@tencent.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:gCh0CgB3I_RWyI9ppdNrHQ--.4951S2
X-Coremail-Antispam: 1UD129KBjvJXoW3Gw1UtFWkWF15AryUXFWfuFg_yoW7urWDpF
	sIkan0yayrJrW7GF1Ska429FyfZa18Xw45XFyxKw17Zrnxtw15XF17tr98XayUCF97trsx
	Jan0yr1kGw4YyFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvjb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I
	0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7CjxVAaw2AF
	wI0_Jw0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4
	xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43
	MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I
	0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWU
	JVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUF1
	v3UUUUU
X-CM-SenderInfo: hfkh02xlgr0w46kxt4xhlfz01xgou0bp/
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FREEMAIL_TO(0.00)[gmail.com,vger.kernel.org,kvack.org];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_SEVEN(0.00)[11];
	DMARC_NA(0.00)[huaweicloud.com];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[chenridong@huaweicloud.com,cgroups@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	R_DKIM_NA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_FROM(0.00)[bounces-13955-lists,cgroups=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[6];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[]
X-Rspamd-Queue-Id: 39CD513A329
X-Rspamd-Action: no action



On 2026/2/13 18:03, Kairui Song wrote:
> From: Kairui Song <kasong@tencent.com>
> 
> We currently have two different sets of helpers for getting or putting
> the private IDs' refcount for order 0 and large folios. This is
> redundant. Just use one and always acquire the refcount of the swapout
> folio size unless it's zero, and put the refcount using the folio size
> if the charge failed, since the folio size can't change. Then there is
> no need to update the refcount for tail pages.
> 
> Same for freeing, then only one pair of get/put helper is needed now.
> 
> The performance might be slightly better, too: both "inc unless zero"
> and "add unless zero" use the same cmpxchg implementation. For large
> folios, we saved an atomic operation. And for both order 0 and large
> folios, we saved a branch.
> 
> Signed-off-by: Kairui Song <kasong@tencent.com>
> ---
>  mm/memcontrol-v1.c |  5 +----
>  mm/memcontrol-v1.h |  4 ++--
>  mm/memcontrol.c    | 29 +++++++----------------------
>  3 files changed, 10 insertions(+), 28 deletions(-)
> 
> diff --git a/mm/memcontrol-v1.c b/mm/memcontrol-v1.c
> index 0e3d972fad33..c28a060abc64 100644
> --- a/mm/memcontrol-v1.c
> +++ b/mm/memcontrol-v1.c
> @@ -635,11 +635,8 @@ void memcg1_swapout(struct folio *folio, swp_entry_t entry)
>  	 * have an ID allocated to it anymore, charge the closest online
>  	 * ancestor for the swap instead and transfer the memory+swap charge.
>  	 */
> -	swap_memcg = mem_cgroup_private_id_get_online(memcg);
>  	nr_entries = folio_nr_pages(folio);
> -	/* Get references for the tail pages, too */
> -	if (nr_entries > 1)
> -		mem_cgroup_private_id_get_many(swap_memcg, nr_entries - 1);
> +	swap_memcg = mem_cgroup_private_id_get_online(memcg, nr_entries);
>  	mod_memcg_state(swap_memcg, MEMCG_SWAP, nr_entries);
>  
>  	swap_cgroup_record(folio, mem_cgroup_private_id(swap_memcg), entry);
> diff --git a/mm/memcontrol-v1.h b/mm/memcontrol-v1.h
> index 49933925b4ba..dbbd0e13d4ff 100644
> --- a/mm/memcontrol-v1.h
> +++ b/mm/memcontrol-v1.h
> @@ -28,8 +28,8 @@ unsigned long memcg_events(struct mem_cgroup *memcg, int event);
>  unsigned long memcg_page_state_output(struct mem_cgroup *memcg, int item);
>  int memory_stat_show(struct seq_file *m, void *v);
>  
> -void mem_cgroup_private_id_get_many(struct mem_cgroup *memcg, unsigned int n);
> -struct mem_cgroup *mem_cgroup_private_id_get_online(struct mem_cgroup *memcg);
> +struct mem_cgroup *mem_cgroup_private_id_get_online(struct mem_cgroup *memcg,
> +						    unsigned int n);
>  
>  /* Cgroup v1-specific declarations */
>  #ifdef CONFIG_MEMCG_V1
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index 007413a53b45..4425ef51feae 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -3564,13 +3564,7 @@ static void mem_cgroup_private_id_remove(struct mem_cgroup *memcg)
>  	}
>  }
>  
> -void __maybe_unused mem_cgroup_private_id_get_many(struct mem_cgroup *memcg,
> -					   unsigned int n)
> -{
> -	refcount_add(n, &memcg->id.ref);
> -}
> -
> -static void mem_cgroup_private_id_put_many(struct mem_cgroup *memcg, unsigned int n)
> +static inline void mem_cgroup_private_id_put(struct mem_cgroup *memcg, unsigned int n)
>  {
>  	if (refcount_sub_and_test(n, &memcg->id.ref)) {
>  		mem_cgroup_private_id_remove(memcg);
> @@ -3580,14 +3574,9 @@ static void mem_cgroup_private_id_put_many(struct mem_cgroup *memcg, unsigned in
>  	}
>  }
>  
> -static inline void mem_cgroup_private_id_put(struct mem_cgroup *memcg)
> +struct mem_cgroup *mem_cgroup_private_id_get_online(struct mem_cgroup *memcg, unsigned int n)
>  {
> -	mem_cgroup_private_id_put_many(memcg, 1);
> -}
> -
> -struct mem_cgroup *mem_cgroup_private_id_get_online(struct mem_cgroup *memcg)
> -{
> -	while (!refcount_inc_not_zero(&memcg->id.ref)) {
> +	while (!refcount_add_not_zero(n, &memcg->id.ref)) {
>  		/*
>  		 * The root cgroup cannot be destroyed, so it's refcount must
>  		 * always be >= 1.
> @@ -3888,7 +3877,7 @@ static void mem_cgroup_css_offline(struct cgroup_subsys_state *css)
>  
>  	drain_all_stock(memcg);
>  
> -	mem_cgroup_private_id_put(memcg);
> +	mem_cgroup_private_id_put(memcg, 1);
>  }
>  
>  static void mem_cgroup_css_released(struct cgroup_subsys_state *css)
> @@ -5170,19 +5159,15 @@ int __mem_cgroup_try_charge_swap(struct folio *folio, swp_entry_t entry)
>  		return 0;
>  	}
>  
> -	memcg = mem_cgroup_private_id_get_online(memcg);
> +	memcg = mem_cgroup_private_id_get_online(memcg, nr_pages);
>  
>  	if (!mem_cgroup_is_root(memcg) &&
>  	    !page_counter_try_charge(&memcg->swap, nr_pages, &counter)) {
>  		memcg_memory_event(memcg, MEMCG_SWAP_MAX);
>  		memcg_memory_event(memcg, MEMCG_SWAP_FAIL);
> -		mem_cgroup_private_id_put(memcg);
> +		mem_cgroup_private_id_put(memcg, nr_pages);
>  		return -ENOMEM;
>  	}
> -
> -	/* Get references for the tail pages, too */
> -	if (nr_pages > 1)
> -		mem_cgroup_private_id_get_many(memcg, nr_pages - 1);
>  	mod_memcg_state(memcg, MEMCG_SWAP, nr_pages);
>  
>  	swap_cgroup_record(folio, mem_cgroup_private_id(memcg), entry);
> @@ -5211,7 +5196,7 @@ void __mem_cgroup_uncharge_swap(swp_entry_t entry, unsigned int nr_pages)
>  				page_counter_uncharge(&memcg->swap, nr_pages);
>  		}
>  		mod_memcg_state(memcg, MEMCG_SWAP, -nr_pages);
> -		mem_cgroup_private_id_put_many(memcg, nr_pages);
> +		mem_cgroup_private_id_put(memcg, nr_pages);
>  	}
>  	rcu_read_unlock();
>  }
> 
> ---
> base-commit: 9fff1ab283e0982c2b8e73f1d2246fd38caf40c8
> change-id: 20260213-memcg-privid-6ba2773b5ca2
> 
> Best regards,

Reviewed-by: Chen Ridong <chenridong@huaweicloud.com>

-- 
Best regards,
Ridong


