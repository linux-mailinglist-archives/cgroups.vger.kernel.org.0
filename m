Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB3B24F655A
	for <lists+cgroups@lfdr.de>; Wed,  6 Apr 2022 18:27:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237116AbiDFQ1w (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 6 Apr 2022 12:27:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237125AbiDFQ1W (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 6 Apr 2022 12:27:22 -0400
Received: from mail-qv1-xf2e.google.com (mail-qv1-xf2e.google.com [IPv6:2607:f8b0:4864:20::f2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15C8624F517;
        Tue,  5 Apr 2022 19:11:47 -0700 (PDT)
Received: by mail-qv1-xf2e.google.com with SMTP id kd21so1244338qvb.6;
        Tue, 05 Apr 2022 19:11:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wf8pQwHnRNmaHjWr1ZOvrwWsnNuIT93e+BIdPY7Vuuo=;
        b=eR2P6EjBqwGm0I3XlightluFGFW6/4Q1Fk0IBFVv0J7whG/+EutaNF17I/sCk8/LEf
         JkTfcbbNvUq52C1a5meMMepcUHtv/+Y3VUv4b4qaz+VXEQshKicKgiNOzSNV+CRAZotn
         ydZwRQKutAFaqxcZem8W/v46M/8z998iLTS2BguFC0O7aE4d7u6pC4J1nxyntWDQlgzu
         9/2x6HcSRhN3lEc5TW3hexP8tzYak8NdWbYTPUUowbw2PGXJe4x0J2dfZpCsMrmmAoBc
         gc96Y2Eu3GR0Y3I8E8r2dfVQTP2SJct6y2F5NnnR6aMK8wq6UnA0xDVBbs9bnYbRPvP1
         bsPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wf8pQwHnRNmaHjWr1ZOvrwWsnNuIT93e+BIdPY7Vuuo=;
        b=1bNAyoqrpL7CUYhvFVWCTDlk1oIVwHuIOQdBBKG4rpLaLEZAwj0QmTFzA5V3vRW+5q
         AAB8Nn+7H0CcRg+7pr79AqevoRD6aaV6wu8Az82bzTPGn5XriEnFyIfxoW9j4ffGrgoh
         t2v+7dgW+dZBpIOhmaGiQfBYXGHBnIA6OfNJsV02MEBaJ88AMJcLHnEyU0sDDKMq31Iu
         p5UJR71som4D2l5C6Yp/YA0toVB4Zt3x52eE0Sm/sSMfOVIJZ917mENrmrX9hZOwAidY
         V4MVlHjByMG3DXzby+n0TR05F1AKba13dtofL38toWXnzN79d7obb+4b23ba2sKeCZf4
         H28Q==
X-Gm-Message-State: AOAM531p8qQ+Jr32xXDGDH91FghfsVrmFhd3mktfLs9YlEpnFwwH4UBF
        igsITjpQEYVAzqJ1mftOvKm76XSoFj8lLX1rYD4=
X-Google-Smtp-Source: ABdhPJyy8x2mhTh2XDHSLA1p4xRwU3HMsrpCGyBfNfZ7krWKUNrMGTDCa9f9Xg715cZmJkdqtqzN0Wgck4yDuNSHeqQ=
X-Received: by 2002:a05:6214:238b:b0:430:842c:1863 with SMTP id
 fw11-20020a056214238b00b00430842c1863mr5428680qvb.105.1649211106952; Tue, 05
 Apr 2022 19:11:46 -0700 (PDT)
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
Date:   Wed, 6 Apr 2022 10:11:19 +0800
Message-ID: <CAGWkznG=QH3HRSzgum0sQBkyQAahqgiWf8nXCv1qXstxrn7e8w@mail.gmail.com>
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
I am not sure if I understand you right. Do you have suspicions on the
test result as you think protected memcg has no chance to update the
protection or the global reclaim should have been satisfied with the
reclaiming(step d is hard to reach?). Let me try to answer it under my
understanding, please give me feedback if you need more info. The
protection is updated while mem_cgroup_calculate_protection is called
during either kswapd or direct reclaim for each round of the priority
reclaiming and then the memcg's lruvec will be reached in step d.
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
I don't think so. IMO, it is hard to protect when memcg has a wide and
random range of its usage especially when depending on scenarios. Does
the example of EAS on scheduler make more sense? When comparing with
the legacy CFS, EAS does be against to some original design as load
balance etc, while it will keep some small tasks into one CORE.
>
> [...]
> --
> Michal Hocko
> SUSE Labs
