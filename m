Return-Path: <cgroups+bounces-15022-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yMWEGtNuwmmncwQAu9opvQ
	(envelope-from <cgroups+bounces-15022-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Tue, 24 Mar 2026 12:00:35 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D925C306EC6
	for <lists+cgroups@lfdr.de>; Tue, 24 Mar 2026 12:00:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 557EA30DAF0F
	for <lists+cgroups@lfdr.de>; Tue, 24 Mar 2026 10:52:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDDE3393DD1;
	Tue, 24 Mar 2026 10:51:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="MpVyk+PY"
X-Original-To: cgroups@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 957B63E8C40;
	Tue, 24 Mar 2026 10:51:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774349517; cv=none; b=Rfu8o1F9D1M0UebiwLRf3uTDvwvj9d1011Cpwh6QzUFf9la4hQdTQZpYZGNtmxRV3cgzzKrrfFwjXjUwhKVBKftMtlyEsQZHV0lWuIzPR90xcBMgCPZH1lUx3CvMna3bbYpgmBNhpZqlJyrf2Lyjj1zj6YUJIlD1DMX59Gyzpmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774349517; c=relaxed/simple;
	bh=PaqfZyj4NogeiQQ6zAyk2zOW2AkVjGBHvOGRAO40GZc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eE145cHknVzPWp7PHc1QD+u75O+4u/qMeXQBiCZp0gWh3HNbd/3+yTJxq4kRsnwD3KQYhrNrNyonvWMlqrmqy029zzUrAq0zI8aeRIV8U06qLOsMCTGIXNNfI4bjdJ6yq6WMlMT8tFn/e7WZ5ebtJzc8QMKQlceD7QnzG1pUido=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=MpVyk+PY; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62O59CGi194143;
	Tue, 24 Mar 2026 10:51:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=9HHh34
	2uH8Hl6l5tnTfRNn9T/B3ST8B3hq6nLcuhmVQ=; b=MpVyk+PYNNLdFH4I3DL5/7
	p9k2DjHHfUAwFfG0lGoVSgVYfj2VQqh6t+JGm132519aQPB6Kd6PD39zoNA71bqm
	J4UFShmAErEyiPDZa27tXP6eK7A1DiGtGjgloRpPOCYgqV7mcNpdXyawhv5NMLra
	FhluJbGLSLY5SKq64BnbJsMTEC4H2N6Z0Ko71u3A6GfzhN+vww47g0zrG4LFJ/Vo
	K/H/HPhF2m/v50QaEtbmVHv0bCHETelw3VkSdm4knwus+xMKJcALL2RmFNrOyom8
	uLZs+iUwKYyTdv8ruJaQbAz8BDmQHnX4rNhN1P8CIwkuDobjYa3vxIicrWGKIuQQ
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4d1ktxty4y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 24 Mar 2026 10:51:16 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62O8AgiV009115;
	Tue, 24 Mar 2026 10:51:14 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4d26nnhf75-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 24 Mar 2026 10:51:14 +0000
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com [10.241.53.102])
	by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 62OApEJB32375392
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 24 Mar 2026 10:51:14 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2941058060;
	Tue, 24 Mar 2026 10:51:14 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 68AE558056;
	Tue, 24 Mar 2026 10:51:08 +0000 (GMT)
Received: from [9.39.25.178] (unknown [9.39.25.178])
	by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 24 Mar 2026 10:51:08 +0000 (GMT)
Message-ID: <90749965-ebc8-43b2-92e3-baec5f6e3de0@linux.ibm.com>
Date: Tue, 24 Mar 2026 16:21:06 +0530
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 6/6] mm/memcontrol: Make memory.high tier-aware
To: Joshua Hahn <joshua.hahnjy@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@kernel.org>,
        Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
        Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@suse.com>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Shakeel Butt <shakeel.butt@linux.dev>,
        Muchun Song <muchun.song@linux.dev>,
        Qi Zheng <zhengqi.arch@bytedance.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Yuanchu Xie <yuanchu@google.com>, Wei Xu <weixugc@google.com>,
        linux-mm@kvack.org, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@meta.com
References: <20260223223830.586018-1-joshua.hahnjy@gmail.com>
 <20260223223830.586018-7-joshua.hahnjy@gmail.com>
