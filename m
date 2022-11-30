Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC70B63CD36
	for <lists+cgroups@lfdr.de>; Wed, 30 Nov 2022 03:15:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229580AbiK3CPF (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 29 Nov 2022 21:15:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229875AbiK3CPD (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 29 Nov 2022 21:15:03 -0500
Received: from mail-vs1-xe2e.google.com (mail-vs1-xe2e.google.com [IPv6:2607:f8b0:4864:20::e2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 053C231ED0
        for <cgroups@vger.kernel.org>; Tue, 29 Nov 2022 18:15:02 -0800 (PST)
Received: by mail-vs1-xe2e.google.com with SMTP id p15so7815903vsr.5
        for <cgroups@vger.kernel.org>; Tue, 29 Nov 2022 18:15:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=0JX7OVGXqhjLT5U0sxZCrCFZrJK+/Ptd8iza3dr3fMU=;
        b=fK/t1R6jEYGIaIccsQFMtY0W0OhO5tYVELmfG/KKVlOA90f7AmEAgqSwrhjlT087Ov
         Zjr15NzihKSnGTMQUHUxIhxuT3ou17X5W1y0nDS2O36heNDIwEE+Pb52dW4ajbGO+LkP
         ngDaqhU7EMfSMN9uIjJO7R0Ip1IQctKb8QDGKuZHd+m476Mm8rGCxaaFIYNrZdpXaBJf
         GEWTEfzEMM+r+wFLkgmMVmLT7rvvYEaYMTS1ZtZZJzieimTZJRwh5gxyuIutcw30B49Y
         CkYhspbjwY1xiX3TSmLqHlbBg7HvFlesXloEhio5Vw20Ve3MDTLyWhmqgf5/z0lQgg+n
         qnEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0JX7OVGXqhjLT5U0sxZCrCFZrJK+/Ptd8iza3dr3fMU=;
        b=sEjAa6BP/yrr0Fw/SR0l2WK6SDlGsS0+xh5ul6uTqfhZ0b30SpNeTk6d7K5jWNkIBT
         VuWANr5XhtV9cgINLGy5DXxQAqrOsnKfS9LHmiYXOrcG4QCwBweE/hlBUOXZTtcGzzwo
         yHJrZD85k2qNwYTer6cNaPZ07gLxVmVlavaQbWhKVyU2ysrKcZrp7Ai9pOpFbNzdiXnb
         kxicKX/0UgSo+lGdq4CtSokv+ywT2igZ/afIOZQwgZ5r2NOvp6lshdWAzmCD9dPaBVRj
         mxfDMI/SOnlIN4pYjnl3xs6NJPL5Akp6fBosrMLapsnHDBH48ZamSpTS5XHM1YtVdr41
         OkYw==
X-Gm-Message-State: ANoB5plJZB8I4mSFtY9/y1osNCJohgR4IE6a25TypQ8oZecGK0cgp1Hh
        SHsIpePN+PwqKsiT62q8NhRh7IgjBuuoMqAGC+nf9A==
X-Google-Smtp-Source: AA0mqf5qCx7brp/8Dmkd70vgLRjX378XaQj83zJ+INAgJDVwo6ip+MvAfzH9/EPsv41BaKjD1If4S16ThnMaeXL/KMA=
X-Received: by 2002:a05:6102:54a5:b0:3b0:7462:a88c with SMTP id
 bk37-20020a05610254a500b003b07462a88cmr18688692vsb.49.1669774500963; Tue, 29
 Nov 2022 18:15:00 -0800 (PST)
MIME-Version: 1.0
References: <20221122203850.2765015-1-almasrymina@google.com>
 <Y35fw2JSAeAddONg@cmpxchg.org> <CAHS8izN+xqM67XLT4y5qyYnGQMUWRQCJrdvf2gjTHd8nZ_=0sw@mail.gmail.com>
 <Y36XchdgTCsMP4jT@cmpxchg.org> <874juonbmv.fsf@yhuang6-desk2.ccr.corp.intel.com>
In-Reply-To: <874juonbmv.fsf@yhuang6-desk2.ccr.corp.intel.com>
From:   Mina Almasry <almasrymina@google.com>
Date:   Tue, 29 Nov 2022 18:14:49 -0800
Message-ID: <CAHS8izMhoHVCGxXGt8qRtf-fPpAR8=pTy7Rc3j2=Wf8vJz-C+g@mail.gmail.com>
Subject: Re: [RFC PATCH V1] mm: Disable demotion from proactive reclaim
To:     "Huang, Ying" <ying.huang@intel.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Yang Shi <yang.shi@linux.alibaba.com>,
        Yosry Ahmed <yosryahmed@google.com>,
        Tim Chen <tim.c.chen@linux.intel.com>, weixugc@google.com,
        shakeelb@google.com, gthelen@google.com, fvdl@google.com,
        Michal Hocko <mhocko@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Muchun Song <songmuchun@bytedance.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed, Nov 23, 2022 at 9:52 PM Huang, Ying <ying.huang@intel.com> wrote:
>
> Hi, Johannes,
>
> Johannes Weiner <hannes@cmpxchg.org> writes:
> [...]
> >
> > The fallback to reclaim actually strikes me as wrong.
> >
> > Think of reclaim as 'demoting' the pages to the storage tier. If we
> > have a RAM -> CXL -> storage hierarchy, we should demote from RAM to
> > CXL and from CXL to storage. If we reclaim a page from RAM, it means
> > we 'demote' it directly from RAM to storage, bypassing potentially a
> > huge amount of pages colder than it in CXL. That doesn't seem right.
> >
> > If demotion fails, IMO it shouldn't satisfy the reclaim request by
> > breaking the layering. Rather it should deflect that pressure to the
> > lower layers to make room. This makes sure we maintain an aging
> > pipeline that honors the memory tier hierarchy.
>
> Yes.  I think that we should avoid to fall back to reclaim as much as
> possible too.  Now, when we allocate memory for demotion
> (alloc_demote_page()), __GFP_KSWAPD_RECLAIM is used.  So, we will trigger

I may be missing something but as far I can tell reclaim is disabled
for allocations from lower tier memory:
https://elixir.bootlin.com/linux/v6.1-rc7/source/mm/vmscan.c#L1583

I think this is maybe a good thing when doing proactive demotion. In
this case we probably don't want to try to reclaim from lower tier
nodes and instead fail the proactive demotion. However I can see this
being desirable when the top tier nodes are under real memory pressure
to deflect that pressure to the lower tier nodes.

> kswapd reclaim on lower tier node to free some memory to avoid fall back
> to reclaim on current (higher tier) node.  This may be not good enough,
> for example, the following patch from Hasan may help via waking up
> kswapd earlier.
>
> https://lore.kernel.org/linux-mm/b45b9bf7cd3e21bca61d82dcd1eb692cd32c122c.1637778851.git.hasanalmaruf@fb.com/
>
> Do you know what is the next step plan for this patch?
>
> Should we do even more?
>
> From another point of view, I still think that we can use falling back
> to reclaim as the last resort to avoid OOM in some special situations,
> for example, most pages in the lowest tier node are mlock() or too hot
> to be reclaimed.
>
> > So I'm hesitant to design cgroup controls around the current behavior.

I sent RFC v2 patch:
https://lore.kernel.org/linux-mm/20221130020328.1009347-1-almasrymina@google.com/T/#u

Please take a look when convenient. Thanks!

> >
>
> Best Regards,
> Huang, Ying
>
