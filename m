Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF1A9432200
	for <lists+cgroups@lfdr.de>; Mon, 18 Oct 2021 17:08:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231898AbhJRPKC (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 18 Oct 2021 11:10:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232527AbhJRPJw (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 18 Oct 2021 11:09:52 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F2C0C0613EC
        for <cgroups@vger.kernel.org>; Mon, 18 Oct 2021 08:07:34 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id y26so318514lfa.11
        for <cgroups@vger.kernel.org>; Mon, 18 Oct 2021 08:07:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6bRJbqa6xT34/h7NxHqqr/Wrj4ooiVPcZ2S2RE7msX0=;
        b=tD7pGpPfZPhaSJpFmCQHjE8kNfwVnGkla3JDhKVEXmEq1jfKNyRz9nnFit+58lszlJ
         WlNab+RrKfHDmFdjRl05B7+DTrm4zLtlznOneffVIV5/jMgTSknMxa2PQ4hVjTUZEafw
         PhNcTjrFsTpdCPYFrDGtdBqvhUenjTpujzRQp2/tEhySHtn5hsSzVvpD3r+E4feXnuW5
         eAWFmBWQ1CB5tiJDO2xUyzQazBKDDNjpnCkkjdhpwhdMMuBERyvKVr5dr672S9Pq/0hL
         g8+zyVv0DxEwLoun1bQvj9ls/CruLgbDWQl+p7d2GS92pO6OHGf7RefsBkcTzHavFLOR
         KMog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6bRJbqa6xT34/h7NxHqqr/Wrj4ooiVPcZ2S2RE7msX0=;
        b=Rwzmbr1FURgOy9BvdM59yrbTYKfSM57cEb5fgfpvgtWCJCU+Jma4J8D5ggvmWQikDI
         oQJFb+2qjFIcOh1ZVvHiWkwpVRPakyjLcg4bGXWUiMbt5eqZ2wMC5TX202/XlpVIPeYA
         1Rimcp5Zac5W+1yAIXUn7h/HkPwZzjRqs6a+K+D0D0bxruem8FHJJcZF40isyxnlvWOa
         eyI2Dog4Uji2EYskTFvXD4PLUYDxaGqCrXhnF6y0tSPzIxLOkcIHQK4z+wvo4T8vNwQ3
         piJhJBm6wL+1bU0i0DaYxh2KGUDpht4eCx0E03uwb1kq8Fe0/L+ARheF8X5Hc+MFaQla
         EqIg==
X-Gm-Message-State: AOAM530QHRsez8ontEQnxIPPormR6dSCcl3kPrL/0eaYSgqC5qBT1++p
        yjlYrTDbeT7m7kwxDN34urf5Z19J/D5iket1Et1U9Q==
X-Google-Smtp-Source: ABdhPJzkcQbJmHIcmsSv23CmJ8pvuIgse7txYaY63YZogGKFZIVhvM5S+K8nNQYkOLgWxlGU6DrXAruX57i0Qu7+Z9s=
X-Received: by 2002:ac2:5a0b:: with SMTP id q11mr327244lfn.40.1634569652473;
 Mon, 18 Oct 2021 08:07:32 -0700 (PDT)
MIME-Version: 1.0
References: <9d10df01-0127-fb40-81c3-cc53c9733c3e@virtuozzo.com>
 <YW04jWSv6pQb2Goe@dhcp22.suse.cz> <6b751abe-aa52-d1d8-2631-ec471975cc3a@virtuozzo.com>
 <YW1gRz0rTkJrvc4L@dhcp22.suse.cz> <27dc0c49-a0d6-875b-49c6-0ef5c0cc3ac8@virtuozzo.com>
 <YW1oMxNkUCaAimmg@dhcp22.suse.cz>
In-Reply-To: <YW1oMxNkUCaAimmg@dhcp22.suse.cz>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Mon, 18 Oct 2021 08:07:20 -0700
Message-ID: <CALvZod42uwgrg83CCKn6JgYqAQtR1RLJSuybNYjtkFo4wVgT1w@mail.gmail.com>
Subject: Re: [PATCH memcg 0/1] false global OOM triggered by memcg-limited task
To:     Michal Hocko <mhocko@suse.com>
Cc:     Vasily Averin <vvs@virtuozzo.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Roman Gushchin <guro@fb.com>,
        Uladzislau Rezki <urezki@gmail.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Mel Gorman <mgorman@techsingularity.net>,
        Cgroups <cgroups@vger.kernel.org>, Linux MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>, kernel@openvz.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Mon, Oct 18, 2021 at 5:27 AM Michal Hocko <mhocko@suse.com> wrote:
>
> [restore the cc list]
>
> On Mon 18-10-21 15:14:26, Vasily Averin wrote:
> > On 18.10.2021 14:53, Michal Hocko wrote:
> > > On Mon 18-10-21 13:05:35, Vasily Averin wrote:
> > >> On 18.10.2021 12:04, Michal Hocko wrote:
> > >> Here we call try_charge_memcg() that return success and approve the allocation,
> > >> however then we hit into kmem limit and fail the allocation.
> > >
> > > Just to make sure I understand this would be for the v1 kmem explicit
> > > limit, correct?
> >
> > yes, I mean this limit.
>
> OK, thanks for the clarification. This is a known problem. Have a look
> at I think we consider that one to 0158115f702b ("memcg, kmem: deprecate
> kmem.limit_in_bytes"). We are reporting the deprecated and to-be removed
> status since 2019 without any actual report sugested by the kernel
> message. Maybe we should try and remove it and see whether that prompts
> some pushback.
>

Yes, I think now should be the right time to take the next step for
deprecation of kmem limits:
https://lore.kernel.org/all/20201118175726.2453120-1-shakeelb@google.com/
