Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0D2B6DE84F
	for <lists+cgroups@lfdr.de>; Wed, 12 Apr 2023 01:48:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229567AbjDKXs6 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 11 Apr 2023 19:48:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229548AbjDKXs4 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 11 Apr 2023 19:48:56 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69F4C4225
        for <cgroups@vger.kernel.org>; Tue, 11 Apr 2023 16:48:50 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id a640c23a62f3a-947abd74b10so477670766b.2
        for <cgroups@vger.kernel.org>; Tue, 11 Apr 2023 16:48:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1681256929; x=1683848929;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xoyQVeaFsgpeGhfzOdZSPoa4a8w+FT9SRbAgSywf7sc=;
        b=qDjRrSVe7rsc75FviosB6qBZZ8fCZ27cRjYKQggjvqCGoWu4bJAUH/sIetxt+jzJmA
         C9SIxTBxB4l4i/l8YBaF/G4nsjyQj4fLt+nst3hlwnb76omBpv+cgdFVmcsgGIPpzEe8
         kPANJ5G/LZzwI2nbaWbd5sCf7GJX4TkHJKdcoey1qCE3RRRT3fG+f++YWyLHngRa6OA0
         GGOzSZDP0zNup7QsE8n2/iT33pRTx7h89PnzZyF5K/DNwnlY3syA43611ydty5JEeTYe
         lIkyLa9naq08kcgIbNf0WqfSC50meamQ5Veq+kczO7cHl5BDnXd2a4kHWujmddiHMSeT
         HVLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681256929; x=1683848929;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xoyQVeaFsgpeGhfzOdZSPoa4a8w+FT9SRbAgSywf7sc=;
        b=pMKJUip+/YXbnN89ehPpxf3Y4I8sywjcxdjm61yNL+lS3M7GbgguaabupDQEwpAB/q
         2D+0s+mmHWp5CPar1GcKl1oLyvpMbBLlrddHGUKJLp8XXO/vpF58+Mak8nre1P4mKWcV
         PTvFlp3DY37vR5OdFKTBBdEJaKcTOqrIviVkfbEPiBViEAEIJnkHvCUd0LeGrQ5If75n
         pman7n2sAdTnMcPQ0sgVD2xq7xRMQPE2MyAfmHtHGHSxmZ4SLfJ1I3opZudvLsn0Lbji
         201Zc2JXuuC4AGm3NzJKjiyIMTE3xn81oy0eRWxzXJNUsWrFfyXR2hZ3xbN1vmHuonG3
         +i/A==
X-Gm-Message-State: AAQBX9cdPAh/SbmipVJSszmtXtDI4XVYMvM/+WO3SI0EhcPdyNc4E+wx
        HvYuZ1Jt38XeNvUi6LhhwFCOv5R5E1+GcDshX5DL2g==
X-Google-Smtp-Source: AKy350aZHW00zKNbOfPWEMuywutfcfS3WFGXLIvU+WGuLxH7vQzLyshmSGH8jpwUKpfgctR2eUf/owFlFW5x9NG6o1Y=
X-Received: by 2002:a50:cddc:0:b0:4fb:9735:f915 with SMTP id
 h28-20020a50cddc000000b004fb9735f915mr7538990edj.8.1681256928740; Tue, 11 Apr
 2023 16:48:48 -0700 (PDT)
MIME-Version: 1.0
References: <CABdmKX2M6koq4Q0Cmp_-=wbP0Qa190HdEGGaHfxNS05gAkUtPA@mail.gmail.com>
In-Reply-To: <CABdmKX2M6koq4Q0Cmp_-=wbP0Qa190HdEGGaHfxNS05gAkUtPA@mail.gmail.com>
From:   Yosry Ahmed <yosryahmed@google.com>
Date:   Tue, 11 Apr 2023 16:48:12 -0700
Message-ID: <CAJD7tkZw9uVPe5KH2xrihsv5nDmExJmkmsUPYP6Npvv6Q0NcVw@mail.gmail.com>
Subject: Re: [LSF/MM/BPF TOPIC] Reducing zombie memcgs
To:     "T.J. Mercier" <tjmercier@google.com>
Cc:     lsf-pc@lists.linux-foundation.org, linux-mm@kvack.org,
        cgroups@vger.kernel.org, Tejun Heo <tj@kernel.org>,
        Shakeel Butt <shakeelb@google.com>,
        Muchun Song <muchun.song@linux.dev>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Alistair Popple <apopple@nvidia.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Kalesh Singh <kaleshsingh@google.com>,
        Yu Zhao <yuzhao@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue, Apr 11, 2023 at 4:36=E2=80=AFPM T.J. Mercier <tjmercier@google.com>=
 wrote:
>
> When a memcg is removed by userspace it gets offlined by the kernel.
> Offline memcgs are hidden from user space, but they still live in the
> kernel until their reference count drops to 0. New allocations cannot
> be charged to offline memcgs, but existing allocations charged to
> offline memcgs remain charged, and hold a reference to the memcg.
>
> As such, an offline memcg can remain in the kernel indefinitely,
> becoming a zombie memcg. The accumulation of a large number of zombie
> memcgs lead to increased system overhead (mainly percpu data in struct
> mem_cgroup). It also causes some kernel operations that scale with the
> number of memcgs to become less efficient (e.g. reclaim).
>
> There are currently out-of-tree solutions which attempt to
> periodically clean up zombie memcgs by reclaiming from them. However
> that is not effective for non-reclaimable memory, which it would be
> better to reparent or recharge to an online cgroup. There are also
> proposed changes that would benefit from recharging for shared
> resources like pinned pages, or DMA buffer pages.

I am very interested in attending this discussion, it's something that
I have been actively looking into -- specifically recharging pages of
offlined memcgs.

>
> Suggested attendees:
> Yosry Ahmed <yosryahmed@google.com>
> Yu Zhao <yuzhao@google.com>
> T.J. Mercier <tjmercier@google.com>
> Tejun Heo <tj@kernel.org>
> Shakeel Butt <shakeelb@google.com>
> Muchun Song <muchun.song@linux.dev>
> Johannes Weiner <hannes@cmpxchg.org>
> Roman Gushchin <roman.gushchin@linux.dev>
> Alistair Popple <apopple@nvidia.com>
> Jason Gunthorpe <jgg@nvidia.com>
> Kalesh Singh <kaleshsingh@google.com>
