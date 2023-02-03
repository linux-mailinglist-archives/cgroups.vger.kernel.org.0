Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62E8C68A3FB
	for <lists+cgroups@lfdr.de>; Fri,  3 Feb 2023 22:01:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232918AbjBCVBa (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 3 Feb 2023 16:01:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232926AbjBCVB2 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 3 Feb 2023 16:01:28 -0500
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 509141728;
        Fri,  3 Feb 2023 13:00:27 -0800 (PST)
Received: by mail-pf1-x42b.google.com with SMTP id a5so1598722pfv.10;
        Fri, 03 Feb 2023 13:00:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+b8TnNfk5HpRX2+jLolvQqR5er/qgFGP/PJZjr+rDww=;
        b=VtEc3firMEuR7MoYOPU4HtJ6MhKnzGhR0W2YC73IzSbv5qj0C/9q4m9zqhHT7+hLi8
         /AHYf4ixUm4qKzV2qdB9Ontci9e3SAwWHb5aSc1dGSRJkjbwHdVBbZ4OoFWjGm8DEcwu
         2g/eauO/KsQz3COI7P91NsVL4TV/YnJPEyLYaafVOrJUVeRxTJoLyR8nQJ90ZYed38mt
         Qd8E1EeVenTnYmuTC4shi8XjTVm5MjGue6QczlHnqb7bjyYaEQ8G9YJPcxaTyvkACXj+
         JAaGq+bu8vTy1SDm18FIQnIuVDaBoQNeKMupY/xs5zURfBFTwH2YPcjXwl77tGmVDRDI
         FakA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+b8TnNfk5HpRX2+jLolvQqR5er/qgFGP/PJZjr+rDww=;
        b=ngfB1wwB7FKbf6f6LgoKps4jvug8gbw8EcbbPfAUUHTl9fv534FptiWKf+tSeFh0yO
         ueTRSWsfg1rB0CxFx+760XGmtAhZeOZCFP/C8CAtCnI/rEg+V4NEMzhkikefP4buawfQ
         OVim1Pd6CZ6tDuqrZdD4zF8gcU04IT1yeHwgiuVGwqySdTHTJ+1GEitLUnIBv60x9jWA
         eantnFf7r+1WBaWdoRStAPvQv1oyBeFnXCPQpkl1Q3GnEGzb0FY5PylF+XmVEyz8BRCu
         AQDDQ8brqrq0Csr+aXCvhg0Z8JNVPPjHUqWnaY65Nusg25NAC442ArOUciovbpHcts4j
         fn7A==
X-Gm-Message-State: AO0yUKUpfs1LKq19gHFUgA++RnO5uPNf7unHcKKwRivUbzmXZz76W76c
        ZkklK12BZVh3T2zHbzEbmIM=
X-Google-Smtp-Source: AK7set89KOzWmP6+zl64+xeRo36XHKZA8RMxnWCFTSGuoO6lAtYLHp5shbSeMny2knRExcw0IE5XbQ==
X-Received: by 2002:a05:6a00:248c:b0:58d:abd5:504a with SMTP id c12-20020a056a00248c00b0058dabd5504amr12792719pfv.31.1675458026596;
        Fri, 03 Feb 2023 13:00:26 -0800 (PST)
Received: from localhost ([2620:10d:c090:400::5:35e])
        by smtp.gmail.com with ESMTPSA id w123-20020a627b81000000b00575b6d7c458sm2282247pfc.21.2023.02.03.13.00.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Feb 2023 13:00:26 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Fri, 3 Feb 2023 11:00:24 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Waiman Long <longman@redhat.com>
Cc:     Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        kernel-team@android.com
Subject: Re: [PATCH] cgroup/cpuset: Don't filter offline CPUs in
 cpuset_cpus_allowed() for top cpuset tasks
Message-ID: <Y9116OLfP6GoZ0ez@slm.duckdns.org>
References: <20230203164040.213437-1-longman@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230203164040.213437-1-longman@redhat.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Fri, Feb 03, 2023 at 11:40:40AM -0500, Waiman Long wrote:
> Since commit 8f9ea86fdf99 ("sched: Always preserve the user
> requested cpumask"), relax_compatible_cpus_allowed_ptr() is calling
> __sched_setaffinity() unconditionally. This helps to expose a bug in
> the current cpuset hotplug code where the cpumasks of the tasks in
> the top cpuset are not updated at all when some CPUs become online or
> offline. It is likely caused by the fact that some of the tasks in the
> top cpuset, like percpu kthreads, cannot have their cpu affinity changed.
> 
> One way to reproduce this as suggested by Peter is:
>  - boot machine
>  - offline all CPUs except one
>  - taskset -p ffffffff $$
>  - online all CPUs
> 
> Fix this by allowing cpuset_cpus_allowed() to return a wider mask that
> includes offline CPUs for those tasks that are in the top cpuset. For
> tasks not in the top cpuset, the old rule applies and only online CPUs
> will be returned in the mask since hotplug events will update their
> cpumasks accordingly.
> 
> Fixes: 8f9ea86fdf99 ("sched: Always preserve the user requested cpumask")
> Reported-by: Will Deacon <will@kernel.org>
> Originally-from: Peter Zijlstra (Intel) <peterz@infradead.org>
> Signed-off-by: Waiman Long <longman@redhat.com>

So, this is the replacement for the first patch[1] Will posted, right?

>  void cpuset_cpus_allowed(struct task_struct *tsk, struct cpumask *pmask)
>  {
>  	unsigned long flags;
> +	struct cpuset *cs;
>  
>  	spin_lock_irqsave(&callback_lock, flags);
> -	guarantee_online_cpus(tsk, pmask);
> +	rcu_read_lock();
> +
> +	cs = task_cs(tsk);
> +	if (cs != &top_cpuset)
> +		guarantee_online_cpus(tsk, pmask);
> +	/*
> +	 * TODO: Tasks in the top cpuset won't get update to their cpumasks
> +	 * when a hotplug online/offline event happens. So we include all
> +	 * offline cpus in the allowed cpu list.
> +	 */
> +	if ((cs == &top_cpuset) || cpumask_empty(pmask)) {
> +		const struct cpumask *possible_mask = task_cpu_possible_mask(tsk);
> +
> +		/*
> +		 * We first exclude cpus allocated to partitions. If there is no
> +		 * allowable online cpu left, we fall back to all possible cpus.
> +		 */
> +		cpumask_andnot(pmask, possible_mask, top_cpuset.subparts_cpus);

and the differences are that

* It's only applied to the root cgroup.

* Cpus taken up by partitions are excluded.

Is my understanding correct?

> +		if (!cpumask_intersects(pmask, cpu_online_mask))
> +			cpumask_copy(pmask, possible_mask);
> +	}
> +
> +	rcu_read_unlock();
>  	spin_unlock_irqrestore(&callback_lock, flags);

So, I suppose you're suggesting applying this patch instead of the one Will
Deacon posted[1] and we need Will's second patch[2] on top, right?

[1] http://lkml.kernel.org/r/20230131221719.3176-3-will@kernel.org
[2] http://lkml.kernel.org/r/20230131221719.3176-3-will@kernel.org

Thanks.

-- 
tejun
