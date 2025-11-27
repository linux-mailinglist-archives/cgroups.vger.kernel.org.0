Return-Path: <cgroups+bounces-12228-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 848C3C8CC57
	for <lists+cgroups@lfdr.de>; Thu, 27 Nov 2025 04:49:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3E2EF3AECD0
	for <lists+cgroups@lfdr.de>; Thu, 27 Nov 2025 03:49:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A9782C0285;
	Thu, 27 Nov 2025 03:49:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="MprLPJcp"
X-Original-To: cgroups@vger.kernel.org
Received: from out-173.mta0.migadu.com (out-173.mta0.migadu.com [91.218.175.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C71D2BE644
	for <cgroups@vger.kernel.org>; Thu, 27 Nov 2025 03:49:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764215378; cv=none; b=MdrrtHaOPCxfuIZZRTzXS/9abMtPS26UV7sAmhu2moG87gFa3WuzmK29PQlv6lYUd7tp27q6xhU54CEa+4M9f9R69gvAf74xEiiBieeU+k9QUoyyM+Ddqqfuqk2iV+KC768r4/0Engxiy4njrnBnR7TDbQ8ptHimV6KMSl+xEVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764215378; c=relaxed/simple;
	bh=g446QZGMSDjjyrEPxr6CBgPHA23xc/sZfOCx4f7ZO0Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ApN0inrCQFpllY12MTfgK0mbWaZwvlbV/dOZv0gsKmYxllL10cCurHQU4SvhGe8rsNgfCkqIhEvy8Fz7/90Ab6W6fFeI6/51+sM8E3vIFo3mKF7EpCCEsR6zum86vID1f+G02dlMCa/roiANCW9PNcI+DLVjDduKm3CVQXSPFiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=MprLPJcp; arc=none smtp.client-ip=91.218.175.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <363eac01-4dd3-44c2-835a-1c843c9ad176@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1764215371;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hQ0ZXYaEsqXDUL5h8p3v+NwU49BKhktpBBnYsZDc89I=;
	b=MprLPJcpPK1AcE4rMa8EQXQpeJ8xaMTQGBfWxH6LezFLbZf+L6bnUsNF/Ns+IavWjiNpuv
	JbTSaofPAHEMDRMzawPDXRQ1/ZUX4WK2W+QJBN1PXCrUoZOQlS1cCeNa0kSnICyk5aim5W
	nZ9cof3nDUTQf6/5y1Fjdl4Jhb4qi3Q=
Date: Thu, 27 Nov 2025 11:48:30 +0800
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
 <aScFNZjGficdjnvD@hyeyoo>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Qi Zheng <qi.zheng@linux.dev>
In-Reply-To: <aScFNZjGficdjnvD@hyeyoo>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 11/26/25 9:48 PM, Harry Yoo wrote:
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
> 
> I was testing this series and observed two warnings...
> 
>> +		for (type = 0; type < ANON_AND_FILE; type++) {
>> +			while (get_nr_gens(lruvec, type) < MAX_NR_GENS) {
>> +				DEFINE_MAX_SEQ(lruvec);
>> +
>> +				inc_max_seq(lruvec, max_seq, mem_cgroup_swappiness(memcg));
>> +				cond_resched();
> 
> Warning 1) Here we increment max_seq but we skip updating mm_state->seq.
> (try_to_inc_max_seq() iterates the mm list and update mm_state->seq after
> an iteration, but since we directly call inc_max_seq(), we don't update it)
> 
> When mm_state->seq is more than one generation behind walk->seq, a warning is
> triggered in iterate_mm_list():
> 
>          VM_WARN_ON_ONCE(mm_state->seq + 1 < walk->max_seq);
> 
> Warning 2) In try_to_inc_max_seq(), the last walker of mm list
> is supposed to succeed to increment max_seq by calling inc_max_seq():
> 
>          if (success) {
>                   success = inc_max_seq(lruvec, seq, swappiness);
>                   WARN_ON_ONCE(!success);
>           }
> 
> But with this patch it may observe the max_seq is already advanced due to
> reparenting and thus inc_max_seq() returns false, triggering the warning.

Got it. Thanks for testing and reporting!

> 
> I'm learning MGLRU internals to see whether we can simply remove the warnings
> or if we need to do something to advance max_seq without actually iterating
> over the mm list.

Thanks! I will also check on this.

> 


