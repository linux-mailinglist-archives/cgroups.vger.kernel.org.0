Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF053209974
	for <lists+cgroups@lfdr.de>; Thu, 25 Jun 2020 07:24:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389905AbgFYFY7 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 25 Jun 2020 01:24:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389559AbgFYFY6 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 25 Jun 2020 01:24:58 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7D22C061573
        for <cgroups@vger.kernel.org>; Wed, 24 Jun 2020 22:24:58 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id y18so2314988plr.4
        for <cgroups@vger.kernel.org>; Wed, 24 Jun 2020 22:24:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from:cc;
        bh=Z9E9F9Mp7v+/S0R9P1itGC7yBfrOh2oBxXHNGIb7loA=;
        b=nMN/B0Fu3KjiA2fcg1bSoSKiHUeeBUEEX6Df+GIYXDP3K9uQJYVhGttZqg9RGGgT9E
         dzb7eTABCsvG2W+a2sbRVqLcsnN92KhwP+n1iwwCfhW4TBK0OIsVFgi6PJTJsKQ3C7kt
         CHzE19cmYXd8r/gpZdxrlIZS3733JGo/R33+3Oem4pDj0fZAKKnc9uGmzYhaiwvmy0tb
         idd8R7X8aKvc/LweVdp8wlxq9tkHjB4tlc4gjaQKLLRI9TlhfRyv5biEeeBRNAAF1fig
         how/gndbd55D2G3Dx7NUays/1hjrm6JI7JSkR5mBxRWdUGKsZcUER9rXlJpE1xySUQjN
         x0xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from:cc;
        bh=Z9E9F9Mp7v+/S0R9P1itGC7yBfrOh2oBxXHNGIb7loA=;
        b=GlMyQCcu8EHmx2+Br+IvE2DUXP6kV5pLQxQWBtU99gGaJzazjUAUG8vrPj7dzzECzQ
         OznxzDLYn+IYLsNvY+FhkkmPYBuNMex6tV9ejmQkf3EZjspMnD1RiiT6f9BmN4JwBf4W
         P8zSQyctX3xF8jPv8hD6iNhoyxolqEbMwlnLhp0npPu8mVlNDOdDgcQiDcKx8/gToOrw
         ZnbEU7rWreNCpYeiaguYaCsKg/rkCpifPq6bsswD0PGYkS2tQQrTZA5FnYy9yUbOB2Lz
         KHZafk3P8mjytm/TLZYC0epPjvHCO33VFtcUp6ES6AVenzun29YVq285kfpazL8t/Pax
         oGlw==
X-Gm-Message-State: AOAM532KImeJ3qimiF+v4+UcnpCSOOik+nG6ikj4iXftOcko3aiwwXo3
        llN+ifG38kX9FEVXW6zeDZ7Wtg==
X-Google-Smtp-Source: ABdhPJy0/Ew8K0kL+0NaJpUTAbZiRRvpFcOdugV7uK8nijnLvkus3PLIIi2GICBvKjFEWQSuMYFyfg==
X-Received: by 2002:a17:902:710d:: with SMTP id a13mr941675pll.71.1593062698219;
        Wed, 24 Jun 2020 22:24:58 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id gq13sm3288917pjb.7.2020.06.24.22.24.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jun 2020 22:24:57 -0700 (PDT)
Message-ID: <5ef43529.1c69fb81.eac8c.85c7@mx.google.com>
Date:   Wed, 24 Jun 2020 22:24:57 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: bisect
X-Kernelci-Branch: linux-5.6.y
X-Kernelci-Lab-Name: lab-baylibre
X-Kernelci-Tree: stable-rc
X-Kernelci-Kernel: v5.6.19
Subject: stable-rc/linux-5.6.y bisection: baseline.dmesg.crit on
 bcm2837-rpi-3-b
