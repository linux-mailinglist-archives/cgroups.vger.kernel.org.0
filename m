Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 037E4243774
	for <lists+cgroups@lfdr.de>; Thu, 13 Aug 2020 11:17:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726244AbgHMJRE (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 13 Aug 2020 05:17:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726144AbgHMJRE (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 13 Aug 2020 05:17:04 -0400
Received: from mail-il1-x144.google.com (mail-il1-x144.google.com [IPv6:2607:f8b0:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8E14C061384
        for <cgroups@vger.kernel.org>; Thu, 13 Aug 2020 02:17:03 -0700 (PDT)
Received: by mail-il1-x144.google.com with SMTP id p13so4970631ilh.4
        for <cgroups@vger.kernel.org>; Thu, 13 Aug 2020 02:17:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AVVK701BmMx0nOUeszXW5DOWYJuKUEBlmJUyUmBXonw=;
        b=KBgg1LChIJzojq8wCoeBtwucYMjlQp1QRp2wmwPAM1zKPNUxxR3/5bSVizhTzk6G44
         npUXrcnyRvP3lRa9ULHZykC+QGgP49O13LGemQfktRZo0AwGCTZxu1Ja45c7yx18xNv1
         muca13rZx62UlS4IYGcPmIkoylmr5XPcDhItlD5VtS/lOEzd/55M7WX/jCSGZlcxiQI+
         xvnTzujx3DLUkky5EGUiKdsM2s3jPLVW09TCdy6GQnvkfys69duwnup2xrOpSZ4dzgrb
         MtdejXgoIja4ZEo0YCTAljx1ZieNdcHRbla7np/JOHNAUDYiXq7g/vRLdZ5Giy7MIEkC
         pJKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AVVK701BmMx0nOUeszXW5DOWYJuKUEBlmJUyUmBXonw=;
        b=EGWWve7KaIzdJ/qaF3Clnw3ssxsPQMB+03g1JiogoXGmKyld1lKdqlXmVWK1nY9dI3
         ybS3sk7WIerkUlx3tiRyVeMRgT6p683p4EdhV8HhKYr4rRzYNR9IXhjvEa5QbYKsMO/F
         iqw2xU+LDPbfWMWV2ETDYRkqgyw6bbSP/SzoPsdBtSYeO1dyA4ERg7a5rduXEoxxlv2D
         8YbBT2ZULn5IxvGY26jXof3Z+jPvWi17z269mLDR2YGfr7MvO6OsHa/MkdIIGG6TeEFp
         zAfIkaqUQu+8Nic49URhb45FI/02Qng1ph99UlSG1LepoI9hvcgDrIoZBrPKn4eFfhoR
         0iRQ==
X-Gm-Message-State: AOAM533DSAgrom8J05bnwUznYr8qZDdcH7bYWpQEu//MriNARxorDqit
        rBRW2vcV0eKyJGhtqKyVyGrAy82ZqNeAREeL7latoQ==
X-Google-Smtp-Source: ABdhPJxRPXxN0U59d/h40YvTBY16ELyNZJXxcUBHQUGymL9OOd1KXfE1MSjnoyNb6ubpiCdMHTv5+ANAII49M9IQehI=
X-Received: by 2002:a92:d5ca:: with SMTP id d10mr3686682ilq.216.1597310222851;
 Thu, 13 Aug 2020 02:17:02 -0700 (PDT)
MIME-Version: 1.0
References: <20200623184515.4132564-1-guro@fb.com> <20200623184515.4132564-5-guro@fb.com>
 <20200811152737.GB650506@cmpxchg.org> <20200811170611.GB1507044@carbon.DHCP.thefacebook.com>
In-Reply-To: <20200811170611.GB1507044@carbon.DHCP.thefacebook.com>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Thu, 13 Aug 2020 14:46:51 +0530
Message-ID: <CA+G9fYuTsjEpDpODGcYf5hnGwzxj__tVdCMpWeC+ojg5pkYCzw@mail.gmail.com>
Subject: Re: [PATCH v3 4/5] mm: memcg: charge memcg percpu memory to the
 parent cgroup
To:     Roman Gushchin <guro@fb.com>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>, Cgroups <cgroups@vger.kernel.org>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dennis Zhou <dennis@kernel.org>, Tejun Heo <tj@kernel.org>,
        Christoph Lameter <cl@linux.com>,
        Michal Hocko <mhocko@kernel.org>,
        Shakeel Butt <shakeelb@google.com>,
        Kernel Team <kernel-team@fb.com>, lkft-triage@lists.linaro.org
Content-Type: text/plain; charset="UTF-8"
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

The kernel warnings  were noticed on linux next 20200813 while booting
on arm64, arm, x86_64 and i386.

metadata:
  git branch: master
  git repo: https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git
  git commit: e6d113aca646fb6a92b237340109237fd7a9c770
  git describe: next-20200813
  make_kernelversion: 5.8.0
  kernel-config:
https://builds.tuxbuild.com/YQHc_PpEV-DF8rU7N9tlIQ/kernel.config

> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index 130093bdf74b..e25f2db7e61c 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -5137,6 +5137,9 @@ static int alloc_mem_cgroup_per_node_info(struct mem_cgroup *memcg, int node)
>         if (!pn)
>                 return 1;
>
> +       /* We charge the parent cgroup, never the current task */
> +       WARN_ON_ONCE(!current->active_memcg);
> +
>         pn->lruvec_stat_local = alloc_percpu_gfp(struct lruvec_stat,
>                                                  GFP_KERNEL_ACCOUNT);
>         if (!pn->lruvec_stat_local) {
> @@ -5219,6 +5222,9 @@ static struct mem_cgroup *mem_cgroup_alloc(void)
>                 goto fail;
>         }
>
> +       /* We charge the parent cgroup, never the current task */
> +       WARN_ON_ONCE(!current->active_memcg);

[    0.217404] ------------[ cut here ]------------
[    0.218038] WARNING: CPU: 0 PID: 0 at mm/memcontrol.c:5226
mem_cgroup_css_alloc+0x680/0x740
[    0.219188] Modules linked in:
[    0.219597] CPU: 0 PID: 0 Comm: swapper/0 Not tainted 5.8.0-next-20200813 #1
[    0.220187] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996),
BIOS 1.12.0-1 04/01/2014
[    0.221190] EIP: mem_cgroup_css_alloc+0x680/0x740
[    0.222190] Code: d6 17 5d ff 8d 65 f4 89 d8 5b 5e 5f 5d c3 8d 74
26 00 b8 58 39 6a d1 e8 fe 94 55 ff 8d 65 f4 89 d8 5b 5e 5f 5d c3 8d
74 26 00 <0f> 0b e9 01 fa ff ff 8d b4 26 00 00 00 00 66 90 bb f4 ff ff
ff ba
[    0.223188] EAX: 00000000 EBX: d13666c0 ECX: 00000cc0 EDX: 0000ffff
[    0.224187] ESI: 00000000 EDI: f4c11000 EBP: d1361f50 ESP: d1361f40
[    0.225188] DS: 007b ES: 007b FS: 00d8 GS: 00e0 SS: 0068 EFLAGS: 00210246
[    0.226190] CR0: 80050033 CR2: ffd19000 CR3: 115f8000 CR4: 00040690
[    0.227195] Call Trace:
[    0.227882]  ? _cond_resched+0x17/0x30
[    0.228195]  cgroup_init_subsys+0x66/0x12a
[    0.229193]  cgroup_init+0x118/0x323
[    0.230194]  start_kernel+0x43c/0x47d
[    0.231193]  i386_start_kernel+0x48/0x4a
[    0.232194]  startup_32_smp+0x164/0x168
[    0.233195] ---[ end trace dfcf9be7b40caf05 ]---
[    0.2342#
08] ------------[ cut here ]------------
[    0.235192] WARNING: CPU: 0 PID: 0 at mm/memcontrol.c:5141
mem_cgroup_css_alloc+0x718/0x740
[    0.236187] Modules linked in:
[    0.236590] CPU: 0 PID: 0 Comm: swapper/0 Tainted: G        W
  5.8.0-next-20200813 #1
[    0.237190] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996),
BIOS 1.12.0-1 04/01/2014
[    0.238194] EIP: mem_cgroup_css_alloc+0x718/0x740
[    0.239191] Code: 48 ff e9 7c fd ff ff 8d 76 00 a1 b0 14 40 d1 e9
53 fc ff ff 8d b6 00 00 00 00 0f 0b 8d b6 00 00 00 00 0f 0b 8d b6 00
00 00 00 <0f> 0b e9 df f9 ff ff 90 89 f8 e8 29 0c 5c ff 89 f2 b8 10 f4
40 d1
[    0.240190] EAX: 00000000 EBX: f4c0c800 ECX: 00000000 EDX: d0eab660
[    0.241189] ESI: 00000000 EDI: f4c11000 EBP: d1361f50 ESP: d1361f40
[    0.242189] DS: 007b ES: 007b FS: 00d8 GS: 00e0 SS: 0068 EFLAGS: 00210246
[    0.243190] CR0: 80050033 CR2: ffd19000 CR3: 115f8000 CR4: 00040690
[    0.244188] Call Trace:
[    0.245191]  ? _cond_resched+0x17/0x30
[    0.245686]  cgroup_init_subsys+0x66/0x12a
[    0.246189]  cgroup_init+0x118/0x323
[    0.246654]  start_kernel+0x43c/0x47d
[    0.247189]  i386_start_kernel+0x48/0x4a
[    0.247697]  startup_32_smp+0x164/0x168
[    0.248188] ---[ end trace dfcf9be7b40caf06 ]---
[    0.248990] Last level iTLB entries: 4KB 512, 2MB 255, 4MB 127
[    0.249187] Last level dTLB entries: 4KB 512, 2MB 255, 4MB 127, 1GB 0


Full test log,
https://qa-reports.linaro.org/lkft/linux-next-oe/build/next-20200813/testrun/3061112/suite/linux-log-parser/test/check-kernel-warning-1665815/log

-- 
Linaro LKFT
https://lkft.linaro.org
