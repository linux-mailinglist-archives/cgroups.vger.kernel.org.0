Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8466559C72
	for <lists+cgroups@lfdr.de>; Fri, 28 Jun 2019 15:03:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726759AbfF1NDn (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 28 Jun 2019 09:03:43 -0400
Received: from merlin.infradead.org ([205.233.59.134]:42904 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726558AbfF1NDn (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 28 Jun 2019 09:03:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=hNhbRK+lgaslS8SRTtf5siA3u2w3EzBwsK7J6J2XYis=; b=jNV5Y6ICUWEomVh/T/H1PUORD
        Xmc/50YdpSCSitGdcfnblqm8K9MqezT5JWiFd0pJHJym9GRt9EpxtOTORcsSP8e1cSNaZh4e+HqW9
        woWHRiXoepn/GKPrXO0PlpKT0vpgW62XocEMSxeXaqh6U03q6TZ5pduhuMJJkmZ0tWhAqVpfxQOh8
        HTRkUnmIE1qRifuJZWHh+2ksixAx+iGLc72/JVL6NQXv1N+D7lAaQGY3n7AAtOO+eAO/S1XEgVDeP
        OIxYJ8lrLsvH8SdLFVvFbDj2XGQ+wwM4FuH1TlGhLWafYJze9JqeK2k+vRUXP1ElPQM0QqNlLJKSR
        9p8Vffm6A==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hgqWz-0000eb-W6; Fri, 28 Jun 2019 13:03:10 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id AB49D2021621E; Fri, 28 Jun 2019 15:03:08 +0200 (CEST)
Date:   Fri, 28 Jun 2019 15:03:08 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Juri Lelli <juri.lelli@redhat.com>
Cc:     mingo@redhat.com, rostedt@goodmis.org, tj@kernel.org,
        linux-kernel@vger.kernel.org, luca.abeni@santannapisa.it,
        claudio@evidence.eu.com, tommaso.cucinotta@santannapisa.it,
        bristot@redhat.com, mathieu.poirier@linaro.org, lizefan@huawei.com,
        cgroups@vger.kernel.org, Prateek Sood <prsood@codeaurora.org>
Subject: Re: [PATCH v8 6/8] cgroup/cpuset: Change cpuset_rwsem and hotplug
 lock order
Message-ID: <20190628130308.GU3419@hirez.programming.kicks-ass.net>
References: <20190628080618.522-1-juri.lelli@redhat.com>
 <20190628080618.522-7-juri.lelli@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190628080618.522-7-juri.lelli@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Fri, Jun 28, 2019 at 10:06:16AM +0200, Juri Lelli wrote:
> cpuset_rwsem is going to be acquired from sched_setscheduler() with a
> following patch. There are however paths (e.g., spawn_ksoftirqd) in
> which sched_scheduler() is eventually called while holding hotplug lock;
> this creates a dependecy between hotplug lock (to be always acquired
> first) and cpuset_rwsem (to be always acquired after hotplug lock).
> 
> Fix paths which currently take the two locks in the wrong order (after
> a following patch is applied).
> Signed-off-by: Juri Lelli <juri.lelli@redhat.com>

This all reminds me of this:

  https://lkml.kernel.org/r/1510755615-25906-1-git-send-email-prsood@codeaurora.org

Which sadly got reverted again. If we do this now (I've always been a
proponent), then we can make that rebuild synchronous again, which
should also help here IIRC.

> ---
>  include/linux/cpuset.h |  8 ++++----
>  kernel/cgroup/cpuset.c | 22 +++++++++++++++++-----
>  2 files changed, 21 insertions(+), 9 deletions(-)
> 
> diff --git a/include/linux/cpuset.h b/include/linux/cpuset.h
> index 934633a05d20..7f1478c26a33 100644
> --- a/include/linux/cpuset.h
> +++ b/include/linux/cpuset.h
> @@ -40,14 +40,14 @@ static inline bool cpusets_enabled(void)
>  
>  static inline void cpuset_inc(void)
>  {
> -	static_branch_inc(&cpusets_pre_enable_key);
> -	static_branch_inc(&cpusets_enabled_key);
> +	static_branch_inc_cpuslocked(&cpusets_pre_enable_key);
> +	static_branch_inc_cpuslocked(&cpusets_enabled_key);
>  }
>  
>  static inline void cpuset_dec(void)
>  {
> -	static_branch_dec(&cpusets_enabled_key);
> -	static_branch_dec(&cpusets_pre_enable_key);
> +	static_branch_dec_cpuslocked(&cpusets_enabled_key);
> +	static_branch_dec_cpuslocked(&cpusets_pre_enable_key);
>  }
>  
>  extern int cpuset_init(void);
> diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
> index a7c0c8d8f132..d92b351f89e3 100644
> --- a/kernel/cgroup/cpuset.c
> +++ b/kernel/cgroup/cpuset.c
> @@ -1026,8 +1026,8 @@ static void rebuild_sched_domains_locked(void)
>  	cpumask_var_t *doms;
>  	int ndoms;
>  
> +	lockdep_assert_cpus_held();
>  	percpu_rwsem_assert_held(&cpuset_rwsem);
> -	get_online_cpus();
>  
>  	/*
>  	 * We have raced with CPU hotplug. Don't do anything to avoid
> @@ -1036,19 +1036,17 @@ static void rebuild_sched_domains_locked(void)
>  	 */
>  	if (!top_cpuset.nr_subparts_cpus &&
>  	    !cpumask_equal(top_cpuset.effective_cpus, cpu_active_mask))
> -		goto out;
> +		return;
>  
>  	if (top_cpuset.nr_subparts_cpus &&
>  	   !cpumask_subset(top_cpuset.effective_cpus, cpu_active_mask))
> -		goto out;
> +		return;
>  
>  	/* Generate domain masks and attrs */
>  	ndoms = generate_sched_domains(&doms, &attr);
>  
>  	/* Have scheduler rebuild the domains */
>  	partition_and_rebuild_sched_domains(ndoms, doms, attr);
> -out:
> -	put_online_cpus();
>  }
>  #else /* !CONFIG_SMP */
>  static void rebuild_sched_domains_locked(void)
> @@ -1058,9 +1056,11 @@ static void rebuild_sched_domains_locked(void)
>  
>  void rebuild_sched_domains(void)
>  {
> +	get_online_cpus();
>  	percpu_down_write(&cpuset_rwsem);
>  	rebuild_sched_domains_locked();
>  	percpu_up_write(&cpuset_rwsem);
> +	put_online_cpus();
>  }
>  
>  /**
> @@ -2298,6 +2298,7 @@ static int cpuset_write_u64(struct cgroup_subsys_state *css, struct cftype *cft,
>  	cpuset_filetype_t type = cft->private;
>  	int retval = 0;
>  
> +	get_online_cpus();
>  	percpu_down_write(&cpuset_rwsem);
>  	if (!is_cpuset_online(cs)) {
>  		retval = -ENODEV;
> @@ -2335,6 +2336,7 @@ static int cpuset_write_u64(struct cgroup_subsys_state *css, struct cftype *cft,
>  	}
>  out_unlock:
>  	percpu_up_write(&cpuset_rwsem);
> +	put_online_cpus();
>  	return retval;
>  }
>  
> @@ -2345,6 +2347,7 @@ static int cpuset_write_s64(struct cgroup_subsys_state *css, struct cftype *cft,
>  	cpuset_filetype_t type = cft->private;
>  	int retval = -ENODEV;
>  
> +	get_online_cpus();
>  	percpu_down_write(&cpuset_rwsem);
>  	if (!is_cpuset_online(cs))
>  		goto out_unlock;
> @@ -2359,6 +2362,7 @@ static int cpuset_write_s64(struct cgroup_subsys_state *css, struct cftype *cft,
>  	}
>  out_unlock:
>  	percpu_up_write(&cpuset_rwsem);
> +	put_online_cpus();
>  	return retval;
>  }
>  
> @@ -2397,6 +2401,7 @@ static ssize_t cpuset_write_resmask(struct kernfs_open_file *of,
>  	kernfs_break_active_protection(of->kn);
>  	flush_work(&cpuset_hotplug_work);
>  
> +	get_online_cpus();
>  	percpu_down_write(&cpuset_rwsem);
>  	if (!is_cpuset_online(cs))
>  		goto out_unlock;
> @@ -2422,6 +2427,7 @@ static ssize_t cpuset_write_resmask(struct kernfs_open_file *of,
>  	free_cpuset(trialcs);
>  out_unlock:
>  	percpu_up_write(&cpuset_rwsem);
> +	put_online_cpus();
>  	kernfs_unbreak_active_protection(of->kn);
>  	css_put(&cs->css);
>  	flush_workqueue(cpuset_migrate_mm_wq);
> @@ -2552,6 +2558,7 @@ static ssize_t sched_partition_write(struct kernfs_open_file *of, char *buf,
>  		return -EINVAL;
>  
>  	css_get(&cs->css);
> +	get_online_cpus();
>  	percpu_down_write(&cpuset_rwsem);
>  	if (!is_cpuset_online(cs))
>  		goto out_unlock;
> @@ -2559,6 +2566,7 @@ static ssize_t sched_partition_write(struct kernfs_open_file *of, char *buf,
>  	retval = update_prstate(cs, val);
>  out_unlock:
>  	percpu_up_write(&cpuset_rwsem);
> +	put_online_cpus();
>  	css_put(&cs->css);
>  	return retval ?: nbytes;
>  }
> @@ -2764,6 +2772,7 @@ static int cpuset_css_online(struct cgroup_subsys_state *css)
>  	if (!parent)
>  		return 0;
>  
> +	get_online_cpus();
>  	percpu_down_write(&cpuset_rwsem);
>  
>  	set_bit(CS_ONLINE, &cs->flags);
> @@ -2816,6 +2825,7 @@ static int cpuset_css_online(struct cgroup_subsys_state *css)
>  	spin_unlock_irq(&callback_lock);
>  out_unlock:
>  	percpu_up_write(&cpuset_rwsem);
> +	put_online_cpus();
>  	return 0;
>  }
>  
> @@ -2834,6 +2844,7 @@ static void cpuset_css_offline(struct cgroup_subsys_state *css)
>  {
>  	struct cpuset *cs = css_cs(css);
>  
> +	get_online_cpus();
>  	percpu_down_write(&cpuset_rwsem);
>  
>  	if (is_partition_root(cs))
> @@ -2854,6 +2865,7 @@ static void cpuset_css_offline(struct cgroup_subsys_state *css)
>  	clear_bit(CS_ONLINE, &cs->flags);
>  
>  	percpu_up_write(&cpuset_rwsem);
> +	put_online_cpus();
>  }
>  
>  static void cpuset_css_free(struct cgroup_subsys_state *css)
> -- 
> 2.17.2
> 
