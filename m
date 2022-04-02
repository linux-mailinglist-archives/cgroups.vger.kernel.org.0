Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 285CC4EFE29
	for <lists+cgroups@lfdr.de>; Sat,  2 Apr 2022 05:21:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237782AbiDBDXl (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 1 Apr 2022 23:23:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229999AbiDBDXh (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 1 Apr 2022 23:23:37 -0400
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com [IPv6:2607:f8b0:4864:20::834])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 655F81AD83;
        Fri,  1 Apr 2022 20:21:46 -0700 (PDT)
Received: by mail-qt1-x834.google.com with SMTP id bp39so3697041qtb.6;
        Fri, 01 Apr 2022 20:21:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jmwCIqyPXnCB8aA5w+kz04qMXqDkkG33h9HD7X6PkyE=;
        b=Es64RWPEOMaeUpsTBsp9QH8SB0bTj+XPwPQVv+sjmZQ1aJBaPnYGsq8c+Uy7XOMGtP
         LEsk1MmN8KAZ9r1EtKVWw7XQ54XW3BEEQGGAAN/xVyMstrKhZ03d6MBD7GhxYMiE2hwV
         my4S7GUbgUaEQ4ieOpwX7MorMufPrHPiQaoi3YOr/QUSdwLLCLkPu1iMoTtqmflRd441
         jQoboPhRpY28knGoYz++639zH09EBeFHXFLHv8uQ69pW83wM3Y5PNyqN9w8dRKAaMEH8
         GymvHjC6LcuOsiBTSZvemZIa3crKu9ddu09nOPbIu7IQe3Dw4xL45KBG1+5720KDS3tI
         AlPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jmwCIqyPXnCB8aA5w+kz04qMXqDkkG33h9HD7X6PkyE=;
        b=zS/Rrioq+gbZ2K7+oBFHDg0LguCHL4rgb1Er8yQOJ2bl6m3hi6sZD/Y+vEfF6/3MFx
         D2BWVpuJvOPSjUeNJ1TL2DuyvhK6AOih0EgpGgjgSx2OdvVKYzcKcfMtR1I27G3lXVeS
         kvYCuJFXVPbMQ+UDeS4B3bOwUcrTJd+5zHqPIrr0S04azwEu1AS0kKknKoBCMhgC8rqg
         zX0CIjLnvTQJSClCnkJ15VRZ3IIviehd41jGuwjFAVAasOYs6u34g9ZQ7bOIub+jMiv4
         JYU9S9VpCLSgXLcCKObI/3N8hDnYpEY5mUnUDfTC8emltgesfA8r8dgnnNjDi82vxpMA
         214A==
X-Gm-Message-State: AOAM533sTi+YoITqnqnKdeh8VLs975Y5T/j219JtWO5lG4afdBoLhB/j
        GljUGCJIBr0omfrRlViTx9aXc7iWeKTSiWjuwSGIirOdBdPUVA==
X-Google-Smtp-Source: ABdhPJzZUw7eKxiuUyP4w4PLhuAmsTpE+B+QsKzIKOPkf8rtTiuaQHiNwk70ehTZClxFoowef6RGMtugN/J3WmCs7ZI=
X-Received: by 2002:a05:622a:1013:b0:2e1:c9c0:9831 with SMTP id
 d19-20020a05622a101300b002e1c9c09831mr10709011qte.245.1648869705560; Fri, 01
 Apr 2022 20:21:45 -0700 (PDT)
MIME-Version: 1.0
References: <1648713656-24254-1-git-send-email-zhaoyang.huang@unisoc.com>
 <YkVt0m+VxnXgnulq@dhcp22.suse.cz> <CAGWkznF4qb2EP3=xVamKO8qk08vaFg9JeHD7g80xvBfxm39Hkg@mail.gmail.com>
 <YkWR8t8yEe6xyzCM@dhcp22.suse.cz> <CAJuCfpFgi+Dph-dcDAvGQXwgeZVDBhok1UQ3X5kxFEfPQnxSSg@mail.gmail.com>
 <CAGWkznHyAG1wZcUrGE4-amptT_MkSnpZCrDLy0vUWBm3z2cmJw@mail.gmail.com> <CAJuCfpEyDqiB2a+KqC1+Un0UJB1m3c0Aej6y3Umna3fdCPhvaQ@mail.gmail.com>
In-Reply-To: <CAJuCfpEyDqiB2a+KqC1+Un0UJB1m3c0Aej6y3Umna3fdCPhvaQ@mail.gmail.com>
From:   Zhaoyang Huang <huangzhaoyang@gmail.com>
Date:   Sat, 2 Apr 2022 11:21:18 +0800
Message-ID: <CAGWkznFZbz6TJM=kceTsNrAKu10_aXWf0=pbXXeNh3cCw7OJ4A@mail.gmail.com>
Subject: Re: [RFC PATCH] cgroup: introduce dynamic protection for memcg
To:     Suren Baghdasaryan <surenb@google.com>
Cc:     Michal Hocko <mhocko@suse.com>,
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

On Fri, Apr 1, 2022 at 12:46 PM Suren Baghdasaryan <surenb@google.com> wrote:
>
> On Thu, Mar 31, 2022 at 6:51 PM Zhaoyang Huang <huangzhaoyang@gmail.com> wrote:
> >
> > On Fri, Apr 1, 2022 at 3:26 AM Suren Baghdasaryan <surenb@google.com> wrote:
> > >
> > > On Thu, Mar 31, 2022 at 4:35 AM Michal Hocko <mhocko@suse.com> wrote:
> > > >
> > > > On Thu 31-03-22 19:18:58, Zhaoyang Huang wrote:
> > > > > On Thu, Mar 31, 2022 at 5:01 PM Michal Hocko <mhocko@suse.com> wrote:
> > > > > >
> > > > > > On Thu 31-03-22 16:00:56, zhaoyang.huang wrote:
> > > > > > > From: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
> > > > > > >
> > > > > > > For some kind of memcg, the usage is varies greatly from scenarios. Such as
> > > > > > > multimedia app could have the usage range from 50MB to 500MB, which generated
> > > > > > > by loading an special algorithm into its virtual address space and make it hard
> > > > > > > to protect the expanded usage without userspace's interaction.
> > > > > >
> > > > > > Do I get it correctly that the concern you have is that you do not know
> > > > > > how much memory your workload will need because that depends on some
> > > > > > parameters?
> > > > > right. such as a camera APP will expand the usage from 50MB to 500MB
> > > > > because of launching a special function(face beauty etc need special
> > > > > algorithm)
> > > > > >
> > > > > > > Furthermore, fixed
> > > > > > > memory.low is a little bit against its role of soft protection as it will response
> > > > > > > any system's memory pressure in same way.
> > > > > >
> > > > > > Could you be more specific about this as well?
> > > > > As the camera case above, if we set memory.low as 200MB to keep the
> > > > > APP run smoothly, the system will experience high memory pressure when
> > > > > another high load APP launched simultaneously. I would like to have
> > > > > camera be reclaimed under this scenario.
> > > >
> > > > OK, so you effectivelly want to keep the memory protection when there is
> > > > a "normal" memory pressure but want to relax the protection on other
> > > > high memory utilization situations?
> > > >
> > > > How do you exactly tell a difference between a steady memory pressure
> > > > (say stream IO on the page cache) from "high load APP launched"? Should
> > > > you reduce the protection on the stram IO situation as well?
> > >
> > > IIUC what you are implementing here is a "memory allowance boost"
> > > feature and it seems you are implementing it entirely inside the
> > > kernel, while only userspace knows when to apply this boost (say at
> > > app launch time). This does not make sense to me.
> > I am wondering if it could be more helpful to apply this patch on the
> > background services(system_server etc) than APP, while the latter ones
> > are persistent to the system.
> > >
> > > >
> > > > [...]
> > > > > > One very important thing that I am missing here is the overall objective of this
> > > > > > tuning. From the above it seems that you want to (ab)use memory->low to
> > > > > > protect some portion of the charged memory and that the protection
> > > > > > shrinks over time depending on the the global PSI metrict and time.
> > > > > > But why this is a good thing?
> > > > > 'Good' means it meets my original goal of keeping the usage during a
> > > > > period of time and responding to the system's memory pressure. For an
> > > > > android like system, memory is almost forever being in a tight status
> > > > > no matter how many RAM it has. What we need from memcg is more than
> > > > > control and grouping, we need it to be more responsive to the system's
> > > > > load and could  sacrifice its usage  under certain criteria.
> > > >
> > > > Why existing tools/APIs are insufficient for that? You can watch for
> > > > both global and memcg memory pressure including PSI metrics and update
> > > > limits dynamically. Why is it necessary to put such a logic into the
> > > > kernel?
> > >
> > > I had exactly the same thought while reading through this.
> > > In Android you would probably need to implement a userspace service
> > > which would temporarily relax the memcg limits when required, monitor
> > > PSI levels and adjust the limits accordingly.
> > As my response to Michal's comment. Userspace monitors introduce
> > latency. Take LMKD as an example, it is actually driven by the
> > PSI_POLL_PERIOD_XXX_MS after first wakeup, which means
> > PSI_WINDOW_SIZE_MS could be too big to rely on. IMHO, with regards to
> > the responding time, LMKD is less efficient than lmk driver but more
> > strong in strategy things. I would like to test this patch in real
> > android's work load and feedback in next version.
>
> LMKD is a reactive mechanism which does not know when memory pressure
> might rise, therefore its response latency matters.
> The usecases you mentioned seemed to imply that userspace was aware of
> increased memory demands of the process (app startup time, maybe the
> moment the app becomes foreground, etc.). Therefore the userspace
> could relax memory allowance before that memory is requested. Was my
> understanding incorrect?
In terms of Android specific scenarios, I think it is not the best
choice to have AMS relax memory allowance directly when activity
arised, as:
1. AMS also has to face latency issues like LMKD does when polling
systems PSI value
2. AMS needs to launch syscalls to act.  A read for either
memcg.usage/watermark and a write on memcg.min/low.
3. Processes in CACHED adj are not capable of shrinking themselves
except waiting to be killed by LMKD.

IMO, this patch is alike an Pressure Aware Per Process Reclaim which
does NOT launch real reclaiming.
>
> > >
> > > >
> > > > --
> > > > Michal Hocko
> > > > SUSE Labs
