Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 88B1B3D8310
	for <lists+cgroups@lfdr.de>; Wed, 28 Jul 2021 00:33:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232272AbhG0Wdu (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 27 Jul 2021 18:33:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231858AbhG0Wdu (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 27 Jul 2021 18:33:50 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3C69C061760
        for <cgroups@vger.kernel.org>; Tue, 27 Jul 2021 15:33:47 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id r26so202418lfp.5
        for <cgroups@vger.kernel.org>; Tue, 27 Jul 2021 15:33:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DhOk56syJ49REgl7tdN9zLvJ0rtCnMIghUB5ztLzd68=;
        b=X9HEBVjB56EM/zdnzOtQqZAcd0A9JsH/VivVb3IjMVcf2q1P2MKr9pSgpwXQw0ADgk
         0faL6G3ID3xJJdC1ecfdb5/kqZjJdV9V+Qg4Zg37NfIlS4FHVZ1EuUazf4JyT4dmfhJc
         2NtqH75DUU5rRtXBMt4o2ymJQ3zf1x3QCR45bc3EBBx0eNSZM1xf+ProTdk3JMSfWTjb
         zY69yaw9jmkHrJ70V/jLSd30wwsUeHl006UfdJ4lP7JLhgd+T3EcqgoeBjl+STNS4vyz
         ugREqEDyNA1GyqnZwjCZaI39uiE0CFbaxtDv+bw0BYDqAsBf4wJDTyb1zh6dmKY+6u9+
         2bGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DhOk56syJ49REgl7tdN9zLvJ0rtCnMIghUB5ztLzd68=;
        b=QXlIDg6NyS7hb8ty5sEbQO21mj4NpK4C5SUtP0DDyTus8xQw6DYZj/fAAzcRWB7knO
         n+PEVN2kD29gvaeNoRAcJM71BaPhThd0gFiqGMpAOB/YlLs7+ekb9bGD2nS4aMLmqr+H
         +mUqJrMiTNEhgAgPB955FrpNUQi5lHpMecti3fxubHOxMtP+KeF6M8nIgiGmy3Nxe1fu
         7PObHvQVfZT3HOxSCYOYQIMdyUn/IW3CAsuUidgrrxL7YR2DdBGFM49S7Q+AVU0F8ozG
         CjCWNUl8MavVb7sXgv5EnGf6QnG5hQuM5kWeCSG2o5H72KmZLH9CLdP/bBoI7Pm5eevK
         aMCA==
X-Gm-Message-State: AOAM530hnJeHnynJRqBJ+QsFpG4GUreuY3PHN/0hUzJzZ2ebDUw/7H2M
        hHzF72echy9UYMAfLvEPgpctm5+CmbSf755XZSg7MA==
X-Google-Smtp-Source: ABdhPJwXTVZzicFV3Z7sKNaHKaF7p6b/x0f/gWReTDmo37OvJf5DkjUCazLIA326Q1OXtzTtgMFd3G0pOr/fgamd/so=
X-Received: by 2002:a19:e053:: with SMTP id g19mr17827672lfj.83.1627425226080;
 Tue, 27 Jul 2021 15:33:46 -0700 (PDT)
MIME-Version: 1.0
References: <6f21a0e0-bd36-b6be-1ffa-0dc86c06c470@virtuozzo.com>
 <cover.1627362057.git.vvs@virtuozzo.com> <57795560-025c-267c-6b1a-dea852d95530@virtuozzo.com>
In-Reply-To: <57795560-025c-267c-6b1a-dea852d95530@virtuozzo.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Tue, 27 Jul 2021 15:33:35 -0700
Message-ID: <CALvZod6avZ=1qHug1ziLwYPNf1c0366Fb9pvYXBx9gh1HBcr6A@mail.gmail.com>
Subject: Re: [PATCH v7 08/10] memcg: enable accounting for posix_timers_cache slab
To:     Vasily Averin <vvs@virtuozzo.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Cgroups <cgroups@vger.kernel.org>,
        Michal Hocko <mhocko@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Roman Gushchin <guro@fb.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Mon, Jul 26, 2021 at 10:34 PM Vasily Averin <vvs@virtuozzo.com> wrote:
>
> A program may create multiple interval timers using timer_create().
> For each timer the kernel preallocates a "queued real-time signal",
> Consequently, the number of timers is limited by the RLIMIT_SIGPENDING
> resource limit. The allocated object is quite small, ~250 bytes,
> but even the default signal limits allow to consume up to 100 megabytes
> per user.
>
> It makes sense to account for them to limit the host's memory consumption
> from inside the memcg-limited container.
>
> Signed-off-by: Vasily Averin <vvs@virtuozzo.com>
> Reviewed-by: Thomas Gleixner <tglx@linutronix.de>

Reviewed-by: Shakeel Butt <shakeelb@google.com>
