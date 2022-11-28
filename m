Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9B0F63B4C2
	for <lists+cgroups@lfdr.de>; Mon, 28 Nov 2022 23:24:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234556AbiK1WYR (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 28 Nov 2022 17:24:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232825AbiK1WYQ (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 28 Nov 2022 17:24:16 -0500
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0DF010FC6;
        Mon, 28 Nov 2022 14:24:14 -0800 (PST)
Received: by mail-pl1-x632.google.com with SMTP id p24so7852888plw.1;
        Mon, 28 Nov 2022 14:24:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ChSR6Hj3C9VOEQNkpeQ6mJNLM6aWG/Pf82PGUg9D7GM=;
        b=TJ3UVG5hY7eNPG/NI1+Ofd6ZgVBVNg0o4s4HC8hmb56J7fnfnYX6byUPJntUVjbkvM
         mbnSLnfDDAqp0j6WdmpnSxgAZER30CcMUE01FP/WqAi251v0v93rP+fWvJvDm1c0MKLf
         JACq0lvFkIkdQnDeDjDdZ2QkSGcxld+nGK8y/E8+E3LId+HRRBJ/7BbGsIy0cCBmz+RI
         4RNo00M5vyg1Z3X/UB3Y4lcHplxj7jE5PXU6vu3SMsz6h+rBWLgPlwGljviih4aLPeip
         6V+bTBVJuLFBKr3gwSSxNuDqLfg3IqOSLOd+h99tcqHcWw0UyQy3YdrM97RCyGidEd/i
         uSvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ChSR6Hj3C9VOEQNkpeQ6mJNLM6aWG/Pf82PGUg9D7GM=;
        b=pdY6Lce/CAxpJbUwgsOJ+EhfdbpfkeVMWtfueGD8YKST6Naz/ibZpkkn78fF6SZZet
         V3MN81bbeOlxc5Wjjp5igdmIN8cGx9PLJV5XeDv2ou6mcWsf93BR8iwHWs6RJrH+iAjn
         r2OSOIOx1ExYjSurafjrSuX9+wwRTPkYHgzoN3a9r9+ElOIqk0dlQ7fEAjeAje6jDXL0
         sez8Pd9cfWfCiHDA1J4qWxoApnD5uId83qnrKq4Xv8DDP1JoFEv82G2YcgczSCF5Na4V
         Muk/fSWl8dRbtMo5SV9Lwiwumz0fAj9JiZJm/sYglO3NSjUI3HyE5nZikqwbDbza0taQ
         WWqg==
X-Gm-Message-State: ANoB5pmlHgcNJNYolh1sJUP6B36Dt7Hog2ppqgS64HAF46Gaay7iif0t
        lkPM0H7PkhKlKUM5Ib/sLhWD2h6jd0rV+85Ho3w=
X-Google-Smtp-Source: AA0mqf78Srjq2nmL2QKmQeg1Qnjvh/p1DU0WiyXMtqy2g7t2ClV6vV2TeFnd0kCLhZrNwxv9uw7vuX3djN3aAQ9y4tI=
X-Received: by 2002:a17:903:22c4:b0:184:cb7e:ba36 with SMTP id
 y4-20020a17090322c400b00184cb7eba36mr33770698plg.57.1669674254391; Mon, 28
 Nov 2022 14:24:14 -0800 (PST)
MIME-Version: 1.0
References: <20221122203850.2765015-1-almasrymina@google.com>
 <Y35fw2JSAeAddONg@cmpxchg.org> <CAHS8izN+xqM67XLT4y5qyYnGQMUWRQCJrdvf2gjTHd8nZ_=0sw@mail.gmail.com>
 <Y36XchdgTCsMP4jT@cmpxchg.org> <874juonbmv.fsf@yhuang6-desk2.ccr.corp.intel.com>
In-Reply-To: <874juonbmv.fsf@yhuang6-desk2.ccr.corp.intel.com>
From:   Yang Shi <shy828301@gmail.com>
Date:   Mon, 28 Nov 2022 14:24:03 -0800
Message-ID: <CAHbLzkrmxyzH4R7a9sJQavrUyKCEiNYeA543+sdJLsgRPrwBwQ@mail.gmail.com>
Subject: Re: [RFC PATCH V1] mm: Disable demotion from proactive reclaim
To:     "Huang, Ying" <ying.huang@intel.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Mina Almasry <almasrymina@google.com>,
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
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
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
> kswapd reclaim on lower tier node to free some memory to avoid fall back
> to reclaim on current (higher tier) node.  This may be not good enough,
> for example, the following patch from Hasan may help via waking up
> kswapd earlier.

For the ideal case, I do agree with Johannes to demote the page tier
by tier rather than reclaiming them from the higher tiers. But I also
agree with your premature OOM concern.

>
> https://lore.kernel.org/linux-mm/b45b9bf7cd3e21bca61d82dcd1eb692cd32c122c.1637778851.git.hasanalmaruf@fb.com/
>
> Do you know what is the next step plan for this patch?
>
> Should we do even more?

In my initial implementation I implemented a simple throttle logic
when the demotion is not going to succeed if the demotion target has
not enough free memory (just check the watermark) to make migration
succeed without doing any reclamation. Shall we resurrect that?

Waking kswapd sooner is fine to me, but it may be not enough, for
example, the kswapd may not keep up so remature OOM may happen on
higher tiers or reclaim may still happen. I think throttling the
reclaimer/demoter until kswapd makes progress could avoid both. And
since the lower tiers memory typically is quite larger than the higher
tiers, so the throttle should happen very rarely IMHO.

>
> From another point of view, I still think that we can use falling back
> to reclaim as the last resort to avoid OOM in some special situations,
> for example, most pages in the lowest tier node are mlock() or too hot
> to be reclaimed.
>
> > So I'm hesitant to design cgroup controls around the current behavior.
> >
>
> Best Regards,
> Huang, Ying
>
