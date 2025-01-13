Return-Path: <cgroups+bounces-6097-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 52163A0AD16
	for <lists+cgroups@lfdr.de>; Mon, 13 Jan 2025 02:06:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 56FAB3A6E0A
	for <lists+cgroups@lfdr.de>; Mon, 13 Jan 2025 01:05:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B61612E5B;
	Mon, 13 Jan 2025 01:05:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="cfSy0Jb/"
X-Original-To: cgroups@vger.kernel.org
Received: from esa4.hc1455-7.c3s2.iphmx.com (esa4.hc1455-7.c3s2.iphmx.com [68.232.139.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10E38BA4B;
	Mon, 13 Jan 2025 01:05:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.139.117
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736730345; cv=none; b=kGhzXJE8EqK/h13kcQlB6mPoQGnYBRnsvXxB5ph5tZ3PCk3inALy5t0eorKhKbcuqIqDzm6X9sXVq4kt6k/3wEVaEWh15KuSlmzquZjAbA8ro3BZ6A8anCXCS79gm2YJb6KgMx28d4I1ZbVTWozHzmzKvgN0DCo9lEd/Dac2aNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736730345; c=relaxed/simple;
	bh=zTaa8HYhR0T7JXfkAWwzg0rqsHYC2A2po9SaveVras4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KUwzG1m4sEOHcjz+3fvD3ALyBUXqDFHdggPtE57jOhImUKk0YAi4G3WMKiBi/ZRTZoycJLYlZRHiG8pKyHsXOhvqZbPu7ourM0jXtcKuFCRuV3ZP30sobVS31YWT8fONmAhEsEJmuDZkIXbZP7rxDM3tpoEOTgAkgA/gB0cYprY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=cfSy0Jb/; arc=none smtp.client-ip=68.232.139.117
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
  t=1736730343; x=1768266343;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=zTaa8HYhR0T7JXfkAWwzg0rqsHYC2A2po9SaveVras4=;
  b=cfSy0Jb/Ee24+vgyCU/R/YWieZ7TCx8Z+CA9PhnMzdLS65b64ezhpH4i
   /P9WTWb5MIrCaX57XdyQtNb1hytaNIPKFYaBgVTvbHJmZ0ijhUm4defn3
   nUwZ+b9TostSsDWGPQTLdELu9XFLutU2Qf7eRFN1fUSw7DuipcqXKzEhM
   GX19YM37IOagY92b3oYSVMJbeINvbbth7Peb7HqjEBcxxym72UY/4BOBy
   RQ3/cGuv0VH0jdDTfOmBrVk6z7yK5NZZaCuxZL+Wf/uQMHUIyxOOMasQb
   tl65PQYtFaSnmedRTq4hVdRVCZT/I92ctSAOU2eC83+xkTdcg05rhD5gS
   g==;
X-CSE-ConnectionGUID: /AyguDavRsmIkpZyA+B5DQ==
X-CSE-MsgGUID: LHsmP4SzQHWZdUvR7Z48fA==
X-IronPort-AV: E=McAfee;i="6700,10204,11313"; a="186564847"
X-IronPort-AV: E=Sophos;i="6.12,310,1728918000"; 
   d="scan'208";a="186564847"
Received: from unknown (HELO oym-r4.gw.nic.fujitsu.com) ([210.162.30.92])
  by esa4.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2025 10:04:30 +0900
Received: from oym-m1.gw.nic.fujitsu.com (oym-nat-oym-m1.gw.nic.fujitsu.com [192.168.87.58])
	by oym-r4.gw.nic.fujitsu.com (Postfix) with ESMTP id 5EC57DE677;
	Mon, 13 Jan 2025 10:04:28 +0900 (JST)
Received: from kws-ab3.gw.nic.fujitsu.com (kws-ab3.gw.nic.fujitsu.com [192.51.206.21])
	by oym-m1.gw.nic.fujitsu.com (Postfix) with ESMTP id 2E038D4F41;
	Mon, 13 Jan 2025 10:04:28 +0900 (JST)
Received: from edo.cn.fujitsu.com (edo.cn.fujitsu.com [10.167.33.5])
	by kws-ab3.gw.nic.fujitsu.com (Postfix) with ESMTP id 98AB12007FAFE;
	Mon, 13 Jan 2025 10:04:27 +0900 (JST)
Received: from iaas-rdma.. (unknown [10.167.135.44])
	by edo.cn.fujitsu.com (Postfix) with ESMTP id 872E41A006C;
	Mon, 13 Jan 2025 09:04:26 +0800 (CST)
From: Li Zhijian <lizhijian@fujitsu.com>
To: linux-doc@vger.kernel.org
Cc: Tejun Heo <tj@kernel.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	mkoutny@suse.com,
	Jonathan Corbet <corbet@lwn.net>,
	cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Waiman Long <llong@redhat.com>,
	Li Zhijian <lizhijian@fujitsu.com>
Subject: [PATCH v2] Documentation/cgroup-v2: Update memory.{stat,numa_stat} description to reflect possible units
Date: Mon, 13 Jan 2025 09:05:30 +0800
Message-ID: <20250113010530.432396-1-lizhijian@fujitsu.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20250110123019.423725-1-lizhijian@fujitsu.com>
References: <20250110123019.423725-1-lizhijian@fujitsu.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSS-9.1.0.1417-9.0.0.1002-28920.004
X-TM-AS-User-Approved-Sender: Yes
X-TMASE-Version: IMSS-9.1.0.1417-9.0.1002-28920.004
X-TMASE-Result: 10--8.417900-10.000000
X-TMASE-MatchedRID: Wu7mvlVj+42gOUOBLqPMtLPx3rO+jk2QK2GKtdiFmTkKo7vFXsOIEjBy
	UyUcWgBxs2pATm9V9PxUdjhO4CbFI+BRuAss+FbmEXjPIvKd74BMkOX0UoduufJdr/uA7ez9G/C
	T7CSpnL2C9g3+dE2CC++zkoobd8qBr78SC5iivxwURSScn+QSXt0H8LFZNFG7bkV4e2xSge6bCT
	BZ/aKW2AzIND4/GH2mtrCLkQaGGdYCjGN0tulMiRyFdNnda6Rv
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0

The description of the memory.{stat,numa_stat} file has been updated to
clarify that the output values can be in bytes or pages.
This change ensures that users are aware that the unit of measurement for
memory values can vary and should be verified by consulting the memory.stat

It's known that
workingset_*, pg* are counted in pages

Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>a
---
V2: updated the document as suggestion from Michal
    updated subject and commit log
---
 Documentation/admin-guide/cgroup-v2.rst | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/Documentation/admin-guide/cgroup-v2.rst b/Documentation/admin-guide/cgroup-v2.rst
index 315ede811c9d..0a43be0c32d1 100644
--- a/Documentation/admin-guide/cgroup-v2.rst
+++ b/Documentation/admin-guide/cgroup-v2.rst
@@ -1427,7 +1427,7 @@ The following nested keys are defined.
 	types of memory, type-specific details, and other information
 	on the state and past events of the memory management system.
 
-	All memory amounts are in bytes.
+	All memory amounts are in bytes unless said otherwise.
 
 	The entries are ordered to be human readable, and new entries
 	can show up in the middle. Don't rely on items remaining in a
@@ -1673,11 +1673,12 @@ The following nested keys are defined.
 	application performance by combining this information with the
 	application's CPU allocation.
 
-	All memory amounts are in bytes.
-
 	The output format of memory.numa_stat is::
 
-	  type N0=<bytes in node 0> N1=<bytes in node 1> ...
+	  type N0=<value for node 0> N1=<value for node 1> ...
+
+        The 'value' can be in bytes or pages, depending on the specific
+        type of memory. To determine the unit, refer to the memory.stat.
 
 	The entries are ordered to be human readable, and new entries
 	can show up in the middle. Don't rely on items remaining in a
-- 
2.44.0