To:     Tejun Heo <tj@kernel.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        gtucker@collabora.com, Sasha Levin <sashal@kernel.org>
From:   "kernelci.org bot" <bot@kernelci.org>
Cc:     Li Zefan <lizefan@huawei.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        cgroups@vger.kernel.org, Johannes Weiner <hannes@cmpxchg.org>,
        linux-kernel@vger.kernel.org
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
* This automated bisection report was sent to you on the basis  *
* that you may be involved with the breaking commit it has      *
* found.  No manual investigation has been done to verify it,   *
* and the root cause of the problem may be somewhere else.      *
*                                                               *
* If you do send a fix, please include this trailer:            *
*   Reported-by: "kernelci.org bot" <bot@kernelci.org>          *
*                                                               *
* Hope this helps!                                              *
* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *

stable-rc/linux-5.6.y bisection: baseline.dmesg.crit on bcm2837-rpi-3-b

Summary:
  Start:      61aba373f570 Linux 5.6.19
  Plain log:  https://storage.kernelci.org/stable-rc/linux-5.6.y/v5.6.19/ar=
m64/defconfig/gcc-8/lab-baylibre/baseline-bcm2837-rpi-3-b.txt
  HTML log:   https://storage.kernelci.org/stable-rc/linux-5.6.y/v5.6.19/ar=
m64/defconfig/gcc-8/lab-baylibre/baseline-bcm2837-rpi-3-b.html
  Result:     9cf5d5444c78 Revert "cgroup: Add memory barriers to plug cgro=
up_rstat_updated() race window"

Checks:
  revert:     PASS
  verify:     PASS

Parameters:
  Tree:       stable-rc
  URL:        https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-=
stable-rc.git
  Branch:     linux-5.6.y
  Target:     bcm2837-rpi-3-b
  CPU arch:   arm64
  Lab:        lab-baylibre
  Compiler:   gcc-8
  Config:     defconfig
  Test case:  baseline.dmesg.crit

Breaking commit found:

---------------------------------------------------------------------------=
----
commit 9cf5d5444c78c14bb9f90dd21cef361ee14ba64b
Author: Tejun Heo <tj@kernel.org>
Date:   Thu Apr 9 14:55:35 2020 -0400

    Revert "cgroup: Add memory barriers to plug cgroup_rstat_updated() race=
 window"
    =

    [ Upstream commit d8ef4b38cb69d907f9b0e889c44d05fc0f890977 ]
    =

    This reverts commit 9a9e97b2f1f2 ("cgroup: Add memory barriers to plug
    cgroup_rstat_updated() race window").
    =

    The commit was added in anticipation of memcg rstat conversion which ne=
eded
    synchronous accounting for the event counters (e.g. oom kill count). Ho=
wever,
    the conversion didn't get merged due to percpu memory overhead concern =
which
    couldn't be addressed at the time.
    =

    Unfortunately, the patch's addition of smp_mb() to cgroup_rstat_updated=
()
    meant that every scheduling event now had to go through an additional f=
ull
    barrier and Mel Gorman noticed it as 1% regression in netperf UDP_STREA=
M test.
    =

    There's no need to have this barrier in tree now and even if we need
    synchronous accounting in the future, the right thing to do is separati=
ng that
    out to a separate function so that hot paths which don't care about
    synchronous behavior don't have to pay the overhead of the full barrier=
. Let's
    revert.
    =

    Signed-off-by: Tejun Heo <tj@kernel.org>
    Reported-by: Mel Gorman <mgorman@techsingularity.net>
    Link: http://lkml.kernel.org/r/20200409154413.GK3818@techsingularity.net
    Cc: v4.18+
    Signed-off-by: Sasha Levin <sashal@kernel.org>

diff --git a/kernel/cgroup/rstat.c b/kernel/cgroup/rstat.c
index 6f87352f8219..41ca996568df 100644
--- a/kernel/cgroup/rstat.c
+++ b/kernel/cgroup/rstat.c
@@ -33,12 +33,9 @@ void cgroup_rstat_updated(struct cgroup *cgrp, int cpu)
 		return;
 =

 	/*
-	 * Paired with the one in cgroup_rstat_cpu_pop_updated().  Either we
-	 * see NULL updated_next or they see our updated stat.
-	 */
-	smp_mb();
-
-	/*
+	 * Speculative already-on-list test. This may race leading to
+	 * temporary inaccuracies, which is fine.
+	 *
 	 * Because @parent's updated_children is terminated with @parent
 	 * instead of NULL, we can tell whether @cgrp is on the list by
 	 * testing the next pointer for NULL.
@@ -134,13 +131,6 @@ static struct cgroup *cgroup_rstat_cpu_pop_updated(str=
uct cgroup *pos,
 		*nextp =3D rstatc->updated_next;
 		rstatc->updated_next =3D NULL;
 =

-		/*
-		 * Paired with the one in cgroup_rstat_cpu_updated().
-		 * Either they see NULL updated_next or we see their
-		 * updated stat.
-		 */
-		smp_mb();
-
 		return pos;
 	}
