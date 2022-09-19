Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8D0C5BD683
	for <lists+cgroups@lfdr.de>; Mon, 19 Sep 2022 23:37:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229622AbiISVhn (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 19 Sep 2022 17:37:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229574AbiISVhR (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 19 Sep 2022 17:37:17 -0400
Received: from mail-pf1-x449.google.com (mail-pf1-x449.google.com [IPv6:2607:f8b0:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E65664A122
        for <cgroups@vger.kernel.org>; Mon, 19 Sep 2022 14:37:03 -0700 (PDT)
Received: by mail-pf1-x449.google.com with SMTP id q22-20020a62e116000000b005428fb66124so414161pfh.16
        for <cgroups@vger.kernel.org>; Mon, 19 Sep 2022 14:37:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date;
        bh=b8T/nfISwHjU5GhrDDw7h8TuPVenEykyrkI2CqK0PNA=;
        b=TA8fMr6nzbnQJbU1cKRxwhWFVkClJkNpo48/2PDtCj44AVsvQSr24Wu1dlgHh07ek1
         QlD08L/ToZ77/qmrWD7u2q7ZTr0TuF9KIExWGwuX+ri/K4njShYi8Sg7xEu00+M7PrFx
         kQtWTx4jpB6+c6ofFS5fn+nIYv00E3hWw9IzvhDPQgpSYyUpvi/46nnRUay+8G0zG8N1
         xiPSu3pbdS73FOi88PfhI0CtNDiqGYa5EZJkYIhs6gRIIX4pZ6MjyUYBsjZhMT/x0onR
         IEdm2VFCGborFFmGTkBWAosAwx2JVxUvHubkvWlUBEdn9wNRvDa3HrBCUNTClNXG+N+S
         wKAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date;
        bh=b8T/nfISwHjU5GhrDDw7h8TuPVenEykyrkI2CqK0PNA=;
        b=B5eoW/jTG0ju8DSK5JVboGM4lzREvRoFMRyUvgh8jBuoP+U961aL7Epu6w1C62HHes
         OmMwSg1gzwCRoS94Pm/+p88+MBUEiWJr+nUnQOXQACZIbKBlsiSQ4BfuJON8e/Mk49Vg
         7UkamC4ftUQICeQbsYT1O9JLo3Vdpe/mOfMwduUv3PNX5UmUvEVj5vsxBe83l8JGnG9k
         sMbLg+iPLITwUNGbWlKDAse6PId9QLJ30jkqK/tQQS2IwY1+O979Jq1MKkii5ZgiILj8
         asVueeiTXohHF0oqethZwhXB+ipAL89Y4Mysn6BYnUhfWibTwDrS2eLnv0aIzE2S7imI
         jPmw==
X-Gm-Message-State: ACrzQf2IO55lfc1vZQSAm2ckEJwQB7tG2Z9v+8h7ZZVaJDOI1D/LK5Rl
        GbgyWLNtJLFkiSScKXgAXR32jarfNqvwCw==
X-Google-Smtp-Source: AMsMyM4ALR/Mn6NEMrGg+aT9UJ+ROXv9Cuve5n5D3gimP7C3BdTIuA473rtvqYxdhMKtwbsjT80Ljz5HJZeJEA==
X-Received: from shakeelb.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:262e])
 (user=shakeelb job=sendgmr) by 2002:aa7:9247:0:b0:544:6566:8ba0 with SMTP id
 7-20020aa79247000000b0054465668ba0mr20806650pfp.11.1663623422992; Mon, 19 Sep
 2022 14:37:02 -0700 (PDT)
Date:   Mon, 19 Sep 2022 21:37:01 +0000
In-Reply-To: <20220919180634.45958-3-ryncsn@gmail.com>
Mime-Version: 1.0
References: <20220919180634.45958-1-ryncsn@gmail.com> <20220919180634.45958-3-ryncsn@gmail.com>
Message-ID: <20220919213701.fwx4tfgpit6lcpn2@google.com>
Subject: Re: [PATCH v2 2/2] mm: memcontrol: make cgroup_memory_noswap a static key
From:   Shakeel Butt <shakeelb@google.com>
To:     Kairui Song <kasong@tencent.com>
Cc:     cgroups@vger.kernel.org, linux-mm@kvack.org,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Muchun Song <songmuchun@bytedance.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Michal Hocko <mhocko@suse.com>
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue, Sep 20, 2022 at 02:06:34AM +0800, Kairui Song wrote:
> From: Kairui Song <kasong@tencent.com>
> 
> cgroup_memory_noswap is used in many hot path, so make it a static key
> to lower the kernel overhead.
> 
> Using 8G of ZRAM as SWAP, benchmark using `perf stat -d -d -d --repeat 100`
> with the following code snip in a non-root cgroup:
> 
>    #include <stdio.h>
>    #include <string.h>
>    #include <linux/mman.h>
>    #include <sys/mman.h>
>    #define MB 1024UL * 1024UL
>    int main(int argc, char **argv){
>       void *p = mmap(NULL, 8000 * MB, PROT_READ | PROT_WRITE,
>                      MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
>       memset(p, 0xff, 8000 * MB);
>       madvise(p, 8000 * MB, MADV_PAGEOUT);
>       memset(p, 0xff, 8000 * MB);
>       return 0;
>    }
> 
> Before:
>           7,021.43 msec task-clock                #    0.967 CPUs utilized            ( +-  0.03% )
>              4,010      context-switches          #  573.853 /sec                     ( +-  0.01% )
>                  0      cpu-migrations            #    0.000 /sec
>          2,052,057      page-faults               #  293.661 K/sec                    ( +-  0.00% )
>     12,616,546,027      cycles                    #    1.805 GHz                      ( +-  0.06% )  (39.92%)
>        156,823,666      stalled-cycles-frontend   #    1.25% frontend cycles idle     ( +-  0.10% )  (40.25%)
>        310,130,812      stalled-cycles-backend    #    2.47% backend cycles idle      ( +-  4.39% )  (40.73%)
>     18,692,516,591      instructions              #    1.49  insn per cycle
>                                                   #    0.01  stalled cycles per insn  ( +-  0.04% )  (40.75%)
>      4,907,447,976      branches                  #  702.283 M/sec                    ( +-  0.05% )  (40.30%)
>         13,002,578      branch-misses             #    0.26% of all branches          ( +-  0.08% )  (40.48%)
>      7,069,786,296      L1-dcache-loads           #    1.012 G/sec                    ( +-  0.03% )  (40.32%)
>        649,385,847      L1-dcache-load-misses     #    9.13% of all L1-dcache accesses  ( +-  0.07% )  (40.10%)
>      1,485,448,688      L1-icache-loads           #  212.576 M/sec                    ( +-  0.15% )  (39.49%)
>         31,628,457      L1-icache-load-misses     #    2.13% of all L1-icache accesses  ( +-  0.40% )  (39.57%)
>          6,667,311      dTLB-loads                #  954.129 K/sec                    ( +-  0.21% )  (39.50%)
>          5,668,555      dTLB-load-misses          #   86.40% of all dTLB cache accesses  ( +-  0.12% )  (39.03%)
>                765      iTLB-loads                #  109.476 /sec                     ( +- 21.81% )  (39.44%)
>          4,370,351      iTLB-load-misses          # 214320.09% of all iTLB cache accesses  ( +-  1.44% )  (39.86%)
>        149,207,254      L1-dcache-prefetches      #   21.352 M/sec                    ( +-  0.13% )  (40.27%)
> 
>            7.25869 +- 0.00203 seconds time elapsed  ( +-  0.03% )
> 
> After:
>           6,576.16 msec task-clock                #    0.953 CPUs utilized            ( +-  0.10% )
>              4,020      context-switches          #  605.595 /sec                     ( +-  0.01% )
>                  0      cpu-migrations            #    0.000 /sec
>          2,052,056      page-faults               #  309.133 K/sec                    ( +-  0.00% )
>     11,967,619,180      cycles                    #    1.803 GHz                      ( +-  0.36% )  (38.76%)
>        161,259,240      stalled-cycles-frontend   #    1.38% frontend cycles idle     ( +-  0.27% )  (36.58%)
>        253,605,302      stalled-cycles-backend    #    2.16% backend cycles idle      ( +-  4.45% )  (34.78%)
>     19,328,171,892      instructions              #    1.65  insn per cycle
>                                                   #    0.01  stalled cycles per insn  ( +-  0.10% )  (31.46%)
>      5,213,967,902      branches                  #  785.461 M/sec                    ( +-  0.18% )  (30.68%)
>         12,385,170      branch-misses             #    0.24% of all branches          ( +-  0.26% )  (34.13%)
>      7,271,687,822      L1-dcache-loads           #    1.095 G/sec                    ( +-  0.12% )  (35.29%)
>        649,873,045      L1-dcache-load-misses     #    8.93% of all L1-dcache accesses  ( +-  0.11% )  (41.41%)
>      1,950,037,608      L1-icache-loads           #  293.764 M/sec                    ( +-  0.33% )  (43.11%)
>         31,365,566      L1-icache-load-misses     #    1.62% of all L1-icache accesses  ( +-  0.39% )  (45.89%)
>          6,767,809      dTLB-loads                #    1.020 M/sec                    ( +-  0.47% )  (48.42%)
>          6,339,590      dTLB-load-misses          #   95.43% of all dTLB cache accesses  ( +-  0.50% )  (46.60%)
>                736      iTLB-loads                #  110.875 /sec                     ( +-  1.79% )  (48.60%)
>          4,314,836      iTLB-load-misses          # 518653.73% of all iTLB cache accesses  ( +-  0.63% )  (42.91%)
>        144,950,156      L1-dcache-prefetches      #   21.836 M/sec                    ( +-  0.37% )  (41.39%)
> 
>            6.89935 +- 0.00703 seconds time elapsed  ( +-  0.10% )
> 
> The performance is clearly better. There is no significant hotspot
> improvement according to perf report, as there are quite a few
> callers of memcg_swap_enabled and do_memsw_account (which calls
> memcg_swap_enabled). Many pieces of minor optimizations resulted
> in lower overhead for the branch predictor, and bettter performance.
> 
> Acked-by: Michal Hocko <mhocko@suse.com>
> Signed-off-by: Kairui Song <kasong@tencent.com>

Acked-by: Shakeel Butt <shakeelb@google.com>
