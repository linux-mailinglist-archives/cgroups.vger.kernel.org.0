Return-Path: <cgroups+bounces-6876-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0111CA560E6
	for <lists+cgroups@lfdr.de>; Fri,  7 Mar 2025 07:33:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2B9121768C9
	for <lists+cgroups@lfdr.de>; Fri,  7 Mar 2025 06:33:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 475B8194A6C;
	Fri,  7 Mar 2025 06:33:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="DbhYTEP0"
X-Original-To: cgroups@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 670D03D6D;
	Fri,  7 Mar 2025 06:33:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741329221; cv=none; b=JSWr2r/v4SUmVBJjeLptQx10NEiF/uqiwCLPn50wyVhFGksjkxBzC8Ybcip2/Vfz3tNZyLlbgZC3eBHpLygzZINP3YEd8sbgq6t4oHGni3fjD2oYfLS2cm13cskZFxC6e/ZJa71KwSp+dTDmLGAxl+OpdJdwWaI60Cc4UVq3kPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741329221; c=relaxed/simple;
	bh=ZekPPtsk1ScZpqNWJqDXN+JNyvlvIbWBAK2GZKubP5k=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=Ra4vULYxikVisez4vNPe8DmUvHXSCrOSAVwng/IdZquhda8/U6cZmpEkVmbReguqYrPzOUGURMDg2Yc30lJEyXMCSs0QQQNdt3iKeZq1oZSj+ntO2i5i72XUc3rUnPjvpEIOD2lbsqnWnSBRQULgUVjaTqm4ydIzeSmqbB/dueM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=DbhYTEP0; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 526KdJ8b003771;
	Fri, 7 Mar 2025 06:33:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=2ZGwll
	Zz5/kLVNOFNLkWjcldANwCssBAkYGRgFt9ndo=; b=DbhYTEP0qhE4RxVNLaMr/W
	0Tx7ovHVTon5OaHc48seP9QgeFF3cZlpnvfiyvjw8YlTdbd8P9WmisK0aUIa9yf4
	5Gv40SrEtiG84sqPZ5wILbJzCqmW8S77PxZqHOxQ5+B6kU6yVkqZ3O9gwj2Pgr3v
	8CH4ogWyf/EiAesxQbRBThBY5UlKaaMsUKbCbgPJ8HNFgIC6Ns7FCLrdbw/STE5L
	NtTLGOs0+0hiuQi9xIryIrcEvYtEcKaEt2WrHk96cC81pqhfP0Svc9v+yfjT/NOm
	QasGcFtd1JIaFScuceineX0cHt1LtNOmrgDacDdijPor7PODPj2eqnuKx4vfJ+Cg
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 457jx024w2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 07 Mar 2025 06:33:09 +0000 (GMT)
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 5276X8dA002152;
	Fri, 7 Mar 2025 06:33:08 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 457jx024vy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 07 Mar 2025 06:33:08 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5273ptcA025012;
	Fri, 7 Mar 2025 06:33:07 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 454f92cs7e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 07 Mar 2025 06:33:07 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5276X6n941484648
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 7 Mar 2025 06:33:06 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2BD4920043;
	Fri,  7 Mar 2025 06:33:06 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C787020040;
	Fri,  7 Mar 2025 06:33:01 +0000 (GMT)
Received: from [9.124.218.213] (unknown [9.124.218.213])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri,  7 Mar 2025 06:33:01 +0000 (GMT)
Message-ID: <2926c843-62e6-419b-a045-e49bdd0b0b97@linux.ibm.com>
Date: Fri, 7 Mar 2025 12:03:01 +0530
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Shrikanth Hegde <sshegde@linux.ibm.com>
Subject: Re: [PATCH v2 4/8] sched/deadline: Rebuild root domain accounting
 after every update
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
        Swapnil Sapkal <swapnil.sapkal@amd.com>, cgroups@vger.kernel.org,
        Phil Auld <pauld@redhat.com>, luca.abeni@santannapisa.it,
        linux-kernel@vger.kernel.org, tommaso.cucinotta@santannapisa.it,
        Jon Hunter <jonathanh@nvidia.com>
