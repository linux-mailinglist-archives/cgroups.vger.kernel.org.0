Return-Path: <cgroups+bounces-9768-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id F001EB46899
	for <lists+cgroups@lfdr.de>; Sat,  6 Sep 2025 05:21:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A52F24E2B68
	for <lists+cgroups@lfdr.de>; Sat,  6 Sep 2025 03:21:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7F5822DFA3;
	Sat,  6 Sep 2025 03:21:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="nPOx88R7"
X-Original-To: cgroups@vger.kernel.org
Received: from pdx-out-004.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-004.esa.us-west-2.outbound.mail-perimeter.amazon.com [44.246.77.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 348261DF254;
	Sat,  6 Sep 2025 03:21:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=44.246.77.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757128893; cv=none; b=QTESUo+f3c+t5x++qYs+uFcszV8N/+V4+roq6a48aY4GYE8DEj9OVjmlaoF4owJPxYnVTXRpp7cIXcvRdoRdyBEkmfs7z3jLTeHEtW8vuBMQQvj+UH5KyBmwlfxHxLuEM6qPgezZLIjY04y6xyRFAnd8edgkHdRv7fFR36F2k6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757128893; c=relaxed/simple;
	bh=s4izz7yW2A8+7kei3XaTuO0t+LSTxvUOtCOyHgmNYuE=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=MOWBN+KE5NmNM2rGPUR385XlWv9xEVd3t1YWi9z2lSTVufVOBtdHrPSuzQvvYwZF9TM7uaaSsbIFShVvL+tt4jZ0rYH34su8faf8282LYa/l+lY8+07JxkLKcIKCDWExAcDhTxn1oGzPI5FrOlf6lfophNzN12Sluz17Tjghv6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=nPOx88R7; arc=none smtp.client-ip=44.246.77.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1757128892; x=1788664892;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=ukV1P46xm4LSs6P9dPGvdjimOnGmu5wrUw+EGUHyxAE=;
  b=nPOx88R7xmye1MYC0TOlNT739TuYt6I8gknMHVpGtGGQYErQsm9Wwl5V
   3rSW1nh4QPynrILpQp1MmBf5MRX7yF/yc0p35xMG1HwRKEzVHff3GczlX
   9E2wxWUgW1fDaOU2sDUm2obS7XJcupyy9GQxQbC4NPxknzxhYseRgL7Ae
   uLvuZonEZGqAQf1LbJAEwZbykCswU4uBTeGv8t1RkqTcQ2ajMor/pDksp
   CJ4cvR+JfTdxOo7E0D9ZxcoSnz15oHzFgdFYN7n5/kLR5nkr1UGUEITnM
   0irbee8/nFtls8/MSjougIsMDbA3drCBOCeNTqhbj3mZ46IQzowG2RXaI
   A==;
X-CSE-ConnectionGUID: 0UUPTMG0Q8e/TgRO3JA41g==
X-CSE-MsgGUID: zGTnETyJT0+2svpF8rOm2Q==
X-IronPort-AV: E=Sophos;i="6.18,243,1751241600"; 
   d="scan'208";a="2522412"
Received: from ip-10-5-6-203.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.6.203])
  by internal-pdx-out-004.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Sep 2025 03:21:31 +0000
Received: from EX19MTAUWB002.ant.amazon.com [10.0.21.151:28382]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.63.19:2525] with esmtp (Farcaster)
 id ff3684f7-82cf-4557-bb86-378b3641385d; Sat, 6 Sep 2025 03:21:31 +0000 (UTC)
