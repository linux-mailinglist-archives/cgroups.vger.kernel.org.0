Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 920454F13C1
	for <lists+cgroups@lfdr.de>; Mon,  4 Apr 2022 13:23:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238463AbiDDLZL (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 4 Apr 2022 07:25:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235756AbiDDLZL (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 4 Apr 2022 07:25:11 -0400
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com [IPv6:2607:f8b0:4864:20::82d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43E4626569;
        Mon,  4 Apr 2022 04:23:15 -0700 (PDT)
Received: by mail-qt1-x82d.google.com with SMTP id t2so7342837qtw.9;
        Mon, 04 Apr 2022 04:23:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uTEQc40WAUSwoIQpKgQjJIExKC4lQtRNhQFFG5ZkcD4=;
        b=pSQrIEqHbVdTq/rz7ZjoIHJeXGubsbHAjJLdZQp8l5AlsVTZJ+zGV6P/H00sP5zGjo
         q+P5rRL6Xf1ojgtC3ksx1Ef8i2OuaW6hN5Xvmhv81HeIWyvZeivSRdnL27IsTVbg6i3O
         9B3re0wo1wSl/8BcUSuX4LVgJRfaDdhN6r87xtLvideB2JC7a+DPgCUTNGgGwOjgRVyW
         Zvxxz7gIeRHEVgHhHIX7quhCuYkWirUKgloE0bw5kmWIex1c1AUdUPNaRxvptrxfhIvR
         QjWrwJZu5C4IjXkkouQaycFHjCIqdJbz9C21zz2s0nyXkEv6veEazyX+AXCVSnLXMhE4
         b+Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uTEQc40WAUSwoIQpKgQjJIExKC4lQtRNhQFFG5ZkcD4=;
        b=VWFV7Oec/fVIBxUwQvEbgsaAms7lflUJWSTLNvao/SyJeCQg0r71BJ8+DAuCj+pI+9
         0bzl32qa5D6NiGvC53Le49fUXGvs3jz5861V+4sp2Lx7xp9amVNm9jjBaMc1tfKqQcJL
         9f9x53GedjY8qd+gr2mX87g6/x9gAqpEP+Q0Brd0EfqB7V9FXPCcz9DU2eLptxokv/+Q
         atXRIpC2lmG/W1CAkPryx2gtaHhE6R7o8n3yQqazC50TX0z4y/ppTQyF5lEw67asTXHS
         EhfNZ1cNR2XVI9NEdGUVreZaXwnc3UjHaP5vrLLW/MtN9r8XOCPJNJ5TTu73+pd+WYxz
         P9RQ==
X-Gm-Message-State: AOAM531mrDgYtTjdALUulziKls8dZAJluG0/JfSQaA/KaNX7ehFUL5FK
        kzWvlOuQ2qvwGYklxCcMmbUCOV/3vStMpJU+rfI=
X-Google-Smtp-Source: ABdhPJwsqMcUrJ8a8kJxjin3FIFKsyMPd5nCbkXKV5uDt5pycXdxclS9X6RJOkF7HV24PAyV8hVuJ5+fhP+GvaC6fM4=
X-Received: by 2002:a05:622a:1999:b0:2e2:2928:db7d with SMTP id
 u25-20020a05622a199900b002e22928db7dmr17447404qtc.160.1649071394354; Mon, 04
 Apr 2022 04:23:14 -0700 (PDT)
MIME-Version: 1.0
References: <CAGWkznF4qb2EP3=xVamKO8qk08vaFg9JeHD7g80xvBfxm39Hkg@mail.gmail.com>
 <YkWR8t8yEe6xyzCM@dhcp22.suse.cz> <CAGWkznHxAD0757m1i1Csw1CVRDtQddfCL08dYf12fa47=-uYYQ@mail.gmail.com>
 <YkbjNYMY8VjHoSHR@dhcp22.suse.cz> <CAGWkznF7cSyPU0ceYwH6zweJzf-X1bQnS6AJ2-J+WEL0u8jzng@mail.gmail.com>
 <CAJuCfpHneDZMXO_MmQDPA+igAOdAPRUChiq+zftFXGfDzPHNhQ@mail.gmail.com>
 <CAGWkznFTQCm0cusVxA_55fu2WfT-w2coVHrT=JA1D_9_2728mQ@mail.gmail.com>
 <YkqxpEW4m6iU3zMq@dhcp22.suse.cz> <CAGWkznG4L3w=9bpZp8TjyWHmqFyZQk-3m4xCZ96zhHCLPawBgQ@mail.gmail.com>
 <CAGWkznGMRohE2_at4Qh8KbwSqNmNqOAG2N1EM+7uE9wKqzRm0A@mail.gmail.com> <Ykq7KUleuAg5QnNU@dhcp22.suse.cz>
In-Reply-To: <Ykq7KUleuAg5QnNU@dhcp22.suse.cz>
From:   Zhaoyang Huang <huangzhaoyang@gmail.com>
Date:   Mon, 4 Apr 2022 19:23:03 +0800
Message-ID: <CAGWkznGbd5TOTHZE8uUhak3SnHqEWx_9QCJVtUFUSg9rk3xYEQ@mail.gmail.com>
Subject: Re: [RFC PATCH] cgroup: introduce dynamic protection for memcg
To:     Michal Hocko <mhocko@suse.com>
Cc:     Suren Baghdasaryan <surenb@google.com>,
        "zhaoyang.huang" <zhaoyang.huang@unisoc.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        "open list:MEMORY MANAGEMENT" <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        cgroups mailinglist <cgroups@vger.kernel.org>,
        Ke Wang <ke.wang@unisoc.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Mon, Apr 4, 2022 at 5:32 PM Michal Hocko <mhocko@suse.com> wrote:
>
> On Mon 04-04-22 17:23:43, Zhaoyang Huang wrote:
> > On Mon, Apr 4, 2022 at 5:07 PM Zhaoyang Huang <huangzhaoyang@gmail.com> wrote:
> > >
> > > On Mon, Apr 4, 2022 at 4:51 PM Michal Hocko <mhocko@suse.com> wrote:
> > > >
> > > > On Mon 04-04-22 10:33:58, Zhaoyang Huang wrote:
> > > > [...]
> > > > > > One thing that I don't understand in this approach is: why memory.low
> > > > > > should depend on the system's memory pressure. It seems you want to
> > > > > > allow a process to allocate more when memory pressure is high. That is
> > > > > > very counter-intuitive to me. Could you please explain the underlying
> > > > > > logic of why this is the right thing to do, without going into
> > > > > > technical details?
> > > > > What I want to achieve is make memory.low be positive correlation with
> > > > > timing and negative to memory pressure, which means the protected
> > > > > memcg should lower its protection(via lower memcg.low) for helping
> > > > > system's memory pressure when it's high.
> > > >
> > > > I have to say this is still very confusing to me. The low limit is a
> > > > protection against external (e.g. global) memory pressure. Decreasing
> > > > the protection based on the external pressure sounds like it goes right
> > > > against the purpose of the knob. I can see reasons to update protection
> > > > based on refaults or other metrics from the userspace but I still do not
> > > > see how this is a good auto-magic tuning done by the kernel.
> > > >
> > > > > The concept behind is memcg's
> > > > > fault back of dropped memory is less important than system's latency
> > > > > on high memory pressure.
> > > >
> > > > Can you give some specific examples?
> > > For both of the above two comments, please refer to the latest test
> > > result in Patchv2 I have sent. I prefer to name my change as focus
> > > transfer under pressure as protected memcg is the focus when system's
> > > memory pressure is low which will reclaim from root, this is not
> > > against current design. However, when global memory pressure is high,
> > > then the focus has to be changed to the whole system, because it
> > > doesn't make sense to let the protected memcg out of everybody, it
> > > can't
> > > do anything when the system is trapped in the kernel with reclaiming work.
> > Does it make more sense if I describe the change as memcg will be
> > protect long as system pressure is under the threshold(partially
> > coherent with current design) and will sacrifice the memcg if pressure
> > is over the threshold(added change)
>
> No, not really. For one it is still really unclear why there should be any
> difference in the semantic between global and external memory pressure
> in general. The low limit is always a protection from the external
> pressure. And what should be the actual threshold? Amount of the reclaim
> performed, effectivness of the reclaim or what?
Please find bellowing for the test result, which shows current design
has more effective protection when system memory pressure is high. It
could be argued that the protected memcg lost the protection as its
usage dropped too much. I would like to say that this is just the goal
of the change. Is it reasonable to let the whole system be trapped in
memory pressure while the memcg holds the memory? With regard to
threshold, it is a dynamic decayed watermark value which represents
the historic(watermark) and present(update to new usage if it expands
again) usage. Actually, I have update the code by adding opt-in code
which means this is a opt type of the memcg. This patch is coherent to
the original design if user want to set the fixed value by default and
also provide a new way of dynamic protected memcg without external
monitor and interactivation.

We simply test above change by comparing it with current design on a v5.4 based
system in 3GB RAM in bellowing steps, via which we can find that fixed
memory.low have the system experience high memory pressure with holding too
much memory.

1. setting up the topology seperatly as [1]
2. place a memory cost process into B and have it consume 1GB memory
from userspace.
3. generating global memory pressure via mlock 1GB memory.
4. watching B's memory.current and PSI_MEM.
5. repeat 3,4 twice.

[1]. setting fixed low=500MB; low=600MB; wm_decay_factor=36(68s decay 1/2)
      A(low=500MB)
     /
    B(low=500MB)

What we observed are:

                    PSI_MEM, usage             PSI_MEM,usage
PSI_MEM,usage
                    (Mlock 1GB)                    (Mlock 2GB)
     (stable)
low=600MB   s=23 f=17 u=720/600MB   s=91 f=48 u=202MB   s=68 f=32 u=106MB
low=500MB   s=22 f=13 u=660/530MB   s=88 f=50 u=156MB   s=30 f=20 u=120MB
patch            s=23 f=12 u=692/470MB   s=40 f=23 u=67MB     s=21 f=18 u=45MB

> --
> Michal Hocko
> SUSE Labs
