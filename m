Return-Path: <cgroups+bounces-6811-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 92C82A4E398
	for <lists+cgroups@lfdr.de>; Tue,  4 Mar 2025 16:36:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 247AD1886D62
	for <lists+cgroups@lfdr.de>; Tue,  4 Mar 2025 15:29:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 973CF28150D;
	Tue,  4 Mar 2025 15:17:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Bq4CxKEz"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82EAD281520
	for <cgroups@vger.kernel.org>; Tue,  4 Mar 2025 15:17:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741101472; cv=none; b=J8ezImhk25Y2ULN614XHAk2G3rf5AyGAUWEQK5bEil4Syy/CQt09IRBvQoVlsz7YvPCCNl1RrZZkF6Jxz4ebt7SF/SuuZxEkWMXlmo7T7IH4DsxUM2SvR1dMmPAMkOzB8uZg3jqM7dI92RNnZ9odYCJOj8oeC6oar9RBZk1aFg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741101472; c=relaxed/simple;
	bh=WOkwYBJ6mURKrzAo56DfT5siukCfEs71MN6//Njmljw=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=DrtWYacp9iqix5IOF2no1ooemgvl/E1IX+MISixnc+byx9KkHQVtyb3SHQ7U/S7StoIGo+9z42b5hM/mdZPilEkgLD88ssjKgJOKfk/AigxS/ewU2UR1H5vX89zn/FwzjJUx0AhJ7XW4Bp/HeOZj5Z2LgMS9FzE6epsmTHUQpL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Bq4CxKEz; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741101469;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=O0lr8kKXCfO90fVf3E5CbEg1FpivAju4c8en810I8Rk=;
	b=Bq4CxKEzOrAAZWs9p3C6zXxlYfJiUuucdst/yynv00e0+iz/7/EiplzMjmXEAHLWxslc8A
	U7vY7y2+B1+dPBNoe+ESnH0SudztG6hQGR7NEOxutFIZtNa7eKiQuynAtLBlWshFqDU2Fy
	eipLqY/Ik6PfS78FYBEGPYgEf+WAyrk=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-77-j2ksjsHJP7ubbtfnPTtwiQ-1; Tue, 04 Mar 2025 10:17:48 -0500
X-MC-Unique: j2ksjsHJP7ubbtfnPTtwiQ-1
X-Mimecast-MFC-AGG-ID: j2ksjsHJP7ubbtfnPTtwiQ_1741101468
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-6e8e171fd66so12728116d6.0
        for <cgroups@vger.kernel.org>; Tue, 04 Mar 2025 07:17:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741101468; x=1741706268;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=O0lr8kKXCfO90fVf3E5CbEg1FpivAju4c8en810I8Rk=;
        b=wMeP0jllgR6EmQ0/m8tBiHat0XHp5NIPcmSzBAg5vr/HE7q/neuvo1vNiKU1udC/Ob
         bpaB6YkfefbmrQfXWMiHeaGF0XH1hcbeX/dh8jZ+tf+GfDrX4sdf3HpuZX9amRsW0s9C
         h+EdPfYSttALcAQbwP+3GPYbjyDh51PwCUfhaFKqLIyQv4fNG2rsjlEjFiUVvt/oJgoS
         PC9/HlGclGZH1HLfuMrHltWE+KaKyGn6PsRHFiJacN+Qj+b5WBHJlKXrd9NM8uK52uyt
         OIg1bmW79k1OOsn7bfS0qojnSoR2cest8BLb+ghf3p8Msf6tjxKvxJp+Hd00kGo3nAEY
         W0Uw==
X-Forwarded-Encrypted: i=1; AJvYcCUFBtkjSSdlt4b0/go2Gx/7SMDXMAe/OOsO/KSfcssjCz/imPGa55DlO0Wc3sOpLwagNeOvhcAS@vger.kernel.org
X-Gm-Message-State: AOJu0YyPEnjuTQaLIk3gCmaLjmyDTSd+J6Afvr9URz+TLKN7ZbRwM6Nn
	H1+FLZijBpD9jUi0wnA1F9yqu1vfMT+qBXG/JFzC+h3K/a7QAUAH84xV2oqenETP/QXiPR+QGM2
	4Uvx6VgwEoO5XkHvchkMlh359k+o8ObdPcc0ilkoAzJ1cpzoubwVMxXo=
