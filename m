Return-Path: <cgroups+bounces-15028-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CAtzFei4wmlilAQAu9opvQ
	(envelope-from <cgroups+bounces-15028-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Tue, 24 Mar 2026 17:16:40 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id F3BD6318D4B
	for <lists+cgroups@lfdr.de>; Tue, 24 Mar 2026 17:16:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id E523830D1573
	for <lists+cgroups@lfdr.de>; Tue, 24 Mar 2026 16:07:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 434FC396B6B;
	Tue, 24 Mar 2026 16:07:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="ltHEVA/O"
X-Original-To: cgroups@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66D653976A7;
	Tue, 24 Mar 2026 16:07:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774368460; cv=none; b=tah04GeC6/mbQfqIbFIBgoLAFODQGjfqQQV0AA8ne6QJIhF3uD85UiFIixS1MLbsHSsa0ZWzz/lrEyZmi/HIyvvRuivEV3t5/gfwqoPq7g/n0ZRQ0dy9NgQNozEn5P8KTPL3dF39nZyFmxGxDzL0wI/mIiKa7G001F7BO1OZUww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774368460; c=relaxed/simple;
	bh=jLyjQJ8B06fZCf1hME+l9mYN2e1ySS1Q2gqMTAcA6LQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=V0u0YarLnzucbxYsCdvYHZcS/NOxqnlhlFuQbe3d8/RMb+tvTXEbZ1wHMiIksljkCX5FGHSKWb6k3ajis17f6KUtt66mRZvoqSjWaaWL8tUhHOZeC8F0+riV9RGF8zNFvglnSF495een5ahOTxt+ugeiZP4iu2n1SIumjIx5tLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=ltHEVA/O; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62O70Z5w415280;
	Tue, 24 Mar 2026 16:06:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=2DabmZ
	mrMAnP5JPSCcsIQW6Bj+sjnHfmrij8n/J4K0w=; b=ltHEVA/OjID7gMmJSyBGcM
	Hpb6Z4qNZXY1KXvJCFbreuTuCSB8+FECfn6bTXuJwPXgJE50NCxA6XUaFXBZ0Jdi
	yVQcY1WwVLrwWsaKA4Utdhdc3wodDpePL999Ig/NRLPbJBpgPZ/oLOwG/0XQA05M
	XaTCIwHrAHhYOWxYqaBnZDDUjqQ6ZiR7+n39AgX9Apu7yJMT/c6hqe0fxNC/IzDT
	AOKaBmT31+OVDCi45N+5zO0sngkPWej3afDFgdRReUi+aONTEWZKyKYzr+cxWi+R
	lJG0nJKMnE1XtjTbS+/FWgdP6DBtdAsdA8V2cp4gUNjjo1JhhvvG7n4ReVGBV0/Q
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4d1kumkvnv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 24 Mar 2026 16:06:30 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62OFha2A031635;
	Tue, 24 Mar 2026 16:06:30 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4d25nstt93-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 24 Mar 2026 16:06:30 +0000
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com [10.241.53.102])
	by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 62OG6TrR22872764
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 24 Mar 2026 16:06:29 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9C74B5805A;
	Tue, 24 Mar 2026 16:06:29 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 16D035803F;
	Tue, 24 Mar 2026 16:06:24 +0000 (GMT)
Received: from [9.39.25.178] (unknown [9.39.25.178])
	by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 24 Mar 2026 16:06:23 +0000 (GMT)
Message-ID: <537ea1c6-e631-4d13-8169-1a1b96834762@linux.ibm.com>
Date: Tue, 24 Mar 2026 21:36:22 +0530
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
References: <20260324154414.195150-1-joshua.hahnjy@gmail.com>
Content-Language: en-US
From: Donet Tom <donettom@linux.ibm.com>
In-Reply-To: <20260324154414.195150-1-joshua.hahnjy@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: r9ujSe3VNxAPEMHzMB-f4qRIQV0EF_vt
X-Proofpoint-ORIG-GUID: iGZaYGwDGoTS6lHfgsxRnCrWibAtMXQp
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI0MDEyMyBTYWx0ZWRfXz2D+Y0KIRzTN
 3mRzWQmU8YYdEHBDMTYgRcjuij9OYd/WM/2JcE6km5CAi+m6jIxXJlLNrM8TeRfC0UT7tPQ/o57
 qbnhLwvhrwWF5qXFJmdVPkGv4/jUiosCaeIJXn3qqx0OnikEVVd115deOV/dgqonM+HogMD6QvB
 Rm8CHvIDVs3Cm5QdQumIyywCvLZcVaXdTiUpfbWQ9Kvsy3UGc6Zs0xSEPTxo+GmpZ/BzSj/cG+a
 55NiE1OdR8JjvU342EnZt9yjUsLhb0avdASknNmogYm9YTlfWdlzmXvx4GuVORl7YbftyL8rkFo
 vcZizlsUH7AzbSMISPxdEjrkIUNhXH4RjJ9W67HOX4/1fACZM/8Nf4RWJExf8TpeDH4NIycRf1A
 6lk5AkQwIocTSBZ12tIFL+ta31QEkID3769uggylXJIlRg7TKEe3njKWs0I4w4xOX9aS3vLhhQT
 /LtXwbdcxPm2A8nunKw==
