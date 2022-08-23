Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D655459D102
	for <lists+cgroups@lfdr.de>; Tue, 23 Aug 2022 08:04:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240434AbiHWGDh (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 23 Aug 2022 02:03:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240391AbiHWGDg (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 23 Aug 2022 02:03:36 -0400
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCE6141998;
        Mon, 22 Aug 2022 23:03:34 -0700 (PDT)
Received: by mail-lj1-x22d.google.com with SMTP id u24so6972152lji.0;
        Mon, 22 Aug 2022 23:03:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=E62vcG6bv2NNKCtD/xZSrhG3tjB/Yn/YnvPEoQsQ9jU=;
        b=i9pQ/jlf23urfzZGcT78wq4iwrCpsCF/RBEu56tcMGOPHmkNCYJyLUlDhCzToM/tns
         VXlAupSv9gmHQiLAijfbheKjUISV7fLTvvwCc/Bq099q1/FKTE3B5yvgGOjyDi4oaVR1
         2MUmxB34Ls2U41/lrPnegBKEhxSrDoU3rHrUMgRPe2O7JLkd0Uw0EbRcmV663aAdE9J2
         XyRs3+ZuOQcfs5fEi6Yv1O32zi/7ALmMyDLGatsIrJCDHEZLD95v5/WDa1I7j9D+dtPS
         CveXtZXWpglnln7WRxUW2BurJCt+giTZ3gowKTC9U4Z4jRjmGbHjOc5hrhGukOza0LoD
         jkow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=E62vcG6bv2NNKCtD/xZSrhG3tjB/Yn/YnvPEoQsQ9jU=;
        b=2Lu3KA/bj6sNR7vMHB1wGdylfAp9+MyzpFYOpb8GYeNfDKOX9mgVVaSAVEvk3TOhYi
         bGdcX5ehd1pr+n7zLnRyam25Mr/ERcRYqemkZ1iUzLKgloMUg8Sex9lnrcevoYAY1bHn
         hC71/k3gWLK69kDlxna4FC24a/HFiFSGb2xPTHJ4q91bsC/IFczf7ZWX3jG2izUvO4u+
         CbDKHED4x19jiIs1/wdGPIaL9YMdnxAkK3TVGoD+MwSAwp2PDZhwqT9I1emCgRk8f0/9
         SKxAlwmKa78n0Gm6IpLKCtQS0b2jaNnoXOAAZNiG/r0Wm5NnuChlWiZLI5Ck5Ay2kgUS
         fWsA==
X-Gm-Message-State: ACgBeo2E0WpvydJ47f1nliL5ShePqbsFz9E7e0S2XYKBwrBHijH6nlZr
        0ZEvXwgfqGT8i0o6yVoECuti6T3cs9ohotJZKgQ=
X-Google-Smtp-Source: AA6agR6zN9oIh9MYRCAAGDxl0xMdUfhVW/LqXRolx5mCBjnzeCCMkmhYgnVODUm5K8SWlRonG7SrNkD1K8Aa/nul9bU=
X-Received: by 2002:a05:651c:2311:b0:261:d3d9:52e6 with SMTP id
 bi17-20020a05651c231100b00261d3d952e6mr1267222ljb.392.1661234613072; Mon, 22
 Aug 2022 23:03:33 -0700 (PDT)
MIME-Version: 1.0
References: <1660908562-17409-1-git-send-email-zhaoyang.huang@unisoc.com>
 <Yv+6YjaGAv52yvq9@slm.duckdns.org> <CALvZod7QdLSMdBoD2WztL72qS8kJe7F79JuCH6t19rRcw6Pn1w@mail.gmail.com>
 <Yv/EArPDTcCrGqJh@slm.duckdns.org> <YwNpI1ydy0yDnBH0@dhcp22.suse.cz>
 <CAGWkznEB+R0YBaBFBL7dPqs8R=qKC6+ixTWEGCYy2PaczXkaPA@mail.gmail.com> <YwRjyx6wFLk8WTDe@dhcp22.suse.cz>
In-Reply-To: <YwRjyx6wFLk8WTDe@dhcp22.suse.cz>
From:   Zhaoyang Huang <huangzhaoyang@gmail.com>
Date:   Tue, 23 Aug 2022 14:03:04 +0800
Message-ID: <CAGWkznGaYTv4u4kOo-rupfyWzDNJXNKTchwP6dbUK-=UXWm47w@mail.gmail.com>
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

On Tue, Aug 23, 2022 at 1:21 PM Michal Hocko <mhocko@suse.com> wrote:
>
> On Tue 23-08-22 10:31:57, Zhaoyang Huang wrote:
> > On Mon, Aug 22, 2022 at 7:31 PM Michal Hocko <mhocko@suse.com> wrote:
> > >
> > > On Fri 19-08-22 07:10:26, Tejun Heo wrote:
> > > > On Fri, Aug 19, 2022 at 10:08:59AM -0700, Shakeel Butt wrote:
> > > > > On Fri, Aug 19, 2022 at 9:29 AM Tejun Heo <tj@kernel.org> wrote:
> > > > > >
> > > > > > On Fri, Aug 19, 2022 at 07:29:22PM +0800, zhaoyang.huang wrote:
> > > > > > > From: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
> > > > > > >
> > > > > > > It is observed in android system where per-app cgroup is demanded by freezer
> > > > > > > subsys and part of groups require memory control. The hierarchy could be simplized
> > > > > > > as bellowing where memory charged on group B abserved while we only want have
> > > > > > > group E's memory be controlled and B's descendants compete freely for memory.
> > > > > > > This should be the consequences of unified hierarchy.
> > > > > > > Under this scenario, less efficient memory reclaim is observed when comparing
> > > > > > > with no memory control. It is believed that multi LRU scanning introduces some
> > > > > > > of the overhead. Furthermore, page thrashing is also heavier than global LRU
> > > > > > > which could be the consequences of partial failure of WORKINGSET mechanism as
> > > > > > > LRU is too short to protect the active pages.
> > > > > > >
> > > > > > > A(subtree_control = memory) - B(subtree_control = NULL) - C()
> > > > > > >                                                       \ D()
> > > > > > >                           - E(subtree_control = memory) - F()
> > > > > > >                                                         \ G()
> > > > > > >
> > > > > > > Signed-off-by: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
> > > > > >
> > > > > > Just in case it wasn't clear.
> > > > > >
> > > > > > Nacked-by: Tejun Heo <tj@kernel.org>
> > > > > >
> > > > > > Thanks.
> > > > > >
> > > > >
> > > > > Was there a previous discussion on this? The commit message is unreadable.
> > > >
> > > > http://lkml.kernel.org/r/1660298966-11493-1-git-send-email-zhaoyang.huang@unisoc.com
> > >
> > > Even that discussion doesn't really explain the real underlying problem.
> > > There are statements about inefficiency and trashing without any further
> > > details or clarifications.
> > I would like to quote the comments from google side for more details
> > which can also be observed from different vendors.
> > "Also be advised that when you enable memcg v2 you will be using
> > per-app memcg configuration which implies noticeable overhead because
> > every app will have its own group. For example pagefault path will
> > regress by about 15%. And obviously there will be some memory overhead
> > as well. That's the reason we don't enable them in Android by
> > default."
>
> This should be reported and investigated. Because per-application memcg
> vs. memcg in general shouldn't make much of a difference from the
> performance side. I can see a potential performance impact for no-memcg
> vs. memcg case but even then 15% is quite a lot.
Less efficiency on memory reclaim caused by multi-LRU should be one of
the reason, which has been proved by comparing per-app memcg on/off.
Besides, theoretically workingset could also broken as LRU is too
short to compose workingset.
>
> > > My very vague understanding is that the Android system would like to
> > > freeze specific applications and for that it requires each application
> > > to live in its own cgroup. This clashes with a requirement to age and
> > > reclaim memory on a different granularity (aka no per process reclaim).
> > > So in fact something that cgroup v1 would achieve by having 2
> > > hierarchies, one for the freezer which would have a dedicated cgroup for
> > > each application and the other for the memory controller where tasks are
> > > grouped by a different criteria. This would rule out that a global (or
> > > any external memory pressure) reclaim would age LRUs that contain a mix
> > > bag of application pages rather than iterate over per-application LRUs.
> > > Is that understanding correct?
> > Correct, this is just our confusion. Besides, we believe that charge
> > the pages to implicit memory enabled parent control group doesn't make
> > sense as the memory cannot be managed at all.
>
> I do not get that part. The parent can manange and control the memory
> usage so how come it cannot be managed at all?
What I mean is the kind of parent which is enabled implicitly by
enabling on its sibling group like belowing hierarchy. Imagine that C
has no intention of memory control but has to be enabled as B would
have it. IMO, it doesn't make sense to charge C1's memory.current to C
until an explicitly echo "+memory" >  C/subtree_control.
A----B---B1
     \ C---C1
> --
> Michal Hocko
> SUSE Labs
