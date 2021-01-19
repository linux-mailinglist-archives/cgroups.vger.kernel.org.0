Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 906072FBD00
	for <lists+cgroups@lfdr.de>; Tue, 19 Jan 2021 17:55:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390089AbhASQyp (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 19 Jan 2021 11:54:45 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:29500 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2390498AbhASQyg (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 19 Jan 2021 11:54:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1611075190;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=HK4nAJ3T6oXK1ONWdl9zHivMWs2pVZ45ipCqU6He5eg=;
        b=RtPi40MGQUp86aKT2ckSg14hsx22rAUhg2DaaduI/jj6Canc+zO8i9MbPoJDbQiEuIC/ux
        QVEw+98Ax5N5oPETveJvuqv/UwhPm+Uv70qUT7FXDUH/7f8iCF2531ypb7R2jqIjC67G1E
        dmmULZUNZnlsqMc7K/CPhuB2uvhP4tE=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-384-ZoG4JC-HO-mXY53_JHRHbw-1; Tue, 19 Jan 2021 11:53:08 -0500
X-MC-Unique: ZoG4JC-HO-mXY53_JHRHbw-1
Received: by mail-lj1-f198.google.com with SMTP id s18so5271158ljp.7
        for <cgroups@vger.kernel.org>; Tue, 19 Jan 2021 08:53:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HK4nAJ3T6oXK1ONWdl9zHivMWs2pVZ45ipCqU6He5eg=;
        b=rr/Aes6vHfRjf7bsKapGPIIlqFukJGFf+Q1acDtTNuoZCs+L/ablZilz2CjZ6ts2Na
         D6Am4C32sjYhz0T8x6JFdx0ajYQa3GRVwNOQN0qR0uaPJAMhvWyIGSFOo30JEnNlkKiz
         wXY2xh1YzAiflWm0xKJHFrADVwQVgbM+hRR+HuGKTojMjBdfNjH7wORIs6nCVHjCil1F
         jEYV+AX+y31QfeXKH2rr8IRkxJ+wrDNXmavY/3nuCctREV6cyfeDOvNyBmJIh3JACLMt
         RkGVZ+nLF6HoJLs/XymyjekI94YxTOpoW/mvfO5opaC4F01IsVG3250dbu67MoGSQfRW
         0VeQ==
X-Gm-Message-State: AOAM531TjUvJob7+XhCXNuoXJ45DMb9LvSpc+27tEZVfY5b5JOVm1+SU
        a5Y6EarBXZ2PPEUy7xe3bQIpkogOIaOg7/TJtfG0L/qLo1eB6kmELk4XDHKFeO8P233g5/GRD+b
        0Jf3mgmo2q33ZrYh0HOCW9Y+2t+q6N1z4Dw==
X-Received: by 2002:a19:58a:: with SMTP id 132mr2288982lff.355.1611075186343;
        Tue, 19 Jan 2021 08:53:06 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyI3Q9N/A/K+bU3g9xUudRjbeGxYzhCCeDbwHeLDGBbfnqurDrSLN/JZZ3wEwt/vd6EIC8VtwC1NVoTsV0EYc4=
X-Received: by 2002:a19:58a:: with SMTP id 132mr2288974lff.355.1611075186136;
 Tue, 19 Jan 2021 08:53:06 -0800 (PST)
MIME-Version: 1.0
References: <20201203171431.256675-1-aklimov@redhat.com> <20201207083827.GD3040@hirez.programming.kicks-ass.net>
 <87k0tritvq.fsf@oracle.com> <87im7yc2bu.fsf@oracle.com>
In-Reply-To: <87im7yc2bu.fsf@oracle.com>
From:   Alexey Klimov <aklimov@redhat.com>
Date:   Tue, 19 Jan 2021 16:52:55 +0000
Message-ID: <CAFBcO+_PoXhbq+p-2z=acCpboJtOewXkp-9-3=csafoAYuNFQw@mail.gmail.com>
Subject: Re: [RFC][PATCH] cpu/hotplug: wait for cpuset_hotplug_work to finish
 on cpu online
To:     Daniel Jordan <daniel.m.jordan@oracle.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        yury.norov@gmail.com, tglx@linutronix.de, jobaker@redhat.com,
        audralmitchel@gmail.com, arnd@arndb.de, gregkh@linuxfoundation.org,
        rafael@kernel.org, tj@kernel.org, lizefan.x@bytedance.com,
        qais.yousef@arm.com, hannes@cmpxchg.org,
        Alexey Klimov <klimov.linux@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Fri, Jan 15, 2021 at 6:54 AM Daniel Jordan
<daniel.m.jordan@oracle.com> wrote:
>
> Daniel Jordan <daniel.m.jordan@oracle.com> writes:
> > Peter Zijlstra <peterz@infradead.org> writes:
> >>> The nature of this bug is also described here (with different consequences):
> >>> https://lore.kernel.org/lkml/20200211141554.24181-1-qais.yousef@arm.com/
> >>
> >> Yeah, pesky deadlocks.. someone was going to try again.
> >
> > I dug up the synchronous patch
> >
> >     https://lore.kernel.org/lkml/1579878449-10164-1-git-send-email-prsood@codeaurora.org/
> >
> > but surprisingly wasn't able to reproduce the lockdep splat from
> >
> >     https://lore.kernel.org/lkml/F0388D99-84D7-453B-9B6B-EEFF0E7BE4CC@lca.pw/
> >
> > even though I could hit it a few weeks ago.
>
> oh okay, you need to mount a legacy cpuset hierarchy.
>
> So as the above splat shows, making cpuset_hotplug_workfn() synchronous
> means cpu_hotplug_lock (and "cpuhp_state-down") can be acquired before
> cgroup_mutex.
>
> But there are at least four cgroup paths that take the locks in the
> opposite order.  They're all the same, they take cgroup_mutex and then
> cpu_hotplug_lock later on to modify one or more static keys.
>
> cpu_hotplug_lock should probably be ahead of cgroup_mutex because the
> latter is taken in a hotplug callback, and we should keep the static
> branches in cgroup, so the only way out I can think of is moving
> cpu_hotplug_lock to just before cgroup_mutex is taken and switching to
> _cpuslocked flavors of the static key calls.
>
> lockdep quiets down with that change everywhere, but it puts another big
> lock around a lot of cgroup paths.  Seems less heavyhanded to go with
> this RFC.  What do you all think?

Daniel, thank you for taking a look. I don't mind reviewing+testing
another approach that you described.

> Absent further discussion, Alexey, do you plan to post another version?

I plan to update this patch and re-send in the next couple of days. It
looks like it might be a series of two patches. Sorry for delays.

Best regards,
Alexey

