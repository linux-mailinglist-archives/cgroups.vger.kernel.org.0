Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7AD4B374831
	for <lists+cgroups@lfdr.de>; Wed,  5 May 2021 20:49:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230380AbhEESuK (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 5 May 2021 14:50:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:41440 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229810AbhEESuJ (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Wed, 5 May 2021 14:50:09 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1CD1661027;
        Wed,  5 May 2021 18:49:09 +0000 (UTC)
Date:   Wed, 5 May 2021 20:49:06 +0200
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Christian Brauner <brauner@kernel.org>, Tejun Heo <tj@kernel.org>,
        Roman Gushchin <guro@fb.com>,
        Shakeel Butt <shakeelb@google.com>,
        Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>, cgroups@vger.kernel.org,
        containers@lists.linux.dev
Subject: Re: [PATCH v2 1/5] cgroup: introduce cgroup.kill
Message-ID: <20210505184906.ngybltl4knuadags@wittgenstein>
References: <20210503143922.3093755-1-brauner@kernel.org>
 <m1v97x6niq.fsf@fess.ebiederm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <m1v97x6niq.fsf@fess.ebiederm.org>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed, May 05, 2021 at 01:31:09PM -0500, Eric W. Biederman wrote:
> 
> Please see below this patch uses the wrong function to send SIGKILL.
> 
> Eric
> 
> 
> Christian Brauner <brauner@kernel.org> writes:
> 
> > From: Christian Brauner <christian.brauner@ubuntu.com>
> >
> > Introduce the cgroup.kill file. It does what it says on the tin and
> > allows a caller to kill a cgroup by writing "1" into cgroup.kill.
> > The file is available in non-root cgroups.
> >
> > Killing cgroups is a process directed operation, i.e. the whole
> > thread-group is affected. Consequently trying to write to cgroup.kill in
> > threaded cgroups will be rejected and EOPNOTSUPP returned. This behavior
> > aligns with cgroup.procs where reads in threaded-cgroups are rejected
> > with EOPNOTSUPP.
> >
> > The cgroup.kill file is write-only since killing a cgroup is an event
> > not which makes it different from e.g. freezer where a cgroup
> > transitions between the two states.
> >
> > As with all new cgroup features cgroup.kill is recursive by default.
> >
> > Killing a cgroup is protected against concurrent migrations through the
> > cgroup mutex. To protect against forkbombs and to mitigate the effect of
> > racing forks a new CGRP_KILL css set lock protected flag is introduced
> > that is set prior to killing a cgroup and unset after the cgroup has
> > been killed. We can then check in cgroup_post_fork() where we hold the
> > css set lock already whether the cgroup is currently being killed. If so
> > we send the child a SIGKILL signal immediately taking it down as soon as
> > it returns to userspace. To make the killing of the child semantically
> > clean it is killed after all cgroup attachment operations have been
> > finalized.
> >
> > There are various use-cases of this interface:
> > - Containers usually have a conservative layout where each container
> >   usually has a delegated cgroup. For such layouts there is a 1:1
> >   mapping between container and cgroup. If the container in addition
> >   uses a separate pid namespace then killing a container usually becomes
> >   a simple kill -9 <container-init-pid> from an ancestor pid namespace.
> >   However, there are quite a few scenarios where that isn't true. For
> >   example, there are containers that share the cgroup with other
> >   processes on purpose that are supposed to be bound to the lifetime of
> >   the container but are not in the same pidns of the container.
> >   Containers that are in a delegated cgroup but share the pid namespace
> >   with the host or other containers.
> > - Service managers such as systemd use cgroups to group and organize
> >   processes belonging to a service. They usually rely on a recursive
> >   algorithm now to kill a service. With cgroup.kill this becomes a
> >   simple write to cgroup.kill.
> > - Userspace OOM implementations can make good use of this feature to
> >   efficiently take down whole cgroups quickly.
> > - The kill program can gain a new
> >   kill --cgroup /sys/fs/cgroup/delegated
> >   flag to take down cgroups.
> >
> > A few observations about the semantics:
> > - If parent and child are in the same cgroup and CLONE_INTO_CGROUP is
> >   not specified we are not taking cgroup mutex meaning the cgroup can be
> >   killed while a process in that cgroup is forking.
> >   If the kill request happens right before cgroup_can_fork() and before
> >   the parent grabs its siglock the parent is guaranteed to see the
> >   pending SIGKILL. In addition we perform another check in
> >   cgroup_post_fork() whether the cgroup is being killed and is so take
> >   down the child (see above). This is robust enough and protects gainst
> >   forkbombs. If userspace really really wants to have stricter
> >   protection the simple solution would be to grab the write side of the
> >   cgroup threadgroup rwsem which will force all ongoing forks to
> >   complete before killing starts. We concluded that this is not
> >   necessary as the semantics for concurrent forking should simply align
> >   with freezer where a similar check as cgroup_post_fork() is performed.
> >
> >   For all other cases CLONE_INTO_CGROUP is required. In this case we
> >   will grab the cgroup mutex so the cgroup can't be killed while we
> >   fork. Once we're done with the fork and have dropped cgroup mutex we
> >   are visible and will be found by any subsequent kill request.
> > - We obviously don't kill kthreads. This means a cgroup that has a
> >   kthread will not become empty after killing and consequently no
> >   unpopulated event will be generated. The assumption is that kthreads
> >   should be in the root cgroup only anyway so this is not an issue.
> > - We skip killing tasks that already have pending fatal signals.
> > - Freezer doesn't care about tasks in different pid namespaces, i.e. if
> >   you have two tasks in different pid namespaces the cgroup would still
> >   be frozen. The cgroup.kill mechanism consequently behaves the same
> >   way, i.e. we kill all processes and ignore in which pid namespace they
> >   exist.
> > - If the caller is located in a cgroup that is killed the caller will
> >   obviously be killed as well.
> >
> > Cc: Shakeel Butt <shakeelb@google.com>
> > Cc: Roman Gushchin <guro@fb.com>
> > Cc: Tejun Heo <tj@kernel.org>
> > Cc: cgroups@vger.kernel.org
> > Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
> > ---
> >
> > The series can be pulled from
> >
> > git@gitolite.kernel.org:pub/scm/linux/kernel/git/brauner/linux tags/cgroup.kill.v5.14
> >
> > /* v2 */
> > - Roman Gushchin <guro@fb.com>:
> >   - Retrieve cgrp->flags only once and check CGRP_* bits on it.
> > ---
> >  include/linux/cgroup-defs.h |   3 +
> >  kernel/cgroup/cgroup.c      | 127 ++++++++++++++++++++++++++++++++----
> >  2 files changed, 116 insertions(+), 14 deletions(-)
> >
> > diff --git a/include/linux/cgroup-defs.h b/include/linux/cgroup-defs.h
> > index 559ee05f86b2..43fef771009a 100644
> > --- a/include/linux/cgroup-defs.h
> > +++ b/include/linux/cgroup-defs.h
> > @@ -71,6 +71,9 @@ enum {
> >  
> >  	/* Cgroup is frozen. */
> >  	CGRP_FROZEN,
> > +
> > +	/* Control group has to be killed. */
> > +	CGRP_KILL,
> >  };
> >  
> >  /* cgroup_root->flags */
> > diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
> > index 9153b20e5cc6..aee84b99534a 100644
> > --- a/kernel/cgroup/cgroup.c
> > +++ b/kernel/cgroup/cgroup.c
> > @@ -3654,6 +3654,80 @@ static ssize_t cgroup_freeze_write(struct kernfs_open_file *of,
> >  	return nbytes;
> >  }
> >  
> > +static void __cgroup_kill(struct cgroup *cgrp)
> > +{
> > +	struct css_task_iter it;
> > +	struct task_struct *task;
> > +
> > +	lockdep_assert_held(&cgroup_mutex);
> > +
> > +	spin_lock_irq(&css_set_lock);
> > +	set_bit(CGRP_KILL, &cgrp->flags);
> > +	spin_unlock_irq(&css_set_lock);
> > +
> > +	css_task_iter_start(&cgrp->self, CSS_TASK_ITER_PROCS | CSS_TASK_ITER_THREADED, &it);
> > +	while ((task = css_task_iter_next(&it))) {
> > +		/* Ignore kernel threads here. */
> > +		if (task->flags & PF_KTHREAD)
> > +			continue;
> > +
> > +		/* Skip tasks that are already dying. */
> > +		if (__fatal_signal_pending(task))
> > +			continue;
> > +
> > +		send_sig(SIGKILL, task, 0);
>                 ^^^^^^^^
> Using send_sig here is wrong.  The function send_sig
> is the interface to send a signal to a single task/thread.
> 
> The signal SIGKILL can not be sent to a single task/thread.
> So it is never makes sense to use send_sig with SIGKILL.
> 
> As this all happens in the context of the process writing
> to the file this can either be:
> 
> 	group_send_sig_info(SIGKILL, SEND_SIG_NOINFO, task, PIDTYPE_TGID);
> 
> Which will check that the caller actually has permissions to kill the
> specified task.  Or:
> 
> 	do_send_sig_info(SIGKILL, SEND_SIG_NOINFO, task, PIDTYPE_TGID);

The result should be the same but yes it's better to be explicit about
that. I'll switch to that.
