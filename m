Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 339A24A884D
	for <lists+cgroups@lfdr.de>; Thu,  3 Feb 2022 17:06:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236118AbiBCQG1 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 3 Feb 2022 11:06:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229993AbiBCQG1 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 3 Feb 2022 11:06:27 -0500
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C83DC061714;
        Thu,  3 Feb 2022 08:06:27 -0800 (PST)
Received: by mail-pf1-x431.google.com with SMTP id v74so2622357pfc.1;
        Thu, 03 Feb 2022 08:06:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Egk8ptnkjCf/i7Q94WgOkfmqeEgzwPogxM8QtrgBZYM=;
        b=WCquLTl47IgfLUUw0s5GBcjV6TNgPToIqQtfdlzNi5SiIdfzkOGCmId4jUQ6vC965+
         gqhh8aoHnYpa2MAwFLNMnUAJiUVo92O+2/95zawyzBPJgGeY/wUXT0FdJab5g7yZKsrp
         2ueB3eOJf1tQmxbDJYHn94zjBV52wbghhrlXZQuw84NR5hGHa7rKmxykwWI9dKPoK29+
         YTCnIDIMv7Cd6t9OqKmQ6X3Yt/gPnCAgu6I+gjnxC+iUugLLqw5+8GOXCAPZ+AdWJDOq
         xVeiLeSuqNhpl2PrDyiHHWQYxoyDp4VlH/GxSY/vYMJYnvF047ntdJqK1opMWEYigJtD
         sB4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=Egk8ptnkjCf/i7Q94WgOkfmqeEgzwPogxM8QtrgBZYM=;
        b=s+r2D4BhaFhnBxaUjdqXeV9YD+B0JswCoPdS/5GjaHiEXUYXo9+kUExuI/VY4uXJQm
         mXLUVfiuRBvIn5t3x0At8UbB75+kDiqbui+zvzLntbuGWtmf9oDUgKWOjkf9tcXAKq+2
         VZlVUBKBX8z17JCnAwlSanGwmig7Y5CtaESNVbe3ulPLe+OrjxRGNKUlvTgmdv2x4KvQ
         djlRhCpckwOZYfQEQ6d50b/MbU3aasgK6dM7u4sYxnmle4MKB/3ZAd3l4bZySKjSibf7
         4WNWzzhspcZ/dlROojlUB3BgZx5XObdPrD1NgXFlXd2Z3ip+80leHudA59LoWKJD0Qlm
         9R4A==
X-Gm-Message-State: AOAM532kDMgl7O49HZFls1Kpcmk5Y4fm5g7a8PGzlCPUBENRzO4Ctrjq
        w9m//NxJJ9K2ZrDn4W6gp9E=
X-Google-Smtp-Source: ABdhPJyxpQ2XobgLPAU5AsNXw2Izb5p4XceHhjwOW/DU/cuwpacrUWBLehPJKn2VZds7SqDfnii+lA==
X-Received: by 2002:a65:6a46:: with SMTP id o6mr29528822pgu.465.1643904386396;
        Thu, 03 Feb 2022 08:06:26 -0800 (PST)
Received: from localhost (2603-800c-1a02-1bae-e24f-43ff-fee6-449f.res6.spectrum.com. [2603:800c:1a02:1bae:e24f:43ff:fee6:449f])
        by smtp.gmail.com with ESMTPSA id g2sm10777082pfj.83.2022.02.03.08.06.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Feb 2022 08:06:25 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Thu, 3 Feb 2022 06:06:24 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Waiman Long <longman@redhat.com>
Cc:     Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org, Phil Auld <pauld@redhat.com>
Subject: Re: [PATCH] cgroup/cpuset: Fix "suspicious RCU usage" lockdep warning
Message-ID: <Yfv9gBps4FU7QgLz@slm.duckdns.org>
References: <20220203033103.773030-1-longman@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220203033103.773030-1-longman@redhat.com>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed, Feb 02, 2022 at 10:31:03PM -0500, Waiman Long wrote:
> It was found that a "suspicious RCU usage" lockdep warning was issued
> with the rcu_read_lock() call in update_sibling_cpumasks().  It is
> because the update_cpumasks_hier() function may sleep. So we have
> to release the RCU lock, call update_cpumasks_hier() and reacquire
> it afterward.
> 
> Also add a percpu_rwsem_assert_held() in update_sibling_cpumasks()
> instead of stating that in the comment.
> 
> Fixes: 4716909cc5c5 ("cpuset: Track cpusets that use parent's effective_cpus")
> Signed-off-by: Waiman Long <longman@redhat.com>

Applied to cgroup/for-5.17-fixes.

Thanks.

-- 
tejun
