Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 20DC8E4F29
	for <lists+cgroups@lfdr.de>; Fri, 25 Oct 2019 16:32:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392836AbfJYOcp (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 25 Oct 2019 10:32:45 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:47282 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727003AbfJYOcp (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 25 Oct 2019 10:32:45 -0400
Received: from [213.220.153.21] (helo=wittgenstein)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1iO0de-0007qC-Bl; Fri, 25 Oct 2019 14:32:26 +0000
Date:   Fri, 25 Oct 2019 16:32:25 +0200
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Oleg Nesterov <oleg@redhat.com>
Cc:     Tejun Heo <tj@kernel.org>, dvyukov@google.com,
        Li Zefan <lizefan@huawei.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        akpm@linux-foundation.org, arnd@arndb.de, deepa.kernel@gmail.com,
        ebiederm@xmission.com, elver@google.com, guro@fb.com,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        cgroups@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH cgroup/for-5.5] cgroup: remove
 cgroup_enable_task_cg_lists() optimization
Message-ID: <20191025143224.wtwkkimqq4644iqq@wittgenstein>
References: <0000000000003b1e8005956939f1@google.com>
 <20191021142111.GB1339@redhat.com>
 <20191024190351.GD3622521@devbig004.ftw2.facebook.com>
 <20191025125606.GI3622521@devbig004.ftw2.facebook.com>
 <20191025133358.pxpzxkhqc3mboi5x@wittgenstein>
 <20191025141325.GB6020@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20191025141325.GB6020@redhat.com>
User-Agent: NeoMutt/20180716
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Fri, Oct 25, 2019 at 04:13:25PM +0200, Oleg Nesterov wrote:
> On 10/25, Christian Brauner wrote:
> >
> > [+Dmitry]
> >
> > On Fri, Oct 25, 2019 at 05:56:06AM -0700, Tejun Heo wrote:
> > > On Thu, Oct 24, 2019 at 12:03:51PM -0700, Tejun Heo wrote:
> > > > cgroup_enable_task_cg_lists() is used to lazyily initialize task
> > > > cgroup associations on the first use to reduce fork / exit overheads
> > > > on systems which don't use cgroup.  Unfortunately, locking around it
> > > > has never been actually correct and its value is dubious given how the
> > > > vast majority of systems use cgroup right away from boot.
> > > >
> > > > This patch removes the optimization.  For now, replace the cg_list
> > > > based branches with WARN_ON_ONCE()'s to be on the safe side.  We can
> > > > simplify the logic further in the future.
> > > >
> > > > Signed-off-by: Tejun Heo <tj@kernel.org>
> > > > Reported-by: Oleg Nesterov <oleg@redhat.com>
> > >
> > > Applying to cgroup/for-5.5.
> >
> > The code you removed was the only place where task->flags was set from
> > !current.
> 
> No, that code doesn't modify task->flags. It checks PF_EXITING under siglock
> but this makes no sense and can't avoid the race with cgroup_exit().

Sorry, you are right. I misread
Ah right, sorry I misremembered this from the prior thread where we
discussed where ->flags is set from [1].

> 
> > So I think this fixes the syzbot data-race report in:
> > https://lore.kernel.org/r/0000000000003b1e8005956939f1@google.com
> 
> No.
> 
> Almost every usage of task->flags (load or sore) can be reported as "data race".
> 
> Say, you do
> 
> 	if (task->flags & PF_KTHREAD)
> 
> while this task does
> 
> 	current->flags |= PF_FREEZER_SKIP;
> 	schedule().
> 
> this is data race.

Right, but I thought we agreed on WONTFIX in those scenarios?
The alternative is to READ_ONCE()/WRITE_ONCE() all of these.

[1]: https://lore.kernel.org/r/20191021134659.GA1339@redhat.com

Anyway, accidental noise on my part.
Christian
