Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96D7A5F7218
	for <lists+cgroups@lfdr.de>; Fri,  7 Oct 2022 01:55:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231733AbiJFXzo (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 6 Oct 2022 19:55:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230307AbiJFXzm (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 6 Oct 2022 19:55:42 -0400
Received: from mail-vs1-xe35.google.com (mail-vs1-xe35.google.com [IPv6:2607:f8b0:4864:20::e35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0BE3FFFB6
        for <cgroups@vger.kernel.org>; Thu,  6 Oct 2022 16:55:41 -0700 (PDT)
Received: by mail-vs1-xe35.google.com with SMTP id n186so3551355vsc.9
        for <cgroups@vger.kernel.org>; Thu, 06 Oct 2022 16:55:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=T4mxXhpF84I6akWlYzDe5Gw+8i4lTZ56Lv0l9+70zzM=;
        b=Bq5A1mKudnh0A+o4CH6pTUhbmuThgiCNQGGHKR4Ycnz/34kL9MQ7iOIFDgY9uzlDAm
         4mB4bS9RhEZVNiv6pVcJrCbhIqK7qosRit3UslqGOgU/vHG0tiNss/TQn2Q9s9alc5dZ
         cVawtXTsDNhEdHwQcCIw8CiSjoaV5qStZ9LYMGuBX4LgP5Z4xQdXENWR/HxaeNAmrUPO
         ODMqxoXpo4vBrZgbfFe2AXz+VhB8Uvi1PfmgbASI1hiJZZCjdH9phoyFYxzbE9ZkIC2N
         QrhNvDWkz+1vpYU2zUXP04hvINbsY8u0JZOOCNwBTTb228Y9UcHZnQ5rgE+sjtXGeX2u
         opCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=T4mxXhpF84I6akWlYzDe5Gw+8i4lTZ56Lv0l9+70zzM=;
        b=F2AZ/xmBe+Z8Jc7h9ezck6za33hPQ9lPhOk924eOriqh6ejXfO5Zb0iGkmoMx7KLvM
         927gzCXT79FuNW+hzGEJz+TNOWQxisPsQCegYatURvAIFwfO930XfOzaxlUKCfyPSicL
         xpG1sCn5zhWh86eW/ebsqQyjdaNjq6/D0Ce/yPm823kU3ui5U/njnipk0yYMdDPh3YcZ
         dsor0F0zSYbLgONMsR3NIvctMxjtHNgWnZiMLXi7xYMdIVOTpo+RxNpPH7y/huyU+dU+
         UKMiX4r7gjSuvFSxWZ3gzhVMyUqJOFtFLmEORgxaLvMXig3ptSWOaWOdwnutenCz/rI7
         yzsQ==
X-Gm-Message-State: ACrzQf0iS3qeTYnTK904AAnXOuX9S5iz7z1Ah+YGgxqsCq2V6mauaREx
        Im8Wm7Xr7UbPNeMmFmU85Xtj2Dsi9JM1aTUrZXGWww==
X-Google-Smtp-Source: AMsMyM7fskDFYjjfO6feGxVo9l3jfUKsuNvnXNSxzozxWTPS8A+yUPApE/+l3J4wYcEpLx4V1idVjApyI58Z1pbzQkk=
X-Received: by 2002:a67:ac08:0:b0:3a5:d34b:ae1 with SMTP id
 v8-20020a67ac08000000b003a5d34b0ae1mr1239151vse.46.1665100540584; Thu, 06 Oct
 2022 16:55:40 -0700 (PDT)
MIME-Version: 1.0
References: <20221005173713.1308832-1-yosryahmed@google.com>
 <CAOUHufaDhmHwY_qd2z26k6vK=eCHudJL1Pp4xALP25iZfbSJWA@mail.gmail.com>
 <CAJD7tkaS4T5dD3CpST2wsie5uP1ruHiaWL5AJv0j8V9=yiOuug@mail.gmail.com>
 <CAOUHufYKvbZTJ_ofD4+DyzY+DuHrRKYChnJVwqD7OKwe6sw-hw@mail.gmail.com>
 <Yz5XVZfq8abvMYJ8@cmpxchg.org> <CAJD7tkao9DU2e_2co_HgOm38PxvLqdRS=kHcOdRfqcqN6MRdaw@mail.gmail.com>
 <Yz71HQpeS6ccOIe2@cmpxchg.org> <CAJD7tka+wzjw8dHHGnz5jWULqhvbSF5WQ4gJCui7ztMUeVwfTg@mail.gmail.com>
 <CAOUHufZo5WMpHvZMevGfB_T4wxWn86Z76NcPK9GymoHK8-o0Kg@mail.gmail.com> <CAJD7tkZAKhtbd7Gk4hoN-y9p9PHAxQqv5p3ePZs=Au84=Y0ViQ@mail.gmail.com>
In-Reply-To: <CAJD7tkZAKhtbd7Gk4hoN-y9p9PHAxQqv5p3ePZs=Au84=Y0ViQ@mail.gmail.com>
From:   Yu Zhao <yuzhao@google.com>
Date:   Thu, 6 Oct 2022 17:55:04 -0600
Message-ID: <CAOUHufY07M=YxZ-Ycrtd8=7WAAcaXrJXK9w1qMrz7JMT44nrZA@mail.gmail.com>
Subject: Re: [PATCH v2] mm/vmscan: check references from all memcgs for
 swapbacked memory
To:     Yosry Ahmed <yosryahmed@google.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Shakeel Butt <shakeelb@google.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Greg Thelen <gthelen@google.com>,
        David Rientjes <rientjes@google.com>,
        Cgroups <cgroups@vger.kernel.org>, Linux-MM <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Thu, Oct 6, 2022 at 5:07 PM Yosry Ahmed <yosryahmed@google.com> wrote:
>
> On Thu, Oct 6, 2022 at 2:57 PM Yu Zhao <yuzhao@google.com> wrote:
> >
> > On Thu, Oct 6, 2022 at 12:30 PM Yosry Ahmed <yosryahmed@google.com> wrote:
> > >
> > > On Thu, Oct 6, 2022 at 8:32 AM Johannes Weiner <hannes@cmpxchg.org> wrote:
> > > >
> > > > On Thu, Oct 06, 2022 at 12:30:45AM -0700, Yosry Ahmed wrote:
> > > > > On Wed, Oct 5, 2022 at 9:19 PM Johannes Weiner <hannes@cmpxchg.org> wrote:
> > > > > >
> > > > > > On Wed, Oct 05, 2022 at 03:13:38PM -0600, Yu Zhao wrote:
> > > > > > > On Wed, Oct 5, 2022 at 3:02 PM Yosry Ahmed <yosryahmed@google.com> wrote:
> > > > > > > >
> > > > > > > > On Wed, Oct 5, 2022 at 1:48 PM Yu Zhao <yuzhao@google.com> wrote:
> > > > > > > > >
> > > > > > > > > On Wed, Oct 5, 2022 at 11:37 AM Yosry Ahmed <yosryahmed@google.com> wrote:
> > > > > > > > > >
> > > > > > > > > > During page/folio reclaim, we check if a folio is referenced using
> > > > > > > > > > folio_referenced() to avoid reclaiming folios that have been recently
> > > > > > > > > > accessed (hot memory). The rationale is that this memory is likely to be
> > > > > > > > > > accessed soon, and hence reclaiming it will cause a refault.
> > > > > > > > > >
> > > > > > > > > > For memcg reclaim, we currently only check accesses to the folio from
> > > > > > > > > > processes in the subtree of the target memcg. This behavior was
> > > > > > > > > > originally introduced by commit bed7161a519a ("Memory controller: make
> > > > > > > > > > page_referenced() cgroup aware") a long time ago. Back then, refaulted
> > > > > > > > > > pages would get charged to the memcg of the process that was faulting them
> > > > > > > > > > in. It made sense to only consider accesses coming from processes in the
> > > > > > > > > > subtree of target_mem_cgroup. If a page was charged to memcg A but only
> > > > > > > > > > being accessed by a sibling memcg B, we would reclaim it if memcg A is
> > > > > > > > > > is the reclaim target. memcg B can then fault it back in and get charged
> > > > > > > > > > for it appropriately.
> > > > > > > > > >
> > > > > > > > > > Today, this behavior still makes sense for file pages. However, unlike
> > > > > > > > > > file pages, when swapbacked pages are refaulted they are charged to the
> > > > > > > > > > memcg that was originally charged for them during swapping out. Which
> > > > > > > > > > means that if a swapbacked page is charged to memcg A but only used by
> > > > > > > > > > memcg B, and we reclaim it from memcg A, it would simply be faulted back
> > > > > > > > > > in and charged again to memcg A once memcg B accesses it. In that sense,
> > > > > > > > > > accesses from all memcgs matter equally when considering if a swapbacked
> > > > > > > > > > page/folio is a viable reclaim target.
> > > > > > > > > >
> > > > > > > > > > Modify folio_referenced() to always consider accesses from all memcgs if
> > > > > > > > > > the folio is swapbacked.
> > > > > > > > >
> > > > > > > > > It seems to me this change can potentially increase the number of
> > > > > > > > > zombie memcgs. Any risk assessment done on this?
> > > > > > > >
> > > > > > > > Do you mind elaborating the case(s) where this could happen? Is this
> > > > > > > > the cgroup v1 case in mem_cgroup_swapout() where we are reclaiming
> > > > > > > > from a zombie memcg and swapping out would let us move the charge to
> > > > > > > > the parent?
> > > > > > >
> > > > > > > The scenario is quite straightforward: for a page charged to memcg A
> > > > > > > and also actively used by memcg B, if we don't ignore the access from
> > > > > > > memcg B, we won't be able to reclaim it after memcg A is deleted.
> > > > > >
> > > > > > This patch changes the behavior of limit-induced reclaim. There is no
> > > > > > limit reclaim on A after it's been deleted. And parental/global
> > > > > > reclaim has always recognized outside references.
> > > > >
> > > > > Do you mind elaborating on the parental reclaim part?
> > > > >
> > > > > I am looking at the code and it looks like memcg reclaim of a parent
> > > > > (limit-induced or proactive) will only consider references coming from
> > > > > its subtree, even when reclaiming from its dead children. It looks
> > > > > like as long as sc->target_mem_cgroup is set, we ignore outside
> > > > > references (relative to sc->target_mem_cgroup).
> > > >
> > > > Yes, I was referring to outside of A.
> > > >
> > > > As of today, any siblings of A can already pin its memory after it's
> > > > dead. I suppose your patch would add cousins to that list. It doesn't
> > > > seem like a categorial difference to me.
> > > >
> > > > > If that is true, maybe we want to keep ignoring outside references for
> > > > > swap-backed pages if the folio is charged to a dead memcg? My
> > > > > understanding is that in this case we will uncharge the page from the
> > > > > dead memcg and charge the swapped entry to the parent, reducing the
> > > > > number of refs on the dead memcg. Without this check, this patch might
> > > > > prevent the charge from being moved to the parent in this case. WDYT?
> > > >
> > > > I don't think it's worth it. Keeping the semantics simple and behavior
> > > > predictable is IMO more valuable.
> > > >
> > > > It also wouldn't fix the scrape-before-rmdir issue Yu points out,
> > > > which I think is the more practical concern. In light of that, it
> > > > might be best to table the patch for now. (Until we have
> > > > reparent-on-delete for anon and file pages...)
> > >
> > > If we add a mem_cgroup_online() check, we partially solve the problem.
> > > Maybe scrape-before-rmdir will not reclaim those pages at once, but
> > > the next time we try to reclaim from the dead memcg (global, limit,
> > > proactive,..) we will reclaim the pages. So we will only be delaying
> > > the freeing of those zombie memcgs.
> >
> > As an observer, this seems to be the death by a thousand cuts of the
> > existing mechanism that Google has been using to virtually eliminate
> > zombie memcgs for the last decade.
> >
> > I understand the desire to fix a specific problem with this patch. But
> > it's methodically wrong to focus on specific problems without
> > considering the large picture and how it's evolving.
> >
> > Our internal memory.reclaim, which is being superseded, is a superset
> > of the mainline version. It has two flags relevant to this discussion:
> >     1. hierarchical walk of a parent
> >     2. target dead memcgs only
> > With these, our job scheduler (Borg) doesn't need to scrape before
> > rmdir at all. It does something called "applying root pressure",
> > which, as one might imagine, is to write to the root memory.reclaim
> > with the above flags. We have metrics on the efficiency of this
> > mechanism and they are closely monitored.
> >
> > Why is this important? Because Murphy's law is generally true for a
> > fleet when its scale and diversity is large and high enough. *We used
> > to run out memcg IDs.* And we are still carrying a patch that enlarges
> > swap_cgroup->id from unsigned short to unsigned int.
> >
> > Compared with the recharging proposal we have been discussing, the two
> > cases that the above solution can't help:
> >     1. kernel long pins
> >     2. foreign mlocks
> > But it's still *a lot* more reliable than the scrape-before-rmdir
> > approach (or scrape-after-rmdir if we can hold the FD open before
> > rmdir), because it offers unlimited retries and no dead memcgs, e.g.,
> > those created and deleted by jobs (not the job scheduler), can escape.
> >
> > Unless you can provide data, my past experience tells me that this
> > patch will make scrape-before-rmdir unacceptable (in terms of
> > effectiveness) to our fleet. Of course you can add additional code,
> > i.e., those two flags or the offline check, which I'm not object to.
>
> I agree that the zombie memcgs problem is a serious problem that needs
> to be dealt with, and recharging memory when a memcg is dying seems
> like a promising direction. However, this patch's goal is to improve
> reclaim of shared swapbacked memory in general, regardless of the
> zombie memcgs problem. I understand that the current version affects
> the zombie memcgs problem, but I believe this is an oversight that
> needs to be fixed, not something that should make us leave the reclaim
> problem unsolved.
>
> I think this patch + an offline check should be sufficient to fix the
> reclaim problem while not regressing the zombie memcgs problem for
> multiple reasons, see below.
>
> If we implement recharging memory of dying memcgs in the future, we
> can always come back and remove the offline check.
>
> > Frankly, let me ask the real question: are you really sure this is the
> > best for us and the rest of the community?
>
> Yes. This patch should improve reclaim of shared memory as I
> elaborated in my previous email, and with an offline check I believe
> we shouldn't be regressing the zombie memcgs problem whether for
> Google or the community, for the following reasons.

But it will regress a (non-root) parent who wishes to keep the hot
memory it shared with its deleted children to itself.

I think we should sleep on this.
