Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 73E3D355341
	for <lists+cgroups@lfdr.de>; Tue,  6 Apr 2021 14:10:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241728AbhDFMK4 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 6 Apr 2021 08:10:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343783AbhDFMKz (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 6 Apr 2021 08:10:55 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 263ABC06174A
        for <cgroups@vger.kernel.org>; Tue,  6 Apr 2021 05:10:47 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id j4-20020a05600c4104b029010c62bc1e20so7188777wmi.3
        for <cgroups@vger.kernel.org>; Tue, 06 Apr 2021 05:10:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=3UA2QLgE5D0ijsyIx8P+uuJ+qKQ15FjapR/N/wkS3FM=;
        b=HF72u0MOJvcyb2iO031+3c68hjNTeovFQNLtmtnt5xqUF1rnl9HuJPHYt5suzoXNS0
         XGZaD4/jxQsphiOqCQ7iwY+xVYPkdS/lkbMeDHiHVVsO2ZhBbaxKz/R9tJcLJVw5qyKg
         wH8RjFs6SbFvit+GIlaly8tMXLlJxWDnkFGCOo1q9cvbp0r9VqQzi3KqtUC3Bzf4Hp+9
         7rCvU/b58AauosJJ+qvqsWEZBDrc1Rk7er7tyPgLkisjbxAqgRi6V4Xn54K4K5lpuQtr
         dkJWd0eWbKIhUf7hs+Ch4z2XyTMWUK86+nbI/TqALTF24exGJ9lnQmaju2WAqmH0rAof
         qZ8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=3UA2QLgE5D0ijsyIx8P+uuJ+qKQ15FjapR/N/wkS3FM=;
        b=k//IQ/4ulh1q/Y9DzoThZNA8osqW2dplrdKEupF/XAYSfaXP/G3KwqbBxpOIizGTUy
         RPp0B+PppitL8xd9PLU9r8nJbt+ofIiml+13d+UKKwyOqK0ghCvPJxhsbVCYbeVm/wcX
         lnVAwnNOP6IUHbzn7/10EyXrb/mM1mSseMsiRivAEhaplhPbHQtx69R56NsjgwnElZTe
         rhcboEMVdFd91bj1MXHyvE3QNAi1yi508+R2fsmvnKQs6UsAgiJ51QQvYMVDzho3HlYo
         /Bagrm0JBJFNRMFtBT8ZWLTpVRF1SAGX1rxTr2lNgMYV9nBohq1Nktdj6wUUZ3AlkYIF
         ghyQ==
X-Gm-Message-State: AOAM530bZOqffejG7kmNl1eEncUcNidD6Q8lqJwkP73cdcVztiUm6lwv
        cci4qDOtEBJvq0XcWtW9jFKF0A==
X-Google-Smtp-Source: ABdhPJzTDA96h3UTvSc08nJvxf+2FUxmGNfRVsGh4JOeRkBHchLzJzk+DTg4qwBPAvA37oQ9pq297Q==
X-Received: by 2002:a1c:c918:: with SMTP id f24mr3980300wmb.12.1617711044267;
        Tue, 06 Apr 2021 05:10:44 -0700 (PDT)
Received: from google.com (105.168.195.35.bc.googleusercontent.com. [35.195.168.105])
        by smtp.gmail.com with ESMTPSA id s21sm2641882wmc.10.2021.04.06.05.10.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Apr 2021 05:10:43 -0700 (PDT)
Date:   Tue, 6 Apr 2021 12:10:41 +0000
From:   Quentin Perret <qperret@google.com>
To:     Pavankumar Kondeti <pkondeti@codeaurora.org>
Cc:     linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>, Wei Wang <wvw@google.com>
Subject: Re: [PATCH] cgroup: Relax restrictions on kernel threads moving out
 of root cpu cgroup
Message-ID: <YGxPwTVvpqYkkIMI@google.com>
References: <1617706753-25349-1-git-send-email-pkondeti@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1617706753-25349-1-git-send-email-pkondeti@codeaurora.org>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hi Pavan,

On Tuesday 06 Apr 2021 at 16:29:13 (+0530), Pavankumar Kondeti wrote:
> In Android GKI, CONFIG_FAIR_GROUP_SCHED is enabled [1] to help prioritize
> important work. Given that CPU shares of root cgroup can't be changed,
> leaving the tasks inside root cgroup will give them higher share
> compared to the other tasks inside important cgroups. This is mitigated
> by moving all tasks inside root cgroup to a different cgroup after
> Android is booted. However, there are many kernel tasks stuck in the
> root cgroup after the boot.
> 
> We see all kworker threads are in the root cpu cgroup. This is because,
> tasks with PF_NO_SETAFFINITY flag set are forbidden from cgroup migration.
> This restriction is in place to avoid kworkers getting moved to a cpuset
> which conflicts with kworker affinity. Relax this restriction by explicitly
> checking if the task is moving out of a cpuset cgroup. This allows kworkers
> to be moved out root cpu cgroup.
> 
> We also see kthreadd_task and any kernel thread created after the Android boot
> also stuck in the root cgroup. The current code prevents kthreadd_task moving
> out root cgroup to avoid the possibility of creating new RT kernel threads
> inside a cgroup with no RT runtime allocated. Apply this restriction when tasks
> are moving out of cpu cgroup under CONFIG_RT_GROUP_SCHED. This allows all
> kernel threads to be moved out of root cpu cgroup if the kernel does not
> enable RT group scheduling.

OK, so IIUC this only works with cgroup v1 -- the unified hierarchy in
v2 forces you to keep cpu and cpuset in 'sync'. But that should be fine,
so this looks like a nice improvement to me.

> [1] https://android.googlesource.com/kernel/common/+/f08f049de11c15a4251cb1db08cf0bee20bd9b59
> 
> Signed-off-by: Pavankumar Kondeti <pkondeti@codeaurora.org>
> ---
>  kernel/cgroup/cgroup-internal.h |  3 ++-
>  kernel/cgroup/cgroup-v1.c       |  2 +-
>  kernel/cgroup/cgroup.c          | 24 +++++++++++++++++++-----
>  3 files changed, 22 insertions(+), 7 deletions(-)
> 
> diff --git a/kernel/cgroup/cgroup-internal.h b/kernel/cgroup/cgroup-internal.h
> index bfbeabc..a96ed9a 100644
> --- a/kernel/cgroup/cgroup-internal.h
> +++ b/kernel/cgroup/cgroup-internal.h
> @@ -232,7 +232,8 @@ int cgroup_migrate(struct task_struct *leader, bool threadgroup,
>  int cgroup_attach_task(struct cgroup *dst_cgrp, struct task_struct *leader,
>  		       bool threadgroup);
>  struct task_struct *cgroup_procs_write_start(char *buf, bool threadgroup,
> -					     bool *locked)
> +					     bool *locked,
> +					     struct cgroup *dst_cgrp)
>  	__acquires(&cgroup_threadgroup_rwsem);
>  void cgroup_procs_write_finish(struct task_struct *task, bool locked)
>  	__releases(&cgroup_threadgroup_rwsem);
> diff --git a/kernel/cgroup/cgroup-v1.c b/kernel/cgroup/cgroup-v1.c
> index a575178..d674a6c 100644
> --- a/kernel/cgroup/cgroup-v1.c
> +++ b/kernel/cgroup/cgroup-v1.c
> @@ -497,7 +497,7 @@ static ssize_t __cgroup1_procs_write(struct kernfs_open_file *of,
>  	if (!cgrp)
>  		return -ENODEV;
>  
> -	task = cgroup_procs_write_start(buf, threadgroup, &locked);
> +	task = cgroup_procs_write_start(buf, threadgroup, &locked, cgrp);
>  	ret = PTR_ERR_OR_ZERO(task);
>  	if (ret)
>  		goto out_unlock;
> diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
> index 9153b20..41864a8 100644
> --- a/kernel/cgroup/cgroup.c
> +++ b/kernel/cgroup/cgroup.c
> @@ -2744,7 +2744,8 @@ int cgroup_attach_task(struct cgroup *dst_cgrp, struct task_struct *leader,
>  }
>  
>  struct task_struct *cgroup_procs_write_start(char *buf, bool threadgroup,
> -					     bool *locked)
> +					     bool *locked,
> +					     struct cgroup *dst_cgrp)
>  	__acquires(&cgroup_threadgroup_rwsem)
>  {
>  	struct task_struct *tsk;
> @@ -2784,15 +2785,28 @@ struct task_struct *cgroup_procs_write_start(char *buf, bool threadgroup,
>  		tsk = tsk->group_leader;
>  
>  	/*
> +	 * RT kthreads may be born in a cgroup with no rt_runtime allocated.
> +	 * Just say no.
> +	 */
> +#ifdef CONFIG_RT_GROUP_SCHED
> +	if (tsk->no_cgroup_migration && (dst_cgrp->root->subsys_mask & (1U << cpu_cgrp_id))) {
> +		tsk = ERR_PTR(-EINVAL);
> +		goto out_unlock_threadgroup;
> +	}
> +#endif
> +
> +	/*
>  	 * kthreads may acquire PF_NO_SETAFFINITY during initialization.
>  	 * If userland migrates such a kthread to a non-root cgroup, it can
> -	 * become trapped in a cpuset, or RT kthread may be born in a
> -	 * cgroup with no rt_runtime allocated.  Just say no.
> +	 * become trapped in a cpuset. Just say no.
>  	 */
> -	if (tsk->no_cgroup_migration || (tsk->flags & PF_NO_SETAFFINITY)) {
> +#ifdef CONFIG_CPUSETS
> +	if ((tsk->no_cgroup_migration || (tsk->flags & PF_NO_SETAFFINITY)) &&
> +			(dst_cgrp->root->subsys_mask & (1U << cpuset_cgrp_id))) {
>  		tsk = ERR_PTR(-EINVAL);
>  		goto out_unlock_threadgroup;
>  	}
> +#endif

Nit: maybe move this #ifdefery out to a header?

Thanks,
Quentin
