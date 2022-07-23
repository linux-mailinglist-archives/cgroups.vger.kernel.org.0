Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F023E57EF42
	for <lists+cgroups@lfdr.de>; Sat, 23 Jul 2022 15:43:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234686AbiGWNnx (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Sat, 23 Jul 2022 09:43:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234863AbiGWNnw (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Sat, 23 Jul 2022 09:43:52 -0400
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C731121E39
        for <cgroups@vger.kernel.org>; Sat, 23 Jul 2022 06:43:50 -0700 (PDT)
Received: by mail-pg1-x52d.google.com with SMTP id e132so6556227pgc.5
        for <cgroups@vger.kernel.org>; Sat, 23 Jul 2022 06:43:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=nPpL7FVl1H6PqS4nSrWEyucV5KSmiF3t3mUkvRlHKBU=;
        b=33Pvm3siw1zIA/gqHlaxpRttHKirwq32HP3voocw7GvlH7yCIugm82MXFYusTQBr68
         knM800EJZgRHqXkSz7vdMPH3+5nKTta1dlmxzWt1AqMHiPlfYhv0qE8Lmd67TKIE8cXK
         rQN5NAzCXFChsjY2ct3ErpJIaAVOoyjfoH/sp22cfnNJAudeIYuaprca7rtdbQIfPEMM
         o2S1DnSjoLj7gxj3OOKF3zmA0043M82rpl8M+OCxC19U9RBfGtjyWE369bahfWSt2Txg
         K+a38XrTyNcnAJgQhy0yydkXBJRwQHzyyX8LwMGfX8ANV+E9J63tSjuXbvJocqeDTSnn
         6aYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=nPpL7FVl1H6PqS4nSrWEyucV5KSmiF3t3mUkvRlHKBU=;
        b=oInuviSo9GEXA3aLEOX1Pqp2N/T4Bo0BtNe2NHyH4BJs0ZoJ5bgVB8RSkqp00JIti+
         ufBaIzH3ytQfJHuqz/66vePRtELnuUxRiUuUV58Ksmkq/cernWfAUzxIcBG2uhVvUpgN
         ogBRDxoBSdfG4hGwm20g2lQv25uhj8D+bgFfg/F+tksJcgQzSOXRQFXkMZDKSJEcVs3v
         MvO80A2Hw7SUY3K409nNHQI/7+rRiFOug1jb9H+tHydalC0U/3K08B8e8wrXPWkmcD3M
         bxUoqqj/QTX4DskbQnt176BvovmvGuj5ERjfUZfrC+Rzk2bY5POAIT6IaI1sOCR5gHVA
         xuMA==
X-Gm-Message-State: AJIora/VUEB0FEeLJpLk0l4Q2XJZMopqIZOMxHK0FcEEc/RDGZjNa0ri
        rFmec8Z2LFdzWaXxSj/mA5t+BA==
X-Google-Smtp-Source: AGRyM1t+byhgVDc1TwUk8OX/9xUITk45nLbmuKiSJ1MhpGu0O/05x8iTrTMZreaVyvjjKObbuO3KvA==
X-Received: by 2002:a63:31d3:0:b0:412:a9d9:d407 with SMTP id x202-20020a6331d3000000b00412a9d9d407mr3953747pgx.479.1658583830231;
        Sat, 23 Jul 2022 06:43:50 -0700 (PDT)
Received: from localhost ([139.177.225.241])
        by smtp.gmail.com with ESMTPSA id n13-20020a170902e54d00b0016c38eb1f3asm5895681plf.214.2022.07.23.06.43.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Jul 2022 06:43:49 -0700 (PDT)
Date:   Sat, 23 Jul 2022 21:43:45 +0800
From:   Muchun Song <songmuchun@bytedance.com>
To:     Jiebin Sun <jiebin.sun@intel.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        cgroups@vger.kernel.org, hannes@cmpxchg.org, mhocko@kernel.org,
        roman.gushchin@linux.dev, shakeelb@google.com,
        akpm@linux-foundation.org, tim.c.chen@intel.com,
        ying.huang@intel.com, amadeuszx.slawinski@linux.intel.com,
        tianyou.li@intel.com, wangyang.guo@intel.com
Subject: Re: [PATCH] mm: Remove the redundant updating of
 stats_flush_threshold
Message-ID: <Ytv7EX1FzNg1uz1t@FVFYT0MHHV2J.usts.net>
References: <20220722164949.47760-1-jiebin.sun@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220722164949.47760-1-jiebin.sun@intel.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Sat, Jul 23, 2022 at 12:49:49AM +0800, Jiebin Sun wrote:
> From: jiebin sun <jiebin.sun@intel.com>
> 
> Remove the redundant updating of stats_flush_threshold. If the
> global var stats_flush_threshold has exceeded the trigger value
> for __mem_cgroup_flush_stats, further increment is unnecessary.
> 
> Apply the patch and test the pts/hackbench-1.0.0 Count:4 (160 threads).
> 
> Score gain: 1.95x
> Reduce CPU cycles in __mod_memcg_lruvec_state (44.88% -> 0.12%)
> 
> CPU: ICX 8380 x 2 sockets
> Core number: 40 x 2 physical cores
> Benchmark: pts/hackbench-1.0.0 Count:4 (160 threads)
> 
> Signed-off-by: Jiebin Sun <jiebin.sun@intel.com>

Acked-by: Muchun Song <songmuchun@bytedance.com>

Thanks.
