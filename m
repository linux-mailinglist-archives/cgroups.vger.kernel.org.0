Return-Path: <cgroups+bounces-10321-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D0C5AB8DD3D
	for <lists+cgroups@lfdr.de>; Sun, 21 Sep 2025 17:15:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AA2F43ACEC2
	for <lists+cgroups@lfdr.de>; Sun, 21 Sep 2025 15:15:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D84203D544;
	Sun, 21 Sep 2025 15:15:28 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [160.30.148.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D4BD6FC3;
	Sun, 21 Sep 2025 15:15:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=160.30.148.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758467728; cv=none; b=VI+5MtRwTDWWtSxt3l1mlyDlMqmGC1zoV5QGJpLH7VOoBrB0ClL9sFGJj0nJJ2Y+mUE8gskb7qkaqT76SLgIUgiTAD/w4oMU150wDMIJoSXsOiSh8cVC2TWs1zf+4wPRSFvuYcnFPvc6+b6nBhyIgvvdWr5xTyb7ZcIHeUyVi14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758467728; c=relaxed/simple;
	bh=jdkC5I1ywmOk+XVUobrz8tW9x5D6SlXX/o0ckoJqeYY=;
	h=Date:Message-ID:In-Reply-To:References:Mime-Version:From:To:Cc:
	 Subject:Content-Type; b=M8V/hAv4g/SemWqskBy5ccfh+6cBRfABOzLZt8utAqPH1pEELBap7ezdNsCi9c7fBzfepXVHI5e3D0+yVqZ5yMHpYpk+YL9Bz0XxngLGg72Lx2NsdRP59AgMDPydsuW83iXLHJHlv52bqKWK1d1gHrxf8kgY/aeb8Wodm0t15W4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn; spf=pass smtp.mailfrom=zte.com.cn; arc=none smtp.client-ip=160.30.148.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zte.com.cn
Received: from mse-fl1.zte.com.cn (unknown [10.5.228.132])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mxhk.zte.com.cn (FangMail) with ESMTPS id 4cV8v10dxDz5PM35;
	Sun, 21 Sep 2025 23:15:25 +0800 (CST)
Received: from xaxapp02.zte.com.cn ([10.88.97.241])
	by mse-fl1.zte.com.cn with SMTP id 58LFFFLK072474;
	Sun, 21 Sep 2025 23:15:15 +0800 (+08)
	(envelope-from xu.xin16@zte.com.cn)
Received: from mapi (xaxapp02[null])
	by mapi (Zmail) with MAPI id mid32;
	Sun, 21 Sep 2025 23:15:18 +0800 (CST)
Date: Sun, 21 Sep 2025 23:15:18 +0800 (CST)
X-Zmail-TransId: 2afa68d01686f1c-20a97
X-Mailer: Zmail v1.0
Message-ID: <202509212315188885yTwMVyN-Xn_6tuRc3Zi7@zte.com.cn>
In-Reply-To: <20250921230726978agBBWNsPLi2hCp9Sxed1Y@zte.com.cn>
References: 20250921230726978agBBWNsPLi2hCp9Sxed1Y@zte.com.cn
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
From: <xu.xin16@zte.com.cn>
To: <xu.xin16@zte.com.cn>, <akpm@linux-foundation.org>
Cc: <shakeel.butt@linux.dev>, <hannes@cmpxchg.org>, <mhocko@kernel.org>,
        <roman.gushchin@linux.dev>, <david@redhat.com>,
        <chengming.zhou@linux.dev>, <muchun.song@linux.dev>,
        <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
        <cgroups@vger.kernel.org>
Subject: =?UTF-8?B?W1BBVENIIGxpbnV4LW5leHQgdjMgNi82XSBEb2N1bWVudGF0aW9uOiBhZGQgS1NNIHN0YXRpc3RpYyBjb3VudGVyc8KgZGVzY3JpcHRpb24=?=
Content-Type: text/plain;
	charset="UTF-8"
X-MAIL:mse-fl1.zte.com.cn 58LFFFLK072474
X-TLS: YES
X-SPF-DOMAIN: zte.com.cn
X-ENVELOPE-SENDER: xu.xin16@zte.com.cn
X-SPF: None
X-SOURCE-IP: 10.5.228.132 unknown Sun, 21 Sep 2025 23:15:25 +0800
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 68D0168D.000/4cV8v10dxDz5PM35

From: xu xin <xu.xin16@zte.com.cn>
This add KSM-related statistic counters description in cgroup-v2.rst,
including "ksm_rmap_items", "ksm_zero_pages", "ksm_merging_pages" and
"ksm_profit".

Signed-off-by: xu xin <xu.xin16@zte.com.cn>
---
 Documentation/admin-guide/cgroup-v2.rst | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/Documentation/admin-guide/cgroup-v2.rst b/Documentation/admin-guide/cgroup-v2.rst
index a1e3d431974c..c8c4faa4e3fd 100644
--- a/Documentation/admin-guide/cgroup-v2.rst
+++ b/Documentation/admin-guide/cgroup-v2.rst
@@ -1776,6 +1776,23 @@ The following nested keys are defined.
 		up if hugetlb usage is accounted for in memory.current (i.e.
 		cgroup is mounted with the memory_hugetlb_accounting option).

+	  ksm_rmap_items
+		Number of ksm_rmap_item structures in use. The structure
+		ksm_rmap_item stores the reverse mapping information for virtual
+		addresses.  KSM will generate a ksm_rmap_item for each
+		ksm-scanned page of the process.
+
+	  ksm_zero_pages
+		Number of empty pages are merged with kernel zero pages by KSM,
+		which is only useful when /sys/kernel/mm/ksm/use_zero_pages.
+
+	  ksm_merging_pages
+		Number of pages of this process are involved in KSM merging
+		(not including ksm_zero_pages).
+
+	  ksm_profit
+		Amount of profitable memory that KSM brings (Saved bytes).
+
   memory.numa_stat
 	A read-only nested-keyed file which exists on non-root cgroups.

-- 
2.25.1

