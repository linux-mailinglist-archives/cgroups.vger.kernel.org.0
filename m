Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 37D8A433DF7
	for <lists+cgroups@lfdr.de>; Tue, 19 Oct 2021 20:02:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234643AbhJSSEX (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 19 Oct 2021 14:04:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230158AbhJSSEX (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 19 Oct 2021 14:04:23 -0400
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 476A8C06161C;
        Tue, 19 Oct 2021 11:02:10 -0700 (PDT)
Received: by mail-pg1-x536.google.com with SMTP id 75so20113121pga.3;
        Tue, 19 Oct 2021 11:02:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=3sZM03eQhB2KzVvExB+/wmjn4hXG0h6WujSIe5Eehcg=;
        b=pdVCsGnAm94532oZGMO3Ez89POaEjaCzYWHB2T/AXlJ5kW/oyCcWkHgf25+XwKca1J
         a47acU8a9sfAUgqWXUcaYq6slfGMUYBcESJfuGUEzt59CGaW4CqsPe3VS7FX0eWlaWhY
         Tue14lvZ5Y9McXLISdKd/pFYeNK4mCBpxO68v+BXR5kIHZC8lSzQPxTglTLjji3OEUfF
         jd0nuqkcjHEy1T0nrO1S31iGZ4id5Zj4PP0mtLuD+ZExXNnS9W+N2mxFdx98uKgkUsiL
         YMyY88VFK/hzjbyEi+Mt/sTW45vXwseARbgOmeCXLABsSN/a1/jfF8CMViONAjZbJAnL
         f5HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=3sZM03eQhB2KzVvExB+/wmjn4hXG0h6WujSIe5Eehcg=;
        b=lqSd7W/KJH3Nynl266yOuLbrlSuGpBSw5xYu1yGOBjTNKc9MXqgxkKWalkQT4xmbB7
         Ijxhp+V60g2d5Aeb62ci62KFXhY2tgvdBbGbNFgch97cSoI9MqSyYKfMjlYV3I8mSApq
         f4u7i3gwSHvOpINoSQaTS0xliXgiIoi+CTOKft7SADfzTFK5KQCzuKiTboPqju5MHlNR
         L6SNlkJ6bQAPyelsUI69BEj+dHjnAcser5w4Na5rIP1LntM4rNgeDH5NzUq0SXFYHz5A
         n3NwwD7QXH5ZAROqMk+2cKzFTcxiyBT5izgzux4dmIuCvddOMJvH/c5PlYW0R7d2ento
         jzpA==
X-Gm-Message-State: AOAM531+3M4GsiusxpDwBT5fUxFOz8SASOymb2zVfziJCGMmB5WhOwDp
        sOFd3NKCUK1zoBK5U2A8p9o=
X-Google-Smtp-Source: ABdhPJyCPBmixUfzOynGK/HWr1nOgd+4zNCnD1vU7BIwevA7IuOBArVJlJPt3veA3X+p62Qo4MJwdQ==
X-Received: by 2002:a62:e510:0:b0:44c:e06e:80dd with SMTP id n16-20020a62e510000000b0044ce06e80ddmr1364636pff.48.1634666529582;
        Tue, 19 Oct 2021 11:02:09 -0700 (PDT)
Received: from localhost (2603-800c-1a02-1bae-e24f-43ff-fee6-449f.res6.spectrum.com. [2603:800c:1a02:1bae:e24f:43ff:fee6:449f])
        by smtp.gmail.com with ESMTPSA id z12sm3237715pjh.51.2021.10.19.11.02.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Oct 2021 11:02:08 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Tue, 19 Oct 2021 08:02:07 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Zheng Liang <zhengliang6@huawei.com>
Cc:     axboe@kernel.dk, paolo.valente@linaro.org, cgroups@vger.kernel.org,
        linux-block@vger.kernel.org, yi.zhang@huawei.com
Subject: Re: [PATCH v2] block, bfq: fix UAF problem in bfqg_stats_init()
Message-ID: <YW8IH83UVyWrivVS@slm.duckdns.org>
References: <20211018024225.1493938-1-zhengliang6@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211018024225.1493938-1-zhengliang6@huawei.com>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Mon, Oct 18, 2021 at 10:42:25AM +0800, Zheng Liang wrote:
> In bfq_pd_alloc(), the function bfqg_stats_init() init bfqg. If
> blkg_rwstat_init() init bfqg_stats->bytes successful and init
> bfqg_stats->ios failed, bfqg_stats_init() return failed, bfqg will
> be freed. But blkg_rwstat->cpu_cnt is not deleted from the list of
> percpu_counters. If we traverse the list of percpu_counters, It will
> have UAF problem.
> 
> we should use blkg_rwstat_exit() to cleanup bfqg_stats bytes in the
> above scenario.
> 
> Fixes: commit fd41e60331b ("bfq-iosched: stop using blkg->stat_bytes and ->stat_ios")
> Signed-off-by: Zheng Liang <zhengliang6@huawei.com>

Acked-by: Tejun Heo <tj@kernel.org>

Thanks.

-- 
tejun
