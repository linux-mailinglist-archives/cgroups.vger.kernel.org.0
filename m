Return-Path: <cgroups+bounces-13308-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id CE0F0D39D2B
	for <lists+cgroups@lfdr.de>; Mon, 19 Jan 2026 04:40:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5C9CA300D49A
	for <lists+cgroups@lfdr.de>; Mon, 19 Jan 2026 03:40:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2DB9280A5B;
	Mon, 19 Jan 2026 03:40:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Vb18RKe9"
X-Original-To: cgroups@vger.kernel.org
Received: from out-173.mta1.migadu.com (out-173.mta1.migadu.com [95.215.58.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8078924469E
	for <cgroups@vger.kernel.org>; Mon, 19 Jan 2026 03:40:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768794006; cv=none; b=WsQFnOatmw4DLtmh9SJqApviWaKYAD5N7mpwbeEdGsbjxlxA99fwUQNxET/lMqy6OGeVPaZshYBPLtgv9B8y+Rp8Vzdzp4OGqvyVX2qJDIhd12DLitUemQtWma8GF00RCsUmKFOp0yqWrOWn+1e8/JPpO06JRBwzRQE76unCipc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768794006; c=relaxed/simple;
	bh=cZb81msBA/aSBX3ucu5D8bazXfnOfZbGbabhEfUbzBE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=s3iE0+p7EDAd/RmIvhx2CByeiJt/mCdPZr9zuHOnMzJUXANE7KGeU/UawEUm0g6m9HTerZ6SDLB1Vf0s9JkWltpE2QV4aIhJOfv5NytZOCvfXxyUNzaxtdsrG70YQiqcZbcSHYL4zn+fYOPzsP11UjinjpmAmcswYgaGO4aRtOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Vb18RKe9; arc=none smtp.client-ip=95.215.58.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <7cd937c3-148c-43ed-ac51-18d90cb9a5cc@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1768794002;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UUhhhWP2jSDUI41mEAYgwc1tmgkjJxYhACRaQUEM408=;
	b=Vb18RKe9L/jlWkEUZ70IlnlFdjiOwcuHVpqI0uvYrIG4CC4RcGyYPsamjIXs65AM5726cL
	n8YSQrMKJEUEfheCvIftZjf3eCjXZj266U+GOK0MgZp43Ltkw1RROLEJ31qcJkUZSwHxbr
	I41DnLIyGS7t8xTuMVk7Tx1stkQmZ5w=
Date: Mon, 19 Jan 2026 11:39:37 +0800
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v3 26/30] mm: vmscan: prepare for reparenting MGLRU folios
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: hannes@cmpxchg.org, hughd@google.com, mhocko@suse.com,
 roman.gushchin@linux.dev, muchun.song@linux.dev, david@kernel.org,
 lorenzo.stoakes@oracle.com, ziy@nvidia.com, harry.yoo@oracle.com,
 yosry.ahmed@linux.dev, imran.f.khan@oracle.com, kamalesh.babulal@oracle.com,
 axelrasmussen@google.com, yuanchu@google.com, weixugc@google.com,
 chenridong@huaweicloud.com, mkoutny@suse.com, akpm@linux-foundation.org,
 hamzamahfooz@linux.microsoft.com, apais@linux.microsoft.com,
 lance.yang@linux.dev, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 cgroups@vger.kernel.org, Qi Zheng <zhengqi.arch@bytedance.com>
References: <cover.1768389889.git.zhengqi.arch@bytedance.com>
 <92e0728fed3d68855173352416cf8077670610f0.1768389889.git.zhengqi.arch@bytedance.com>
 <mhxt3oheta2enk562jt25qdac2tkq6ulc3olxairfow6tb5qpl@n5dhssfcyhea>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Qi Zheng <qi.zheng@linux.dev>
In-Reply-To: <mhxt3oheta2enk562jt25qdac2tkq6ulc3olxairfow6tb5qpl@n5dhssfcyhea>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 1/18/26 11:29 AM, Shakeel Butt wrote:
> I asked AI to review this patch and it find following potential issues:

Thanks.

> 
> Author: Qi Zheng <zhengqi.arch@bytedance.com>
> 
> mm: vmscan: prepare for reparenting MGLRU folios
> 
> This commit adds infrastructure for reparenting MGLRU folios from dying
> memcg to parent memcg, including functions to ensure parent has MAX_NR_GENS
> generations before reparenting.
> 
> Link: https://lkml.kernel.org/r/92e0728fed3d68855173352416cf8077670610f0.1768389889.git.zhengqi.arch@bytedance.com
> 
>> diff --git a/mm/vmscan.c b/mm/vmscan.c
>> index f1a45c94c2fc..284292653d14 100644
>> --- a/mm/vmscan.c
>> +++ b/mm/vmscan.c
> 
> [ ... ]
> 
>> +static void try_to_inc_max_seq_nowalk(struct mem_cgroup *memcg,
>> +				      struct lruvec *lruvec)
>> +{
>> +	struct lru_gen_mm_list *mm_list = get_mm_list(memcg);
>> +	struct lru_gen_mm_state *mm_state = get_mm_state(lruvec);
>> +	int swappiness = mem_cgroup_swappiness(memcg);
>> +	DEFINE_MAX_SEQ(lruvec);
>> +	bool success = false;
>> +
>> +	/*
>> +	 * We are not iterating the mm_list here, updating mm_state->seq is just
>> +	 * to make mm walkers work properly.
>> +	 */
>> +	if (mm_state) {
>> +		spin_lock(&mm_list->lock);
>> +		VM_WARN_ON_ONCE(mm_state->seq + 1 < max_seq);
>> +		if (max_seq > mm_state->seq) {
>                      ^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> 
> When mm_state->seq equals max_seq (which can happen when mm walkers have
> completed their iteration), this condition is false, success remains false,
> and inc_max_seq() is never called.

I expect that once mm walkers complete their iterations, the number of
generations will have increased, so it won't cause an infinite loop.

> 
> The caller max_lru_gen_memcg() loops with:
> 
>      while (get_nr_gens(lruvec, type) < MAX_NR_GENS) {
>          try_to_inc_max_seq_nowalk(memcg, lruvec);
>          cond_resched();
>      }
> 
> If try_to_inc_max_seq_nowalk() fails to increment max_seq, get_nr_gens()
> returns the same value, and the while loop continues indefinitely.
> 
> Can this cause an infinite loop during memcg offline when mm_state->seq has
> caught up to max_seq?
> 
> Suggested fix: Remove the success variable and always call inc_max_seq().
> The mm_state->seq update is only for coordination with mm walkers - it should
> not gate whether we increment the generation. inc_max_seq() has its own
> staleness check (seq < READ_ONCE(lrugen->max_seq)) so calling it unconditionally
> is safe:
> 
>      if (mm_state) {
>          spin_lock(&mm_list->lock);
>          VM_WARN_ON_ONCE(mm_state->seq + 1 < max_seq);
>          if (max_seq > mm_state->seq)
>              WRITE_ONCE(mm_state->seq, mm_state->seq + 1);
>          spin_unlock(&mm_list->lock);
>      }
> 
>      inc_max_seq(lruvec, max_seq, swappiness);
> 
>> +			WRITE_ONCE(mm_state->seq, mm_state->seq + 1);
>> +			success = true;
>> +		}
>> +		spin_unlock(&mm_list->lock);
>> +	} else {
>> +		success = true;
>> +	}
>> +
>> +	if (success)
>> +		inc_max_seq(lruvec, max_seq, swappiness);
>> +}
> 
> [ ... ]
> 
>> +static void __lru_gen_reparent_memcg(struct lruvec *child_lruvec, struct lruvec *parent_lruvec,
>> +				     int zone, int type)
>> +{
>> +	struct lru_gen_folio *child_lrugen, *parent_lrugen;
>> +	enum lru_list lru = type * LRU_INACTIVE_FILE;
>> +	int i;
> 
> [ ... ]
> 
>> +		WRITE_ONCE(child_lrugen->nr_pages[gen][type][zone], 0);
>> +		WRITE_ONCE(parent_lrugen->nr_pages[gen][type][zone],
>> +			   parent_lrugen->nr_pages[gen][type][zone] + nr_pages);
>> +
>> +		update_lru_size(parent_lruvec, lru + dst_lru_active, zone, nr_pages);
>                  ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> 
> This update_lru_size() call updates both __update_lru_size() counters and
> mem_cgroup_update_lru_size(). However, lru_gen_reparent_memcg() also calls
> mem_cgroup_update_lru_size() for LRU_UNEVICTABLE. The combination appears
> to cause incorrect accounting.
> 
> Note: This issue was fixed in later commit ("mm: mglru: do not call
> update_lru_size() during reparenting").

Right.

> 
>> +	}
>> +}
> 


