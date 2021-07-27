Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A68993D81EC
	for <lists+cgroups@lfdr.de>; Tue, 27 Jul 2021 23:39:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231445AbhG0Vjh (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 27 Jul 2021 17:39:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231339AbhG0Vjg (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 27 Jul 2021 17:39:36 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25B7AC061757
        for <cgroups@vger.kernel.org>; Tue, 27 Jul 2021 14:39:36 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id m13so24244366lfg.13
        for <cgroups@vger.kernel.org>; Tue, 27 Jul 2021 14:39:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=586qQ0VfqS2t1FgawENmqvW9B/cgMqgnCEiHKLyzI/E=;
        b=u1/MVJO4zcfaei7PD7eWb+709nz15VrWARci7ePDMDFolJNUERP2wsbjom+4NbVKF7
         ssCxzxA0a2UMxu67QqmKkzf8Ut6ydxeIlIqw2blw57FpMzpCZ3PC+AX7TZdUAx0tipyl
         G8luFgvQvburMncuoSBNoiciSrzOHj4b5hjw5HfttQCJX69lVCqpmjGkRnGShNJwduXw
         Zh8TM0wbJKBTwe0RiYKQ6DlcLgR+hq+p9L+JSK8/8r1bCXiy6mY+G/ZI55irmnQDLRxC
         ZeISUoXD1z4L5Wyc48m90u3UbQaFELITPkCenCYevX5lJ/OgtMDHFVm6vd5w9iw29W+4
         Bw0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=586qQ0VfqS2t1FgawENmqvW9B/cgMqgnCEiHKLyzI/E=;
        b=ZkmHkd7YjIj5rCJi3KZMm7/td0FljaA9ayM02PY/ciqh2CJfW/OR2w7FUQ8MLSFuHf
         QECFzZDh5wifiivNNjhWcCm/BFiXf1yCfIkzaYotk+lXAtDwEwQJV4xTOPmCWPAZVHzQ
         BxR2u0FoJD2lH3jf+QMsZAajjgTnWhqsJoS0hPzlOYTS+ZpZhcepJ/K+5xd+CHTGgz9I
         2ULWsUa6Kure15Cq0RQSWwQQ7ijXsdhgmvl6zUnFJxVnmI+7EWbiiLmhkn06Ho8w7Dq2
         ILydcJ/vhq458GH2VjDhwnZf/DFoAWQZaqUt/nV4T2CyPUmWt4njCCRt75Ome5Hte+X2
         eu0g==
X-Gm-Message-State: AOAM530wLjxwOcrt3ve0LDitPfyTwg8a7Gn9zKcojWakAAslgvvC3GXn
        tD7CN7wVckVYI/BZCzWN7ynD2fgiskCxHxl5sPmQ9HlfbdPrxA==
X-Google-Smtp-Source: ABdhPJwwdSCswMAky7kROjCs9+RNQPi2B9KOACTRASBYz1YEPyZkM5BZYLuBNqCTFu4siT0t1TDHb1BYSgpDsRxP1UA=
X-Received: by 2002:a19:ae0f:: with SMTP id f15mr18055453lfc.117.1627421974281;
 Tue, 27 Jul 2021 14:39:34 -0700 (PDT)
MIME-Version: 1.0
References: <6f21a0e0-bd36-b6be-1ffa-0dc86c06c470@virtuozzo.com>
 <cover.1627362057.git.vvs@virtuozzo.com> <56e31cb5-6e1e-bdba-d7ca-be64b9842363@virtuozzo.com>
In-Reply-To: <56e31cb5-6e1e-bdba-d7ca-be64b9842363@virtuozzo.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Tue, 27 Jul 2021 14:39:23 -0700
Message-ID: <CALvZod7e8pNhCU-o8-dFwn5v4aVoUrxxjGamfbaqK83d3UL1Mw@mail.gmail.com>
Subject: Re: [PATCH v7 02/10] memcg: enable accounting for pollfd and select
 bits arrays
To:     Vasily Averin <vvs@virtuozzo.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Cgroups <cgroups@vger.kernel.org>,
        Michal Hocko <mhocko@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Roman Gushchin <guro@fb.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Mon, Jul 26, 2021 at 10:33 PM Vasily Averin <vvs@virtuozzo.com> wrote:
>
> User can call select/poll system calls with a large number of assigned
> file descriptors and force kernel to allocate up to several pages of memory
> till end of these sleeping system calls. We have here long-living
> unaccounted per-task allocations.
>
> It makes sense to account for these allocations to restrict the host's
> memory consumption from inside the memcg-limited container.
>
> Signed-off-by: Vasily Averin <vvs@virtuozzo.com>
> ---
>  fs/select.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/fs/select.c b/fs/select.c
> index 945896d..e83e563 100644
> --- a/fs/select.c
> +++ b/fs/select.c
> @@ -655,7 +655,7 @@ int core_sys_select(int n, fd_set __user *inp, fd_set __user *outp,
>                         goto out_nofds;
>
>                 alloc_size = 6 * size;
> -               bits = kvmalloc(alloc_size, GFP_KERNEL);
> +               bits = kvmalloc(alloc_size, GFP_KERNEL_ACCOUNT);

What about the similar allocation in compat_core_sys_select()? Also
what about the allocation in poll_get_entry()?

>                 if (!bits)
>                         goto out_nofds;
>         }
> @@ -1000,7 +1000,7 @@ static int do_sys_poll(struct pollfd __user *ufds, unsigned int nfds,
>
>                 len = min(todo, POLLFD_PER_PAGE);
>                 walk = walk->next = kmalloc(struct_size(walk, entries, len),
> -                                           GFP_KERNEL);
> +                                           GFP_KERNEL_ACCOUNT);
>                 if (!walk) {
>                         err = -ENOMEM;
>                         goto out_fds;
> --
> 1.8.3.1
>
