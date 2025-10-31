Return-Path: <cgroups+bounces-11449-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BBE24C22FCF
	for <lists+cgroups@lfdr.de>; Fri, 31 Oct 2025 03:26:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C8FCA406EED
	for <lists+cgroups@lfdr.de>; Fri, 31 Oct 2025 02:25:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 509F527E7EB;
	Fri, 31 Oct 2025 02:25:39 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 632E1279DCE;
	Fri, 31 Oct 2025 02:25:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761877539; cv=none; b=Qgo8PXkZPmVXiga5ILuLfS/71fypPG5+JIwqCO8w/6pBzHUMIqOh7tghRXDVDTJR5ekxpb634eekSistFgcVtVSjYTDeRfQSAo4YzM/r3cO6t5cyB2GfrCl3R/Y/0UVk8+WuI3O7xSxxPl3sLTXcEyC+TOmKOt9Iqv0DuXIa+gA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761877539; c=relaxed/simple;
	bh=FCMDZpo+zPOaucjsv5ocR/PPIqQlRU1b4RGM6RBMBDo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YGQemGSesqkLv6a/vGFKe/ixpq/Q/DB/ZJv3sC78jacoIjVuQ9ml8480pt5FrhaTGtxJD41uSvuU8oQtaDFToy4FFEJuD2K9jMoamUr6f4HHuGzJrSXB3+T8amrCEk3md4KScGpbm2SBjzv1cTYImS35Sz6G94dy+hwCqDOJiQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4cyPv50WnqzKHMLG;
	Fri, 31 Oct 2025 10:24:33 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id 7BEB61A06E0;
	Fri, 31 Oct 2025 10:25:33 +0800 (CST)
Received: from [10.67.111.176] (unknown [10.67.111.176])
	by APP2 (Coremail) with SMTP id Syh0CgA32EAcHgRpbQXDCA--.35193S2;
	Fri, 31 Oct 2025 10:25:33 +0800 (CST)
Message-ID: <bb99364a-3143-4911-9b86-81fe5a11e1eb@huaweicloud.com>
Date: Fri, 31 Oct 2025 10:25:31 +0800
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] cgroup: Rename cgroup lifecycle hooks to
 cgroup_task_*()
To: Tejun Heo <tj@kernel.org>, David Vernet <void@manifault.com>,
 Andrea Righi <arighi@nvidia.com>, Changwoo Min <changwoo@igalia.com>
Cc: Dan Schatzberg <dschatzberg@meta.com>,
 Peter Zijlstra <peterz@infradead.org>, linux-kernel@vger.kernel.org,
 cgroups@vger.kernel.org, sched-ext@lists.linux.dev
References: <20251029061918.4179554-1-tj@kernel.org>
 <20251029061918.4179554-2-tj@kernel.org>
Content-Language: en-US
From: Chen Ridong <chenridong@huaweicloud.com>
In-Reply-To: <20251029061918.4179554-2-tj@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:Syh0CgA32EAcHgRpbQXDCA--.35193S2
X-Coremail-Antispam: 1UD129KBjvJXoW3WFy8Xw18Xr43XrW7KFW5GFg_yoW7KFW3pa
	yDC3WUGw43Ja4jgFn7t3yqvFySgws7W3W5Gryrt3yFyr43tr10qF9rCry7ur4rt3Z2gF1a
	qrsYkr47Kr4Dtr7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUyGb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxkF7I0En4kS14v26r1q6r43MxAIw28IcxkI7VAK
	I48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7
	xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xII
	jxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw2
	0EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x02
	67AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU17KsUUUUUU==
X-CM-SenderInfo: hfkh02xlgr0w46kxt4xhlfz01xgou0bp/



On 2025/10/29 14:19, Tejun Heo wrote:
> The current names cgroup_exit(), cgroup_release(), and cgroup_free() are
> confusing because they look like they're operating on cgroups themselves when
> they're actually task lifecycle hooks. For example, cgroup_init() initializes
> the cgroup subsystem while cgroup_exit() is a task exit notification to
> cgroup. Rename them to cgroup_task_exit(), cgroup_task_release(), and
> cgroup_task_free() to make it clear that these operate on tasks.
> 

This makes sense.

