Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DEC396CC1D6
	for <lists+cgroups@lfdr.de>; Tue, 28 Mar 2023 16:15:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233067AbjC1OPk (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 28 Mar 2023 10:15:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233127AbjC1OP3 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 28 Mar 2023 10:15:29 -0400
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CE02CA2D
        for <cgroups@vger.kernel.org>; Tue, 28 Mar 2023 07:15:26 -0700 (PDT)
Received: by mail-pj1-x104a.google.com with SMTP id k4-20020a17090aef0400b0023fcccbd7e6so3375974pjz.5
        for <cgroups@vger.kernel.org>; Tue, 28 Mar 2023 07:15:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1680012925;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=qjzC1AXnpW8l0xPrPEZPgxXh3c0otg2X0grqn38oTAU=;
        b=Z21Fhu3pxXs+t1qejKjoB06mqPadXXUaJj6uhGgpRk+3gLqlDes+wtSSSWE2knRI8/
         qiF1U6JTQdX1HxRtou/7QeC7ME871T4I2lhXvmsiB9LqWDQkJ4A+0KJwwrxD+tJ4Zz1U
         eS8+YEXBsJWpRHPbqfmOGMvVMX3kHO1M02ByL8p7FWqBJtGrwNge2GxAveCUIe2ZNQ6v
         dvl7/FGZwG59zro3vm/oD7ttk1pXq3InfcSBeQsKHb9wmWZOyOVM20v0sF2M0rosq1uZ
         BvtS7Z8Fw8zE99KoUjs5+fCH5VuwRsaKfmGjaYi/I6cgKnvsxM9ic7CzcXo5qhkkLbxE
         V9bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680012925;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qjzC1AXnpW8l0xPrPEZPgxXh3c0otg2X0grqn38oTAU=;
        b=WftlRFBUdpiHSTTchjEnDqfhOAzuibTiTL9+XiLnQ8iRKacxx8scrXzGTY/l8axiYB
         lhc94lnFSGEgYVPOLhwk3ecP5z0cQeJ+VF2pwkPRbqfRn0xEyUjJwYYCosZ1qTv45NTW
         fRO8jA9mSIjlrwBLuayIfE4MlxBmT3BZFpPyCDGhMJdGZ3h66ARyJ006TM/eDggu0tvJ
         qNguUPh+8RP3rOy9PRs/HIGJy8T17UHF1bESCzvKH5qG+ZuHJyxOrCXTU2pq8QRQ/Rdc
         DBADfj87k2DmfTFfjl+yMtrEi48LgqTWNtQyvaBF6MinKkzLS31zgPUxpHc8ONsTQs+T
         zIlQ==
X-Gm-Message-State: AAQBX9e0pAfsjD+eWVoFSNFZWcAIaE7XZaM0lXhf29r6kBQmaACSO68J
        zyLwgthNvlUx5fxeIdxLNud1Yh1jn3vTAQ==
X-Google-Smtp-Source: AKy350YS7K4/XlK9G5uXTQxuk1NaV9HRM+JxBayP8kn09bcoJ8C7tEj08nHpJbsB9L4uvhkNT4kYeDqSgTfetg==
X-Received: from shakeelb.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:262e])
 (user=shakeelb job=sendgmr) by 2002:a63:5a43:0:b0:50a:c176:385b with SMTP id
 k3-20020a635a43000000b0050ac176385bmr4084662pgm.0.1680012925672; Tue, 28 Mar
 2023 07:15:25 -0700 (PDT)
Date:   Tue, 28 Mar 2023 14:15:23 +0000
In-Reply-To: <20230328061638.203420-6-yosryahmed@google.com>
Mime-Version: 1.0
References: <20230328061638.203420-1-yosryahmed@google.com> <20230328061638.203420-6-yosryahmed@google.com>
Message-ID: <20230328141523.txyhl7wt7wtvssea@google.com>
Subject: Re: [PATCH v1 5/9] memcg: replace stats_flush_lock with an atomic
From:   Shakeel Butt <shakeelb@google.com>
To:     Yosry Ahmed <yosryahmed@google.com>
Cc:     Tejun Heo <tj@kernel.org>, Josef Bacik <josef@toxicpanda.com>,
        Jens Axboe <axboe@kernel.dk>,
        Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Muchun Song <muchun.song@linux.dev>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Michal =?utf-8?Q?Koutn=C3=BD?=" <mkoutny@suse.com>,
        Vasily Averin <vasily.averin@linux.dev>,
        cgroups@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        bpf@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-7.7 required=5.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue, Mar 28, 2023 at 06:16:34AM +0000, Yosry Ahmed wrote:
[...]
> @@ -585,8 +585,8 @@ mem_cgroup_largest_soft_limit_node(struct mem_cgroup_tree_per_node *mctz)
>   */
>  static void flush_memcg_stats_dwork(struct work_struct *w);
>  static DECLARE_DEFERRABLE_WORK(stats_flush_dwork, flush_memcg_stats_dwork);
> -static DEFINE_SPINLOCK(stats_flush_lock);
>  static DEFINE_PER_CPU(unsigned int, stats_updates);
> +static atomic_t stats_flush_ongoing = ATOMIC_INIT(0);
>  static atomic_t stats_flush_threshold = ATOMIC_INIT(0);
>  static u64 flush_next_time;
>  
> @@ -636,15 +636,18 @@ static inline void memcg_rstat_updated(struct mem_cgroup *memcg, int val)
>  
>  static void __mem_cgroup_flush_stats(void)
>  {
> -	unsigned long flag;
> -
> -	if (!spin_trylock_irqsave(&stats_flush_lock, flag))
> +	/*
> +	 * We always flush the entire tree, so concurrent flushers can just
> +	 * skip. This avoids a thundering herd problem on the rstat global lock
> +	 * from memcg flushers (e.g. reclaim, refault, etc).
> +	 */
> +	if (atomic_xchg(&stats_flush_ongoing, 1))

Have you profiled this? I wonder if we should replace the above with
	
	if (atomic_read(&stats_flush_ongoing) || atomic_xchg(&stats_flush_ongoing, 1))

to not always dirty the cacheline. This would not be an issue if there
is no cacheline sharing but I suspect percpu stats_updates is sharing
the cacheline with it and may cause false sharing with the parallel stat
updaters (updaters only need to read the base percpu pointer).

Other than that the patch looks good.
