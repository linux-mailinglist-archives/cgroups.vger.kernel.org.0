Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E485C4F0D88
	for <lists+cgroups@lfdr.de>; Mon,  4 Apr 2022 04:34:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238927AbiDDCgW (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Sun, 3 Apr 2022 22:36:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230517AbiDDCgW (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Sun, 3 Apr 2022 22:36:22 -0400
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81E5827CF9;
        Sun,  3 Apr 2022 19:34:26 -0700 (PDT)
Received: by mail-qt1-x82a.google.com with SMTP id i4so6677828qti.7;
        Sun, 03 Apr 2022 19:34:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pet6Cd8QN+6E9l7Pe1i1Z7DRHGjXc6tw1i1GJeHwKHY=;
        b=V8puzvltQxJL9XxR1kuxmEAcD3nniE6lMtpldsHM3CWZnj98229LnpMFRFmvNCdLIc
         moyLXNsc9st9sioCsMmdz0/GGQN5Riv0xseZ+y8ddA++5tQPSYdT7lsO5AwpMUGQ+3fv
         aPu1D/FWGC/M8vNVOW0SsD/Vs6D+8Me3yL2uWFnAdFn+BqMwRyQtMlVetUXY93IofmU8
         xvWKhEoJr0Z9S5l7ikgVgk/iDFKvJvfhM1BFOSyWQVJsF7/79VzbpGnf8q/dIn1hDvqP
         whl+uX0h6pwSI2KO/KDgQ1ExFhL5orJ0O5YiOipx/C/A3DUaWPPyFGpZThuTalX3Lvf7
         T/tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pet6Cd8QN+6E9l7Pe1i1Z7DRHGjXc6tw1i1GJeHwKHY=;
        b=QRRZSZTy5GxTqWlCGTkvZwN1qosFChfoJ1XG5Q6UdaOcvF55t6RYTXaPqmDVL2Pfgv
         jqmWK+0XPD40g5viYIWkt4IR+OfaJOsTlXk4INB8dAqAj/gKNlKNlHl0uwuJ4s3bSieW
         JJFaapdBpO9LHH7srd7fAC2WlTZjPCnNhbvfEDI6SHjCFceNrPIe9Rn26ulISUL3Ajr1
         KA59w/QshoVLbd4w/FRfpNLxKqZjWYHePAIGMjMyx6zFl+pRkRIV2ZbvRGrJr9HV95x/
         ne1Z7utgpLCfg0u3AuUFcvQvCbgLQsH4eYdBADf0290lB9eXv8OtysH3crRMrtBE0vhl
         qpAw==
X-Gm-Message-State: AOAM531v7qdiDfMoqqpQhdBbs3HkAkldl/kBxQ8HAzQ5dB0VHW1ODmQm
        pMFYSQ8YmuIN2MC2X/KiYnQomKKXNRpSqziW4Wk=
X-Google-Smtp-Source: ABdhPJyAdARiOzxgBRjGfjOxZyVkyOhu8EUSQdQ140UXpKmWbiF4Mf5SGUwoCIVpjWRFagFwo5HlCRsi/sF1OOhz/5k=
X-Received: by 2002:a05:622a:1013:b0:2e1:c9c0:9831 with SMTP id
 d19-20020a05622a101300b002e1c9c09831mr15898965qte.245.1649039665610; Sun, 03
 Apr 2022 19:34:25 -0700 (PDT)
MIME-Version: 1.0
References: <1648713656-24254-1-git-send-email-zhaoyang.huang@unisoc.com>
 <YkVt0m+VxnXgnulq@dhcp22.suse.cz> <CAGWkznF4qb2EP3=xVamKO8qk08vaFg9JeHD7g80xvBfxm39Hkg@mail.gmail.com>
 <YkWR8t8yEe6xyzCM@dhcp22.suse.cz> <CAGWkznHxAD0757m1i1Csw1CVRDtQddfCL08dYf12fa47=-uYYQ@mail.gmail.com>
 <YkbjNYMY8VjHoSHR@dhcp22.suse.cz> <CAGWkznF7cSyPU0ceYwH6zweJzf-X1bQnS6AJ2-J+WEL0u8jzng@mail.gmail.com>
 <CAJuCfpHneDZMXO_MmQDPA+igAOdAPRUChiq+zftFXGfDzPHNhQ@mail.gmail.com>
In-Reply-To: <CAJuCfpHneDZMXO_MmQDPA+igAOdAPRUChiq+zftFXGfDzPHNhQ@mail.gmail.com>
From:   Zhaoyang Huang <huangzhaoyang@gmail.com>
Date:   Mon, 4 Apr 2022 10:33:58 +0800
Message-ID: <CAGWkznFTQCm0cusVxA_55fu2WfT-w2coVHrT=JA1D_9_2728mQ@mail.gmail.com>
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

On Sun, Apr 3, 2022 at 11:04 PM Suren Baghdasaryan <surenb@google.com> wrote:
>
> On Fri, Apr 1, 2022 at 10:18 PM Zhaoyang Huang <huangzhaoyang@gmail.com> wrote:
> >
> > On Fri, Apr 1, 2022 at 7:34 PM Michal Hocko <mhocko@suse.com> wrote:
> > >
> > > On Fri 01-04-22 09:34:02, Zhaoyang Huang wrote:
> > > > On Thu, Mar 31, 2022 at 7:35 PM Michal Hocko <mhocko@suse.com> wrote:
> > > > >
> > > > > On Thu 31-03-22 19:18:58, Zhaoyang Huang wrote:
> > > > > > On Thu, Mar 31, 2022 at 5:01 PM Michal Hocko <mhocko@suse.com> wrote:
> > > > > > >
> > > > > > > On Thu 31-03-22 16:00:56, zhaoyang.huang wrote:
> > > > > > > > From: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
> > > > > > > >
> > > > > > > > For some kind of memcg, the usage is varies greatly from scenarios. Such as
> > > > > > > > multimedia app could have the usage range from 50MB to 500MB, which generated
> > > > > > > > by loading an special algorithm into its virtual address space and make it hard
> > > > > > > > to protect the expanded usage without userspace's interaction.
> > > > > > >
> > > > > > > Do I get it correctly that the concern you have is that you do not know
> > > > > > > how much memory your workload will need because that depends on some
> > > > > > > parameters?
> > > > > > right. such as a camera APP will expand the usage from 50MB to 500MB
> > > > > > because of launching a special function(face beauty etc need special
> > > > > > algorithm)
> > > > > > >
> > > > > > > > Furthermore, fixed
> > > > > > > > memory.low is a little bit against its role of soft protection as it will response
> > > > > > > > any system's memory pressure in same way.
> > > > > > >
> > > > > > > Could you be more specific about this as well?
> > > > > > As the camera case above, if we set memory.low as 200MB to keep the
> > > > > > APP run smoothly, the system will experience high memory pressure when
> > > > > > another high load APP launched simultaneously. I would like to have
> > > > > > camera be reclaimed under this scenario.
> > > > >
> > > > > OK, so you effectivelly want to keep the memory protection when there is
> > > > > a "normal" memory pressure but want to relax the protection on other
> > > > > high memory utilization situations?
> > > > >
> > > > > How do you exactly tell a difference between a steady memory pressure
> > > > > (say stream IO on the page cache) from "high load APP launched"? Should
> > > > > you reduce the protection on the stram IO situation as well?
> > > > We can take either system's io_wait or PSI_IO into consideration for these.
> > >
> > > I do not follow. Let's say you have a stream IO workload which is mostly
> > > RO. Reclaiming those pages means effectivelly to drop them from the
> > > cache so there is no IO involved during the reclaim. This will generate
> > > a constant flow of reclaim that shouldn't normally affect other
> > > workloads (as long as kswapd keeps up with the IO pace). How does your
> > > scheme cope with this scenario? My understanding is that it will simply
> > > relax the protection.
> > You are right. This scheme treats the system's memory pressure
> > equally, no matter if it comes from in-kernel page allocation with
> > high order or cache drop by IO like things. The decay_factor composed
> > of PSI_SOME and PSI_FULL which represent the system is tight on
> > memory, every entity has the obligation to donate to solve this issue.
> > >
> > > > > [...]
> > > > > > > One very important thing that I am missing here is the overall objective of this
> > > > > > > tuning. From the above it seems that you want to (ab)use memory->low to
> > > > > > > protect some portion of the charged memory and that the protection
> > > > > > > shrinks over time depending on the the global PSI metrict and time.
> > > > > > > But why this is a good thing?
> > > > > > 'Good' means it meets my original goal of keeping the usage during a
> > > > > > period of time and responding to the system's memory pressure. For an
> > > > > > android like system, memory is almost forever being in a tight status
> > > > > > no matter how many RAM it has. What we need from memcg is more than
> > > > > > control and grouping, we need it to be more responsive to the system's
> > > > > > load and could  sacrifice its usage  under certain criteria.
> > > > >
> > > > > Why existing tools/APIs are insufficient for that? You can watch for
> > > > > both global and memcg memory pressure including PSI metrics and update
> > > > > limits dynamically. Why is it necessary to put such a logic into the
> > > > > kernel?
> > > > Poll and then React method in userspace requires a polling interval
> > > > and response time. Take PSI as an example, it polls ten times during
> > > > POLLING_INTERVAL while just report once, which introduce latency in
> > > > some extend.
> > >
> > > Do workload transitions happen so often in your situation that the
> > > interval really matters? As Suren already pointed out starting a new
> > > application is usually an explicit event which can pro-activelly update
> > > limits.
> > Yes. As my reply to Suren's comment, even a positive monitor service
> > which could be aware of the activity starting(APP launching etc) at
> > the very first time, has to 1. read PSI and memcg->watermark/usage 2.
> > make a decision. 3. write memcg->memory.low to adjust memory
> > allowance. Furthermore, monitors could not supervise the APP for whole
> > life time, while the reclaiming could arise at any time.
>
> Ok, sounds like you want this dynamic limit to be active all the time,
> not only at specific points in the process's life cycle.
Not sure yet. I think it would be better to cooperate with AMS like
things which could distinguish scenarios. Such as place
foreground/background processes into different memcgs with different
decay configurations OR dynamic set up the parameters to a specific
memcg.
> One thing that I don't understand in this approach is: why memory.low
> should depend on the system's memory pressure. It seems you want to
> allow a process to allocate more when memory pressure is high. That is
> very counter-intuitive to me. Could you please explain the underlying
> logic of why this is the right thing to do, without going into
> technical details?
What I want to achieve is make memory.low be positive correlation with
timing and negative to memory pressure, which means the protected
memcg should lower its protection(via lower memcg.low) for helping
system's memory pressure when it's high. The concept behind is memcg's
fault back of dropped memory is less important than system's latency
on high memory pressure. Please refer to my new version's test data
for more detail.
>
> >
> > > --
> > > Michal Hocko
> > > SUSE Labs
