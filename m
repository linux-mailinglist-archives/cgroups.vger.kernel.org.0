Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4E4F6D6556
	for <lists+cgroups@lfdr.de>; Tue,  4 Apr 2023 16:31:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233968AbjDDObR (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 4 Apr 2023 10:31:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234723AbjDDObR (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 4 Apr 2023 10:31:17 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64585E75;
        Tue,  4 Apr 2023 07:31:15 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 199F120676;
        Tue,  4 Apr 2023 14:31:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1680618674; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=5lkgsKF9buBugrMdUK7Gx/f9nw3TdJxXdyQ3Vtpni/8=;
        b=oECM6QZI2l8k0Cat0iLrKabTx6UDrsw0FHGLSivUEm2Ls1/617xgC/Eq5yO2MvFOli/73k
        xtjo/a2U0oUtad7J7+f9f2kjSvGkafMfx5quyNT1/oXjy4xYgxHYrB/0/RiXdxAv//Y9ML
        H+C7NRgGqLlGen8n7jeAiJcpuvEdlOY=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 09B3A1391A;
        Tue,  4 Apr 2023 14:31:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id vCSzAbI0LGQhZwAAMHmgww
        (envelope-from <mhocko@suse.com>); Tue, 04 Apr 2023 14:31:14 +0000
Date:   Tue, 4 Apr 2023 16:31:13 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Gang Li <ligang.bdlg@bytedance.com>
Cc:     rientjes@google.com, linux-kernel@vger.kernel.org,
        Waiman Long <longman@redhat.com>,
        Zefan Li <lizefan.x@bytedance.com>, cgroups@vger.kernel.org
Subject: Re: [PATCH v2] mm: oom: introduce cpuset oom
Message-ID: <ZCw0sR6IqYa5Es7Q@dhcp22.suse.cz>
References: <20230404115509.14299-1-ligang.bdlg@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230404115509.14299-1-ligang.bdlg@bytedance.com>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

[CC cpuset people]

On Tue 04-04-23 19:55:09, Gang Li wrote:
> When a process in cpuset triggers oom, it may kill a completely
> irrelevant process on another numa node, which will not release any
> memory for this cpuset.
> 
> It seems that `CONSTRAINT_CPUSET` is not really doing much these
> days. Using CONSTRAINT_CPUSET, we can easily achieve node aware oom
> by selecting victim from all cpusets with the same mems_allowed as
> the current cpuset.

This should go into more details about the usecase, testing and ideally
also spend couple of words about how CONSTRAINT_CPUSET is actually
implemented because this is not really immediately obvious. An example
of before/after behavior would have been really nice as well.

You should also go into much more details about how oom victims are
actually evaluated.

> Suggested-by: Michal Hocko <mhocko@suse.com>
> Signed-off-by: Gang Li <ligang.bdlg@bytedance.com>
> ---
> Changes in v2:
> - Select victim from all cpusets with the same mems_allowed as the current cpuset.
>   (David Rientjes <rientjes@google.com>)
> 
> v1:
> - https://lore.kernel.org/all/20220921064710.89663-1-ligang.bdlg@bytedance.com/
> 
> ---
>  include/linux/cpuset.h |  6 ++++++
>  kernel/cgroup/cpuset.c | 28 ++++++++++++++++++++++++++++
>  mm/oom_kill.c          |  4 ++++
>  3 files changed, 38 insertions(+)

As this is a userspace visible change it should also be documented
somewhere  in Documentation.

I am not really familiar with cpusets internals so I cannot really judge
cpuset_cgroup_scan_tasks implementation.

The oom report should be explicit about this being CPUSET specific oom
handling so unexpected behavior could be nailed down to this change so I
do not see a major concern from the oom POV. Nevertheless it would be
still good to consider whether this should be an opt-in behavior. I
personally do not see a major problem because most cpuset deployments I
have seen tend to be well partitioned so the new behavior makes more
sense. 

> diff --git a/include/linux/cpuset.h b/include/linux/cpuset.h
> index 980b76a1237e..fc244141bd52 100644
> --- a/include/linux/cpuset.h
> +++ b/include/linux/cpuset.h
> @@ -171,6 +171,8 @@ static inline void set_mems_allowed(nodemask_t nodemask)
>  	task_unlock(current);
>  }
>  
> +int cpuset_cgroup_scan_tasks(int (*fn)(struct task_struct *, void *), void *arg);
> +
>  #else /* !CONFIG_CPUSETS */
>  
>  static inline bool cpusets_enabled(void) { return false; }
> @@ -287,6 +289,10 @@ static inline bool read_mems_allowed_retry(unsigned int seq)
>  	return false;
>  }
>  
> +static inline int cpuset_cgroup_scan_tasks(int (*fn)(struct task_struct *, void *), void *arg)
> +{
> +	return 0;
> +}
>  #endif /* !CONFIG_CPUSETS */
>  
>  #endif /* _LINUX_CPUSET_H */
> diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
> index bc4dcfd7bee5..b009c98ca19e 100644
> --- a/kernel/cgroup/cpuset.c
> +++ b/kernel/cgroup/cpuset.c
> @@ -4013,6 +4013,34 @@ void cpuset_print_current_mems_allowed(void)
>  	rcu_read_unlock();
>  }
>  
> +int cpuset_cgroup_scan_tasks(int (*fn)(struct task_struct *, void *), void *arg)
> +{
> +	int ret = 0;
> +	struct css_task_iter it;
> +	struct task_struct *task;
> +	struct cpuset *cs;
> +	struct cgroup_subsys_state *pos_css;
> +
> +	/*
> +	 * Situation gets complex with overlapping nodemasks in different cpusets.
> +	 * TODO: Maybe we should calculate the "distance" between different mems_allowed.
> +	 *
> +	 * But for now, let's make it simple. Just iterate through all cpusets
> +	 * with the same mems_allowed as the current cpuset.
> +	 */
> +	rcu_read_lock();
> +	cpuset_for_each_descendant_pre(cs, pos_css, &top_cpuset) {
> +		if (nodes_equal(cs->mems_allowed, task_cs(current)->mems_allowed)) {
> +			css_task_iter_start(&(cs->css), CSS_TASK_ITER_PROCS, &it);
> +			while (!ret && (task = css_task_iter_next(&it)))
> +				ret = fn(task, arg);
> +			css_task_iter_end(&it);
> +		}
> +	}
> +	rcu_read_unlock();
> +	return ret;
> +}
> +
>  /*
>   * Collection of memory_pressure is suppressed unless
>   * this flag is enabled by writing "1" to the special
> diff --git a/mm/oom_kill.c b/mm/oom_kill.c
> index 044e1eed720e..205982a69b30 100644
> --- a/mm/oom_kill.c
> +++ b/mm/oom_kill.c
> @@ -367,6 +367,8 @@ static void select_bad_process(struct oom_control *oc)
>  
>  	if (is_memcg_oom(oc))
>  		mem_cgroup_scan_tasks(oc->memcg, oom_evaluate_task, oc);
> +	else if (oc->constraint == CONSTRAINT_CPUSET)
> +		cpuset_cgroup_scan_tasks(oom_evaluate_task, oc);
>  	else {
>  		struct task_struct *p;
>  
> @@ -427,6 +429,8 @@ static void dump_tasks(struct oom_control *oc)
>  
>  	if (is_memcg_oom(oc))
>  		mem_cgroup_scan_tasks(oc->memcg, dump_task, oc);
> +	else if (oc->constraint == CONSTRAINT_CPUSET)
> +		cpuset_cgroup_scan_tasks(dump_task, oc);
>  	else {
>  		struct task_struct *p;
>  
> -- 
> 2.20.1

-- 
Michal Hocko
SUSE Labs
