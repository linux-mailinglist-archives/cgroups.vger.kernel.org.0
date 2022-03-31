Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2DB74EE1A2
	for <lists+cgroups@lfdr.de>; Thu, 31 Mar 2022 21:27:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240650AbiCaT21 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 31 Mar 2022 15:28:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240646AbiCaT20 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 31 Mar 2022 15:28:26 -0400
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com [IPv6:2607:f8b0:4864:20::b2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C6C31E0147
        for <cgroups@vger.kernel.org>; Thu, 31 Mar 2022 12:26:39 -0700 (PDT)
Received: by mail-yb1-xb2e.google.com with SMTP id o5so1222796ybe.2
        for <cgroups@vger.kernel.org>; Thu, 31 Mar 2022 12:26:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TX6QX0+HXrSqPnqJDfaKnpAt/asDBfCVYhsU3t5tEcc=;
        b=nb3MbJRRAbBq9xDAD1NkGl6UAAGL0QIEi9Lgjrtb61uhKkmxKE2ynQ1oz3cxOJ6xaL
         hUw2V2U6RikzGjio0lGQsjrt8P4ZUdwVuQmENM9+qmYF4bLsKGbvRyFMp3dW2EeoZ46q
         Ozvbohpe3e5Et69346PFXjYvxEjxJx0h9Ow//0q/jX97jqtRytW2dgZWdpfnhKiRImgf
         BQXQkrxJtZNwtShSr7InkA/MggN0JtZO/Vp/58i4pvPelyqW8S2KgYer5xwnrSWNt5N2
         nNQOEBZZndbQX1lmru4YUbyIp57jfGAktPoso00dg+tuqHJv2rO/pqiEAtsT976rgnoq
         69NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TX6QX0+HXrSqPnqJDfaKnpAt/asDBfCVYhsU3t5tEcc=;
        b=vHY6gv7gvPxbD8M+4r7VK9/rl3mIOfjuu6IDcYR4jvnCbVucvhKjf2I4eweaHZmRoS
         +4fT6T3rQdnTudLep2P2DchPQTwCOj4mlmou7rieheXi2M71YTwtlCSfRYZ80/1WljE7
         T6LoWtfH06EUPMFn7Cby5E9uauoE1qSy+wd7E4hQbsWYcrPtrbQDWCr4tfKzH8za0psb
         /FIBUjLHAADP8Ca0aqCe9z3CPRZMo0tKIaxjE6aXQAR0STVDYQnlMrnVKr5BtPjbd9iz
         yMJT7DfiqEuHsERark4HVvJrnHtrJ/Cz42sx0oDxHrcLkZk6WV//7nNlaT5FiQ0muFYQ
         f/Bw==
X-Gm-Message-State: AOAM531+cvQSsDrMTa6VaZIXVZLiSmeJc2rTdCNIb09U1drshRikgEPp
        cVwyzqH3+WrlHM5dlDVDVlHf1Soz+Fe5XA3ue6A4QA==
X-Google-Smtp-Source: ABdhPJzb6s3dp9L52kirRHRXCjOqXWIaXLwxT6D11fIb5+efsBWozTIDW6eLFnP1mKmrG/gWXA8/BV0Ci5ZwJ4uz/Dw=
X-Received: by 2002:a25:608:0:b0:634:5ff5:7c65 with SMTP id
 8-20020a250608000000b006345ff57c65mr5199291ybg.282.1648754798107; Thu, 31 Mar
 2022 12:26:38 -0700 (PDT)
MIME-Version: 1.0
References: <1648713656-24254-1-git-send-email-zhaoyang.huang@unisoc.com>
 <YkVt0m+VxnXgnulq@dhcp22.suse.cz> <CAGWkznF4qb2EP3=xVamKO8qk08vaFg9JeHD7g80xvBfxm39Hkg@mail.gmail.com>
 <YkWR8t8yEe6xyzCM@dhcp22.suse.cz>
In-Reply-To: <YkWR8t8yEe6xyzCM@dhcp22.suse.cz>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Thu, 31 Mar 2022 12:26:27 -0700
Message-ID: <CAJuCfpFgi+Dph-dcDAvGQXwgeZVDBhok1UQ3X5kxFEfPQnxSSg@mail.gmail.com>
Subject: Re: [RFC PATCH] cgroup: introduce dynamic protection for memcg
To:     Michal Hocko <mhocko@suse.com>
Cc:     Zhaoyang Huang <huangzhaoyang@gmail.com>,
        "zhaoyang.huang" <zhaoyang.huang@unisoc.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        "open list:MEMORY MANAGEMENT" <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        cgroups mailinglist <cgroups@vger.kernel.org>,
        Ke Wang <ke.wang@unisoc.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Thu, Mar 31, 2022 at 4:35 AM Michal Hocko <mhocko@suse.com> wrote:
>
> On Thu 31-03-22 19:18:58, Zhaoyang Huang wrote:
> > On Thu, Mar 31, 2022 at 5:01 PM Michal Hocko <mhocko@suse.com> wrote:
> > >
> > > On Thu 31-03-22 16:00:56, zhaoyang.huang wrote:
> > > > From: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
> > > >
> > > > For some kind of memcg, the usage is varies greatly from scenarios. Such as
> > > > multimedia app could have the usage range from 50MB to 500MB, which generated
> > > > by loading an special algorithm into its virtual address space and make it hard
> > > > to protect the expanded usage without userspace's interaction.
> > >
> > > Do I get it correctly that the concern you have is that you do not know
> > > how much memory your workload will need because that depends on some
> > > parameters?
> > right. such as a camera APP will expand the usage from 50MB to 500MB
> > because of launching a special function(face beauty etc need special
> > algorithm)
> > >
> > > > Furthermore, fixed
> > > > memory.low is a little bit against its role of soft protection as it will response
> > > > any system's memory pressure in same way.
> > >
> > > Could you be more specific about this as well?
> > As the camera case above, if we set memory.low as 200MB to keep the
> > APP run smoothly, the system will experience high memory pressure when
> > another high load APP launched simultaneously. I would like to have
> > camera be reclaimed under this scenario.
>
> OK, so you effectivelly want to keep the memory protection when there is
> a "normal" memory pressure but want to relax the protection on other
> high memory utilization situations?
>
> How do you exactly tell a difference between a steady memory pressure
> (say stream IO on the page cache) from "high load APP launched"? Should
> you reduce the protection on the stram IO situation as well?

IIUC what you are implementing here is a "memory allowance boost"
feature and it seems you are implementing it entirely inside the
kernel, while only userspace knows when to apply this boost (say at
app launch time). This does not make sense to me.

>
> [...]
> > > One very important thing that I am missing here is the overall objective of this
> > > tuning. From the above it seems that you want to (ab)use memory->low to
> > > protect some portion of the charged memory and that the protection
> > > shrinks over time depending on the the global PSI metrict and time.
> > > But why this is a good thing?
> > 'Good' means it meets my original goal of keeping the usage during a
> > period of time and responding to the system's memory pressure. For an
> > android like system, memory is almost forever being in a tight status
> > no matter how many RAM it has. What we need from memcg is more than
> > control and grouping, we need it to be more responsive to the system's
> > load and could  sacrifice its usage  under certain criteria.
>
> Why existing tools/APIs are insufficient for that? You can watch for
> both global and memcg memory pressure including PSI metrics and update
> limits dynamically. Why is it necessary to put such a logic into the
> kernel?

I had exactly the same thought while reading through this.
In Android you would probably need to implement a userspace service
which would temporarily relax the memcg limits when required, monitor
PSI levels and adjust the limits accordingly.

>
> --
> Michal Hocko
> SUSE Labs
