Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4267E5A159B
	for <lists+cgroups@lfdr.de>; Thu, 25 Aug 2022 17:26:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241626AbiHYPYa (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 25 Aug 2022 11:24:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241669AbiHYPYR (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 25 Aug 2022 11:24:17 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9746B99C7
        for <cgroups@vger.kernel.org>; Thu, 25 Aug 2022 08:24:15 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id o4so716448pjp.4
        for <cgroups@vger.kernel.org>; Thu, 25 Aug 2022 08:24:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=Sjxu1KZYU3KDG78+cZAn5+zrZMruhm46V6F/elCTC6I=;
        b=cgdSCg/G5MIqnMdtGF27PjSCoHoxA2BsgT02jo7Ty55H5CD+J3M0vHpW6lHr8NcHWU
         X4d85j0jzRSVoQQ1MCpo3IQxt2FbpJcglk7ukGEyRJIhQszVQ9wx2i35z97DqqSPd8oC
         VCP76agWwaX+4eMZ+QIx3J3v9Nver8Y2hT/qeJt1TMaAprapOxqq9WUzYpSdGmHshkAY
         GfaP+h3+0CtF8cAYQQM3KgFAd8WHhKHivvxwKgX45zfRGdSEJ/wxeU6tfT/4yjg6gHiJ
         kPNYCejF6P/dRAtVBxvPeyL9+3p/YImkl2YVTcNEsoYooOr0nt/CrL9psmY7f6J0bNqd
         Y+dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=Sjxu1KZYU3KDG78+cZAn5+zrZMruhm46V6F/elCTC6I=;
        b=3J/hAXLf64noV+yEF36aA/iD+qz94/9BzMMk1JwIO/vZsCmtbTgyWYSzwd0EWs3viq
         iIttKTQh64t+Dj7KBCHNw1q2djreWZTHeXCneCA32vfBaIHLb5hBWjUBelY4+4SZXzXV
         //4rJuQN08Ak1Aq4rpQuHWWzGULpX7AMFz7kmdDhB3FhkhG+dHhRSuZvMmhNBLeTl/EA
         429Uxx4rxAcekkaR0pR0l06TEBBbX5eVscq2mmQNJ2p3KYOqqBnwBTWZNJjfONtUKtCR
         548sUUTfOinD5uePDqjhkj30SOiQGnyM5M2ClNqhhai3uWkk1Au95X2THv4VQSPAM5vC
         rwkA==
X-Gm-Message-State: ACgBeo1eVOj6rFX/6THa2QDEakRdsJ0+U3edUmLRm562kIALUKZlgmVN
        PRiVtZUfum9BN8PiuUxa24ywDzEQfpA9ImfFFIa3pw==
X-Google-Smtp-Source: AA6agR47CCHMXIXPEnmUh5MEwo8eqnV5OkxhX40/DKDSoDxPq9qnYdSc5lDaOytVRTphX+pidszh2naGv0wE7nfCZh8=
X-Received: by 2002:a17:90b:1d91:b0:1fb:4f7f:852e with SMTP id
 pf17-20020a17090b1d9100b001fb4f7f852emr14163491pjb.126.1661441054986; Thu, 25
 Aug 2022 08:24:14 -0700 (PDT)
MIME-Version: 1.0
References: <20220825000506.239406-1-shakeelb@google.com> <20220825000506.239406-3-shakeelb@google.com>
 <20220824173330.2a15bcda24d2c3c248bc43c7@linux-foundation.org>
 <CALvZod6+Y1yvp8evMLTeEwKnQyoXJmzjO7xLN9w=EPcOUH6BHQ@mail.gmail.com> <20220824222150.61c516a83bfe0ecb6c9b5348@linux-foundation.org>
In-Reply-To: <20220824222150.61c516a83bfe0ecb6c9b5348@linux-foundation.org>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Thu, 25 Aug 2022 08:24:02 -0700
Message-ID: <CALvZod6tFce5Ld9rh-xt495S+A-vi4Curkja2YYyf0VizKw1tw@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] mm: page_counter: rearrange struct page_counter fields
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Muchun Song <songmuchun@bytedance.com>,
        =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>,
        Eric Dumazet <edumazet@google.com>,
        Soheil Hassas Yeganeh <soheil@google.com>,
        Feng Tang <feng.tang@intel.com>,
        Oliver Sang <oliver.sang@intel.com>, lkp@lists.01.org,
        Cgroups <cgroups@vger.kernel.org>, Linux MM <linux-mm@kvack.org>,
        netdev <netdev@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
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

On Wed, Aug 24, 2022 at 10:21 PM Andrew Morton
<akpm@linux-foundation.org> wrote:
>
> On Wed, 24 Aug 2022 21:41:42 -0700 Shakeel Butt <shakeelb@google.com> wrote:
>
> > > Did you evaluate the effects of using a per-cpu counter of some form?
> >
> > Do you mean per-cpu counter for usage or something else?
>
> percpu_counter, perhaps.  Or some hand-rolled thing if that's more suitable.
>
> > The usage
> > needs to be compared against the limits and accumulating per-cpu is
> > costly particularly on larger machines,
>
> Well, there are tricks one can play.  For example, only run
> __percpu_counter_sum() when `usage' is close to its limit.
>
> I'd suggest flinging together a prototype which simply uses
> percpu_counter_read() all the time.  If the performance testing results
> are sufficiently promising, then look into the accuracy issues.
>

Thanks, I will take a stab at that in a week or so.
