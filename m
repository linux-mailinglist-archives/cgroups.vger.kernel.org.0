Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D45636F89D8
	for <lists+cgroups@lfdr.de>; Fri,  5 May 2023 21:51:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232549AbjEETvH (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 5 May 2023 15:51:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233366AbjEETvG (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 5 May 2023 15:51:06 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC8EA10C;
        Fri,  5 May 2023 12:51:01 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id d2e1a72fcca58-64115e652eeso22202796b3a.0;
        Fri, 05 May 2023 12:51:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683316261; x=1685908261;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9VTfSz0yyeWdPF85h+AGQ/vGWi6fRSpfJvLR0EPjDWQ=;
        b=YzCXidzcvcJPIoxaBZ+1nS64ayb4z2Nf/LW7iWyUN9Mns5/BbiJOUSxxUH/670nETy
         MIs5soNpscb526ENU8VjKh6AdiDPRH98QzW13/BUp9S+rDbjVHfd3KCVMKP9SEX3qgfA
         K1ywoVkU2tKVOeJIyZdnfV9SFvQ+jCeepatv589ecD3xCxWZvUiuoMFaAVK0Vw+XLPIa
         VpXQlYmhF33TSjEjtEeLUKbnUMQd2SJy9bedok132XO7Har+gUApfjkynV5S5dUx+MDg
         ftBonzsxuMC4noRNfzT1bUaXe150dGe63LYuU5IwhhM4dL63Q7uC6ix1Fn5ZgosyQkuN
         bSEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683316261; x=1685908261;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9VTfSz0yyeWdPF85h+AGQ/vGWi6fRSpfJvLR0EPjDWQ=;
        b=al2oxpju6rN0W7iUbGECtMWwSddMpdePHXlB7MDRq0V/eDebH2ghOMh0jeWJqHS805
         X8rx+UjZGjBJquuGakxpa0kKcuVeEKQiLEt44Wp2NmvBOFrVvKG3D01SJGzRCV7bwH2q
         EzKIx5YLfbzgndsigsAfHInFkmdUPshUZ/NMHtLxByxSSOGXBkxJyZhv/wSI/CxMdIvy
         fdjksT719UUsFgpWkkQUDC9lUJYohhMg0vB9Wl7HcNLUHfwZ7F+xXT9uXp5J6qRyOvaX
         4fXaD2oww7pd0uKiGYD4vEKMNgCjqquKr/HqIxg1QiSY9evLxSOnuiWlTVn1b2QjpdZR
         uxNg==
X-Gm-Message-State: AC+VfDz2VJwk59n1q6djbZ8bXr0HZu3TnpoIxyRGO7VqIiV9BihNGTUY
        8MH+H0JHdAxw/sEPbtENH3kY/B2qbX4=
X-Google-Smtp-Source: ACHHUZ4bkyJhNlajHLHjulTevnzyI8SPsU3iBUFjjRbWKMZ5Oh2cdTySHlBCCO1k0lGiFMNc3urMIg==
X-Received: by 2002:a05:6a00:298e:b0:63c:b3be:9784 with SMTP id cj14-20020a056a00298e00b0063cb3be9784mr7723066pfb.3.1683316260908;
        Fri, 05 May 2023 12:51:00 -0700 (PDT)
Received: from localhost (2603-800c-1a02-1bae-a7fa-157f-969a-4cde.res6.spectrum.com. [2603:800c:1a02:1bae:a7fa:157f:969a:4cde])
        by smtp.gmail.com with ESMTPSA id c13-20020aa7880d000000b0063d2bb0d10asm1965319pfo.113.2023.05.05.12.51.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 May 2023 12:51:00 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Fri, 5 May 2023 09:50:59 -1000
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
Subject: Re: [RFC PATCH 0/4]  Add support for DRM cgroup memory accounting.
Message-ID: <ZFVeI2DKQXddKDNl@slm.duckdns.org>
References: <20230503083500.645848-1-maarten.lankhorst@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230503083500.645848-1-maarten.lankhorst@linux.intel.com>
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

On Wed, May 03, 2023 at 10:34:56AM +0200, Maarten Lankhorst wrote:
> RFC as I'm looking for comments.
> 
> For long running compute, it can be beneficial to partition the GPU memory
> between cgroups, so each cgroup can use its maximum amount of memory without
> interfering with other scheduled jobs. Done properly, this can alleviate the
> need for eviction, which might result in a job being terminated if the GPU
> doesn't support mid-thread preemption or recoverable page faults.
> 
> This is done by adding a bunch of knobs to cgroup:
> drm.capacity: Shows maximum capacity of each resource region.
> drm.max: Display or limit max amount of memory.
> drm.current: Current amount of memory in use.
> 
> TTM has not been made cgroup aware yet, so instead of evicting from
> the current cgroup to stay within the cgroup limits, it simply returns
> the error -ENOSPC to userspace.
> 
> I've used Tvrtko's cgroup controller series as a base, but it implemented
> scheduling weight, not memory accounting, so I only ended up keeping the
> base patch.
> 
> Xe is not upstream yet, so the driver specific patch will only apply on
> https://gitlab.freedesktop.org/drm/xe/kernel

Some high-level feedbacks.

* There have been multiple attempts at this but the track record is kinda
  poor. People don't seem to agree what should constitute DRM memory and how
  they should be accounted / controlled.

* I like Tvrtko's scheduling patchset because it exposes a generic interface
  which makes sense regardless of hardware details and then each driver can
  implement the configured control in whatever way they can. However, even
  for that, there doesn't seem much buy-in from other drivers.

* This proposal seems narrowly scoped trying to solve a specific problem
  which may not translate to different hardware configurations. Please let
  me know if I got that wrong, but if that's the case, I think a better and
  easier approach might be just being a part of the misc controller. That
  doesn't require much extra code and should be able to provide everything
  necessary for statically limiting specific resources.

Thanks.

-- 
tejun
