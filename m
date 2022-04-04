Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F11D4F11E7
	for <lists+cgroups@lfdr.de>; Mon,  4 Apr 2022 11:24:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239162AbiDDJ0I (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 4 Apr 2022 05:26:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236317AbiDDJ0H (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 4 Apr 2022 05:26:07 -0400
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0902424589;
        Mon,  4 Apr 2022 02:24:12 -0700 (PDT)
Received: by mail-qt1-x833.google.com with SMTP id c4so7193861qtx.1;
        Mon, 04 Apr 2022 02:24:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oXmJJ5+eLXFpFacDKNV9S+2RH6HTol71eIq9kzYo+Zo=;
        b=eflAGqZ3vQTJxGYGbegq1IkJ1Jj7j6sR79EJcRJ6tIr2aMi/46tQdVwR8fYN2kOQ6J
         nfQxDRXc/vXsD9gMO2zhmgXzpaKvpmvzWAAfTcrbg4tvTH7tlhyQWYf79I58B/XnndMj
         dqSrGuAjJ5M78Z9iFuUgLFORB8JJgOBV3fBG9y4Cn14m6plu7SILNcI8fjKS+q2PqjVY
         rRjvDhiqoZGTDrU9QfgdRJYjejVuxOIrZpoQjwNiMHk1nt2vCrHa/tHYVOdynIYpS50B
         KkQl3sZ+bobm6bOMiqJlOeZibzkmAseeD4kLYm+6giD17MjEbmDDIZjtI6s7BuhgfCNu
         xVIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oXmJJ5+eLXFpFacDKNV9S+2RH6HTol71eIq9kzYo+Zo=;
        b=ZezDjUz+ZspV6Wy/wkToc5RtPfB6HcUUwqO8hLvFu69sK2svQ2o3VNR6pI3YfhHRTe
         jSyi0pu8UMOEOmswPmgSP4aBIy4jIsaxnX+xPOZOxYmcftPG1QTt1ou8S1JmCNycbrUe
         njwiHCR6kzmXOXIsUvjBWYnW/Ye8vi8X1Z5KLRJEC0KtZbwZ/QbDBhXvcc94mh22lQMo
         C0XLtYotzgf+MzssGq8GHl77I1Cpxyc/sh7vg8a3r/Mdjza9CJtO3A+WWxbnYLONPHvs
         pfWXSHFVH/Sk0gZihu2MPhHPYul6T6II8e364r5mKe124/zOhXEvXOFqObWsAxPQS23N
         Cz/w==
X-Gm-Message-State: AOAM531MjL1FHK/DeOHqKsRKZuUjnivEywVoU8iz6eEnng6DMqQZ7zde
        HwU7F2+DrigAWLG1KcgKk05Sir+CXbUGDciwAxXanFMcEwo=
X-Google-Smtp-Source: ABdhPJzG+pfiihbIr+vV8nmCAu3EUwjBSNALuPSw7wTFpTdkCugi7Vlp+jba89JnUXgvjEkbVMTeI+53Oi+i8WofzDI=
X-Received: by 2002:ac8:4e50:0:b0:2e2:17a8:2ab0 with SMTP id
 e16-20020ac84e50000000b002e217a82ab0mr16600488qtw.68.1649064251177; Mon, 04
 Apr 2022 02:24:11 -0700 (PDT)
MIME-Version: 1.0
References: <1648713656-24254-1-git-send-email-zhaoyang.huang@unisoc.com>
 <YkVt0m+VxnXgnulq@dhcp22.suse.cz> <CAGWkznF4qb2EP3=xVamKO8qk08vaFg9JeHD7g80xvBfxm39Hkg@mail.gmail.com>
 <YkWR8t8yEe6xyzCM@dhcp22.suse.cz> <CAGWkznHxAD0757m1i1Csw1CVRDtQddfCL08dYf12fa47=-uYYQ@mail.gmail.com>
 <YkbjNYMY8VjHoSHR@dhcp22.suse.cz> <CAGWkznF7cSyPU0ceYwH6zweJzf-X1bQnS6AJ2-J+WEL0u8jzng@mail.gmail.com>
 <CAJuCfpHneDZMXO_MmQDPA+igAOdAPRUChiq+zftFXGfDzPHNhQ@mail.gmail.com>
 <CAGWkznFTQCm0cusVxA_55fu2WfT-w2coVHrT=JA1D_9_2728mQ@mail.gmail.com>
 <YkqxpEW4m6iU3zMq@dhcp22.suse.cz> <CAGWkznG4L3w=9bpZp8TjyWHmqFyZQk-3m4xCZ96zhHCLPawBgQ@mail.gmail.com>
In-Reply-To: <CAGWkznG4L3w=9bpZp8TjyWHmqFyZQk-3m4xCZ96zhHCLPawBgQ@mail.gmail.com>
From:   Zhaoyang Huang <huangzhaoyang@gmail.com>
Date:   Mon, 4 Apr 2022 17:23:43 +0800
Message-ID: <CAGWkznGMRohE2_at4Qh8KbwSqNmNqOAG2N1EM+7uE9wKqzRm0A@mail.gmail.com>
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

On Mon, Apr 4, 2022 at 5:07 PM Zhaoyang Huang <huangzhaoyang@gmail.com> wrote:
>
> On Mon, Apr 4, 2022 at 4:51 PM Michal Hocko <mhocko@suse.com> wrote:
> >
> > On Mon 04-04-22 10:33:58, Zhaoyang Huang wrote:
> > [...]
> > > > One thing that I don't understand in this approach is: why memory.low
> > > > should depend on the system's memory pressure. It seems you want to
> > > > allow a process to allocate more when memory pressure is high. That is
> > > > very counter-intuitive to me. Could you please explain the underlying
> > > > logic of why this is the right thing to do, without going into
> > > > technical details?
> > > What I want to achieve is make memory.low be positive correlation with
> > > timing and negative to memory pressure, which means the protected
> > > memcg should lower its protection(via lower memcg.low) for helping
> > > system's memory pressure when it's high.
> >
> > I have to say this is still very confusing to me. The low limit is a
> > protection against external (e.g. global) memory pressure. Decreasing
> > the protection based on the external pressure sounds like it goes right
> > against the purpose of the knob. I can see reasons to update protection
> > based on refaults or other metrics from the userspace but I still do not
> > see how this is a good auto-magic tuning done by the kernel.
> >
> > > The concept behind is memcg's
> > > fault back of dropped memory is less important than system's latency
> > > on high memory pressure.
> >
> > Can you give some specific examples?
> For both of the above two comments, please refer to the latest test
> result in Patchv2 I have sent. I prefer to name my change as focus
> transfer under pressure as protected memcg is the focus when system's
> memory pressure is low which will reclaim from root, this is not
> against current design. However, when global memory pressure is high,
> then the focus has to be changed to the whole system, because it
> doesn't make sense to let the protected memcg out of everybody, it
> can't
> do anything when the system is trapped in the kernel with reclaiming work.
Does it make more sense if I describe the change as memcg will be
protect long as system pressure is under the threshold(partially
coherent with current design) and will sacrifice the memcg if pressure
is over the threshold(added change)
> >
> > > Please refer to my new version's test data
> > > for more detail.
> >
> > Please note that sending new RFCs will just make the discussion spread
> > over several email threads which will get increasingly hard to follow.
> > So do not post another version until it is really clear what is the
> > actual semantic you are proposing.
> ok, I will hold until all question done.
> >
> > --
> > Michal Hocko
> > SUSE Labs
