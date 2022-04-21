Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35AFD50A218
	for <lists+cgroups@lfdr.de>; Thu, 21 Apr 2022 16:22:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1389142AbiDUOZC (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 21 Apr 2022 10:25:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1388733AbiDUOZB (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 21 Apr 2022 10:25:01 -0400
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com [IPv6:2607:f8b0:4864:20::82e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B7333CA63
        for <cgroups@vger.kernel.org>; Thu, 21 Apr 2022 07:22:11 -0700 (PDT)
Received: by mail-qt1-x82e.google.com with SMTP id bb21so3325656qtb.3
        for <cgroups@vger.kernel.org>; Thu, 21 Apr 2022 07:22:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=xZMCVPcYFV3B+SKd3NEIMAMCeRNJPyaeLFKLuEeo51c=;
        b=q3lCCATKuv+Uf5ChmHextg+VIYRg7sglu2vtz03zUPGFsDXhO7asAMZtk1H9E/JnDr
         YibqlpDokwcpSiIdJL8QeVip38kYFCQ2xBWbysfUDwU2V/NRfUkI9/PsfsKYxDZpQ1mb
         r5AXLmwCXYxLFzrCecn/0Y6Au873M0CBj+0vEC9orZ/LT+dE/GvFDYw3rgIA8Op4LCHN
         X0zzweG7A0C3beYpMXbFFw6IKQHaInfwnSTOD6NPwJN7YTK+tGVujdGsHuUJ2H+myjpT
         S6/znAKKqrEvzcWQ1qKqblw6q/aLFBRAYuB9f3t7HhAqRizq4t2KEezpyBvq6OLqFbzI
         JAfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=xZMCVPcYFV3B+SKd3NEIMAMCeRNJPyaeLFKLuEeo51c=;
        b=MnutejxFVcFVUjfhNNeTUf1ntmXErz5nXjREiZzymD2JPJXTFPjZz9SGf0DvRH+lV0
         Zo7VJCZRvRwc+lbBKWsmOv67G/H1V1Ft86CtET4iy/Y3gGrkyYX/FRv3NmfQ47woWnam
         YJvUjrUuUszUvC34pN7Om/FoPSJn6epSGOlbbh+w3690WfTtUfNi8nNzUMlBwh9s9WyV
         qSE9sTRQtqBS47FVPpCJdAqj4xnjFY3RqNBXExdlTgcSKxT0kEwVzq5y9WUMmwnp2LQZ
         bw+NaTV3T6kTaV3dAQxkzBGyYKJ6RV5sQ+TQiv2iMEbWXDnU69En58v0A/1NxnyEr/5B
         s+Ww==
X-Gm-Message-State: AOAM533SncBMuIG6G1qNbrb0DmqVnZiEueO2XHjyWJ6PnbV1c98IQ0gr
        J7eG25IdUW2EelhbS+xhJZnBmw==
X-Google-Smtp-Source: ABdhPJyZap0TOdrBgRkuajd9I7vdEoxGIlxp0WQHjmdek10/dK3YxB4ChxtlTFV7Gj5bn6hewrWGEA==
X-Received: by 2002:ac8:5905:0:b0:2f2:480:ef2e with SMTP id 5-20020ac85905000000b002f20480ef2emr11909254qty.272.1650550930673;
        Thu, 21 Apr 2022 07:22:10 -0700 (PDT)
Received: from localhost (cpe-98-15-154-102.hvc.res.rr.com. [98.15.154.102])
        by smtp.gmail.com with ESMTPSA id n11-20020a05622a11cb00b002f344f11849sm2096485qtk.71.2022.04.21.07.22.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Apr 2022 07:22:10 -0700 (PDT)
Date:   Thu, 21 Apr 2022 10:22:09 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Lu Jialin <lujialin4@huawei.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Shakeel Butt <shakeelb@google.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Matthew Wilcox <willy@infradead.org>,
        Yang Shi <shy828301@gmail.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Wang Weiyang <wangweiyang2@huawei.com>,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH -next] mm/memcontrol.c: make cgroup_memory_noswap static
Message-ID: <YmFokXAWjp35yIFS@cmpxchg.org>
References: <20220421124736.62180-1-lujialin4@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220421124736.62180-1-lujialin4@huawei.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Thu, Apr 21, 2022 at 08:47:36PM +0800, Lu Jialin wrote:
> cgroup_memory_noswap is only used in mm/memcontrol.c, therefore just make
> it static, and remove export in include/linux/memcontrol.h
> 
> Signed-off-by: Lu Jialin <lujialin4@huawei.com>

Nice. Unused since 2d1c498072de ("mm: memcontrol: make swap tracking
an integral part of memory control"), which removed the two instances
from mm/swap_cgroup.c.

Acked-by: Johannes Weiner <hannes@cmpxchg.org>
