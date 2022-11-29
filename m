Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BDAB63C706
	for <lists+cgroups@lfdr.de>; Tue, 29 Nov 2022 19:08:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233159AbiK2SIP (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 29 Nov 2022 13:08:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230508AbiK2SIG (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 29 Nov 2022 13:08:06 -0500
Received: from mail-qv1-xf33.google.com (mail-qv1-xf33.google.com [IPv6:2607:f8b0:4864:20::f33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCAD61F9DA
        for <cgroups@vger.kernel.org>; Tue, 29 Nov 2022 10:08:03 -0800 (PST)
Received: by mail-qv1-xf33.google.com with SMTP id d13so10273115qvj.8
        for <cgroups@vger.kernel.org>; Tue, 29 Nov 2022 10:08:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=uLGeaz8NT3BELQqUMecnx7omQ6ldn4HqO+/oulNlF3g=;
        b=iJplMCRi2LhhQadE374lqFmED+tpdcxnO/27Tz7GhsxsGYaov3AHSLgVredAl4EKwf
         y8y410DKLDpSpT3Vg/nc8WJi8/kmTtcmzjrB7+f6ia7nIR8Fx3ZTXcjIUFvPzTGKcA7N
         sWqZP2O1KSGzmGfWdZulbDtgFgQt+fgC6FqTMrTCWJYjAcIvClChZJLfa3V7OLx7EIiD
         3/UMSLouRXc6/u20V8fBpyyQyw4VpjI0d+y3dKINM0DN3bj8C8bVcVVlf7k657Y7eC0l
         C1PNjG/V/Im5mFkoETZImcdpJ9/+aiX7oXo7pgjfoqk1pwugErWo42C1OW9+7z/62bmZ
         EwPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uLGeaz8NT3BELQqUMecnx7omQ6ldn4HqO+/oulNlF3g=;
        b=LxLynL50EXXC4qkqy+fQxkatm5I5wRrOAxRSpjQXtfTeD6MJFChQXIF6R4/EMCrmUz
         pvFKUPuChYE5q5BEzuu1llFu4Udf6BOcDSajL5JdBhMxghAF5c56vfXrNYdLfk7mqJ04
         vkPYp0f70VL1YyCk2s+wpXtfkhiyEwOvfRT9JYzc/lhHvHWm2NOG030318h8UdWw9/P0
         wMXy0218bC309/99DgbMOpsc1kaq7TAeh6IPF46zs27kVAXFHieg4pcwNEmOOoD7PFoo
         iFOVq0188sD591WxgREyueYceLZ3OOdXLEJtI1aE+6ozH6EM6Di7cWGel4IQoAqHbEF/
         YOdg==
X-Gm-Message-State: ANoB5ploQBpdVpBEAiSQ/nC3wwEIfQj158yyzE3EgC9ebCUg6an4TcwH
        FcpRLIamS6u3u24dDRBizLtHgw==
X-Google-Smtp-Source: AA0mqf4IJkpBeqMkP10/WQYwbB4b2vUFv97YcL7SBezywirDtOwEYT22VSC2x2m31tDlZYOy8QPELw==
X-Received: by 2002:a0c:90f1:0:b0:4c6:8f2e:9a2 with SMTP id p104-20020a0c90f1000000b004c68f2e09a2mr52264929qvp.100.1669745282935;
        Tue, 29 Nov 2022 10:08:02 -0800 (PST)
Received: from localhost ([2620:10d:c091:480::1:ea9a])
        by smtp.gmail.com with ESMTPSA id f3-20020a05622a114300b003434d3b5938sm8911215qty.2.2022.11.29.10.08.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Nov 2022 10:08:02 -0800 (PST)
Date:   Tue, 29 Nov 2022 13:08:01 -0500
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     "Huang, Ying" <ying.huang@intel.com>
Cc:     Mina Almasry <almasrymina@google.com>,
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
Subject: Re: [RFC PATCH V1] mm: Disable demotion from proactive reclaim
Message-ID: <Y4ZKgXdUXZ3ycMp4@cmpxchg.org>
References: <20221122203850.2765015-1-almasrymina@google.com>
 <Y35fw2JSAeAddONg@cmpxchg.org>
 <CAHS8izN+xqM67XLT4y5qyYnGQMUWRQCJrdvf2gjTHd8nZ_=0sw@mail.gmail.com>
 <Y36XchdgTCsMP4jT@cmpxchg.org>
 <874juonbmv.fsf@yhuang6-desk2.ccr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <874juonbmv.fsf@yhuang6-desk2.ccr.corp.intel.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hello Ying,

On Thu, Nov 24, 2022 at 01:51:20PM +0800, Huang, Ying wrote:
> Johannes Weiner <hannes@cmpxchg.org> writes:
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

If they're hotter than reclaim candidates on the toptier, shouldn't
they get promoted instead and make room that way? We may have to tweak
the watermark logic a bit to facilitate that (allow promotions where
regular allocations already fail?). But this sort of resorting would
be preferable to age inversions.

The mlock scenario sounds possible. In that case, it wouldn't be an
aging inversion, since there is nothing colder on the CXL node.

Maybe a bypass check should explicitly consult the demotion target
watermarks against its evictable pages (similar to the file_is_tiny
check in prepare_scan_count)?

Because in any other scenario, if there is a bug in the promo/demo
coordination, I think we'd rather have the OOM than deal with age
inversions causing intermittent performance issues that are incredibly
hard to track down.
