Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5165649D0B2
	for <lists+cgroups@lfdr.de>; Wed, 26 Jan 2022 18:29:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236903AbiAZR32 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 26 Jan 2022 12:29:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236899AbiAZR31 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 26 Jan 2022 12:29:27 -0500
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DE90C06161C;
        Wed, 26 Jan 2022 09:29:27 -0800 (PST)
Received: by mail-pj1-x1032.google.com with SMTP id d15-20020a17090a110f00b001b4e7d27474so335196pja.2;
        Wed, 26 Jan 2022 09:29:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=o7yVQ6gsvTTab9fYp8q+lCU+rLwohNUxOjiCLgJGdGM=;
        b=O6zfBzmd+BywBFqXzIfiy3ycqMOwjnMfDYKV8Xlu61A5NUaAdxjhLjXRk91Zxmp379
         0Zfjblp8ROfH7rGfRhEtsP/JWG6yw+G/qBGkEN722dXIW53FMFuWEu01agN9bdHb9we0
         XOfCUvJMOBV/VWzq7SmjsTPdvjJ7m8E7DPaqPCR2KdqEhdKUcN20ZgDnwHGrUrZ6+I3h
         8R/tO/SPoduJvlIslRZbhDKzQDuMNWYkbGxVq/ggvEDK6IeFnDzjVzrDuCHhUptS6yE3
         zTZNooS0kFSqw6KKe8jJQpHWqMqYs1PMrHkCKAl3tpRiDJB4Eimn0LqYUPgEWvGJZSkJ
         kK4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=o7yVQ6gsvTTab9fYp8q+lCU+rLwohNUxOjiCLgJGdGM=;
        b=l2cEOGO1p2/3I7N4HQz0BC9A0nojRP7a/1rdpe1Hx1e2CjpOr8TGNa0HLg6xByehIM
         sG15LnT3sLLOideTEXk0rx8m5JS8uTT+XXy43uzLaE6azSMH2/IedWJthyDgGlCvHvNm
         yD9dV/B07Q16NcSz4fTllrqn4KQ5f0fhQFxXV7gQpUJq9Fi8OPB33CMeXnjy4KVTVVUb
         zVKvopY+PWUj0yxLotUJgodtB9dDGs5vbKG5PQ1RFkAIicx5asFwo9Erv0c7t/Kpgs9v
         KEnHS640zBcZXmoyuJ1t7zWaMk7GEyIWapf8p/eZRFrsLlOYXiKOxkjPOetnOqzKr+QD
         /C2Q==
X-Gm-Message-State: AOAM532k/FQrp4pi9uHL10HPwqMUuUWrsqUnvggE/14umfFIAAdCklF8
        FcOpQUs4uICAqK9VNr/qJoEjouEWLRZ3mw==
X-Google-Smtp-Source: ABdhPJxyUHtO42sVayvKd1TwY8fWw8c2ZGvly5R/fAkkk2S/qM6qTyEIqTSco7v2TNmyUpldFs4JGQ==
X-Received: by 2002:a17:903:1212:: with SMTP id l18mr10132plh.45.1643218166669;
        Wed, 26 Jan 2022 09:29:26 -0800 (PST)
Received: from localhost (2603-800c-1a02-1bae-e24f-43ff-fee6-449f.res6.spectrum.com. [2603:800c:1a02:1bae:e24f:43ff:fee6:449f])
        by smtp.gmail.com with ESMTPSA id h18sm2699799pfv.216.2022.01.26.09.29.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jan 2022 09:29:26 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Wed, 26 Jan 2022 07:29:24 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Yu Kuai <yukuai3@huawei.com>
Cc:     axboe@kernel.dk, cgroups@vger.kernel.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        yi.zhang@huawei.com
Subject: Re: [PATCH -next] blk-throttle: enable io throttle for root in
 cgroup v2
Message-ID: <YfGE9L4i7DtNTo08@slm.duckdns.org>
References: <20220114093000.3323470-1-yukuai3@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220114093000.3323470-1-yukuai3@huawei.com>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Fri, Jan 14, 2022 at 05:30:00PM +0800, Yu Kuai wrote:
> RFC patch: https://lkml.org/lkml/2021/9/9/1432
> 
> There is a proformance problem in our environment:
> 
> A host can provide a remote device to difierent client. If one client is
> under high io pressure, other clients might be affected.
> 
> Limit the overall iops/bps(io.max) from the client can fix the problem,
> however, config files do not exist in root cgroup currently, which makes
> it impossible.
> 
> This patch enables io throttle for root cgroup:
>  - enable "io.max" and "io.low" in root
>  - don't skip root group in tg_iops_limit() and tg_bps_limit()
>  - don't skip root group in tg_conf_updated()
> 
> Signed-off-by: Yu Kuai <yukuai3@huawei.com>

Yeah, I'm kinda split. It's a simple change with some utility, but it's also
something which doesn't fit with the cgroup feature or interface. It's
regulating the whole system behavior. There's no reason for any of the
control "groups" to be involved here and semantically the interface would
fit a lot better under /proc, /sys or some other system-wide location. Here
are some points to consider:

* As a comparison, it'd be rather absurd to enable memory.max at system root
  in terms of interface and most likely break whole lot of mm operations.

* Resource control knobs of a cgroup belong to the parent as the parent is
  responsible for divvying up the available resources to its children. Here
  too, the knobs are making sense because there's a higher level parent
  (whether that's hypervisor or some network server).

Is your use case VMs or network attached storage?

Thanks.

-- 
tejun
