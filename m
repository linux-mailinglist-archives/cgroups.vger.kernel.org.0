Return-Path: <cgroups+bounces-15053-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aGQGBUUvxGkAxQQAu9opvQ
	(envelope-from <cgroups+bounces-15053-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Wed, 25 Mar 2026 19:53:57 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 64EF932AD2D
	for <lists+cgroups@lfdr.de>; Wed, 25 Mar 2026 19:53:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C2078305BAA7
	for <lists+cgroups@lfdr.de>; Wed, 25 Mar 2026 18:48:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B79531AA87;
	Wed, 25 Mar 2026 18:48:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="PrkyhMXA"
X-Original-To: cgroups@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70A25F4F1;
	Wed, 25 Mar 2026 18:48:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774464516; cv=none; b=Rcuy+LSy+93qkYB3dVxBl59yuPqUMMG1diEFPnlhuTSsLUqSLK+hPxNUHMnc/6CxBRn48lU4Z+2trJm7tln2I/qcmI2V4s01iVH0aVLq44Ekm+NmHf5N+BWykTpsb8UWsg2+GN0KD8xusiLshdmoq195RFKDVaR0uyXt3l6UCxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774464516; c=relaxed/simple;
	bh=JkMNj3FSDd/tbhaMJKw31dgFlYA/xwxw1aa1/iQ5cvo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iu+yPy8AU76rz+3BFiXrWyVRF8u2VQnXg1Oz8uG4Vtm4M08g+80H60tAzwwovxwqtZ/uCB2nZ8cPZ3cT41FluvCkEXwxj+NZkYoJK+Y+zg+KA8Hl0KVjjezgWxor7xm5s3AWddZq1cHpbMUa74KMq0F7N6BJ9JOW0Wsu0PFaHhE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=PrkyhMXA; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62PD2rww646583;
	Wed, 25 Mar 2026 18:48:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=K669+j
	AXFfOnMiVShjbjDrGlaYoW4qKt7UsN03oR2Tk=; b=PrkyhMXAeiYAgswbUog5R9
	7gVy5oLBN9izZWsF5eCVqlrB21CX7VySH3fqgzG75/3IqjJf70mRpCU8DftvSFfo
	ZnccaGHuimmY48jDqy0UwpMhlwZ321JEIdPr8cZQ5G3X2BwsOAAbqPV4kyiFzg+2
	2RE0THdArOR+iFvTFYTigP0y0eVSN+TOaDGh1K2R7DU3L++Fie0fsK6CDwIQrSbG
	aEwjb6DjXL1yPYbOMrhaWTMXWwbkTRvJiwOxIWPJN1a4I5MrjsviHsRB55iza5tS
	/HJjn0F+dx3VnZ/wTRmL8nygVvmTfgnQYpde6HrlwqzfHgULAJgw0eTcf3uO8ibQ
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4d1kums5gj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 25 Mar 2026 18:48:07 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62PFjiKi026685;
	Wed, 25 Mar 2026 18:48:07 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4d275kyrfp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 25 Mar 2026 18:48:06 +0000
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com [10.39.53.233])
	by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 62PIm6GS63963452
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 25 Mar 2026 18:48:06 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8A7605803F;
	Wed, 25 Mar 2026 18:48:06 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 475B858055;
	Wed, 25 Mar 2026 18:47:58 +0000 (GMT)
Received: from [9.39.25.125] (unknown [9.39.25.125])
	by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 25 Mar 2026 18:47:57 +0000 (GMT)
Message-ID: <14403d89-c77c-4011-bfad-681c7b10187a@linux.ibm.com>
Date: Thu, 26 Mar 2026 00:17:56 +0530
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [LSF/MM/BPF TOPIC] Reimagining Memory Cgroup (memcg_ext)
To: Shakeel Butt <shakeel.butt@linux.dev>, lsf-pc@lists.linux-foundation.org
Cc: Andrew Morton <akpm@linux-foundation.org>, Tejun Heo <tj@kernel.org>,
        Michal Hocko <mhocko@suse.com>, Johannes Weiner <hannes@cmpxchg.org>,
        Alexei Starovoitov <ast@kernel.org>,
        =?UTF-8?Q?Michal_Koutn=C3=BD?=
 <mkoutny@suse.com>,
        Roman Gushchin <roman.gushchin@linux.dev>, Hui Zhu <hui.zhu@linux.dev>,
        JP Kobryn <inwardvessel@gmail.com>,
        Muchun Song <muchun.song@linux.dev>, Geliang Tang <geliang@kernel.org>,
        Sweet Tea Dorminy <sweettea-kernel@dorminy.me>,
        Emil Tsalapatis <emil@etsalapatis.com>,
        David Rientjes
 <rientjes@google.com>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Meta kernel team <kernel-team@meta.com>, linux-mm@kvack.org,
        cgroups@vger.kernel.org, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20260307182424.2889780-1-shakeel.butt@linux.dev>
