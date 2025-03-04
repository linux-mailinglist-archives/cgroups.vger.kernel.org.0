Return-Path: <cgroups+bounces-6810-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A8F2A4E2E8
	for <lists+cgroups@lfdr.de>; Tue,  4 Mar 2025 16:22:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0210F881E6F
	for <lists+cgroups@lfdr.de>; Tue,  4 Mar 2025 15:12:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B383D24BBF7;
	Tue,  4 Mar 2025 15:06:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="J93AxCqh"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF36926B2D4
	for <cgroups@vger.kernel.org>; Tue,  4 Mar 2025 15:06:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741100762; cv=none; b=FNHtt8/sCcLML9YPCv53Xdb2TihACBneQiH2gS7anN8jtjYDCRR07p6uwGp9tgos0kzOJaovGLoDIWScXs2xFFxayL4R4jnuhAU+r2NppZYPt4H42V4k7nlokGGmEde13ZaZXvmm96nplyDfgS+91d2JWMGKZoTyHG8doi+UdSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741100762; c=relaxed/simple;
	bh=Ausz82rABUmsFDHngVFigCx2TfyazEHTkTJOWZT6A/k=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=ESt4zPX1wlA0lF+ANKIOWJ6hVQgNJOUriA2BbHsX+Y3ASnzNBzYRVDYdPAd95dVDSF4Rt5JggIC70o/X1TDf1SMCT2n/HhHOu5tQGW3e3atbyzJ1WnKcCcmiwqSP4NjziRwYKsFzfm/sUS/Qo/K61d2hdW+288vb8Zk1uSFIcvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=J93AxCqh; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741100759;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wLtWpbvMEFCI7y1aGgi0AZHDOLR7+yjwGF1He+h1A9c=;
	b=J93AxCqh3b8A63uvApy8g5w3vla12QNLitkTbfSqqI84ixM86w1tES8+P7s++svnKy14GN
	PhL0pDxE3P4nqzWbkkSB9N8dYY+R6QDYGsOhiPIXz5DyhWTy44j9mBX3b1xmsuAd75/bxA
	/69notEZbXAKUrxUjGYEty7XEmG4N5c=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-586-vl2ML_HgOGGglzGHYQZ_iw-1; Tue, 04 Mar 2025 10:05:58 -0500
X-MC-Unique: vl2ML_HgOGGglzGHYQZ_iw-1
X-Mimecast-MFC-AGG-ID: vl2ML_HgOGGglzGHYQZ_iw_1741100758
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-474fff2dd31so15319411cf.0
        for <cgroups@vger.kernel.org>; Tue, 04 Mar 2025 07:05:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741100757; x=1741705557;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wLtWpbvMEFCI7y1aGgi0AZHDOLR7+yjwGF1He+h1A9c=;
        b=UrAKl+Nijz8OyE4BR3ln//ONQ74fDc8d5Mxx+NbwAvFP5fc4551Xn36sboGVoAJTkv
         cgex7AyYTq7pnFbH2RPBi4C46RyhYJatixlMpWRwmag2EIeiDxXB9FOomoVkNyXzWPbt
         0Qg8wfEXnQgfr2yinhl5VmKV4wIjJ//L9ow6hXnHHntY3C1/3C2tWS8aen8yYqNuFNke
         GFCIhHrz2Zi+NLwntyB4bOzc4o0K6O9pta9GQNRpVPmBILZEofX/fzMayr8g8yMZFJgw
         oYRVaZnw+LHARVly6zU+KKnZXZrt0FtQ7CpAwnyjHkhyoRw9AbpW6Ztk5zImEPzsiCY3
         T8YQ==
X-Forwarded-Encrypted: i=1; AJvYcCVbL7y+VQQMmHf7pcy2rc/mmixlHnHah3jPy8JK9rEAamjCoHwIrm0H9p8jzBWn0U0f1nFJaY22@vger.kernel.org
X-Gm-Message-State: AOJu0YzNZHJAq3lIv4q84MOqrGz5h+01S+pRTfWKmqx6z0HRAZNR5RbQ
	0rmhD/JbxIsxQEmyqwrgZo6D/545dh/ySt48gu1/G7SEdwuF1DYJ06rUcFK6uiMZyrsEXIvT1Ki
	Jr99cHDr+e6gjDjSFUrZ3Jld49XiXwuLvzGbX0s4emZL5ojXwtuPC5vM=
