Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E7484F13E6
	for <lists+cgroups@lfdr.de>; Mon,  4 Apr 2022 13:35:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237231AbiDDLhN (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 4 Apr 2022 07:37:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233165AbiDDLhN (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 4 Apr 2022 07:37:13 -0400
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com [IPv6:2607:f8b0:4864:20::730])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7217A3D1D5;
        Mon,  4 Apr 2022 04:35:17 -0700 (PDT)
Received: by mail-qk1-x730.google.com with SMTP id 1so7331867qke.1;
        Mon, 04 Apr 2022 04:35:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qm48wnLSa24puHCxxJ0e1Qe5gtn6QPwMgY9+Vycw7ig=;
        b=Ki+gCYwbS0XnQ5UhlqPCCi5C/H/hPmbA8WTAV8iHSC/oPkMxbbfr5ufUIJQvh9nj1i
         XCN/Wi+j7sh1PrPInyPGbJu5zCIY80Gfriv7q+IdRApbUkvSPn3aMNravOLC5GIKRUwl
         OfNTazXCkloY2UyAgYCq8ZwIAPfaWXToSKqA/3S7pjhQWgbTkqX3HSyVTknG9lMnugFJ
         HRpB4d4IwoyNiYzqewo/s4PVA6Ort+cs8Oj2H7qox2hHXoC9rVGnaFu5bXYDUzitT99z
         3DrHOw0r8yWErgJQ/g+1Mb6g86bvmWYMS6GC7TYvlvgWEQG17Z2FeElDO8q6TZ0HTvgE
         hH0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qm48wnLSa24puHCxxJ0e1Qe5gtn6QPwMgY9+Vycw7ig=;
        b=KAgTtQWtU4604vUHJDBdgeRvtDKZo+UeGw7uw3Hf0Pa3Ex0ZaCKHnL/tNj0CR1QX2a
         +A9HcSL1MG3d0/gLhrm+Gm+nT48tSu4CwLhDjOk8tGgvaicb7gU/E2zophtWmSnP0nQ7
         XIgFU7NX8e+J/X+MMeoVRPMzCAkExgcCWys9zV2+cCyQlunTIdL1EBu+xdWvfV7v7Ih3
         aoZfzM4qRGeg+N8zMsYzliIU6nedAN1GRzJ05qDdga7zmaO0DfAKM22P7XWxVwddnWMA
         WnvzN+xOj+ZD6QLfQj2p4AWJvWP8zsqv+P6iCiOeTegVp6CQ28i03jnyvrltQjaS9BHm
         eROA==
X-Gm-Message-State: AOAM533inRr4ySkfQ/EmvwNruqj/hJ9fZ38+UNhbBW3IAHkwctVFB1Vz
        hcw7TzZxPKDXVFtEH+E3Q62MyWea7fj9FwzAx6k=
X-Google-Smtp-Source: ABdhPJxfRY3HDCYw3miLPJVu8yAYK0vpS0RnLxCLR7sWI87lweGn7P71lMLm1l9RE/O8PZiw2PigCOYrbAcIPCxjy1g=
X-Received: by 2002:a05:620a:4586:b0:67e:d240:ed1d with SMTP id
 bp6-20020a05620a458600b0067ed240ed1dmr13123222qkb.630.1649072116559; Mon, 04
 Apr 2022 04:35:16 -0700 (PDT)
MIME-Version: 1.0
References: <YkWR8t8yEe6xyzCM@dhcp22.suse.cz> <CAGWkznHxAD0757m1i1Csw1CVRDtQddfCL08dYf12fa47=-uYYQ@mail.gmail.com>
 <YkbjNYMY8VjHoSHR@dhcp22.suse.cz> <CAGWkznF7cSyPU0ceYwH6zweJzf-X1bQnS6AJ2-J+WEL0u8jzng@mail.gmail.com>
 <CAJuCfpHneDZMXO_MmQDPA+igAOdAPRUChiq+zftFXGfDzPHNhQ@mail.gmail.com>
 <CAGWkznFTQCm0cusVxA_55fu2WfT-w2coVHrT=JA1D_9_2728mQ@mail.gmail.com>
 <YkqxpEW4m6iU3zMq@dhcp22.suse.cz> <CAGWkznG4L3w=9bpZp8TjyWHmqFyZQk-3m4xCZ96zhHCLPawBgQ@mail.gmail.com>
 <CAGWkznGMRohE2_at4Qh8KbwSqNmNqOAG2N1EM+7uE9wKqzRm0A@mail.gmail.com>
 <Ykq7KUleuAg5QnNU@dhcp22.suse.cz> <Ykq8IXstIKoW8JE2@dhcp22.suse.cz>
In-Reply-To: <Ykq8IXstIKoW8JE2@dhcp22.suse.cz>
From:   Zhaoyang Huang <huangzhaoyang@gmail.com>
Date:   Mon, 4 Apr 2022 19:35:05 +0800
Message-ID: <CAGWkznFTDhyUTennhOuD1iuMCgerLsfDwcJomDvPDjjHKk_wFQ@mail.gmail.com>
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

On Mon, Apr 4, 2022 at 5:36 PM Michal Hocko <mhocko@suse.com> wrote:
>
> On Mon 04-04-22 11:32:28, Michal Hocko wrote:
> > On Mon 04-04-22 17:23:43, Zhaoyang Huang wrote:
> > > On Mon, Apr 4, 2022 at 5:07 PM Zhaoyang Huang <huangzhaoyang@gmail.com> wrote:
> > > >
> > > > On Mon, Apr 4, 2022 at 4:51 PM Michal Hocko <mhocko@suse.com> wrote:
> > > > >
> > > > > On Mon 04-04-22 10:33:58, Zhaoyang Huang wrote:
> > > > > [...]
> > > > > > > One thing that I don't understand in this approach is: why memory.low
> > > > > > > should depend on the system's memory pressure. It seems you want to
> > > > > > > allow a process to allocate more when memory pressure is high. That is
> > > > > > > very counter-intuitive to me. Could you please explain the underlying
> > > > > > > logic of why this is the right thing to do, without going into
> > > > > > > technical details?
> > > > > > What I want to achieve is make memory.low be positive correlation with
> > > > > > timing and negative to memory pressure, which means the protected
> > > > > > memcg should lower its protection(via lower memcg.low) for helping
> > > > > > system's memory pressure when it's high.
> > > > >
> > > > > I have to say this is still very confusing to me. The low limit is a
> > > > > protection against external (e.g. global) memory pressure. Decreasing
> > > > > the protection based on the external pressure sounds like it goes right
> > > > > against the purpose of the knob. I can see reasons to update protection
> > > > > based on refaults or other metrics from the userspace but I still do not
> > > > > see how this is a good auto-magic tuning done by the kernel.
> > > > >
> > > > > > The concept behind is memcg's
> > > > > > fault back of dropped memory is less important than system's latency
> > > > > > on high memory pressure.
> > > > >
> > > > > Can you give some specific examples?
> > > > For both of the above two comments, please refer to the latest test
> > > > result in Patchv2 I have sent. I prefer to name my change as focus
> > > > transfer under pressure as protected memcg is the focus when system's
> > > > memory pressure is low which will reclaim from root, this is not
> > > > against current design. However, when global memory pressure is high,
> > > > then the focus has to be changed to the whole system, because it
> > > > doesn't make sense to let the protected memcg out of everybody, it
> > > > can't
> > > > do anything when the system is trapped in the kernel with reclaiming work.
> > > Does it make more sense if I describe the change as memcg will be
> > > protect long as system pressure is under the threshold(partially
> > > coherent with current design) and will sacrifice the memcg if pressure
> > > is over the threshold(added change)
> >
> > No, not really. For one it is still really unclear why there should be any
> > difference in the semantic between global and external memory pressure
> > in general. The low limit is always a protection from the external
> > pressure. And what should be the actual threshold? Amount of the reclaim
> > performed, effectivness of the reclaim or what?
>
> Btw. you might want to have a look at http://lkml.kernel.org/r/20220331084151.2600229-1-yosryahmed@google.com
> where a new interface to allow pro-active memory reclaim is discussed.
> I think that this might turn out to be a better fit then an automagic
> kernel manipulation with a low limit. It will require a user agent to
> drive the reclaim though.
Ok. But AFAIK, there are some of this kinds of method working as out
of tree code now. such as PPR in android etc. As I have replied to
Suren, there is always latency issue on this scheme as the agent
should poll the event/read current status/write to launch the action.
This patch is aiming at solve part of these issues.
> --
> Michal Hocko
> SUSE Labs
