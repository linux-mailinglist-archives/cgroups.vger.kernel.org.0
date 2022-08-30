Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5A075A5EA0
	for <lists+cgroups@lfdr.de>; Tue, 30 Aug 2022 10:51:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229837AbiH3Iv4 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 30 Aug 2022 04:51:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231267AbiH3IvX (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 30 Aug 2022 04:51:23 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E934418B28;
        Tue, 30 Aug 2022 01:50:50 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id w88-20020a17090a6be100b001fbb0f0b013so11145901pjj.5;
        Tue, 30 Aug 2022 01:50:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc;
        bh=/4NmEBmRVS5u98WkgFxb7busgin0hbl0z7JMDpKPQqI=;
        b=TMDmeULTGp3zYQ+RirhTSLeIsq6KmqYJ49vvOBhKY5C3ctMXCWGgwqs5tY9u4g6uvF
         RUiemXktaGoLUnHw9D/UWxWHafa12IPc2pJwqY6ZuN0lhSwS35HQynC/ErGIUeYamtby
         OuUm4J9bfeXoqofRGmNZ53n3MHhUQcRTzH15b4dlARX8Uv0h3+LDRcPQOlWFvDba5QjU
         ge73zqtgh6uaaiWwiJ5Qot0luKdab4IVTBuIjUDXi4lTERaT/drddly1BzTKgXLBao3j
         iPHgiPy86abgz0hCKRFCdQnh72YEpuJSGIeBx85eTPlUau5iHZM8CFE+JVxIr98b20NB
         besg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc;
        bh=/4NmEBmRVS5u98WkgFxb7busgin0hbl0z7JMDpKPQqI=;
        b=q6Cxudj6C9beBEipJlbvlS2e61FpnZgGlHcYSp4/Dysz1KKw4DWSxfPFsSDxeMG2VI
         awaLK9TY4VGAZgmu974BFbdknZIAwHmTLnpNwRAEurhS9sMWi1szrHI1SjJ3Ozk+6FI5
         8XYENIRWYf3LD1QNKT3+lGKqd8Mq54KDSBqzeirRShkcwPndkO8PDHtTWsiagcJGLHtI
         +d25vbN2TQPhLNLfTs6O0rGc5bqcyGCHcepaV+L5t/4zuih8t2eULEWbs3aPDWOv4QDL
         xBLJWDpPQ45MrzG12V6i00Aj32/LOsBoq9yoJK2l+eBPQjg10bgynLs75MKoWpxq6olt
         OmWw==
X-Gm-Message-State: ACgBeo2GQJHp2l0X0syj5vsHkIDKxf8tkqf3l4JFFxx5N2kBRcKHss7I
        ErGayf7yxh+AAPNSQczWf98Omftu48jFsSYGwFc=
X-Google-Smtp-Source: AA6agR6lUyMgE5tAwRkQHiJNclB++eX2/Zbq+XyICuqYKAhQaQVOSu/Iq42ARRPFBKvdIIBGutCrBZ4AJ7Knha4Tt6o=
X-Received: by 2002:a17:902:a982:b0:170:d646:5851 with SMTP id
 bh2-20020a170902a98200b00170d6465851mr20697690plb.134.1661849450448; Tue, 30
 Aug 2022 01:50:50 -0700 (PDT)
MIME-Version: 1.0
References: <20220830055949.12640-1-ryncsn@gmail.com> <20220830055949.12640-3-ryncsn@gmail.com>
 <Yw21uOyEz9lLkI3p@dhcp22.suse.cz>
In-Reply-To: <Yw21uOyEz9lLkI3p@dhcp22.suse.cz>
From:   Kairui Song <ryncsn@gmail.com>
Date:   Tue, 30 Aug 2022 16:50:38 +0800
Message-ID: <CAMgjq7CM_SX3jLj9yp5hzAr6c3hBtS5nd4Nh4z8bTY8yWx-3KQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] mm: memcontrol: make cgroup_memory_noswap a static key
To:     Michal Hocko <mhocko@suse.com>
Cc:     cgroups@vger.kernel.org, linux-mm@kvack.org,
        Johannes Weiner <hannes@cmpxchg.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Shakeel Butt <shakeelb@google.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Michal Hocko <mhocko@suse.com> =E4=BA=8E2022=E5=B9=B48=E6=9C=8830=E6=97=A5=