X-Gm-Gg: ASbGnctLFlDyXgHvkE37OcxM5fuQtJfwIWjyN5o7NE47k1cS8UWrxKOroj1HdbnhrPk
	Rzcs0vi0CSpTEOZweaz5kXGLV3c/g/3f1ib8VTCPmt444qgxmIr0eAaBz2PlKS2mDU3v1Gj+Ame
	0BM8DKiKAzGbkVN9QmGfI/VAm100oEZ9R51e3PkyD1yifc751z41PYvzVo4EFBdUH0bIbHICq83
	k6PK2XBzD7J8f53MDihv+zYScC7oiUuTvmnPfvqrsqvbD6p++r0L765B8/+Aoar2aXKNLzJE4b0
	gGzQ1H8Kv2G4JoB0vnWeigBnfeR1YzDg5rpXkyRMRjie93PYyKlGGjIm/vs=
X-Received: by 2002:a05:622a:1187:b0:471:ef27:a316 with SMTP id d75a77b69052e-474bc0a9120mr240046911cf.25.1741100757701;
        Tue, 04 Mar 2025 07:05:57 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHmxjoZQ+WwtQaBwoBtwwt7AY0W0M6nAO4E7HJDDlK+Q2gc9JnNsbTlz0jrKkabcpqb1EUUcQ==
X-Received: by 2002:a05:622a:1187:b0:471:ef27:a316 with SMTP id d75a77b69052e-474bc0a9120mr240046361cf.25.1741100757124;
        Tue, 04 Mar 2025 07:05:57 -0800 (PST)
Received: from ?IPV6:2601:188:c100:5710:627d:9ff:fe85:9ade? ([2601:188:c100:5710:627d:9ff:fe85:9ade])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-474fd8ce3bbsm11094961cf.59.2025.03.04.07.05.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Mar 2025 07:05:56 -0800 (PST)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <c02dd563-7cfc-404d-80d1-cec934117caf@redhat.com>
Date: Tue, 4 Mar 2025 10:05:54 -0500
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/5] sched/topology: Wrappers for sched_domains_mutex
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
 <20250304084045.62554-3-juri.lelli@redhat.com>
Content-Language: en-US
In-Reply-To: <20250304084045.62554-3-juri.lelli@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/4/25 3:40 AM, Juri Lelli wrote:
> Create wrappers for sched_domains_mutex so that it can transparently be
> used on both CONFIG_SMP and !CONFIG_SMP, as some function will need to
> do.
>
> Reported-by: Jon Hunter <jonathanh@nvidia.com>
> Fixes: 53916d5fd3c0 ("sched/deadline: Check bandwidth overflow earlier for hotplug")
> Signed-off-by: Juri Lelli <juri.lelli@redhat.com>
> ---
>   include/linux/sched.h   |  2 ++
>   kernel/cgroup/cpuset.c  |  4 ++--
>   kernel/sched/core.c     |  4 ++--
>   kernel/sched/debug.c    |  8 ++++----
>   kernel/sched/topology.c | 17 +++++++++++++++--
>   5 files changed, 25 insertions(+), 10 deletions(-)
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

If all access to sched_domains_mutex is through the wrappers, we may not 
need to expose sched_domains_mutex at all. Also it is more efficient for 
the non-SMP case to put the wrappers inside the CONFIG_SMP block and 
define the empty inline functions in the else part.


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
> index 9aecd914ac69..7b14500d731b 100644
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
> index c49aea8c1025..e2b879ec9458 100644
> --- a/kernel/sched/topology.c
> +++ b/kernel/sched/topology.c
> @@ -6,6 +6,19 @@
>   #include <linux/bsearch.h>
>   
>   DEFINE_MUTEX(sched_domains_mutex);
> +#ifdef CONFIG_SMP
> +void sched_domains_mutex_lock(void)
> +{
> +	mutex_lock(&sched_domains_mutex);
> +}
> +void sched_domains_mutex_unlock(void)
> +{
> +	mutex_unlock(&sched_domains_mutex);
> +}
> +#else
> +void sched_domains_mutex_lock(void) { }
> +void sched_domains_mutex_unlock(void) { }
> +#endif
>   
>   /* Protected by sched_domains_mutex: */
>   static cpumask_var_t sched_domains_tmpmask;
> @@ -2791,7 +2804,7 @@ void partition_sched_domains_locked(int ndoms_new, cpumask_var_t doms_new[],
>   void partition_sched_domains(int ndoms_new, cpumask_var_t doms_new[],
>   			     struct sched_domain_attr *dattr_new)
>   {
> -	mutex_lock(&sched_domains_mutex);
> +	sched_domains_mutex_lock();
>   	partition_sched_domains_locked(ndoms_new, doms_new, dattr_new);
> -	mutex_unlock(&sched_domains_mutex);
> +	sched_domains_mutex_unlock();
>   }

There are two "lockdep_assert_held(&sched_domains_mutex);" statements in 
topology.c file and one in cpuset.c. That can be problematic in the 
non-SMP case. Maybe another wrapper to do the assert?

Cheers,
Longman



