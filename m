Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B8E713F9AC2
	for <lists+cgroups@lfdr.de>; Fri, 27 Aug 2021 16:19:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232884AbhH0OT5 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 27 Aug 2021 10:19:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232257AbhH0OTk (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 27 Aug 2021 10:19:40 -0400
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com [IPv6:2607:f8b0:4864:20::d36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4909C0613CF
        for <cgroups@vger.kernel.org>; Fri, 27 Aug 2021 07:18:50 -0700 (PDT)
Received: by mail-io1-xd36.google.com with SMTP id a15so8691069iot.2
        for <cgroups@vger.kernel.org>; Fri, 27 Aug 2021 07:18:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=uZsEs/8kjOigJb/9CIkKujcCvyTVtquxdPpsZWziM2Y=;
        b=nDreCI/xOmeEf6Q9hlgH9sBVSs7+vcBblHdWls/D5MIdQYK11J66jrdchuffKwpj8C
         1o3lk6jlwlTOK56KNKiiiyOjFoKruwTSoajZTB3fuo9zVy3pPU6vWUOALr3jpwMlUK8f
         260rhgUH086HtMkMBvnlnRTPFhhs4JZlqGZDSXjmdqcoBgh0IsA6Yjrpxcxsm+716fuz
         5R+Maws6hyrjzYhIQomTkgmne+0ovh8TRXZhp8+XBN0W+abiP6wKq20Gy0NKuCFAOdce
         BIJC94PeCehqW8tMPlzD7Xxe2lRDWlZoc7cKR2d/cICtbQ/FYlr4DEfmMhn+2CkRaO1s
         7eqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=uZsEs/8kjOigJb/9CIkKujcCvyTVtquxdPpsZWziM2Y=;
        b=WPPGwKSgQgaNWb/mbUTetA7tsxA20oKcQArlF23tN+v6BRfs2/zRNOebY5lxq0oa5I
         8zQVMVNPmQMA7KfRtgZ7mpNMhnzG0tSHyFtO2SNuKoCOFUcqcL2lqn+YzaMIMNIqG6Tt
         ljnapEQF5y8/+q5ws/yC8GRAGsm3NBtpWF8tn2HektIZ2FBeTu/XtFlRjmAVqWmCsJnn
         kGHEZ8VyZJu9MY6h98e04Tq3Cz+l8xf5MJDwOnxsWyhfoapK/tia2sqQXO9XZ/qB7mh+
         h8cO80hevUGEKuv5T7X/2fsnwAmtpiybB94ARoz3op43FGCQxsbZFQbnXbt88LNpntBH
         dSyQ==
X-Gm-Message-State: AOAM531+pOudMvNigBRsqh93/+TL+GAiqgpqlSuI1Zg7FusWE50/9iVg
        v10ciDfhGb4aAn9rW8L8AiavQg==
X-Google-Smtp-Source: ABdhPJzVZ4K+foFu/Z+mrhKMyU1ClfLehrYaZ5lhgApZKunvqvBxp9yM9iuRSJRwMYomwbTS1SqdQg==
X-Received: by 2002:a02:cc30:: with SMTP id o16mr1355140jap.101.1630073930301;
        Fri, 27 Aug 2021 07:18:50 -0700 (PDT)
Received: from [192.168.1.30] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id h10sm3390577ilj.71.2021.08.27.07.18.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Aug 2021 07:18:49 -0700 (PDT)
Subject: Re: [PATCH for-5.15 v2] io_uring: consider cgroup setting when
 binding sqpoll cpu
To:     Hao Xu <haoxu@linux.alibaba.com>,
        Zefan Li <lizefan.x@bytedance.com>, Tejun Heo <tj@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Pavel Begunkov <asml.silence@gmail.com>
Cc:     io-uring@vger.kernel.org, cgroups@vger.kernel.org,
        Joseph Qi <joseph.qi@linux.alibaba.com>
References: <20210827141315.235974-1-haoxu@linux.alibaba.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <0988b0dc-232f-80cd-c984-2364c0dee69f@kernel.dk>
Date:   Fri, 27 Aug 2021 08:18:48 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210827141315.235974-1-haoxu@linux.alibaba.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 8/27/21 8:13 AM, Hao Xu wrote:
> Since sqthread is userspace like thread now, it should respect cgroup
> setting, thus we should consider current allowed cpuset when doing
> cpu binding for sqthread.

In general, this looks way better than v1. Just a few minor comments
below.

> @@ -7000,6 +7001,16 @@ static bool io_sqd_handle_event(struct io_sq_data *sqd)
>  	return did_sig || test_bit(IO_SQ_THREAD_SHOULD_STOP, &sqd->state);
>  }
>  
> +static int io_sq_bind_cpu(int cpu)
> +{
> +	if (!test_cpu_in_current_cpuset(cpu))
> +		pr_warn("sqthread %d: bound cpu not allowed\n", current->pid);
> +	else
> +		set_cpus_allowed_ptr(current, cpumask_of(cpu));
> +
> +	return 0;
> +}

This should not be triggerable, unless the set changes between creation
and the thread being created. Hence maybe the warn is fine. I'd probably
prefer terminating the thread at that point, which would result in an
-EOWNERDEAD return when someone attempts to wake the thread.

Which is probably OK, as we really should not hit this path.

> diff --git a/include/linux/cpuset.h b/include/linux/cpuset.h
> index 04c20de66afc..fad77c91bc1f 100644
> --- a/include/linux/cpuset.h
> +++ b/include/linux/cpuset.h
> @@ -116,6 +116,8 @@ static inline int cpuset_do_slab_mem_spread(void)
>  
>  extern bool current_cpuset_is_being_rebound(void);
>  
> +extern bool test_cpu_in_current_cpuset(int cpu);
> +
>  extern void rebuild_sched_domains(void);
>  
>  extern void cpuset_print_current_mems_allowed(void);
> @@ -257,6 +259,11 @@ static inline bool current_cpuset_is_being_rebound(void)
>  	return false;
>  }
>  
> +static inline bool test_cpu_in_current_cpuset(int cpu)
> +{
> +	return false;
> +}
> +
>  static inline void rebuild_sched_domains(void)
>  {
>  	partition_sched_domains(1, NULL, NULL);
> diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
> index adb5190c4429..a63c27e9430e 100644
> --- a/kernel/cgroup/cpuset.c
> +++ b/kernel/cgroup/cpuset.c
> @@ -1849,6 +1849,17 @@ bool current_cpuset_is_being_rebound(void)
>  	return ret;
>  }
>  
> +bool test_cpu_in_current_cpuset(int cpu)
> +{
> +	bool ret;
> +
> +	rcu_read_lock();
> +	ret = cpumask_test_cpu(cpu, task_cs(current)->effective_cpus);
> +	rcu_read_unlock();
> +
> +	return ret;
> +}
> +
>  static int update_relax_domain_level(struct cpuset *cs, s64 val)
>  {
>  #ifdef CONFIG_SMP

In terms of review and so forth, I'd split this into a prep patch. Then
patch 2 just becomes the io_uring consumer of it.

-- 
Jens Axboe

