Return-Path: <cgroups+bounces-6878-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EBE69A561D9
	for <lists+cgroups@lfdr.de>; Fri,  7 Mar 2025 08:33:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2F8AA18942F6
	for <lists+cgroups@lfdr.de>; Fri,  7 Mar 2025 07:33:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 982B81A4E9E;
	Fri,  7 Mar 2025 07:33:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="G+/lI6zr"
X-Original-To: cgroups@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B788A19CC02;
	Fri,  7 Mar 2025 07:33:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741332798; cv=none; b=i9vyGPxx2GkixAW7446DuuVfCVsqWj4ctDlKRlry8A32xmff/lT+frvnoV7cl5iREHwb+Mt2TNov1iEV3IalDyzwxULRAmjUrqzlDn+jOupz7EukV8sL9zEFkqIfh6cdRv6OR/n+jaiQTyUMy0je0FWdflLY6qHSKjZ8X7HqFKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741332798; c=relaxed/simple;
	bh=eDPyLva+3ycJMNxZ3ZwXOg52wZmOxAi1w6ol2jRP/u8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Rxg0nCshMTQ+DSFN5NCMGwemgHUHvbChxVLjNGKwRdPF2K9VAUy31WUXyf5WxVHqLgMXRPY2NR5ww5eYzAFTIemo5fsbYdHYFh+pomFx7tNHmqcian6c/ICVqpmv3DR7t0k6frdyZBg1OpM+KF5AsbjZvAnN20US/uaqCcfC2RQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=G+/lI6zr; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 526KpdMX011752;
	Fri, 7 Mar 2025 07:32:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=ubrYVp
	qk50rcjMnv39H3MY8gteUJk4S0eCQfVy0GMbk=; b=G+/lI6zrT3e8gE2GIYRTjB
	QSBzvJZ2D5gvCmhOMOJ778iBmMY7h/ScsPGA23z9GkKtBvXC7kRGobvy0qpSK25A
	Twefz8e3XC7xqgAx+XEeI5n6h4/BdSOIqs+/F0OBDaEuJFZM2KtAaIXMyymb4tX8
	nwGdk6YTCGbiVSK9a2XrXDhQN2rBvIcm7A9Mh7gT7ZoFdwqBEZWIMfuoxI1b900p
	QNS3EV8/0elZUMDGkEXdR47eiK852fqKbEYDxlUArv/BbYH0CvXiSSlZYWaCvKIF
	qk+hWLTAEZV8ax1d/MzbczeFyFsnehzSaO1+detcdJKb6ZrkC/cMT8AnNdcG2vRQ
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 457k45aadp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 07 Mar 2025 07:32:24 +0000 (GMT)
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 5277RAJC028063;
	Fri, 7 Mar 2025 07:32:23 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 457k45aadh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 07 Mar 2025 07:32:23 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5273rtrB025064;
	Fri, 7 Mar 2025 07:32:22 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 454f92cyw7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 07 Mar 2025 07:32:22 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5277WKcs50004248
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 7 Mar 2025 07:32:21 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DC8A92004E;
	Fri,  7 Mar 2025 07:32:20 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 99FB920040;
	Fri,  7 Mar 2025 07:32:16 +0000 (GMT)
Received: from [9.124.218.213] (unknown [9.124.218.213])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri,  7 Mar 2025 07:32:16 +0000 (GMT)
Message-ID: <295680e1-ba91-4019-9b7f-e8efd75d7f13@linux.ibm.com>
Date: Fri, 7 Mar 2025 13:02:15 +0530
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/8] sched/deadline: Rebuild root domain accounting
 after every update
To: Juri Lelli <juri.lelli@redhat.com>, linux-kernel@vger.kernel.org,
        cgroups@vger.kernel.org
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
        Jon Hunter <jonathanh@nvidia.com>
References: <20250306141016.268313-1-juri.lelli@redhat.com>
 <20250306141016.268313-5-juri.lelli@redhat.com>
From: Shrikanth Hegde <sshegde@linux.ibm.com>
Content-Language: en-US
In-Reply-To: <20250306141016.268313-5-juri.lelli@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: H5E39Y8HQmVajRQaIIoFk01IleThurC5
X-Proofpoint-GUID: P6_eV3Mygq6EyTwXENHnTUGYqqXswSxh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-07_02,2025-03-06_04,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 malwarescore=0
 mlxlogscore=999 mlxscore=0 adultscore=0 clxscore=1015 impostorscore=0
 priorityscore=1501 suspectscore=0 bulkscore=0 lowpriorityscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502100000 definitions=main-2503070053



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

This will clear all possible root domains bandwidth and rebuild it.

For an online CPUs, the fair server bandwidth is added i think in 
rq_attach_root. But for an offline CPUs the sched domains wont be 
rebuilt. It may not be an issue. but the def_root_domain's bw may be 
different afterwords. no?

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


