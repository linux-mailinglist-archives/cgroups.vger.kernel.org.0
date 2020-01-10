Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E3F92137990
	for <lists+cgroups@lfdr.de>; Fri, 10 Jan 2020 23:14:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727185AbgAJWOd (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 10 Jan 2020 17:14:33 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:37107 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727183AbgAJWOc (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 10 Jan 2020 17:14:32 -0500
Received: by mail-wm1-f66.google.com with SMTP id f129so3547720wmf.2
        for <cgroups@vger.kernel.org>; Fri, 10 Jan 2020 14:14:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tIHbadlEEe6VqIeDYFiZTkUTW3gJ9MJi50LS331ICnE=;
        b=UW3D/eX/WbSjL5KWp3+hTOA9ef/dfVT4bFIT0eExsHPkvryTOMpo3XUKeDr6IaZd+Q
         EXBr1v+ADKym5QayjPcDFOEZoge9ajebqhToXncZPnLwUvfvIwSBnYkeNDEgr2liq9/8
         oiaU/5iMi10aGoqXAsw46U6N4F7c3TopzaiT9uC5d658FiCciYm4gbM4ZUwIHixe1yIE
         LvRDLLkSUoYLuV0lDB5hwwYV+i4rHnnLWTAJ0A+f1nZa9xJV2zMqJgFe6vCrrY69se/m
         uEWIyfr7mI4L/dR1F8mRZ8jEVyKpRq8AkTe0EBZtRkmvVRSAZRsgxrEwLFHIT5xYTB5g
         4FtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tIHbadlEEe6VqIeDYFiZTkUTW3gJ9MJi50LS331ICnE=;
        b=En5K7d7jhNb+6+RbwBlElo0lY9PJlFpU+dR16RBcWIkP31NT0/Qp4Le77EoAgKIkyu
         UG6WPZeodF4PtJ71ZKZgjmHZ0Gqj8JCpTfUe5fWUeraelYWXn17rhERaIrLgj4g9T1BO
         9/Y2XQICylKDSgb63Tr4HyGKNYDZFxBdq+Wd+ZCk6G9KOlGihk3aHHYH2+Cm5z0ztkPE
         nuHRrCtdcvGQotwjcZYbZTal23ORH/Ek/lKL+q8UjwQ7v2VWjz+Zf4WPtnhJxENoP9/x
         Jb11s2Sr4lzOZ4OnrhtU/8TisidklrNBZt98Pk2z/tWPm0F3MMTdbs2joAEXn/lB/KBU
         TtOw==
X-Gm-Message-State: APjAAAWBZq3TB/sd1j3NUXNBWcLqBKYABOluiTWpGQBtw8ghm12gpPs2
        GSO2Gm5a7WfPDD8mgNHwnNVBUpYJxZqh9tYXZR3EsA==
X-Google-Smtp-Source: APXvYqxQwfHKonCBBVKdXe9DbzN3cNlej9zC6rLOX8qRQZch9eSzKIZsly7XbbjKQukkGD9NYH2iLnUHZjwR+a+20dk=
X-Received: by 2002:a1c:964f:: with SMTP id y76mr6391692wmd.62.1578694470705;
 Fri, 10 Jan 2020 14:14:30 -0800 (PST)
MIME-Version: 1.0
References: <87zhn6923n.fsf@xmission.com> <e407a8e7-7780-f08f-320a-a0f2c954d253@gmail.com>
 <20190529003601.GN374014@devbig004.ftw2.facebook.com> <e45d974b-5eff-f781-291f-ddf5e9679e4c@gmail.com>
 <20190530183556.GR374014@devbig004.ftw2.facebook.com> <20190530183637.GS374014@devbig004.ftw2.facebook.com>
 <20190530183700.GT374014@devbig004.ftw2.facebook.com> <20190607170952.GE30727@blackbody.suse.cz>
 <20190611185742.GH3341036@devbig004.ftw2.facebook.com> <CAJuCfpGkAsmp5B=fNz38fLE8pYaMCG=uLDSSBFByNOtWD20zVQ@mail.gmail.com>
 <20200110215648.GC2677547@devbig004.ftw2.facebook.com>
In-Reply-To: <20200110215648.GC2677547@devbig004.ftw2.facebook.com>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Fri, 10 Jan 2020 14:14:19 -0800
Message-ID: <CAJuCfpHPRfV5KDM74JtDepdUJ2G+-3-A3XV+Fzr3Lkbj9nR-Cg@mail.gmail.com>
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
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Fri, Jan 10, 2020 at 1:56 PM Tejun Heo <tj@kernel.org> wrote:
>
> Hello,
>
> On Fri, Jan 10, 2020 at 01:47:19PM -0800, Suren Baghdasaryan wrote:
> > So from user space's point of view the cgroup is empty and can be
> > removed but rmdir() fails to do so. I think this behavior is
> > inconsistent with the claim "cgroup which doesn't have any children
> > and is associated only with zombie processes is considered empty and
> > can be removed" from
> > https://elixir.bootlin.com/linux/v5.4.10/source/Documentation/admin-guide/cgroup-v2.rst#L222
>
> Yeah, the current behavior isn't quite consistent with the
> documentation and what we prolly wanna do is allowing destroying a
> cgroup with only dead processes in it.  That said, the correct (or at
> least workable) signal which indicates that a cgroup is ready for
> removal is cgroup.events::populated being zero, which is a poll(2)able
> event.

Unfortunately it would not be workable for us as it's only available
for cgroup v2 controllers.
I can think of other ways to fix it in the userspace but there might
be other cgroup API users which are be broken after this change. I
would prefer to fix it in the kernel if at all possible rather than
chasing all possible users.
Thanks,
Suren.

>
> Thanks.
>
> --
> tejun
