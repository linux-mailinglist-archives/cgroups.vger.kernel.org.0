Return-Path: <cgroups+bounces-13356-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8Mf4EpeMcWkLJAAAu9opvQ
	(envelope-from <cgroups+bounces-13356-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Thu, 22 Jan 2026 03:33:59 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id F308C60FA5
	for <lists+cgroups@lfdr.de>; Thu, 22 Jan 2026 03:33:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1CE4A8480CB
	for <lists+cgroups@lfdr.de>; Thu, 22 Jan 2026 02:33:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7140F37FF78;
	Thu, 22 Jan 2026 02:33:19 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2889243376;
	Thu, 22 Jan 2026 02:33:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769049196; cv=none; b=FmrTvuuWFA1BOzdNoTeKL27w+fHMtXXHqq55uei9L5X+iDzq2DU8IjJTis5RhgfTd2PC/WACuUUbG2U7iyg3CXno4/1wX6jZf9XpXsBIWskRvUjOMwuc6fwYAmeWM/WpFF5ajATUC61zhaIXkOci0T0IOzLA+ngFLPWKg67rjxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769049196; c=relaxed/simple;
	bh=rGA7qq7DyPj6fxmntp30HOn//LJ7gXcsKuKBrtSvK5g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XR5kUAMkvzXFem1udlzJs/abUCR9gaucom+sao9aYIGI7kvyUjMSBYJSwVijF4d3UrmThTxiYwzA0cgBApFQCuu1sm546dkh+yLZNVhtjt0rQlKuDFyBbBuV5LLzzk6jhOQTNEoiH2fuwNJlEfDQPaovBYEInDyoBljwPrlu1Vs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=none smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.170])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4dxQ8P49tczKHM07;
	Thu, 22 Jan 2026 10:32:53 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 329AF4056E;
	Thu, 22 Jan 2026 10:32:56 +0800 (CST)
Received: from [10.67.111.176] (unknown [10.67.111.176])
	by APP4 (Coremail) with SMTP id gCh0CgA35vZUjHFpwPuoEg--.20525S2;
	Thu, 22 Jan 2026 10:32:53 +0800 (CST)
Message-ID: <52f8db5b-58c6-4a2c-a533-53556072ecb5@huaweicloud.com>
Date: Thu, 22 Jan 2026 10:32:51 +0800
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH -next 1/7] vmscan: add memcg heat level for reclaim
To: Kairui Song <ryncsn@gmail.com>
Cc: akpm@linux-foundation.org, axelrasmussen@google.com, yuanchu@google.com,
 weixugc@google.com, david@kernel.org, lorenzo.stoakes@oracle.com,
 Liam.Howlett@oracle.com, vbabka@suse.cz, rppt@kernel.org, surenb@google.com,
 mhocko@suse.com, corbet@lwn.net, skhan@linuxfoundation.org,
 hannes@cmpxchg.org, roman.gushchin@linux.dev, shakeel.butt@linux.dev,
 muchun.song@linux.dev, zhengqi.arch@bytedance.com, linux-mm@kvack.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 cgroups@vger.kernel.org, lujialin4@huawei.com
References: <20260120134256.2271710-1-chenridong@huaweicloud.com>
 <20260120134256.2271710-2-chenridong@huaweicloud.com>
 <aXDfTiDrUHbQaFWX@KASONG-MC4>
Content-Language: en-US
From: Chen Ridong <chenridong@huaweicloud.com>
In-Reply-To: <aXDfTiDrUHbQaFWX@KASONG-MC4>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgA35vZUjHFpwPuoEg--.20525S2
X-Coremail-Antispam: 1UD129KBjvAXoWfGF17CryxKF4xXFyftr47Arb_yoW8WF1kAo
	WS9r13X3Z2kr1UZw4qvas7JrZ8u3Wqkw4UZr15ZwsrZF1qva4UW3WkAa18AFWfXF43tr1U
	uFyxXayDAFZ2q3Zxn29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7v73VFW2AGmfu7bjvjm3
	AaLaJ3UjIYCTnIWjp_UUUY27kC6x804xWl14x267AKxVW5JVWrJwAFc2x0x2IEx4CE42xK
	8VAvwI8IcIk0rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4
	AK67xGY2AK021l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF
	7I0E14v26r4UJVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7
	CjxVAFwI0_GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8C
	rVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4
	IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwACI402YVCY1x02628vn2kIc2xKxwCY1x0262kK
	e7AKxVW8ZVWrXwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c
	02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_GFv_
	WrylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7
	CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v2
	6r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07
	jIksgUUUUU=