Content-Language: en-US
From: Donet Tom <donettom@linux.ibm.com>
In-Reply-To: <20260223223830.586018-7-joshua.hahnjy@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=IqITsb/g c=1 sm=1 tr=0 ts=69c26ca4 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=pGLkceISAAAA:8
 a=4rzORf8nsDSbtsABdP8A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI0MDA4NiBTYWx0ZWRfX6UBn9MbLM1ed
 M9mbnvayIgD62+sx81pYqEBLXUEd8+irfd3zY/j1bZEI9Ixwx91tR6YoQrMRwpJ4zK5a29yDm2M
 DCkBAnuvu8K7GtC6ySo8azRbhee6R7jOaH50QnWd9xoNQ8Zv8xXs6QjMhzIYTuDuCPei+dE3436
 HHfOIxNm4txQJ5noowVxKritiw/Ns6ES8SHNEspWM7X7wIZff9QALHzElFsJ+JhbnL3qIReencv
 GN2UzsLoTfaXujV4JOEci/S4NucpGfBK/fHpNvV99i2UdJIwqQLr5erMXtDulnYQJaNhrQ9RR3k
 Zl+pAApgPdbTaa8UBFisW6AkmeG/1HIsjeuRkZ0luEGymAHVSOJ6c3yHWpvWl3AJVnYigusufKW
 CWcMSnc5vX0b+CKoM6Ge9QkHY4g7aForp+BaSro/jPGbreeBsC6cpkqclsYT87As5NeIiE3JuUO
 K/X5iYQbiw+odr9kDRg==
