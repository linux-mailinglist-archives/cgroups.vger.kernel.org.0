Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24C1F7C01EF
	for <lists+cgroups@lfdr.de>; Tue, 10 Oct 2023 18:49:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233843AbjJJQs7 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 10 Oct 2023 12:48:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232338AbjJJQs7 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 10 Oct 2023 12:48:59 -0400
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com [IPv6:2607:f8b0:4864:20::b34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 301958E;
        Tue, 10 Oct 2023 09:48:57 -0700 (PDT)
Received: by mail-yb1-xb34.google.com with SMTP id 3f1490d57ef6-d9a5adc8cefso1008413276.0;
        Tue, 10 Oct 2023 09:48:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696956536; x=1697561336; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=F6yfbZUcdTYweQuQIVJ4G7iiHQ0Y4iE8YHYGN5BB78g=;
        b=M667UaDewUiIRCot52Asmdw75GRjVUueZRmmT+qwUSIhXUat/GGao6ACXpToELgwFB
         DeXarmYeXk2Wo4oIbmyxslW4wr4cXbAj/lCuMjMPLwW04G/XXB4xqM2a9tQwOK3O904+
         n3bxFuv+c5K4IY6YW3688u9ZoRP3HGo0lj9LnnkB2kv4EMAdhTz4sxSHXHSZDQKiBgZF
         b5NbTO1YzNVLaT5El+7/k8cpeHkouDrkgKddNow7uj/W68o9YERZT2SNyxwN+sL+Ib32
         JGMKLE62XbH5bEuKQLGYTD9vpl4CAdWVv9BAGikHEuH9C/8e5ALaSWXj5XB6CHcAsELY
         VpJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696956536; x=1697561336;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=F6yfbZUcdTYweQuQIVJ4G7iiHQ0Y4iE8YHYGN5BB78g=;
        b=Bnr35v6J84Y+AxNIX98uGmFqfuin/xhLjkoF3lOS0xDKYeU1qNY+PNjFMSNJ4KZNC+
         esi349OPs1ab3Ip+ZIdbL+zHB7o0IesIR5JLvc45a2gxVjLlr72d7K3mL9Td9+QinUDA
         aDREldrxHHhteyJoyAaWtsIA5k2kH4i0jhe96SZO+6LbA7lMwOUFRA+4FJpc0MHspMzt
         2GASb6vyZ6Haf1l8bjc9jRHPByy2Hc6daVNYvXV93Xn4z98EUUSbWsC88xep6v/I8nhT
         O87ISz8jgbCp8SOchrqBZb7L6prqNHhVS1bU2tEOchdo5SIAjeeE+E4OHWuK2MAt4d40
         kqSQ==
X-Gm-Message-State: AOJu0Yy+lfoET7mM6SV5hTL8k5Z84tOZtwvQA0IuBL+bp+Kb05MRZM40
        hEBLMlgdVhqb3hbG/jK+SuTKfAD3VmYGAvKODKg=
X-Google-Smtp-Source: AGHT+IG1Q1H2aRZkN+GdQsf18X5YRzerJzVeovsTDs2fjFiqLpKPd7sueu8wJF9sq0/Vlu99kOr7hui0Jdwrt8Phsgg=
X-Received: by 2002:a25:2390:0:b0:d9a:4367:1a92 with SMTP id
 j138-20020a252390000000b00d9a43671a92mr3092795ybj.50.1696956536082; Tue, 10
 Oct 2023 09:48:56 -0700 (PDT)
MIME-Version: 1.0
References: <20231010032117.1577496-1-yosryahmed@google.com>
In-Reply-To: <20231010032117.1577496-1-yosryahmed@google.com>
From:   domenico cerasuolo <cerasuolodomenico@gmail.com>
Date:   Tue, 10 Oct 2023 18:48:45 +0200
Message-ID: <CAFYChMv_kv_KXOMRkrmTN-7MrfgBHMcK3YXv0dPYEL7nK77e2A@mail.gmail.com>
Subject: Re: [PATCH v2 0/5] mm: memcg: subtree stats flushing and thresholds
To:     Yosry Ahmed <yosryahmed@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Shakeel Butt <shakeelb@google.com>,
        Muchun Song <muchun.song@linux.dev>,
        Ivan Babrou <ivan@cloudflare.com>, Tejun Heo <tj@kernel.org>,
        =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>,
        Waiman Long <longman@redhat.com>, kernel-team@cloudflare.com,
        Wei Xu <weixugc@google.com>, Greg Thelen <gthelen@google.com>,
        linux-mm@kvack.org, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Il giorno mar 10 ott 2023 alle ore 05:21 Yosry Ahmed
<yosryahmed@google.com> ha scritto:
>
> This series attempts to address shortages in today's approach for memcg
> stats flushing, namely occasionally stale or expensive stat reads. The
> series does so by changing the threshold that we use to decide whether
> to trigger a flush to be per memcg instead of global (patch 3), and then
> changing flushing to be per memcg (i.e. subtree flushes) instead of
> global (patch 5).
>
> Patch 3 & 5 are the core of the series, and they include more details
> and testing results. The rest are either cleanups or prep work.
>
> This series replaces the "memcg: more sophisticated stats flushing"
> series [1], which also replaces another series, in a long list of
> attempts to improve memcg stats flushing. It is not a new version of
> the same patchset as it is a completely different approach. This is
> based on collected feedback from discussions on lkml in all previous
> attempts. Hopefully, this is the final attempt.
>
> [1]https://lore.kernel.org/lkml/20230913073846.1528938-1-yosryahmed@google.com/
>
> v1 -> v2:
> - Fixed compilation error reported by the kernel robot in patch 4, also
>   added a missing rcu_read_unlock().
> - More testing results in the commit message of patch 3.
>
> Yosry Ahmed (5):
>   mm: memcg: change flush_next_time to flush_last_time
>   mm: memcg: move vmstats structs definition above flushing code
>   mm: memcg: make stats flushing threshold per-memcg
>   mm: workingset: move the stats flush into workingset_test_recent()
>   mm: memcg: restore subtree stats flushing
>
>  include/linux/memcontrol.h |   8 +-
>  mm/memcontrol.c            | 269 +++++++++++++++++++++----------------
>  mm/vmscan.c                |   2 +-
>  mm/workingset.c            |  42 ++++--
>  4 files changed, 185 insertions(+), 136 deletions(-)
>
> --
> 2.42.0.609.gbb76f46606-goog
>
>

Hi Yosry,

thanks for this series! We backported it on a 5.19-based kernel and ran it on a
machine for almost a week now. The goal was to fix a CPU utilization regression
caused by memory stats readings, it seems that this series was the last bit
needed to completely fix it and bring CPU utilization to 5.12 levels.

FWIW,

Tested-by: Domenico Cerasuolo <cerasuolodomenico@gmail.com>