X-Gm-Gg: ASbGncv9nVe4hHiOTmC7vMPbSxS298XHAx2jQR8+2H7KhbnF7RsR9C3xBFOlo2LI3Yn
	W0zVX2nmiyfe/+UJwXVLP/HjbpbtSGWIQ5Til2LdiGD+syKcqGw0KrVivT5ED07bknWPRaWStNz
	bEtHBnwMxAyvBwVqPCpi9qwFInsZXqeFVN5JfYquGxqF1JoSdxE1cnyBOh6yp1oPDARr/D850/l
	qUlU9zzXg0lQJKRZ87jcOPrNrzjKzoqjI3osVb2hq0LkKXgBVCkrV3vEpsZ48EwGciUJoal+AF3
	srzl7EgU8L2DPWef/AP7lxJjX0s70LPW5gSK0GD5aTJKpNcFpVb+xbA4cbc=
X-Received: by 2002:a05:6214:2462:b0:6e4:2f4c:f2d2 with SMTP id 6a1803df08f44-6e8a0d4a85dmr296961136d6.31.1741101467604;
        Tue, 04 Mar 2025 07:17:47 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFkHDKpx95IvLlNWfMuPOgJAI9UpdVjyVUiKIhZFFUom81X7LiUCPrloV7QmTIDO56sr2LL9A==
X-Received: by 2002:a05:6214:2462:b0:6e4:2f4c:f2d2 with SMTP id 6a1803df08f44-6e8a0d4a85dmr296960696d6.31.1741101467233;
        Tue, 04 Mar 2025 07:17:47 -0800 (PST)
Received: from ?IPV6:2601:188:c100:5710:627d:9ff:fe85:9ade? ([2601:188:c100:5710:627d:9ff:fe85:9ade])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6e897634a8dsm67563276d6.7.2025.03.04.07.17.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Mar 2025 07:17:46 -0800 (PST)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <e78c0d2d-c5bf-41f1-9786-981c60b7b50c@redhat.com>
Date: Tue, 4 Mar 2025 10:17:45 -0500
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/5] sched/deadline: Rebuild root domain accounting after
 every update
To: Juri Lelli <juri.lelli@redhat.com>, linux-kernel@vger.kernel.org,
 cgroups@vger.kernel.org
Cc: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>,
 Mel Gorman <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>,
 Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>,
 =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>,
 Qais Yousef <qyousef@layalina.io>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Swapnil Sapkal <swapnil.sapkal@amd.com>,
 Shrikanth Hegde <sshegde@linux.ibm.com>, Phil Auld <pauld@redhat.com>,
 luca.abeni@santannapisa.it, tommaso.cucinotta@santannapisa.it,
 Jon Hunter <jonathanh@nvidia.com>
References: <20250304084045.62554-1-juri.lelli@redhat.com>
 <20250304084045.62554-5-juri.lelli@redhat.com>
Content-Language: en-US
In-Reply-To: <20250304084045.62554-5-juri.lelli@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/4/25 3:40 AM, Juri Lelli wrote:
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
>   	cpuset_for_each_descendant_pre(cs, pos_css, &top_cpuset) {
>   
> @@ -996,7 +999,6 @@ partition_and_rebuild_sched_domains(int ndoms_new, cpumask_var_t doms_new[],
>   {
>   	sched_domains_mutex_lock();
>   	partition_sched_domains_locked(ndoms_new, doms_new, dattr_new);
> -	dl_rebuild_rd_accounting();
>   	sched_domains_mutex_unlock();
>   }

With this patch, partition_and_rebuild_sched_domains() is essentially 
the same as partition_sched_domains(). We can remove 
partition_and_rebuild_sched_domains() and use partition_sched_domains() 
directly. Also we don't need to expose partition_sched_domains_locked() 
as well as there is no more caller outside of topology.c.

Cheers,
Longman

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
> index b70d6002bb93..bdfda0ef1bd9 100644
> --- a/kernel/sched/topology.c
> +++ b/kernel/sched/topology.c
> @@ -2796,6 +2796,7 @@ void partition_sched_domains_locked(int ndoms_new, cpumask_var_t doms_new[],
>   	ndoms_cur = ndoms_new;
>   
>   	update_sched_domain_debugfs();
> +	dl_rebuild_rd_accounting();
>   }
>   
>   /*


