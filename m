Return-Path: <cgroups+bounces-6874-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A7ED4A56021
	for <lists+cgroups@lfdr.de>; Fri,  7 Mar 2025 06:37:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D33A11773B0
	for <lists+cgroups@lfdr.de>; Fri,  7 Mar 2025 05:37:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7832F1519A3;
	Fri,  7 Mar 2025 05:37:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="EqyIBw8I"
X-Original-To: cgroups@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A78187FD;
	Fri,  7 Mar 2025 05:37:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741325874; cv=none; b=GCnQ1AluyQfXlQW2c7gB4HvietRvHNehoYqN+BOy0GNLhi0rKo1o0n74FwhGYweWEELmIvJDlSdHptvnQXXWh5nJ5mkvvedQGZTKtbrsemGuj1S7+gnO7cdqpUsdsCzIPLK8chHTyGAao/GVAJfZKjz+2/lEgH+RiYges/nziRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741325874; c=relaxed/simple;
	bh=7FWbwkk33+DHUdnpxFg6kqXyYpN8KW9SYWe7dEfrlIE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qKAIR2RQS/tWepavXw8/AU+iYHGQx/9n9HAfk/x4RfVEuMeKql5Y/IOyoI0KjgkbTOyfZAenlcLj2bl6h8bLloydodPhlZFQo+aY6Gsd0/v2yE6sixHTgs0O8hhhDBra/43aeLSkfz9UGFtGGEFUSumBb+Rzbn0i07jZZAqx3fM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=EqyIBw8I; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5273kXIQ018271;
	Fri, 7 Mar 2025 05:37:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=kUYM8O
	goyahKbZW6htTscRhE3SX55nRZKD62Bt1Zduw=; b=EqyIBw8IWXhEQpLAst/0iL
	aZF1jC5Mb/19QXi/kr6xqzpDV4hcLLMru3dmCvfAv8ieC4tVWdvwveZOoUMmff30
	5u2DKhM3SA/ADAQn6GegTozY9AerUt3iWxKRxB1f483lgYnLNtjnp6meJTjswFb3
	4cnHSm3JBdTa0vfAmBg0s62CO9SIX+sX1gbW/YB+8rZPTz8Z1OSuTHyTzE2ScBzN
	VGhJfazxfmZaMeDk3+FTSorgj5MXKQAFThs8WdgedPCSHRMLl7ScJzEu91u3vidM
	7pCkPf+S4BnT2TUyuHdxCERd/GpjYrzUQruPTxmIt4zZ8Sgzo9pp4aAycxarIwUw
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 457s6a0cs1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 07 Mar 2025 05:37:05 +0000 (GMT)
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 5275Y6KD009795;
	Fri, 7 Mar 2025 05:37:04 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 457s6a0crw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 07 Mar 2025 05:37:04 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 52759Ym4008934;
	Fri, 7 Mar 2025 05:37:03 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 454cxyw55s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 07 Mar 2025 05:37:03 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5275b1KG20513218
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 7 Mar 2025 05:37:01 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6E7D420043;
	Fri,  7 Mar 2025 05:37:01 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 189D620040;
	Fri,  7 Mar 2025 05:36:57 +0000 (GMT)
Received: from [9.124.218.213] (unknown [9.124.218.213])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri,  7 Mar 2025 05:36:56 +0000 (GMT)
Message-ID: <885de7ad-f168-4826-b96d-bb136ee30333@linux.ibm.com>
Date: Fri, 7 Mar 2025 11:06:56 +0530
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/8] sched/deadline: Generalize unique visiting of root
 domains
To: Juri Lelli <juri.lelli@redhat.com>
Cc: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>,
        Mel Gorman <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>,
        Waiman Long <longman@redhat.com>, Tejun Heo <tj@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        =?UTF-8?Q?Michal_Koutn=C3=BD?=
 <mkoutny@suse.com>,
        Qais Yousef <qyousef@layalina.io>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Swapnil Sapkal <swapnil.sapkal@amd.com>, Phil Auld <pauld@redhat.com>,
        luca.abeni@santannapisa.it, tommaso.cucinotta@santannapisa.it,
        Jon Hunter <jonathanh@nvidia.com>, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20250306141016.268313-1-juri.lelli@redhat.com>
 <20250306141016.268313-4-juri.lelli@redhat.com>