Content-Language: en-US
From: Donet Tom <donettom@linux.ibm.com>
In-Reply-To: <20260307182424.2889780-1-shakeel.butt@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: 6FmiCLs32PS63n5oqMNtpfe4PvUiBYsr
X-Proofpoint-ORIG-GUID: pJfccnXiV3nwWrj2BDc5BsTHSbA8hxMy
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI1MDEzNyBTYWx0ZWRfX3sjkXq14IWb2
 gZ1IZK+3cm8rUowKHKnRHKbcxXFjihOSmWnVAeP9o8VlzL6+LAEqNWg/u3msB+iRQcI1a08+MKL
 Xvo7QsyUvpHdu52TgoFjFsNWFrR8UYcfXNbw1jGo/p1Q9XPaRipJGUyLFUtwVJH8A90S0SedNnR
 0oE7Oe/g5ScWc/A2Zz0QKkecXDRZNOnbsHhvxz7cXDbJbndeQeIhsgNyh9b89xAICSfjAsiecDw
 kqTh6IPiLoGi41RKUxRMk3DY2FRamP0VAyfCukGoDWgs35qaIPT0c14yRKKOHrG+tUKKuMfQDg4
 KqEv8Tluzl2+yAVsQcPhgnpHGt35si3MKbz/t8Ey22v4NN52ZoxS21pPxcWpswcF8og4z8RHLF6
 BItOVy9zb/cS4S+ME/laXIYiIL6/kgFCtf9op5TwA0Ry1mQTSwMvxPMd4NwPJrcXU8QCpE+p+UG
 hNz44EpVAKG0woaNThQ==