X-Farcaster-Flow-ID: ff3684f7-82cf-4557-bb86-378b3641385d
Received: from EX19D032UWA001.ant.amazon.com (10.13.139.62) by
 EX19MTAUWB002.ant.amazon.com (10.250.64.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.20;
 Sat, 6 Sep 2025 03:21:31 +0000
Received: from dev-dsk-ajgja-2a-6a9b5603.us-west-2.amazon.com (172.22.68.79)
 by EX19D032UWA001.ant.amazon.com (10.13.139.62) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.20;
 Sat, 6 Sep 2025 03:21:30 +0000
From: Andrew Guerrero <ajgja@amazon.com>
To: <cgroups@vger.kernel.org>, <linux-mm@kvack.org>,
	<linux-kernel@vger.kernel.org>
CC: <hannes@cmpxchg.org>, <mhocko@kernel.org>, <vdavydov.dev@gmail.com>,
	<akpm@linux-foundation.org>, <shakeelb@google.com>, <guro@fb.com>,
	<gunnarku@amazon.com>, <stable@vger.kernel.org>
Subject: [PATCH] mm: memcontrol: fix memcg accounting during cpu hotplug
Date: Sat, 6 Sep 2025 03:21:08 +0000
Message-ID: <20250906032108.30539-1-ajgja@amazon.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D037UWC004.ant.amazon.com (10.13.139.254) To
 EX19D032UWA001.ant.amazon.com (10.13.139.62)

A filesystem writeback performance issue was discovered by repeatedly
running CPU hotplug operations while a process in a cgroup with memory
and io controllers enabled wrote to an ext4 file in a loop.

When a CPU is offlined, the memcg_hotplug_cpu_dead() callback function
flushes per-cpu vmstats counters. However, instead of applying a per-cpu
counter once to each cgroup in the heirarchy, the per-cpu counter is
applied repeatedly just to the nested cgroup. Under certain conditions,
the per-cpu NR_FILE_DIRTY counter is routinely positive during hotplug
events and the dirty file count artifically inflates. Once the dirty
file count grows past the dirty_freerun_ceiling(), balance_dirty_pages()
starts a backgroup writeback each time a file page is marked dirty
within the nested cgroup.

This change fixes memcg_hotplug_cpu_dead() so that the per-cpu vmstats
and vmevents counters are applied once to each cgroup in the heirarchy,
similar to __mod_memcg_state() and __count_memcg_events().

Fixes: 42a300353577 ("mm: memcontrol: fix recursive statistics correctness & scalabilty")
Signed-off-by: Andrew Guerrero <ajgja@amazon.com>
Reviewed-by: Gunnar Kudrjavets <gunnarku@amazon.com>
---
Hey all,

This patch is intended for the 5.10 longterm release branch. It will not apply
cleanly to mainline and is inadvertantly fixed by a larger series of changes in 
later release branches:
a3d4c05a4474 ("mm: memcontrol: fix cpuhotplug statistics flushing").

In 5.15, the counter flushing code is completely removed. This may be another
viable option here too, though it's a larger change.

Thanks!
---
 mm/memcontrol.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 142b4d5e08fe..8e085a4f45b7 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -2394,7 +2394,7 @@ static int memcg_hotplug_cpu_dead(unsigned int cpu)
 			x = this_cpu_xchg(memcg->vmstats_percpu->stat[i], 0);
 			if (x)
 				for (mi = memcg; mi; mi = parent_mem_cgroup(mi))
-					atomic_long_add(x, &memcg->vmstats[i]);
+					atomic_long_add(x, &mi->vmstats[i]);
 
 			if (i >= NR_VM_NODE_STAT_ITEMS)
 				continue;
@@ -2417,7 +2417,7 @@ static int memcg_hotplug_cpu_dead(unsigned int cpu)
 			x = this_cpu_xchg(memcg->vmstats_percpu->events[i], 0);
 			if (x)
 				for (mi = memcg; mi; mi = parent_mem_cgroup(mi))
-					atomic_long_add(x, &memcg->vmevents[i]);
+					atomic_long_add(x, &mi->vmevents[i]);
 		}
 	}
 

base-commit: c30b4019ea89633d790f0bfcbb03234f0d006f87
-- 
2.47.3