References: <20250306141016.268313-1-juri.lelli@redhat.com>
 <20250306141016.268313-5-juri.lelli@redhat.com>
Content-Language: en-US
In-Reply-To: <20250306141016.268313-5-juri.lelli@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: WiGCthaIkkcdAAhbRu_qw1VZaJElO8hh
X-Proofpoint-ORIG-GUID: WA-lyjapa09EPcq-i9zLOMdLbhhdoowZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-07_02,2025-03-06_04,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999
 suspectscore=0 bulkscore=0 clxscore=1015 malwarescore=0 spamscore=0
 lowpriorityscore=0 priorityscore=1501 phishscore=0 mlxscore=0 adultscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502100000 definitions=main-2503070044

Hi Juri.

On 3/6/25 19:40, Juri Lelli wrote:
> Rebuilding of root domains accounting information (total_bw) is
> currently broken on some cases, e.g. suspend/resume on aarch64. Problem
> is that the way we keep track of domain changes and try to add bandwidth
> back is convoluted and fragile.
> 
> Fix it by simplify things by making sure bandwidth accounting is cleared
> and completely restored after root domains changes (after root domains
> are again stable).
> 
> Reported-by: Jon Hunter <jonathanh@nvidia.com>
> Fixes: 53916d5fd3c0 ("sched/deadline: Check bandwidth overflow earlier for hotplug")
> Signed-off-by: Juri Lelli <juri.lelli@redhat.com>
> ---
>   include/linux/sched/deadline.h |  4 ++++
>   include/linux/sched/topology.h |  2 ++
>   kernel/cgroup/cpuset.c         | 16 +++++++++-------
>   kernel/sched/deadline.c        | 16 ++++++++++------
>   kernel/sched/topology.c        |  1 +
>   5 files changed, 26 insertions(+), 13 deletions(-)
> 
> diff --git a/include/linux/sched/deadline.h b/include/linux/sched/deadline.h
> index 6ec578600b24..a780068aa1a5 100644
> --- a/include/linux/sched/deadline.h
> +++ b/include/linux/sched/deadline.h
> @@ -34,6 +34,10 @@ static inline bool dl_time_before(u64 a, u64 b)
>   struct root_domain;
>   extern void dl_add_task_root_domain(struct task_struct *p);
>   extern void dl_clear_root_domain(struct root_domain *rd);
> +extern void dl_clear_root_domain_cpu(int cpu);
> +
> +extern u64 dl_cookie;
> +extern bool dl_bw_visited(int cpu, u64 gen);

Is this needed? There is same declaration outside of CONFIG_SMP done in 
patch 3/8.

