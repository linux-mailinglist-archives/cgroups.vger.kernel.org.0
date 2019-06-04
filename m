Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 512B4345FD
	for <lists+cgroups@lfdr.de>; Tue,  4 Jun 2019 13:55:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727610AbfFDLzX (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 4 Jun 2019 07:55:23 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:43728 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727250AbfFDLzX (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 4 Jun 2019 07:55:23 -0400
Received: by mail-qt1-f195.google.com with SMTP id z24so6169323qtj.10
        for <cgroups@vger.kernel.org>; Tue, 04 Jun 2019 04:55:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=h8UiBw5YF7XvZ0Sc1GxQewXB7h1IamgVFTbLK/OqV7s=;
        b=1VcEEnwcedHvdBV5Fz7LJACfGBlBEELnMr9lZCVc2tdNE17MzFVpq3PoO/OYI2CCab
         PbqwkZP2yZWzjc+T0Jzc8PjnxxRFUDS9opGd+STgN30OkQtqfd1ZTwE941ui9q0075y/
         Ps7mcgfZ/aX1FeJv1qcr8noLIEPZnU7n8FX4EcIymK1+Pod5kyZ/NwyceIZD0nfU37O+
         98J6uUSrYWKl6ib4NHpZBkNCay2V1SMDszW/Nn+a3cRNsbmEifBSv9VB70FZ/u4ov2+m
         EkfNnqfCq6StXsNSJ7hTQekxOgZ34KjdyYWuP0EgiVhA6B3nNr7XnM1j8ZPTD+B7tCed
         cfWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=h8UiBw5YF7XvZ0Sc1GxQewXB7h1IamgVFTbLK/OqV7s=;
        b=nT0tMwv3+9T1YDnw5xQkktM2vGVP+qKl2UxagyEsuLz0pYjIvzFaLHrjcPQoeVeyjd
         wdFh7OmV7NYdNVCGn3Wu4RgjNGQWlXzvLDsUiG/WVqAbulDJSh4MT8sccofoCV5E48r7
         fcr7SUtJTdX0j5nqxoKSC/ZAUx9N0z/brGfmYGbVOvPyTuNxsbRSyd809uw5nMRtkgpz
         aDGpheV912DLMVZrzT/WHem0WOix74RyFq6OdVbyzv/NB7s8mpraXK1HruoAF7ByFXjX
         KPadEhlOui7mykRnOfIy9fZPf/HuiAqMP0IBZBGYevSdQWKEdhHh1OQdKmTtpEP3CXLB
         mCug==
X-Gm-Message-State: APjAAAUbGEOB7Bt9/FxvMePnOWAU+Xz6hBkxjpzM1ubnehmt7srHtEfj
        cB+K0VPvJp0w5OLvOFa7q0WdiEpWFvE=
X-Google-Smtp-Source: APXvYqyV1Dm27WU4y+l7+YFidXGLtknNS0wTxBBMR5Oynuq7MZkxquuK4YQ95aMau8OAsZdcxtdeGw==
X-Received: by 2002:a0c:88c3:: with SMTP id 3mr8026706qvo.21.1559649321482;
        Tue, 04 Jun 2019 04:55:21 -0700 (PDT)
Received: from localhost (pool-108-27-252-85.nycmny.fios.verizon.net. [108.27.252.85])
        by smtp.gmail.com with ESMTPSA id 41sm3499015qtp.32.2019.06.04.04.55.20
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 04 Jun 2019 04:55:20 -0700 (PDT)
Date:   Tue, 4 Jun 2019 07:55:19 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Joseph Qi <joseph.qi@linux.alibaba.com>
Cc:     linux-mm@kvack.org, cgroups@vger.kernel.org,
        akpm@linux-foundation.org, Tejun Heo <tj@kernel.org>,
        Jiufei Xue <jiufei.xue@linux.alibaba.com>,
        Caspar Zhang <caspar@linux.alibaba.com>
Subject: Re: [RFC PATCH 2/3] psi: cgroup v1 support
Message-ID: <20190604115519.GA18545@cmpxchg.org>
References: <20190604015745.78972-1-joseph.qi@linux.alibaba.com>
 <20190604015745.78972-3-joseph.qi@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190604015745.78972-3-joseph.qi@linux.alibaba.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue, Jun 04, 2019 at 09:57:44AM +0800, Joseph Qi wrote:
> Implements pressure stall tracking for cgroup v1.
> 
> Signed-off-by: Joseph Qi <joseph.qi@linux.alibaba.com>
> ---
>  kernel/sched/psi.c | 65 +++++++++++++++++++++++++++++++++++++++-------
>  1 file changed, 56 insertions(+), 9 deletions(-)
> 
> diff --git a/kernel/sched/psi.c b/kernel/sched/psi.c
> index 7acc632c3b82..909083c828d5 100644
> --- a/kernel/sched/psi.c
> +++ b/kernel/sched/psi.c
> @@ -719,13 +719,30 @@ static u32 psi_group_change(struct psi_group *group, int cpu,
>  	return state_mask;
>  }
>  
> -static struct psi_group *iterate_groups(struct task_struct *task, void **iter)
> +static struct cgroup *psi_task_cgroup(struct task_struct *task, enum psi_res res)
> +{
> +	switch (res) {
> +	case NR_PSI_RESOURCES:
> +		return task_dfl_cgroup(task);
> +	case PSI_IO:
> +		return task_cgroup(task, io_cgrp_subsys.id);
> +	case PSI_MEM:
> +		return task_cgroup(task, memory_cgrp_subsys.id);
> +	case PSI_CPU:
> +		return task_cgroup(task, cpu_cgrp_subsys.id);
> +	default:  /* won't reach here */
> +		return NULL;
> +	}
> +}
> +
> +static struct psi_group *iterate_groups(struct task_struct *task, void **iter,
> +					enum psi_res res)
>  {
>  #ifdef CONFIG_CGROUPS
>  	struct cgroup *cgroup = NULL;
>  
>  	if (!*iter)
> -		cgroup = task->cgroups->dfl_cgrp;
> +		cgroup = psi_task_cgroup(task, res);
>  	else if (*iter == &psi_system)
>  		return NULL;
>  	else
> @@ -776,15 +793,45 @@ void psi_task_change(struct task_struct *task, int clear, int set)
>  		     wq_worker_last_func(task) == psi_avgs_work))
>  		wake_clock = false;
>  
> -	while ((group = iterate_groups(task, &iter))) {
> -		u32 state_mask = psi_group_change(group, cpu, clear, set);
> +	if (cgroup_subsys_on_dfl(cpu_cgrp_subsys) ||
> +	    cgroup_subsys_on_dfl(memory_cgrp_subsys) ||
> +	    cgroup_subsys_on_dfl(io_cgrp_subsys)) {
> +		while ((group = iterate_groups(task, &iter, NR_PSI_RESOURCES))) {
> +			u32 state_mask = psi_group_change(group, cpu, clear, set);
>  
> -		if (state_mask & group->poll_states)
> -			psi_schedule_poll_work(group, 1);
> +			if (state_mask & group->poll_states)
> +				psi_schedule_poll_work(group, 1);
>  
> -		if (wake_clock && !delayed_work_pending(&group->avgs_work))
> -			schedule_delayed_work(&group->avgs_work, PSI_FREQ);
> +			if (wake_clock && !delayed_work_pending(&group->avgs_work))
> +				schedule_delayed_work(&group->avgs_work, PSI_FREQ);
> +		}
> +	} else {
> +		enum psi_task_count i;
> +		enum psi_res res;
> +		int psi_flags = clear | set;
> +
> +		for (i = NR_IOWAIT; i < NR_PSI_TASK_COUNTS; i++) {
> +			if ((i == NR_IOWAIT) && (psi_flags & TSK_IOWAIT))
> +				res = PSI_IO;
> +			else if ((i == NR_MEMSTALL) && (psi_flags & TSK_MEMSTALL))
> +				res = PSI_MEM;
> +			else if ((i == NR_RUNNING) && (psi_flags & TSK_RUNNING))
> +				res = PSI_CPU;
> +			else
> +				continue;
> +
> +			while ((group = iterate_groups(task, &iter, res))) {
> +				u32 state_mask = psi_group_change(group, cpu, clear, set);

This doesn't work. Each resource state is composed of all possible
task states:

static bool test_state(unsigned int *tasks, enum psi_states state)
{
	switch (state) {
	case PSI_IO_SOME:
		return tasks[NR_IOWAIT];
	case PSI_IO_FULL:
		return tasks[NR_IOWAIT] && !tasks[NR_RUNNING];
	case PSI_MEM_SOME:
		return tasks[NR_MEMSTALL];
	case PSI_MEM_FULL:
		return tasks[NR_MEMSTALL] && !tasks[NR_RUNNING];
	case PSI_CPU_SOME:
		return tasks[NR_RUNNING] > 1;
	case PSI_NONIDLE:
		return tasks[NR_IOWAIT] || tasks[NR_MEMSTALL] ||
			tasks[NR_RUNNING];
	default:
		return false;
	}
}

So the IO controller needs to know of NR_RUNNING to tell some vs full,
the memory controller needs to know of NR_IOWAIT to tell nonidle etc.

You need to run the full psi task tracking and aggregation machinery
separately for each of the different cgroups a task can be in in v1.

Needless to say, that is expensive. For cpu, memory and io, it's
triple the scheduling overhead with three ancestor walks and three
times the cache footprint; three times more aggregation workers every
two seconds... We could never turn this on per default.

Have you considered just co-mounting cgroup2, if for nothing else, to
get the pressure numbers?
