Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A94876C5E07
	for <lists+cgroups@lfdr.de>; Thu, 23 Mar 2023 05:33:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229691AbjCWEc7 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 23 Mar 2023 00:32:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229612AbjCWEc6 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 23 Mar 2023 00:32:58 -0400
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com [IPv6:2607:f8b0:4864:20::b34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D688AD31
        for <cgroups@vger.kernel.org>; Wed, 22 Mar 2023 21:32:55 -0700 (PDT)
Received: by mail-yb1-xb34.google.com with SMTP id e71so23497108ybc.0
        for <cgroups@vger.kernel.org>; Wed, 22 Mar 2023 21:32:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1679545974;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wrIDK0fVrbx7cxzc4APSQQIB8Tdld7ibFj4Oysy8xfU=;
        b=FIzImCYRhfKjUT9pnu01dLLA4HDQ3BXtcjgTBHFJpnBLcGZGoGO939DvVsE0ACCLBD
         HAUrEyMh7dQYQpfiSzh1z2T4aoliQXDY2PtH8zUgWHZJ+Wlzj09Hc57J7+LzbWPLwJ30
         QPFFiP3KO6t2VwC9VgJYqd0EckGB6umtsMwnb3yJ2JSFju2Dm4jDvh5VHkd965tUFaZj
         W+NjP9qTR3O5ZH/o08OwnNf2A5eKq4nOVV2mM+FZmrLAYG0SehoQ+EDazL9xDG8TNlTx
         kCxHR0bIyEU/UZVe+dMYjlb9si4q45Gfnc1KLNTqhs8UX7jHYv+TWSPptwMfEaiMEV+x
         pf/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679545974;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wrIDK0fVrbx7cxzc4APSQQIB8Tdld7ibFj4Oysy8xfU=;
        b=Z6USUidP2DJiD7qB+PLd5pxd7VZHGwfctSKxAZg2WauV5yt+uvQl16r+/9qPY5mNCX
         snqAmerqZa/khK5Q5HpUaMHLGx5X0Sn4zgUZYCIzO0VFcs8WNr4SudkyDv6lgxIz+w8U
         VeRFcxeuBG2ut/sZuCh50DoaJJcIy3IiCI4KpH0RCb18gHXO3PaKQYBjiHf37tSickaB
         Oyvrq+CVe3DT93bk2BD0XHnCkA/yD1cypEOf0pQwRyVGco+Sxcj27BoaPG63NFDZKzcP
         VjsxLHt9uFPkvvMmY+H79gI21nboB7AaHLlC8lAQbdPsESpbFxshSlrnesW3k3Wjut5m
         Y00Q==
X-Gm-Message-State: AAQBX9cIRxz3yUyab+fXuwCtEPZ1JYgyt/6Lce79RyCqjiZgHroVIb35
        ENnj/iseiMexqfowXrGVHnAfqQYxbPRPGa6yD8+hfw==
X-Google-Smtp-Source: AKy350bBapFtyhRnakDaJ98q33qTvbSPFQRHJsMpzHiU7Bnmsr7y712jIsm3XTxYLrqYW8o05V+X9pbP9RgpV7J2f94=
X-Received: by 2002:a25:800d:0:b0:b3b:6576:b22b with SMTP id
 m13-20020a25800d000000b00b3b6576b22bmr1372177ybk.12.1679545974133; Wed, 22
 Mar 2023 21:32:54 -0700 (PDT)
MIME-Version: 1.0
References: <20230323040037.2389095-1-yosryahmed@google.com> <20230323040037.2389095-3-yosryahmed@google.com>
In-Reply-To: <20230323040037.2389095-3-yosryahmed@google.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Wed, 22 Mar 2023 21:32:42 -0700
Message-ID: <CALvZod5MnM8UJ0pj44QYb4sVwgFZ1B2KpSL6oqBQbJU3wH6eNA@mail.gmail.com>
Subject: Re: [RFC PATCH 2/7] memcg: do not disable interrupts when holding stats_flush_lock
To:     Yosry Ahmed <yosryahmed@google.com>
Cc:     Tejun Heo <tj@kernel.org>, Josef Bacik <josef@toxicpanda.com>,
        Jens Axboe <axboe@kernel.dk>,
        Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Muchun Song <muchun.song@linux.dev>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vasily Averin <vasily.averin@linux.dev>,
        cgroups@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-15.7 required=5.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed, Mar 22, 2023 at 9:00=E2=80=AFPM Yosry Ahmed <yosryahmed@google.com>=
 wrote:
>
> The rstat flushing code was modified so that we do not disable interrupts
> when we hold the global rstat lock. Do the same for stats_flush_lock on
> the memcg side to avoid unnecessarily disabling interrupts throughout
> flushing.
>
> Since the code exclusively uses trylock to acquire this lock, it should
> be fine to hold from interrupt contexts or normal contexts without
> disabling interrupts as a deadlock cannot occur. For interrupt contexts
> we will return immediately without flushing anyway.
>
> Signed-off-by: Yosry Ahmed <yosryahmed@google.com>
> ---
>  mm/memcontrol.c | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)
>
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index 5abffe6f8389..e0e92b38fa51 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -636,15 +636,17 @@ static inline void memcg_rstat_updated(struct mem_c=
group *memcg, int val)
>
>  static void __mem_cgroup_flush_stats(void)
>  {
> -       unsigned long flag;
> -
> -       if (!spin_trylock_irqsave(&stats_flush_lock, flag))
> +       /*
> +        * This lock can be acquired from interrupt context,

How? What's the code path?

> but we only acquire
> +        * using trylock so it should be fine as we cannot cause a deadlo=
ck.
> +        */
> +       if (!spin_trylock(&stats_flush_lock))
>                 return;
>
>         flush_next_time =3D jiffies_64 + 2*FLUSH_TIME;
>         cgroup_rstat_flush_irqsafe(root_mem_cgroup->css.cgroup);
>         atomic_set(&stats_flush_threshold, 0);
> -       spin_unlock_irqrestore(&stats_flush_lock, flag);
> +       spin_unlock(&stats_flush_lock);
>  }
>
>  void mem_cgroup_flush_stats(void)
> --
> 2.40.0.rc1.284.g88254d51c5-goog
>