From: Shrikanth Hegde <sshegde@linux.ibm.com>
Content-Language: en-US
In-Reply-To: <20250306141016.268313-4-juri.lelli@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: EiyRpNDaNrUBbQao0gqNtEevidRz9tHF
X-Proofpoint-ORIG-GUID: U3qOnSjOG5STYIIkrfQiBOrBEFm_QbCA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-07_01,2025-03-06_04,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 suspectscore=0
 mlxlogscore=999 adultscore=0 priorityscore=1501 phishscore=0 clxscore=1011
 malwarescore=0 impostorscore=0 bulkscore=0 spamscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2502100000
 definitions=main-2503070031



On 3/6/25 19:40, Juri Lelli wrote:
> Bandwidth checks and updates that work on root domains currently employ
> a cookie mechanism for efficiency. This mechanism is very much tied to
> when root domains are first created and initialized.
> 
> Generalize the cookie mechanism so that it can be used also later at
> runtime while updating root domains. Also, additionally guard it with
> sched_domains_mutex, since domains need to be stable while updating them
> (and it will be required for further dynamic changes).
> 
> Reported-by: Jon Hunter <jonathanh@nvidia.com>
> Fixes: 53916d5fd3c0 ("sched/deadline: Check bandwidth overflow earlier for hotplug")
> Signed-off-by: Juri Lelli <juri.lelli@redhat.com>
> ---
>   include/linux/sched/deadline.h |  3 +++
>   kernel/sched/deadline.c        | 23 +++++++++++++----------
>   kernel/sched/rt.c              |  2 ++
>   kernel/sched/sched.h           |  2 +-
>   kernel/sched/topology.c        |  2 +-
>   5 files changed, 20 insertions(+), 12 deletions(-)
> 
> diff --git a/include/linux/sched/deadline.h b/include/linux/sched/deadline.h
> index 3a912ab42bb5..6ec578600b24 100644
> --- a/include/linux/sched/deadline.h
> +++ b/include/linux/sched/deadline.h
> @@ -37,4 +37,7 @@ extern void dl_clear_root_domain(struct root_domain *rd);
>   
>   #endif /* CONFIG_SMP */
>   
> +extern u64 dl_cookie;
> +extern bool dl_bw_visited(int cpu, u64 cookie);
> +
>   #endif /* _LINUX_SCHED_DEADLINE_H */
> diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
> index ab565a151355..339434271cba 100644
> --- a/kernel/sched/deadline.c
> +++ b/kernel/sched/deadline.c
> @@ -166,14 +166,14 @@ static inline unsigned long dl_bw_capacity(int i)
>   	}
>   }
>   
> -static inline bool dl_bw_visited(int cpu, u64 gen)
> +static inline bool dl_bw_visited(int cpu, u64 cookie)
>   {
>   	struct root_domain *rd = cpu_rq(cpu)->rd;
>   
> -	if (rd->visit_gen == gen)
> +	if (rd->visit_cookie == cookie)
>   		return true;
>   
> -	rd->visit_gen = gen;
> +	rd->visit_cookie = cookie;
>   	return false;
>   }
>   
> @@ -207,7 +207,7 @@ static inline unsigned long dl_bw_capacity(int i)
>   	return SCHED_CAPACITY_SCALE;
>   }
>   
> -static inline bool dl_bw_visited(int cpu, u64 gen)
> +static inline bool dl_bw_visited(int cpu, u64 cookie)
>   {
>   	return false;
>   }
> @@ -3171,15 +3171,18 @@ DEFINE_SCHED_CLASS(dl) = {
>   #endif
>   };
>   
> -/* Used for dl_bw check and update, used under sched_rt_handler()::mutex */
> -static u64 dl_generation;
> +/*
> + * Used for dl_bw check and update, used under sched_rt_handler()::mutex and
> + * sched_domains_mutex.
> + */
> +u64 dl_cookie;
>   
>   int sched_dl_global_validate(void)
>   {
>   	u64 runtime = global_rt_runtime();
>   	u64 period = global_rt_period();
>   	u64 new_bw = to_ratio(period, runtime);
> -	u64 gen = ++dl_generation;
> +	u64 cookie = ++dl_cookie;
>   	struct dl_bw *dl_b;
>   	int cpu, cpus, ret = 0;
>   	unsigned long flags;
> @@ -3192,7 +3195,7 @@ int sched_dl_global_validate(void)
>   	for_each_possible_cpu(cpu) {

This has been changed in 14672f059d83f591afb2ee1fff56858efe055e5a to 
online CPUs. So patch didn't apply cleanly to me.

>   		rcu_read_lock_sched();
>   
> -		if (dl_bw_visited(cpu, gen))
> +		if (dl_bw_visited(cpu, cookie))
>   			goto next;
>   
>   		dl_b = dl_bw_of(cpu);
> @@ -3229,7 +3232,7 @@ static void init_dl_rq_bw_ratio(struct dl_rq *dl_rq)
>   void sched_dl_do_global(void)
>   {
>   	u64 new_bw = -1;
> -	u64 gen = ++dl_generation;
> +	u64 cookie = ++dl_cookie;
>   	struct dl_bw *dl_b;
>   	int cpu;
>   	unsigned long flags;
> @@ -3240,7 +3243,7 @@ void sched_dl_do_global(void)
>   	for_each_possible_cpu(cpu) {
>   		rcu_read_lock_sched();
>   
> -		if (dl_bw_visited(cpu, gen)) {
> +		if (dl_bw_visited(cpu, cookie)) {
>   			rcu_read_unlock_sched();
>   			continue;
>   		}
> diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
> index 4b8e33c615b1..8cebe71d2bb1 100644
> --- a/kernel/sched/rt.c
> +++ b/kernel/sched/rt.c
> @@ -2910,6 +2910,7 @@ static int sched_rt_handler(const struct ctl_table *table, int write, void *buff
>   	int ret;
>   
>   	mutex_lock(&mutex);
> +	sched_domains_mutex_lock();
>   	old_period = sysctl_sched_rt_period;
>   	old_runtime = sysctl_sched_rt_runtime;
>   
> @@ -2936,6 +2937,7 @@ static int sched_rt_handler(const struct ctl_table *table, int write, void *buff
>   		sysctl_sched_rt_period = old_period;
>   		sysctl_sched_rt_runtime = old_runtime;
>   	}
> +	sched_domains_mutex_unlock();
>   	mutex_unlock(&mutex);
>   
>   	return ret;
> diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
> index c8512a9fb022..c978abe38c07 100644
> --- a/kernel/sched/sched.h
> +++ b/kernel/sched/sched.h
> @@ -998,7 +998,7 @@ struct root_domain {
>   	 * Also, some corner cases, like 'wrap around' is dangerous, but given
>   	 * that u64 is 'big enough'. So that shouldn't be a concern.
>   	 */
> -	u64 visit_gen;
> +	u64 visit_cookie;
>   
>   #ifdef HAVE_RT_PUSH_IPI
>   	/*
> diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
> index 296ff2acfd32..44093339761c 100644
> --- a/kernel/sched/topology.c
> +++ b/kernel/sched/topology.c
> @@ -568,7 +568,7 @@ static int init_rootdomain(struct root_domain *rd)
>   	rd->rto_push_work = IRQ_WORK_INIT_HARD(rto_push_irq_work_func);
>   #endif
>   
> -	rd->visit_gen = 0;
> +	rd->visit_cookie = 0;
>   	init_dl_bw(&rd->dl_bw);
>   	if (cpudl_init(&rd->cpudl) != 0)
>   		goto free_rto_mask;


