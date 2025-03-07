Return-Path: <cgroups+bounces-6877-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E2DF1A560EF
	for <lists+cgroups@lfdr.de>; Fri,  7 Mar 2025 07:35:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2271C1892EB7
	for <lists+cgroups@lfdr.de>; Fri,  7 Mar 2025 06:35:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B43C19DF53;
	Fri,  7 Mar 2025 06:35:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="GHdKuhXo"
X-Original-To: cgroups@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D0E319CC0E;
	Fri,  7 Mar 2025 06:35:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741329325; cv=none; b=nta16nN/oEI+3FeI0cTe/f4dQSIa3fRaboraA/cqdTcL4S7kTKeIKg84guHEHaYcVUwMhGte7PEXXQIhoUZsDdd+l6j3PqzQrOUSP5AEJhYabLOtC8U83WCQ/1EcC0RYmUIbnyAsFCSW+XpWX/42y7qYmYI2of5cs9Zxj9g7Mj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741329325; c=relaxed/simple;
	bh=GYx5eaMgcMyVlORSNU0ESK5+cU+zv7MGm1Y6eXzB8yA=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=pxiO7LdmGhOAbWWIZg6O6jwgabRQaf07q/9Hy4p1wHCgKH2SqBJJHP5aPVIHRXgAmoKgLdEz030UOtuAWH3wGfpRi4dsA/gg6tnxRZ9+GJsW1sMl0yd5BLiZ3FXd1yuIYOXuXRTysu4Ajvkl9iWC2RQqSIZ4gjD0l1KKxGNnM5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=GHdKuhXo; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 526KpeKS011769;
	Fri, 7 Mar 2025 06:34:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=aZFszm
	ZgUb3ZJkTR3TenzC+7WpiH8t/ykh1ucKiM1WU=; b=GHdKuhXozYiZU0py6nK8mN
	yX8dpt/a3gCE6ITl5/ROF+X4SaWIEpM4jOlacok5vL78dLz/2I0w9sw8/Vhonlu4
	IRe7RSH4/RNRebINctkOcG2tmy0W6446VtYrfv3UwBoM3T11pYwkskHKgxJnYfoK
	4UqJc/+lhyqW3f1hCEMOjIg2VGX2UY76EEmGynoG7A8E9scKHrVmyROdX9ighF7z
	s9l5jlRMRvSj+zhk1iTiGLkUlfnwTaSKyxwX/xQgK8bVoRlvpja9hH8+UmDInira
	EExjLcYdR1MjiudfdAJvzQ+I1Hc8nnSElUjYHylEKdwVcvGmC/jtlYk/GLW105zA
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 457k45a3gg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 07 Mar 2025 06:34:38 +0000 (GMT)
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 5276YbwU021836;
	Fri, 7 Mar 2025 06:34:37 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 457k45a3ge-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 07 Mar 2025 06:34:37 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5273rtdS025064;
	Fri, 7 Mar 2025 06:34:37 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 454f92csce-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 07 Mar 2025 06:34:36 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5276YZVv50266528
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 7 Mar 2025 06:34:35 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3FDF520043;
	Fri,  7 Mar 2025 06:34:35 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D7C4820040;
	Fri,  7 Mar 2025 06:34:30 +0000 (GMT)
Received: from [9.124.218.213] (unknown [9.124.218.213])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri,  7 Mar 2025 06:34:30 +0000 (GMT)
Message-ID: <6894861a-4a40-4c6d-8f48-997b999f5778@linux.ibm.com>
Date: Fri, 7 Mar 2025 12:04:29 +0530
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Shrikanth Hegde <sshegde@linux.ibm.com>
Subject: Re: [PATCH v2 2/8] sched/topology: Wrappers for sched_domains_mutex
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
 <20250306141016.268313-3-juri.lelli@redhat.com>
Content-Language: en-US
In-Reply-To: <20250306141016.268313-3-juri.lelli@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 9Sd9Xp_ZckaXXH0fxocA9f18CdD3gSmL
X-Proofpoint-GUID: tp0MwI61fGU-ugDMdJbuK1I1BdMfA5_m
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-07_02,2025-03-06_04,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 malwarescore=0
 mlxlogscore=999 mlxscore=0 adultscore=0 clxscore=1015 impostorscore=0
 priorityscore=1501 suspectscore=0 bulkscore=0 lowpriorityscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502100000 definitions=main-2503070044

Hi Juri.

