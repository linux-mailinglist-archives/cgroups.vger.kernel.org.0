Return-Path: <cgroups+bounces-12202-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 77F61C87DC0
	for <lists+cgroups@lfdr.de>; Wed, 26 Nov 2025 03:45:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id CCB32355317
	for <lists+cgroups@lfdr.de>; Wed, 26 Nov 2025 02:45:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D43123ABBD;
	Wed, 26 Nov 2025 02:45:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="EinoyG3g"
X-Original-To: cgroups@vger.kernel.org
Received: from out-182.mta1.migadu.com (out-182.mta1.migadu.com [95.215.58.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FE9212B94
	for <cgroups@vger.kernel.org>; Wed, 26 Nov 2025 02:45:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764125134; cv=none; b=YEV5cmh5ZLEoIVTmKGOy0oYgXT2tZbEJQN8cbKLu2M6/25Eh9q4J+vL99DaobYpwfS2CZdhyKZyhMzK9lRMwcKvWh5wmbOtZBVYNUnXAifvifX4AsyB3DvvcUI6JqyhyGQa5K43734MDc64LU0MxWt8wUmIgO8ycckl6JakUT4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764125134; c=relaxed/simple;
	bh=aiGiaIj/VyQQZ5dTY0c1DLfh7BEpBbzowFBta7DP6oQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PVG+yL2alVxp2uHLSxSubPYbQF5HHkdiP8Gw2JCEPzpzcM9O2NJsptXGzqz8gGv9RunCYuOt6U+KNhI3KAhmLv1YxgbUFiO0an4go08ziY/BTRvMcEIYACEnLbSyZuzVam0irOwpp7Wu+ZotjDRarlSSriBwIt6AI0EiEbnWLnQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=EinoyG3g; arc=none smtp.client-ip=95.215.58.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <f208ee30-c0b1-426b-b5e6-5ab358877ad4@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1764125119;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WR/tG/fXd1FIx5kgs0c7mUUaG40bMBvPGKIqdKa16DI=;
	b=EinoyG3gLBkrH9Rc9OfSH7oVgLRpr9vJlvoqwGPC96MiTQv8DiMdvSshDddppOpgPVRSof
	O1xmrW+BPJqmU93kJgVFre4hks7hQuEGXqOtUNImUjjXEFf+Ph+KS/VJhsjQPWS/C2jBlF
	cMncr+rrLcPXKJ1MwN+BIbvIJ9P4uMg=
Date: Wed, 26 Nov 2025 10:44:05 +0800
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v1 23/26] mm: vmscan: prepare for reparenting MGLRU folios
To: Harry Yoo <harry.yoo@oracle.com>
Cc: hannes@cmpxchg.org, hughd@google.com, mhocko@suse.com,
 roman.gushchin@linux.dev, shakeel.butt@linux.dev, muchun.song@linux.dev,
 david@redhat.com, lorenzo.stoakes@oracle.com, ziy@nvidia.com,
 imran.f.khan@oracle.com, kamalesh.babulal@oracle.com,
 axelrasmussen@google.com, yuanchu@google.com, weixugc@google.com,
 akpm@linux-foundation.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 cgroups@vger.kernel.org, Qi Zheng <zhengqi.arch@bytedance.com>
References: <cover.1761658310.git.zhengqi.arch@bytedance.com>
 <cdcedd284f5706c557bb6f53858b8c2ac2815ecb.1761658311.git.zhengqi.arch@bytedance.com>
 <aSV9ANXym0UDhE2j@hyeyoo>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Qi Zheng <qi.zheng@linux.dev>
In-Reply-To: <aSV9ANXym0UDhE2j@hyeyoo>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 11/25/25 5:55 PM, Harry Yoo wrote:
> On Tue, Oct 28, 2025 at 09:58:36PM +0800, Qi Zheng wrote:
>> From: Qi Zheng <zhengqi.arch@bytedance.com>
>>
>> Similar to traditional LRU folios, in order to solve the dying memcg
>> problem, we also need to reparenting MGLRU folios to the parent memcg when
>> memcg offline.
>>
>> However, there are the following challenges:
>>
>> 1. Each lruvec has between MIN_NR_GENS and MAX_NR_GENS generations, the
>>     number of generations of the parent and child memcg may be different,
>>     so we cannot simply transfer MGLRU folios in the child memcg to the
>>     parent memcg as we did for traditional LRU folios.
>> 2. The generation information is stored in folio->flags, but we cannot
>>     traverse these folios while holding the lru lock, otherwise it may
>>     cause softlockup.
>> 3. In walk_update_folio(), the gen of folio and corresponding lru size
>>     may be updated, but the folio is not immediately moved to the
>>     corresponding lru list. Therefore, there may be folios of different
>>     generations on an LRU list.
>> 4. In lru_gen_del_folio(), the generation to which the folio belongs is
>>     found based on the generation information in folio->flags, and the
>>     corresponding LRU size will be updated. Therefore, we need to update
>>     the lru size correctly during reparenting, otherwise the lru size may
>>     be updated incorrectly in lru_gen_del_folio().
>>
>> Finally, this patch chose a compromise method, which is to splice the lru
>> list in the child memcg to the lru list of the same generation in the
>> parent memcg during reparenting. And in order to ensure that the parent
>> memcg has the same generation, we need to increase the generations in the
>> parent memcg to the MAX_NR_GENS before reparenting.
>>
>> Of course, the same generation has different meanings in the parent and
>> child memcg, this will cause confusion in the hot and cold information of
>> folios. But other than that, this method is simple enough, the lru size
>> is correct, and there is no need to consider some concurrency issues (such
>> as lru_gen_del_folio()).
>>
>> To prepare for the above work, this commit implements the specific
>> functions, which will be used during reparenting.
>>
>> Suggested-by: Harry Yoo <harry.yoo@oracle.com>
>> Suggested-by: Imran Khan <imran.f.khan@oracle.com>
>> Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
>> ---
>>   include/linux/mmzone.h | 16 ++++++++
>>   mm/vmscan.c            | 86 ++++++++++++++++++++++++++++++++++++++++++
>>   2 files changed, 102 insertions(+)
>>
>> diff --git a/mm/vmscan.c b/mm/vmscan.c
>> index 7aa8e1472d10d..3ee7fb96b8aeb 100644
>> --- a/mm/vmscan.c
>> +++ b/mm/vmscan.c
>> @@ -4468,6 +4468,92 @@ void lru_gen_soft_reclaim(struct mem_cgroup *memcg, int nid)
>>   		lru_gen_rotate_memcg(lruvec, MEMCG_LRU_HEAD);
>>   }
>>   
>> +bool recheck_lru_gen_max_memcg(struct mem_cgroup *memcg)
>> +{
>> +	int nid;
>> +
>> +	for_each_node(nid) {
>> +		struct lruvec *lruvec = get_lruvec(memcg, nid);
>> +		int type;
>> +
>> +		for (type = 0; type < ANON_AND_FILE; type++) {
>> +			if (get_nr_gens(lruvec, type) != MAX_NR_GENS)
>> +				return false;
>> +		}
>> +	}
>> +
>> +	return true;
>> +}
>> +
>> +/*
>> + * We need to ensure that the folios of child memcg can be reparented to the
>> + * same gen of the parent memcg, so the gens of the parent memcg needed be
>> + * incremented to the MAX_NR_GENS before reparenting.
>> + */
>> +void max_lru_gen_memcg(struct mem_cgroup *memcg)
>> +{
>> +	int nid;
>> +
>> +	for_each_node(nid) {
>> +		struct lruvec *lruvec = get_lruvec(memcg, nid);
>> +		int type;
>> +
>> +		for (type = 0; type < ANON_AND_FILE; type++) {
>> +			while (get_nr_gens(lruvec, type) < MAX_NR_GENS) {
>> +				DEFINE_MAX_SEQ(lruvec);
>> +
>> +				inc_max_seq(lruvec, max_seq, mem_cgroup_swappiness(memcg));
>> +				cond_resched();
>> +			}
> 
> To best of my knowledge this looks functionally correct.
> 
>> +		}
>> +	}
>> +}
>> +
>> +static void __lru_gen_reparent_memcg(struct lruvec *src_lruvec, struct lruvec *dst_lruvec,
>> +				     int zone, int type)
>> +{
>> +	struct lru_gen_folio *src_lrugen, *dst_lrugen;
>> +	enum lru_list lru = type * LRU_INACTIVE_FILE;
>> +	int i;
>> +
>> +	src_lrugen = &src_lruvec->lrugen;
>> +	dst_lrugen = &dst_lruvec->lrugen;
>> +
>> +	for (i = 0; i < get_nr_gens(src_lruvec, type); i++) {
>> +		int gen = lru_gen_from_seq(src_lrugen->max_seq - i);
>> +		int nr_pages = src_lrugen->nr_pages[gen][type][zone];
> 
> nr_pages should be long type since nothing prevents us from reparenting
> more than 2 billions of pages :)

Right. The lru_gen_folio.nr_pages is long type, I don't know how I ended
up writing it as an int type.

Will fix it in the next version.

> 
> Otherwise looks correct to me.

Thanks!

> 