X-Authority-Analysis: v=2.4 cv=KbXfcAYD c=1 sm=1 tr=0 ts=69c42de8 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=EWPDJS0nAAAA:8
 a=qRGbQyZx1wJ4HwBk7TQA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-25_05,2026-03-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 impostorscore=0 malwarescore=0 adultscore=0 clxscore=1011
 priorityscore=1501 bulkscore=0 lowpriorityscore=0 phishscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603250137
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[ibm.com,none];
	R_DKIM_ALLOW(-0.20)[ibm.com:s=pp1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-15053-lists,cgroups=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[linux-foundation.org,kernel.org,suse.com,cmpxchg.org,linux.dev,gmail.com,dorminy.me,etsalapatis.com,google.com,meta.com,kvack.org,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[22];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[donettom@linux.ibm.com,cgroups@vger.kernel.org];
	DKIM_TRACE(0.00)[ibm.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[cgroups];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[11]
X-Rspamd-Queue-Id: 64EF932AD2D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


On 3/7/26 11:54 PM, Shakeel Butt wrote:
> Over the last couple of weeks, I have been brainstorming on how I would go
> about redesigning memcg, taking inspiration from sched_ext and bpfoom, with a
> focus on existing challenges and issues. This proposal outlines the high-level
> direction. Followup emails and patch series will cover and brainstorm the
> mechanisms (of course BPF) to achieve these goals.
>
> Memory cgroups provide memory accounting and the ability to control memory usage
> of workloads through two categories of limits. Throttling limits (memory.max and
> memory.high) cap memory consumption. Protection limits (memory.min and
> memory.low) shield a workload's memory from reclaim under external memory
> pressure.
>
> Challenges
> ----------
>
> - Workload owners rarely know their actual memory requirements, leading to
>    overprovisioned limits, lower utilization, and higher infrastructure costs.
>
> - Throttling limit enforcement is synchronous in the allocating task's context,
>    which can stall latency-sensitive threads.
>
> - The stalled thread may hold shared locks, causing priority inversion -- all
>    waiters are blocked regardless of their priority.
>
> - Enforcement is indiscriminate -- there is no way to distinguish a
>    performance-critical or latency-critical allocator from a latency-tolerant
>    one.
>
> - Protection limits assume static working sets size, forcing owners to either
>    overprovision or build complex userspace infrastructure to dynamically adjust
>    them.
>
> Feature Wishlist
> ----------------
>
> Here is the list of features and capabilities I want to enable in the
> redesigned memcg limit enforcement world.
>
> Per-Memcg Background Reclaim
>
> In the new memcg world, with the goal of (mostly) eliminating direct synchronous
> reclaim for limit enforcement, provide per-memcg background reclaimers which can
> scale across CPUs with the allocation rate.
>
> Lock-Aware Throttling
>
> The ability to avoid throttling an allocating task that is holding locks, to
> prevent priority inversion. In Meta's fleet, we have observed lock holders stuck
> in memcg reclaim, blocking all waiters regardless of their priority or
> criticality.
>
> Thread-Level Throttling Control
>
> Workloads should be able to indicate at the thread level which threads can be
> synchronously throttled and which cannot. For example, while experimenting with
> sched_ext, we drastically improved the performance of AI training workloads by
> prioritizing threads interacting with the GPU. Similarly, applications can
> identify the threads or thread pools on their performance-critical paths and
> the memcg enforcement mechanism should not throttle them.
>
> Combined Memory and Swap Limits
>
> Some users (Google actually) need the ability to enforce limits based on
> combined memory and swap usage, similar to cgroup v1's memsw limit, providing a
> ceiling on total memory commitment rather than treating memory and swap
> independently.
>
> Dynamic Protection Limits
>
> Rather than static protection limits, the kernel should support defining
> protection based on the actual working set of the workload, leveraging signals
> such as working set estimation, PSI, refault rates, or a combination thereof to
> automatically adapt to the workload's current memory needs.
>
> Shared Memory Semantics
>
> With more flexibility in limit enforcement, the kernel should be able to
> account for memory shared between workloads (cgroups) during enforcement.
> Today, enforcement only looks at each workload's memory usage independently.
> Sensible shared memory semantics would allow the enforcer to consider
> cross-cgroup sharing when making reclaim and throttling decisions.
>
> Memory Tiering
>
> With a flexible limit enforcement mechanism, the kernel can balance memory
> usage of different workloads across memory tiers based on their performance
> requirements. Tier accounting and hotness tracking are orthogonal, but the
> decisions of when and how to balance memory between tiers should be handled by
> the enforcer.


Hi Shakeel


This looks like a good idea. I was thinking along similar lines,
but wasn’t sure about the best way to implement it.

For memcg with memory tiering, the idea is that we set
memory.high and memory.max as the maximum limits. Within
memory.high, a certain percentage (x%) could be backed by
higher-tier memory, with the remaining portion coming from
lower-tier memory.

In this model, an application would get up to
memory.high * x / 100 from higher-tier memory, and the rest
from lower-tier memory.

Once the higher-tier usage reaches its limit, we would start
demoting pages. If the lower-tier usage also reaches its
limit, we would then start swapping out pages from lower tier.

What is your opinion on how memory tiering should be handled in memcg?


-Donet

>
> Collaborative Load Shedding
>
> Many workloads communicate with an external entity for load balancing and rely
> on their own usage metrics like RSS or memory pressure to signal whether they
> can accept more or less work. This is guesswork. Instead of the
> workload guessing, the limit enforcer -- which is actually managing the
> workload's memory usage -- should be able to communicate available headroom or
> request the workload to shed load or reduce memory usage. This collaborative
> load shedding mechanism would allow workloads to make informed decisions rather
> than reacting to coarse signals.
>
> Cross-Subsystem Collaboration
>
> Finally, the limit enforcement mechanism should collaborate with the CPU
> scheduler and other subsystems that can release memory. For example, dirty
> memory is not reclaimable and the memory subsystem wakes up flushers to trigger
> writeback. However, flushers need CPU to run -- asking the CPU scheduler to
> prioritize them ensures the kernel does not lack reclaimable memory under
> stressful conditions. Similarly, some subsystems free memory through workqueues
> or RCU callbacks. While this may seem orthogonal to limit enforcement, we can
> definitely take advantage by having visibility into these situations.
>
> Putting It All Together
> -----------------------
>
> To illustrate the end goal, here is an example of the scenario I want to
> enable. Suppose there is an AI agent controlling the resources of a host. I
> should be able to provide the following policy and everything should work out
> of the box:
>
> Policy: "keep system-level memory utilization below 95 percent;
> avoid priority inversions by not throttling allocators holding locks; trim each
> workload's usage to its working set without regressing its relevant performance
> metrics; collaborate with workloads on load shedding and memory trimming
> decisions; and under extreme memory pressure, collaborate with the OOM killer
> and the central job scheduler to kill and clean up a workload."
>
> Initially I added this example for fun, but from [1] it seems like there is a
> real need to enable such capabilities.
>
> [1] https://arxiv.org/abs/2602.09345
>

