Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1AAAD688652
	for <lists+cgroups@lfdr.de>; Thu,  2 Feb 2023 19:27:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231185AbjBBS1a (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 2 Feb 2023 13:27:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229974AbjBBS13 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 2 Feb 2023 13:27:29 -0500
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com [IPv6:2607:f8b0:4864:20::b2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45F6A61D40
        for <cgroups@vger.kernel.org>; Thu,  2 Feb 2023 10:27:28 -0800 (PST)
Received: by mail-yb1-xb2e.google.com with SMTP id x139so3305407ybe.13
        for <cgroups@vger.kernel.org>; Thu, 02 Feb 2023 10:27:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=pjDgomZIywp7e6CSQ2Vxhlha4qbmdscu2vXAz8lYKTA=;
        b=kBmTcd8o1o1lVFPHTCamTTlrH1XgzC6/Lm8P51JWY63/kZfoZBGAxxVnl7fM/nB325
         IxzufFGHbol1OmmWvAiywYQ+Fy1QBuXWrZwLlN1qQ9z7IxRm32vgeSaVK119yYYHHSqD
         TChuw3JNRefL7J6YRb8mNWhTuYUswyasUCYKhDwn09eouJjPhcFUN0BUZQV2duIsSs/+
         fYf40hTpoQqE25xwSQupwMUMWfX4lPXh6vDLt1AW/718EH/LIEdCdGVP5lsYKzieKxN9
         ASVVs6xST3c54vncqQG/W+tR2N8h6Dj53Uzd1jGD1vjnvlqo65wzLMf6u8eqeM5CeZar
         VTgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pjDgomZIywp7e6CSQ2Vxhlha4qbmdscu2vXAz8lYKTA=;
        b=KTgLAl+VyqniSkYXemMbZ6/A/ci9Fca2sFpcYephcOjJeWG4KSRB+smiEZLtzU7aFV
         e+2BGCeox95Kz8bOmK15NUWYm4ifFcLD2B1eUAEz3ChMMJ926HQ7YbkBy0bAIgsSuBF6
         jZnZiuHRiGsBhtdJkW1NJN2dgoQb+zggZsGcqnJLemAW6a08lVIEfdtLWJ9XZaCga9e2
         vMqTpBvTj61RFJ/7EkgzgVlFuiKsB88mjnZAbPsT6kr4qO6RL1gG5CvA5ISgGnCtxBH0
         1dwCQdN5RO2iWSseIZ/9R95yz/o4ly+yRbJ8Ib+kkDfRzD+vjst+dpzUzwbmc5oQDhFM
         j8gw==
X-Gm-Message-State: AO0yUKXBM9C6voVF3Co0Z3FY2o6T/hXEarKHiR9U2xokwIp/91cF0ZcF
        XSWHFtOGC1nddOQs6JnlwQ5P4eTUOL9oYFnEs+7aoQ==
X-Google-Smtp-Source: AK7set/Hnx6lJHCqj73tIGeDFi1YJ8GWSUaM63IsKEvF4eFWlNkSiVnp42bGA0R4p4mwFHS+jEPi0S9fHu83FSWWH1Y=
X-Received: by 2002:a25:ada8:0:b0:836:46e3:fa42 with SMTP id
 z40-20020a25ada8000000b0083646e3fa42mr593380ybi.228.1675362447371; Thu, 02
 Feb 2023 10:27:27 -0800 (PST)
MIME-Version: 1.0
References: <20230202155626.1829121-1-hannes@cmpxchg.org>
In-Reply-To: <20230202155626.1829121-1-hannes@cmpxchg.org>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Thu, 2 Feb 2023 10:27:16 -0800
Message-ID: <CALvZod6m-XOb6LvjAD0wXv1doP_LJb1yUJ-QRpJt3H+G=xyQXg@mail.gmail.com>
Subject: Re: [RFC PATCH] mm: memcontrol: don't account swap failures not due
 to cgroup limits
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Michal Hocko <mhocko@suse.com>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Tejun Heo <tj@kernel.org>, linux-mm@kvack.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        Christian Brauner <brauner@kernel.org>
Content-Type: text/plain; charset="UTF-8"
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

On Thu, Feb 2, 2023 at 7:56 AM Johannes Weiner <hannes@cmpxchg.org> wrote:
>
> Christian reports the following situation in a cgroup that doesn't
> have memory.swap.max configured:
>
>   $ cat memory.swap.events
>   high 0
>   max 0
>   fail 6218
>
> Upon closer examination, this is an ARM64 machine that doesn't support
> swapping out THPs. In that case, the first get_swap_page() fails, and
> the kernel falls back to splitting the THP and swapping the 4k
> constituents one by one. /proc/vmstat confirms this with a high rate
> of thp_swpout_fallback events.
>
> While the behavior can ultimately be explained, it's unexpected and
> confusing. I see three choices how to address this:
>
> a) Specifically exlude THP fallbacks from being counted, as the
>    failure is transient and the memory is ultimately swapped.
>
>    Arguably, though, the user would like to know if their cgroup's
>    swap limit is causing high rates of THP splitting during swapout.
>
> b) Only count cgroup swap events when they are actually due to a
>    cgroup's own limit. Exclude failures that are due to physical swap
>    shortage or other system-level conditions (like !THP_SWAP). Also
>    count them at the level where the limit is configured, which may be
>    above the local cgroup that holds the page-to-be-swapped.
>
>    This is in line with how memory.swap.high, memory.high and
>    memory.max events are counted.
>
>    However, it's a change in documented behavior.
>
> c) Leave it as is. The documentation says system-level events are
>    counted, so stick to that.
>
>    This is the conservative option, but isn't very user friendly.
>    Cgroup events are usually due to a local control choice made by the
>    user. Mixing in events that are beyond the user's control makes it
>    difficult to id root causes and configure the system properly.
>
> Implement option b).

I prefer option b too.

>
> Reported-by: Christian Brauner <brauner@kernel.org>
> Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>

Acked-by: Shakeel Butt <shakeelb@google.com>

I think we should CC stable as well for early exposure.
