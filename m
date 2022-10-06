Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 195445F6AA8
	for <lists+cgroups@lfdr.de>; Thu,  6 Oct 2022 17:32:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230007AbiJFPcv (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 6 Oct 2022 11:32:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231845AbiJFPct (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 6 Oct 2022 11:32:49 -0400
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com [IPv6:2607:f8b0:4864:20::72b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C12F1A598C
        for <cgroups@vger.kernel.org>; Thu,  6 Oct 2022 08:32:47 -0700 (PDT)
Received: by mail-qk1-x72b.google.com with SMTP id o22so830598qkl.8
        for <cgroups@vger.kernel.org>; Thu, 06 Oct 2022 08:32:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=HD/3Y6U1aB12XT2sHowJ6F+GbBNpOcL+Q3nS96b8W9o=;
        b=4WqNJOFbpojr+On41IcjBSg7LLLaApk/OvMwSZrD9xiRQdqxbAuydQWa8UeYIvCyhO
         71w8L7bjt2nKU93JMcwDPianc+XdxnPNXX4B+xQCTOIoQHO//929+nqYjQTJ4rlCrGvX
         SxjZjTK/AM3XuEUPiQi7xuK8HCzqJ358fzfCO8zx1wSic9jk8EDKXu1vMKOBhSJO5PH/
         BkZrwgkqQfWTQrK2S+LIPDWTylL0Gn34/3zbK+msE1WdaqKmGo1IWGlwGh23B1zzkwvI
         ltbqb0bdy6Ex5VCWcVz5xASQbvnvcPLjQVq/AbT5Z7ixy5cZebpN23fMPkSxgtbzE6yn
         5DaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HD/3Y6U1aB12XT2sHowJ6F+GbBNpOcL+Q3nS96b8W9o=;
        b=6t0lfTU+HGj2AstTBe/yboZ8I7T57D3L+An0hENjDIASBv0pIM/AgZF2rHBS3n9vE7
         dRZzCgzK7evLgMbJ0RoxB3DB5o9Yo9ELEzkUK8HIJEZ4IEsmLGmcDsfobdCEaRGJH+Lb
         BFRYgQ32gBg1FRubQgBVpBpg6K5ll8kRWy/ViwNnrVr8NoV31UfP2r60Wg8DheQDjd0l
         pjaf3gIURu2u+ntyt4c+SYa5SZg1mH9R67pScOfMmTPLCwSF4n7GyL9i1UyvJpZrXOHs
         HrFTAvWhTvGoDQTyhTnG1cc+lAUYRL0mejblc/o+qjQl6vHqnA/H+bsNPe6pjMQL6gex
         WH1A==
X-Gm-Message-State: ACrzQf1v5GRLcfM31zJAqqdumAbFPlFOEks6X+o5A/TzS61c+9x7xyc2
        l49mxOLgDjwtksRS+5Cyv7IGDw==
X-Google-Smtp-Source: AMsMyM6h9Ks8qzhTcb3j+T+Wy042tMCFaCET4BDkScnpQTRIB7TkqOsMcUKrv9UyxDhWUPOVdjf1Aw==
X-Received: by 2002:a05:620a:16d0:b0:6cf:a482:ab21 with SMTP id a16-20020a05620a16d000b006cfa482ab21mr484675qkn.771.1665070366892;
        Thu, 06 Oct 2022 08:32:46 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::8a16])
        by smtp.gmail.com with ESMTPSA id m21-20020a05620a291500b006b8e8c657ccsm21065422qkp.117.2022.10.06.08.32.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Oct 2022 08:32:46 -0700 (PDT)
Date:   Thu, 6 Oct 2022 11:32:45 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Yosry Ahmed <yosryahmed@google.com>
Cc:     Yu Zhao <yuzhao@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Shakeel Butt <shakeelb@google.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Greg Thelen <gthelen@google.com>,
        David Rientjes <rientjes@google.com>,
        Cgroups <cgroups@vger.kernel.org>, Linux-MM <linux-mm@kvack.org>
Subject: Re: [PATCH v2] mm/vmscan: check references from all memcgs for
 swapbacked memory
Message-ID: <Yz71HQpeS6ccOIe2@cmpxchg.org>
References: <20221005173713.1308832-1-yosryahmed@google.com>
 <CAOUHufaDhmHwY_qd2z26k6vK=eCHudJL1Pp4xALP25iZfbSJWA@mail.gmail.com>
 <CAJD7tkaS4T5dD3CpST2wsie5uP1ruHiaWL5AJv0j8V9=yiOuug@mail.gmail.com>
 <CAOUHufYKvbZTJ_ofD4+DyzY+DuHrRKYChnJVwqD7OKwe6sw-hw@mail.gmail.com>
 <Yz5XVZfq8abvMYJ8@cmpxchg.org>
 <CAJD7tkao9DU2e_2co_HgOm38PxvLqdRS=kHcOdRfqcqN6MRdaw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJD7tkao9DU2e_2co_HgOm38PxvLqdRS=kHcOdRfqcqN6MRdaw@mail.gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Thu, Oct 06, 2022 at 12:30:45AM -0700, Yosry Ahmed wrote:
> On Wed, Oct 5, 2022 at 9:19 PM Johannes Weiner <hannes@cmpxchg.org> wrote:
> >
> > On Wed, Oct 05, 2022 at 03:13:38PM -0600, Yu Zhao wrote:
> > > On Wed, Oct 5, 2022 at 3:02 PM Yosry Ahmed <yosryahmed@google.com> wrote:
> > > >
> > > > On Wed, Oct 5, 2022 at 1:48 PM Yu Zhao <yuzhao@google.com> wrote:
> > > > >
> > > > > On Wed, Oct 5, 2022 at 11:37 AM Yosry Ahmed <yosryahmed@google.com> wrote:
> > > > > >
> > > > > > During page/folio reclaim, we check if a folio is referenced using
> > > > > > folio_referenced() to avoid reclaiming folios that have been recently
> > > > > > accessed (hot memory). The rationale is that this memory is likely to be
> > > > > > accessed soon, and hence reclaiming it will cause a refault.
> > > > > >
> > > > > > For memcg reclaim, we currently only check accesses to the folio from
> > > > > > processes in the subtree of the target memcg. This behavior was
> > > > > > originally introduced by commit bed7161a519a ("Memory controller: make
> > > > > > page_referenced() cgroup aware") a long time ago. Back then, refaulted
> > > > > > pages would get charged to the memcg of the process that was faulting them
> > > > > > in. It made sense to only consider accesses coming from processes in the
> > > > > > subtree of target_mem_cgroup. If a page was charged to memcg A but only
> > > > > > being accessed by a sibling memcg B, we would reclaim it if memcg A is
> > > > > > is the reclaim target. memcg B can then fault it back in and get charged
> > > > > > for it appropriately.
> > > > > >
> > > > > > Today, this behavior still makes sense for file pages. However, unlike
> > > > > > file pages, when swapbacked pages are refaulted they are charged to the
> > > > > > memcg that was originally charged for them during swapping out. Which
> > > > > > means that if a swapbacked page is charged to memcg A but only used by
> > > > > > memcg B, and we reclaim it from memcg A, it would simply be faulted back
> > > > > > in and charged again to memcg A once memcg B accesses it. In that sense,
> > > > > > accesses from all memcgs matter equally when considering if a swapbacked
> > > > > > page/folio is a viable reclaim target.
> > > > > >
> > > > > > Modify folio_referenced() to always consider accesses from all memcgs if
> > > > > > the folio is swapbacked.
> > > > >
> > > > > It seems to me this change can potentially increase the number of
> > > > > zombie memcgs. Any risk assessment done on this?
> > > >
> > > > Do you mind elaborating the case(s) where this could happen? Is this
> > > > the cgroup v1 case in mem_cgroup_swapout() where we are reclaiming
> > > > from a zombie memcg and swapping out would let us move the charge to
> > > > the parent?
> > >
> > > The scenario is quite straightforward: for a page charged to memcg A
> > > and also actively used by memcg B, if we don't ignore the access from
> > > memcg B, we won't be able to reclaim it after memcg A is deleted.
> >
> > This patch changes the behavior of limit-induced reclaim. There is no
> > limit reclaim on A after it's been deleted. And parental/global
> > reclaim has always recognized outside references.
> 
> Do you mind elaborating on the parental reclaim part?
> 
> I am looking at the code and it looks like memcg reclaim of a parent
> (limit-induced or proactive) will only consider references coming from
> its subtree, even when reclaiming from its dead children. It looks
> like as long as sc->target_mem_cgroup is set, we ignore outside
> references (relative to sc->target_mem_cgroup).

Yes, I was referring to outside of A.

As of today, any siblings of A can already pin its memory after it's
dead. I suppose your patch would add cousins to that list. It doesn't
seem like a categorial difference to me.

> If that is true, maybe we want to keep ignoring outside references for
> swap-backed pages if the folio is charged to a dead memcg? My
> understanding is that in this case we will uncharge the page from the
> dead memcg and charge the swapped entry to the parent, reducing the
> number of refs on the dead memcg. Without this check, this patch might
> prevent the charge from being moved to the parent in this case. WDYT?

I don't think it's worth it. Keeping the semantics simple and behavior
predictable is IMO more valuable.

It also wouldn't fix the scrape-before-rmdir issue Yu points out,
which I think is the more practical concern. In light of that, it
might be best to table the patch for now. (Until we have
reparent-on-delete for anon and file pages...)