On 3/6/25 19:40, Juri Lelli wrote:
> Create wrappers for sched_domains_mutex so that it can transparently be
> used on both CONFIG_SMP and !CONFIG_SMP, as some function will need to
> do.
> 
> Reported-by: Jon Hunter <jonathanh@nvidia.com>
> Fixes: 53916d5fd3c0 ("sched/deadline: Check bandwidth overflow earlier for hotplug")
> Signed-off-by: Juri Lelli <juri.lelli@redhat.com>
> ---
> v1 -> v2: Remove wrappers for the !SMP case as all users are not defined
>            either in that case
> ---
>   include/linux/sched.h   |  2 ++
>   kernel/cgroup/cpuset.c  |  4 ++--
>   kernel/sched/core.c     |  4 ++--
>   kernel/sched/debug.c    |  8 ++++----
>   kernel/sched/topology.c | 12 ++++++++++--
>   5 files changed, 20 insertions(+), 10 deletions(-)
> 
> diff --git a/include/linux/sched.h b/include/linux/sched.h
> index 9632e3318e0d..d5f8c161d852 100644
> --- a/include/linux/sched.h
> +++ b/include/linux/sched.h
> @@ -383,6 +383,8 @@ enum uclamp_id {
>   extern struct root_domain def_root_domain;
>   extern struct mutex sched_domains_mutex;
>   #endif
> +extern void sched_domains_mutex_lock(void);
> +extern void sched_domains_mutex_unlock(void);
>   
>   struct sched_param {
>   	int sched_priority;
> diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
> index 0f910c828973..f87526edb2a4 100644
> --- a/kernel/cgroup/cpuset.c
> +++ b/kernel/cgroup/cpuset.c
> @@ -994,10 +994,10 @@ static void
>   partition_and_rebuild_sched_domains(int ndoms_new, cpumask_var_t doms_new[],
>   				    struct sched_domain_attr *dattr_new)
>   {
> -	mutex_lock(&sched_domains_mutex);
> +	sched_domains_mutex_lock();
>   	partition_sched_domains_locked(ndoms_new, doms_new, dattr_new);
>   	dl_rebuild_rd_accounting();
> -	mutex_unlock(&sched_domains_mutex);
> +	sched_domains_mutex_unlock();
>   }
>   
>   /*
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index 67189907214d..58593f4d09a1 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -8424,9 +8424,9 @@ void __init sched_init_smp(void)
>   	 * CPU masks are stable and all blatant races in the below code cannot
>   	 * happen.
>   	 */
> -	mutex_lock(&sched_domains_mutex);
> +	sched_domains_mutex_lock();
>   	sched_init_domains(cpu_active_mask);
> -	mutex_unlock(&sched_domains_mutex);
> +	sched_domains_mutex_unlock();
>   
>   	/* Move init over to a non-isolated CPU */
>   	if (set_cpus_allowed_ptr(current, housekeeping_cpumask(HK_TYPE_DOMAIN)) < 0)
> diff --git a/kernel/sched/debug.c b/kernel/sched/debug.c
> index ef047add7f9e..a0893a483d35 100644
> --- a/kernel/sched/debug.c
> +++ b/kernel/sched/debug.c
> @@ -292,7 +292,7 @@ static ssize_t sched_verbose_write(struct file *filp, const char __user *ubuf,
>   	bool orig;
>   
>   	cpus_read_lock();
> -	mutex_lock(&sched_domains_mutex);
> +	sched_domains_mutex_lock();
>   
>   	orig = sched_debug_verbose;
>   	result = debugfs_write_file_bool(filp, ubuf, cnt, ppos);
> @@ -304,7 +304,7 @@ static ssize_t sched_verbose_write(struct file *filp, const char __user *ubuf,
>   		sd_dentry = NULL;
>   	}
>   
> -	mutex_unlock(&sched_domains_mutex);
> +	sched_domains_mutex_unlock();
>   	cpus_read_unlock();
>   
>   	return result;
> @@ -515,9 +515,9 @@ static __init int sched_init_debug(void)
>   	debugfs_create_u32("migration_cost_ns", 0644, debugfs_sched, &sysctl_sched_migration_cost);
>   	debugfs_create_u32("nr_migrate", 0644, debugfs_sched, &sysctl_sched_nr_migrate);
>   
> -	mutex_lock(&sched_domains_mutex);
> +	sched_domains_mutex_lock();
>   	update_sched_domain_debugfs();
> -	mutex_unlock(&sched_domains_mutex);
> +	sched_domains_mutex_unlock();
>   #endif
>   
>   #ifdef CONFIG_NUMA_BALANCING
> diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
> index c49aea8c1025..296ff2acfd32 100644
> --- a/kernel/sched/topology.c
> +++ b/kernel/sched/topology.c
> @@ -6,6 +6,14 @@
>   #include <linux/bsearch.h>
>   
>   DEFINE_MUTEX(sched_domains_mutex);
> +void sched_domains_mutex_lock(void)
> +{
> +	mutex_lock(&sched_domains_mutex);
> +}
> +void sched_domains_mutex_unlock(void)
> +{
> +	mutex_unlock(&sched_domains_mutex);
> +}
>   
>   /* Protected by sched_domains_mutex: */
>   static cpumask_var_t sched_domains_tmpmask;
> @@ -2791,7 +2799,7 @@ void partition_sched_domains_locked(int ndoms_new, cpumask_var_t doms_new[],
>   void partition_sched_domains(int ndoms_new, cpumask_var_t doms_new[],
>   			     struct sched_domain_attr *dattr_new)
>   {
> -	mutex_lock(&sched_domains_mutex);
> +	sched_domains_mutex_lock();
>   	partition_sched_domains_locked(ndoms_new, doms_new, dattr_new);
> -	mutex_unlock(&sched_domains_mutex);
> +	sched_domains_mutex_unlock();
>   }

Maybe sched_domains_mutex can be static since its only used in topology.c ?

Other than the above
Reviewed-by: Shrikanth Hegde <sshegde@linux.ibm.com>

