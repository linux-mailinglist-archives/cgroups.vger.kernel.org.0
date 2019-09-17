Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6B392B4FA0
	for <lists+cgroups@lfdr.de>; Tue, 17 Sep 2019 15:47:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726308AbfIQNrT (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 17 Sep 2019 09:47:19 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50532 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726230AbfIQNrT (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Tue, 17 Sep 2019 09:47:19 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id A73F13175281;
        Tue, 17 Sep 2019 13:47:18 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.43.17.72])
        by smtp.corp.redhat.com (Postfix) with SMTP id D73DA60167;
        Tue, 17 Sep 2019 13:47:16 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Tue, 17 Sep 2019 15:47:18 +0200 (CEST)
Date:   Tue, 17 Sep 2019 15:47:16 +0200
From:   Oleg Nesterov <oleg@redhat.com>
To:     Tejun Heo <tj@kernel.org>
Cc:     Honglei Wang <honglei.wang@oracle.com>, lizefan@huawei.com,
        hannes@cmpxchg.org, cgroups@vger.kernel.org,
        Roman Gushchin <guro@fb.com>
Subject: Re: [PATCH] cgroup: freezer: Don't wake up process really blocked on
 signal
Message-ID: <20190917134715.GA30334@redhat.com>
References: <20190917064645.14666-1-honglei.wang@oracle.com>
 <20190917123941.GG3084169@devbig004.ftw2.facebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190917123941.GG3084169@devbig004.ftw2.facebook.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.49]); Tue, 17 Sep 2019 13:47:19 +0000 (UTC)
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 09/17, Tejun Heo wrote:
>
> (cc'ing Roman and Oleg and quoting whole body)
> 
> On Tue, Sep 17, 2019 at 02:46:45PM +0800, Honglei Wang wrote:
> > Process who's waiting for specific sigset shouldn't be woke up
> > neither it is moved between different cgroups nor the cgroup it
> > belongs to changes the frozen state. We'd better keep it as is
> > and let it wait for the desired signals coming.
> > 
> > Following test case is one scenario which will get "Interrupted
> > system call" error if we wake it up in cgroup_freeze_task().
> > 
> > int main(int argc, char *argv[])
> > {
> >         sigset_t waitset;
> >         int signo;
> > 
> >         sigemptyset(&waitset);
> >         sigaddset(&waitset, SIGINT);
> >         sigaddset(&waitset, SIGUSR1);
> > 
> >         pthread_sigmask(SIG_BLOCK, &waitset, NULL);
> > 
> >         for (;;) {
> >                 signo = sigwaitinfo(&waitset, NULL);
> >                 if (signo < 0)
> >                         err(1, "sigwaitinfo() failed");
> > 
> >                 if (signo == SIGUSR1)
> >                         printf("Receive SIGUSR1\n");
> >                 else
> >                         break;
> >         }
> > 
> >         return 0;
> > }

Well, I think we do not care. Userspace should handle -EINTR and restart
if necessary. And afaics this test case can equally "fail" if it races
with the system freezer, freeze_task() can be called between
set_current_state(TASK_INTERRUPTIBLE) and freezable_schedule() in
do_sigtimedwait().

OTOH, this is another indication that kernel/cgroup/freezer.c should
interact with freezer_do_not_count/freezer_count somehow.


> > 
> > Signed-off-by: Honglei Wang <honglei.wang@oracle.com>
> > ---
> >  kernel/cgroup/freezer.c | 8 ++++++--
> >  1 file changed, 6 insertions(+), 2 deletions(-)
> > 
> > diff --git a/kernel/cgroup/freezer.c b/kernel/cgroup/freezer.c
> > index 8cf010680678..08f6abacaa75 100644
> > --- a/kernel/cgroup/freezer.c
> > +++ b/kernel/cgroup/freezer.c
> > @@ -162,10 +162,14 @@ static void cgroup_freeze_task(struct task_struct *task, bool freeze)
> >  
> >  	if (freeze) {
> >  		task->jobctl |= JOBCTL_TRAP_FREEZE;
> > -		signal_wake_up(task, false);
> > +
> > +		if (sigisemptyset(&task->real_blocked))
> > +			signal_wake_up(task, false);

This can't really help, ->real_blocked can be empty even if this task
sleeps in sigwaitinfo().

Oleg.