---------------------------------------------------------------------------=
----


Git bisection log:

---------------------------------------------------------------------------=
----
git bisect start
# good: [7111951b8d4973bda27ff663f2cf18b663d15b48] Linux 5.6
git bisect good 7111951b8d4973bda27ff663f2cf18b663d15b48
# bad: [61aba373f5708f2aebc3f72078e51949a068aa6f] Linux 5.6.19
git bisect bad 61aba373f5708f2aebc3f72078e51949a068aa6f
# good: [0bc4d081e87ef8fd43baeed7141267e558896f86] RDMA/cm: Fix an error ch=
eck in cm_alloc_id_priv()
git bisect good 0bc4d081e87ef8fd43baeed7141267e558896f86
# good: [0deceb85de592b89f6476e2bfcb5321a95d23126] dmaengine: owl: Use corr=
ect lock in owl_dma_get_pchan()
git bisect good 0deceb85de592b89f6476e2bfcb5321a95d23126
# bad: [566f16e2d62fb3817529a05147ef46046ecffe6a] io_uring: initialize ctx-=
>sqo_wait earlier
git bisect bad 566f16e2d62fb3817529a05147ef46046ecffe6a
# good: [23952755bc2f839844b5a60c29620cce98c9b09d] riscv: stacktrace: Fix u=
ndefined reference to `walk_stackframe'
git bisect good 23952755bc2f839844b5a60c29620cce98c9b09d
# good: [be31933db49c8e3d81b96ee6bc9933d2adafe13d] drm/amd/display: Fix pot=
ential integer wraparound resulting in a hang
git bisect good be31933db49c8e3d81b96ee6bc9933d2adafe13d
# good: [ee899046f79db390650e546446a7a0196788d39d] esp6: get the right prot=
o for transport mode in esp6_gso_encap
git bisect good ee899046f79db390650e546446a7a0196788d39d
# good: [bdd07c33a3be1896ec1982fab1a2baf986fbe4dc] netfilter: conntrack: co=
mparison of unsigned in cthelper confirmation
git bisect good bdd07c33a3be1896ec1982fab1a2baf986fbe4dc
# bad: [46f4a75fb5034c8d80a5388fe3bb46a8ed05df5b] ARC: [plat-eznps]: Restri=
ct to CONFIG_ISA_ARCOMPACT
git bisect bad 46f4a75fb5034c8d80a5388fe3bb46a8ed05df5b
# good: [960a4cc3ec49f8292d0f837f0a6b28b03c54f042] Linux 5.6.16
git bisect good 960a4cc3ec49f8292d0f837f0a6b28b03c54f042
# bad: [9cf5d5444c78c14bb9f90dd21cef361ee14ba64b] Revert "cgroup: Add memor=
y barriers to plug cgroup_rstat_updated() race window"
git bisect bad 9cf5d5444c78c14bb9f90dd21cef361ee14ba64b
# good: [2df9b670ad1a2120f54982e1b1dfd17a6ce3cc0c] x86/syscalls: Revert "x8=
6/syscalls: Make __X32_SYSCALL_BIT be unsigned long"
git bisect good 2df9b670ad1a2120f54982e1b1dfd17a6ce3cc0c
# first bad commit: [9cf5d5444c78c14bb9f90dd21cef361ee14ba64b] Revert "cgro=
up: Add memory barriers to plug cgroup_rstat_updated() race window"
---------------------------------------------------------------------------=
----
