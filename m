Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE2F57624B2
	for <lists+cgroups@lfdr.de>; Tue, 25 Jul 2023 23:44:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230042AbjGYVoR (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 25 Jul 2023 17:44:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229696AbjGYVoQ (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 25 Jul 2023 17:44:16 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5226B1FE6;
        Tue, 25 Jul 2023 14:44:15 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id d9443c01a7336-1bbc2e1c6b2so6062985ad.3;
        Tue, 25 Jul 2023 14:44:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690321455; x=1690926255;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LMF20IZtbfCz3aU/3bfXT+An6WYKlC9WFpBOERsbLtc=;
        b=cuSOP3cY00kalmUDb+byhPR92kTHul30bSE157ciDmWkuI3153sw6DFVNwFXC73ZZH
         AMb7lJ2vBq3NfzlR75VP9ViihITZUUBuwZSP+iZbcnGqMdmLWEqXA3VleLVomwy1AQ7K
         ot9lBHyDBPxyHGh8V0vMqtTuB/kS4Flz9vR00TJzFanJ7/hOzkkIhAlOcCaVYUWR/q4O
         PXmqDHD51oaTBEblzjHQjFk3hcSdEHYiNZdxxP7RxHHD4HSfdG65/jyaMhgqcPMVdOgf
         DDMqgL1wXsE0INWvlim252xKspmHeBqwoIe1+prRY5UcjPYodxV6TTiAF6/c+R5lSC29
         IUzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690321455; x=1690926255;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LMF20IZtbfCz3aU/3bfXT+An6WYKlC9WFpBOERsbLtc=;
        b=fForm67b0oLU27qRrk851xFbY90NicTru2j8/yxsFNmE/QVGhVKddxn+SAMc1NNgDJ
         l+zW5Qm1JALkNFteKVX0gnlMXZIQpm47aRyVylUE70OWdlLxihBRNS3a5jovC05rNmkh
         DE95oKpqkfhF7IwPYspeN/QFH8FlElpBP32GZX20IYp/sRrfaWaCd0IZ9aWBHMz1sv7y
         qUJGd8xJrYYU1ZoiPaGrcnjLibLS31zVfV36j21Em2n1AY0IKPhvZUk1k1XjW4VX9it2
         VgnT+nS7fltvGJ8QtamaQvKOwUQMcvOoZAJRUFCuakjwliiX9hTD/pcYi4gIQr1yiK0q
         Cbcw==
X-Gm-Message-State: ABy/qLbjMiQnbF9rhcg7B4f/T/toUGUBhEIOLDwJ2bkV2ms3a7sSpj0P
        MGXSrGrDhyvFVt1he8GRr8k=
X-Google-Smtp-Source: APBJJlGEvIWL8IjcRtZzTTX4hJPQpgL1X1ro3T1G7CJ0ISXDwtKv3zqQvmRPdYNOVSRJKkvn3KdUjA==
X-Received: by 2002:a17:902:e314:b0:1bb:c64f:9a5e with SMTP id q20-20020a170902e31400b001bbc64f9a5emr323769plc.5.1690321454499;
        Tue, 25 Jul 2023 14:44:14 -0700 (PDT)
Received: from localhost ([2620:10d:c090:400::5:18d])
        by smtp.gmail.com with ESMTPSA id l9-20020a170902d34900b001b86f1b5797sm2642688plk.302.2023.07.25.14.44.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jul 2023 14:44:14 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Tue, 25 Jul 2023 11:44:12 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>
Cc:     Intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
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
Subject: Re: [PATCH 15/17] cgroup/drm: Expose GPU utilisation
Message-ID: <ZMBCLJMLL_cl9G_e@slm.duckdns.org>
References: <20230712114605.519432-1-tvrtko.ursulin@linux.intel.com>
 <20230712114605.519432-16-tvrtko.ursulin@linux.intel.com>
 <ZLsEdJeEAPYWFunT@slm.duckdns.org>
 <ZLsEomsuxoy-YnkA@slm.duckdns.org>
 <3b96cada-3433-139c-3180-1f050f0f80f3@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3b96cada-3433-139c-3180-1f050f0f80f3@linux.intel.com>
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

On Tue, Jul 25, 2023 at 03:08:40PM +0100, Tvrtko Ursulin wrote:
> > Also, shouldn't this be keyed by the drm device?
>
> It could have that too, or it could come later. Fun with GPUs that it not
> only could be keyed by the device, but also by the type of the GPU engine.
> (Which are a) vendor specific and b) some aree fully independent, some
> partially so, and some not at all - so it could get complicated semantics
> wise really fast.)

I see.

> If for now I'd go with drm.stat/usage_usec containing the total time spent
> how would you suggest adding per device granularity? Files as documented
> are either flag or nested, not both at the same time. So something like:
> 
> usage_usec 100000
> card0 usage_usec 50000
> card1 usage_usec 50000
> 
> Would or would not fly? Have two files along the lines of drm.stat and drm.dev_stat?

Please follow one of the pre-defined formats. If you want to have card
identifier and field key, it should be a nested keyed file like io.stat.

> While on this general topic, you will notice that for memory stats I have
> _sort of_ nested keyed per device format, for example on integrated Intel
> GPU:
> 
>   $ cat drm.memory.stat
>   card0 region=system total=12898304 shared=0 active=0 resident=12111872 purgeable=167936
>   card0 region=stolen-system total=0 shared=0 active=0 resident=0 purgeable=0
> 
> If one a discrete Intel GPU two more lines would appear with memory
> regions of local and local-system. But then on some server class
> multi-tile GPUs even further regions with more than one device local
> memory region. And users do want to see this granularity for container use
> cases at least.
> 
> Anyway, this may not be compatible with the nested key format as
> documented in cgroup-v2.rst, although it does not explicitly say.
> 
> Should I cheat and create key names based on device and memory region name
> and let userspace parse it? Like:
> 
>   $ cat drm.memory.stat
>   card0.system total=12898304 shared=0 active=0 resident=12111872 purgeable=167936
>   card0.stolen-system total=0 shared=0 active=0 resident=0 purgeable=0

Yeah, this looks better to me. If they're reporting different values for the
same fields, they're separate keys.

Thanks.

-- 
tejun
