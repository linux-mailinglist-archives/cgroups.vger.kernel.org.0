Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0572C13D320
	for <lists+cgroups@lfdr.de>; Thu, 16 Jan 2020 05:26:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730479AbgAPE0Y (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 15 Jan 2020 23:26:24 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:52753 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729048AbgAPE0X (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 15 Jan 2020 23:26:23 -0500
Received: by mail-wm1-f68.google.com with SMTP id p9so2283909wmc.2
        for <cgroups@vger.kernel.org>; Wed, 15 Jan 2020 20:26:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=a5N2u0A3A1Ze4ASuZeJI3+cOqS5XMVlaChKs80y7r2w=;
        b=HXFkBhBfNqMUD6OB6zGklJ6bCwzVK2oBHH+gUOP9lP0MsdXg2KM2JmiexVJSydcni6
         ZeOQSnOCNzP8++MAPz5SbPR2S4BM5AqTZeUUj4NEVmVP+5K9wKb4qD6kzMhXLzXrgXoO
         PHw48OdmAzK5J2L39yEZC0DqtOSh+P4WzHSvQFn2QYoLw4ZmQXxhS8hc0djLgRd8KFDv
         x8MEti7+OyyQ1esvmLsncsiCPf6M3mNgBUetpvKPSTJwUTxfKrAI6Py8z39126cZ+Tb1
         uwmRE9bIRnqKbH2/6A/Su7UqsBKbMMtikPvH6ykX5uFtLKH03mzgCtuo6HFNXhuGY48W
         k6gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=a5N2u0A3A1Ze4ASuZeJI3+cOqS5XMVlaChKs80y7r2w=;
        b=PYXnpAHBvXW7eSAf6cI6HW46/e73PFRTywZirNaGvXpJMK3V4xYqh3w20TszcAWEKU
         XYYa0JyLztOuQJP4c7K3vWltITIVDGmwBJc77X9mz+ZWi4ayEMfTP4gNZeZJMKiH9Zo5
         DnljRD4nSrGt1kJVNBzZ83ioXMqW31+o1UnrrvcH4zpydbBdNAZfRXM9mEdaahv0KW6H
         U8L7NYkUMVlKsUNgsbbI/vDKngD9HIpltYMImg3jqPdnepesuVzmXWIegaalFkh5EeJf
         MfSUbXk7jNSPom0bHW1fWEq7JeoJOafkhs1bHIAynLx/f5L0z4o8XKXCqhqa9utl2KqA
         c/2Q==
X-Gm-Message-State: APjAAAXNDO7ayFr+OJ149G/jWbET6eI2oDkgIFhPvAUfFUrAGaUFUhXy
        EoRhYF0+uysqES311JW7yexU+QF+t2jA6mUODKgKiw==
X-Google-Smtp-Source: APXvYqx2eIc1IcJkpUdmKUDzitQ7czR3bwT3+ZUwUk25IPHp0puGaRHTn/XVZ9p+L7KjzogSX/edk0DsI+1s/4AuiWw=
X-Received: by 2002:a1c:6588:: with SMTP id z130mr3863373wmb.0.1579148780328;
 Wed, 15 Jan 2020 20:26:20 -0800 (PST)
MIME-Version: 1.0
References: <87zhn6923n.fsf@xmission.com> <e407a8e7-7780-f08f-320a-a0f2c954d253@gmail.com>
 <20190529003601.GN374014@devbig004.ftw2.facebook.com> <e45d974b-5eff-f781-291f-ddf5e9679e4c@gmail.com>
 <20190530183556.GR374014@devbig004.ftw2.facebook.com> <20190530183637.GS374014@devbig004.ftw2.facebook.com>
 <20190530183700.GT374014@devbig004.ftw2.facebook.com> <20190607170952.GE30727@blackbody.suse.cz>
 <20190611185742.GH3341036@devbig004.ftw2.facebook.com> <CAJuCfpGkAsmp5B=fNz38fLE8pYaMCG=uLDSSBFByNOtWD20zVQ@mail.gmail.com>
 <20200110231624.GA6557@blackbook> <CAJuCfpG-sn0wPM9GRnCjrmytf=mDC3smsRRd=XQBLAK6ZKoAUA@mail.gmail.com>
 <CAJuCfpFeiH_8MbX3qeAKCz_z+XXYp9M2KrnkOsBoN5jGoV7=eg@mail.gmail.com>
In-Reply-To: <CAJuCfpFeiH_8MbX3qeAKCz_z+XXYp9M2KrnkOsBoN5jGoV7=eg@mail.gmail.com>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Wed, 15 Jan 2020 20:26:09 -0800
Message-ID: <CAJuCfpGpcadPPXuU_4mNHy7tjPRXDkttWxqv1kUrGzGKOtsUxg@mail.gmail.com>
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
        james.hsu@mediatek.com, JeiFeng Lee <linger.lee@mediatek.com>,
        Tom Cherry <tomcherry@google.com>, Roman Gushchin <guro@fb.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Fri, Jan 10, 2020 at 4:55 PM Suren Baghdasaryan <surenb@google.com> wrot=
e:
>
> On Fri, Jan 10, 2020 at 4:00 PM Suren Baghdasaryan <surenb@google.com> wr=
ote:
> >
> >  H Michal,
> >
> > On Fri, Jan 10, 2020 at 3:16 PM Michal Koutn=C3=BD <mkoutny@suse.com> w=
rote:
> > >
> > > Hello Suren.
> > >
> > > On Fri, Jan 10, 2020 at 01:47:19PM -0800, Suren Baghdasaryan <surenb@=
google.com> wrote:
> > > > > On Fri, Jun 07, 2019 at 07:09:53PM +0200, Michal Koutn=C3=BD wrot=
e:
> > > > > > Wouldn't it make more sense to call
> > > > > >       css_set_move_task(tsk, cset, NULL, false);
> > > > > > in cgroup_release instead of cgroup_exit then?
> > > > > >
> > > > > > css_set_move_task triggers the cgroup emptiness notification so=
 if we
> > > > > > list group leaders with running siblings as members of the cgro=
up (IMO
> > > > > > correct), is it consistent to deliver the (un)populated event
> > > > > > that early?
> > > > > > By moving to cgroup_release we would also make this notificatio=
n
> > > > > > analogous to SIGCHLD delivery.
> > > > >
> > > > > So, the current behavior is mostly historical and I don't think t=
his
> > > > > is a better behavior.  That said, I'm not sure about the cost ben=
efit
> > > > > ratio of changing the behavior at this point given how long the c=
ode
> > > > > has been this way.  Another aspect is that it'd expose zombie tas=
ks
> > > > > and possibly migrations of them to each controller.
> > > >
> > > > Sorry for reviving an old discussion
> > > Since you reply to my remark, I have to share that I found myself wro=
ng
> > > later wrt the emptiness notifications. Moving the task in cgroup_exit
> > > doesn't matter if thread group contains other live tasks, the unpopul=
ated
> > > notification will be raised when the last task of thread group calls
> > > group_exit, i.e. it is similar to SIGHLD.
> > >
> > > Now to your issue.
> > >
> > > > but I got a bug report from a customer about Android
> > > What kernel version is that? Can be it considered equal to the curren=
t
> > > Linux?
> >
> > I reproduced this with 4.19 kernel that had Tejun's patches backported
> > but I believe the same behavior will happen with any kernel that
> > contains c03cd7738a83 ("cgroup: Include dying leaders with live
> > threads in PROCS iterations") including the latest. I'll try to
> > confirm this on 5.4 next week.

Hi Folks,
I confirmed that the issue is happening on 5.4 as well. I did
implement a fix for this and a kselftest to reproduce the problem.
Will send both the fix and the kselftest as a 2-patch series shortly.
Thanks,
Suren.

> >
> > >
> > > > In my testing I was able to reproduce the failure in
> > > > which case rmdir() fails with EBUSY from cgroup_destroy_locked()
> > > > because cgroup_is_populated() returns true.
> > > That'd mean that not all tasks in the cgroup did exit() (cgroup_exit(=
)),
> > > i.e. they're still running. Can you see them in cgroup.threads/tasks?
> >
> > Correct, I confirmed that there are still tasks in cset->tasks list
> > when this happens. Actually when I reproduced this I logged one task
> > in cset->dying_tasks which was the group leader and another one in
> > cset->tasks. So the last task to reach cgroup_exit() was not the group
> > leader.
> > However these tasks will be ignored when we enumerate them using
> > css_task_iter_start()/css_task_iter_next() loop because
> > css_task_iter_advance() ignores tasks with PF_EXITING flag set or
> > group leaders with task->signal->live=3D=3D0 (see the code lines I post=
ed
> > in my first email). So threads are there, they are PF_EXITING but at
> > least one of them did not reach cgroup_exit() yet. When user space
> > reads cgroup.procs/tasks they are skipped. This is the change in
> > behavior which is different from what it used to be before this patch.
> > Prior to it these tasks would be visible even if they are exiting.
> >
> > >
> > > > cgroup_is_populated() depends on cgrp->nr_populated_xxx counters wh=
ich
> > > > IIUC will not be updated until cgroup_update_populated() is called
> > > > from cgroup_exit() and that might get delayed...
> > > Why do you think it's delayed?
> >
> > I think exit_mm() can be one of the contributors if the process owns a
> > considerable amount of memory but there might be other possible
> > reasons.
> >
> > > > So from user space's point of view the cgroup is empty and can be
> > > > removed but rmdir() fails to do so.
> > > As Tejun says, cgroup with only dead _tasks_ should be removable (and=
 if
> > > I'm not mistaken it is in the current kernel).
>
> Sorry, I missed this last part.
> Agree, if all tasks are dead the cgroup should be removable and it
> will be if all tasks reached cgroup_exit(). The issue happens when
> tasks are marked PF_EXITING, userspace reads empty cgroups.procs and
> issues rmdir() before the last killed task reaches cgroup_exit().
>
> > > Unless you do individual
> > > threads migration when a thread would be separated from its (dead)
> > > leader. Does your case include such migrations?
>
> No my case just kills all tasks in the cgroup until cgroup.procs is
> empty and then tries to remove the cgroup itself. No migrations.
>
> > >
> > > Michal
> >
> > Thanks,
> > Suren.
