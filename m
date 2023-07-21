Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44DA075D761
	for <lists+cgroups@lfdr.de>; Sat, 22 Jul 2023 00:22:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229699AbjGUWWB (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 21 Jul 2023 18:22:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230108AbjGUWV7 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 21 Jul 2023 18:21:59 -0400
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 443FA26BF;
        Fri, 21 Jul 2023 15:21:59 -0700 (PDT)
Received: by mail-pg1-x530.google.com with SMTP id 41be03b00d2f7-5440e98616cso2442139a12.0;
        Fri, 21 Jul 2023 15:21:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689978119; x=1690582919;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=91mL5jfG2O2HHjlTT7P8VaJYQOxhCgdT7EC1VTa5Mlk=;
        b=HoTrEYR2GIsVg0GudEbf1N4STKpjkBfxcIxV8y4tckabtqJiXjkWnRyTMvEvodEDKy
         03wenOijhJ+tz7aJDaz6ktZq2S+2ea84w8eFBiNgmFbHdK3MdKsab/DgPlyqg57SV9mL
         IGK9P1QQ1OSJTXDk3wrx0YWu81fBhzrZK7dvLtbfMBKSOnWl3qh8LtIB4j6mN6+41KcR
         CPzHBXacWVpcD7202RYxOO6l77KD3p35XYRFkjBMvI62PoRHwECevgNiUY75d76DmXUK
         HnA6FyFKxSgAi4SNMPpnrnVccOXAIhNLC7OXA0S1Z7aFf6+LPA9HGgSVVY9xeboyvKdz
         tSWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689978119; x=1690582919;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=91mL5jfG2O2HHjlTT7P8VaJYQOxhCgdT7EC1VTa5Mlk=;
        b=IaLEwClRITeT7EB9VCriDnbC7WzSFkNZHW/dW5KywPj3LwvdDiEnnby23wmtrKWIuU
         4lCeW096B/5BzfPKjxZ5J97enyPqclj4tRtRAqouMMjDH5U2xKYGiziIkOYoW3DrJ7G5
         ghVa+cjl2cQNEY2T7/ZdwND5g0Di+qG7d9e06R1QXAFlRtXBELGe/FwRDXqMtNaqaq2P
         OVUSqyVHbS7dyeBVgX1wTyQG+WburahWwG3vY51WyS/G4BB0cSGlThUrjKwXO/hgzg/g
         9uGkimHOJw3QEcs+ZijR/Iv+67GXS8ht2MaNYa2OH0P1qTqlkGGq+NmPycknqs8xQvwB
         42yw==
X-Gm-Message-State: ABy/qLYl1ftT4m+P5z7xbdpCa6QfIdNlQENyB3Gtm/ffD89st9WFZHAa
        sNR39SxEGDOgfGoVIsjQSIs=
X-Google-Smtp-Source: APBJJlHKMa7ltMEibHTz8p6SimlBXW/dfy5JPiBMaVtarDRYEJmmQv5gvJ8rHnOz8BqcCK2OH/SWEg==
X-Received: by 2002:a17:90a:4a0f:b0:263:f521:da3e with SMTP id e15-20020a17090a4a0f00b00263f521da3emr4581496pjh.2.1689978118480;
        Fri, 21 Jul 2023 15:21:58 -0700 (PDT)
Received: from localhost ([2620:10d:c090:400::5:fbd8])
        by smtp.gmail.com with ESMTPSA id u3-20020a17090aae8300b00265a7145fe5sm4626319pjq.41.2023.07.21.15.21.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jul 2023 15:21:58 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Fri, 21 Jul 2023 12:21:56 -1000
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
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Eero Tamminen <eero.t.tamminen@intel.com>
Subject: Re: [PATCH 16/17] cgroup/drm: Expose memory stats
Message-ID: <ZLsFBHqCQdPHoZVw@slm.duckdns.org>
References: <20230712114605.519432-1-tvrtko.ursulin@linux.intel.com>
 <20230712114605.519432-17-tvrtko.ursulin@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230712114605.519432-17-tvrtko.ursulin@linux.intel.com>
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

On Wed, Jul 12, 2023 at 12:46:04PM +0100, Tvrtko Ursulin wrote:
>   $ cat drm.memory.stat
>   card0 region=system total=12898304 shared=0 active=0 resident=12111872 purgeable=167936
>   card0 region=stolen-system total=0 shared=0 active=0 resident=0 purgeable=0
> 
> Data is generated on demand for simplicty of implementation ie. no running
> totals are kept or accounted during migrations and such. Various
> optimisations such as cheaper collection of data are possible but
> deliberately left out for now.
> 
> Overall, the feature is deemed to be useful to container orchestration
> software (and manual management).
> 
> Limits, either soft or hard, are not envisaged to be implemented on top of
> this approach due on demand nature of collecting the stats.

So, yeah, if you want to add memory controls, we better think through how
the fd ownership migration should work.

Thanks.

-- 
tejun
