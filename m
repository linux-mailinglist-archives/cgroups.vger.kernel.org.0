Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4299E3AB2D7
	for <lists+cgroups@lfdr.de>; Thu, 17 Jun 2021 13:41:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232281AbhFQLnt (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 17 Jun 2021 07:43:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231495AbhFQLns (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 17 Jun 2021 07:43:48 -0400
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com [IPv6:2607:f8b0:4864:20::736])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD93FC06175F;
        Thu, 17 Jun 2021 04:41:38 -0700 (PDT)
Received: by mail-qk1-x736.google.com with SMTP id j62so2709611qke.10;
        Thu, 17 Jun 2021 04:41:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=308dLMmMqDbO4OFxN9kKT0tYjzQ+yKtGYVUA4Fqyf7c=;
        b=j2mlwryJ8j64/CGxPSzcDSq04YPEz/agtkQ2ZMfENonngleTcs0350yQ0AojHiAeCS
         dlhWSMdJbckGk6MJdZwRvNBjo8hWI8MQWq7zXtxHJn+nbxgG+Lo6I8MurqxJnHtpSkNY
         bqm0uXfjO9eQKyBJ11JxWTUikLWek9ua4dgKko+FxJAJX5EjbQlmEBDQ9OJ4TyUjPGau
         xE6nGBI5s2mSYnPrYbc5sui2FTJNRh9df2lbFmZUzlZW6zOQIBbCq2fyOl30HljUbjqd
         mILERgv9iLJhNUC+50SGFdCG0Y4RjmHySuNviIMBK8vBEYSGmu41aryEGBQDxVKC/laP
         jp1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=308dLMmMqDbO4OFxN9kKT0tYjzQ+yKtGYVUA4Fqyf7c=;
        b=CraEau8LMno/VkCqPsuP0r4UPhoEmPBX2qiCw0etzYkBQv+gRznh+hk3jvRPF2RlXF
         ukVzX59GwluPiUW6PiGHpIy8QnciZOzYPl3j5oiaer3QdfXl9NbSNHohFEkKECEBprqI
         TIksCM+W5COALm2unKmOMNHuzNeDwQqSP3zO9zIhrK710ztIN4WOzqRje5GrI+oDQlrY
         OWzqW+lmEJo1wrELdj09wdBolNbMWdtvH1M1/tM6hG7O8+AXHV3oO6M67HQkY5t35r+8
         kM6jj3RHvd96HUsWeLSan70JmSc99VJBH9PBZwiJsqxZ5j5Fg+g5x18j5DQcJvuwoXyu
         WxIA==
X-Gm-Message-State: AOAM533dT3U/7GJ6td5f8OcozrefcF/ah5YpRrQJvApDZLRA5JJaNVXb
        ZON1s8P2h1NQTN7apcp5IAA=
X-Google-Smtp-Source: ABdhPJyZp8YxhkmQv3fjz9vs7o70JkS/lbq5ZNZoVLZQGGyY593pvceUmYYiWUDYduN9Spby2zOxyA==
X-Received: by 2002:a05:620a:9d7:: with SMTP id y23mr3339768qky.227.1623930097823;
        Thu, 17 Jun 2021 04:41:37 -0700 (PDT)
Received: from localhost ([199.192.137.73])
        by smtp.gmail.com with ESMTPSA id i24sm1512970qkk.87.2021.06.17.04.41.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Jun 2021 04:41:37 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Thu, 17 Jun 2021 07:41:36 -0400
From:   Tejun Heo <tj@kernel.org>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     linux-kernel@vger.kernel.org, Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>, cgroups@vger.kernel.org
Subject: Re: [PATCH 1/1] cgroup-v1: Grant CAP_SYS_NICE holders permission to
 move tasks between cgroups
Message-ID: <YMs08Ij8PZ/gemLL@slm.duckdns.org>
References: <20210617090941.340135-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210617090941.340135-1-lee.jones@linaro.org>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hello,

On Thu, Jun 17, 2021 at 10:09:41AM +0100, Lee Jones wrote:
> It should be possible for processes with CAP_SYS_NICE capabilities
> (privileges) to move lower priority tasks within the same namespace to
> different cgroups.

I'm not sure that "should" is justified that easily given that cgroup can
affect things like device access permissions and basic system organization.

> One extremely common example of this is Android's 'system_server',
> which moves processes around to different cgroups/cpusets, but should
> not require any other root privileges.

Why is this being brought up now after all the years? Isn't android moving
onto cgroup2 anyway?

Thanks.

-- 
tejun
