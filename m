Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0791175D75B
	for <lists+cgroups@lfdr.de>; Sat, 22 Jul 2023 00:20:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230034AbjGUWUW (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 21 Jul 2023 18:20:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229699AbjGUWUV (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 21 Jul 2023 18:20:21 -0400
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com [IPv6:2607:f8b0:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5E2326BF;
        Fri, 21 Jul 2023 15:20:20 -0700 (PDT)
Received: by mail-oi1-x22e.google.com with SMTP id 5614622812f47-3a3efebcc24so1687520b6e.1;
        Fri, 21 Jul 2023 15:20:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689978020; x=1690582820;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=l6xRYi4aCBF7mvF9Wq1OcAPDild54ArRewQg4E7JKv4=;
        b=KkHPlyzjqy+65JjxuJgW31Z63b8E8dgBPO23fclVK63J02CdQ4bxPgkvvAcvKpvVB8
         KLce+Y4ZAIlKYS25+ziMYw/Ue1uBPq8EvSWA7k4Zot0rP9lRUYXzVhQLw8oH9wPhebx8
         NDFJS1ksZygEE55Cy7PS8rPXlxFm8JFiH6/TRQoEg+hvZzcGB/KgAwgGaynsy1r+ZgBH
         jwlXF+OvqxKXIamZwRS/075w9H0D/NVYXwuSCjD5K8KsvkhjJBDJSTHZEACzM1+Kfw+n
         WrDXkZg+aWxz2TFpOjN4Jhi7B4IQ3R8WYEVmN/7/EbmWj6bSLy9fgmRv/x1Ll42WXGhL
         EZ8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689978020; x=1690582820;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=l6xRYi4aCBF7mvF9Wq1OcAPDild54ArRewQg4E7JKv4=;
        b=BYKNp4IdRobTLxVcMT7L7cnfoD/5yFXas+2M8rDQqaLL3Cun0uL9kHquXAtqjSpVyf
         MTpu16wP04zQZnChytNqTMnQ/nCJa1OH5+kAK42gjhYBEJL88GZZebwEZPfGpUqsWUlJ
         8xpktpjTD3h7iMyXLokCk8kaMjS8py1VXXEzs19OPp67URFv0R8yxQQOl7AseZyNsE7m
         b57GezNOofdQRa80kkRYHg94anaR1nVPp4j4/FmFsCbHhuvbc5QDFKc/9z+NVnsSpSAh
         TQ5ZNGnCtru9zg+2uNSYEqtAQqFGc8A7lu/GEyN/QxHkaCuzkP0MARbpWUJ4V4KwQe5c
         7vBw==
X-Gm-Message-State: ABy/qLZlNtGzZJ0zT63GEdUKLf3BUv0Cn3FFRNme9DnS+MJrAItWNG3D
        qWyi39Y3JIL7gLsPMlIJHJ4=
X-Google-Smtp-Source: APBJJlHG/FUT0SIeokqX+Gveor3YszwCmqC1hRKDFYWP3alGEuI2TPEvl8+5TiGfMTURGVBjk9E0Fw==
X-Received: by 2002:a05:6808:200d:b0:3a4:8590:90f2 with SMTP id q13-20020a056808200d00b003a4859090f2mr4502985oiw.47.1689978019839;
        Fri, 21 Jul 2023 15:20:19 -0700 (PDT)
Received: from localhost ([2620:10d:c090:400::5:fbd8])
        by smtp.gmail.com with ESMTPSA id z2-20020a17090a6d0200b002676e961260sm5041674pjj.0.2023.07.21.15.20.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jul 2023 15:20:19 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Fri, 21 Jul 2023 12:20:18 -1000
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
Message-ID: <ZLsEomsuxoy-YnkA@slm.duckdns.org>
References: <20230712114605.519432-1-tvrtko.ursulin@linux.intel.com>
 <20230712114605.519432-16-tvrtko.ursulin@linux.intel.com>
 <ZLsEdJeEAPYWFunT@slm.duckdns.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZLsEdJeEAPYWFunT@slm.duckdns.org>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Fri, Jul 21, 2023 at 12:19:32PM -1000, Tejun Heo wrote:
> On Wed, Jul 12, 2023 at 12:46:03PM +0100, Tvrtko Ursulin wrote:
> > +  drm.active_us
> > +	GPU time used by the group recursively including all child groups.
> 
> Maybe instead add drm.stat and have "usage_usec" inside? That'd be more
> consistent with cpu side.

Also, shouldn't this be keyed by the drm device?

-- 
tejun
