Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 60C741DD31F
	for <lists+cgroups@lfdr.de>; Thu, 21 May 2020 18:34:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728774AbgEUQe4 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 21 May 2020 12:34:56 -0400
Received: from mail-ej1-f65.google.com ([209.85.218.65]:46610 "EHLO
        mail-ej1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726938AbgEUQez (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 21 May 2020 12:34:55 -0400
Received: by mail-ej1-f65.google.com with SMTP id e2so9520077eje.13;
        Thu, 21 May 2020 09:34:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=xPFD7IFPtAwroNkfi9MemR+cpIhDyy+Gat6jBDCzwmc=;
        b=I+zFEekaSGNtUvOBaQWHj6RVKBBQMWG7kcw59nWP4UEq62aw8PzkCFsFxhdCeLUvOF
         uvUgqFtNQRGimz80rErbFSQHYD8Eipwj94F6p1arDkhfw81w5/EZG489FiZrdUBA6Tfc
         aaOyjjcZXHaZyPOw4aqEsK0kOJRvskGJFz0N2ablGt8tM1zI6Im0TT7heeWpJurk4i6S
         7yNpIilJeEOe1qs7WN/XRZ4NWWoqEV0TpLCfxZROanRtx+r0aOwXFD6eM2yKMDPz9mam
         WXK89Bq0PWkePDyepB4ysrudm9LfvdoP2xaP8Fjca8pEjl+SzWayfxb00dpPyChLXhOn
         48Hg==
X-Gm-Message-State: AOAM531Obo4tukQe9e0V2brWkUq0agXLcajodfW2Cxf0Rfi6OXa0TPL4
        DaLqKLt7Fcdx/WRA7D0uGa4=
X-Google-Smtp-Source: ABdhPJwXVn3GpddymYyJuCnFqK41AXqqaHjxUQiP8VzaDxPtzIQQTqMUciYSPeaIDYFRbF092GX9fQ==
X-Received: by 2002:a17:906:3607:: with SMTP id q7mr4218185ejb.81.1590078892997;
        Thu, 21 May 2020 09:34:52 -0700 (PDT)
Received: from localhost (ip-37-188-180-112.eurotel.cz. [37.188.180.112])
        by smtp.gmail.com with ESMTPSA id m27sm5175644eja.83.2020.05.21.09.34.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 May 2020 09:34:51 -0700 (PDT)
Date:   Thu, 21 May 2020 18:34:50 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Naresh Kamboju <naresh.kamboju@linaro.org>,
        Chris Down <chris@chrisdown.name>
Cc:     Yafang Shao <laoar.shao@gmail.com>,
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
        Theodore Ts'o <tytso@mit.edu>, Chao Yu <chao@kernel.org>,
        Hugh Dickins <hughd@google.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Chao Yu <yuchao0@huawei.com>, lkft-triage@lists.linaro.org,
        Johannes Weiner <hannes@cmpxchg.org>,
        Roman Gushchin <guro@fb.com>, cgroups@vger.kernel.org
Subject: Re: mm: mkfs.ext4 invoked oom-killer on i386 - pagecache_get_page
Message-ID: <20200521163450.GV6462@dhcp22.suse.cz>
References: <CA+G9fYu2ruH-8uxBHE0pdE6RgRTSx4QuQPAN=Nv3BCdRd2ouYA@mail.gmail.com>
 <20200501135806.4eebf0b92f84ab60bba3e1e7@linux-foundation.org>
 <CA+G9fYsiZ81pmawUY62K30B6ue+RXYod854RS91R2+F8ZO7Xvw@mail.gmail.com>
 <20200519075213.GF32497@dhcp22.suse.cz>
 <CAK8P3a2T_j-Ynvhsqe_FCqS2-ZdLbo0oMbHhHChzMbryE0izAQ@mail.gmail.com>
 <20200519084535.GG32497@dhcp22.suse.cz>
 <CA+G9fYvzLm7n1BE7AJXd8_49fOgPgWWTiQ7sXkVre_zoERjQKg@mail.gmail.com>
 <CA+G9fYsXnwyGetj-vztAKPt8=jXrkY8QWe74u5EEA3XPW7aikQ@mail.gmail.com>
 <20200520190906.GA558281@chrisdown.name>
 <20200521095515.GK6462@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200521095515.GK6462@dhcp22.suse.cz>
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Thu 21-05-20 11:55:16, Michal Hocko wrote:
> On Wed 20-05-20 20:09:06, Chris Down wrote:
> > Hi Naresh,
> > 
> > Naresh Kamboju writes:
> > > As a part of investigation on this issue LKFT teammate Anders Roxell
> > > git bisected the problem and found bad commit(s) which caused this problem.
> > > 
> > > The following two patches have been reverted on next-20200519 and retested the
> > > reproducible steps and confirmed the test case mkfs -t ext4 got PASS.
> > > ( invoked oom-killer is gone now)
> > > 
> > > Revert "mm, memcg: avoid stale protection values when cgroup is above
> > > protection"
> > >    This reverts commit 23a53e1c02006120f89383270d46cbd040a70bc6.
> > > 
> > > Revert "mm, memcg: decouple e{low,min} state mutations from protection
> > > checks"
> > >    This reverts commit 7b88906ab7399b58bb088c28befe50bcce076d82.
> > 
> > Thanks Anders and Naresh for tracking this down and reverting.
> > 
> > I'll take a look tomorrow. I don't see anything immediately obviously wrong
> > in either of those commits from a (very) cursory glance, but they should
> > only be taking effect if protections are set.
> 
> Agreed. If memory.{low,min} is not used then the patch should be
> effectively a nop.

I was staring into the code and do not see anything.  Could you give the
following debugging patch a try and see whether it triggers?

diff --git a/mm/vmscan.c b/mm/vmscan.c
index cc555903a332..df2e8df0eb71 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -2404,6 +2404,8 @@ static void get_scan_count(struct lruvec *lruvec, struct scan_control *sc,
 			 * sc->priority further than desirable.
 			 */
 			scan = max(scan, SWAP_CLUSTER_MAX);
+
+			trace_printk("scan:%lu protection:%lu\n", scan, protection);
 		} else {
 			scan = lruvec_size;
 		}
@@ -2648,6 +2650,7 @@ static void shrink_node_memcgs(pg_data_t *pgdat, struct scan_control *sc)
 		mem_cgroup_calculate_protection(target_memcg, memcg);
 
 		if (mem_cgroup_below_min(memcg)) {
+			trace_printk("under min:%lu emin:%lu\n", memcg->memory.min, memcg->memory.emin);
 			/*
 			 * Hard protection.
 			 * If there is no reclaimable memory, OOM.
@@ -2660,6 +2663,7 @@ static void shrink_node_memcgs(pg_data_t *pgdat, struct scan_control *sc)
 			 * there is an unprotected supply
 			 * of reclaimable memory from other cgroups.
 			 */
+			trace_printk("under low:%lu elow:%lu\n", memcg->memory.low, memcg->memory.elow);
 			if (!sc->memcg_low_reclaim) {
 				sc->memcg_low_skipped = 1;
 				continue;
-- 
Michal Hocko
SUSE Labs
