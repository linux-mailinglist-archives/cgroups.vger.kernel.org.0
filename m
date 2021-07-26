Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA2993D6599
	for <lists+cgroups@lfdr.de>; Mon, 26 Jul 2021 19:24:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235842AbhGZQnd (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 26 Jul 2021 12:43:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233327AbhGZQnX (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 26 Jul 2021 12:43:23 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6951C0619E2
        for <cgroups@vger.kernel.org>; Mon, 26 Jul 2021 09:57:28 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id g13so16623963lfj.12
        for <cgroups@vger.kernel.org>; Mon, 26 Jul 2021 09:57:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4CjU2RsYvZ9x+m1FosmYIR8QGbXd8bRq67CFAxCYneo=;
        b=KE/UnX3ML3Xw/5e0wwlWbS/xgPSyv+N4V3ynbBhw+BEqgokKCdDHOAQhI2EC4em4FI
         cF66Zk05KBdsDmPSV049y02ENoBdBIMLG4JuUL2hXcmObOgnJ+De8vRbYqHytF8iNP4t
         sc/n9LmbTDHqiyzZI4oM96x5N3DbQsNV71w1NIcbajXRmFKqfDUx/qyexNcykqgooXDb
         VWGTrDPpa96AfCN0BPcHQo1ZHj7ILA7C8IZgGhGDMDPa/PAjuJIAAzwEwgYZDhJmYbQf
         QrZsjEpOLvAXRhLTggf9OOBrPFb+jgt+OJKMdnoh81XeQppUTCOTYevElzQAK8t3lWnx
         MeXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4CjU2RsYvZ9x+m1FosmYIR8QGbXd8bRq67CFAxCYneo=;
        b=TpoVMa0pM8e3MpnYGRs6l8YcIiD7AZYy1+reMinrTzzHGm2eDEaLCmwhAPkgft1XOi
         1P9Rrx+xPNOpshg2ZbTjlwW7xXbHHL1E2tRGD1f63Qsz4Vk3dEkeAzq+rHy2nVlsm5tz
         p/yIkf+yn5IHm9/Ci1rv9lKZrr+Lqb6gzMpJJc3g+etuYEecfrMLqikttUxZs+/z1Hz7
         EVJ0f9koTsR059ZRWuSJI0ep/o4wjKHMZJwoUTdv/p3M8UZ93wLAXbgatzdW6xUxZmLj
         8s/OHmhnPPjsqn7F0iadoypEp/gIVgkUEW8vDyGo78SqMEL+uVvfJm1jIV5BE0QImknJ
         /V9A==
X-Gm-Message-State: AOAM532Gy7UqQEMAMLV+5apQu6ixOQRwe8QcBdIQ9hmcoinoAGniqgaD
        rpVzoZFpSJ4bHXSb8Y1UNGByKfRea2sTN4BWtz3ftw==
X-Google-Smtp-Source: ABdhPJx+xXmD0VZj3AsK/ylqlmnDPoW3CElhkDtGeuoJOlJPgXEiMsg3GLTgBT867f0FFvwX6DilkeMJQOIR9Ca4ngc=
X-Received: by 2002:a19:771c:: with SMTP id s28mr13309197lfc.358.1627318646800;
 Mon, 26 Jul 2021 09:57:26 -0700 (PDT)
MIME-Version: 1.0
References: <CALvZod5-XtaeawPtEgnp9xwouy0KfuDbpykB6Z3b+8YJyCrLVA@mail.gmail.com>
 <ed4448b0-4970-616f-7368-ef9dd3cb628d@virtuozzo.com>
In-Reply-To: <ed4448b0-4970-616f-7368-ef9dd3cb628d@virtuozzo.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Mon, 26 Jul 2021 09:57:15 -0700
Message-ID: <CALvZod5Vj-_S2gRYpGgwhiCysXuA8z1WEV2ttP0t3Tdy2MU7KQ@mail.gmail.com>
Subject: Re: [PATCH] memcg: replace in_interrupt() by !in_task() in active_memcg()
To:     Vasily Averin <vvs@virtuozzo.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Roman Gushchin <guro@fb.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Cgroups <cgroups@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Mon, Jul 26, 2021 at 9:53 AM Vasily Averin <vvs@virtuozzo.com> wrote:
>
> set_active_memcg() uses in_interrupt() check to select proper storage for
> cgroup: pointer on task struct or per-cpu pointer.
>
> It isn't fully correct: obsoleted in_interrupt() includes tasks with disabled BH.
> It's better to use '!in_task()' instead.
>
> Link: https://lkml.org/lkml/2021/7/26/487
> Fixes: 37d5985c003d ("mm: kmem: prepare remote memcg charging infra for interrupt contexts")
> Signed-off-by: Vasily Averin <vvs@virtuozzo.com>

Thanks.

Reviewed-by: Shakeel Butt <shakeelb@google.com>
