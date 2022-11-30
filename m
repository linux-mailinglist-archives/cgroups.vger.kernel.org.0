Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A99E63CF17
	for <lists+cgroups@lfdr.de>; Wed, 30 Nov 2022 07:07:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232707AbiK3GHP (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 30 Nov 2022 01:07:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233917AbiK3GHN (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 30 Nov 2022 01:07:13 -0500
Received: from mail-ua1-x933.google.com (mail-ua1-x933.google.com [IPv6:2607:f8b0:4864:20::933])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E750274AB5
        for <cgroups@vger.kernel.org>; Tue, 29 Nov 2022 22:07:09 -0800 (PST)
Received: by mail-ua1-x933.google.com with SMTP id e24so5827138uam.10
        for <cgroups@vger.kernel.org>; Tue, 29 Nov 2022 22:07:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=FWjVwsfaKDFRr8VkwYzgxCXQbcwfzKH8w2b9Cg9S3Qg=;
        b=G7O5bwbCEbvRUawdrMo0STCjIPBtikhsjYt5P2BbfdIgSX/6UUKrw+39wtAX3MzM3l
         asRuDPtvRAgh9vfobCy2BwwtQccULYWiaOcNFO0s4JiArEE6S4merDcjjJsdaJxZO0Lo
         uPyC5dNSHfSqryuTnefPXdCvzQOqfMVQT1Q5liZOs7a+r98V2iHJSORCQLhj5X1mLHFe
         MKbxTUXDzXCaXA12A8ibCEedbfC3hBGfeE9kq4l2Mn92IXBHHaT4/l2FjByD6fgQMBs1
         hsWd6zuklbsRveIaFWwQa160MDjpU6F/UlFuI+0fLDn7OEOjdi3/Uh7m10etrOAQZAux
         ZHaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FWjVwsfaKDFRr8VkwYzgxCXQbcwfzKH8w2b9Cg9S3Qg=;
        b=wWFIOxwAzx7b73qjZzen1wsz1KpSyHldBHIwO3UhlZZwzHFF60n/4/SqusvoMMyQNd
         4QVFX6lSM+L/e6IMYXbdJ4DHleXjYA+/YuJijcMBCjzNQgNGd9xQKp9kaiyQUY+u0PS2
         yaxehNgBORsxl+pl/FWWhgxLvnJmU3/sgTGL5vh6GPRJOuKGzqnXdTxS1qJeUqb2xxYj
         Is9vqIUtQ7YIyaqUfTzfMjAlPVC1BkdMoww6/ORL/DUifwqpualWg78W5VN+BRhagmI0
         XwYlGREqESsxGt4dKSNHS/qSR12un38sw2AD8k34n/JKVvuGATFOX0ocXGRsuBwXcBW7
         kEcg==
X-Gm-Message-State: ANoB5pm9zQBiEhAtV91S6iBRjzKViWFK8Age4s4/We16TGxF/Qyu8UUT
        /2OonDkSbGML+r4KWEFRI1zN3n9nc5KOd+0/Fj84iA==
X-Google-Smtp-Source: AA0mqf6SVhumDSHrtQczqhp0r9DvE7CaXXHOLr0Yf/QvLnp1AFeQ0cn7D77MyLwPihqjlqNFkbRUGIrP2PaoMz6yH4c=
X-Received: by 2002:ab0:5517:0:b0:409:5403:c18 with SMTP id
 t23-20020ab05517000000b0040954030c18mr26040308uaa.51.1669788428939; Tue, 29
 Nov 2022 22:07:08 -0800 (PST)
MIME-Version: 1.0
References: <20221122203850.2765015-1-almasrymina@google.com>
 <Y35fw2JSAeAddONg@cmpxchg.org> <CAHS8izN+xqM67XLT4y5qyYnGQMUWRQCJrdvf2gjTHd8nZ_=0sw@mail.gmail.com>
 <Y36XchdgTCsMP4jT@cmpxchg.org> <874juonbmv.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <CAHS8izMhoHVCGxXGt8qRtf-fPpAR8=pTy7Rc3j2=Wf8vJz-C+g@mail.gmail.com> <87edtlatmg.fsf@yhuang6-desk2.ccr.corp.intel.com>
In-Reply-To: <87edtlatmg.fsf@yhuang6-desk2.ccr.corp.intel.com>
From:   Mina Almasry <almasrymina@google.com>
Date:   Tue, 29 Nov 2022 22:06:57 -0800
Message-ID: <CAHS8izM6_uUSqWjMAOoMgNup9ZMsB9n_9CMpdW1Y=T558hLHwQ@mail.gmail.com>
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
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue, Nov 29, 2022 at 9:40 PM Huang, Ying <ying.huang@intel.com> wrote:
>
> Mina Almasry <almasrymina@google.com> writes:
>
> > On Wed, Nov 23, 2022 at 9:52 PM Huang, Ying <ying.huang@intel.com> wrote:
> >>
> >> Hi, Johannes,
> >>
> >> Johannes Weiner <hannes@cmpxchg.org> writes:
> >> [...]
> >> >
> >> > The fallback to reclaim actually strikes me as wrong.
> >> >
> >> > Think of reclaim as 'demoting' the pages to the storage tier. If we
> >> > have a RAM -> CXL -> storage hierarchy, we should demote from RAM to
> >> > CXL and from CXL to storage. If we reclaim a page from RAM, it means
> >> > we 'demote' it directly from RAM to storage, bypassing potentially a
> >> > huge amount of pages colder than it in CXL. That doesn't seem right.
> >> >
> >> > If demotion fails, IMO it shouldn't satisfy the reclaim request by
> >> > breaking the layering. Rather it should deflect that pressure to the
> >> > lower layers to make room. This makes sure we maintain an aging
> >> > pipeline that honors the memory tier hierarchy.
> >>
> >> Yes.  I think that we should avoid to fall back to reclaim as much as
> >> possible too.  Now, when we allocate memory for demotion
> >> (alloc_demote_page()), __GFP_KSWAPD_RECLAIM is used.  So, we will trigger
> >
> > I may be missing something but as far I can tell reclaim is disabled
> > for allocations from lower tier memory:
> > https://elixir.bootlin.com/linux/v6.1-rc7/source/mm/vmscan.c#L1583
>
> #define GFP_NOWAIT      (__GFP_KSWAPD_RECLAIM)
>
> We have GFP_NOWAIT set in gfp.
>

Ah, thanks. I missed that.

> > I think this is maybe a good thing when doing proactive demotion. In
> > this case we probably don't want to try to reclaim from lower tier
> > nodes and instead fail the proactive demotion.
>
> Do you have some real use cases for this?  If so, we can tweak the
> logic.
>

Nothing real at the moment. I was thinking this may be something
desirable to tune at some point.

> > However I can see this being desirable when the top tier nodes are
> > under real memory pressure to deflect that pressure to the lower tier
> > nodes.
>
> Yes.
>
> Best Regards,
> Huang, Ying
>
> >> kswapd reclaim on lower tier node to free some memory to avoid fall back
> >> to reclaim on current (higher tier) node.  This may be not good enough,
> >> for example, the following patch from Hasan may help via waking up
> >> kswapd earlier.
> >>
> >> https://lore.kernel.org/linux-mm/b45b9bf7cd3e21bca61d82dcd1eb692cd32c122c.1637778851.git.hasanalmaruf@fb.com/
> >>
> >> Do you know what is the next step plan for this patch?
> >>
> >> Should we do even more?
> >>
> >> From another point of view, I still think that we can use falling back
> >> to reclaim as the last resort to avoid OOM in some special situations,
> >> for example, most pages in the lowest tier node are mlock() or too hot
> >> to be reclaimed.
> >>
> >> > So I'm hesitant to design cgroup controls around the current behavior.
> >
> > I sent RFC v2 patch:
> > https://lore.kernel.org/linux-mm/20221130020328.1009347-1-almasrymina@google.com/T/#u
> >
> > Please take a look when convenient. Thanks!
> >
> >> >
> >>
> >> Best Regards,
> >> Huang, Ying
> >>
>
