Return-Path: <cgroups+bounces-13299-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F49DD3926C
	for <lists+cgroups@lfdr.de>; Sun, 18 Jan 2026 04:29:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6B53A3004228
	for <lists+cgroups@lfdr.de>; Sun, 18 Jan 2026 03:29:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A95842EA172;
	Sun, 18 Jan 2026 03:29:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="uWNLg7kl"
X-Original-To: cgroups@vger.kernel.org
Received: from out-186.mta0.migadu.com (out-186.mta0.migadu.com [91.218.175.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 263D82192F4
	for <cgroups@vger.kernel.org>; Sun, 18 Jan 2026 03:29:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768706965; cv=none; b=AUVJrj5xhs6vZE+qselNP7aIMLL8phsfx8vGEDMB1qP9PhseodB28qaJr7keqQk+qgrFTJgjapCAaN9KeLvI6og9lEfL8GybdGWygEFbZuHVJV4jX/0N92CZ2MLnp5QDtWzBjE2ooPXaJFXOPvqlki38etCE6ev+Tr2zqrDs3c8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768706965; c=relaxed/simple;
	bh=dWcnkQXMI4RiLB3ci8Afyrr1HUMG596AoNcOdZqWL+g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LGsyL0fiHONVes5ArDiYfGquihDEMr5VlORtLwbeZ48QHowk9dNQPvg6k4NuSKJvnytDsehAiN/Bl64uDzlx4iNh90OuFhGsfF5GofKAtYfYfb/fu8D8kWJNTEJOBnfKxi1UgvDYPvyU7NjJLA8eh9udBr8pchUK1NbmEjgW624=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=uWNLg7kl; arc=none smtp.client-ip=91.218.175.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Sat, 17 Jan 2026 19:29:15 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1768706962;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=WSt/eL8MOWMH16GBja7BlYK/m3mPkdcdzLf2DCLrKaI=;
	b=uWNLg7kl4TqVqq4BhyBKExegaGv6L+4p6xNVw9KEiE0wHXOu+GMmgHsf0Pqxo1HYJPa7Dt
	1xu6JGmewl0XPwdyEzFQ1vHBOOG2qQPe2tHSEWXhx5i/HsaM2WtK5bdz3OsIcjHVH7/0f1
	ZMOHtpd9e2XiEDFC4nW1ypeO22RR0ms=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Qi Zheng <qi.zheng@linux.dev>
Cc: hannes@cmpxchg.org, hughd@google.com, mhocko@suse.com, 
	roman.gushchin@linux.dev, muchun.song@linux.dev, david@kernel.org, 
	lorenzo.stoakes@oracle.com, ziy@nvidia.com, harry.yoo@oracle.com, yosry.ahmed@linux.dev, 
	imran.f.khan@oracle.com, kamalesh.babulal@oracle.com, axelrasmussen@google.com, 
	yuanchu@google.com, weixugc@google.com, chenridong@huaweicloud.com, mkoutny@suse.com, 
	akpm@linux-foundation.org, hamzamahfooz@linux.microsoft.com, apais@linux.microsoft.com, 
	lance.yang@linux.dev, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	cgroups@vger.kernel.org, Qi Zheng <zhengqi.arch@bytedance.com>
Subject: Re: [PATCH v3 26/30] mm: vmscan: prepare for reparenting MGLRU folios
Message-ID: <mhxt3oheta2enk562jt25qdac2tkq6ulc3olxairfow6tb5qpl@n5dhssfcyhea>
References: <cover.1768389889.git.zhengqi.arch@bytedance.com>
 <92e0728fed3d68855173352416cf8077670610f0.1768389889.git.zhengqi.arch@bytedance.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <92e0728fed3d68855173352416cf8077670610f0.1768389889.git.zhengqi.arch@bytedance.com>
X-Migadu-Flow: FLOW_OUT

I asked AI to review this patch and it find following potential issues:

Author: Qi Zheng <zhengqi.arch@bytedance.com>

mm: vmscan: prepare for reparenting MGLRU folios

This commit adds infrastructure for reparenting MGLRU folios from dying
memcg to parent memcg, including functions to ensure parent has MAX_NR_GENS
generations before reparenting.

Link: https://lkml.kernel.org/r/92e0728fed3d68855173352416cf8077670610f0.1768389889.git.zhengqi.arch@bytedance.com

> diff --git a/mm/vmscan.c b/mm/vmscan.c
> index f1a45c94c2fc..284292653d14 100644
> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c

[ ... ]

> +static void try_to_inc_max_seq_nowalk(struct mem_cgroup *memcg,
> +				      struct lruvec *lruvec)
> +{
> +	struct lru_gen_mm_list *mm_list = get_mm_list(memcg);
> +	struct lru_gen_mm_state *mm_state = get_mm_state(lruvec);
> +	int swappiness = mem_cgroup_swappiness(memcg);
> +	DEFINE_MAX_SEQ(lruvec);
> +	bool success = false;
> +
> +	/*
> +	 * We are not iterating the mm_list here, updating mm_state->seq is just
> +	 * to make mm walkers work properly.
> +	 */
> +	if (mm_state) {
> +		spin_lock(&mm_list->lock);
> +		VM_WARN_ON_ONCE(mm_state->seq + 1 < max_seq);
> +		if (max_seq > mm_state->seq) {
                    ^^^^^^^^^^^^^^^^^^^^^^^^^^^^

When mm_state->seq equals max_seq (which can happen when mm walkers have
completed their iteration), this condition is false, success remains false,
and inc_max_seq() is never called.

The caller max_lru_gen_memcg() loops with:

    while (get_nr_gens(lruvec, type) < MAX_NR_GENS) {
        try_to_inc_max_seq_nowalk(memcg, lruvec);
        cond_resched();
    }

If try_to_inc_max_seq_nowalk() fails to increment max_seq, get_nr_gens()
returns the same value, and the while loop continues indefinitely.

Can this cause an infinite loop during memcg offline when mm_state->seq has
caught up to max_seq?

Suggested fix: Remove the success variable and always call inc_max_seq().
The mm_state->seq update is only for coordination with mm walkers - it should
not gate whether we increment the generation. inc_max_seq() has its own
staleness check (seq < READ_ONCE(lrugen->max_seq)) so calling it unconditionally
is safe:

    if (mm_state) {
        spin_lock(&mm_list->lock);
        VM_WARN_ON_ONCE(mm_state->seq + 1 < max_seq);
        if (max_seq > mm_state->seq)
            WRITE_ONCE(mm_state->seq, mm_state->seq + 1);
        spin_unlock(&mm_list->lock);
    }

    inc_max_seq(lruvec, max_seq, swappiness);

> +			WRITE_ONCE(mm_state->seq, mm_state->seq + 1);
> +			success = true;
> +		}
> +		spin_unlock(&mm_list->lock);
> +	} else {
> +		success = true;
> +	}
> +
> +	if (success)
> +		inc_max_seq(lruvec, max_seq, swappiness);
> +}

[ ... ]

> +static void __lru_gen_reparent_memcg(struct lruvec *child_lruvec, struct lruvec *parent_lruvec,
> +				     int zone, int type)
> +{
> +	struct lru_gen_folio *child_lrugen, *parent_lrugen;
> +	enum lru_list lru = type * LRU_INACTIVE_FILE;
> +	int i;

[ ... ]

> +		WRITE_ONCE(child_lrugen->nr_pages[gen][type][zone], 0);
> +		WRITE_ONCE(parent_lrugen->nr_pages[gen][type][zone],
> +			   parent_lrugen->nr_pages[gen][type][zone] + nr_pages);
> +
> +		update_lru_size(parent_lruvec, lru + dst_lru_active, zone, nr_pages);
                ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

This update_lru_size() call updates both __update_lru_size() counters and
mem_cgroup_update_lru_size(). However, lru_gen_reparent_memcg() also calls
mem_cgroup_update_lru_size() for LRU_UNEVICTABLE. The combination appears
to cause incorrect accounting.

Note: This issue was fixed in later commit ("mm: mglru: do not call
update_lru_size() during reparenting").

> +	}
> +}


