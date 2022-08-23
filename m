Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD28259DDB3
	for <lists+cgroups@lfdr.de>; Tue, 23 Aug 2022 14:28:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232069AbiHWLTq (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 23 Aug 2022 07:19:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357549AbiHWLRn (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 23 Aug 2022 07:17:43 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FDFA89819;
        Tue, 23 Aug 2022 02:21:29 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id z25so18861480lfr.2;
        Tue, 23 Aug 2022 02:21:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=+DWGPIPc3ISzDYgpuxxTGtSNnOcnHXPhDpdYriuehoA=;
        b=W+2mwoq3OWMQOasY34q5ndf9QlyFCqrsVYi8MwQDe1BCxhmcZpZ0Z1p+h0jGQpBVe5
         YI9nZKuyu12VLCXV5aKWyXzAhYFJubm5BcTqhOm5wrL2+a9v0L3eEFhNb94C8Abjpofk
         H0FkmNc+BE+pbY/Jr172MT/PHEpCKyW3hnF2iqXiX5hvBxOZ/qMwweAvrRfGGGPP9cMA
         PGbqH0aMl7DQRqBGNw6Li+N3SzBnJJrYXLBoPOnFpF+kdMmRbo657HDBtrY4+QrpjzCd
         0mnRokYL7mKXy66KYnO+0RA+rYX2cxrA4dx4W+HwqBjtx4j2xBHFHBg81zAcG6FZrpes
         b2jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=+DWGPIPc3ISzDYgpuxxTGtSNnOcnHXPhDpdYriuehoA=;
        b=LCyyyL22Cgx62Kx/935uxnVEqGO96+XlxcwzUpfVRxYShIk5LmPs13I6XlhcwOo8Un
         gP+881ZDAc5G0W/Y7HjMO8a9Skrk+3VyLECtClxeJx9uStabffi97rPK0nyLjybZ2uW9
         /AYNr02ucudRPmXCDOL3vBo2muBkaOnBuqHBrgpGjHfchJzQi4I9mQQFdTrtWyRDpF/G
         c7Q7SxJnLF6e2RFITMxpzjywWn1rV3qAWnR45xKHvTpmt66KWb2htPKvNPDfHXQtKC4O
         K8M2mcQ8NlU6QyP90S+JHayLzw5Ci0JDZCa5RKZBex6zU/8fwDZZ9xrv5g9du4XRmpFm
         h44Q==
X-Gm-Message-State: ACgBeo1vFRUAk9FcPc2/f5k+PNtSO60ZQVqRlnLvdTu1M9LUnJEAvf3K
        l36brOReBkzBfehdywgg6hKdMhMf+ga3vLAfqG8Y/CNe
X-Google-Smtp-Source: AA6agR4+KWoZ7AaIB7FncIy8FTWaR54rys+sYhXWsAOHt1uJIh9H5Lnf6SzVrLAGohOucXvT3iQ9PYabEoIZSSYmXNA=
X-Received: by 2002:a05:6512:68f:b0:492:cbb1:c4b2 with SMTP id
 t15-20020a056512068f00b00492cbb1c4b2mr7138192lfe.130.1661246487607; Tue, 23
 Aug 2022 02:21:27 -0700 (PDT)
MIME-Version: 1.0
References: <1660908562-17409-1-git-send-email-zhaoyang.huang@unisoc.com>
 <Yv+6YjaGAv52yvq9@slm.duckdns.org> <CALvZod7QdLSMdBoD2WztL72qS8kJe7F79JuCH6t19rRcw6Pn1w@mail.gmail.com>
 <Yv/EArPDTcCrGqJh@slm.duckdns.org> <YwNpI1ydy0yDnBH0@dhcp22.suse.cz>
 <CAGWkznEB+R0YBaBFBL7dPqs8R=qKC6+ixTWEGCYy2PaczXkaPA@mail.gmail.com>
 <YwRjyx6wFLk8WTDe@dhcp22.suse.cz> <CAGWkznGaYTv4u4kOo-rupfyWzDNJXNKTchwP6dbUK-=UXWm47w@mail.gmail.com>
 <YwSQ4APOu/H7lYGL@dhcp22.suse.cz>
In-Reply-To: <YwSQ4APOu/H7lYGL@dhcp22.suse.cz>
From:   Zhaoyang Huang <huangzhaoyang@gmail.com>
Date:   Tue, 23 Aug 2022 17:20:59 +0800
Message-ID: <CAGWkznGd6mgareABseMKY5p0f1=5dkfVkj=NS7_B6OkXBYSwyw@mail.gmail.com>
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

On Tue, Aug 23, 2022 at 4:33 PM Michal Hocko <mhocko@suse.com> wrote:
>
> On Tue 23-08-22 14:03:04, Zhaoyang Huang wrote:
> > On Tue, Aug 23, 2022 at 1:21 PM Michal Hocko <mhocko@suse.com> wrote:
> > >
> > > On Tue 23-08-22 10:31:57, Zhaoyang Huang wrote:
> [...]
> > > > I would like to quote the comments from google side for more details
> > > > which can also be observed from different vendors.
> > > > "Also be advised that when you enable memcg v2 you will be using
> > > > per-app memcg configuration which implies noticeable overhead because
> > > > every app will have its own group. For example pagefault path will
> > > > regress by about 15%. And obviously there will be some memory overhead
> > > > as well. That's the reason we don't enable them in Android by
> > > > default."
> > >
> > > This should be reported and investigated. Because per-application memcg
> > > vs. memcg in general shouldn't make much of a difference from the
> > > performance side. I can see a potential performance impact for no-memcg
> > > vs. memcg case but even then 15% is quite a lot.
> > Less efficiency on memory reclaim caused by multi-LRU should be one of
> > the reason, which has been proved by comparing per-app memcg on/off.
> > Besides, theoretically workingset could also broken as LRU is too
> > short to compose workingset.
>
> Do you have any data to back these claims? Is this something that could
> be handled on the configuration level? E.g. by applying low limit
> protection to keep the workingset in the memory?
I don't think so. IMO, workingset works when there are pages evicted
from LRU and then refault which provide refault distance for pages.
Applying memcg's protection will have all LRU out of evicted which
make the mechanism fail.
>
> > > > > My very vague understanding is that the Android system would like to
> > > > > freeze specific applications and for that it requires each application
> > > > > to live in its own cgroup. This clashes with a requirement to age and
> > > > > reclaim memory on a different granularity (aka no per process reclaim).
> > > > > So in fact something that cgroup v1 would achieve by having 2
> > > > > hierarchies, one for the freezer which would have a dedicated cgroup for
> > > > > each application and the other for the memory controller where tasks are
> > > > > grouped by a different criteria. This would rule out that a global (or
> > > > > any external memory pressure) reclaim would age LRUs that contain a mix
> > > > > bag of application pages rather than iterate over per-application LRUs.
> > > > > Is that understanding correct?
> > > > Correct, this is just our confusion. Besides, we believe that charge
> > > > the pages to implicit memory enabled parent control group doesn't make
> > > > sense as the memory cannot be managed at all.
> > >
> > > I do not get that part. The parent can manange and control the memory
> > > usage so how come it cannot be managed at all?
> > What I mean is the kind of parent which is enabled implicitly by
> > enabling on its sibling group like belowing hierarchy. Imagine that C
> > has no intention of memory control but has to be enabled as B would
> > have it. IMO, it doesn't make sense to charge C1's memory.current to C
> > until an explicitly echo "+memory" >  C/subtree_control.
> > A----B---B1
> >      \ C---C1
>
> So let me just expand your example for clarity
>
> A.cgroup.controllers = memory
> A.cgroup.subtree_control = memory
>
> A/B.cgroup.controllers = memory
> A/B.cgroup.subtree_control = memory
> A/B/B1.cgroup.controllers = memory
>
> A/C.cgroup.controllers = memory
> A/C.cgroup.subtree_control = ""
> A/C/C1.cgroup.controllers = ""
Yes for above hierarchy and configuration.
>
> Is your concern that C1 is charged to A/C or that you cannot actually make
> A/C.cgroup.controllers = "" because you want to maintain memory in A?
> Because that would be breaking the internal node constrain rule AFAICS.
No. I just want to keep memory on B.
>
> Or maybe you just really want a different hierarchy where
> A == root_cgroup and want the memory acocunted in B
> (root/B.cgroup.controllers = memory) but not in C (root/C.cgroup.controllers = "")?
Yes.
>
> That would mean that C memory would be maintained on the global (root
> memcg) LRUs which is the only internal node which is allowed to have
> resources because it is special.
Exactly. I would like to have all groups like C which have no parent's
subtree_control = memory charge memory to root. Under this
implementation, memory under enabled group will be protected by
min/low while other groups' memory share the same LRU to have
workingset things take effect.
> --
> Michal Hocko
> SUSE Labs
