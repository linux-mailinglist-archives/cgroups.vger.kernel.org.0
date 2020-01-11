Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C3BA4137A68
	for <lists+cgroups@lfdr.de>; Sat, 11 Jan 2020 01:00:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727724AbgAKAAk (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 10 Jan 2020 19:00:40 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:35582 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727718AbgAKAAk (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 10 Jan 2020 19:00:40 -0500
Received: by mail-wr1-f67.google.com with SMTP id g17so3425485wro.2
        for <cgroups@vger.kernel.org>; Fri, 10 Jan 2020 16:00:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=6b10KFr2b/SXa8SjpLJKq2FHzb01RuYd99JphLV4XKQ=;
        b=o9BPH+5nyRj/6E2mBd7VSBEMrlEx+FdEVc96Sqa6RXkhKYdQx3YPUZhfXa30IGI4il
         TwfsOu6bKusT7rQAOfAxHdc3QOJmVRinuqX742vwsoD3tFU21+E+grsqbfYCC+cDmfCO
         c0O914zDiakaFxj+Lo3yCMz9X1pkVGRJHhTuTAsFW7cPBatuNZgXeRtAodD53xfZH9pj
         5d9Ks7GDE1NrFC33ZMh/9yFb/NH3cxX2jA+vVcITaNKUy00XigzJ8KsIF13TmkDgs3/f
         nOt4qcqc9pwvlCHjQS4AmxyqTvbZQExe4G6GkwpecGfB/ai15S6/h/KULtIJH04ra6uY
         8A+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=6b10KFr2b/SXa8SjpLJKq2FHzb01RuYd99JphLV4XKQ=;
        b=r6r7Ur4eI25wq9ljlRGx/zL52ZwPG5XXWB3e0s6PZmiKJE26emcIgvFPjCEighLL6h
         X+6CoCFQ6wuPgS+dQCYjB42UFmNJWevv6k8xpDJFljkKKL8joEgFl0cDyxO3taBim4ID
         q9nvEShiXzwRzx7LsY+WODiUAExTdPfcDwLfIgMI1Cp1g9UaYNEMEbGLPq06jY5g/J+0
         ZM8veki6QbeWYWg3tk5hQ1G09O118pBOsusedR52SmHzF5EHhac5OLnNZp9MI9LR2NBe
         FZWu8vdxd2/X5Iym8zK7SCpZtXvJn8NtCd6EWOKH0ZB72xMAWTiS7tAzcuykCDVKtqrv
         XUgQ==
X-Gm-Message-State: APjAAAVl8TPJbBQ625qmK0EYYiYpBSFUrQzr2rdHFvZbbHbtqMcbavsB
        1OwwUsbKFQfJJ9sluxP3cq+P+HOSHqn30l4UvWlhaw==
X-Google-Smtp-Source: APXvYqyJi/J7TFHASi7tWncoszTF0lk/P3nc4mg6PZdV06sfVna1wxEB53RYCrEw6scmfW/qdX0K1hWQ88d8Z7fDdkc=
X-Received: by 2002:a5d:528e:: with SMTP id c14mr6107957wrv.308.1578700837418;
 Fri, 10 Jan 2020 16:00:37 -0800 (PST)
MIME-Version: 1.0
References: <87zhn6923n.fsf@xmission.com> <e407a8e7-7780-f08f-320a-a0f2c954d253@gmail.com>
 <20190529003601.GN374014@devbig004.ftw2.facebook.com> <e45d974b-5eff-f781-291f-ddf5e9679e4c@gmail.com>
 <20190530183556.GR374014@devbig004.ftw2.facebook.com> <20190530183637.GS374014@devbig004.ftw2.facebook.com>
 <20190530183700.GT374014@devbig004.ftw2.facebook.com> <20190607170952.GE30727@blackbody.suse.cz>
 <20190611185742.GH3341036@devbig004.ftw2.facebook.com> <CAJuCfpGkAsmp5B=fNz38fLE8pYaMCG=uLDSSBFByNOtWD20zVQ@mail.gmail.com>
 <20200110231624.GA6557@blackbook>
In-Reply-To: <20200110231624.GA6557@blackbook>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Fri, 10 Jan 2020 16:00:26 -0800
Message-ID: <CAJuCfpG-sn0wPM9GRnCjrmytf=mDC3smsRRd=XQBLAK6ZKoAUA@mail.gmail.com>
Subject: Re: [PATCH 3/3 cgroup/for-5.2-fixes] cgroup: Include dying leaders
 with live threads in PROCS iterations
To:     =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>
Cc:     Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>,
        Topi Miettinen <toiwoton@gmail.com>,
        Li Zefan <lizefan@huawei.com>,
        cgroups mailinglist <cgroups@vger.kernel.org>,
        security@debian.org, Security Officers <security@kernel.org>,
        Lennart Poettering <lennart@poettering.net>,
        Oleg Nesterov <oleg@redhat.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        james.hsu@mediatek.com, linger.lee@mediatek.com,
        Tom Cherry <tomcherry@google.com>, Roman Gushchin <guro@fb.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

 H Michal,

On Fri, Jan 10, 2020 at 3:16 PM Michal Koutn=C3=BD <mkoutny@suse.com> wrote=
:
>
> Hello Suren.
>
> On Fri, Jan 10, 2020 at 01:47:19PM -0800, Suren Baghdasaryan <surenb@goog=
le.com> wrote:
> > > On Fri, Jun 07, 2019 at 07:09:53PM +0200, Michal Koutn=C3=BD wrote:
> > > > Wouldn't it make more sense to call
> > > >       css_set_move_task(tsk, cset, NULL, false);
> > > > in cgroup_release instead of cgroup_exit then?
> > > >
> > > > css_set_move_task triggers the cgroup emptiness notification so if =
we
> > > > list group leaders with running siblings as members of the cgroup (=
IMO
> > > > correct), is it consistent to deliver the (un)populated event
> > > > that early?
> > > > By moving to cgroup_release we would also make this notification
> > > > analogous to SIGCHLD delivery.
> > >
> > > So, the current behavior is mostly historical and I don't think this
> > > is a better behavior.  That said, I'm not sure about the cost benefit
> > > ratio of changing the behavior at this point given how long the code
> > > has been this way.  Another aspect is that it'd expose zombie tasks
> > > and possibly migrations of them to each controller.
> >
> > Sorry for reviving an old discussion
> Since you reply to my remark, I have to share that I found myself wrong
> later wrt the emptiness notifications. Moving the task in cgroup_exit
> doesn't matter if thread group contains other live tasks, the unpopulated
> notification will be raised when the last task of thread group calls
> group_exit, i.e. it is similar to SIGHLD.
>
> Now to your issue.
>
> > but I got a bug report from a customer about Android
> What kernel version is that? Can be it considered equal to the current
> Linux?

I reproduced this with 4.19 kernel that had Tejun's patches backported
but I believe the same behavior will happen with any kernel that
contains c03cd7738a83 ("cgroup: Include dying leaders with live
threads in PROCS iterations") including the latest. I'll try to
confirm this on 5.4 next week.

>
> > In my testing I was able to reproduce the failure in
> > which case rmdir() fails with EBUSY from cgroup_destroy_locked()
> > because cgroup_is_populated() returns true.
> That'd mean that not all tasks in the cgroup did exit() (cgroup_exit()),
> i.e. they're still running. Can you see them in cgroup.threads/tasks?

Correct, I confirmed that there are still tasks in cset->tasks list
when this happens. Actually when I reproduced this I logged one task
in cset->dying_tasks which was the group leader and another one in
cset->tasks. So the last task to reach cgroup_exit() was not the group
leader.
However these tasks will be ignored when we enumerate them using
css_task_iter_start()/css_task_iter_next() loop because
css_task_iter_advance() ignores tasks with PF_EXITING flag set or
group leaders with task->signal->live=3D=3D0 (see the code lines I posted
in my first email). So threads are there, they are PF_EXITING but at
least one of them did not reach cgroup_exit() yet. When user space
reads cgroup.procs/tasks they are skipped. This is the change in
behavior which is different from what it used to be before this patch.
Prior to it these tasks would be visible even if they are exiting.

>
> > cgroup_is_populated() depends on cgrp->nr_populated_xxx counters which
> > IIUC will not be updated until cgroup_update_populated() is called
> > from cgroup_exit() and that might get delayed...
> Why do you think it's delayed?

I think exit_mm() can be one of the contributors if the process owns a
considerable amount of memory but there might be other possible
reasons.

> > So from user space's point of view the cgroup is empty and can be
> > removed but rmdir() fails to do so.
> As Tejun says, cgroup with only dead _tasks_ should be removable (and if
> I'm not mistaken it is in the current kernel). Unless you do individual
> threads migration when a thread would be separated from its (dead)
> leader. Does your case include such migrations?
>
> Michal

Thanks,
Suren.
