Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 435115A6078
	for <lists+cgroups@lfdr.de>; Tue, 30 Aug 2022 12:14:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229682AbiH3KOu (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 30 Aug 2022 06:14:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230254AbiH3KO1 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 30 Aug 2022 06:14:27 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA882785BC;
        Tue, 30 Aug 2022 03:12:23 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 43D6B21ACB;
        Tue, 30 Aug 2022 10:12:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1661854341; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LYvW4/C2mjaJQZlE3mRWOzrMuvS8imMEtRVp0zKjWZI=;
        b=qsVu4V70wdDHwjBgpKiDN0IlP/BDCuLEwMyjOQLn0UUCVFhXfjfQkoPEbTbScmBED/gl6P
        bhU/EU/BRe2KUivYSHMfWx7D/0VMg7tkZvJUo10luRxxgtwxj1QUbxotcwmi5ML2RzsZF/
        j9alAbuMHIT1y5Qy8jCkr4+d0Co14+M=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 1A90213B0C;
        Tue, 30 Aug 2022 10:12:21 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id IHTZA4XiDWPAKQAAMHmgww
        (envelope-from <mhocko@suse.com>); Tue, 30 Aug 2022 10:12:21 +0000
Date:   Tue, 30 Aug 2022 12:12:20 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Kairui Song <ryncsn@gmail.com>
Cc:     cgroups@vger.kernel.org, linux-mm@kvack.org,
        Johannes Weiner <hannes@cmpxchg.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Shakeel Butt <shakeelb@google.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] mm: memcontrol: make cgroup_memory_noswap a static
 key
Message-ID: <Yw3ihBZ7J/V37eU0@dhcp22.suse.cz>
References: <20220830055949.12640-1-ryncsn@gmail.com>
 <20220830055949.12640-3-ryncsn@gmail.com>
 <Yw21uOyEz9lLkI3p@dhcp22.suse.cz>
 <CAMgjq7CM_SX3jLj9yp5hzAr6c3hBtS5nd4Nh4z8bTY8yWx-3KQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMgjq7CM_SX3jLj9yp5hzAr6c3hBtS5nd4Nh4z8bTY8yWx-3KQ@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue 30-08-22 16:50:38, Kairui Song wrote:
> Michal Hocko <mhocko@suse.com> 于2022年8月30日周二 15:01写道：
> >
> > On Tue 30-08-22 13:59:49, Kairui Song wrote:
> > > From: Kairui Song <kasong@tencent.com>
> > >
> > > cgroup_memory_noswap is used in many hot path, so make it a static key
> > > to lower the kernel overhead.
> > >
> > > Using 8G of ZRAM as SWAP, benchmark using `perf stat -d -d -d --repeat 100`
> > > with the following code snip in a non-root cgroup:
> > >
> > >    #include <stdio.h>
> > >    #include <string.h>
> > >    #include <linux/mman.h>
> > >    #include <sys/mman.h>
> > >    #define MB 1024UL * 1024UL
> > >    int main(int argc, char **argv){
> > >       void *p = mmap(NULL, 8000 * MB, PROT_READ | PROT_WRITE,
> > >                      MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
> > >       memset(p, 0xff, 8000 * MB);
> > >       madvise(p, 8000 * MB, MADV_PAGEOUT);
> > >       memset(p, 0xff, 8000 * MB);
> > >       return 0;
> > >    }
> > >
> > > Before:
> > >           7,021.43 msec task-clock                #    0.967 CPUs utilized            ( +-  0.03% )
> > >              4,010      context-switches          #  573.853 /sec                     ( +-  0.01% )
> > >                  0      cpu-migrations            #    0.000 /sec
> > >          2,052,057      page-faults               #  293.661 K/sec                    ( +-  0.00% )
> > >     12,616,546,027      cycles                    #    1.805 GHz                      ( +-  0.06% )  (39.92%)
> > >        156,823,666      stalled-cycles-frontend   #    1.25% frontend cycles idle     ( +-  0.10% )  (40.25%)
> > >        310,130,812      stalled-cycles-backend    #    2.47% backend cycles idle      ( +-  4.39% )  (40.73%)
> > >     18,692,516,591      instructions              #    1.49  insn per cycle
> > >                                                   #    0.01  stalled cycles per insn  ( +-  0.04% )  (40.75%)
> > >      4,907,447,976      branches                  #  702.283 M/sec                    ( +-  0.05% )  (40.30%)
> > >         13,002,578      branch-misses             #    0.26% of all branches          ( +-  0.08% )  (40.48%)
> > >      7,069,786,296      L1-dcache-loads           #    1.012 G/sec                    ( +-  0.03% )  (40.32%)
> > >        649,385,847      L1-dcache-load-misses     #    9.13% of all L1-dcache accesses  ( +-  0.07% )  (40.10%)
> > >      1,485,448,688      L1-icache-loads           #  212.576 M/sec                    ( +-  0.15% )  (39.49%)
> > >         31,628,457      L1-icache-load-misses     #    2.13% of all L1-icache accesses  ( +-  0.40% )  (39.57%)
> > >          6,667,311      dTLB-loads                #  954.129 K/sec                    ( +-  0.21% )  (39.50%)
> > >          5,668,555      dTLB-load-misses          #   86.40% of all dTLB cache accesses  ( +-  0.12% )  (39.03%)
> > >                765      iTLB-loads                #  109.476 /sec                     ( +- 21.81% )  (39.44%)
> > >          4,370,351      iTLB-load-misses          # 214320.09% of all iTLB cache accesses  ( +-  1.44% )  (39.86%)
> > >        149,207,254      L1-dcache-prefetches      #   21.352 M/sec                    ( +-  0.13% )  (40.27%)
> > >
> > >            7.25869 +- 0.00203 seconds time elapsed  ( +-  0.03% )
> > >
> > > After:
> > >           6,576.16 msec task-clock                #    0.953 CPUs utilized            ( +-  0.10% )
> > >              4,020      context-switches          #  605.595 /sec                     ( +-  0.01% )
> > >                  0      cpu-migrations            #    0.000 /sec
> > >          2,052,056      page-faults               #  309.133 K/sec                    ( +-  0.00% )
> > >     11,967,619,180      cycles                    #    1.803 GHz                      ( +-  0.36% )  (38.76%)
> > >        161,259,240      stalled-cycles-frontend   #    1.38% frontend cycles idle     ( +-  0.27% )  (36.58%)
> > >        253,605,302      stalled-cycles-backend    #    2.16% backend cycles idle      ( +-  4.45% )  (34.78%)
> > >     19,328,171,892      instructions              #    1.65  insn per cycle
> > >                                                   #    0.01  stalled cycles per insn  ( +-  0.10% )  (31.46%)
> > >      5,213,967,902      branches                  #  785.461 M/sec                    ( +-  0.18% )  (30.68%)
> > >         12,385,170      branch-misses             #    0.24% of all branches          ( +-  0.26% )  (34.13%)
> > >      7,271,687,822      L1-dcache-loads           #    1.095 G/sec                    ( +-  0.12% )  (35.29%)
> > >        649,873,045      L1-dcache-load-misses     #    8.93% of all L1-dcache accesses  ( +-  0.11% )  (41.41%)
> > >      1,950,037,608      L1-icache-loads           #  293.764 M/sec                    ( +-  0.33% )  (43.11%)
> > >         31,365,566      L1-icache-load-misses     #    1.62% of all L1-icache accesses  ( +-  0.39% )  (45.89%)
> > >          6,767,809      dTLB-loads                #    1.020 M/sec                    ( +-  0.47% )  (48.42%)
> > >          6,339,590      dTLB-load-misses          #   95.43% of all dTLB cache accesses  ( +-  0.50% )  (46.60%)
> > >                736      iTLB-loads                #  110.875 /sec                     ( +-  1.79% )  (48.60%)
> > >          4,314,836      iTLB-load-misses          # 518653.73% of all iTLB cache accesses  ( +-  0.63% )  (42.91%)
> > >        144,950,156      L1-dcache-prefetches      #   21.836 M/sec                    ( +-  0.37% )  (41.39%)
> > >
> > >            6.89935 +- 0.00703 seconds time elapsed  ( +-  0.10% )
> >
> > Do you happen to have a perf profile before and after to see which of
> > the paths really benefits from this?
> 
> No I don't have a clear profile data about which path benefit the most.
> The performance benchmark result can be stably reproduced, but perf
> record & report & diff doesn't seems too helpful, as I can't see a
> significant change of any single symbols.

This is a good information on its own as it suggests that the overhead
is spilled over multiple places rather than a single hot spot. Good to
have in the changelog.

-- 
Michal Hocko
SUSE Labs
