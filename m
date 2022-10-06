Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32D2A5F7187
	for <lists+cgroups@lfdr.de>; Fri,  7 Oct 2022 01:07:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229529AbiJFXHn (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 6 Oct 2022 19:07:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229614AbiJFXHm (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 6 Oct 2022 19:07:42 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D118FB48A8
        for <cgroups@vger.kernel.org>; Thu,  6 Oct 2022 16:07:40 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id b4so4840239wrs.1
        for <cgroups@vger.kernel.org>; Thu, 06 Oct 2022 16:07:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=ELjLnSOUcHIeqK95gfd+ZLIPRkJZ8GrVrKNIZucF8Dc=;
        b=XPIOx2SSBiO3YyMi7Nhb8Htq3ra0JsZ/bF0zVfIl+RbnqOchK5bn168GneznsDaWi8
         8Ar5OQe4Ercb8vrp3t4ZttP2iI4c1Rxy+GKHyGR+bdaf/HoK53muscIZCJZkMJPyNumf
         KLTHJJ/MakCxzoOYlXb5Hl5g2N/0lNW8AqkUOdZnl88lvjpHHP2aP86riLmH+zbpHJYc
         FPvtqfwI31EzVNVWd9t2f+sPnGeTnrNTbEMG/sNKk5FspVHXVC7ddPBe8VB5PqxjzKkn
         ev2LAWfE5N+bFROT5lRcfIkWfo/8+jlNRowMt7Fw4FerR3FCA9d0kdsSo83v5ksLTi53
         6euw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=ELjLnSOUcHIeqK95gfd+ZLIPRkJZ8GrVrKNIZucF8Dc=;
        b=qIKPA9GBtNzqc9uOmsDw2+PnOn0/Hj4sw45FradVY36k6KKN8kK8w4TZtnqkuIZ+qH
         CQ38tEX6dzmcl6Rp3jt6KtzYeChzPUPboGKwECKVf3YTSITuSjjh2Tny/HRsWX7/2dAI
         HWn8lZ53dsbd25EH3dquhu2EOAo/GadHx07XfJWd04UeJaywUkHpge8T3ohr0clVtNbX
         DTJ9FrSEwIFI5sECbPppDDMCiBI28xD73GfXvssL2/uKompq5qY19xWHkvqMutLOfF95
         gnR2TU1/u0BstgKXByEI5sA7wd4YU3qtq26tknwwpkbDS5rHPzLpUYUQYK4dtD9DloSc
         0dHw==
X-Gm-Message-State: ACrzQf3JB2YTlD5WUR7oktkraT00SonWYQJZ2kmg3Qpgb6uDFu82+9ZH
        rg89SJyjvADnaBOzVj9mkpQMuFQheeNastMiWAJ8Jw==
X-Google-Smtp-Source: AMsMyM6WTTKC66A3zlL/lGZp6jqWLfBWzqUTP+FCRAUJ7Zu0o7dBSOAVIt3nnjAovGNv8mtazO4DFwP9Uc9jXmhanLc=
X-Received: by 2002:a5d:64e8:0:b0:22a:bbb0:fa with SMTP id g8-20020a5d64e8000000b0022abbb000famr1410594wri.372.1665097659137;
 Thu, 06 Oct 2022 16:07:39 -0700 (PDT)
MIME-Version: 1.0
References: <20221005173713.1308832-1-yosryahmed@google.com>
 <CAOUHufaDhmHwY_qd2z26k6vK=eCHudJL1Pp4xALP25iZfbSJWA@mail.gmail.com>
 <CAJD7tkaS4T5dD3CpST2wsie5uP1ruHiaWL5AJv0j8V9=yiOuug@mail.gmail.com>
 <CAOUHufYKvbZTJ_ofD4+DyzY+DuHrRKYChnJVwqD7OKwe6sw-hw@mail.gmail.com>
 <Yz5XVZfq8abvMYJ8@cmpxchg.org> <CAJD7tkao9DU2e_2co_HgOm38PxvLqdRS=kHcOdRfqcqN6MRdaw@mail.gmail.com>
 <Yz71HQpeS6ccOIe2@cmpxchg.org> <CAJD7tka+wzjw8dHHGnz5jWULqhvbSF5WQ4gJCui7ztMUeVwfTg@mail.gmail.com>
 <CAOUHufZo5WMpHvZMevGfB_T4wxWn86Z76NcPK9GymoHK8-o0Kg@mail.gmail.com>
In-Reply-To: <CAOUHufZo5WMpHvZMevGfB_T4wxWn86Z76NcPK9GymoHK8-o0Kg@mail.gmail.com>
From:   Yosry Ahmed <yosryahmed@google.com>
Date:   Thu, 6 Oct 2022 16:07:02 -0700
Message-ID: <CAJD7tkZAKhtbd7Gk4hoN-y9p9PHAxQqv5p3ePZs=Au84=Y0ViQ@mail.gmail.com>
Subject: Re: [PATCH v2] mm/vmscan: check references from all memcgs for
 swapbacked memory
To:     Yu Zhao <yuzhao@google.com>
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

On Thu, Oct 6, 2022 at 2:57 PM Yu Zhao <yuzhao@google.com> wrote:
>
> On Thu, Oct 6, 2022 at 12:30 PM Yosry Ahmed <yosryahmed@google.com> wrote:
> >
> > On Thu, Oct 6, 2022 at 8:32 AM Johannes Weiner <hannes@cmpxchg.org> wrote:
> > >
> > > On Thu, Oct 06, 2022 at 12:30:45AM -0700, Yosry Ahmed wrote:
> > > > On Wed, Oct 5, 2022 at 9:19 PM Johannes Weiner <hannes@cmpxchg.org> wrote:
> > > > >
> > > > > On Wed, Oct 05, 2022 at 03:13:38PM -0600, Yu Zhao wrote:
> > > > > > On Wed, Oct 5, 2022 at 3:02 PM Yosry Ahmed <yosryahmed@google.com> wrote:
> > > > > > >
> > > > > > > On Wed, Oct 5, 2022 at 1:48 PM Yu Zhao <yuzhao@google.com> wrote:
> > > > > > > >
> > > > > > > > On Wed, Oct 5, 2022 at 11:37 AM Yosry Ahmed <yosryahmed@google.com> wrote:
> > > > > > > > >
> > > > > > > > > During page/folio reclaim, we check if a folio is referenced using
> > > > > > > > > folio_referenced() to avoid reclaiming folios that have been recently
> > > > > > > > > accessed (hot memory). The rationale is that this memory is likely to be
> > > > > > > > > accessed soon, and hence reclaiming it will cause a refault.
> > > > > > > > >
> > > > > > > > > For memcg reclaim, we currently only check accesses to the folio from
> > > > > > > > > processes in the subtree of the target memcg. This behavior was
> > > > > > > > > originally introduced by commit bed7161a519a ("Memory controller: make
> > > > > > > > > page_referenced() cgroup aware") a long time ago. Back then, refaulted
> > > > > > > > > pages would get charged to the memcg of the process that was faulting them
> > > > > > > > > in. It made sense to only consider accesses coming from processes in the
> > > > > > > > > subtree of target_mem_cgroup. If a page was charged to memcg A but only
> > > > > > > > > being accessed by a sibling memcg B, we would reclaim it if memcg A is
> > > > > > > > > is the reclaim target. memcg B can then fault it back in and get charged
> > > > > > > > > for it appropriately.
> > > > > > > > >
> > > > > > > > > Today, this behavior still makes sense for file pages. However, unlike
> > > > > > > > > file pages, when swapbacked pages are refaulted they are charged to the
> > > > > > > > > memcg that was originally charged for them during swapping out. Which
> > > > > > > > > means that if a swapbacked page is charged to memcg A but only used by
> > > > > > > > > memcg B, and we reclaim it from memcg A, it would simply be faulted back
> > > > > > > > > in and charged again to memcg A once memcg B accesses it. In that sense,
> > > > > > > > > accesses from all memcgs matter equally when considering if a swapbacked
> > > > > > > > > page/folio is a viable reclaim target.
> > > > > > > > >
> > > > > > > > > Modify folio_referenced() to always consider accesses from all memcgs if
> > > > > > > > > the folio is swapbacked.
> > > > > > > >
> > > > > > > > It seems to me this change can potentially increase the number of
> > > > > > > > zombie memcgs. Any risk assessment done on this?
> > > > > > >
> > > > > > > Do you mind elaborating the case(s) where this could happen? Is this
> > > > > > > the cgroup v1 case in mem_cgroup_swapout() where we are reclaiming
> > > > > > > from a zombie memcg and swapping out would let us move the charge to
> > > > > > > the parent?
> > > > > >
> > > > > > The scenario is quite straightforward: for a page charged to memcg A
> > > > > > and also actively used by memcg B, if we don't ignore the access from
> > > > > > memcg B, we won't be able to reclaim it after memcg A is deleted.
> > > > >
> > > > > This patch changes the behavior of limit-induced reclaim. There is no
> > > > > limit reclaim on A after it's been deleted. And parental/global
> > > > > reclaim has always recognized outside references.
> > > >
> > > > Do you mind elaborating on the parental reclaim part?
> > > >
> > > > I am looking at the code and it looks like memcg reclaim of a parent
> > > > (limit-induced or proactive) will only consider references coming from
> > > > its subtree, even when reclaiming from its dead children. It looks
> > > > like as long as sc->target_mem_cgroup is set, we ignore outside
> > > > references (relative to sc->target_mem_cgroup).
> > >
> > > Yes, I was referring to outside of A.
> > >
> > > As of today, any siblings of A can already pin its memory after it's
> > > dead. I suppose your patch would add cousins to that list. It doesn't
> > > seem like a categorial difference to me.
> > >
> > > > If that is true, maybe we want to keep ignoring outside references for
> > > > swap-backed pages if the folio is charged to a dead memcg? My
> > > > understanding is that in this case we will uncharge the page from the
> > > > dead memcg and charge the swapped entry to the parent, reducing the
> > > > number of refs on the dead memcg. Without this check, this patch might
> > > > prevent the charge from being moved to the parent in this case. WDYT?
> > >
> > > I don't think it's worth it. Keeping the semantics simple and behavior
> > > predictable is IMO more valuable.
> > >
> > > It also wouldn't fix the scrape-before-rmdir issue Yu points out,
> > > which I think is the more practical concern. In light of that, it
> > > might be best to table the patch for now. (Until we have
> > > reparent-on-delete for anon and file pages...)
> >
> > If we add a mem_cgroup_online() check, we partially solve the problem.
> > Maybe scrape-before-rmdir will not reclaim those pages at once, but
> > the next time we try to reclaim from the dead memcg (global, limit,
> > proactive,..) we will reclaim the pages. So we will only be delaying
> > the freeing of those zombie memcgs.
>
> As an observer, this seems to be the death by a thousand cuts of the
> existing mechanism that Google has been using to virtually eliminate
> zombie memcgs for the last decade.
>
> I understand the desire to fix a specific problem with this patch. But
> it's methodically wrong to focus on specific problems without
> considering the large picture and how it's evolving.
>
> Our internal memory.reclaim, which is being superseded, is a superset
> of the mainline version. It has two flags relevant to this discussion:
>     1. hierarchical walk of a parent
>     2. target dead memcgs only
> With these, our job scheduler (Borg) doesn't need to scrape before
> rmdir at all. It does something called "applying root pressure",
> which, as one might imagine, is to write to the root memory.reclaim
> with the above flags. We have metrics on the efficiency of this
> mechanism and they are closely monitored.
>
> Why is this important? Because Murphy's law is generally true for a
> fleet when its scale and diversity is large and high enough. *We used
> to run out memcg IDs.* And we are still carrying a patch that enlarges
> swap_cgroup->id from unsigned short to unsigned int.
>
> Compared with the recharging proposal we have been discussing, the two
> cases that the above solution can't help:
>     1. kernel long pins
>     2. foreign mlocks
> But it's still *a lot* more reliable than the scrape-before-rmdir
> approach (or scrape-after-rmdir if we can hold the FD open before
> rmdir), because it offers unlimited retries and no dead memcgs, e.g.,
> those created and deleted by jobs (not the job scheduler), can escape.
>
> Unless you can provide data, my past experience tells me that this
> patch will make scrape-before-rmdir unacceptable (in terms of
> effectiveness) to our fleet. Of course you can add additional code,
> i.e., those two flags or the offline check, which I'm not object to.

I agree that the zombie memcgs problem is a serious problem that needs
to be dealt with, and recharging memory when a memcg is dying seems
like a promising direction. However, this patch's goal is to improve
reclaim of shared swapbacked memory in general, regardless of the
zombie memcgs problem. I understand that the current version affects
the zombie memcgs problem, but I believe this is an oversight that
needs to be fixed, not something that should make us leave the reclaim
problem unsolved.

I think this patch + an offline check should be sufficient to fix the
reclaim problem while not regressing the zombie memcgs problem for
multiple reasons, see below.

If we implement recharging memory of dying memcgs in the future, we
can always come back and remove the offline check.

> Frankly, let me ask the real question: are you really sure this is the
> best for us and the rest of the community?

Yes. This patch should improve reclaim of shared memory as I
elaborated in my previous email, and with an offline check I believe
we shouldn't be regressing the zombie memcgs problem whether for
Google or the community, for the following reasons.

For Google:
a) With an offline check, our root memcg pressure method should remain
unaffected, as this patch + offline check should be nop for dead
memcgs.
b) The current version of our internal memory.reclaim actually
considers accesses from outside memcgs, specifically for the reason I
am sending this patch for. In retrospect, maybe this should *not* be
the case for the root zombie cleanup scenario, but maybe this was an
oversight, or it wasn't the case originally. Anyway, as I have
mentioned before, I think for the case of shared memory our userspace
has become smart enough to stop referencing the shared memory charged
to dead memcgs.

For the community:
- In the scenario of scrape-before-rmdir where that memcg has shared
memory charged to it (which shouldn't be very likely), this patch
would only delay freeing the dead memcgs until the next reclaim cycle.
Given that memory.reclaim was only recently upstreamed, and
memory.force_empty is not in cgroup v2, I am not really sure if a lot
of people are depending on this scrape-before-rmdir behavior.

For both Google and the community, we get a better reclaim policy for
shared memory.

Again, this conversation got quite derailed. There is a clear problem
with reclaiming shared memory that we are trying to fix. We should not
regress the zombie cleanup behavior (thanks Yu for catching that), but
hopefully this can be accomplished with a simple offline check.

Does this make sense to you, Yu and Johannes? If yes, I can send a v3
with an added offline check.

>
> (I think the recharging proposal is.)
