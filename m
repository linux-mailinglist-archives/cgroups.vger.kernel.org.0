Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D84714F159C
	for <lists+cgroups@lfdr.de>; Mon,  4 Apr 2022 15:14:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231879AbiDDNQu (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 4 Apr 2022 09:16:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231190AbiDDNQt (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 4 Apr 2022 09:16:49 -0400
Received: from mail-qv1-xf30.google.com (mail-qv1-xf30.google.com [IPv6:2607:f8b0:4864:20::f30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B86AA3CA50;
        Mon,  4 Apr 2022 06:14:52 -0700 (PDT)
Received: by mail-qv1-xf30.google.com with SMTP id ke15so7362201qvb.11;
        Mon, 04 Apr 2022 06:14:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EfcDbIWE4C09Ui7idn4jzEzRWfLd4paXbUSuIemqKOA=;
        b=gSDgBRylKxsRAEp6XTStLrJPzJ9SodJ1Zq8Tutv3fh3wMrV8+3uIfYthV5WBGwu/Q8
         hTl6FKXkSsOW7Oj0bFpjN7MsOQHTD+k7sNG8cNTL8uGU+YCbopXN3nRE8PR27xpRXLEi
         ymsDDDUmRU5MVmmjW8YUVcjd/olS2pRTvhHUzH5aspbfR9PPzgFdywzNs+wBuyXLDcQO
         A/gSuxVivZXkwIg+rwy38rN+aAxrP1+YTB28euSkUXE32Am9C3zUJvXmbtfq+d8gZIa2
         P+a9QDSpnmn/YRB0IwCMzaUos9mh0zvj4wJrLayczPpOV6CIGNh8aA+CkkhD5diE9OHx
         QDAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EfcDbIWE4C09Ui7idn4jzEzRWfLd4paXbUSuIemqKOA=;
        b=GnyftacOzCUvVOwy9QkZKuCW4qVgy59TM+ETYJ5iw5fQmll/T947k16wI6hC392rF4
         fbah8wL2sJdpfzTiWoYwI6iYcUqEyAwiIVnu9Y0vAcYyq3betJWV1KiiywpBf4hGajZG
         KgYP2slYYMpL30oHBTZvLfOXAAVNHVgobklf6lhRCIzxOr90fHlMn66dQ1IsQBm76u1v
         gXnKGhnnOnJGRzq9AWS9buSazVMUz8ldZSPalwQSBArGL/6uvynMEPZWem+bRZRp5tl3
         srrJUF57/n/dwWI3FftxOcEUoGr/7wdU4K3dlLveo4EWJEFe22P3nnkkKvbXjNbcnued
         YxAQ==
X-Gm-Message-State: AOAM533Hze1fGB4en6jUKWcnmztekw07AmeIhGJN12TviecMFn66BJTL
        AFqyoQMiEdnQGrxvmjAYB630UVPYMhDa3aB1Pig=
X-Google-Smtp-Source: ABdhPJzD8SmejalWKXKkrcFzAXRiyjlyGtncJf6UQpUZbkW+zW+9S3sJml0FCViZzyDSv1wkBhqCBjYEpkCY7CvJNfs=
X-Received: by 2002:a05:6214:d42:b0:440:d56b:4233 with SMTP id
 2-20020a0562140d4200b00440d56b4233mr16604985qvr.15.1649078091785; Mon, 04 Apr
 2022 06:14:51 -0700 (PDT)
MIME-Version: 1.0
References: <CAGWkznHxAD0757m1i1Csw1CVRDtQddfCL08dYf12fa47=-uYYQ@mail.gmail.com>
 <YkbjNYMY8VjHoSHR@dhcp22.suse.cz> <CAGWkznF7cSyPU0ceYwH6zweJzf-X1bQnS6AJ2-J+WEL0u8jzng@mail.gmail.com>
 <CAJuCfpHneDZMXO_MmQDPA+igAOdAPRUChiq+zftFXGfDzPHNhQ@mail.gmail.com>
 <CAGWkznFTQCm0cusVxA_55fu2WfT-w2coVHrT=JA1D_9_2728mQ@mail.gmail.com>
 <YkqxpEW4m6iU3zMq@dhcp22.suse.cz> <CAGWkznG4L3w=9bpZp8TjyWHmqFyZQk-3m4xCZ96zhHCLPawBgQ@mail.gmail.com>
 <CAGWkznGMRohE2_at4Qh8KbwSqNmNqOAG2N1EM+7uE9wKqzRm0A@mail.gmail.com>
 <Ykq7KUleuAg5QnNU@dhcp22.suse.cz> <CAGWkznGbd5TOTHZE8uUhak3SnHqEWx_9QCJVtUFUSg9rk3xYEQ@mail.gmail.com>
 <Ykrkx4JML4c81gBV@dhcp22.suse.cz>
In-Reply-To: <Ykrkx4JML4c81gBV@dhcp22.suse.cz>
From:   Zhaoyang Huang <huangzhaoyang@gmail.com>
Date:   Mon, 4 Apr 2022 21:14:40 +0800
Message-ID: <CAGWkznEaEavCz9GeiYuTqsox2qZK43iQKevt8njkzaHv6KiW-A@mail.gmail.com>
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

On Mon, Apr 4, 2022 at 8:30 PM Michal Hocko <mhocko@suse.com> wrote:
>
> On Mon 04-04-22 19:23:03, Zhaoyang Huang wrote:
> > On Mon, Apr 4, 2022 at 5:32 PM Michal Hocko <mhocko@suse.com> wrote:
> > >
> > > On Mon 04-04-22 17:23:43, Zhaoyang Huang wrote:
> > > > On Mon, Apr 4, 2022 at 5:07 PM Zhaoyang Huang <huangzhaoyang@gmail.com> wrote:
> > > > >
> > > > > On Mon, Apr 4, 2022 at 4:51 PM Michal Hocko <mhocko@suse.com> wrote:
> > > > > >
> > > > > > On Mon 04-04-22 10:33:58, Zhaoyang Huang wrote:
> > > > > > [...]
> > > > > > > > One thing that I don't understand in this approach is: why memory.low
> > > > > > > > should depend on the system's memory pressure. It seems you want to
> > > > > > > > allow a process to allocate more when memory pressure is high. That is
> > > > > > > > very counter-intuitive to me. Could you please explain the underlying
> > > > > > > > logic of why this is the right thing to do, without going into
> > > > > > > > technical details?
> > > > > > > What I want to achieve is make memory.low be positive correlation with
> > > > > > > timing and negative to memory pressure, which means the protected
> > > > > > > memcg should lower its protection(via lower memcg.low) for helping
> > > > > > > system's memory pressure when it's high.
> > > > > >
> > > > > > I have to say this is still very confusing to me. The low limit is a
> > > > > > protection against external (e.g. global) memory pressure. Decreasing
> > > > > > the protection based on the external pressure sounds like it goes right
> > > > > > against the purpose of the knob. I can see reasons to update protection
> > > > > > based on refaults or other metrics from the userspace but I still do not
> > > > > > see how this is a good auto-magic tuning done by the kernel.
> > > > > >
> > > > > > > The concept behind is memcg's
> > > > > > > fault back of dropped memory is less important than system's latency
> > > > > > > on high memory pressure.
> > > > > >
> > > > > > Can you give some specific examples?
> > > > > For both of the above two comments, please refer to the latest test
> > > > > result in Patchv2 I have sent. I prefer to name my change as focus
> > > > > transfer under pressure as protected memcg is the focus when system's
> > > > > memory pressure is low which will reclaim from root, this is not
> > > > > against current design. However, when global memory pressure is high,
> > > > > then the focus has to be changed to the whole system, because it
> > > > > doesn't make sense to let the protected memcg out of everybody, it
> > > > > can't
> > > > > do anything when the system is trapped in the kernel with reclaiming work.
> > > > Does it make more sense if I describe the change as memcg will be
> > > > protect long as system pressure is under the threshold(partially
> > > > coherent with current design) and will sacrifice the memcg if pressure
> > > > is over the threshold(added change)
> > >
> > > No, not really. For one it is still really unclear why there should be any
> > > difference in the semantic between global and external memory pressure
> > > in general. The low limit is always a protection from the external
> > > pressure. And what should be the actual threshold? Amount of the reclaim
> > > performed, effectivness of the reclaim or what?
> > Please find bellowing for the test result, which shows current design
> > has more effective protection when system memory pressure is high. It
> > could be argued that the protected memcg lost the protection as its
> > usage dropped too much.
>
> Yes, this is exactly how I do see it. The memory low/min is a
> clear decision of the administrator to protect the memory consumption of
> the said memcg (or hierarchy) from external memory pressure.
Please be noticed that this patch DOES protect the memcg when external
pressure is 1GB as fixed low does. Besides, how does the admin decide
the exact number of low/min if it expand from small to even xGB in a
quick changing scenario?
>
> > I would like to say that this is just the goal
> > of the change. Is it reasonable to let the whole system be trapped in
> > memory pressure while the memcg holds the memory?
>
> I would argue that this is expected and reasonable indeed. You cannot
> provide a protection withtout pushing the pressure to others. The memory
> is a finite resource.
Imagin you are playing a game on a 3GB mobile phone while a visual
call is connected. There could be either a dead view of the call
because of the game possess a improper low value or the game be killed
by OOM. IMHO, could we let the user have the choice to configure the
memcg as dynamic protection.
>
> > With regard to
> > threshold, it is a dynamic decayed watermark value which represents
> > the historic(watermark) and present(update to new usage if it expands
> > again) usage. Actually, I have update the code by adding opt-in code
> > which means this is a opt type of the memcg. This patch is coherent to
> > the original design if user want to set the fixed value by default and
> > also provide a new way of dynamic protected memcg without external
> > monitor and interactivation.
>
> The more I read here to more I am convinced that hooking into low/min
> limits is simply wrong. If you want to achieve a more "clever" way to
> balance memory reclaim among existing memcgs then fine but trying to
> achieve that by dynamically interpreting low limits is just an abuse of
> an existing interface IMO. What has led you to (ab)use low limit in the
> first place?
>
> > We simply test above change by comparing it with current design on a v5.4 based
> > system in 3GB RAM in bellowing steps, via which we can find that fixed
> > memory.low have the system experience high memory pressure with holding too
> > much memory.
> >
> > 1. setting up the topology seperatly as [1]
> > 2. place a memory cost process into B and have it consume 1GB memory
> > from userspace.
> > 3. generating global memory pressure via mlock 1GB memory.
> > 4. watching B's memory.current and PSI_MEM.
> > 5. repeat 3,4 twice.
>
> This is effectively an OOM test, isn't it? Memory low protection will
> be enforced as long as there is something reclaimable but your memory
> pressure is unreclaimable due to mlock so it has a stronger guarantee
> than low limit so the protected memcg is going to be reclaimed.
Mlock is for the purpose of easy for test. High pressure could be
introduced by file cache thrashing(mapped so file would have very
short refault distance) or kernel driver allocation(multimedia or AI
scenarios on android). I will retest it without Mlock then.
>
> Maybe I am just not following but this makes less and less sense as I am
> reading through. So either I am missing something really significant or
> we are just not on the same page.
As I said, I would like to have this patch provide a opt-in choice for
user to establish a kind of desired memcg while bring any change of
current design.
> --
> Michal Hocko
> SUSE Labs