> Cc: Dan Schatzberg <dschatzberg@meta.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Signed-off-by: Tejun Heo <tj@kernel.org>
> ---
>  include/linux/cgroup.h   | 12 ++++++------
>  kernel/cgroup/cgroup.c   | 11 ++++++-----
>  kernel/exit.c            |  4 ++--
>  kernel/fork.c            |  2 +-
>  kernel/sched/autogroup.c |  4 ++--
>  5 files changed, 17 insertions(+), 16 deletions(-)
> 
> diff --git a/include/linux/cgroup.h b/include/linux/cgroup.h
> index 6ed477338b16..4068035176c4 100644
> --- a/include/linux/cgroup.h
> +++ b/include/linux/cgroup.h
> @@ -137,9 +137,9 @@ extern void cgroup_cancel_fork(struct task_struct *p,
>  			       struct kernel_clone_args *kargs);
>  extern void cgroup_post_fork(struct task_struct *p,
>  			     struct kernel_clone_args *kargs);
> -void cgroup_exit(struct task_struct *p);
> -void cgroup_release(struct task_struct *p);
> -void cgroup_free(struct task_struct *p);
> +void cgroup_task_exit(struct task_struct *p);
> +void cgroup_task_release(struct task_struct *p);
> +void cgroup_task_free(struct task_struct *p);
>  
>  int cgroup_init_early(void);
>  int cgroup_init(void);
> @@ -680,9 +680,9 @@ static inline void cgroup_cancel_fork(struct task_struct *p,
>  				      struct kernel_clone_args *kargs) {}
>  static inline void cgroup_post_fork(struct task_struct *p,
>  				    struct kernel_clone_args *kargs) {}
> -static inline void cgroup_exit(struct task_struct *p) {}
> -static inline void cgroup_release(struct task_struct *p) {}
> -static inline void cgroup_free(struct task_struct *p) {}
> +static inline void cgroup_task_exit(struct task_struct *p) {}
> +static inline void cgroup_task_release(struct task_struct *p) {}
> +static inline void cgroup_task_free(struct task_struct *p) {}
>  
>  static inline int cgroup_init_early(void) { return 0; }
>  static inline int cgroup_init(void) { return 0; }
> diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
> index 6ae5f48cf64e..826b7fd2f85d 100644
> --- a/kernel/cgroup/cgroup.c
> +++ b/kernel/cgroup/cgroup.c
> @@ -944,7 +944,8 @@ static void css_set_move_task(struct task_struct *task,
>  		/*
>  		 * We are synchronized through cgroup_threadgroup_rwsem
>  		 * against PF_EXITING setting such that we can't race
> -		 * against cgroup_exit()/cgroup_free() dropping the css_set.
> +		 * against cgroup_task_exit()/cgroup_task_free() dropping
> +		 * the css_set.
>  		 */
>  		WARN_ON_ONCE(task->flags & PF_EXITING);
>  
> @@ -6972,13 +6973,13 @@ void cgroup_post_fork(struct task_struct *child,
>  }
>  
>  /**
> - * cgroup_exit - detach cgroup from exiting task
> + * cgroup_task_exit - detach cgroup from exiting task
>   * @tsk: pointer to task_struct of exiting process
>   *
>   * Description: Detach cgroup from @tsk.
>   *
>   */
> -void cgroup_exit(struct task_struct *tsk)
> +void cgroup_task_exit(struct task_struct *tsk)
>  {
>  	struct cgroup_subsys *ss;
>  	struct css_set *cset;
> @@ -7010,7 +7011,7 @@ void cgroup_exit(struct task_struct *tsk)
>  	} while_each_subsys_mask();
>  }
>  
> -void cgroup_release(struct task_struct *task)
> +void cgroup_task_release(struct task_struct *task)
>  {
>  	struct cgroup_subsys *ss;
>  	int ssid;
> @@ -7027,7 +7028,7 @@ void cgroup_release(struct task_struct *task)
>  	}
>  }
>  
> -void cgroup_free(struct task_struct *task)
> +void cgroup_task_free(struct task_struct *task)
>  {
>  	struct css_set *cset = task_css_set(task);
>  	put_css_set(cset);
> diff --git a/kernel/exit.c b/kernel/exit.c
> index 9f74e8f1c431..46173461e8de 100644
> --- a/kernel/exit.c
> +++ b/kernel/exit.c
> @@ -257,7 +257,7 @@ void release_task(struct task_struct *p)
>  	rcu_read_unlock();
>  
>  	pidfs_exit(p);
> -	cgroup_release(p);
> +	cgroup_task_release(p);
>  
>  	/* Retrieve @thread_pid before __unhash_process() may set it to NULL. */
>  	thread_pid = task_pid(p);
> @@ -967,7 +967,7 @@ void __noreturn do_exit(long code)
>  	exit_thread(tsk);
>  
>  	sched_autogroup_exit_task(tsk);
> -	cgroup_exit(tsk);
> +	cgroup_task_exit(tsk);
>  
>  	/*
>  	 * FIXME: do that only when needed, using sched_exit tracepoint
> diff --git a/kernel/fork.c b/kernel/fork.c
> index 3da0f08615a9..960c39c9c264 100644
> --- a/kernel/fork.c
> +++ b/kernel/fork.c
> @@ -738,7 +738,7 @@ void __put_task_struct(struct task_struct *tsk)
>  	unwind_task_free(tsk);
>  	sched_ext_free(tsk);
>  	io_uring_free(tsk);
> -	cgroup_free(tsk);
> +	cgroup_task_free(tsk);
>  	task_numa_free(tsk, true);
>  	security_task_free(tsk);
>  	exit_creds(tsk);
> diff --git a/kernel/sched/autogroup.c b/kernel/sched/autogroup.c
> index cdea931aae30..954137775f38 100644
> --- a/kernel/sched/autogroup.c
> +++ b/kernel/sched/autogroup.c
> @@ -178,8 +178,8 @@ autogroup_move_group(struct task_struct *p, struct autogroup *ag)
>  	 * this process can already run with task_group() == prev->tg or we can
>  	 * race with cgroup code which can read autogroup = prev under rq->lock.
>  	 * In the latter case for_each_thread() can not miss a migrating thread,
> -	 * cpu_cgroup_attach() must not be possible after cgroup_exit() and it
> -	 * can't be removed from thread list, we hold ->siglock.
> +	 * cpu_cgroup_attach() must not be possible after cgroup_task_exit()
> +	 * and it can't be removed from thread list, we hold ->siglock.
>  	 *
>  	 * If an exiting thread was already removed from thread list we rely on
>  	 * sched_autogroup_exit_task().

Reviewed-by: Chen Ridong<chenridong@huawei.com>

-- 
Best regards,
Ridong


