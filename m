Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 239E479217
	for <lists+cgroups@lfdr.de>; Mon, 29 Jul 2019 19:29:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728908AbfG2R3E (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 29 Jul 2019 13:29:04 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:46917 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725934AbfG2R3E (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 29 Jul 2019 13:29:04 -0400
Received: by mail-qt1-f194.google.com with SMTP id h21so60316250qtn.13;
        Mon, 29 Jul 2019 10:29:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=udkUdoHD+/xDbjBugzOSQ54RdKcLOvg7mCBhGnLbrHY=;
        b=oh54sUbqobJwz9lD8GsJU9GCOWfnXwfAsAG3K9yMfohPeWmqap0o2gqLB8B0e1ky8U
         e37WLWqIOD4v3QcbJqyhfmeWrigLZi9lTlOFjRshdB47i0McihHUiSXOYW72erAwtW4h
         4iYG5Vr7nO39ZaUSHgdLVNVGU8KH4sndynjs91oJgtSid4bkhglmXffKyl834QaAngdA
         DvOzpuLJrSTw8N+ZfdutrFul1SB6i21Sh1z00FSZXNcN8yDkXB57LOljJuo6w3lWRwWv
         ICyERxp9m8QwB3gS882QmH14NabvmB3IbdMoSsfCm0Mu2j77FzN4DCmP5/f75wALlMW6
         ffaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=udkUdoHD+/xDbjBugzOSQ54RdKcLOvg7mCBhGnLbrHY=;
        b=jKhf5F7tgjfTduGKWiwMrZSQBbS9jF4TfVVWdeXn5wOKC/Y3E0/52a3cW+uYlfpjoy
         v+KB+NZLIi9L6yIXD7E2LAs2WCyf058o2hJcK0mz87hqw+ZOvFVntVessuAw+1cOu2z1
         FE4xw2bFzmSDQY2Hw28n+q4hKm2KQRMWL1qeQfYzSfC7nUtM60z6n4FxPmacC73tcdQe
         GULLSPAc+Txw8oUHDJLryjr4Fx5di128IOBtCaiKkUw4ZsuqEfUDqM6MEi1kMtq3mDMx
         DEfiM/6rPysnHFs26upu7UOsLme0xkDCYQ5kxF1Wj5IovqfftVHaZb+FYycEO+cKNGtu
         Mzcw==
X-Gm-Message-State: APjAAAUwjEfbU2vR64KgraL8FK7bJssivaU2EQwEnPKGnyGWcHU6DFYi
        FiNuHhRRm/BoHWv25R+dES9pS5kO90ruWOCTusg=
X-Google-Smtp-Source: APXvYqz19nEJwzZPl0Rc1pBiSuYwxF86on9CogNKuQGhaTvySkOxalyFhl01uTOEKTeFdMf1rKYufS3N7KlFpgwpIYQ=
X-Received: by 2002:a0c:ae50:: with SMTP id z16mr78170781qvc.60.1564421343160;
 Mon, 29 Jul 2019 10:29:03 -0700 (PDT)
MIME-Version: 1.0
References: <156431697805.3170.6377599347542228221.stgit@buzz>
 <20190729091738.GF9330@dhcp22.suse.cz> <3d6fc779-2081-ba4b-22cf-be701d617bb4@yandex-team.ru>
 <20190729103307.GG9330@dhcp22.suse.cz>
In-Reply-To: <20190729103307.GG9330@dhcp22.suse.cz>
From:   Yang Shi <shy828301@gmail.com>
Date:   Mon, 29 Jul 2019 10:28:43 -0700
Message-ID: <CAHbLzkrdj-O2uXwM8ujm90OcgjyR4nAiEbFtRGe7SOoY_fs=BA@mail.gmail.com>
Subject: Re: [PATCH RFC] mm/memcontrol: reclaim severe usage over high limit
 in get_user_pages loop
To:     Michal Hocko <mhocko@kernel.org>,
        Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
Cc:     Linux MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        cgroups@vger.kernel.org, Vladimir Davydov <vdavydov.dev@gmail.com>,
        Johannes Weiner <hannes@cmpxchg.org>
Content-Type: text/plain; charset="UTF-8"
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Mon, Jul 29, 2019 at 3:33 AM Michal Hocko <mhocko@kernel.org> wrote:
>
> On Mon 29-07-19 12:40:29, Konstantin Khlebnikov wrote:
> > On 29.07.2019 12:17, Michal Hocko wrote:
> > > On Sun 28-07-19 15:29:38, Konstantin Khlebnikov wrote:
> > > > High memory limit in memory cgroup allows to batch memory reclaiming and
> > > > defer it until returning into userland. This moves it out of any locks.
> > > >
> > > > Fixed gap between high and max limit works pretty well (we are using
> > > > 64 * NR_CPUS pages) except cases when one syscall allocates tons of
> > > > memory. This affects all other tasks in cgroup because they might hit
> > > > max memory limit in unhandy places and\or under hot locks.
> > > >
> > > > For example mmap with MAP_POPULATE or MAP_LOCKED might allocate a lot
> > > > of pages and push memory cgroup usage far ahead high memory limit.
> > > >
> > > > This patch uses halfway between high and max limits as threshold and
> > > > in this case starts memory reclaiming if mem_cgroup_handle_over_high()
> > > > called with argument only_severe = true, otherwise reclaim is deferred
> > > > till returning into userland. If high limits isn't set nothing changes.
> > > >
> > > > Now long running get_user_pages will periodically reclaim cgroup memory.
> > > > Other possible targets are generic file read/write iter loops.
> > >
> > > I do see how gup can lead to a large high limit excess, but could you be
> > > more specific why is that a problem? We should be reclaiming the similar
> > > number of pages cumulatively.
> > >
> >
> > Large gup might push usage close to limit and keep it here for a some time.
> > As a result concurrent allocations will enter direct reclaim right at
> > charging much more frequently.
>
> Yes, this is indeed prossible. On the other hand even the reclaim from
> the charge path doesn't really prevent from that happening because the
> context might get preempted or blocked on locks. So I guess we need a
> more detailed information of an actual world visible problem here.
>
> > Right now deferred recalaim after passing high limit works like distributed
> > memcg kswapd which reclaims memory in "background" and prevents completely
> > synchronous direct reclaim.
> >
> > Maybe somebody have any plans for real kswapd for memcg?
>
> I am not aware of that. The primary problem back then was that we simply
> cannot have a kernel thread per each memcg because that doesn't scale.
> Using kthreads and a dynamic pool of threads tends to be quite tricky -
> e.g. a proper accounting, scaling again.

We did discuss this topic in last year's LSF/MM, please see:
https://lwn.net/Articles/753162/. We (Alibaba) do have the memcg
kswapd thing work in our production environment for a while, and it
works well for our 11.11 shopping festival flood.

I did plan to post the patches to upstream, but I was distracted by
something else for a long time, now I already redesigned it and
already had some preliminary patches work, if you are interested in
this I would like post the patches soon to gather some comments early.

However, some of the issues mentioned by Michal does still exist, i.e.
accounting. I have not thought too much about accounting yet. I
recalled Johannes mentioned they were working on accounting kswapd
back then. But, I'm not sure if they are still working on that or not,
or he just meant some throttling solved by commit
2cf855837b89d92996cf264713f3bed2bf9b0b4f ("memcontrol: schedule
throttling if we are congested")? But, I recalled vaguely accounting
sounds not very critical.

I don't worry too much about scale since the scale issue is not unique
to background reclaim, direct reclaim may run into the same problem.
If you run into extreme memory pressure, a lot memcgs run into direct
relcaim and global reclaim is also running at the mean time, your
machine is definitely already not usable. And, our usecase is memcg
backgroup reclaim is mainly used by some latency sensitive memcgs
(running latency sensitive applications) to try to minimize direct
reclaim, for other memcgs they'd better be throttled by direct reclaim
if they consume too much memory.

Regards,
Yang

>
> > I've put mem_cgroup_handle_over_high in gup next to cond_resched() and
> > later that gave me idea that this is good place for running any
> > deferred works, like bottom half for tasks. Right now this happens
> > only at switching into userspace.
>
> I am not against pushing high memory reclaim into the charge path in
> principle. I just want to hear how big of a problem this really is in
> practice. If this is mostly a theoretical problem that might hit then I
> would rather stick with the existing code though.
>
> --
> Michal Hocko
> SUSE Labs
>