=E5=91=A8=E4=BA=8C 15:01=E5=86=99=E9=81=93=EF=BC=9A
>
> On Tue 30-08-22 13:59:49, Kairui Song wrote:
> > From: Kairui Song <kasong@tencent.com>
> >
> > cgroup_memory_noswap is used in many hot path, so make it a static key
> > to lower the kernel overhead.
> >
> > Using 8G of ZRAM as SWAP, benchmark using `perf stat -d -d -d --repeat =
100`
> > with the following code snip in a non-root cgroup:
> >
> >    #include <stdio.h>
> >    #include <string.h>
> >    #include <linux/mman.h>
> >    #include <sys/mman.h>
> >    #define MB 1024UL * 1024UL
> >    int main(int argc, char **argv){
> >       void *p =3D mmap(NULL, 8000 * MB, PROT_READ | PROT_WRITE,
> >                      MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
> >       memset(p, 0xff, 8000 * MB);
> >       madvise(p, 8000 * MB, MADV_PAGEOUT);
> >       memset(p, 0xff, 8000 * MB);
> >       return 0;
> >    }
> >
> > Before:
> >           7,021.43 msec task-clock                #    0.967 CPUs utili=
zed            ( +-  0.03% )
> >              4,010      context-switches          #  573.853 /sec      =
               ( +-  0.01% )
> >                  0      cpu-migrations            #    0.000 /sec
> >          2,052,057      page-faults               #  293.661 K/sec     =
               ( +-  0.00% )
> >     12,616,546,027      cycles                    #    1.805 GHz       =
               ( +-  0.06% )  (39.92%)
> >        156,823,666      stalled-cycles-frontend   #    1.25% frontend c=
ycles idle     ( +-  0.10% )  (40.25%)
> >        310,130,812      stalled-cycles-backend    #    2.47% backend cy=
cles idle      ( +-  4.39% )  (40.73%)
> >     18,692,516,591      instructions              #    1.49  insn per c=
ycle
> >                                                   #    0.01  stalled cy=
cles per insn  ( +-  0.04% )  (40.75%)
> >      4,907,447,976      branches                  #  702.283 M/sec     =
               ( +-  0.05% )  (40.30%)
> >         13,002,578      branch-misses             #    0.26% of all bra=
nches          ( +-  0.08% )  (40.48%)
> >      7,069,786,296      L1-dcache-loads           #    1.012 G/sec     =
               ( +-  0.03% )  (40.32%)
> >        649,385,847      L1-dcache-load-misses     #    9.13% of all L1-=
dcache accesses  ( +-  0.07% )  (40.10%)
> >      1,485,448,688      L1-icache-loads           #  212.576 M/sec     =
               ( +-  0.15% )  (39.49%)
> >         31,628,457      L1-icache-load-misses     #    2.13% of all L1-=
icache accesses  ( +-  0.40% )  (39.57%)
> >          6,667,311      dTLB-loads                #  954.129 K/sec     =
               ( +-  0.21% )  (39.50%)
> >          5,668,555      dTLB-load-misses          #   86.40% of all dTL=
B cache accesses  ( +-  0.12% )  (39.03%)
> >                765      iTLB-loads                #  109.476 /sec      =
               ( +- 21.81% )  (39.44%)
> >          4,370,351      iTLB-load-misses          # 214320.09% of all i=
TLB cache accesses  ( +-  1.44% )  (39.86%)
> >        149,207,254      L1-dcache-prefetches      #   21.352 M/sec     =
               ( +-  0.13% )  (40.27%)
> >
> >            7.25869 +- 0.00203 seconds time elapsed  ( +-  0.03% )
> >
> > After:
> >           6,576.16 msec task-clock                #    0.953 CPUs utili=
zed            ( +-  0.10% )
> >              4,020      context-switches          #  605.595 /sec      =
               ( +-  0.01% )
> >                  0      cpu-migrations            #    0.000 /sec
> >          2,052,056      page-faults               #  309.133 K/sec     =
               ( +-  0.00% )
> >     11,967,619,180      cycles                    #    1.803 GHz       =
               ( +-  0.36% )  (38.76%)
> >        161,259,240      stalled-cycles-frontend   #    1.38% frontend c=
ycles idle     ( +-  0.27% )  (36.58%)
> >        253,605,302      stalled-cycles-backend    #    2.16% backend cy=
cles idle      ( +-  4.45% )  (34.78%)
> >     19,328,171,892      instructions              #    1.65  insn per c=
ycle
> >                                                   #    0.01  stalled cy=
cles per insn  ( +-  0.10% )  (31.46%)
> >      5,213,967,902      branches                  #  785.461 M/sec     =
               ( +-  0.18% )  (30.68%)
> >         12,385,170      branch-misses             #    0.24% of all bra=
nches          ( +-  0.26% )  (34.13%)
> >      7,271,687,822      L1-dcache-loads           #    1.095 G/sec     =
               ( +-  0.12% )  (35.29%)
> >        649,873,045      L1-dcache-load-misses     #    8.93% of all L1-=
dcache accesses  ( +-  0.11% )  (41.41%)
> >      1,950,037,608      L1-icache-loads           #  293.764 M/sec     =
               ( +-  0.33% )  (43.11%)
> >         31,365,566      L1-icache-load-misses     #    1.62% of all L1-=
icache accesses  ( +-  0.39% )  (45.89%)
> >          6,767,809      dTLB-loads                #    1.020 M/sec     =
               ( +-  0.47% )  (48.42%)
> >          6,339,590      dTLB-load-misses          #   95.43% of all dTL=
B cache accesses  ( +-  0.50% )  (46.60%)
> >                736      iTLB-loads                #  110.875 /sec      =
               ( +-  1.79% )  (48.60%)
> >          4,314,836      iTLB-load-misses          # 518653.73% of all i=
TLB cache accesses  ( +-  0.63% )  (42.91%)
> >        144,950,156      L1-dcache-prefetches      #   21.836 M/sec     =
               ( +-  0.37% )  (41.39%)
> >
> >            6.89935 +- 0.00703 seconds time elapsed  ( +-  0.10% )
>
> Do you happen to have a perf profile before and after to see which of
> the paths really benefits from this?

No I don't have a clear profile data about which path benefit the most.
The performance benchmark result can be stably reproduced, but perf
record & report & diff doesn't seems too helpful, as I can't see a
significant change of any single symbols.

There are quite a few callers of memcg_swap_enabled and
do_memsw_account (which also calls memcg_swap_enabled), to me, it
seems multiple pieces of optimization caused an overall improvement.
And a lower overhead for the branch predictor may also help in
general.

Any other suggestion about how to collect such data?