X-Proofpoint-GUID: S5xTqAAIrNy2bbILfqEnnHBg2izUMjQx
X-Proofpoint-ORIG-GUID: T2SNJoJ1yDXrykBLfJrKO5gTlul5fFRJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-24_02,2026-03-23_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 clxscore=1015 spamscore=0 impostorscore=0 suspectscore=0
 phishscore=0 bulkscore=0 adultscore=0 priorityscore=1501 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603240086
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[ibm.com,none];
	R_DKIM_ALLOW(-0.20)[ibm.com:s=pp1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-15022-lists,cgroups=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[donettom@linux.ibm.com,cgroups@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[ibm.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[cgroups];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[11]
X-Rspamd-Queue-Id: D925C306EC6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


On 2/24/26 4:08 AM, Joshua Hahn wrote:
> On machines serving multiple workloads whose memory is isolated via the
> memory cgroup controller, it is currently impossible to enforce a fair
> distribution of toptier memory among the workloads, as the only
> enforcable limits have to do with total memory footprint, but not where
> that memory resides.
>
> This makes ensuring a consistent and baseline performance difficult, as
> each workload's performance is heavily impacted by workload-external
> factors wuch as which other workloads are co-located in the same host,
> and the order at which different workloads are started.
>
> Extend the existing memory.high protection to be tier-aware in the
> charging and enforcement to limit toptier-hogging for workloads.
>
> Also, add a new nodemask parameter to try_to_free_mem_cgroup_pages,
> which can be used to selectively reclaim from memory at the
> memcg-tier interection of a cgroup.
>
> Signed-off-by: Joshua Hahn <joshua.hahnjy@gmail.com>
> ---
>   include/linux/swap.h |  3 +-
>   mm/memcontrol-v1.c   |  6 ++--
>   mm/memcontrol.c      | 85 +++++++++++++++++++++++++++++++++++++-------
>   mm/vmscan.c          | 11 +++---
>   4 files changed, 84 insertions(+), 21 deletions(-)
>
> diff --git a/include/linux/swap.h b/include/linux/swap.h
> index 0effe3cc50f5..c6037ac7bf6e 100644
> --- a/include/linux/swap.h
> +++ b/include/linux/swap.h
> @@ -368,7 +368,8 @@ extern unsigned long try_to_free_mem_cgroup_pages(struct mem_cgroup *memcg,
>   						  unsigned long nr_pages,
>   						  gfp_t gfp_mask,
>   						  unsigned int reclaim_options,
> -						  int *swappiness);
> +						  int *swappiness,
> +						  nodemask_t *allowed);
>   extern unsigned long mem_cgroup_shrink_node(struct mem_cgroup *mem,
>   						gfp_t gfp_mask, bool noswap,
>   						pg_data_t *pgdat,
> diff --git a/mm/memcontrol-v1.c b/mm/memcontrol-v1.c
> index 0b39ba608109..29630c7f3567 100644
> --- a/mm/memcontrol-v1.c
> +++ b/mm/memcontrol-v1.c
> @@ -1497,7 +1497,8 @@ static int mem_cgroup_resize_max(struct mem_cgroup *memcg,
>   		}
>   
>   		if (!try_to_free_mem_cgroup_pages(memcg, 1, GFP_KERNEL,
> -				memsw ? 0 : MEMCG_RECLAIM_MAY_SWAP, NULL)) {
> +				memsw ? 0 : MEMCG_RECLAIM_MAY_SWAP,
> +				NULL, NULL)) {
>   			ret = -EBUSY;
>   			break;
>   		}
> @@ -1529,7 +1530,8 @@ static int mem_cgroup_force_empty(struct mem_cgroup *memcg)
>   			return -EINTR;
>   
>   		if (!try_to_free_mem_cgroup_pages(memcg, 1, GFP_KERNEL,
> -						  MEMCG_RECLAIM_MAY_SWAP, NULL))
> +						  MEMCG_RECLAIM_MAY_SWAP,
> +						  NULL, NULL))
>   			nr_retries--;
>   	}
>   
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index 8aa7ae361a73..ebd4a1b73c51 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -2184,18 +2184,30 @@ static unsigned long reclaim_high(struct mem_cgroup *memcg,
>   
>   	do {
>   		unsigned long pflags;
> -
> -		if (page_counter_read(&memcg->memory) <=
> -		    READ_ONCE(memcg->memory.high))
> +		nodemask_t toptier_nodes, *reclaim_nodes;
> +		bool mem_high_ok, toptier_high_ok;
> +
> +		mt_get_toptier_nodemask(&toptier_nodes, NULL);
> +		mem_high_ok = page_counter_read(&memcg->memory) <=
> +			      READ_ONCE(memcg->memory.high);
> +		toptier_high_ok = !(tier_aware_memcg_limits &&
> +				    mem_cgroup_toptier_usage(memcg) >
> +				    page_counter_toptier_high(&memcg->memory));
> +		if (mem_high_ok && toptier_high_ok)
>   			continue;
>   
> +		if (mem_high_ok && !toptier_high_ok)
> +			reclaim_nodes = &toptier_nodes;
> +		else
> +			reclaim_nodes = NULL;


IIUC The intent of this patch is to partition cgroup memory such that
0 → toptier_high is backed by higher-tier memory, and
toptier_high → max is backed by lower-tier memory.

Based on this:

1.If top-tier usage exceeds toptier_high, pages should be
   demoted to the lower tier.

2. If lower-tier usage exceeds (max - toptier_high), pages
   should be swapped out.

3. If total memory usage exceeds max, demotion should be
   avoided and reclaim should directly swap out pages.

I think we are only handling case (1) in this patch. When
mem_high_ok && !toptier_high_ok, we are reclaiming pages (demotion first)

However, if !mem_high_ok, the memcg reclaim path works as if
there is no memory tiering  in cgroup. This can lead to more demotion
and may eventually result in OOM.

Should we also handle cases (2) and (3) in this patch?


> +
>   		memcg_memory_event(memcg, MEMCG_HIGH);
>   
>   		psi_memstall_enter(&pflags);
>   		nr_reclaimed += try_to_free_mem_cgroup_pages(memcg, nr_pages,
>   							gfp_mask,
>   							MEMCG_RECLAIM_MAY_SWAP,
> -							NULL);
> +							NULL, reclaim_nodes);
>   		psi_memstall_leave(&pflags);
>   	} while ((memcg = parent_mem_cgroup(memcg)) &&
>   		 !mem_cgroup_is_root(memcg));
> @@ -2296,6 +2308,24 @@ static u64 mem_find_max_overage(struct mem_cgroup *memcg)
>   	return max_overage;
>   }
>   
> +static u64 toptier_find_max_overage(struct mem_cgroup *memcg)
> +{
> +	u64 overage, max_overage = 0;
> +
> +	if (!tier_aware_memcg_limits)
> +		return 0;
> +
> +	do {
> +		unsigned long usage = mem_cgroup_toptier_usage(memcg);
> +		unsigned long high = page_counter_toptier_high(&memcg->memory);
> +
> +		overage = calculate_overage(usage, high);
> +		max_overage = max(overage, max_overage);
> +	} while ((memcg = parent_mem_cgroup(memcg)) &&
> +		  !mem_cgroup_is_root(memcg));
> +
> +	return max_overage;
> +}
>   static u64 swap_find_max_overage(struct mem_cgroup *memcg)
>   {
>   	u64 overage, max_overage = 0;
> @@ -2401,6 +2431,14 @@ void __mem_cgroup_handle_over_high(gfp_t gfp_mask)
>   	penalty_jiffies += calculate_high_delay(memcg, nr_pages,
>   						swap_find_max_overage(memcg));
>   
> +	/*
> +	 * Don't double-penalize for toptier high overage if system-wide
> +	 * memory.high has already been breached.
> +	 */
> +	if (!penalty_jiffies)
> +		penalty_jiffies += calculate_high_delay(memcg, nr_pages,
> +					toptier_find_max_overage(memcg));
> +
>   	/*
>   	 * Clamp the max delay per usermode return so as to still keep the
>   	 * application moving forwards and also permit diagnostics, albeit
> @@ -2503,7 +2541,8 @@ static int try_charge_memcg(struct mem_cgroup *memcg, gfp_t gfp_mask,
>   
>   	psi_memstall_enter(&pflags);
>   	nr_reclaimed = try_to_free_mem_cgroup_pages(mem_over_limit, nr_pages,
> -						    gfp_mask, reclaim_options, NULL);
> +						    gfp_mask, reclaim_options,
> +						    NULL, NULL);
>   	psi_memstall_leave(&pflags);
>   
>   	if (mem_cgroup_margin(mem_over_limit) >= nr_pages)
> @@ -2592,23 +2631,26 @@ static int try_charge_memcg(struct mem_cgroup *memcg, gfp_t gfp_mask,
>   	 * reclaim, the cost of mismatch is negligible.
>   	 */
>   	do {
> -		bool mem_high, swap_high;
> +		bool mem_high, swap_high, toptier_high = false;
>   
>   		mem_high = page_counter_read(&memcg->memory) >
>   			READ_ONCE(memcg->memory.high);
>   		swap_high = page_counter_read(&memcg->swap) >
>   			READ_ONCE(memcg->swap.high);
> +		toptier_high = tier_aware_memcg_limits &&
> +			       (mem_cgroup_toptier_usage(memcg) >
> +				page_counter_toptier_high(&memcg->memory));
>   
>   		/* Don't bother a random interrupted task */
>   		if (!in_task()) {
> -			if (mem_high) {
> +			if (mem_high || toptier_high) {
>   				schedule_work(&memcg->high_work);
>   				break;
>   			}
>   			continue;
>   		}
>   
> -		if (mem_high || swap_high) {
> +		if (mem_high || swap_high || toptier_high) {
>   			/*
>   			 * The allocating tasks in this cgroup will need to do
>   			 * reclaim or be throttled to prevent further growth
> @@ -4476,7 +4518,7 @@ static ssize_t memory_high_write(struct kernfs_open_file *of,
>   	struct mem_cgroup *memcg = mem_cgroup_from_css(of_css(of));
>   	unsigned int nr_retries = MAX_RECLAIM_RETRIES;
>   	bool drained = false;
> -	unsigned long high;
> +	unsigned long high, toptier_high;
>   	int err;
>   
>   	buf = strstrip(buf);
> @@ -4485,15 +4527,22 @@ static ssize_t memory_high_write(struct kernfs_open_file *of,
>   		return err;
>   
>   	page_counter_set_high(&memcg->memory, high);
> +	toptier_high = page_counter_toptier_high(&memcg->memory);
>   
>   	if (of->file->f_flags & O_NONBLOCK)
>   		goto out;
>   
>   	for (;;) {
>   		unsigned long nr_pages = page_counter_read(&memcg->memory);
> +		unsigned long toptier_pages = mem_cgroup_toptier_usage(memcg);
>   		unsigned long reclaimed;
> +		unsigned long to_free;
> +		nodemask_t toptier_nodes, *reclaim_nodes;
> +		bool mem_high_ok = nr_pages <= high;
> +		bool toptier_high_ok = !(tier_aware_memcg_limits &&
> +					 toptier_pages > toptier_high);
>   
> -		if (nr_pages <= high)
> +		if (mem_high_ok && toptier_high_ok)
>   			break;
>   
>   		if (signal_pending(current))
> @@ -4505,8 +4554,17 @@ static ssize_t memory_high_write(struct kernfs_open_file *of,
>   			continue;
>   		}
>   
> -		reclaimed = try_to_free_mem_cgroup_pages(memcg, nr_pages - high,
> -					GFP_KERNEL, MEMCG_RECLAIM_MAY_SWAP, NULL);
> +		mt_get_toptier_nodemask(&toptier_nodes, NULL);
> +		if (mem_high_ok && !toptier_high_ok) {
> +			reclaim_nodes = &toptier_nodes;
> +			to_free = toptier_pages - toptier_high;
> +		} else {
> +			reclaim_nodes = NULL;
> +			to_free = nr_pages - high;
> +		}
> +		reclaimed = try_to_free_mem_cgroup_pages(memcg, to_free,
> +					GFP_KERNEL, MEMCG_RECLAIM_MAY_SWAP,
> +					NULL, reclaim_nodes);
>   
>   		if (!reclaimed && !nr_retries--)
>   			break;
> @@ -4558,7 +4616,8 @@ static ssize_t memory_max_write(struct kernfs_open_file *of,
>   
>   		if (nr_reclaims) {
>   			if (!try_to_free_mem_cgroup_pages(memcg, nr_pages - max,
> -					GFP_KERNEL, MEMCG_RECLAIM_MAY_SWAP, NULL))
> +					GFP_KERNEL, MEMCG_RECLAIM_MAY_SWAP,
> +					NULL, NULL))
>   				nr_reclaims--;
>   			continue;
>   		}
> diff --git a/mm/vmscan.c b/mm/vmscan.c
> index 5b4cb030a477..94498734b4f5 100644
> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
> @@ -6652,7 +6652,7 @@ unsigned long try_to_free_mem_cgroup_pages(struct mem_cgroup *memcg,
>   					   unsigned long nr_pages,
>   					   gfp_t gfp_mask,
>   					   unsigned int reclaim_options,
> -					   int *swappiness)
> +					   int *swappiness, nodemask_t *allowed)
>   {
>   	unsigned long nr_reclaimed;
>   	unsigned int noreclaim_flag;
> @@ -6668,6 +6668,7 @@ unsigned long try_to_free_mem_cgroup_pages(struct mem_cgroup *memcg,
>   		.may_unmap = 1,
>   		.may_swap = !!(reclaim_options & MEMCG_RECLAIM_MAY_SWAP),
>   		.proactive = !!(reclaim_options & MEMCG_RECLAIM_PROACTIVE),
> +		.nodemask = allowed,
>   	};
>   	/*
>   	 * Traverse the ZONELIST_FALLBACK zonelist of the current node to put
> @@ -6693,7 +6694,7 @@ unsigned long try_to_free_mem_cgroup_pages(struct mem_cgroup *memcg,
>   					   unsigned long nr_pages,
>   					   gfp_t gfp_mask,
>   					   unsigned int reclaim_options,
> -					   int *swappiness)
> +					   int *swappiness, nodemask_t *allowed)
>   {
>   	return 0;
>   }
> @@ -7806,9 +7807,9 @@ int user_proactive_reclaim(char *buf,
>   			reclaim_options = MEMCG_RECLAIM_MAY_SWAP |
>   					  MEMCG_RECLAIM_PROACTIVE;
>   			reclaimed = try_to_free_mem_cgroup_pages(memcg,
> -						 batch_size, gfp_mask,
> -						 reclaim_options,
> -						 swappiness == -1 ? NULL : &swappiness);
> +					batch_size, gfp_mask, reclaim_options,
> +					swappiness == -1 ? NULL : &swappiness,
> +					NULL);
>   		} else {
>   			struct scan_control sc = {
>   				.gfp_mask = current_gfp_context(gfp_mask),

