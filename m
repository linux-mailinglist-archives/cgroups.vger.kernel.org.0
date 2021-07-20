Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DDF2F3D0213
	for <lists+cgroups@lfdr.de>; Tue, 20 Jul 2021 21:16:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233517AbhGTSff (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 20 Jul 2021 14:35:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233465AbhGTSfU (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 20 Jul 2021 14:35:20 -0400
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B17AC061766
        for <cgroups@vger.kernel.org>; Tue, 20 Jul 2021 12:15:50 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id l11so17189617ljq.4
        for <cgroups@vger.kernel.org>; Tue, 20 Jul 2021 12:15:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=07bx4NkLdn3YQo/4PUJkMzmndAbRZde3u9NpVjJE6Xo=;
        b=jH4ofDKiNAS6wninS1QG7BNfZTXGP6Tjxgvi8PtuyJ6A+fotRAxZpfxIuSyfOhDioS
         YlVz47P5bm5noadpORW7KP+FGm+QeNQJgSNXvF0keEyMaWzBtmnREHD5qMKGleIBjg2f
         gxySo7z5fJG5Y19umoVFApZQYQ0XlZNnfRMjz74qsbN0pvxhzG/iDg0+/IljYPmeY2ZY
         jjC8QCa0cP2aigYvOhYGzms8xO0zLIJfbJkRM2U84pKDUB3UZRbXq5uP0qoUsDpC6WAk
         n0hQ1Z54IU4MX/hy7VDhOw5UE6Wy7zhHbvxC6KcS/l2UPpwR42Hl1ZTnw8ZMi2wpwYUl
         AKqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=07bx4NkLdn3YQo/4PUJkMzmndAbRZde3u9NpVjJE6Xo=;
        b=R40kNDJSBkKqVrYssfOXbYkMLLa8JS7v+lFytUvL87ZwbIJO79dn+wda3nDvnu7lBw
         11B3JKh5RoymItn9Dxv0E72Xd7EWf8AQCLhJyO7GSDG9YWLlkTQ+mFTm3uJGZ9LAIooI
         KZxsTw29/pEJkc/deIYv14YhRrm7/ZjiHTqiNWICOttZHI4TD928aV5sElnc92LA9MQ1
         k4K01k7zICvuRj2JB9B+3WgEto8i8qX2E2GdtkwVkAt2u4IymX5Euhko+z3xtbjuLauF
         8U9uZ+AUaaQOnvuQ/e9/LGYgEvAj/+cZxzl/yDGOy4i48iVyLU+x1aup9d7tNMRvu++b
         F/Sg==
X-Gm-Message-State: AOAM5306h2mlmCnBGoXrI/mP+PnMTQCNxvzzSvPmztbRkXsOLumGF3RB
        16RLbghES9AGMwjPhuEucKfWhRdu0UgrnzzHSjFxjOvoISA=
X-Google-Smtp-Source: ABdhPJzBfmIwchbylotTFNtN8B08j+3I3Jymmh9NtMuOkfmAVde5yClE76+HUsTtpljHe+5C8OuVzrFC7S2Z00Izk5o=
X-Received: by 2002:a05:651c:1213:: with SMTP id i19mr22595466lja.81.1626808548122;
 Tue, 20 Jul 2021 12:15:48 -0700 (PDT)
MIME-Version: 1.0
References: <CALvZod66KF-8xKB1dyY2twizDE=svE8iXT_nqvsrfWg1a92f4A@mail.gmail.com>
 <cover.1626688654.git.vvs@virtuozzo.com> <b19f065e-f3c9-2b20-2798-b60f0fc6b05f@virtuozzo.com>
In-Reply-To: <b19f065e-f3c9-2b20-2798-b60f0fc6b05f@virtuozzo.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Tue, 20 Jul 2021 12:15:37 -0700
Message-ID: <CALvZod7-S6=qzKgcnMh_=pK5HRVR6PdGkVXdNNrv9EJLcYW_aw@mail.gmail.com>
Subject: Re: [PATCH v5 13/16] memcg: enable accounting for signals
To:     Vasily Averin <vvs@virtuozzo.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Cgroups <cgroups@vger.kernel.org>,
        Michal Hocko <mhocko@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Roman Gushchin <guro@fb.com>, Jens Axboe <axboe@kernel.dk>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Oleg Nesterov <oleg@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Mon, Jul 19, 2021 at 3:46 AM Vasily Averin <vvs@virtuozzo.com> wrote:
>
> When a user send a signal to any another processes it forces the kernel
> to allocate memory for 'struct sigqueue' objects. The number of signals
> is limited by RLIMIT_SIGPENDING resource limit, but even the default
> settings allow each user to consume up to several megabytes of memory.
> Moreover, an untrusted admin inside container can increase the limit or
> create new fake users and force them to sent signals.
>
> It makes sense to account for these allocations to restrict the host's
> memory consumption from inside the memcg-limited container.
>
> Signed-off-by: Vasily Averin <vvs@virtuozzo.com>

It seems like there is an agreement on this patch with the updated
commit message. In next version you can add:

Reviewed-by: Shakeel Butt <shakeelb@google.com>
