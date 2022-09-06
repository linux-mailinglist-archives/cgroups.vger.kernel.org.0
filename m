Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 908315AE92F
	for <lists+cgroups@lfdr.de>; Tue,  6 Sep 2022 15:13:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240195AbiIFNNs (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 6 Sep 2022 09:13:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240375AbiIFNNp (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 6 Sep 2022 09:13:45 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9ACE76D9C8
        for <cgroups@vger.kernel.org>; Tue,  6 Sep 2022 06:13:37 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id x19so11357136pfr.1
        for <cgroups@vger.kernel.org>; Tue, 06 Sep 2022 06:13:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=z0xoCgZ6OB1X6I9K+Q5ULkuyhW887KdUWlCNKEVd8bw=;
        b=w4ajL+gQDWI7cKBhAtKnr5qiDWAGO/We8uLJbQKU9jAQnQUOLx2qHZbOX1l7S4G5vh
         FTv/eIZt6wZzqvcB84yAV4NpuX6QTsIKU7iaREKywsVq5rv3CoX7ve7fE1emDVz8Wsm1
         CpFQY3aXhwzLmE/6c5T+vB4eaQmq7GzcLBit1y2HOBkyyT2cib4/TYiGZM75X83eooWc
         3q5VLPpsM6sdGE5mNxACCk/J7RvSfk9HVtQeGEAyga1gZMPAWkgI3qVa1+hPcM5yOeJe
         ++tbjev/riu9AwiHLXMbADkvtn/E8Y1wHQZZNCuZ7tCnq1rV3W+rNPALMR5xkExUIWCa
         jDCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=z0xoCgZ6OB1X6I9K+Q5ULkuyhW887KdUWlCNKEVd8bw=;
        b=lW+DLqojgMOhqZxatF6vGr14v7W+PZCJYW6dDv2xNFp34jggTd/dVoDNaOT7WY0ef8
         YAJWpzOF6YpseNxmNKFNuInexsO6X43ybuHuCtbDTUikqvg5e0y1qM0UyMrdwF9YubSR
         0/oWo+9Qlchu84qHASkWEzI2up/sSYg/7NLuo8SOPGsd2pxZ5+C4ALOBeWxv+yT44Zj4
         di7pMcFhvE72g+4AxiK3oC3DI233SN8LeQKwxQOyCcE9819KUX7h/5/wW9qdUH1PM+62
         4syrgI9wWIqF8AVTjoTeuHalYVQHh5/Hu4QKI99ZoWpjSYGRccfhKcJYupPqJJlso4FP
         Ahkg==
X-Gm-Message-State: ACgBeo2Y/kStegLQM83/vITyt8b3yQM16SWZpdX4g/LDwZUo/fYCgeeg
        j+nMshQwXJrDXI9vjo7VgUrbUw==
X-Google-Smtp-Source: AA6agR7azsge6TFNAr9bF+JPxyoBWZJ1WthoY2HFC76CWhDoB+va44aEwoh3LRpXMQfydp0cB3+i6g==
X-Received: by 2002:a62:3347:0:b0:53d:f935:9f01 with SMTP id z68-20020a623347000000b0053df9359f01mr4811289pfz.8.1662470016946;
        Tue, 06 Sep 2022 06:13:36 -0700 (PDT)
Received: from [10.255.159.85] ([139.177.225.233])
        by smtp.gmail.com with ESMTPSA id y1-20020a17090264c100b00172b87d97cbsm1778071pli.67.2022.09.06.06.13.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Sep 2022 06:13:35 -0700 (PDT)
Message-ID: <be071d5a-ff2d-d06e-2f89-f2ca247dd19e@bytedance.com>
Date:   Tue, 6 Sep 2022 21:13:27 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.2.1
Subject: Re: [PATCH v4 00/10] sched/psi: some optimizations and extensions
To:     hannes@cmpxchg.org, tj@kernel.org
Cc:     surenb@google.com, mkoutny@suse.com, mingo@redhat.com,
        peterz@infradead.org, gregkh@linuxfoundation.org, corbet@lwn.net,
        cgroups@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, songmuchun@bytedance.com
References: <20220825164111.29534-1-zhouchengming@bytedance.com>
Content-Language: en-US
From:   Chengming Zhou <zhouchengming@bytedance.com>
In-Reply-To: <20220825164111.29534-1-zhouchengming@bytedance.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hello,

Could this series be merged into the linux-next?

Thanks.


On 2022/8/26 00:41, Chengming Zhou wrote:
> Hi all,
> 
> This patch series are some optimizations and extensions for PSI.
> 
> patch 1/10 fix periodic aggregation shut off problem introduced by earlier
> commit 4117cebf1a9f ("psi: Optimize task switch inside shared cgroups").
> 
> patch 2-4 are some misc optimizations, so put them in front of this series.
> 
> patch 5/10 optimize task switch inside shared cgroups when in_memstall status
> of prev task and next task are different.
> 
> patch 6/10 remove NR_ONCPU task accounting to save 4 bytes in the first
> cacheline to be used by the following patch 7/10, which introduce new
> PSI resource PSI_IRQ to track IRQ/SOFTIRQ pressure stall information.
> 
> patch 8-9 cache parent psi_group in struct psi_group to speed up the
> hot iteration path.
> 
> patch 10/10 introduce a per-cgroup interface "cgroup.pressure" to disable
> or re-enable PSI in the cgroup level, and we implement hiding and unhiding
> the pressure files per Tejun's suggestion[1], which depends on his work[2].
> 
> [1] https://lore.kernel.org/all/YvqjhqJQi2J8RG3X@slm.duckdns.org/
> [2] https://lore.kernel.org/all/20220820000550.367085-1-tj@kernel.org/
> 
> Performance test using mmtests/config-scheduler-perfpipe in
> /user.slice/user-0.slice/session-4.scope:
> 
>                                  next                patched       patched/only-leaf
> Min       Time        8.82 (   0.00%)        8.49 (   3.74%)        8.00 (   9.32%)
> 1st-qrtle Time        8.90 (   0.00%)        8.58 (   3.63%)        8.05 (   9.58%)
> 2nd-qrtle Time        8.94 (   0.00%)        8.61 (   3.65%)        8.09 (   9.50%)
> 3rd-qrtle Time        8.99 (   0.00%)        8.65 (   3.75%)        8.15 (   9.35%)
> Max-1     Time        8.82 (   0.00%)        8.49 (   3.74%)        8.00 (   9.32%)
> Max-5     Time        8.82 (   0.00%)        8.49 (   3.74%)        8.00 (   9.32%)
> Max-10    Time        8.84 (   0.00%)        8.55 (   3.20%)        8.04 (   9.05%)
> Max-90    Time        9.04 (   0.00%)        8.67 (   4.10%)        8.18 (   9.51%)
> Max-95    Time        9.04 (   0.00%)        8.68 (   4.03%)        8.20 (   9.26%)
> Max-99    Time        9.07 (   0.00%)        8.73 (   3.82%)        8.25 (   9.11%)
> Max       Time        9.12 (   0.00%)        8.89 (   2.54%)        8.27 (   9.29%)
> Amean     Time        8.95 (   0.00%)        8.62 *   3.67%*        8.11 *   9.43%*
> 
> Big thanks to Johannes Weiner, Tejun Heo and Michal Koutný for your
> suggestions and review!
> 
> 
> Changes in v4:
>  - Collect Acked-by tags from Johannes Weiner.
>  - Add many clear comments and changelogs per Johannes Weiner.
>  - Replace for_each_psi_group() with better open-code.
>  - Change to use better names cgroup_pressure_show() and
>    cgroup_pressure_write().
>  - Change to use better name psi_cgroup_restart() and only
>    call it on enabling.
> 
> Changes in v3:
>  - Rebase on linux-next and reorder patches to put misc optimizations
>    patches in the front of this series.
>  - Drop patch "sched/psi: don't change task psi_flags when migrate CPU/group"
>    since it caused a little performance regression and it's just
>    code refactoring, so drop it.
>  - Don't define PSI_IRQ and PSI_IRQ_FULL when !CONFIG_IRQ_TIME_ACCOUNTING,
>    in which case they are not used.
>  - Add patch 8/10 "sched/psi: consolidate cgroup_psi()" make cgroup_psi()
>    can handle all cgroups including root cgroup, make patch 9/10 simpler.
>  - Rename interface to "cgroup.pressure" and add some explanation
>    per Michal's suggestion.
>  - Hide and unhide pressure files when disable/re-enable cgroup PSI,
>    depends on Tejun's work.
> 
> Changes in v2:
>  - Add Acked-by tags from Johannes Weiner. Thanks for review!
>  - Fix periodic aggregation wakeup for common ancestors in
>    psi_task_switch().
>  - Add patch 7/10 from Johannes Weiner, which remove NR_ONCPU
>    task accounting to save 4 bytes in the first cacheline.
>  - Remove "psi_irq=" kernel cmdline parameter in last version.
>  - Add per-cgroup interface "cgroup.psi" to disable/re-enable
>    PSI stats accounting in the cgroup level.
> 
> 
> Chengming Zhou (9):
>   sched/psi: fix periodic aggregation shut off
>   sched/psi: don't create cgroup PSI files when psi_disabled
>   sched/psi: save percpu memory when !psi_cgroups_enabled
>   sched/psi: move private helpers to sched/stats.h
>   sched/psi: optimize task switch inside shared cgroups again
>   sched/psi: add PSI_IRQ to track IRQ/SOFTIRQ pressure
>   sched/psi: consolidate cgroup_psi()
>   sched/psi: cache parent psi_group to speed up groups iterate
>   sched/psi: per-cgroup PSI accounting disable/re-enable interface
> 
> Johannes Weiner (1):
>   sched/psi: remove NR_ONCPU task accounting
> 
>  Documentation/admin-guide/cgroup-v2.rst |  23 ++
>  include/linux/cgroup-defs.h             |   3 +
>  include/linux/cgroup.h                  |   5 -
>  include/linux/psi.h                     |  12 +-
>  include/linux/psi_types.h               |  29 ++-
>  kernel/cgroup/cgroup.c                  | 106 ++++++++-
>  kernel/sched/core.c                     |   1 +
>  kernel/sched/psi.c                      | 280 +++++++++++++++++-------
>  kernel/sched/stats.h                    |   6 +
>  9 files changed, 362 insertions(+), 103 deletions(-)
> 
