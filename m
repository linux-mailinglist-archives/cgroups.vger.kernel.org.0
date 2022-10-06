Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADC225F6D80
	for <lists+cgroups@lfdr.de>; Thu,  6 Oct 2022 20:30:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231859AbiJFSaP (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 6 Oct 2022 14:30:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229919AbiJFSaL (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 6 Oct 2022 14:30:11 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE9991ADA8
        for <cgroups@vger.kernel.org>; Thu,  6 Oct 2022 11:30:09 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id j7so3990192wrr.3
        for <cgroups@vger.kernel.org>; Thu, 06 Oct 2022 11:30:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=pLGjZ4p6JTBB7Y0BGVc8c4hG36gv02ysqb6s9xm49co=;
        b=TB7zTZHRt2srLvEvWnEi8O8VBBYMd1+hUcIERL0Ah6+1EIiwcougo9JK1rP8OJsdAx
         kCi+FSvGacQH65J7O7iSM2x02gaqviBwZOhuBM51ROjLEfWMnyDMBdJRh20w73BbQ8I2
         xHa6MgErOLQQI8ajNwCLaNdNJuA5b6cWfr/a5vvyM8iz9O61Y38et68jeoRbB0pMxcAK
         7iA6SNWeET/1cibfz6Fbqm1bXKluwvBZtmD0YMM5OyoxZL+EDbdpQB9wyKuOHPTfdGQP
         SH1leFNmglhjqKmcVWioc43q1D/daeEC726lqtZLevMnDxMnx5OTgvsADp7FMlUD0IvN
         /gwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=pLGjZ4p6JTBB7Y0BGVc8c4hG36gv02ysqb6s9xm49co=;
        b=ENz2NhfosGfXv3Eri2VPxhcqKFYC+pf9aJ6YmWC2us+kZNl5dxuvjXLgEnrSagnWul
         /7PfFkEC/31F/EpkiyqWoSRzyRZm+suYZnur8IB+U//+/x92dQuhK/NzKuI+yLlwQRXI
         0rIoaRFEjpVYQFTRT9plPxGm5s1Y9yAeHCZuUnsxyhj4VHc3nH1VM171PeD5xqpdwXHX
         xoUEOEYaYeKrCeMm+rG2I8/339C2gGIUdtoOy39FlhOxpUvFJwAS55wOmzoteBwIYV08
         9xMb1E5Zu0WCdVtTBZmZnppPWCLG2FSBIthI9LGTgWRHR+D8lvpgjsQlbXlGuNaCm99M
         FsfQ==
X-Gm-Message-State: ACrzQf0u3DvwA6F8zfzUOjo80QjwCEkFwEo515q0JG74sdBF5dMIgZmE
        +tqEooX4H78OexRCgdSskAprM/glwDAlJ0h62sO3DQ==
X-Google-Smtp-Source: AMsMyM4gmR1fJZ8rSrEiDtH0ZLkVjzGKDIBrFmrQSAASIC388ls3eIt7Rzf4aljCZvLXD/xTPT3pYJ6paaEcr9+GoLg=
X-Received: by 2002:a5d:5a82:0:b0:224:f744:1799 with SMTP id
 bp2-20020a5d5a82000000b00224f7441799mr839165wrb.582.1665081008218; Thu, 06
 Oct 2022 11:30:08 -0700 (PDT)
MIME-Version: 1.0
References: <20221005173713.1308832-1-yosryahmed@google.com>
 <CAOUHufaDhmHwY_qd2z26k6vK=eCHudJL1Pp4xALP25iZfbSJWA@mail.gmail.com>
 <CAJD7tkaS4T5dD3CpST2wsie5uP1ruHiaWL5AJv0j8V9=yiOuug@mail.gmail.com>
 <CAOUHufYKvbZTJ_ofD4+DyzY+DuHrRKYChnJVwqD7OKwe6sw-hw@mail.gmail.com>
 <Yz5XVZfq8abvMYJ8@cmpxchg.org> <CAJD7tkao9DU2e_2co_HgOm38PxvLqdRS=kHcOdRfqcqN6MRdaw@mail.gmail.com>
 <Yz71HQpeS6ccOIe2@cmpxchg.org>
In-Reply-To: <Yz71HQpeS6ccOIe2@cmpxchg.org>
From:   Yosry Ahmed <yosryahmed@google.com>
Date:   Thu, 6 Oct 2022 11:29:31 -0700
Message-ID: <CAJD7tka+wzjw8dHHGnz5jWULqhvbSF5WQ4gJCui7ztMUeVwfTg@mail.gmail.com>
Subject: Re: [PATCH v2] mm/vmscan: check references from all memcgs for
 swapbacked memory
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Yu Zhao <yuzhao@google.com>,
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

On Thu, Oct 6, 2022 at 8:32 AM Johannes Weiner <hannes@cmpxchg.org> wrote:
>
> On Thu, Oct 06, 2022 at 12:30:45AM -0700, Yosry Ahmed wrote:
> > On Wed, Oct 5, 2022 at 9:19 PM Johannes Weiner <hannes@cmpxchg.org> wrote:
> > >
> > > On Wed, Oct 05, 2022 at 03:13:38PM -0600, Yu Zhao wrote:
> > > > On Wed, Oct 5, 2022 at 3:02 PM Yosry Ahmed <yosryahmed@google.com> wrote:
> > > > >
> > > > > On Wed, Oct 5, 2022 at 1:48 PM Yu Zhao <yuzhao@google.com> wrote:
> > > > > >
> > > > > > On Wed, Oct 5, 2022 at 11:37 AM Yosry Ahmed <yosryahmed@google.com> wrote:
> > > > > > >
> > > > > > > During page/folio reclaim, we check if a folio is referenced using
> > > > > > > folio_referenced() to avoid reclaiming folios that have been recently
> > > > > > > accessed (hot memory). The rationale is that this memory is likely to be
> > > > > > > accessed soon, and hence reclaiming it will cause a refault.
> > > > > > >
> > > > > > > For memcg reclaim, we currently only check accesses to the folio from
> > > > > > > processes in the subtree of the target memcg. This behavior was
> > > > > > > originally introduced by commit bed7161a519a ("Memory controller: make
> > > > > > > page_referenced() cgroup aware") a long time ago. Back then, refaulted
> > > > > > > pages would get charged to the memcg of the process that was faulting them
> > > > > > > in. It made sense to only consider accesses coming from processes in the
> > > > > > > subtree of target_mem_cgroup. If a page was charged to memcg A but only
> > > > > > > being accessed by a sibling memcg B, we would reclaim it if memcg A is
> > > > > > > is the reclaim target. memcg B can then fault it back in and get charged
> > > > > > > for it appropriately.
> > > > > > >
> > > > > > > Today, this behavior still makes sense for file pages. However, unlike
> > > > > > > file pages, when swapbacked pages are refaulted they are charged to the
> > > > > > > memcg that was originally charged for them during swapping out. Which
> > > > > > > means that if a swapbacked page is charged to memcg A but only used by
> > > > > > > memcg B, and we reclaim it from memcg A, it would simply be faulted back
> > > > > > > in and charged again to memcg A once memcg B accesses it. In that sense,
> > > > > > > accesses from all memcgs matter equally when considering if a swapbacked
> > > > > > > page/folio is a viable reclaim target.
> > > > > > >
> > > > > > > Modify folio_referenced() to always consider accesses from all memcgs if
> > > > > > > the folio is swapbacked.
> > > > > >
> > > > > > It seems to me this change can potentially increase the number of
> > > > > > zombie memcgs. Any risk assessment done on this?
> > > > >
> > > > > Do you mind elaborating the case(s) where this could happen? Is this
> > > > > the cgroup v1 case in mem_cgroup_swapout() where we are reclaiming
> > > > > from a zombie memcg and swapping out would let us move the charge to
> > > > > the parent?
> > > >
> > > > The scenario is quite straightforward: for a page charged to memcg A
> > > > and also actively used by memcg B, if we don't ignore the access from
> > > > memcg B, we won't be able to reclaim it after memcg A is deleted.
> > >
> > > This patch changes the behavior of limit-induced reclaim. There is no
> > > limit reclaim on A after it's been deleted. And parental/global
> > > reclaim has always recognized outside references.
> >
> > Do you mind elaborating on the parental reclaim part?
> >
> > I am looking at the code and it looks like memcg reclaim of a parent
> > (limit-induced or proactive) will only consider references coming from
> > its subtree, even when reclaiming from its dead children. It looks
> > like as long as sc->target_mem_cgroup is set, we ignore outside
> > references (relative to sc->target_mem_cgroup).
>
> Yes, I was referring to outside of A.
>
> As of today, any siblings of A can already pin its memory after it's
> dead. I suppose your patch would add cousins to that list. It doesn't
> seem like a categorial difference to me.
>
> > If that is true, maybe we want to keep ignoring outside references for
> > swap-backed pages if the folio is charged to a dead memcg? My
> > understanding is that in this case we will uncharge the page from the
> > dead memcg and charge the swapped entry to the parent, reducing the
> > number of refs on the dead memcg. Without this check, this patch might
> > prevent the charge from being moved to the parent in this case. WDYT?
>
> I don't think it's worth it. Keeping the semantics simple and behavior
> predictable is IMO more valuable.
>
> It also wouldn't fix the scrape-before-rmdir issue Yu points out,
> which I think is the more practical concern. In light of that, it
> might be best to table the patch for now. (Until we have
> reparent-on-delete for anon and file pages...)

If we add a mem_cgroup_online() check, we partially solve the problem.
Maybe scrape-before-rmdir will not reclaim those pages at once, but
the next time we try to reclaim from the dead memcg (global, limit,
proactive,..) we will reclaim the pages. So we will only be delaying
the freeing of those zombie memcgs.

We have had a variant of this behavior in our production for a while,
and we haven't been having a zombie problem, but I guess the way our
userspace is setup is smart enough to stop referencing shared memory
charged to a dead memcg. One could argue that in general, having
swap-backed pages charged to a dead memcg is less common compared to
file pages.

Anyway, I wanted to give some background about why this is a real
problem that we have been facing. If a tmpfs mount is used by multiple
memcgs (say A and B), and we try to reclaim fromA using
memory.reclaim, we would observe pages that are more heavily used by B
as cold and reclaim them. Afterwards, they get swapped back once B
accesses them again, and charged back to A. We observe increased
refaults and fallback on proactive reclaim, missing the actual cold
memory. With this behavior, reclaim chooses pages that are cold
relative to both A and B, we observe less refaults, and end up
actually trimming cold memory. I suspect the same can happen with
limit-induced reclaim, where memcg A keeps hits its limit, we may
reclaim pages used by B, they get refaulted back in, we go to reclaim
again,... thrashing.

So it is a real problem that we are trying to solve. Given that adding
an online check would partially solves the scrape-before-rmdir problem
(zombie memcgs might stick around a little bit longer, but they should
eventually go away eventually), and that this patch addresses a real
problem and would overall improve reclaim policy for living memcgs
(which is *hopefully* the majority), it would be great if you could
reconsider this. Please let me know if anything that I have said
doesn't make sense to you.
