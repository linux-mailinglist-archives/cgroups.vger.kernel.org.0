Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0DBCF1DC54D
	for <lists+cgroups@lfdr.de>; Thu, 21 May 2020 04:40:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727992AbgEUCkE (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 20 May 2020 22:40:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727798AbgEUCkD (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 20 May 2020 22:40:03 -0400
Received: from mail-il1-x143.google.com (mail-il1-x143.google.com [IPv6:2607:f8b0:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27CCBC061A0E;
        Wed, 20 May 2020 19:40:02 -0700 (PDT)
Received: by mail-il1-x143.google.com with SMTP id y17so3336509ilg.0;
        Wed, 20 May 2020 19:40:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/RCzazjPJQ1zcfvr5ivU8gZ2oW1vvouNHyaX2fPjs5o=;
        b=JIZNHQnmERaJeRhfnEjjac0W+vknvOwLXY/d6ercTVMilrrz524WChiYGwFGcaHgFJ
         K8JZk1i5INW6EyIXuYOyX2v32bfw6qRfgzQTQHHULRWMhQsYMBm89glhPbVBx2I6bwxs
         j20/Yum6NRQKLWYNIxFRjPx0QViHZTbPlmI1fZzO6exUlTKfLwEVLiDwpVb7Qfp6TgJ/
         snhs+KlBeHyRitCTHyRBIFjZ454fFCb9qrYuro47/SQk4QgBQgus3sRPgPYvG8W/Vui1
         AknW2UXV00QW+opr5rDKKkCPY+BNrd0MlLO7V3cFfkCwusagGNkXGNtRMJgA5pK9QeWA
         IAFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/RCzazjPJQ1zcfvr5ivU8gZ2oW1vvouNHyaX2fPjs5o=;
        b=TWTHK1Mul5Ro/PhNgWzqWNYPt0nJuLsbNFOVNMtrDHKeUNy5e3Wh4KgXabrwfejQa4
         feGQUIrWta/+x1iWMMKkF95BTmX22rdt+eaMHB2HnUkoBYGSK/Hu9KHbjv+BmPIoH6+n
         MxAmTa8gLVNgzNGUEm32kaHaJYGHO8DYUO4jiB7cEoJwQyVAuC8rLYdbpC6arSWPo3K6
         Bgqcm/kcW5i+XRLJd6gjF3FiPga6q49LJs2Mgj6IFDBPg7QaPPNEhs8PSWHouj3hSFKC
         IVcPeYPuZJwkrw4dqoILxGW0DGCfBC0jvyl98CnOG3p+/AhoxnPTh8l9IaZhrNuYJihJ
         r98g==
X-Gm-Message-State: AOAM53084UvGaeHRrgPwSB/V1GuYkpGv69xr+89HIfFpfscv5Ue+oW+Z
        KgqQtQd3+FqBTBWZX8nQAlxvdPiSsKFL7f9z2FM=
X-Google-Smtp-Source: ABdhPJyv/UYZjPy/DPwJRsYbSaKbImcwHJUxF5BT675dGaD56oiGCZioxLSjEnZKhN7916a+tUgfDxQbE7d+nnFanoQ=
X-Received: by 2002:a92:9e11:: with SMTP id q17mr6952459ili.137.1590028801270;
 Wed, 20 May 2020 19:40:01 -0700 (PDT)
MIME-Version: 1.0
References: <CA+G9fYu2ruH-8uxBHE0pdE6RgRTSx4QuQPAN=Nv3BCdRd2ouYA@mail.gmail.com>
 <20200501135806.4eebf0b92f84ab60bba3e1e7@linux-foundation.org>
 <CA+G9fYsiZ81pmawUY62K30B6ue+RXYod854RS91R2+F8ZO7Xvw@mail.gmail.com>
 <20200519075213.GF32497@dhcp22.suse.cz> <CAK8P3a2T_j-Ynvhsqe_FCqS2-ZdLbo0oMbHhHChzMbryE0izAQ@mail.gmail.com>
 <20200519084535.GG32497@dhcp22.suse.cz> <CA+G9fYvzLm7n1BE7AJXd8_49fOgPgWWTiQ7sXkVre_zoERjQKg@mail.gmail.com>
 <CA+G9fYsXnwyGetj-vztAKPt8=jXrkY8QWe74u5EEA3XPW7aikQ@mail.gmail.com>
In-Reply-To: <CA+G9fYsXnwyGetj-vztAKPt8=jXrkY8QWe74u5EEA3XPW7aikQ@mail.gmail.com>
From:   Yafang Shao <laoar.shao@gmail.com>
Date:   Thu, 21 May 2020 10:39:25 +0800
Message-ID: <CALOAHbDMrHkNHTxeBWP22iTjJd+HfqfFhAfmC_m0jsVkhu5vEA@mail.gmail.com>
Subject: Re: mm: mkfs.ext4 invoked oom-killer on i386 - pagecache_get_page
To:     Naresh Kamboju <naresh.kamboju@linaro.org>
Cc:     Chris Down <chris@chrisdown.name>,
        Michal Hocko <mhocko@kernel.org>,
        Anders Roxell <anders.roxell@linaro.org>,
        "Linux F2FS DEV, Mailing List" 
        <linux-f2fs-devel@lists.sourceforge.net>,
        linux-ext4 <linux-ext4@vger.kernel.org>,
        linux-block <linux-block@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        open list <linux-kernel@vger.kernel.org>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>, Arnd Bergmann <arnd@arndb.de>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        "Theodore Ts'o" <tytso@mit.edu>, Chao Yu <chao@kernel.org>,
        Hugh Dickins <hughd@google.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Chao Yu <yuchao0@huawei.com>, lkft-triage@lists.linaro.org,
        Johannes Weiner <hannes@cmpxchg.org>,
        Roman Gushchin <guro@fb.com>, Cgroups <cgroups@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Thu, May 21, 2020 at 2:00 AM Naresh Kamboju
<naresh.kamboju@linaro.org> wrote:
>
> On Wed, 20 May 2020 at 17:26, Naresh Kamboju <naresh.kamboju@linaro.org> wrote:
> >
> >
> > This issue is specific on 32-bit architectures i386 and arm on linux-next tree.
> > As per the test results history this problem started happening from
> > Bad : next-20200430
> > Good : next-20200429
> >
> > steps to reproduce:
> > dd if=/dev/disk/by-id/ata-SanDisk_SSD_PLUS_120GB_190504A00573
> > of=/dev/null bs=1M count=2048
> > or
> > mkfs -t ext4 /dev/disk/by-id/ata-SanDisk_SSD_PLUS_120GB_190804A00BE5
> >
> >
> > Problem:
> > [   38.802375] dd invoked oom-killer: gfp_mask=0x100cc0(GFP_USER),
> > order=0, oom_score_adj=0
>
> As a part of investigation on this issue LKFT teammate Anders Roxell
> git bisected the problem and found bad commit(s) which caused this problem.
>
> The following two patches have been reverted on next-20200519 and retested the
> reproducible steps and confirmed the test case mkfs -t ext4 got PASS.
> ( invoked oom-killer is gone now)
>
> Revert "mm, memcg: avoid stale protection values when cgroup is above
> protection"
>     This reverts commit 23a53e1c02006120f89383270d46cbd040a70bc6.
>
> Revert "mm, memcg: decouple e{low,min} state mutations from protection
> checks"
>     This reverts commit 7b88906ab7399b58bb088c28befe50bcce076d82.
>

My guess is that we made the same mistake in commit "mm, memcg:
decouple e{low,min} state mutations from protection
checks" that it read a stale memcg protection in
mem_cgroup_below_low() and mem_cgroup_below_min().

Bellow is a possble fix,

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index 7a2c56fc..6591b71 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -391,20 +391,28 @@ static inline unsigned long
mem_cgroup_protection(struct mem_cgroup *root,
 void mem_cgroup_calculate_protection(struct mem_cgroup *root,
                                     struct mem_cgroup *memcg);

-static inline bool mem_cgroup_below_low(struct mem_cgroup *memcg)
+static inline bool mem_cgroup_below_low(struct mem_cgroup *root,
+                                       struct mem_cgroup *memcg)
 {
        if (mem_cgroup_disabled())
                return false;

+       if (root == memcg)
+               return false;
+
        return READ_ONCE(memcg->memory.elow) >=
                page_counter_read(&memcg->memory);
 }

-static inline bool mem_cgroup_below_min(struct mem_cgroup *memcg)
+static inline bool mem_cgroup_below_min(struct mem_cgroup *root,
+                                       struct mem_cgroup *memcg)
 {
        if (mem_cgroup_disabled())
                return false;

+       if (root == memcg)
+               return false;
+
        return READ_ONCE(memcg->memory.emin) >=
                page_counter_read(&memcg->memory);
 }
@@ -896,12 +904,14 @@ static inline void
mem_cgroup_calculate_protection(struct mem_cgroup *root,
 {
 }

-static inline bool mem_cgroup_below_low(struct mem_cgroup *memcg)
+static inline bool mem_cgroup_below_low(struct mem_cgroup *root,
+                                       struct mem_cgroup *memcg)
 {
        return false;
 }

-static inline bool mem_cgroup_below_min(struct mem_cgroup *memcg)
+static inline bool mem_cgroup_below_min(struct mem_cgroup *root,
+                                       struct mem_cgroup *memcg)
 {
        return false;
 }
diff --git a/mm/vmscan.c b/mm/vmscan.c
index c71660e..fdcdd88 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -2637,13 +2637,13 @@ static void shrink_node_memcgs(pg_data_t
*pgdat, struct scan_control *sc)

                mem_cgroup_calculate_protection(target_memcg, memcg);

-               if (mem_cgroup_below_min(memcg)) {
+               if (mem_cgroup_below_min(target_memcg, memcg)) {
                        /*
                         * Hard protection.
                         * If there is no reclaimable memory, OOM.
                         */
                        continue;
-               } else if (mem_cgroup_below_low(memcg)) {
+               } else if (mem_cgroup_below_low(target_memcg, memcg)) {
                        /*
                         * Soft protection.
                         * Respect the protection only as long as





> i386 test log shows mkfs -t ext4 pass
> https://lkft.validation.linaro.org/scheduler/job/1443405#L1200
>
> ref:
> https://lore.kernel.org/linux-mm/cover.1588092152.git.chris@chrisdown.name/
> https://lore.kernel.org/linux-mm/CA+G9fYvzLm7n1BE7AJXd8_49fOgPgWWTiQ7sXkVre_zoERjQKg@mail.gmail.com/T/#t
>
> --
> Linaro LKFT
> https://lkft.linaro.org



--
Thanks
Yafang
