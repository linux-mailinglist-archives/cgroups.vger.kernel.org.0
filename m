Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0FDAB432D42
	for <lists+cgroups@lfdr.de>; Tue, 19 Oct 2021 07:33:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229742AbhJSFfw (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 19 Oct 2021 01:35:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229521AbhJSFfv (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 19 Oct 2021 01:35:51 -0400
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com [IPv6:2607:f8b0:4864:20::b30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEF4CC061745
        for <cgroups@vger.kernel.org>; Mon, 18 Oct 2021 22:33:38 -0700 (PDT)
Received: by mail-yb1-xb30.google.com with SMTP id a7so1358870yba.6
        for <cgroups@vger.kernel.org>; Mon, 18 Oct 2021 22:33:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=C7/p+vFvGASSiKGffZhdGt/JdSw4hI/EUKyQnYFmEkw=;
        b=R8AfSmX79UsAfHg1g2OmvvNlzzAI+3R1AunnM0Qd9AaY4W4mCP+OnI1q/Y1SOS+amL
         4tYtrwcUCTiXH4srQCq0AHRjIJTcYDiIR/6J3DIDup7Cjf9RkGzF/DCrqzqq3qhi1gFJ
         1vrHiFTCvwfIgK8uuyo+64h58L0TycsJfWW3IwgaJfGm4H3PhM5YlXETYZtBNrRj0OmG
         N1MuNqzyVCe/HfolLlUm0PSkqgoV5vS6m4Alp3OgKK14xLR3/jOeqEraYWCSTlMsTnPx
         mjsW1egWTUuhKT4dkM7NatNC8k1ft80SHBtPrgEbaM42exrExjdvWMlSsqthwIyx20q7
         FgXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=C7/p+vFvGASSiKGffZhdGt/JdSw4hI/EUKyQnYFmEkw=;
        b=fkVYrDZV2N23KhXY8OGsl856vcQtTOaVoYc9Go6kOjCz0pB0oJg5h6NfjlhdgWk+eS
         7uuhb0zjwkeW4m5rkd41r6LtrCVb09e8OcuU2321BQ0wIV/ArPy7ILW9JAh99es1hZv2
         31Ulvg6QikfmT06Kji6s0BG+9Tl8xGC351ktIs35GRQKspn+d3uawboGVNVlOyJ+jUuy
         IAWhWO3wva27S/P78flby1O618N+81DoFj7cvDK6nb4tDXLA7V6FCkWEslSCiAkkqxDn
         WSMKtgN+lEznnie7cNHlRUsd6iBP6paPehJkMakdTt3/AGkMF1+m1O8ROgL+vS0kFAfP
         s9ZQ==
X-Gm-Message-State: AOAM531Pt3zL6Bjj8rHvDq4ZgDuWRx7zL5E9/9rzs0GOjMEw3ektdtOB
        o/K17BY0v56gJgblKyHxbrl7HbLbsJ3pFiC7H4IYfw==
X-Google-Smtp-Source: ABdhPJxt4GTR5JrDEaV4ulWRIivaZMkeRJT6tNSWwwTVpjf7Di5+t/4A4DPVYsi5GRmjL2KD5x2mTPnJunwpg3wKM2w=
X-Received: by 2002:a25:e809:: with SMTP id k9mr36301806ybd.104.1634621616929;
 Mon, 18 Oct 2021 22:33:36 -0700 (PDT)
MIME-Version: 1.0
References: <9d10df01-0127-fb40-81c3-cc53c9733c3e@virtuozzo.com>
 <YW04jWSv6pQb2Goe@dhcp22.suse.cz> <6b751abe-aa52-d1d8-2631-ec471975cc3a@virtuozzo.com>
 <YW1gRz0rTkJrvc4L@dhcp22.suse.cz> <27dc0c49-a0d6-875b-49c6-0ef5c0cc3ac8@virtuozzo.com>
 <YW1oMxNkUCaAimmg@dhcp22.suse.cz> <CALvZod42uwgrg83CCKn6JgYqAQtR1RLJSuybNYjtkFo4wVgT1w@mail.gmail.com>
 <153f7aa6-39ef-f064-8745-a9489e088239@virtuozzo.com>
In-Reply-To: <153f7aa6-39ef-f064-8745-a9489e088239@virtuozzo.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Mon, 18 Oct 2021 22:33:25 -0700
Message-ID: <CALvZod5Kut63MLVfCkEW5XemqN4Jnd1iEQD_Gk0w5=fPffL8Bg@mail.gmail.com>
Subject: Re: [PATCH memcg 0/1] false global OOM triggered by memcg-limited task
To:     Vasily Averin <vvs@virtuozzo.com>
Cc:     Michal Hocko <mhocko@suse.com>,
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

On Mon, Oct 18, 2021 at 11:52 AM Vasily Averin <vvs@virtuozzo.com> wrote:
>
> On 18.10.2021 18:07, Shakeel Butt wrote:
> > On Mon, Oct 18, 2021 at 5:27 AM Michal Hocko <mhocko@suse.com> wrote:
> >>
> >> [restore the cc list]
> >>
> >> On Mon 18-10-21 15:14:26, Vasily Averin wrote:
> >>> On 18.10.2021 14:53, Michal Hocko wrote:
> >>>> On Mon 18-10-21 13:05:35, Vasily Averin wrote:
> >>>>> On 18.10.2021 12:04, Michal Hocko wrote:
> >>>>> Here we call try_charge_memcg() that return success and approve the allocation,
> >>>>> however then we hit into kmem limit and fail the allocation.
> >>>>
> >>>> Just to make sure I understand this would be for the v1 kmem explicit
> >>>> limit, correct?
> >>>
> >>> yes, I mean this limit.
> >>
> >> OK, thanks for the clarification. This is a known problem. Have a look
> >> at I think we consider that one to 0158115f702b ("memcg, kmem: deprecate
> >> kmem.limit_in_bytes"). We are reporting the deprecated and to-be removed
> >> status since 2019 without any actual report sugested by the kernel
> >> message. Maybe we should try and remove it and see whether that prompts
> >> some pushback.
> >>
> >
> > Yes, I think now should be the right time to take the next step for
> > deprecation of kmem limits:
> > https://lore.kernel.org/all/20201118175726.2453120-1-shakeelb@google.com/
>
> Are you going to push it to stable kernels too?
>

Not really. Is there a reason I should? More exposure to catch breakage?