X-Authority-Analysis: v=2.4 cv=KbXfcAYD c=1 sm=1 tr=0 ts=69c2b687 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=VwQbUJbxAAAA:8
 a=1XWaLZrsAAAA:8 a=VnNF1IyMAAAA:8 a=pGLkceISAAAA:8 a=DV77l5TmE7YLv7A2xvoA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-24_03,2026-03-23_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 impostorscore=0 malwarescore=0 adultscore=0 clxscore=1015
 priorityscore=1501 bulkscore=0 lowpriorityscore=0 phishscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603240123
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[ibm.com,none];
	R_DKIM_ALLOW(-0.20)[ibm.com:s=pp1];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-15028-lists,cgroups=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,linux.ibm.com:mid];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
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
X-Rspamd-Queue-Id: F3BD6318D4B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


On 3/24/26 9:14 PM, Joshua Hahn wrote:
> On Tue, 24 Mar 2026 16:21:06 +0530 Donet Tom <donettom@linux.ibm.com> wrote:
>
>> On 2/24/26 4:08 AM, Joshua Hahn wrote:
>>> On machines serving multiple workloads whose memory is isolated via the
>>> memory cgroup controller, it is currently impossible to enforce a fair
>>> distribution of toptier memory among the workloads, as the only
>>> enforcable limits have to do with total memory footprint, but not where
>>> that memory resides.
>>>
>>> This makes ensuring a consistent and baseline performance difficult, as
>>> each workload's performance is heavily impacted by workload-external
>>> factors wuch as which other workloads are co-located in the same host,
>>> and the order at which different workloads are started.
>>>
>>> Extend the existing memory.high protection to be tier-aware in the
>>> charging and enforcement to limit toptier-hogging for workloads.
>>>
>>> Also, add a new nodemask parameter to try_to_free_mem_cgroup_pages,
>>> which can be used to selectively reclaim from memory at the
>>> memcg-tier interection of a cgroup.
>>>
>>> Signed-off-by: Joshua Hahn <joshua.hahnjy@gmail.com>
>>> ---
>>>    include/linux/swap.h |  3 +-
>>>    mm/memcontrol-v1.c   |  6 ++--
>>>    mm/memcontrol.c      | 85 +++++++++++++++++++++++++++++++++++++-------
>>>    mm/vmscan.c          | 11 +++---
>>>    4 files changed, 84 insertions(+), 21 deletions(-)
>>>
>>> diff --git a/include/linux/swap.h b/include/linux/swap.h
>>> index 0effe3cc50f5..c6037ac7bf6e 100644
>>> --- a/include/linux/swap.h
>>> +++ b/include/linux/swap.h
>>> @@ -368,7 +368,8 @@ extern unsigned long try_to_free_mem_cgroup_pages(struct mem_cgroup *memcg,
>>>    						  unsigned long nr_pages,
>>>    						  gfp_t gfp_mask,
>>>    						  unsigned int reclaim_options,
>>> -						  int *swappiness);
>>> +						  int *swappiness,
>>> +						  nodemask_t *allowed);
>>>    extern unsigned long mem_cgroup_shrink_node(struct mem_cgroup *mem,
>>>    						gfp_t gfp_mask, bool noswap,
>>>    						pg_data_t *pgdat,
>>> diff --git a/mm/memcontrol-v1.c b/mm/memcontrol-v1.c
>>> index 0b39ba608109..29630c7f3567 100644
>>> --- a/mm/memcontrol-v1.c
>>> +++ b/mm/memcontrol-v1.c
>>> @@ -1497,7 +1497,8 @@ static int mem_cgroup_resize_max(struct mem_cgroup *memcg,
>>>    		}
>>>    
>>>    		if (!try_to_free_mem_cgroup_pages(memcg, 1, GFP_KERNEL,
>>> -				memsw ? 0 : MEMCG_RECLAIM_MAY_SWAP, NULL)) {
>>> +				memsw ? 0 : MEMCG_RECLAIM_MAY_SWAP,
>>> +				NULL, NULL)) {
>>>    			ret = -EBUSY;
>>>    			break;
>>>    		}
>>> @@ -1529,7 +1530,8 @@ static int mem_cgroup_force_empty(struct mem_cgroup *memcg)
>>>    			return -EINTR;
>>>    
>>>    		if (!try_to_free_mem_cgroup_pages(memcg, 1, GFP_KERNEL,
>>> -						  MEMCG_RECLAIM_MAY_SWAP, NULL))
>>> +						  MEMCG_RECLAIM_MAY_SWAP,
>>> +						  NULL, NULL))
>>>    			nr_retries--;
>>>    	}
>>>    
>>> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
>>> index 8aa7ae361a73..ebd4a1b73c51 100644
>>> --- a/mm/memcontrol.c
>>> +++ b/mm/memcontrol.c
>>> @@ -2184,18 +2184,30 @@ static unsigned long reclaim_high(struct mem_cgroup *memcg,
>>>    
>>>    	do {
>>>    		unsigned long pflags;
>>> -
>>> -		if (page_counter_read(&memcg->memory) <=
>>> -		    READ_ONCE(memcg->memory.high))
>>> +		nodemask_t toptier_nodes, *reclaim_nodes;
>>> +		bool mem_high_ok, toptier_high_ok;
>>> +
>>> +		mt_get_toptier_nodemask(&toptier_nodes, NULL);
>>> +		mem_high_ok = page_counter_read(&memcg->memory) <=
>>> +			      READ_ONCE(memcg->memory.high);
>>> +		toptier_high_ok = !(tier_aware_memcg_limits &&
>>> +				    mem_cgroup_toptier_usage(memcg) >
>>> +				    page_counter_toptier_high(&memcg->memory));
>>> +		if (mem_high_ok && toptier_high_ok)
>>>    			continue;
>>>    
>>> +		if (mem_high_ok && !toptier_high_ok)
>>> +			reclaim_nodes = &toptier_nodes;
>>> +		else
>>> +			reclaim_nodes = NULL;
>>
>> IIUC The intent of this patch is to partition cgroup memory such that
>> 0 → toptier_high is backed by higher-tier memory, and
>> toptier_high → max is backed by lower-tier memory.
>>
>> Based on this:
>>
>> 1.If top-tier usage exceeds toptier_high, pages should be
>>     demoted to the lower tier.
>>
>> 2. If lower-tier usage exceeds (max - toptier_high), pages
>>     should be swapped out.
>>
>> 3. If total memory usage exceeds max, demotion should be
>>     avoided and reclaim should directly swap out pages.
>>
>> I think we are only handling case (1) in this patch. When
>> mem_high_ok && !toptier_high_ok, we are reclaiming pages (demotion first)
>>
>> However, if !mem_high_ok, the memcg reclaim path works as if
>> there is no memory tiering  in cgroup. This can lead to more demotion
>> and may eventually result in OOM.
>>
>> Should we also handle cases (2) and (3) in this patch?
> Hello Donet! I hope you are doing well.
>
> For the second condition, should pages be swapped out? If a workload
> is using 0 toptier memory (extreme case, let's say they haven't set
> memory.low) then lower-tier should be able to use all the way up to
> max memory.
>
> Maybe you mean if lowtier_usage exceeds (max - toptier_usage) pages
> should be swapped out? But if we rearrange this
>
>                  lowtier_usage >= max - toptier_usage
> lowtier_usage + toptier_usage >= max
>                    total_usage >= max
>
> And this is just the memory.max check and is already handled by
> existing reclaim semantics : -)
>
> I think case 3 is a bit more nuanced. If we directly swap out from
> high tier and skip demotions, this is introducing a priority inversion
> since memory in toptier should be hotter than memory in lowtier, so
> we should prefer to swap out the colder memory in lowtier before
> swapping out memory in toptier.
>
> The idea was discussed at length at [1]. It also feels like an orthogonal
> discussion since the behavior isn't related to toptier high or low
> behaviors.
>
> Please let me know what you think. Thank you, I hope you have a great day!


Thanks, Joshua, for your clarification.

[1] disabled demotion from memcg. With memcg limits now being
tier-aware, I was thinking about how to handle the demotion
issue. You are right that this is a separate topic not related to this.

[1] 
https://lore.kernel.org/linux-mm/20260317230720.990329-3-bingjiao@google.com/


> Joshua
>
> [1] https://lore.kernel.org/linux-mm/20260317230720.990329-3-bingjiao@google.com/
>

