Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69EFF6FE42E
	for <lists+cgroups@lfdr.de>; Wed, 10 May 2023 20:46:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229610AbjEJSqH (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 10 May 2023 14:46:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjEJSqG (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 10 May 2023 14:46:06 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17ED5E4A;
        Wed, 10 May 2023 11:46:03 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id d2e1a72fcca58-643990c5319so5423419b3a.2;
        Wed, 10 May 2023 11:46:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683744362; x=1686336362;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5fuvzbzfAPaWz0F0qnb+ng0M3t+DRDPEy+SEvx5Zlpw=;
        b=WaX/lA3Y5RC6vqi8Gstz4xLqZDGmFXeG7a3rgiWsDu5hUwAToAZzkqoYMo1FT7KjnA
         ARUu3pTtOMc7WAoU2YOH9cnEDLX7dlPp5Fk+vl639nloA3cqkDUb96asyf9ZQw15ihXz
         nIf9q2YeVZUyrcSMtyeAkgoRbV+oLyls91sRKUg2xusZZZ3Ihxuq/x0/E/g2898K6qQY
         NY2fYU0eav3eoftoQ/+ak267O1ldNVnrMhtexIpFA1GoP5llXOIGlF9JxtpQi2ToH3Sb
         zXx6m0I8PgYy7bI06tjMymfporVo62Z/NoPWgDzh1wszI52lSrupgJLtKhGceUulCGBv
         Mj0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683744362; x=1686336362;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5fuvzbzfAPaWz0F0qnb+ng0M3t+DRDPEy+SEvx5Zlpw=;
        b=UoLxfsrl7keY7Y8M8rv+RYcFU/QWgIEu5qr1gpAmnry9n/50dC3JYz3fDbuOzEpJzX
         kvE6UfiHHXphUXOrzIVR8pRHMyJmQi2CD+kX6ljgch8dlid51FpZDqtbxzISlbEBziFU
         Ce3aBmjeEgpsa3UgiQePQ5y4rdZp3NBHBpcRuOMYLaVY/B6XBZFpIwdm+nH5p+h7vqnK
         sXsMmxF4dKKQE3UnSiJ5jlJACFmCR8S1U6qbDQbn+rR16+fbxuEs0DmwB2q08usxrNGA
         ht0Eawm4M6PIsd+MUH//u0SPFhYgSlekhGsQ9paq24q27vkHkYZHUdkHoH2arRyzwfTH
         Ozgg==
X-Gm-Message-State: AC+VfDyKfgwFW7pZj/9B+z4thFGtsaKbCSWezHnyQlGNGEiblfHuIGiR
        W0RzrOiTDgXKEd46Dss1VWY=
X-Google-Smtp-Source: ACHHUZ5d5WqcqsbpOW8d9gvlIIZZNzXUY94wx3QLBecJ3Q5deydid7nrQYlsF19asRDnaQT3WKzIjA==
X-Received: by 2002:a17:902:ce86:b0:1ad:c1c2:7d14 with SMTP id f6-20020a170902ce8600b001adc1c27d14mr224531plg.46.1683744362257;
        Wed, 10 May 2023 11:46:02 -0700 (PDT)
Received: from localhost (2603-800c-1a02-1bae-a7fa-157f-969a-4cde.res6.spectrum.com. [2603:800c:1a02:1bae:a7fa:157f:969a:4cde])
        by smtp.gmail.com with ESMTPSA id i3-20020a17090332c300b001ac4d3d3f72sm4130469plr.296.2023.05.10.11.46.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 May 2023 11:46:01 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Wed, 10 May 2023 08:46:00 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Cc:     dri-devel@lists.freedesktop.org, cgroups@vger.kernel.org,
        intel-xe@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>, amd-gfx@lists.freedesktop.org,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Tvrtko Ursulin <tvrtko.ursulin@intel.com>
Subject: Re: [RFC PATCH 0/4] Add support for DRM cgroup memory accounting.
Message-ID: <ZFvmaGNo0buQEUi1@slm.duckdns.org>
References: <20230503083500.645848-1-maarten.lankhorst@linux.intel.com>
 <ZFVeI2DKQXddKDNl@slm.duckdns.org>
 <4d6fbce3-a676-f648-7a09-6f6dcc4bdb46@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4d6fbce3-a676-f648-7a09-6f6dcc4bdb46@linux.intel.com>
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

On Wed, May 10, 2023 at 04:59:01PM +0200, Maarten Lankhorst wrote:
> The misc controller is not granular enough. A single computer may have any number of
> graphics cards, some of them with multiple regions of vram inside a single card.

Extending the misc controller to support dynamic keys shouldn't be that
difficult.

...
> In the next version, I will move all the code for handling the resource limit to
> TTM's eviction layer, because otherwise it cannot handle the resource limit correctly.
> 
> The effect of moving the code to TTM, is that it will make the code even more generic
> for drivers that have vram and use TTM. When using TTM, you only have to describe your
> VRAM, update some fields in the TTM manager and (un)register your device with the
> cgroup handler on (un)load. It's quite trivial to add vram accounting to amdgpu and
> nouveau. [2]
> 
> If you want to add a knob for scheduling weight for a process, it makes sense to
> also add resource usage as a knob, otherwise the effect of that knob is very
> limited. So even for Tvrtko's original proposed usecase, it would make sense.

It does make sense but unlike Tvrtko's scheduling weights what's being
proposed doesn't seem to encapsulate GPU memory resource in a generic enough
manner at least to my untrained eyes. ie. w/ drm.weight, I don't need any
specific knoweldge of how a specific GPU operates to say "this guy should
get 2x processing power over that guy". This more or less holds for other
major resources including CPU, memory and IO. What you're proposing seems a
lot more tied to hardware details and users would have to know a lot more
about how memory is configured on that particular GPU.

Now, if this is inherent to how all, or at least most, GPUs operate, sure,
but otherwise let's start small in terms of interface and not take up space
which should be for something universal. If this turns out to be the way,
expanding to take up the generic interface space isn't difficult.

I don't know GPU space so please educate me where I'm wrong.

Thanks.

-- 
tejun
