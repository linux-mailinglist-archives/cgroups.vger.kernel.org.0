Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D347374801
	for <lists+cgroups@lfdr.de>; Wed,  5 May 2021 20:31:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234165AbhEEScQ (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 5 May 2021 14:32:16 -0400
Received: from out02.mta.xmission.com ([166.70.13.232]:39500 "EHLO
        out02.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229810AbhEEScQ (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 5 May 2021 14:32:16 -0400
Received: from in01.mta.xmission.com ([166.70.13.51])
        by out02.mta.xmission.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1leMIm-003bbP-RS; Wed, 05 May 2021 12:31:16 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=fess.xmission.com)
        by in01.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1leMIi-0001Cy-Ub; Wed, 05 May 2021 12:31:16 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Christian Brauner <brauner@kernel.org>
Cc:     Tejun Heo <tj@kernel.org>, Roman Gushchin <guro@fb.com>,
        Shakeel Butt <shakeelb@google.com>,
        Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>, cgroups@vger.kernel.org,
        containers@lists.linux.dev,
        Christian Brauner <christian.brauner@ubuntu.com>
References: <20210503143922.3093755-1-brauner@kernel.org>
Date:   Wed, 05 May 2021 13:31:09 -0500
In-Reply-To: <20210503143922.3093755-1-brauner@kernel.org> (Christian
        Brauner's message of "Mon, 3 May 2021 16:39:19 +0200")
Message-ID: <m1v97x6niq.fsf@fess.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1leMIi-0001Cy-Ub;;;mid=<m1v97x6niq.fsf@fess.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1/Or5kLC32wk1fF4X6okVbsarIIqCdduSo=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa03.xmission.com
X-Spam-Level: *
X-Spam-Status: No, score=1.8 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,T_TM2_M_HEADER_IN_MSG,T_TooManySym_01,
        XM_B_SpammyWords,XM_B_SpammyWords2,XM_Body_Dirty_Words
        autolearn=disabled version=3.4.2
X-Spam-Virus: No
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa03 1397; Body=1 Fuz1=1 Fuz2=1]
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
        *  1.0 XM_Body_Dirty_Words Contains a dirty word
        *  0.8 XM_B_SpammyWords2 Two or more commony used spammy words
        *  0.2 XM_B_SpammyWords One or more commonly used spammy words
X-Spam-DCC: XMission; sa03 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: *;Christian Brauner <brauner@kernel.org>
X-Spam-Relay-Country: 
X-Spam-Timing: total 2717 ms - load_scoreonly_sql: 0.03 (0.0%),
        signal_user_changed: 3.6 (0.1%), b_tie_ro: 2.5 (0.1%), parse: 1.58
        (0.1%), extract_message_metadata: 23 (0.8%), get_uri_detail_list: 8
        (0.3%), tests_pri_-1000: 7 (0.3%), tests_pri_-950: 1.35 (0.0%),
        tests_pri_-900: 1.11 (0.0%), tests_pri_-90: 940 (34.6%), check_bayes:
        922 (33.9%), b_tokenize: 26 (1.0%), b_tok_get_all: 17 (0.6%),
        b_comp_prob: 4.9 (0.2%), b_tok_touch_all: 870 (32.0%), b_finish: 0.97
        (0.0%), tests_pri_0: 1724 (63.5%), check_dkim_signature: 0.51 (0.0%),
        check_dkim_adsp: 2.4 (0.1%), poll_dns_idle: 1.02 (0.0%), tests_pri_10:
        2.6 (0.1%), tests_pri_500: 8 (0.3%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH v2 1/5] cgroup: introduce cgroup.kill
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org


Please see below this patch uses the wrong function to send SIGKILL.

Eric


Christian Brauner <brauner@kernel.org> writes:

> From: Christian Brauner <christian.brauner@ubuntu.com>
>
> Introduce the cgroup.kill file. It does what it says on the tin and
> allows a caller to kill a cgroup by writing "1" into cgroup.kill.
> The file is available in non-root cgroups.
>
> Killing cgroups is a process directed operation, i.e. the whole
> thread-group is affected. Consequently trying to write to cgroup.kill in
> threaded cgroups will be rejected and EOPNOTSUPP returned. This behavior
> aligns with cgroup.procs where reads in threaded-cgroups are rejected
> with EOPNOTSUPP.
>
> The cgroup.kill file is write-only since killing a cgroup is an event
> not which makes it different from e.g. freezer where a cgroup
> transitions between the two states.
>
> As with all new cgroup features cgroup.kill is recursive by default.
>
> Killing a cgroup is protected against concurrent migrations through the
> cgroup mutex. To protect against forkbombs and to mitigate the effect of
> racing forks a new CGRP_KILL css set lock protected flag is introduced
> that is set prior to killing a cgroup and unset after the cgroup has
> been killed. We can then check in cgroup_post_fork() where we hold the
> css set lock already whether the cgroup is currently being killed. If so
> we send the child a SIGKILL signal immediately taking it down as soon as
> it returns to userspace. To make the killing of the child semantically
> clean it is killed after all cgroup attachment operations have been
> finalized.
>
> There are various use-cases of this interface:
> - Containers usually have a conservative layout where each container
>   usually has a delegated cgroup. For such layouts there is a 1:1
>   mapping between container and cgroup. If the container in addition
>   uses a separate pid namespace then killing a container usually becomes
>   a simple kill -9 <container-init-pid> from an ancestor pid namespace.
>   However, there are quite a few scenarios where that isn't true. For
>   example, there are containers that share the cgroup with other
>   processes on purpose that are supposed to be bound to the lifetime of
>   the container but are not in the same pidns of the container.
>   Containers that are in a delegated cgroup but share the pid namespace
>   with the host or other containers.
> - Service managers such as systemd use cgroups to group and organize
>   processes belonging to a service. They usually rely on a recursive
>   algorithm now to kill a service. With cgroup.kill this becomes a
>   simple write to cgroup.kill.
> - Userspace OOM implementations can make good use of this feature to
>   efficiently take down whole cgroups quickly.
> - The kill program can gain a new
>   kill --cgroup /sys/fs/cgroup/delegated
>   flag to take down cgroups.
>
> A few observations about the semantics:
> - If parent and child are in the same cgroup and CLONE_INTO_CGROUP is
>   not specified we are not taking cgroup mutex meaning the cgroup can be
>   killed while a process in that cgroup is forking.
>   If the kill request happens right before cgroup_can_fork() and before
>   the parent grabs its siglock the parent is guaranteed to see the
>   pending SIGKILL. In addition we perform another check in
>   cgroup_post_fork() whether the cgroup is being killed and is so take
>   down the child (see above). This is robust enough and protects gainst
>   forkbombs. If userspace really really wants to have stricter
>   protection the simple solution would be to grab the write side of the
>   cgroup threadgroup rwsem which will force all ongoing forks to
>   complete before killing starts. We concluded that this is not
>   necessary as the semantics for concurrent forking should simply align
>   with freezer where a similar check as cgroup_post_fork() is performed.
>
>   For all other cases CLONE_INTO_CGROUP is required. In this case we
>   will grab the cgroup mutex so the cgroup can't be killed while we
>   fork. Once we're done with the fork and have dropped cgroup mutex we
>   are visible and will be found by any subsequent kill request.
> - We obviously don't kill kthreads. This means a cgroup that has a
>   kthread will not become empty after killing and consequently no
>   unpopulated event will be generated. The assumption is that kthreads
>   should be in the root cgroup only anyway so this is not an issue.
> - We skip killing tasks that already have pending fatal signals.
> - Freezer doesn't care about tasks in different pid namespaces, i.e. if
>   you have two tasks in different pid namespaces the cgroup would still
>   be frozen. The cgroup.kill mechanism consequently behaves the same
>   way, i.e. we kill all processes and ignore in which pid namespace they
>   exist.
> - If the caller is located in a cgroup that is killed the caller will
>   obviously be killed as well.
>
> Cc: Shakeel Butt <shakeelb@google.com>
> Cc: Roman Gushchin <guro@fb.com>
> Cc: Tejun Heo <tj@kernel.org>
> Cc: cgroups@vger.kernel.org
> Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
> ---
>
> The series can be pulled from
>
> git@gitolite.kernel.org:pub/scm/linux/kernel/git/brauner/linux tags/cgroup.kill.v5.14
>
> /* v2 */
> - Roman Gushchin <guro@fb.com>:
>   - Retrieve cgrp->flags only once and check CGRP_* bits on it.
> ---
>  include/linux/cgroup-defs.h |   3 +
>  kernel/cgroup/cgroup.c      | 127 ++++++++++++++++++++++++++++++++----
>  2 files changed, 116 insertions(+), 14 deletions(-)
>
> diff --git a/include/linux/cgroup-defs.h b/include/linux/cgroup-defs.h
> index 559ee05f86b2..43fef771009a 100644
> --- a/include/linux/cgroup-defs.h
> +++ b/include/linux/cgroup-defs.h
> @@ -71,6 +71,9 @@ enum {
>  
>  	/* Cgroup is frozen. */
>  	CGRP_FROZEN,
> +
> +	/* Control group has to be killed. */
> +	CGRP_KILL,
>  };
>  
>  /* cgroup_root->flags */
> diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
> index 9153b20e5cc6..aee84b99534a 100644
> --- a/kernel/cgroup/cgroup.c
> +++ b/kernel/cgroup/cgroup.c
> @@ -3654,6 +3654,80 @@ static ssize_t cgroup_freeze_write(struct kernfs_open_file *of,
>  	return nbytes;
>  }
>  
> +static void __cgroup_kill(struct cgroup *cgrp)
> +{
> +	struct css_task_iter it;
> +	struct task_struct *task;
> +
> +	lockdep_assert_held(&cgroup_mutex);
> +
> +	spin_lock_irq(&css_set_lock);
> +	set_bit(CGRP_KILL, &cgrp->flags);
> +	spin_unlock_irq(&css_set_lock);
> +
> +	css_task_iter_start(&cgrp->self, CSS_TASK_ITER_PROCS | CSS_TASK_ITER_THREADED, &it);
> +	while ((task = css_task_iter_next(&it))) {
> +		/* Ignore kernel threads here. */
> +		if (task->flags & PF_KTHREAD)
> +			continue;
> +
> +		/* Skip tasks that are already dying. */
> +		if (__fatal_signal_pending(task))
> +			continue;
> +
> +		send_sig(SIGKILL, task, 0);
                ^^^^^^^^
Using send_sig here is wrong.  The function send_sig
is the interface to send a signal to a single task/thread.

The signal SIGKILL can not be sent to a single task/thread.
So it is never makes sense to use send_sig with SIGKILL.

As this all happens in the context of the process writing
to the file this can either be:

	group_send_sig_info(SIGKILL, SEND_SIG_NOINFO, task, PIDTYPE_TGID);

Which will check that the caller actually has permissions to kill the
specified task.  Or:

	do_send_sig_info(SIGKILL, SEND_SIG_NOINFO, task, PIDTYPE_TGID);




> +	}
> +	css_task_iter_end(&it);
> +
> +	spin_lock_irq(&css_set_lock);
> +	clear_bit(CGRP_KILL, &cgrp->flags);
> +	spin_unlock_irq(&css_set_lock);
> +}
> +
> +static void cgroup_kill(struct cgroup *cgrp)
> +{
> +	struct cgroup_subsys_state *css;
> +	struct cgroup *dsct;
> +
> +	lockdep_assert_held(&cgroup_mutex);
> +
> +	cgroup_for_each_live_descendant_pre(dsct, css, cgrp)
> +		__cgroup_kill(dsct);
> +}
> +
> +static ssize_t cgroup_kill_write(struct kernfs_open_file *of, char *buf,
> +				 size_t nbytes, loff_t off)
> +{
> +	ssize_t ret = 0;
> +	int kill;
> +	struct cgroup *cgrp;
> +
> +	ret = kstrtoint(strstrip(buf), 0, &kill);
> +	if (ret)
> +		return ret;
> +
> +	if (kill != 1)
> +		return -ERANGE;
> +
> +	cgrp = cgroup_kn_lock_live(of->kn, false);
> +	if (!cgrp)
> +		return -ENOENT;
> +
> +	/*
> +	 * Killing is a process directed operation, i.e. the whole thread-group
> +	 * is taken down so act like we do for cgroup.procs and only make this
> +	 * writable in non-threaded cgroups.
> +	 */
> +	if (cgroup_is_threaded(cgrp))
> +		ret = -EOPNOTSUPP;
> +	else
> +		cgroup_kill(cgrp);
> +
> +	cgroup_kn_unlock(of->kn);
> +
> +	return ret ?: nbytes;
> +}
> +
>  static int cgroup_file_open(struct kernfs_open_file *of)
>  {
>  	struct cftype *cft = of_cft(of);
> @@ -4846,6 +4920,11 @@ static struct cftype cgroup_base_files[] = {
>  		.seq_show = cgroup_freeze_show,
>  		.write = cgroup_freeze_write,
>  	},
> +	{
> +		.name = "cgroup.kill",
> +		.flags = CFTYPE_NOT_ON_ROOT,
> +		.write = cgroup_kill_write,
> +	},
>  	{
>  		.name = "cpu.stat",
>  		.seq_show = cpu_stat_show,
> @@ -6077,6 +6156,8 @@ void cgroup_post_fork(struct task_struct *child,
>  		      struct kernel_clone_args *kargs)
>  	__releases(&cgroup_threadgroup_rwsem) __releases(&cgroup_mutex)
>  {
> +	unsigned long cgrp_flags = 0;
> +	bool kill = false;
>  	struct cgroup_subsys *ss;
>  	struct css_set *cset;
>  	int i;
> @@ -6088,6 +6169,11 @@ void cgroup_post_fork(struct task_struct *child,
>  
>  	/* init tasks are special, only link regular threads */
>  	if (likely(child->pid)) {
> +		if (kargs->cgrp)
> +			cgrp_flags = kargs->cgrp->flags;
> +		else
> +			cgrp_flags = cset->dfl_cgrp->flags;
> +
>  		WARN_ON_ONCE(!list_empty(&child->cg_list));
>  		cset->nr_tasks++;
>  		css_set_move_task(child, NULL, cset, false);
> @@ -6096,23 +6182,32 @@ void cgroup_post_fork(struct task_struct *child,
>  		cset = NULL;
>  	}
>  
> -	/*
> -	 * If the cgroup has to be frozen, the new task has too.  Let's set
> -	 * the JOBCTL_TRAP_FREEZE jobctl bit to get the task into the
> -	 * frozen state.
> -	 */
> -	if (unlikely(cgroup_task_freeze(child))) {
> -		spin_lock(&child->sighand->siglock);
> -		WARN_ON_ONCE(child->frozen);
> -		child->jobctl |= JOBCTL_TRAP_FREEZE;
> -		spin_unlock(&child->sighand->siglock);
> +	if (!(child->flags & PF_KTHREAD)) {
> +		if (test_bit(CGRP_FREEZE, &cgrp_flags)) {
> +			/*
> +			 * If the cgroup has to be frozen, the new task has
> +			 * too. Let's set the JOBCTL_TRAP_FREEZE jobctl bit to
> +			 * get the task into the frozen state.
> +			 */
> +			spin_lock(&child->sighand->siglock);
> +			WARN_ON_ONCE(child->frozen);
> +			child->jobctl |= JOBCTL_TRAP_FREEZE;
> +			spin_unlock(&child->sighand->siglock);
> +
> +			/*
> +			 * Calling cgroup_update_frozen() isn't required here,
> +			 * because it will be called anyway a bit later from
> +			 * do_freezer_trap(). So we avoid cgroup's transient
> +			 * switch from the frozen state and back.
> +			 */
> +		}
>  
>  		/*
> -		 * Calling cgroup_update_frozen() isn't required here,
> -		 * because it will be called anyway a bit later from
> -		 * do_freezer_trap(). So we avoid cgroup's transient switch
> -		 * from the frozen state and back.
> +		 * If the cgroup is to be killed notice it now and take the
> +		 * child down right after we finished preparing it for
> +		 * userspace.
>  		 */
> +		kill = test_bit(CGRP_KILL, &cgrp_flags);
>  	}
>  
>  	spin_unlock_irq(&css_set_lock);
> @@ -6135,6 +6230,10 @@ void cgroup_post_fork(struct task_struct *child,
>  		put_css_set(rcset);
>  	}
>  
> +	/* Cgroup has to be killed so take down child immediately. */
> +	if (kill)
> +		send_sig(SIGKILL, child, 0);
                ^^^^^^^^
Using send_sig is wrong here for the same reasons as above.

Is a change to cgroup_post_fork necessary?  Fork already
has protections against a signal being delivered effectively
during fork.  Which may be enough in this case.


> +
>  	cgroup_css_set_put_fork(kargs);
>  }
>  
>
> base-commit: 9f4ad9e425a1d3b6a34617b8ea226d56a119a717
