Return-Path: <cgroups+bounces-3322-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 84C44915B50
	for <lists+cgroups@lfdr.de>; Tue, 25 Jun 2024 02:59:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A3C48B20D58
	for <lists+cgroups@lfdr.de>; Tue, 25 Jun 2024 00:59:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FE8B17557;
	Tue, 25 Jun 2024 00:59:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="SNHEm2mO"
X-Original-To: cgroups@vger.kernel.org
Received: from out-175.mta0.migadu.com (out-175.mta0.migadu.com [91.218.175.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1984CA64
	for <cgroups@vger.kernel.org>; Tue, 25 Jun 2024 00:59:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719277173; cv=none; b=aHo01dVBYPrxXKu7P7haq6tREhhpi2OloQYfyO8wDzds5RO+OUbJPW7Fcl93ffkOu9+kAjxIHdcUngLuuThCY1uEFqIj9oXfC5lBVzxGzFiJC4e3z/1WlAHdvopqdxwkzljhH7LA4fbef4Qbj/xP2FuYj+TXU6FswyJFHL/q8i0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719277173; c=relaxed/simple;
	bh=BGTJ8UpPpJFLnys7Cpb4hZmQmB4cDSMfeLSWQtRFwrs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=shrNGIdEYRAB19JVJB06/sfoWtASnXqcYsXvGrUGNFocZ9MEQimwo0k/MNlYalBHzHAfObtXGdKShFq6CiWgRllYuPxwilEi1ZiiSUb4DGofYCgSs8tpuMIh8IkZeHLbxbsLbcQkdE2z/+WV21hvOoKGNoRJv8ps/0IFetBzIrk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=SNHEm2mO; arc=none smtp.client-ip=91.218.175.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: akpm@linux-foundation.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1719277168;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0K8TiASsfXHI+86AZ2a2bPWGqGFFcRCb/gQyRRUpsu8=;
	b=SNHEm2mO/2MBhZOMRXB4XkfaEiY2p+h8mD8OBd4U1zfPiQ3BuKoVwWbf2ski/Cc+TvOfxT
	QpO01xxRyLiHWa3dG3T+27zaWcaG96hCPF5P1nHpIMrWd4l1kPGh8RycYujNQQJUiVPl5+
	uPIKcwxBcy2hngodxGz3SoUlayh91Iw=
X-Envelope-To: hannes@cmpxchg.org
X-Envelope-To: mhocko@kernel.org
X-Envelope-To: shakeel.butt@linux.dev
X-Envelope-To: muchun.song@linux.dev
X-Envelope-To: linux-kernel@vger.kernel.org
X-Envelope-To: cgroups@vger.kernel.org
X-Envelope-To: linux-mm@kvack.org
X-Envelope-To: roman.gushchin@linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Roman Gushchin <roman.gushchin@linux.dev>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Johannes Weiner <hannes@cmpxchg.org>,
	Michal Hocko <mhocko@kernel.org>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Muchun Song <muchun.song@linux.dev>,
	linux-kernel@vger.kernel.org,
	cgroups@vger.kernel.org,
	linux-mm@kvack.org,
	Roman Gushchin <roman.gushchin@linux.dev>
Subject: [PATCH v2 01/14] mm: memcg: introduce memcontrol-v1.c
Date: Mon, 24 Jun 2024 17:58:53 -0700
Message-ID: <20240625005906.106920-2-roman.gushchin@linux.dev>
In-Reply-To: <20240625005906.106920-1-roman.gushchin@linux.dev>
References: <20240625005906.106920-1-roman.gushchin@linux.dev>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

This patch introduces the mm/memcontrol-v1.c source file which will be used for
all legacy (cgroup v1) memory cgroup code. It also introduces mm/memcontrol-v1.h
to keep declarations shared between mm/memcontrol.c and mm/memcontrol-v1.c.

As of now, let's compile it if CONFIG_MEMCG is set, similar to mm/memcontrol.c.
Later on it can be switched to use a separate config option, so that the legacy
code won't be compiled if not required.

Signed-off-by: Roman Gushchin <roman.gushchin@linux.dev>
---
 mm/Makefile        | 3 ++-
 mm/memcontrol-v1.c | 3 +++
 mm/memcontrol-v1.h | 7 +++++++
 3 files changed, 12 insertions(+), 1 deletion(-)
 create mode 100644 mm/memcontrol-v1.c
 create mode 100644 mm/memcontrol-v1.h

diff --git a/mm/Makefile b/mm/Makefile
index 8fb85acda1b1..124d4dea2035 100644
--- a/mm/Makefile
+++ b/mm/Makefile
@@ -26,6 +26,7 @@ KCOV_INSTRUMENT_page_alloc.o := n
 KCOV_INSTRUMENT_debug-pagealloc.o := n
 KCOV_INSTRUMENT_kmemleak.o := n
 KCOV_INSTRUMENT_memcontrol.o := n
+KCOV_INSTRUMENT_memcontrol-v1.o := n
 KCOV_INSTRUMENT_mmzone.o := n
 KCOV_INSTRUMENT_vmstat.o := n
 KCOV_INSTRUMENT_failslab.o := n
@@ -95,7 +96,7 @@ obj-$(CONFIG_NUMA) += memory-tiers.o
 obj-$(CONFIG_DEVICE_MIGRATION) += migrate_device.o
 obj-$(CONFIG_TRANSPARENT_HUGEPAGE) += huge_memory.o khugepaged.o
 obj-$(CONFIG_PAGE_COUNTER) += page_counter.o
-obj-$(CONFIG_MEMCG) += memcontrol.o vmpressure.o
+obj-$(CONFIG_MEMCG) += memcontrol.o memcontrol-v1.o vmpressure.o
 ifdef CONFIG_SWAP
 obj-$(CONFIG_MEMCG) += swap_cgroup.o
 endif
diff --git a/mm/memcontrol-v1.c b/mm/memcontrol-v1.c
new file mode 100644
index 000000000000..a941446ba575
--- /dev/null
+++ b/mm/memcontrol-v1.c
@@ -0,0 +1,3 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+
+#include "memcontrol-v1.h"
diff --git a/mm/memcontrol-v1.h b/mm/memcontrol-v1.h
new file mode 100644
index 000000000000..7c5f094755ff
--- /dev/null
+++ b/mm/memcontrol-v1.h
@@ -0,0 +1,7 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+
+#ifndef __MM_MEMCONTROL_V1_H
+#define __MM_MEMCONTROL_V1_H
+
+
+#endif	/* __MM_MEMCONTROL_V1_H */
-- 
2.45.2


