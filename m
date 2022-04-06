Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 323F84F5C80
	for <lists+cgroups@lfdr.de>; Wed,  6 Apr 2022 13:40:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231883AbiDFLdR (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 6 Apr 2022 07:33:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236007AbiDFLcn (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 6 Apr 2022 07:32:43 -0400
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06A1149FA17;
        Wed,  6 Apr 2022 01:21:36 -0700 (PDT)
Received: by mail-qt1-x835.google.com with SMTP id t2so3093276qtw.9;
        Wed, 06 Apr 2022 01:21:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AFWezyJlqZ77VORHX3U0GwJuhQRt/uhTxdefuNmt42Q=;
        b=UdajeAwz5lRZFRXbxD0b6WdicDco/5iM+47a7VFFMBjwCmLgcEiDJIg7nWDLO+ji2k
         CkNHMl6aooBimIBDkw/xp6u2yjv2xEGsx/+kzbYrNShkzRVLJwOLOsVjqzHpMfixnZl0
         4cO/49izpHp3ca9V5F8qjww8XY3WRZZdDjbY1cVxZQ6PVn0vDIhLZbqfkykB9fzQOIBS
         KLpAKeY80xO37Hxbxzf4fCFAt1qxkfTvaCNHYh7wyNmpF0A4E3DVm5LVNtc9F0CaxlME
         /pd/fLotihhQ0LroBEuHJKYI64RmS2669IZmn3bOJWVpyEvNOfNmQwixkMW+TcsM65/G
         tUZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AFWezyJlqZ77VORHX3U0GwJuhQRt/uhTxdefuNmt42Q=;
        b=OvFkU3J7EyonMNQlvjKl6AMT1EjpYqR4wazMB2rYjFK/q2xL5agQL9UTwtn7brNO/n
         v6c465MRq2HJa1Ak0Fc98VD2sumWWk4x+4C+Vi0KForeRCjXvgOeD834VQ7aYiGe59yK
         NEdQ2lcHpzDaTzsXSN5vr6PKpR+HHqCRJgZfnp5okbZX/DT3MDnew77xKx0+IEh12lyp
         yoLonaGv5/UF0Se5L95Z34yYdz19LKdidGcphU1RWclDI5btrBhYh22l5tBIceqFeA/s
         IVPUnFY261t9fcB768IXNsJNyM0+BnmrXo5Gh7EAvSg7hgVChe5gprp32/P6CtPgtSoc
         v+Xw==
X-Gm-Message-State: AOAM530Vf+cwbbgJXkw2FXFoQq0Nk4MJA5eZqDCHUAmBfbE+eFE3Sjot
        66kpQ0TTHHFL7Ks6qejCVCP3H7selM8323gijUA=
X-Google-Smtp-Source: ABdhPJwsFaRtyZQjBJn9zBMfC8Nfx9hxl1Be1gb/G3G6j10kQniywe6cDREOy6skFWkz8Y7S2TA7wlgoNtxnX5qnP0k=
X-Received: by 2002:ae9:e513:0:b0:67d:2bc6:9620 with SMTP id
 w19-20020ae9e513000000b0067d2bc69620mr4910453qkf.453.1649233295174; Wed, 06
 Apr 2022 01:21:35 -0700 (PDT)
MIME-Version: 1.0
References: <CAGWkznF7cSyPU0ceYwH6zweJzf-X1bQnS6AJ2-J+WEL0u8jzng@mail.gmail.com>
 <CAJuCfpHneDZMXO_MmQDPA+igAOdAPRUChiq+zftFXGfDzPHNhQ@mail.gmail.com>
 <CAGWkznFTQCm0cusVxA_55fu2WfT-w2coVHrT=JA1D_9_2728mQ@mail.gmail.com>
 <YkqxpEW4m6iU3zMq@dhcp22.suse.cz> <CAGWkznG4L3w=9bpZp8TjyWHmqFyZQk-3m4xCZ96zhHCLPawBgQ@mail.gmail.com>
 <CAGWkznGMRohE2_at4Qh8KbwSqNmNqOAG2N1EM+7uE9wKqzRm0A@mail.gmail.com>
 <Ykq7KUleuAg5QnNU@dhcp22.suse.cz> <CAGWkznGbd5TOTHZE8uUhak3SnHqEWx_9QCJVtUFUSg9rk3xYEQ@mail.gmail.com>
 <Ykrkx4JML4c81gBV@dhcp22.suse.cz> <CAGWkznEaEavCz9GeiYuTqsox2qZK43iQKevt8njkzaHv6KiW-A@mail.gmail.com>
 <YkwxNaJIg6ptJOYT@dhcp22.suse.cz>
In-Reply-To: <YkwxNaJIg6ptJOYT@dhcp22.suse.cz>
From:   Zhaoyang Huang <huangzhaoyang@gmail.com>
Date:   Wed, 6 Apr 2022 16:21:07 +0800
Message-ID: <CAGWkznEfT7qZbhjCUPHnAxSsYp3Rxm-RzEnWj4TQRO5B3fLvOQ@mail.gmail.com>
Subject: Re: [RFC PATCH] cgroup: introduce dynamic protection for memcg
To:     Michal Hocko <mhocko@suse.com>
Cc:     Suren Baghdasaryan <surenb@google.com>,
        "zhaoyang.huang" <zhaoyang.huang@unisoc.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        "open list:MEMORY MANAGEMENT" <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        cgroups mailinglist <cgroups@vger.kernel.org>,
        Ke Wang <ke.wang@unisoc.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue, Apr 5, 2022 at 8:08 PM Michal Hocko <mhocko@suse.com> wrote:
>
> On Mon 04-04-22 21:14:40, Zhaoyang Huang wrote:
> [...]
> > Please be noticed that this patch DOES protect the memcg when external
> > pressure is 1GB as fixed low does.
>
> This is getting more and more confusing (at least to me). Could you
> describe the behavior of the reclaim for the following setups/situations?
>
> a) mostly reclaiming a clean page cache - via kswapd
> b) same as above but the direct reclaim is necessary but very
>    lightweight
> c) direct reclaim makes fwd progress but not enough to satisfy the
>    allocation request (so the reclaim has to be retried)
> d) direct reclaim not making progress and low limit protection is
>    ignored.
>
> Say we have several memcgs and only some have low memory protection
> configured. What is the user observable state of the protected group and
> when and how much the protection can be updated?
Ok. I guess you doubt why the external reclaiming on global LRU or
other unprotected memcg does not satisfy the requirement and have the
protected memcg have to face reclaim? According to my experience, this
is common for a large number of malloc from userspace OR high order
alloc_pages within the kernel. I have retested the previous case by
removing mlock and get the trend of result is same, where the pages on
global LRU could help to push some of the global memory pressure back
to global LRU and finally reach the protected memcg.
>
> I think it would be also helpful to describe the high level semantic of
> this feature.
>
> > Besides, how does the admin decide
> > the exact number of low/min if it expand from small to even xGB in a
> > quick changing scenario?
>
> This is not really related, is it? There are different ways to tune for
> the protection.
>
> [...]
> --
> Michal Hocko
> SUSE Labs
