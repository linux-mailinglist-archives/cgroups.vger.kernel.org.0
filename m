Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E36B0763FE7
	for <lists+cgroups@lfdr.de>; Wed, 26 Jul 2023 21:44:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229567AbjGZTot (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 26 Jul 2023 15:44:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229798AbjGZTos (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 26 Jul 2023 15:44:48 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 401A91727;
        Wed, 26 Jul 2023 12:44:47 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id d2e1a72fcca58-686efb9ee3cso179980b3a.3;
        Wed, 26 Jul 2023 12:44:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690400686; x=1691005486;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VIQUF5pxDq7OaH/cq+/yDjYiLBedFBP8ulSYElZmLwU=;
        b=lABXBtPFwn3FCtQv5Cb3csSuJ2Td+KIqkY5ygJK0lT+9ay/TSKzRV3T/qdi98zeoJe
         oirsG2ATytq9UM5BIwjUrJMCjNvs/M8LRIKHCmOWwOA5XgTn6g/wTI9hbwmoN5jBAyeR
         r+c0pgllRpNRDT39CCHZcjyopLj5wXSO4zaJMbVwNJGLOp1Mrm0vWbBj9kIfL+80Q3/Y
         y4VZiF1TKsaNGhoxjq1SQuk+3lm4Cf73LWjQlG1jt2Ece5jOgByA80o/KGwosJv0zjw8
         AFI2VC6F+beS2/t3y7sKqyAUHeziG+oPhfCT7qB3RLIYWwVJ4q/rAVag/eFqSaSpAe9m
         tx2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690400686; x=1691005486;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VIQUF5pxDq7OaH/cq+/yDjYiLBedFBP8ulSYElZmLwU=;
        b=b9pqys9e4NQDbssFDXGGwp1s8MZm8/E9Gin66f/pSZQjfWNaWo8GxOlE0StnruYl9t
         o8yWWQHXEHHcvEdiis6VPF5kJASaSut3k3gRiRZWIc2B2ZHoaKp4ziWyuPmkTGPepXbL
         qzah/xnebpVgWIhzcBWaKyvpsPQ4PKJSpLxEATKiUiJhCYwED5UQQas8pcPgAxlVaAA3
         2xUhgeXPf89cPBp9S31e8NSt2mucFoVMXws+fqr5+z67M/6URMrb/sEXedCq79v4plhj
         hi2KpGriB/JV9/6sXeAOLssJGjLsiy86lANhBsN8CNXrvvhS2nUycOWYKhGO2GtrxkVQ
         xJxQ==
X-Gm-Message-State: ABy/qLbv7Dvns7aWtnYO4JEGTPJIGMrX/XoI3PGKq7aSiCgqar06GHrk
        pQUOgr26ZZt5P2nUW8jQNto=
X-Google-Smtp-Source: APBJJlGILMsw8IkBKMxeBLDfBMBy4EilYpIm1syUNg1rCUlwlmh/o60QGTyq7aO0ZkORDLeDnt3Pdg==
X-Received: by 2002:a05:6a00:b54:b0:668:81c5:2f8d with SMTP id p20-20020a056a000b5400b0066881c52f8dmr4063786pfo.3.1690400686414;
        Wed, 26 Jul 2023 12:44:46 -0700 (PDT)
Received: from localhost ([2620:10d:c090:400::5:18d])
        by smtp.gmail.com with ESMTPSA id d19-20020aa78153000000b0065da94fe917sm1163pfn.36.2023.07.26.12.44.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jul 2023 12:44:45 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Wed, 26 Jul 2023 09:44:44 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Cc:     Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        Intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        Johannes Weiner <hannes@cmpxchg.org>,
        Zefan Li <lizefan.x@bytedance.com>,
        Dave Airlie <airlied@redhat.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Rob Clark <robdclark@chromium.org>,
        =?iso-8859-1?Q?St=E9phane?= Marchesin <marcheu@chromium.org>,
        "T . J . Mercier" <tjmercier@google.com>, Kenny.Ho@amd.com,
        Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        Brian Welty <brian.welty@intel.com>,
        Tvrtko Ursulin <tvrtko.ursulin@intel.com>,
        Eero Tamminen <eero.t.tamminen@intel.com>
Subject: Re: [PATCH 16/17] cgroup/drm: Expose memory stats
Message-ID: <ZMF3rLioJK9QJ0yj@slm.duckdns.org>
References: <20230712114605.519432-1-tvrtko.ursulin@linux.intel.com>
 <20230712114605.519432-17-tvrtko.ursulin@linux.intel.com>
 <ZLsFBHqCQdPHoZVw@slm.duckdns.org>
 <ea64d7bf-c01b-f4ad-a36b-f77e2c2ea931@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ea64d7bf-c01b-f4ad-a36b-f77e2c2ea931@linux.intel.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hello,

On Wed, Jul 26, 2023 at 12:14:24PM +0200, Maarten Lankhorst wrote:
> > So, yeah, if you want to add memory controls, we better think through how
> > the fd ownership migration should work.
>
> I've taken a look at the series, since I have been working on cgroup memory
> eviction.
> 
> The scheduling stuff will work for i915, since it has a purely software
> execlist scheduler, but I don't think it will work for GuC (firmware)
> scheduling or other drivers that use the generic drm scheduler.
> 
> For something like this,  you would probably want it to work inside the drm
> scheduler first. Presumably, this can be done by setting a weight on each
> runqueue, and perhaps adding a callback to update one for a running queue.
> Calculating the weights hierarchically might be fun..

I don't have any idea on this front. The basic idea of making high level
distribution decisions in core code and letting individual drivers enforce
that in a way which fits them the best makes sense to me but I don't know
enough to have an opinion here.

> I have taken a look at how the rest of cgroup controllers change ownership
> when moved to a different cgroup, and the answer was: not at all. If we

For persistent resources, that's the general rule. Whoever instantiates a
resource gets to own it until the resource gets freed. There is an exception
with the pid controller and there are discussions around whether we want
some sort of migration behavior with memcg but yes by and large instantiator
being the owner is the general model cgroup follows.

> attempt to create the scheduler controls only on the first time the fd is
> used, you could probably get rid of all the tracking.
> This can be done very easily with the drm scheduler.
>
> WRT memory, I think the consensus is to track system memory like normal
> memory. Stolen memory doesn't need to be tracked. It's kernel only memory,
> used for internal bookkeeping  only.
> 
> The only time userspace can directly manipulate stolen memory, is by mapping
> the pinned initial framebuffer to its own address space. The only allocation
> it can do is when a framebuffer is displayed, and framebuffer compression
> creates some stolen memory. Userspace is not
> aware of this though, and has no way to manipulate those contents.

So, my dumb understanding:

* Ownership of an fd can be established on the first ioctl call and doesn't
  need to be migrated afterwards. There are no persistent resources to
  migration on the first call.

* Memory then can be tracked in a similar way to memcg. Memory gets charged
  to the initial instantiator and doesn't need to be moved around
  afterwards. There may be some discrepancies around stolen memory but the
  magnitude of inaccuracy introduced that way is limited and bound and can
  be safely ignored.

Is that correct?

Thanks.

-- 
tejun
