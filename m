Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 28B6CB626E
	for <lists+cgroups@lfdr.de>; Wed, 18 Sep 2019 13:47:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730366AbfIRLru (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 18 Sep 2019 07:47:50 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52146 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730360AbfIRLru (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Wed, 18 Sep 2019 07:47:50 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 967FEA3D39D;
        Wed, 18 Sep 2019 11:47:49 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.43.17.72])
        by smtp.corp.redhat.com (Postfix) with SMTP id D7C8462DF;
        Wed, 18 Sep 2019 11:47:46 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Wed, 18 Sep 2019 13:47:49 +0200 (CEST)
Date:   Wed, 18 Sep 2019 13:47:45 +0200
From:   Oleg Nesterov <oleg@redhat.com>
To:     Honglei Wang <honglei.wang@oracle.com>
Cc:     Tejun Heo <tj@kernel.org>, lizefan@huawei.com, hannes@cmpxchg.org,
        cgroups@vger.kernel.org, Roman Gushchin <guro@fb.com>
Subject: Re: [PATCH] cgroup: freezer: Don't wake up process really blocked on
 signal
Message-ID: <20190918114745.GA16266@redhat.com>
References: <20190917064645.14666-1-honglei.wang@oracle.com>
 <20190917123941.GG3084169@devbig004.ftw2.facebook.com>
 <20190917134715.GA30334@redhat.com>
 <685531ef-3399-a6a8-0e9e-449c713c6785@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <685531ef-3399-a6a8-0e9e-449c713c6785@oracle.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2 (mx1.redhat.com [10.5.110.68]); Wed, 18 Sep 2019 11:47:49 +0000 (UTC)
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 09/18, Honglei Wang wrote:
>
>
> On 9/17/19 9:47 PM, Oleg Nesterov wrote:
> >>>int main(int argc, char *argv[])
> >>>{
> >>>         sigset_t waitset;
> >>>         int signo;
> >>>
> >>>         sigemptyset(&waitset);
> >>>         sigaddset(&waitset, SIGINT);
> >>>         sigaddset(&waitset, SIGUSR1);
> >>>
> >>>         pthread_sigmask(SIG_BLOCK, &waitset, NULL);
> >>>
> >>>         for (;;) {
> >>>                 signo = sigwaitinfo(&waitset, NULL);
> >>>                 if (signo < 0)
> >>>                         err(1, "sigwaitinfo() failed");
> >>>
> >>>                 if (signo == SIGUSR1)
> >>>                         printf("Receive SIGUSR1\n");
> >>>                 else
> >>>                         break;
> >>>         }
> >>>
> >>>         return 0;
> >>>}
> >
> >Well, I think we do not care. Userspace should handle -EINTR and restart
> >if necessary. And afaics this test case can equally "fail" if it races
> >with the system freezer, freeze_task() can be called between
> >set_current_state(TASK_INTERRUPTIBLE) and freezable_schedule() in
> >do_sigtimedwait().
> >
> >OTOH, this is another indication that kernel/cgroup/freezer.c should
> >interact with freezer_do_not_count/freezer_count somehow.
> >
>
> It looks weird if a task is happily waiting for the desired signal, but is
> woke up by an move from one cgroup to another (which is really not related
> to any signal action from the point of userspace), doesn't it?

Again, imo a sane application should handle -EINTR. Nothing really weird.

There are other reasons why sigwaitinfo() can return -EINTR. Say, another
thread can steal a signal. Or, simply start you test-case and run
strace -p.

If you want to "fix" sigwaitinfo() - just make it restartable, that is all.
But see above, I don't think this makes any sense.

> At this point, seems we need to be sure if it's necessary for cgroup to fix
> this problem or not.

Well, to me this particular problem simply doesn't exist ;) However, cgroup
freezer has other, more serious problems.

> >>>diff --git a/kernel/cgroup/freezer.c b/kernel/cgroup/freezer.c
> >>>index 8cf010680678..08f6abacaa75 100644
> >>>--- a/kernel/cgroup/freezer.c
> >>>+++ b/kernel/cgroup/freezer.c
> >>>@@ -162,10 +162,14 @@ static void cgroup_freeze_task(struct task_struct *task, bool freeze)
> >>>  	if (freeze) {
> >>>  		task->jobctl |= JOBCTL_TRAP_FREEZE;
> >>>-		signal_wake_up(task, false);
> >>>+
> >>>+		if (sigisemptyset(&task->real_blocked))
> >>>+			signal_wake_up(task, false);
> >
> >This can't really help, ->real_blocked can be empty even if this task
> >sleeps in sigwaitinfo().
> >
>
> Sorry, I'm not quit clear about the 'sleep'. sigwaitinfo() sets
> ->real_blocked in do_sigtimedwait() and it goes to
> freezable_schedule_hrtimeout_range() soon. After the task is woke up,
> ->real_blocked is cleared. Seems there is no chance to set ->real_blocked to
> empty in this path. Do I miss something important here? Please correct me.

Hmm. do_sigtimedwait() does

	tsk->real_blocked = tsk->blocked;

Now, if tsk->blocked was empty (sigisemptyset() == T), then why do you think
the sigisemptyset(real_blocked) check in cgroup_freeze_task() won't be true?


But in fact this doesn't really matter. This patch is wrong in any case.
sigwaitinfo() must not block cgroup freezer.

Oleg.

