Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EB6768A2D2
	for <lists+cgroups@lfdr.de>; Fri,  3 Feb 2023 20:19:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232976AbjBCTTB (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 3 Feb 2023 14:19:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233697AbjBCTS7 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 3 Feb 2023 14:18:59 -0500
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C43443402D
        for <cgroups@vger.kernel.org>; Fri,  3 Feb 2023 11:18:43 -0800 (PST)
Received: by mail-pg1-x549.google.com with SMTP id g12-20020a656ccc000000b004ee62dadb95so2898348pgw.9
        for <cgroups@vger.kernel.org>; Fri, 03 Feb 2023 11:18:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=eZSuQF+nJSrdc5oiEMr2Huwq3nLEZDXbSVvbFcSGTVg=;
        b=kdvGxpkdksPrb8vTbUnTey3IDTfFIN/yZjMk3GpmvkGAN7QnnRU6Wm0uwX3hcaow+7
         T2nGox0V65Lb0aAooaAgQxOALFaDDn7Qve5uGl0s7QISeFrOG8kcYQelo67MvBD7yLAI
         wc+a19ViT+94h4/58b3oOPid3z4l2Fq2+c1avj5d4t2Zj0hB405MokIZ0ZN9mKkBjudm
         Z/Z2WZJhC65WygoAsw1ZZUC07Rx3Inh91guxjjrPRlS60hV0i8P93hJQx8GmRA84m9T/
         8//OzllptVYu4emQ1Ulx5izXKaecOAF8be+n3ke0lVMJtBRwjUSJrg487jTUVkl/EKPk
         46DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eZSuQF+nJSrdc5oiEMr2Huwq3nLEZDXbSVvbFcSGTVg=;
        b=le644F88sVpF8yP8TzqoKGVb/qCzMNIxZi4e4vbaJXghrhFd+E9OSdPF9ZWEjIOQ4n
         liPx/rb6Kmy/GIqMlY97I7JWXKnjmEl1RmbU4CL0Bcr32zfu97OCcgtQT///Ou5QEzqG
         ZZ10W7NsFxpeLwfMw/u32N2uBMnwzs8NXFUf945x1axF/telNqP+ZNVIcPWrspTgDnZD
         4v03rtKn2W9ZWHZLxE1dumlggs4ViOL27tCVrK2O7iit6BHfm7pdEHgnSBjv6YtocfH4
         AsUdIYx8ezF/gwE+NvKBePvDZTyt9/1b1SLWGoK5vpyVzJnc33n+kL7FcudcsMc2aI/8
         sNhw==
X-Gm-Message-State: AO0yUKXjZdR3yi5B6rw++zDIFJiekoOoU7srjULs5NuVaa/EjS+gj53Y
        pFfoy/0K5BUZmQyQAj6GFlPrUoykVX8JZA==
X-Google-Smtp-Source: AK7set+KFitv4K386psersWMjOdQpsVBs7o/hvcomAg0VVFrQ/F95zkILRWihWHNvcethbqhu8oV9vtuVKl92w==
X-Received: from shakeelb.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:262e])
 (user=shakeelb job=sendgmr) by 2002:a17:902:7788:b0:198:e13d:a04a with SMTP
 id o8-20020a170902778800b00198e13da04amr628723pll.7.1675451922818; Fri, 03
 Feb 2023 11:18:42 -0800 (PST)
Date:   Fri, 3 Feb 2023 19:18:40 +0000
In-Reply-To: <Y9zM0GbmfKdvy3bL@dhcp22.suse.cz>
Mime-Version: 1.0
References: <1675312377-4782-1-git-send-email-zhaoyang.huang@unisoc.com>
 <Y9tz+0J9fw+Z+O+O@dhcp22.suse.cz> <CALvZod5E0s9Vu3wq-Fuvs9z=ViMADn3aNL0f56ELGmFzxKCtkg@mail.gmail.com>
 <Y9zM0GbmfKdvy3bL@dhcp22.suse.cz>
Message-ID: <20230203191840.jh5akertunyk4cx7@google.com>
Subject: Re: [PATCH] mm: introduce entrance for root_mem_cgroup's current
From:   Shakeel Butt <shakeelb@google.com>
To:     Michal Hocko <mhocko@suse.com>
Cc:     "zhaoyang.huang" <zhaoyang.huang@unisoc.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Roman Gushchin <roman.gushchin@linux.dev>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        Zhaoyang Huang <huangzhaoyang@gmail.com>, ke.wang@unisoc.com
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Fri, Feb 03, 2023 at 09:58:56AM +0100, Michal Hocko wrote:
[...]
> > 
> > One advantage I can see is if someone is looking for usage for all top
> > containers (alive or zombie) but I wanted to know if that was the real
> > motivation behind the patch.
> 
> Isn't that just a global stats that we already display via /proc files?
> 

Things are a bit complicated for kernel memory. Let's take a simple
example where there are no processes in the root memcg. In this case the
user memory stats should be similar to the global stats under /proc
because we always charge user memory. However the kernel memory has to
be opted-in to be accounted. So, we have a lot of allocations which are
in the global stats but not in the memcg stats. We can traverse the top
level memcgs to get kernel stats and subtract it from the global stats
which will give the sum of zombie kernel memory and unaccounted kernel
memory. For debugging and history/analysis purpose, differentiating
between zombie and unaccounted makes sense.
