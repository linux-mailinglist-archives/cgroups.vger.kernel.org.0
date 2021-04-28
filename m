Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2153736D9B3
	for <lists+cgroups@lfdr.de>; Wed, 28 Apr 2021 16:39:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240106AbhD1Oil (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 28 Apr 2021 10:38:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:54142 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233516AbhD1Oik (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Wed, 28 Apr 2021 10:38:40 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0243861222;
        Wed, 28 Apr 2021 14:37:53 +0000 (UTC)
Date:   Wed, 28 Apr 2021 16:37:46 +0200
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Tejun Heo <tj@kernel.org>,
        Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>,
        Roman Gushchin <guro@fb.com>
Cc:     Christian Brauner <brauner@kernel.org>,
        Shakeel Butt <shakeelb@google.com>,
        Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>, cgroups@vger.kernel.org
Subject: Re: [RFC PATCH] cgroup: add cgroup.signal
Message-ID: <20210428143746.p6tjwv6ywgpixnjy@wittgenstein>
References: <20210423171351.3614430-1-brauner@kernel.org>
 <YIcOZEbvky7hGbR1@blackbook>
 <20210427093606.kygcgb74otakofes@wittgenstein>
 <YIgfrP5J3aXHfM1i@slm.duckdns.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YIgfrP5J3aXHfM1i@slm.duckdns.org>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue, Apr 27, 2021 at 10:29:00AM -0400, Tejun Heo wrote:
> Hello,
> 
> On Tue, Apr 27, 2021 at 11:36:06AM +0200, Christian Brauner wrote:
> > I thought about this optimization but (see below) given that it should
> > work with threaded cgroups we can't only walk thread-group leaders,
> > afaiu.
> 
> CSS_TASK_ITER_PROCS|CSS_TASK_ITER_THREADED iterates all thread group leaders
> in the threaded domain and is used to implement cgroup.procs. This should
> work, right?

Yes, I switched to that.

> 
> > > > @@ -4846,6 +4916,11 @@ static struct cftype cgroup_base_files[] = {
> > > > +	{
> > > > +		.name = "cgroup.signal",
> > > > +		.flags = CFTYPE_NOT_ON_ROOT,
> > > > +		.write = cgroup_signal_write,
> > > 
> > > I think this shouldn't be visible in threaded cgroups (or return an
> > > error when attempting to kill those).
> > 
> > I've been wondering about this too but then decided to follow freezer in
> > that regard. I think it should also be fine because a kill to a thread
> > will cause the whole thread-group to be taken down which arguably is the
> > semantics we want anyway.
> 
> I'd align it with cgroup.procs. Killing is a process-level operation (unlike
> arbitrary signal delivery which I think is another reason to confine this to
> killing) and threaded cgroups should be invisible to process-level
> operations.

Ok, so we make write to cgroup.kill in threaded cgroups EOPNOTSUPP which
is equivalent what a read on cgroup.procs would yield.

Tejun, Roman, Michal, I've been thinking a bit about the escaping
children during fork() when killing a cgroup and I would like to propose
we simply take the write-side of threadgroup_rwsem during cgroup.kill.

This would give us robust protection against escaping children during
fork() since fork()ing takes the read-side already in cgroup_can_fork().
And cgroup.kill should be sufficiently rare that this isn't an
additional burden.

Other ways seems more fragile where the child can potentially escape
being killed. The most obvious case is when CLONE_INTO_CGROUP is not
used. If a cgroup.kill is initiated after cgroup_can_fork() and after
the parent's fatal_signal_pending() check we will wait for the parent to
release the siglock in cgroup_kill(). Once it does we deliver the fatal
signal to the parent. But if we haven't passed cgroup_post_fork() fast
enough the child can be placed into that cgroup right after the kill.
That's not super bad per se since the child isn't technically visible in
the target cgroup anyway but it feels a bit cleaner if it would die
right away. We could minimize the window by raising a flag say CGRP_KILL
say:

static void __cgroup_kill(struct cgroup *cgrp)
{
       spin_lock_irq(&css_set_lock);
       set_bit(CGRP_KILL, &cgrp->flags);
       spin_unlock_irq(&css_set_lock);

       css_task_iter_start(&cgrp->self, CSS_TASK_ITER_PROCS | CSS_TASK_ITER_THREADED, &it);
       while ((task = css_task_iter_next(&it)))
               /* KILL IT */

       spin_lock_irq(&css_set_lock);
       clear_bit(CGRP_KILL, &cgrp->flags);
       spin_unlock_irq(&css_set_lock);

but that's also not clean enough for my taste. So I think the
threadgroup_rwsem might be quite clean and acceptable?

static void cgroup_kill(struct cgroup *cgrp)
{
       struct cgroup_subsys_state *css;
       struct cgroup *dsct;

       lockdep_assert_held(&cgroup_mutex);

       percpu_down_write(&cgroup_threadgroup_rwsem);
       cgroup_for_each_live_descendant_pre(dsct, css, cgrp)
               __cgroup_kill(dsct);
       percpu_up_write(&cgroup_threadgroup_rwsem);
}