>   
>   #endif /* CONFIG_SMP */
>   
> diff --git a/include/linux/sched/topology.h b/include/linux/sched/topology.h
> index 7f3dbafe1817..1622232bd08b 100644
> --- a/include/linux/sched/topology.h
> +++ b/include/linux/sched/topology.h
> @@ -166,6 +166,8 @@ static inline struct cpumask *sched_domain_span(struct sched_domain *sd)
>   	return to_cpumask(sd->span);
>   }
>   
> +extern void dl_rebuild_rd_accounting(void);
> +
>   extern void partition_sched_domains_locked(int ndoms_new,
>   					   cpumask_var_t doms_new[],
>   					   struct sched_domain_attr *dattr_new);
> diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
> index f87526edb2a4..f66b2aefdc04 100644
> --- a/kernel/cgroup/cpuset.c
> +++ b/kernel/cgroup/cpuset.c
> @@ -954,10 +954,12 @@ static void dl_update_tasks_root_domain(struct cpuset *cs)
>   	css_task_iter_end(&it);
>   }
>   
> -static void dl_rebuild_rd_accounting(void)
> +void dl_rebuild_rd_accounting(void)
>   {
>   	struct cpuset *cs = NULL;
>   	struct cgroup_subsys_state *pos_css;
> +	int cpu;
> +	u64 cookie = ++dl_cookie;
>   
>   	lockdep_assert_held(&cpuset_mutex);
>   	lockdep_assert_cpus_held();
> @@ -965,11 +967,12 @@ static void dl_rebuild_rd_accounting(void)
>   
>   	rcu_read_lock();
>   
> -	/*
> -	 * Clear default root domain DL accounting, it will be computed again
> -	 * if a task belongs to it.
> -	 */
> -	dl_clear_root_domain(&def_root_domain);
> +	for_each_possible_cpu(cpu) {
> +		if (dl_bw_visited(cpu, cookie))
> +			continue;
> +
> +		dl_clear_root_domain_cpu(cpu);
> +	}
>   
>   	cpuset_for_each_descendant_pre(cs, pos_css, &top_cpuset) {
>   
> @@ -996,7 +999,6 @@ partition_and_rebuild_sched_domains(int ndoms_new, cpumask_var_t doms_new[],
>   {
>   	sched_domains_mutex_lock();
>   	partition_sched_domains_locked(ndoms_new, doms_new, dattr_new);
> -	dl_rebuild_rd_accounting();
>   	sched_domains_mutex_unlock();
>   }
>   
> diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
> index 339434271cba..17b040c92885 100644
> --- a/kernel/sched/deadline.c
> +++ b/kernel/sched/deadline.c
> @@ -166,7 +166,7 @@ static inline unsigned long dl_bw_capacity(int i)
>   	}
>   }
>   
> -static inline bool dl_bw_visited(int cpu, u64 cookie)
> +bool dl_bw_visited(int cpu, u64 cookie)
>   {
>   	struct root_domain *rd = cpu_rq(cpu)->rd;
>   
> @@ -207,7 +207,7 @@ static inline unsigned long dl_bw_capacity(int i)
>   	return SCHED_CAPACITY_SCALE;
>   }
>   
> -static inline bool dl_bw_visited(int cpu, u64 cookie)
> +bool dl_bw_visited(int cpu, u64 cookie)
>   {
>   	return false;
>   }
> @@ -2981,18 +2981,22 @@ void dl_clear_root_domain(struct root_domain *rd)
>   	rd->dl_bw.total_bw = 0;
>   
>   	/*
> -	 * dl_server bandwidth is only restored when CPUs are attached to root
> -	 * domains (after domains are created or CPUs moved back to the
> -	 * default root doamin).
> +	 * dl_servers are not tasks. Since dl_add_task_root_domanin ignores

s/dl_add_task_root_domanin/dl_add_task_root_domain

> +	 * them, we need to account for them here explicitly.
>   	 */
>   	for_each_cpu(i, rd->span) {
>   		struct sched_dl_entity *dl_se = &cpu_rq(i)->fair_server;
>   
>   		if (dl_server(dl_se) && cpu_active(i))
> -			rd->dl_bw.total_bw += dl_se->dl_bw;
> +			__dl_add(&rd->dl_bw, dl_se->dl_bw, dl_bw_cpus(i));
>   	}
>   }
>   
> +void dl_clear_root_domain_cpu(int cpu)
> +{
> +	dl_clear_root_domain(cpu_rq(cpu)->rd);
> +}
> +
>   #endif /* CONFIG_SMP */
>   
>   static void switched_from_dl(struct rq *rq, struct task_struct *p)
> diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
> index 44093339761c..363ad268a25b 100644
> --- a/kernel/sched/topology.c
> +++ b/kernel/sched/topology.c
> @@ -2791,6 +2791,7 @@ void partition_sched_domains_locked(int ndoms_new, cpumask_var_t doms_new[],
>   	ndoms_cur = ndoms_new;
>   
>   	update_sched_domain_debugfs();
> +	dl_rebuild_rd_accounting();
>   }
>   
>   /*


