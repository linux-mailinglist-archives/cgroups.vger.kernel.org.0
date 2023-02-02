Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 722706875F3
	for <lists+cgroups@lfdr.de>; Thu,  2 Feb 2023 07:37:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229595AbjBBGhX (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 2 Feb 2023 01:37:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231661AbjBBGhU (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 2 Feb 2023 01:37:20 -0500
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E186F7FA2D;
        Wed,  1 Feb 2023 22:37:19 -0800 (PST)
Received: by mail-lf1-x12a.google.com with SMTP id v17so1525469lfd.7;
        Wed, 01 Feb 2023 22:37:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=sjq+FUKGizOs7h66douqWeyIbS6vjmS9C/mxYaq9ggI=;
        b=CEYtJidcoUV7ecHhyZdegKvU786pxfV7Cf5FxLFE3398jNQPQRDXZQko1jktTqOQDl
         DNp9x9yxTsrtdziww+YiXSRZBQ00pRbftQWRDPtF6zMZt1pSLaL53NVdTn5F0W/VKXxq
         TFCWzWoKWKWDRncDMD1Lxc7OTNziHidFFUxN77rhfHInT8P4UvLHiwLlJ9M7+/DZYlWr
         57CpK7zWr/v6jEZewb1/xshww6dRPzpF6qUHj+S1NGacrbzyrootvWW+lLM903u9tAvk
         YYFyuAL4FOxrUDOtRiLB1xirQme2ThIH/lee4JcanhSaZ5BdxW1xF7d7Zb1vOaD/z3PZ
         dWWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sjq+FUKGizOs7h66douqWeyIbS6vjmS9C/mxYaq9ggI=;
        b=QtaFm8Mg4vEGDrTgBzMB2RD5Z0/ZbLdjgkvLSR4clSq2B5DKa7NjVjx6p0BEzw//RP
         EUhUS7O18lcVTnbgXQVx1eI4Rqf5/NVPqXefZ/RAMgALue+GZ7BYbwEqmc+MMNV9wXtH
         eEuv3ZdXabeL/oWSN5l8qgY71iaAAJK+MCuoOM9VNeCRVXiQNsuGaod4/MZiicmdVGzQ
         Y673jbN9TYkBFTQkR3H2cLKd+NB4VzcNmDKEDIKHQvtYSroFvs1KdCNKF0bOl/WyBvSt
         +9/oixXzNCvInMagqsVK2RTSH4z5dqR8Uwk9f2zFOH4SniDkj+vxu0hBYGzJxn4bTI7M
         pllw==
X-Gm-Message-State: AO0yUKVFlzceHDa99u6EjDgn2lyR8UfxQXR1iw+ksAZ2UoraHPY6snNi
        vF8b/+bq8QOWqNpNZ9/lpqUjew/bWnVZR751G4g=
X-Google-Smtp-Source: AK7set9ltlLhdillYWqN3VjhNc46MZ34+mIPsPUBglUAm1UdJYjWELf5j7DCDd6EOQ1ZZzsbIdbZLf19Qt3zi8gAPsk=
X-Received: by 2002:ac2:53b5:0:b0:4d7:cd2c:ef99 with SMTP id
 j21-20020ac253b5000000b004d7cd2cef99mr1020411lfh.119.1675319838044; Wed, 01
 Feb 2023 22:37:18 -0800 (PST)
MIME-Version: 1.0
References: <1675312377-4782-1-git-send-email-zhaoyang.huang@unisoc.com> <CALvZod4Z5CCD-zgHgYt3iRR1JG60GXCuhWm+fpzXo4ivTJx09Q@mail.gmail.com>
In-Reply-To: <CALvZod4Z5CCD-zgHgYt3iRR1JG60GXCuhWm+fpzXo4ivTJx09Q@mail.gmail.com>
From:   Zhaoyang Huang <huangzhaoyang@gmail.com>
Date:   Thu, 2 Feb 2023 14:36:55 +0800
Message-ID: <CAGWkznG6s0RN=gj+nUEfO5KuZw84fxG_KcHMazJu-yJ4OQH5CQ@mail.gmail.com>
Subject: Re: [PATCH] mm: introduce entrance for root_mem_cgroup's current
To:     Shakeel Butt <shakeelb@google.com>
Cc:     "zhaoyang.huang" <zhaoyang.huang@unisoc.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Michal Hocko <mhocko@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        ke.wang@unisoc.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Thu, Feb 2, 2023 at 2:30 PM Shakeel Butt <shakeelb@google.com> wrote:
>
> On Wed, Feb 1, 2023 at 8:34 PM zhaoyang.huang <zhaoyang.huang@unisoc.com> wrote:
> >
> > From: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
> >
> > Introducing memory.root_current for the memory charges on root_mem_cgroup.
>
> Why and how are you planning to use it?
root_mem_cgroup is lack of such statistic entry for debug purpose,
which is the counterpart of memory.current within other memcgs
