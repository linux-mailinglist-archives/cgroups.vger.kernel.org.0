Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 575F951C907
	for <lists+cgroups@lfdr.de>; Thu,  5 May 2022 21:30:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1385020AbiEETeW (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 5 May 2022 15:34:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1384472AbiEETeV (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 5 May 2022 15:34:21 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7F4F5AA70
        for <cgroups@vger.kernel.org>; Thu,  5 May 2022 12:30:40 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id d17so5355608plg.0
        for <cgroups@vger.kernel.org>; Thu, 05 May 2022 12:30:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gLvYPio/y1Rsy8ZWzpMgmaTLG4G8yUQ5M+BgkCxtwtA=;
        b=XQIzSd9nao1kbun84GbUFcH2P6yyzDFG+N0A2uCHmVBYC8oODM70pXR7xtStMpfyc5
         mtLLHkk0xuZbqCU7Z5wfpn1V3VrJczJhfpGwyYX1NsIjuxhnx3cpVEjvnU072DQm7TsC
         gFykdkxKL30lcwxhTxXlO00viowVHb31o4Z2Loba1USEpkQpfNxxSXoUolf1lg7eK28D
         gU4oWX58uS9Uc4wMyy34HH3NIIDZng79hu94xSbuNXAA5Q+YGYbWkVR7CXkiOn3GfgBN
         5WSfh48VFtwZ0Z7T/OV4fH9LnOoWTy+y8fK8buNSTDzi/szVTBJSmmRLPwFRFH2lKvwh
         WMhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gLvYPio/y1Rsy8ZWzpMgmaTLG4G8yUQ5M+BgkCxtwtA=;
        b=nwXZD7VL4+6dw60J8ocPQkCQv9Ciaot7s8vnAv+xd5+BsDX2yK7VqY+P2Dg/sy/RGn
         jz0r3pdie+p/wr5QMFgmACaFm/6jGbYh+Hri40LWrb5odvKom4XtpUeOJMQQL/64QqrL
         sTttIp/8G/r8yqtewqvhHmfouY7XnSaC8TnIUiw1/p8hj15nWdUIXY5H9/Wzm/fCpTfX
         yatHJHA18PA9UobOYExa9szoxYJVZ5irHqlc84mU+AsLKfknjGJdDUr4kypqunjjjd20
         CHe7v9VbzBHx0EjwmhCCtRbdEo6RcNa0Y0Zvt3ZHm6DLSbPw12fGEg65q7yiAivi4G2a
         i+hw==
X-Gm-Message-State: AOAM530YoYW8Ip82BmbPSfHHdMdh1pkVBLy7Y41zIaI5RTNl/LrXuwSE
        pAoCNM183d1K+T0TMy0NPVtyJJzMUbomnKpBb70zmw==
X-Google-Smtp-Source: ABdhPJyXcVPUUtmRGPX2KwjdTIb5ADyqBAf+SHZRA/wRfxH1x/C1g1gXItwmdL+70dkvEIL2og+nTKc+ICshlHYRZ8k=
X-Received: by 2002:a17:902:f682:b0:15e:951b:8091 with SMTP id
 l2-20020a170902f68200b0015e951b8091mr25548653plg.106.1651779040120; Thu, 05
 May 2022 12:30:40 -0700 (PDT)
MIME-Version: 1.0
References: <20220427160016.144237-1-hannes@cmpxchg.org> <20220427160016.144237-5-hannes@cmpxchg.org>
 <Ymmnrkn0mSWcuvmH@google.com> <YmmznQ8AO5RLxicA@cmpxchg.org>
 <Ymm3WpvJWby4gaD/@cmpxchg.org> <CALvZod5LBi5V6q1uHUTSNnLz64HbD499a+OZvdYsUcmcWSt8Jg@mail.gmail.com>
 <YmqmWPrIagEEceN1@cmpxchg.org> <CALvZod7wOyXpA3pycM2dav9_F9sW5ezC84or-75u8GdQyu30nw@mail.gmail.com>
 <Ymqv25+8IX2wqKzu@cmpxchg.org>
In-Reply-To: <Ymqv25+8IX2wqKzu@cmpxchg.org>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Thu, 5 May 2022 12:30:29 -0700
Message-ID: <CALvZod7_5CNjMqEo_SseW7VoVW9gRC8ZoVy=f9SAOL4+-1jR4A@mail.gmail.com>
Subject: Re: [PATCH 4/5] mm: zswap: add basic meminfo and vmstat coverage
To:     Johannes Weiner <hannes@cmpxchg.org>,
        Yosry Ahmed <yosryahmed@google.com>,
        Yuanchu Xie <yuanchu@google.com>
Cc:     Minchan Kim <minchan@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>, Roman Gushchin <guro@fb.com>,
        Seth Jennings <sjenning@redhat.com>,
        Dan Streetman <ddstreet@ieee.org>,
        Linux MM <linux-mm@kvack.org>,
        Cgroups <cgroups@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

+Yosry & Yuanchu

On Thu, Apr 28, 2022 at 8:17 AM Johannes Weiner <hannes@cmpxchg.org> wrote:
>
[...]
> >
> > Yes, we have some modifications to zswap to make it work without any
> > backing real swap.
>
> Not sure if you can share them, but I would be interested in those
> changes. We have real backing swap, but because of the way swap
> entries are allocated, pages stored in zswap will consume physical
> disk slots. So on top of regular swap, you need to provision disk
> space for zswap as well, which is unfortunate.
>
> What could be useful is a separate swap entry address space that maps
> zswap slots and disk slots alike. This would fix the above problem. It
> would have the added benefit of making swapoff much simpler and faster
> too, as it doesn't need to chase down page tables to free disk slots.
>

I think we can share the code. Adding Yosry & Yuanchu who are
currently maintaining that piece of code.

Though that code might not be in an upstreamable state. At the high
level, it introduces a new type of swap (SWP_GHOST) which underlying
is a truncated file, so no real disk space is needed. The zswap always
accepts the page, so the kernel never tries to go to the underlying
swapfile (reality is a bit more complicated due to the presence of
incompressible memory and no real disk present on the system).
