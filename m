Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35412720A93
	for <lists+cgroups@lfdr.de>; Fri,  2 Jun 2023 22:53:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236297AbjFBUx2 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 2 Jun 2023 16:53:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236300AbjFBUx0 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 2 Jun 2023 16:53:26 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 375F9E52
        for <cgroups@vger.kernel.org>; Fri,  2 Jun 2023 13:53:25 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-565de486762so31707677b3.3
        for <cgroups@vger.kernel.org>; Fri, 02 Jun 2023 13:53:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1685739204; x=1688331204;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=+fG+5ZSAkptAZFJidv7/9+oyabWoMFk8mfKUsXGlGg0=;
        b=wK1p09WOIIRnkXa564ureFQ57MRy9iMKrPOln0YwwE/Rw8OZR3fzlJZiq5HBxRLpkH
         3ZcKf8jeGec78koGS+8A3fzef2GGzvuzmiXEkdpPRekeof/+cw6itBzIXeP7oBplDYXu
         RENyUJUpLE4LR2JQJKLwMtUUm7+E4iikGt4Sa6bxosnO3BgwDDOIAsBpL4kHgB50kBVu
         jGC0TjJFLJqBV/tIiCMA1TyH0A1nt94H+9HtXZ3Hep/sBNd17pXa7SPMg3qYJ1Mx2YN+
         DXOflqNAt8Jq1N6cDVlWptPE+gccL71iYSJLkLd/wHhKkhEewij5gwtzW4oGkN0siEub
         SP9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685739204; x=1688331204;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+fG+5ZSAkptAZFJidv7/9+oyabWoMFk8mfKUsXGlGg0=;
        b=DVL5eGup78Eq5vNwosh3NqEXgQsbdwbT26y/Ryj9yKA8NhFeOIz04Ra/LAvlKqb8M7
         uXSg+nhTjgco+pWQ3yrJSj9nL+TBn3w9nmtymEH+RP2POh6vHZVy6q4LguvSjVyS8jTk
         xRc/mU3VeVlyWnOUZaRJU0oVpP/LkRNuuXCUfcJjhL6EgUD+JZT1+Fgm2MTFHoQGpJvk
         FbKT/sJpe6GvrwrksSyCbtu6nfh8FnUvmfwjihN73h52f6bWgy01b7bXNqQicbNZelX3
         bAi/fOEuLNtyT3ZGQ/FjmPNqR7gisPiy7mWHKXQl2kNtPsbfV/aNzVh2bM3DaCUj9+Fu
         jQYg==
X-Gm-Message-State: AC+VfDwZJm/YwzKNImLyVLqBY000dzjZ63O/kPMn28qAU1uYjKSxnJjY
        SdM80cK3Gqth7uYtkIrcRnAElNSdShxNKA==
X-Google-Smtp-Source: ACHHUZ6/VyNEBjEoo9wnWjEXa9PEbJyPsJUJw7sZiQ+swj5n+8uAxQ+8ijts5la1Uf9FkJtC5uEVjrYkgty+zg==
X-Received: from shakeelb.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:262e])
 (user=shakeelb job=sendgmr) by 2002:a81:ad66:0:b0:55d:955b:360 with SMTP id
 l38-20020a81ad66000000b0055d955b0360mr530382ywk.5.1685739204454; Fri, 02 Jun
 2023 13:53:24 -0700 (PDT)
Date:   Fri, 2 Jun 2023 20:53:22 +0000
In-Reply-To: <20230602081135.75424-4-wuyun.abel@bytedance.com>
Mime-Version: 1.0
References: <20230602081135.75424-1-wuyun.abel@bytedance.com> <20230602081135.75424-4-wuyun.abel@bytedance.com>
Message-ID: <20230602205322.ehxm2q2mbg5laa5s@google.com>
Subject: Re: [PATCH net-next v5 3/3] sock: Fix misuse of sk_under_memory_pressure()
From:   Shakeel Butt <shakeelb@google.com>
To:     Abel Wu <wuyun.abel@bytedance.com>
Cc:     "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Muchun Song <muchun.song@linux.dev>,
        Simon Horman <simon.horman@corigine.com>,
        netdev@vger.kernel.org, linux-mm@kvack.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Fri, Jun 02, 2023 at 04:11:35PM +0800, Abel Wu wrote:
> The status of global socket memory pressure is updated when:
> 
>   a) __sk_mem_raise_allocated():
> 
> 	enter: sk_memory_allocated(sk) >  sysctl_mem[1]
> 	leave: sk_memory_allocated(sk) <= sysctl_mem[0]
> 
>   b) __sk_mem_reduce_allocated():
> 
> 	leave: sk_under_memory_pressure(sk) &&
> 		sk_memory_allocated(sk) < sysctl_mem[0]

There is also sk_page_frag_refill() where we can enter the global
protocol memory pressure on actual global memory pressure i.e. page
allocation failed. However this might be irrelevant from this patch's
perspective as the focus is on the leaving part.

> 
> So the conditions of leaving global pressure are inconstant, which

*inconsistent

> may lead to the situation that one pressured net-memcg prevents the
> global pressure from being cleared when there is indeed no global
> pressure, thus the global constrains are still in effect unexpectedly
> on the other sockets.
> 
> This patch fixes this by ignoring the net-memcg's pressure when
> deciding whether should leave global memory pressure.
> 
> Fixes: e1aab161e013 ("socket: initial cgroup code.")
> Signed-off-by: Abel Wu <wuyun.abel@bytedance.com>

This patch looks good.
