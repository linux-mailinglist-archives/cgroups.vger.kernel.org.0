Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C76F636C1CE
	for <lists+cgroups@lfdr.de>; Tue, 27 Apr 2021 11:36:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235199AbhD0Jg4 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 27 Apr 2021 05:36:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:40708 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235184AbhD0Jg4 (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Tue, 27 Apr 2021 05:36:56 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 13C676100B;
        Tue, 27 Apr 2021 09:36:10 +0000 (UTC)
Date:   Tue, 27 Apr 2021 11:36:06 +0200
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
Cc:     Christian Brauner <brauner@kernel.org>, Tejun Heo <tj@kernel.org>,
        Roman Gushchin <guro@fb.com>,
        Shakeel Butt <shakeelb@google.com>,
        Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>, cgroups@vger.kernel.org
Subject: Re: [RFC PATCH] cgroup: add cgroup.signal
Message-ID: <20210427093606.kygcgb74otakofes@wittgenstein>
References: <20210423171351.3614430-1-brauner@kernel.org>
 <YIcOZEbvky7hGbR1@blackbook>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YIcOZEbvky7hGbR1@blackbook>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Mon, Apr 26, 2021 at 09:03:00PM +0200, Michal Koutný wrote:
> On Fri, Apr 23, 2021 at 07:13:51PM +0200, Christian Brauner <brauner@kernel.org> wrote:
> > +static void __cgroup_signal(struct cgroup *cgrp, int signr)
> > +{
> > +	struct css_task_iter it;
> > +	struct task_struct *task;
> > +
> > +	lockdep_assert_held(&cgroup_mutex);
> > +
> > +	css_task_iter_start(&cgrp->self, 0, &it);
> 
> I think here you'd need CSS_TASK_ITER_PROCS here to avoid signalling
> multithreaded processes multiple times? (OTOH, with commiting just to
> SIGKILL this may be irrelevant.)

I thought about this optimization but (see below) given that it should
work with threaded cgroups we can't only walk thread-group leaders,
afaiu.
Instead I tried to rely on __fatal_signal_pending(). If any thread in a
thread-group leader catches SIGKILL it'll set the signal as pending for
each thread in the thread-group and __fatal_signal_pending() should
therefore be enough to skip useless send_sig() calls.

> 
> > +static void cgroup_signal(struct cgroup *cgrp, int signr)
> > [...]
> > +	read_lock(&tasklist_lock);
> 
> (Thinking loudly.)
> I wonder if it's possible to get rid of this? A similar check that
> freezer does in cgroup_post_fork() but perhaps in cgroup_can_fork(). The
> fork/clone would apparently fail for the soon-to-die parent but there's
> already similar error path returning ENODEV (heh, the macabrous name
> cgroup_is_dead() is already occupied).
> 
> This way the cgroup-killer wouldn't unncessarily preempt tasklist_lock
> exclusive requestors system-wide.

Good point. I've been playing with revamping this whole thing. We should
definitely do a post_fork() check too though but that's fairly cheap if
we simply introduce a simple CGRP_KILL flag and set it prior to killing
the cgroup.

> 
> 
> > @@ -4846,6 +4916,11 @@ static struct cftype cgroup_base_files[] = {
> > +	{
> > +		.name = "cgroup.signal",
> > +		.flags = CFTYPE_NOT_ON_ROOT,
> > +		.write = cgroup_signal_write,
> 
> I think this shouldn't be visible in threaded cgroups (or return an
> error when attempting to kill those).

I've been wondering about this too but then decided to follow freezer in
that regard. I think it should also be fine because a kill to a thread
will cause the whole thread-group to be taken down which arguably is the
semantics we want anyway.
