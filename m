Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC16B5E6B9B
	for <lists+cgroups@lfdr.de>; Thu, 22 Sep 2022 21:18:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230472AbiIVTSJ (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 22 Sep 2022 15:18:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229578AbiIVTSH (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 22 Sep 2022 15:18:07 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2E51106A1F
        for <cgroups@vger.kernel.org>; Thu, 22 Sep 2022 12:18:06 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id fv3so10833911pjb.0
        for <cgroups@vger.kernel.org>; Thu, 22 Sep 2022 12:18:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date;
        bh=6I54Hmibv9NNEON21MI/khC1j473zoH5sNcGiz/IqMA=;
        b=jUjTeh5wzF9Ni5HL8rTLkQmxNzQ3yiyS8+wNt2SvUGZ7nGR9TOlyMyCEWezk93KVou
         ou2QevkOksC6VOZRj8jeW+2+DYXWx2J6QAZhW+ATh67Uxw4MyS9azJq4UHyOMKdiQtRL
         KOAB4SghBAL72PCXfYFb8JlkczkehRvHXlchTMaaeJ+yZ6C/nefzrjZXIzptjNLOJQUN
         LwbiXyZgpUtQmTa6axgSgPmAp9DYre7MlUt66vZXtKwxzpLoXuY8BeG6QuthtCJzEUzX
         52/bqPUPaJgJ4wazvClsHtrdj6IHUINvjXnc3KpprM7N+v1MNUlksFtyf7vOwH+qASqZ
         PEJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date;
        bh=6I54Hmibv9NNEON21MI/khC1j473zoH5sNcGiz/IqMA=;
        b=gSwW7hWHahl6ReZFZeAl2SVR1Y6xTYD5YSp0r+oD2eB7+4OmCAg6vf+DMoJhOydEGy
         +LN/luc1BZn4epO5+voqi+7YdAUJJdo/rXkZIt4MEWuU9f7qXG2hlnNBAbpBeUiSQ+Yh
         JPYgLiAjpplriEi/qALtXRRSH9bijngsW7Fb4MDIDP9gOHxaL5OceZevmm1PRT3TAUQR
         IuuXY7yaKxn/oneoyxujM1cM6ljggl86T8g+UIT/qprt7NEcO/zzoXyCsSRPNV4NC8WM
         Zcx6u5dSHssRAKmSpCyt3FQ828BbdR+7QQo9GI8/RSwrBh9xOzKczOQNh5HXg1Vhna8U
         uc1g==
X-Gm-Message-State: ACrzQf1OHn6F9TM+Bt/Gi4pBRZRmL6MN6qXfotU6jzG6yl/Z9VwQipbv
        dm/ZASa1HwLV3HZUwA9P+EPhm9QE+NBpFA==
X-Google-Smtp-Source: AMsMyM489NoZHSzA5ZWkq2GQjXZlU0u91w/tPVdZgrkMTT1zpV5yRKNyvag9xLDJ7g9apnER9eiEVg==
X-Received: by 2002:a17:90a:ab91:b0:202:a520:56c9 with SMTP id n17-20020a17090aab9100b00202a52056c9mr17319196pjq.1.1663874285912;
        Thu, 22 Sep 2022 12:18:05 -0700 (PDT)
Received: from [2620:15c:29:203:63de:fb65:f8a7:416b] ([2620:15c:29:203:63de:fb65:f8a7:416b])
        by smtp.gmail.com with ESMTPSA id a8-20020a170902900800b00178acc7ef16sm4459509plp.253.2022.09.22.12.18.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Sep 2022 12:18:04 -0700 (PDT)
Date:   Thu, 22 Sep 2022 12:18:04 -0700 (PDT)
From:   David Rientjes <rientjes@google.com>
To:     Gang Li <ligang.bdlg@bytedance.com>
cc:     Zefan Li <lizefan.x@bytedance.com>, Tejun Heo <tj@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [RFC PATCH v1] mm: oom: introduce cpuset oom
In-Reply-To: <20220921064710.89663-1-ligang.bdlg@bytedance.com>
Message-ID: <18621b07-256b-7da1-885a-c96dfc8244b6@google.com>
References: <20220921064710.89663-1-ligang.bdlg@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed, 21 Sep 2022, Gang Li wrote:

> cpuset confine processes to processor and memory node subsets.
> When a process in cpuset triggers oom, it may kill a completely
> irrelevant process on another numa node, which will not release any
> memory for this cpuset.
> 
> It seems that `CONSTRAINT_CPUSET` is not really doing much these
> days. Using CONSTRAINT_CPUSET, we can easily achieve node aware oom
> killing by selecting victim from the cpuset which triggers oom.
> 
> Suggested-by: Michal Hocko <mhocko@suse.com>
> Signed-off-by: Gang Li <ligang.bdlg@bytedance.com>

Hmm, is this the right approach?

If a cpuset results in a oom condition, is there a reason why we'd need to 
find a process from within that cpuset to kill?  I think the idea is to 
free memory on the oom set of nodes (cpuset.mems) and that can happen by 
killing a process that is not a member of this cpuset.

I understand the challenges of creating a NUMA aware oom killer to target 
memory that is actually resident on an oom node, but this approach doesn't 
seem right and could actually lead to pathological cases where a small 
process trying to fork in an otherwise empty cpuset is repeatedly oom 
killing when we'd actually prefer to kill a single large process.

> ---
> This idea comes from a previous patch:
> mm, oom: Introduce per numa node oom for CONSTRAINT_MEMORY_POLICY
> https://lore.kernel.org/all/YoJ%2FioXwGTdCywUE@dhcp22.suse.cz/
> 
> Any comments are welcome.
> ---
>  include/linux/cpuset.h |  6 ++++++
>  kernel/cgroup/cpuset.c | 17 +++++++++++++++++
>  mm/oom_kill.c          |  4 ++++
>  3 files changed, 27 insertions(+)
> 
> diff --git a/include/linux/cpuset.h b/include/linux/cpuset.h
> index d58e0476ee8e..7475f613ab90 100644
> --- a/include/linux/cpuset.h
> +++ b/include/linux/cpuset.h
> @@ -178,6 +178,8 @@ static inline void set_mems_allowed(nodemask_t nodemask)
>  	task_unlock(current);
>  }
>  
> +int cpuset_cgroup_scan_tasks(int (*fn)(struct task_struct *, void *), void *arg);
> +
>  #else /* !CONFIG_CPUSETS */
>  
>  static inline bool cpusets_enabled(void) { return false; }
> @@ -299,6 +301,10 @@ static inline bool read_mems_allowed_retry(unsigned int seq)
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
> index b474289c15b8..1f1238b4276d 100644
> --- a/kernel/cgroup/cpuset.c
> +++ b/kernel/cgroup/cpuset.c
> @@ -3943,6 +3943,23 @@ void cpuset_print_current_mems_allowed(void)
>  	rcu_read_unlock();
>  }
>  
> +int cpuset_cgroup_scan_tasks(int (*fn)(struct task_struct *, void *), void *arg)
> +{
> +	int ret = 0;
> +	struct cgroup *cgrp;
> +	struct css_task_iter it;
> +	struct task_struct *task;
> +
> +	rcu_read_lock();
> +	css_task_iter_start(&(task_cs(current)->css), CSS_TASK_ITER_PROCS, &it);
> +	while (!ret && (task = css_task_iter_next(&it)))
> +		ret = fn(task, arg);
> +	css_task_iter_end(&it);
> +	rcu_read_unlock();
> +
> +	return ret;
> +}
> +
>  /*
>   * Collection of memory_pressure is suppressed unless
>   * this flag is enabled by writing "1" to the special
> diff --git a/mm/oom_kill.c b/mm/oom_kill.c
> index 46e7e073f137..8cea787b359c 100644
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
> 
> 
> 
