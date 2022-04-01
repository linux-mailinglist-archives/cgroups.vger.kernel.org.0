Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A1DC4EE5D1
	for <lists+cgroups@lfdr.de>; Fri,  1 Apr 2022 03:51:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229572AbiDABxj (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 31 Mar 2022 21:53:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243869AbiDABxi (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 31 Mar 2022 21:53:38 -0400
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C5B82571B9;
        Thu, 31 Mar 2022 18:51:50 -0700 (PDT)
Received: by mail-qt1-x835.google.com with SMTP id 10so1070210qtz.11;
        Thu, 31 Mar 2022 18:51:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5dbe41dvMeibhzpqOSIQnkhPlg4dZw5Ah44FWg9H4CM=;
        b=NNOnVEr19neIM7273P28aPKE9z7zRSXH889QcLQTa17aFwCGYWyoOjGZq7agLkuR/A
         InpsvR1AP9H4yyco9jZiHjV6ZXr5gY1eGXsQGrPfsBBBZQXLq5eU/0eZYY9xusv5Y5g5
         ul3y4ser5TjHRk3ToUENstkT9vmPN3sTyG72qBStx5y0JCsDie9YO3bY7Va16uEWEnog
         2X9qzH7FSmwQh4flfr7TTaXc0I0+v06FBNUjYcZ5ljTCckVrBAWJiLuFlbaTR99p32Ue
         HqIx2lCXjUKa0VFbqMXi0SFcKPClu1rvpWyXp2Tn82RQZjlsU4/psD1MUh3FmLarTCaF
         Ycyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5dbe41dvMeibhzpqOSIQnkhPlg4dZw5Ah44FWg9H4CM=;
        b=KbaevM0w1sqrQyTWiBBmr3HzlbIk1aVYKw4qMfcxdV+LG/L6+ZUMq8yuQBlLSB05kT
         EHiC61VabIR1RU6nozHQpdN59xzJ9jEvCQ73uLQAQlGf1zmEVYepTNHZHuxQjpUiIQUV
         32cimOIvucJXtzSXC+1Sqh2z5N9MSpNa5ICWFEzx3WltSmqlEqf9dvrW0h1USzH/gOoB
         O8m4jCP4EGCsW4Y7KGblza3bIe0JXtLkTL+KU56yF+NJeMesEbc4dNQ6hKCnM16YKne0
         uXUnMVI1qmNAi+6FsqgdhgC8/cGU3bjQS8A4LTcixLbmHPKp7X2lh/Oi1M9BkA9+8FAt
         GZxQ==
X-Gm-Message-State: AOAM530SN6X/cnKHvJcsa9/sEJsznqmJFRirgQ9J9e98Rc1eMMsV+eTp
        0aYlM09O6BXCDVks878hmQ9PR0zWG4QlE7vyY6R6SVCnC3+GmQ==
X-Google-Smtp-Source: ABdhPJywTnT+U8KMGgzIv+XUbU+uuDZ2RzXK9qs3iQ2wgtBd8IFekfiG/jvTsl+kpqT6vv7mc34LdOJ2OCelcPw/1sw=
X-Received: by 2002:a05:622a:1013:b0:2e1:c9c0:9831 with SMTP id
 d19-20020a05622a101300b002e1c9c09831mr6891444qte.245.1648777909152; Thu, 31
 Mar 2022 18:51:49 -0700 (PDT)
MIME-Version: 1.0
References: <1648713656-24254-1-git-send-email-zhaoyang.huang@unisoc.com>
 <YkVt0m+VxnXgnulq@dhcp22.suse.cz> <CAGWkznF4qb2EP3=xVamKO8qk08vaFg9JeHD7g80xvBfxm39Hkg@mail.gmail.com>
 <YkWR8t8yEe6xyzCM@dhcp22.suse.cz> <CAJuCfpFgi+Dph-dcDAvGQXwgeZVDBhok1UQ3X5kxFEfPQnxSSg@mail.gmail.com>
In-Reply-To: <CAJuCfpFgi+Dph-dcDAvGQXwgeZVDBhok1UQ3X5kxFEfPQnxSSg@mail.gmail.com>
From:   Zhaoyang Huang <huangzhaoyang@gmail.com>
Date:   Fri, 1 Apr 2022 09:51:21 +0800
Message-ID: <CAGWkznHyAG1wZcUrGE4-amptT_MkSnpZCrDLy0vUWBm3z2cmJw@mail.gmail.com>
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

On Fri, Apr 1, 2022 at 3:26 AM Suren Baghdasaryan <surenb@google.com> wrote:
>
> On Thu, Mar 31, 2022 at 4:35 AM Michal Hocko <mhocko@suse.com> wrote:
> >
> > On Thu 31-03-22 19:18:58, Zhaoyang Huang wrote:
> > > On Thu, Mar 31, 2022 at 5:01 PM Michal Hocko <mhocko@suse.com> wrote:
> > > >
> > > > On Thu 31-03-22 16:00:56, zhaoyang.huang wrote:
> > > > > From: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
> > > > >
> > > > > For some kind of memcg, the usage is varies greatly from scenarios. Such as
> > > > > multimedia app could have the usage range from 50MB to 500MB, which generated
> > > > > by loading an special algorithm into its virtual address space and make it hard
> > > > > to protect the expanded usage without userspace's interaction.
> > > >
> > > > Do I get it correctly that the concern you have is that you do not know
> > > > how much memory your workload will need because that depends on some
> > > > parameters?
> > > right. such as a camera APP will expand the usage from 50MB to 500MB
> > > because of launching a special function(face beauty etc need special
> > > algorithm)
> > > >
> > > > > Furthermore, fixed
> > > > > memory.low is a little bit against its role of soft protection as it will response
> > > > > any system's memory pressure in same way.
> > > >
> > > > Could you be more specific about this as well?
> > > As the camera case above, if we set memory.low as 200MB to keep the
> > > APP run smoothly, the system will experience high memory pressure when
> > > another high load APP launched simultaneously. I would like to have
> > > camera be reclaimed under this scenario.
> >
> > OK, so you effectivelly want to keep the memory protection when there is
> > a "normal" memory pressure but want to relax the protection on other
> > high memory utilization situations?
> >
> > How do you exactly tell a difference between a steady memory pressure
> > (say stream IO on the page cache) from "high load APP launched"? Should
> > you reduce the protection on the stram IO situation as well?
>
> IIUC what you are implementing here is a "memory allowance boost"
> feature and it seems you are implementing it entirely inside the
> kernel, while only userspace knows when to apply this boost (say at
> app launch time). This does not make sense to me.
I am wondering if it could be more helpful to apply this patch on the
background services(system_server etc) than APP, while the latter ones
are persistent to the system.
>
> >
> > [...]
> > > > One very important thing that I am missing here is the overall objective of this
> > > > tuning. From the above it seems that you want to (ab)use memory->low to
> > > > protect some portion of the charged memory and that the protection
> > > > shrinks over time depending on the the global PSI metrict and time.
> > > > But why this is a good thing?
> > > 'Good' means it meets my original goal of keeping the usage during a
> > > period of time and responding to the system's memory pressure. For an
> > > android like system, memory is almost forever being in a tight status
> > > no matter how many RAM it has. What we need from memcg is more than
> > > control and grouping, we need it to be more responsive to the system's
> > > load and could  sacrifice its usage  under certain criteria.
> >
> > Why existing tools/APIs are insufficient for that? You can watch for
> > both global and memcg memory pressure including PSI metrics and update
> > limits dynamically. Why is it necessary to put such a logic into the
> > kernel?
>
> I had exactly the same thought while reading through this.
> In Android you would probably need to implement a userspace service
> which would temporarily relax the memcg limits when required, monitor
> PSI levels and adjust the limits accordingly.
As my response to Michal's comment. Userspace monitors introduce
latency. Take LMKD as an example, it is actually driven by the
PSI_POLL_PERIOD_XXX_MS after first wakeup, which means
PSI_WINDOW_SIZE_MS could be too big to rely on. IMHO, with regards to
the responding time, LMKD is less efficient than lmk driver but more
strong in strategy things. I would like to test this patch in real
android's work load and feedback in next version.
>
> >
> > --
> > Michal Hocko
> > SUSE Labs
