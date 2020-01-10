Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 50DF41378AC
	for <lists+cgroups@lfdr.de>; Fri, 10 Jan 2020 22:47:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726959AbgAJVrd (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 10 Jan 2020 16:47:33 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:53215 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726912AbgAJVrd (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 10 Jan 2020 16:47:33 -0500
Received: by mail-wm1-f65.google.com with SMTP id p9so3542426wmc.2
        for <cgroups@vger.kernel.org>; Fri, 10 Jan 2020 13:47:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=wmjhQ0F6HQ+vKH3P6876+WWt3VvMyVFJKzyq6Non2ks=;
        b=OXlCVib6UbN3bCeo134vAFEiWACRORKuRtejTtI50t2GbCVhz/fuBxNac9f7WVOU4L
         IHtMMccA0Cmq2YEPsXMggbDkQqP1G0Nrr6wG01IRR30NrNhIG0OkONrz/pvU4tEojdVD
         a+ZEZCg8mkGGgZwxGMQKh7l8fDJ89rDj+6hS1i6qe3LriILe42mHyRZPHylwT426pJEY
         YvKimz/Udua2aq/pIvxTQHJKLcUMyU3SFXpfrxj91hCCOgFT3ukmEZcsjE6mvCX2Lmsy
         qMCkgvFNr2cR0ElAuf/NxZaxzbhe+ggFk8mWRKO4ZbaOyCAOkFROwhbu11TWMaElOnAv
         4dMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=wmjhQ0F6HQ+vKH3P6876+WWt3VvMyVFJKzyq6Non2ks=;
        b=QEwtGn7iI7boXZ5Ml+H1b4z6yCMnAfzTdFP5qaMToVun8/4w7+iwZndNhoc8V4Xc8s
         ZIwRY7yMyyc4ym1nKMMh0MICkxLVmRR6x9vV6qLNN/u5vIvMe++3ndQVIJZyuwmos4gr
         sDqzpS9oS0pw6gk5z6t63FeyvpWEDFussXEOuqQfzirZhI9VsYHT3w5s3XB+M8ZoZEo0
         PmcLgfwl3GEZe8MtURGc3vMIVPu7sAhsmeILsbX4Y8YfH1spLcmdusD1GPt9bt5gYFp3
         1Yw1p0bMwIdoLTXlveYhQp6SxymBfOybLjv5GPyffx0jdLmyA47vBB0M/jmqI7Jh1dwe
         q/1g==
X-Gm-Message-State: APjAAAWHV34J4O0GhHWiiCiUUW7HzNCCjMecwT4+pPP96nr2AxCwuUzV
        kWNqyMV7ngnkXdooXJUnM7BjreXDUdJkPI7IE06tVg==
X-Google-Smtp-Source: APXvYqzxByzq/AQTMNLukvzgl8uHeE0kRyBV3BMGsLAkV9MPjR28LV1dliyRkslIwLB/JcomQc9DDlzZuSVfRIivLAQ=
X-Received: by 2002:a7b:cf12:: with SMTP id l18mr6801919wmg.66.1578692850299;
 Fri, 10 Jan 2020 13:47:30 -0800 (PST)
MIME-Version: 1.0
References: <87blznagrl.fsf@xmission.com> <1956727d-1ee8-92af-1e00-66ae4921b075@gmail.com>
 <87zhn6923n.fsf@xmission.com> <e407a8e7-7780-f08f-320a-a0f2c954d253@gmail.com>
 <20190529003601.GN374014@devbig004.ftw2.facebook.com> <e45d974b-5eff-f781-291f-ddf5e9679e4c@gmail.com>
 <20190530183556.GR374014@devbig004.ftw2.facebook.com> <20190530183637.GS374014@devbig004.ftw2.facebook.com>
 <20190530183700.GT374014@devbig004.ftw2.facebook.com> <20190607170952.GE30727@blackbody.suse.cz>
 <20190611185742.GH3341036@devbig004.ftw2.facebook.com>
In-Reply-To: <20190611185742.GH3341036@devbig004.ftw2.facebook.com>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Fri, 10 Jan 2020 13:47:19 -0800
Message-ID: <CAJuCfpGkAsmp5B=fNz38fLE8pYaMCG=uLDSSBFByNOtWD20zVQ@mail.gmail.com>
Subject: Re: [PATCH 3/3 cgroup/for-5.2-fixes] cgroup: Include dying leaders
 with live threads in PROCS iterations
To:     Tejun Heo <tj@kernel.org>
Cc:     =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
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

Hi Tejun,

On Tue, Jun 11, 2019 at 12:10 PM Tejun Heo <tj@kernel.org> wrote:
>
> Hello, Michal.
>
> On Fri, Jun 07, 2019 at 07:09:53PM +0200, Michal Koutn=C3=BD wrote:
> > Wouldn't it make more sense to call
> >       css_set_move_task(tsk, cset, NULL, false);
> > in cgroup_release instead of cgroup_exit then?
> >
> > css_set_move_task triggers the cgroup emptiness notification so if we
> > list group leaders with running siblings as members of the cgroup (IMO
> > correct), is it consistent to deliver the (un)populated event
> > that early?
> > By moving to cgroup_release we would also make this notification
> > analogous to SIGCHLD delivery.
>
> So, the current behavior is mostly historical and I don't think this
> is a better behavior.  That said, I'm not sure about the cost benefit
> ratio of changing the behavior at this point given how long the code
> has been this way.  Another aspect is that it'd expose zombie tasks
> and possibly migrations of them to each controller.

Sorry for reviving an old discussion but I got a bug report from a
customer about Android occasionally failing to remove a cgroup after
it killed all processes in it. AndroidManagerService (a privileged
user space process) reads cgroup.procs and sends SIGKILL to all listed
processes in that cgroup until cgroup.procs is empty at which point it
tries to delete cgroup directory (it is a leaf cgroup with empty
cgroup.procs). In my testing I was able to reproduce the failure in
which case rmdir() fails with EBUSY from cgroup_destroy_locked()
because cgroup_is_populated() returns true. cgroup_is_populated()
depends on cgrp->nr_populated_xxx counters which IIUC will not be
updated until cgroup_update_populated() is called from cgroup_exit()
and that might get delayed... Meanwhile the tasks counted by
cgrp->nr_populated_xxx will not show up when cgroup.procs or
cgroup.tasks/tasks files are read by user space due to these changes:

+               /* and dying leaders w/o live member threads */
+               if (!atomic_read(&task->signal->live))
+                       goto repeat;
+       } else {
+               /* skip all dying ones */
+               if (task->flags & PF_EXITING)
+                       goto repeat;
+       }

After removing these checks cgroup.procs shows the processes up until
they are dead and the issue is gone.

So from user space's point of view the cgroup is empty and can be
removed but rmdir() fails to do so. I think this behavior is
inconsistent with the claim "cgroup which doesn't have any children
and is associated only with zombie processes is considered empty and
can be removed" from
https://elixir.bootlin.com/linux/v5.4.10/source/Documentation/admin-guide/c=
group-v2.rst#L222
.

Before contemplating what would be the right fix here I wanted to
check if cgroup.procs being empty is a reasonable indication for user
space to assume the cgroup is empty and can be removed? I think it is
but I might be wrong.
Note that this behavior was reproduced on cgroup v1 hierarchy but I
think it will happen on v2 as well. If needed I can cook up a
reproducer.
Thanks,
Suren.

>
> Thanks.

>
> --
> tejun
