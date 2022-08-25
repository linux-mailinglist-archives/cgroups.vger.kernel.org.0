Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BFAE5A0546
	for <lists+cgroups@lfdr.de>; Thu, 25 Aug 2022 02:44:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230448AbiHYAo2 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 24 Aug 2022 20:44:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230004AbiHYAoX (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 24 Aug 2022 20:44:23 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 475738FD4E;
        Wed, 24 Aug 2022 17:44:22 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id s6so14958295lfo.11;
        Wed, 24 Aug 2022 17:44:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=u5GpYKAPqiPXiVflxFFAVwYjhQ2xT4l31F3rdQnDD0o=;
        b=A/Iio860rhP/v2AnpLJlwrYJYcXyV6DIv9JQx+170rEWmlIhMRzeZ9l+nUAUWh62JI
         c7+HUkhuYDhePhYz0hBnDIf0kxXPYT4M/ZBV+H/mccKyYUoThe086rHM/Idvobh7usXz
         aQ9wrACY0Z3JXJeCVGOVmQknpIZLf36WPkxiBD7fWy8VN+O7qbUFOBo3a44ClzdymCK8
         cn9zOMWbhdyIyrwdxiUZa+HtMGxS+1GXqgQbAaeZcF6rDiKxojIsL57dVyKueIzEDW5i
         YgPIUJJ32Dna6ii+VrXwF0fLGL78HBDUuiwmooSSuF5KJzA6EQ+rvmtMerH7qMgXror3
         KaSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=u5GpYKAPqiPXiVflxFFAVwYjhQ2xT4l31F3rdQnDD0o=;
        b=S0XtLs4W1HO+76qNE5dm70YENYqZiqH6JmerFzloE1d/Gpz+r9dbiQXZGywMpe9w/n
         inbMqB2XCbB9tg7kSWznnCam1hEQFzORBOzECoE2UXsMc67W+BuU9TdgpTUVmTGwcj0F
         irqtmBKiS+ZxeFU5ZJKxi/VJTpA/19QK2Y/nRwjJgq7lQD/gQ268mAbVCAdLQrGtRsKg
         We2i5us6Ko15qhHq/kCzqNi0ftO67GxK078sf2fLhwBsDKJZrij/+mBBCqcJfrvwav2t
         qpxg5RgJHTKbDQsb98VLSOAhGJwltHxmVrfhvx1DK4GhiD88x1cKXK/gaD3FZK9ulRfp
         AGrA==
X-Gm-Message-State: ACgBeo3xTwrFXXvq90BpSaeiaNFSDI8C5lEuG9QSr/GZ4FmlQvBbHhPo
        GG5sy3ssYbmUxAo09onzuZvpw2lrIcvWJobj6KhNOgmD31+vSg==
X-Google-Smtp-Source: AA6agR4sZ+jOQ3X+L+bTqjmbitY0TBSZsnZdxwNoCqHbQQL3VjTrTMF6ph0SwWt+X5NwBlfDz2Rm7C9UXN28W6P64Jc=
X-Received: by 2002:a05:6512:1527:b0:48b:99:f3ff with SMTP id
 bq39-20020a056512152700b0048b0099f3ffmr386714lfb.81.1661388260398; Wed, 24
 Aug 2022 17:44:20 -0700 (PDT)
MIME-Version: 1.0
References: <YwNpI1ydy0yDnBH0@dhcp22.suse.cz> <CAGWkznEB+R0YBaBFBL7dPqs8R=qKC6+ixTWEGCYy2PaczXkaPA@mail.gmail.com>
 <YwRjyx6wFLk8WTDe@dhcp22.suse.cz> <CAGWkznGaYTv4u4kOo-rupfyWzDNJXNKTchwP6dbUK-=UXWm47w@mail.gmail.com>
 <YwSQ4APOu/H7lYGL@dhcp22.suse.cz> <CAGWkznGd6mgareABseMKY5p0f1=5dkfVkj=NS7_B6OkXBYSwyw@mail.gmail.com>
 <YwS/S9Sd1OWnT81Q@dhcp22.suse.cz> <CAGWkznGYLyF+njUB0gFF3JVdThnK9JaNsqxXYFhbdSwEQpCxvA@mail.gmail.com>
 <YwXYVjRpXQjQMsxr@dhcp22.suse.cz> <CAGWkznEqX3DwHW_owiK+HuuQ-HsUYK4vKmLhSxgzGn20Vzid2A@mail.gmail.com>
 <YwX89JCQCKMMYdG9@dhcp22.suse.cz>
In-Reply-To: <YwX89JCQCKMMYdG9@dhcp22.suse.cz>
From:   Zhaoyang Huang <huangzhaoyang@gmail.com>
Date:   Thu, 25 Aug 2022 08:43:52 +0800
Message-ID: <CAGWkznF+dBjLzAxMMXWYSZ_5q3KA-ou0P7XM7jSYN7JSRp8N0w@mail.gmail.com>
Subject: Re: [RFC PATCH] memcg: use root_mem_cgroup when css is inherited
To:     Michal Hocko <mhocko@suse.com>
Cc:     Suren Baghdasaryan <surenb@google.com>, Tejun Heo <tj@kernel.org>,
        Shakeel Butt <shakeelb@google.com>,
        "zhaoyang.huang" <zhaoyang.huang@unisoc.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Linux MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Cgroups <cgroups@vger.kernel.org>, Ke Wang <ke.wang@unisoc.com>,
        Zefan Li <lizefan.x@bytedance.com>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Muchun Song <songmuchun@bytedance.com>
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

On Wed, Aug 24, 2022 at 6:27 PM Michal Hocko <mhocko@suse.com> wrote:
>
> On Wed 24-08-22 17:34:42, Zhaoyang Huang wrote:
> > On Wed, Aug 24, 2022 at 3:50 PM Michal Hocko <mhocko@suse.com> wrote:
> > >
> > > On Wed 24-08-22 10:23:14, Zhaoyang Huang wrote:
> > > > On Tue, Aug 23, 2022 at 7:51 PM Michal Hocko <mhocko@suse.com> wrote:
> > > [...]
> > > > > One way to achieve that would be shaping the hierarchy the following way
> > > > >             root
> > > > >         /         \
> > > > > no_memcg[1]      memcg[2]
> > > > > ||||||||         |||||
> > > > > app_cgroups     app_cgroups
> > > > >
> > > > > with
> > > > > no_memcg.subtree_control = ""
> > > > > memcg.subtree_control = memory
> > > > >
> > > > > no?
> > > > According to my understanding, No as there will be no no_memcg. All
> > > > children groups under root would have its cgroup.controllers = memory
> > > > as long as root has memory enabled.
> > >
> > > Correct
> > >
> > > > Under this circumstance, all
> > > > descendants group under 'no_memcg' will charge memory to its parent
> > > > group.
> > >
> > > Correct. And why is that a problem? I thought you main concern was a per
> > > application LRUs. With the above configuration all app_cgroups which do
> > > not require an explicit memory control will share the same (no_memcg)
> > > LRU and they will be aged together.
> > I can't agree since this indicates the processes want memory free
> > depending on a specific hierarchy which could have been determined by
> > other subsys.
>
> I really fail to understand your requirements.
>
> > IMHO, charging the pages which out of explicitly memory
> > enabled group to root could solve all of the above constraints with no
> > harm.
>
> This would break the hierarchical property of the controller. So a
> strong no no. Consider the following example
>
>        root
>         |
>         A
> controllers="memory"
> memory.max = 1G
> subtree_control=""
> |      |      |
> A1     A2     A3
>
> althought A1,2,3 do not have their memory controller enabled explicitly
> they are still constrained by the A memcg limit. If you just charge to
> the root because it doesn't have memory controller enabled explicitly
> then you just evade that constrain. I hope you understand why that is a
> problem.
IMO, A1-A3 should be explicitly enabled via echo "+memory" >
A/subtree_control since memory.max has been set. How should AA3
achieve the goal of compete with AA4,A1,A2 for cpu but keep memory out
of control under current policy?
        root
         |
         A
 controllers="memory,cpu"
 memory.max = 1G
 subtree_control="memory,cpu"
 |      |      |
 A1     A2     A3 subtree_control="cpu"
                      |      |
                    AA3   AA4 controllers="cpu"

> --
> Michal Hocko
> SUSE Labs
