Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51BB071024A
	for <lists+cgroups@lfdr.de>; Thu, 25 May 2023 03:21:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235107AbjEYBVH (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 24 May 2023 21:21:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbjEYBVH (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 24 May 2023 21:21:07 -0400
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com [IPv6:2607:f8b0:4864:20::f29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AA7BF5
        for <cgroups@vger.kernel.org>; Wed, 24 May 2023 18:21:05 -0700 (PDT)
Received: by mail-qv1-xf29.google.com with SMTP id 6a1803df08f44-6237faa8677so2030436d6.1
        for <cgroups@vger.kernel.org>; Wed, 24 May 2023 18:21:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20221208.gappssmtp.com; s=20221208; t=1684977665; x=1687569665;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=j98gJ4+KN81zlHrINZqrH05Pl+KjXomFxD3KB2ZcwUg=;
        b=aM2MHGY4xUTYKWMcoV1R2ROW5efcpmXigmAL+mMZ5XEnMx0rFxVwZKHGcFfPYyyt4C
         fgrmVpz11FsExkBVjSERPrjP/wh8NJ8MczWW9ITix0Db7wdihD4Ac3W9Mlx3hGIcY5TV
         eWQRaHpScNvFpMGTp8PaXSBqvklX5x18eHZyXR1L9T342LW4WcMfkmIGLFObi24tJs7s
         r0eLa8u0K8XpmMUwXl6S5cB/KijNkqetUl/um5sOvatWTu21sGkGtGRXB3jq44zaDkwf
         svBLbM/mdYZ5c5IYM34uw64uf1dbIgdjkcoAQJCLo/AQyVz0V8ojNZ34TAgKmo2ooHRX
         L9hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684977665; x=1687569665;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j98gJ4+KN81zlHrINZqrH05Pl+KjXomFxD3KB2ZcwUg=;
        b=UrgCsV1X9e+waxssZcknJO0bL10tJ7Fcfxuc4GxjQQEjXGWN9k2tCKP4JOMtK/mAfb
         OP0622ZBpWTBVjCcKnUg9JMHjE7ySMkleF0mjzinD6rV5veeDaJaq5EBEdZKR1/G5vzu
         PQDL6vqT1xUKzfI+RInJbbUYuft+OTb3tmrAvcYFAonvjBzZp2U2OGdkAIwRNJDRXZrr
         pkDkX3LOUBG/u72SCYxF6YX1UXf6l7UEDJ8m6HGgWjIA3uVpCyfVjZJo4V1itvo51rY7
         szECdNZaE9m81nDh7NTZlpi3KEJIxVGq73j3ZxYHFf1gXVid6axcYyQ7YNKW/5fg/1fe
         Ak9Q==
X-Gm-Message-State: AC+VfDyBTR/C4Yh5kmbOrX9wYsC+o+awUU3V5cHuhw0OQ/ziOmTUvWro
        0VP0UwF4idXlfCgw5fe5AQshZQ==
X-Google-Smtp-Source: ACHHUZ6e38+gKVOV7QYsLseVpmGvLBi+8/rvohpxXpAcIjVmnxVHK7W7V7pTLM2gUdYJlDIVRMbk+A==
X-Received: by 2002:a05:6214:124b:b0:623:8896:2d77 with SMTP id r11-20020a056214124b00b0062388962d77mr32062976qvv.41.1684977664722;
        Wed, 24 May 2023 18:21:04 -0700 (PDT)
Received: from localhost ([2620:10d:c091:400::5:8bb6])
        by smtp.gmail.com with ESMTPSA id q5-20020a0cfa05000000b0061b73e331b2sm26089qvn.30.2023.05.24.18.21.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 May 2023 18:21:04 -0700 (PDT)
Date:   Wed, 24 May 2023 21:21:03 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     "Lars R. Damerow" <lars@pixar.com>
Cc:     mhocko@kernel.org, roman.gushchin@linux.dev, shakeelb@google.com,
        tj@kernel.org, lizefan.x@bytedance.com, corbet@lwn.net,
        muchun.song@linux.dev, akpm@linux-foundation.org,
        cgroups@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH] mm/memcontrol: export memcg.swap watermark via sysfs for
 v2 memcg
Message-ID: <20230525012103.GA24888@cmpxchg.org>
References: <20230524181734.125696-1-lars@pixar.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230524181734.125696-1-lars@pixar.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed, May 24, 2023 at 11:17:33AM -0700, Lars R. Damerow wrote:
> This patch is similar to commit 8e20d4b33266 ("mm/memcontrol: export
> memcg->watermark via sysfs for v2 memcg"), but exports the swap counter's
> watermark.
> 
> We allocate jobs to our compute farm using heuristics determined by memory
> and swap usage from previous jobs. Tracking the peak swap usage for new
> jobs is important for determining when jobs are exceeding their expected
> bounds, or when our baseline metrics are getting outdated.
> 
> Our toolset was written to use the "memory.memsw.max_usage_in_bytes" file
> in cgroups v1, and altering it to poll cgroups v2's "memory.swap.current"
> would give less accurate results as well as add complication to the code.
> Having this watermark exposed in sysfs is much preferred.
> 
> Signed-off-by: Lars R. Damerow <lars@pixar.com>

Looks good to me.

Acked-by: Johannes Weiner <hannes@cmpxchg.org>