X-CM-SenderInfo: hfkh02xlgr0w46kxt4xhlfz01xgou0bp/
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.26 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:7979, ipnet:2605:f480::/32, country:US];
	FREEMAIL_TO(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[24];
	MIME_TRACE(0.00)[0:+];
	MID_RHS_MATCH_FROM(0.00)[];
	DMARC_NA(0.00)[huaweicloud.com];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[chenridong@huaweicloud.com,cgroups@vger.kernel.org];
	R_DKIM_NA(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	TAGGED_FROM(0.00)[bounces-13356-lists,cgroups=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[6];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[]
X-Rspamd-Queue-Id: F308C60FA5
X-Rspamd-Action: no action



On 2026/1/21 22:58, Kairui Song wrote:
> On Tue, Jan 20, 2026 at 01:42:50PM +0800, Chen Ridong wrote:
>> From: Chen Ridong <chenridong@huawei.com>
>>
>> The memcg LRU was originally introduced to improve scalability during
>> global reclaim. However, it is complex and only works with gen lru
>> global reclaim. Moreover, its implementation complexity has led to
>> performance regressions when handling a large number of memory cgroups [1].
>>
>> This patch introduces a per-memcg heat level for reclaim, aiming to unify
>> gen lru and traditional LRU global reclaim. The core idea is to track
>> per-node per-memcg reclaim state, including heat, last_decay, and
>> last_refault. The last_refault records the total reclaimed data from the
>> previous memcg reclaim. The last_decay is a time-based parameter; the heat
>> level decays over time if the memcg is not reclaimed again. Both last_decay
>> and last_refault are used to calculate the current heat level when reclaim
>> starts.
>>
>> Three reclaim heat levels are defined: cold, warm, and hot. Cold memcgs are
>> reclaimed first; only if cold memcgs cannot reclaim enough pages, warm
>> memcgs become eligible for reclaim. Hot memcgs are reclaimed last.
>>
>> While this design can be applied to all memcg reclaim scenarios, this patch
>> is conservative and only introduces heat levels for traditional LRU global
>> reclaim. Subsequent patches will replace the memcg LRU with
>> heat-level-based reclaim.
>>
>> Based on tests provided by YU Zhao, traditional LRU global reclaim shows
>> significant performance improvement with heat-level reclaim enabled.
>>
>> The results below are from a 2-hour run of the test [2].
>>
>> Throughput (number of requests)		before	   after	Change
>> Total					1734169    2353717	+35%
>>
>> Tail latency (number of requests)	before	   after	Change
>> [128s, inf)				1231	   1057		-14%
>> [64s, 128s)				586	   444		-24%
>> [32s, 64s)				1658	   1061		-36%
>> [16s, 32s)				4611	   2863		-38%
>>
>> [1] https://lore.kernel.org/r/20251126171513.GC135004@cmpxchg.org
>> [2] https://lore.kernel.org/all/20221220214923.1229538-1-yuzhao@google.com/
> 
> Hi Ridong,
> 
> Thanks very much for checking the test! The benchmark looks good.
> 
> While I don't have strong opinion on the whole approach yet as I'm
> still checking the whole series. But I have some comment and question
> for this patch:
> 

Hi Kairui,

Thank you for your attention

>>
>> Signed-off-by: Chen Ridong <chenridong@huawei.com>
>> ---
>>  include/linux/memcontrol.h |   7 ++
>>  mm/memcontrol.c            |   3 +
>>  mm/vmscan.c                | 227 +++++++++++++++++++++++++++++--------
>>  3 files changed, 192 insertions(+), 45 deletions(-)
>>
>> diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
>> index af352cabedba..b293caf70034 100644
>> --- a/include/linux/memcontrol.h
>> +++ b/include/linux/memcontrol.h
>> @@ -76,6 +76,12 @@ struct memcg_vmstats;
>>  struct lruvec_stats_percpu;
>>  struct lruvec_stats;
>>  
>> +struct memcg_reclaim_state {
>> +	atomic_long_t heat;
>> +	unsigned long last_decay;
>> +	atomic_long_t last_refault;
>> +};
>> +
>>  struct mem_cgroup_reclaim_iter {
>>  	struct mem_cgroup *position;
>>  	/* scan generation, increased every round-trip */
>> @@ -114,6 +120,7 @@ struct mem_cgroup_per_node {
>>  	CACHELINE_PADDING(_pad2_);
>>  	unsigned long		lru_zone_size[MAX_NR_ZONES][NR_LRU_LISTS];
>>  	struct mem_cgroup_reclaim_iter	iter;
>> +	struct memcg_reclaim_state	reclaim;
>>  
>>  #ifdef CONFIG_MEMCG_NMI_SAFETY_REQUIRES_ATOMIC
>>  	/* slab stats for nmi context */
>> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
>> index f2b87e02574e..675d49ad7e2c 100644
>> --- a/mm/memcontrol.c
>> +++ b/mm/memcontrol.c
>> @@ -3713,6 +3713,9 @@ static bool alloc_mem_cgroup_per_node_info(struct mem_cgroup *memcg, int node)
>>  
>>  	lruvec_init(&pn->lruvec);
>>  	pn->memcg = memcg;
>> +	atomic_long_set(&pn->reclaim.heat, 0);
>> +	pn->reclaim.last_decay = jiffies;
>> +	atomic_long_set(&pn->reclaim.last_refault, 0);
>>  
>>  	memcg->nodeinfo[node] = pn;
>>  	return true;
>> diff --git a/mm/vmscan.c b/mm/vmscan.c
>> index 4aa73f125772..3759cd52c336 100644
>> --- a/mm/vmscan.c
>> +++ b/mm/vmscan.c
>> @@ -5978,6 +5978,124 @@ static inline bool should_continue_reclaim(struct pglist_data *pgdat,
>>  	return inactive_lru_pages > pages_for_compaction;
>>  }
>>  
>> +enum memcg_scan_level {
>> +	MEMCG_LEVEL_COLD,
>> +	MEMCG_LEVEL_WARM,
>> +	MEMCG_LEVEL_HOT,
>> +	MEMCG_LEVEL_MAX,
>> +};
> 
> This looks similar to MEMCG_LRU_HEAD, MEMCG_LRU_TAIL, MEMCG_LRU_OLD,
> MEMCG_LRU_YOUNG of the memcg LRU? But now it's unaware of the aging event?
> 

That's a good comparison. Those memcg LRU states are indeed similar, whereas the
aging event is unique to the generational LRU.

The goal is to devise an approach that works for both LRU types and across both
root and memcg reclaim.

>> +
>> +#define MEMCG_HEAT_WARM		4
>> +#define MEMCG_HEAT_HOT		8
>> +#define MEMCG_HEAT_MAX		12
>> +#define MEMCG_HEAT_DECAY_STEP	1
>> +#define MEMCG_HEAT_DECAY_INTERVAL	(1 * HZ)
> 
> This is a hardcoded interval (1s), but memcg_decay_heat is driven by reclaim
> which is kind of random, could be very frequent or not happening at all,
> that doesn't look pretty by first look.
> 
>> +
>> +static void memcg_adjust_heat(struct mem_cgroup_per_node *pn, long delta)
>> +{
>> +	long heat, new_heat;
>> +
>> +	if (mem_cgroup_is_root(pn->memcg))
>> +		return;
>> +
>> +	heat = atomic_long_read(&pn->reclaim.heat);
>> +	do {
>> +		new_heat = clamp_t(long, heat + delta, 0, MEMCG_HEAT_MAX);
> 
> The hotness range is 0 - 12, is that a suitable value for all setup and
> workloads?
> 

That's an excellent question. It is challenging to find a single parameter value
(whether hotness range or decay time) that performs optimally across all
possible setups and workloads. The initial value may need to be set empirically
based on common cases or with benchmark.

As for a path forward, we could consider two approaches:

Set a sensible default based on empirical data, and provide a BPF hook to allow
users to tune it for their specific needs.

Explore a self-adaptive algorithm in the future, though this would likely add
significant complexity.

I'm open to other suggestions on how best to handle this.

>> +		if (atomic_long_cmpxchg(&pn->reclaim.heat, heat, new_heat) == heat)
>> +			break;
>> +		heat = atomic_long_read(&pn->reclaim.heat);
>> +	} while (1);
>> +}
>> +
>> +static void memcg_decay_heat(struct mem_cgroup_per_node *pn)
>> +{
>> +	unsigned long last;
>> +	unsigned long now = jiffies;
>> +
>> +	if (mem_cgroup_is_root(pn->memcg))
>> +		return;
>> +
>> +	last = READ_ONCE(pn->reclaim.last_decay);
>> +	if (!time_after(now, last + MEMCG_HEAT_DECAY_INTERVAL))
>> +		return;
>> +
>> +	if (cmpxchg(&pn->reclaim.last_decay, last, now) != last)
>> +		return;
>> +
>> +	memcg_adjust_heat(pn, -MEMCG_HEAT_DECAY_STEP);
>> +}
>> +
>> +static int memcg_heat_level(struct mem_cgroup_per_node *pn)
>> +{
>> +	long heat;
>> +
>> +	if (mem_cgroup_is_root(pn->memcg))
>> +		return MEMCG_LEVEL_COLD;
>> +
>> +	memcg_decay_heat(pn);
>> +	heat = atomic_long_read(&pn->reclaim.heat);
>> +
>> +	if (heat >= MEMCG_HEAT_HOT)
>> +		return MEMCG_LEVEL_HOT;
>> +	if (heat >= MEMCG_HEAT_WARM)
>> +		return MEMCG_LEVEL_WARM;
>> +	return MEMCG_LEVEL_COLD;
>> +}
>> +
>> +static void memcg_record_reclaim_result(struct mem_cgroup_per_node *pn,
>> +					struct lruvec *lruvec,
>> +					unsigned long scanned,
>> +					unsigned long reclaimed)
>> +{
>> +	long delta;
>> +
>> +	if (mem_cgroup_is_root(pn->memcg))
>> +		return;
>> +
>> +	memcg_decay_heat(pn);
>> +
>> +	/*
>> +	 * Memory cgroup heat adjustment algorithm:
>> +	 * - If scanned == 0: mark as hottest (+MAX_HEAT)
>> +	 * - If reclaimed >= 50% * scanned: strong cool (-2)
>> +	 * - If reclaimed >= 25% * scanned: mild cool (-1)
>> +	 * - Otherwise:  warm up (+1)
> 
> The naming is bit of confusing I think, no scan doesn't mean it's all hot.
> Maybe you mean no reclaim? No scan could also mean a empty memcg?
> 

When a memcg has no pages to scan for reclaim(scanned == 0), we treat it as the
hottest. This applies to empty memcgs as well, since there is nothing to
reclaim. Therefore, the reclaim process should skip these memcgs as possible.

>> +	 */
>> +	if (!scanned)
>> +		delta = MEMCG_HEAT_MAX;
>> +	else if (reclaimed * 2 >= scanned)
>> +		delta = -2;
>> +	else if (reclaimed * 4 >= scanned)
>> +		delta = -1;
>> +	else
>> +		delta = 1;
>> +
>> +	/*
>> +	 * Refault-based heat adjustment:
>> +	 * - If refault increase > reclaimed pages: heat up (more cautious reclaim)
>> +	 * - If no refaults and currently warm:     cool down (allow more reclaim)
>> +	 * This prevents thrashing by backing off when refaults indicate over-reclaim.
>> +	 */
>> +	if (lruvec) {
>> +		unsigned long total_refaults;
>> +		unsigned long prev;
>> +		long refault_delta;
>> +
>> +		total_refaults = lruvec_page_state(lruvec, WORKINGSET_ACTIVATE_ANON);
>> +		total_refaults += lruvec_page_state(lruvec, WORKINGSET_ACTIVATE_FILE);
> 
> I think you want WORKINGSET_REFAULT_* or WORKINGSET_RESTORE_* here.

I've noted that lruvec->refaults currently uses WORKINGSET_ACTIVATE_*. All three
types (ACTIVATE_*, REFAULT_*, RESTORE_*) are valid options to consider. I will
run benchmarks to compare them and implement the one that yields the best
performance.

> 
>> +
>> +		prev = atomic_long_xchg(&pn->reclaim.last_refault, total_refaults);
>> +		refault_delta = total_refaults - prev;
>> +
>> +		if (refault_delta > reclaimed)
>> +			delta++;
>> +		else if (!refault_delta && delta > 0)
>> +			delta--;
>> +	}
>> +
>> +	memcg_adjust_heat(pn, delta);
>> +}
>> +
>>  static void shrink_node_memcgs(pg_data_t *pgdat, struct scan_control *sc)
>>  {
>>  	struct mem_cgroup *target_memcg = sc->target_mem_cgroup;
>> @@ -5986,7 +6104,8 @@ static void shrink_node_memcgs(pg_data_t *pgdat, struct scan_control *sc)
>>  	};
>>  	struct mem_cgroup_reclaim_cookie *partial = &reclaim;
>>  	struct mem_cgroup *memcg;
>> -
>> +	int level;
>> +	int max_level = root_reclaim(sc) ? MEMCG_LEVEL_MAX : MEMCG_LEVEL_WARM;
> 
> Why limit to MEMCG_LEVEL_WARM when it's not a root reclaim?
> 

As noted in the commit message, the design is intended to support both root and
non‑root reclaim. However, as a conservative first step, I currently limit the
logic to MEMCG_LEVEL_WARM only for root reclaim.

>>  	/*
>>  	 * In most cases, direct reclaimers can do partial walks
>>  	 * through the cgroup tree, using an iterator state that
>> @@ -5999,62 +6118,80 @@ static void shrink_node_memcgs(pg_data_t *pgdat, struct scan_control *sc)
>>  	if (current_is_kswapd() || sc->memcg_full_walk)
>>  		partial = NULL;
>>  
>> -	memcg = mem_cgroup_iter(target_memcg, NULL, partial);
>> -	do {
>> -		struct lruvec *lruvec = mem_cgroup_lruvec(memcg, pgdat);
>> -		unsigned long reclaimed;
>> -		unsigned long scanned;
>> -
>> -		/*
>> -		 * This loop can become CPU-bound when target memcgs
>> -		 * aren't eligible for reclaim - either because they
>> -		 * don't have any reclaimable pages, or because their
>> -		 * memory is explicitly protected. Avoid soft lockups.
>> -		 */
>> -		cond_resched();
>> +	for (level = MEMCG_LEVEL_COLD; level < max_level; level++) {
>> +		bool need_next_level = false;
>>  
>> -		mem_cgroup_calculate_protection(target_memcg, memcg);
>> +		memcg = mem_cgroup_iter(target_memcg, NULL, partial);
>> +		do {
>> +			struct lruvec *lruvec = mem_cgroup_lruvec(memcg, pgdat);
>> +			unsigned long reclaimed;
>> +			unsigned long scanned;
>> +			struct mem_cgroup_per_node *pn = memcg->nodeinfo[pgdat->node_id];
>>  
>> -		if (mem_cgroup_below_min(target_memcg, memcg)) {
>> -			/*
>> -			 * Hard protection.
>> -			 * If there is no reclaimable memory, OOM.
>> -			 */
>> -			continue;
>> -		} else if (mem_cgroup_below_low(target_memcg, memcg)) {
>>  			/*
>> -			 * Soft protection.
>> -			 * Respect the protection only as long as
>> -			 * there is an unprotected supply
>> -			 * of reclaimable memory from other cgroups.
>> +			 * This loop can become CPU-bound when target memcgs
>> +			 * aren't eligible for reclaim - either because they
>> +			 * don't have any reclaimable pages, or because their
>> +			 * memory is explicitly protected. Avoid soft lockups.
>>  			 */
>> -			if (!sc->memcg_low_reclaim) {
>> -				sc->memcg_low_skipped = 1;
>> +			cond_resched();
>> +
>> +			mem_cgroup_calculate_protection(target_memcg, memcg);
>> +
>> +			if (mem_cgroup_below_min(target_memcg, memcg)) {
>> +				/*
>> +				 * Hard protection.
>> +				 * If there is no reclaimable memory, OOM.
>> +				 */
>>  				continue;
>> +			} else if (mem_cgroup_below_low(target_memcg, memcg)) {
>> +				/*
>> +				 * Soft protection.
>> +				 * Respect the protection only as long as
>> +				 * there is an unprotected supply
>> +				 * of reclaimable memory from other cgroups.
>> +				 */
>> +				if (!sc->memcg_low_reclaim) {
>> +					sc->memcg_low_skipped = 1;
>> +					continue;
>> +				}
>> +				memcg_memory_event(memcg, MEMCG_LOW);
>>  			}
>> -			memcg_memory_event(memcg, MEMCG_LOW);
>> -		}
>>  
>> -		reclaimed = sc->nr_reclaimed;
>> -		scanned = sc->nr_scanned;
>> +			if (root_reclaim(sc) && memcg_heat_level(pn) > level) {
>> +				need_next_level = true;
>> +				continue;
>> +			}
>>  
>> -		shrink_lruvec(lruvec, sc);
>> +			reclaimed = sc->nr_reclaimed;
>> +			scanned = sc->nr_scanned;
>>  
>> -		shrink_slab(sc->gfp_mask, pgdat->node_id, memcg,
>> -			    sc->priority);
>> +			shrink_lruvec(lruvec, sc);
>> +			if (!memcg || memcg_page_state(memcg, NR_SLAB_RECLAIMABLE_B))
> 
> If we might have memcg == NULL here, the pn = memcg->nodeinfo[pgdat->node_id]
> and other memcg operations above looks kind of dangerous.

Thank you for pointing that out. You are absolutely right about the potential
NULL memcg issue. I will fix that.

> 
> Also why check NR_SLAB_RECLAIMABLE_B if there wasn't such a check previously?
> Maybe worth a separate patch.

Regarding the NR_SLAB_RECLAIMABLE_B check: it was added for better performance.
However, separating it into its own patch is a reasonable suggestion.

> 
>> +				shrink_slab(sc->gfp_mask, pgdat->node_id, memcg,
>> +					    sc->priority);
>>  
>> -		/* Record the group's reclaim efficiency */
>> -		if (!sc->proactive)
>> -			vmpressure(sc->gfp_mask, memcg, false,
>> -				   sc->nr_scanned - scanned,
>> -				   sc->nr_reclaimed - reclaimed);
>> +			if (root_reclaim(sc))
>> +				memcg_record_reclaim_result(pn, lruvec,
>> +						    sc->nr_scanned - scanned,
>> +						    sc->nr_reclaimed - reclaimed);
> 
> Why only record the reclaim result for root_reclaim?
> 

I'm just being conservative for now.

>>  
>> -		/* If partial walks are allowed, bail once goal is reached */
>> -		if (partial && sc->nr_reclaimed >= sc->nr_to_reclaim) {
>> -			mem_cgroup_iter_break(target_memcg, memcg);
>> +			/* Record the group's reclaim efficiency */
>> +			if (!sc->proactive)
>> +				vmpressure(sc->gfp_mask, memcg, false,
>> +					   sc->nr_scanned - scanned,
>> +					   sc->nr_reclaimed - reclaimed);
>> +
>> +			/* If partial walks are allowed, bail once goal is reached */
>> +			if (partial && sc->nr_reclaimed >= sc->nr_to_reclaim) {
>> +				mem_cgroup_iter_break(target_memcg, memcg);
>> +				break;
>> +			}
>> +		} while ((memcg = mem_cgroup_iter(target_memcg, memcg, partial)));
>> +
>> +		if (!need_next_level)
>>  			break;
>> -		}
>> -	} while ((memcg = mem_cgroup_iter(target_memcg, memcg, partial)));
>> +	}
> 
> IIUC you are iterating all the memcg's for up to MEMCG_LEVEL_MAX times and
> only reclaim certain memcg in each iteration. I think in theory some workload
> may have a higher overhead since there are actually more iterations, and
> will this break the reclaim fairness?
> 

To clarify the iteration logic:

Cold level: Iterates all memcgs, reclaims only from cold ones.
Warm level: Reclaims from both cold and warm memcgs.
Hot level: Reclaims from all memcgs.

This does involve trade-offs. A perfectly fair round-robin approach (iterating
one by one) would harm performance, which is why the current prototype may show
lower throughput compared to the memcg LRU algorithm. It's worth noting that the
memcg LRU itself isn't perfectly fair either—it scans a hash list from head to
tail, so memcgs at the head are always the first to be reclaimed.

The core goal, regardless of the fairness model (including memcg LRU's), remains
the same: to achieve fast memory reclamation.

>>  }
>>  
>>  static void shrink_node(pg_data_t *pgdat, struct scan_control *sc)
>> -- 
>> 2.34.1

-- 
Best regards,
Ridong


