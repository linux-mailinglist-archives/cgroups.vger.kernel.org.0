Return-Path: <cgroups+bounces-6086-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CCB12A09074
	for <lists+cgroups@lfdr.de>; Fri, 10 Jan 2025 13:32:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9EAF9164546
	for <lists+cgroups@lfdr.de>; Fri, 10 Jan 2025 12:32:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8F6420D50C;
	Fri, 10 Jan 2025 12:29:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="KTkpg0zT"
X-Original-To: cgroups@vger.kernel.org
Received: from esa10.hc1455-7.c3s2.iphmx.com (esa10.hc1455-7.c3s2.iphmx.com [139.138.36.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 898DC20D4F7;
	Fri, 10 Jan 2025 12:29:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=139.138.36.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736512175; cv=none; b=M8YRKhjGoUkugSrL164KTGi9EQfss5ScCSnCDMiiIRW5Zh94HnDrm2A3dJwWGP4DhYmwpb+bJ7KqfznK86kL02A7WDKgB2Gu4dRQsJwg2Ahw+VOKf/fN80KKgQC29osgWZPVbjRA9BQsjmmDJj+IA5GZLNqQq5f3yyyxu0N01A0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736512175; c=relaxed/simple;
	bh=lCOchsCcSRvNCiXrD4uJhCOB3/weni28KEmIqfS0Lt8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=e1hVUYQvNGNO3/+/OIBy4ngvIZwTTRjJ6r9/Su8tnF51JlPFSqtRJe11EMRFsSKdxTW5o45xVowesxDG45O5NhrSLpYvJWQVdrmMRnHe5alHLZtwu3arrAT79vfYqx4Ft2OzSL8mEVQ1Cm/u+Huy53ax0SpuPIQ9ul9yLQs1s3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=KTkpg0zT; arc=none smtp.client-ip=139.138.36.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
  t=1736512173; x=1768048173;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=lCOchsCcSRvNCiXrD4uJhCOB3/weni28KEmIqfS0Lt8=;
  b=KTkpg0zTl2AgVVeBBJNNX/wJYT1hSwalOr7CloM8CzL6VVZGSYI8tjk0
   7x005zlw4grwWLcZtfASepQXFpTbJSPJGi4tUVlPL8Trtbl0TOwR1fQbe
   NmF0gnK90qb3kYQ4lJXefIAuW3vnLNpMvKMuKtW+6rkHVA9l5ef99C0nO
   Pny0TQbVVaF18gXDLhyCKxHbdA6NRYITs/wWwvufok1BL0XB6rvjnma1L
   x4WHIZOmd9VdmU2y8rGJJIy0V/JhVjjQacT/PUj2UnDbeegZ9XCX0JgKa
   ve7qVxw8UgYJg7uzNn2jkNB/eVutLPozFi8xjWXsgRGvh6pNIzABUyI4O
   g==;
X-CSE-ConnectionGUID: We2fsczjTfmHAkkBSJQHvw==
X-CSE-MsgGUID: ayCZOc63TRqbu2HhM+385g==
X-IronPort-AV: E=McAfee;i="6700,10204,11311"; a="173535461"
X-IronPort-AV: E=Sophos;i="6.12,303,1728918000"; 
   d="scan'208";a="173535461"
Received: from unknown (HELO yto-r1.gw.nic.fujitsu.com) ([218.44.52.217])
  by esa10.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jan 2025 21:29:24 +0900
Received: from yto-m3.gw.nic.fujitsu.com (yto-nat-yto-m3.gw.nic.fujitsu.com [192.168.83.66])
	by yto-r1.gw.nic.fujitsu.com (Postfix) with ESMTP id 1D9ECD6EA9;
	Fri, 10 Jan 2025 21:29:23 +0900 (JST)
Received: from kws-ab3.gw.nic.fujitsu.com (kws-ab3.gw.nic.fujitsu.com [192.51.206.21])
	by yto-m3.gw.nic.fujitsu.com (Postfix) with ESMTP id E01D610362;
	Fri, 10 Jan 2025 21:29:22 +0900 (JST)
Received: from edo.cn.fujitsu.com (edo.cn.fujitsu.com [10.167.33.5])
	by kws-ab3.gw.nic.fujitsu.com (Postfix) with ESMTP id 6D7E1202C3CBB;
	Fri, 10 Jan 2025 21:29:22 +0900 (JST)
Received: from iaas-rdma.. (unknown [10.167.135.44])
	by edo.cn.fujitsu.com (Postfix) with ESMTP id 69ADB1A000B;
	Fri, 10 Jan 2025 20:29:21 +0800 (CST)
From: Li Zhijian <lizhijian@fujitsu.com>
To: linux-doc@vger.kernel.org
Cc: Tejun Heo <tj@kernel.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	mkoutny@suse.com,
	Jonathan Corbet <corbet@lwn.net>,
	cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Li Zhijian <lizhijian@fujitsu.com>
Subject: [PATCH] Documentation/cgroup-v2: Update memory.numa_stat description to reflect possible units
Date: Fri, 10 Jan 2025 20:30:19 +0800
Message-ID: <20250110123019.423725-1-lizhijian@fujitsu.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSS-9.1.0.1417-9.0.0.1002-28914.007
X-TM-AS-User-Approved-Sender: Yes
X-TMASE-Version: IMSS-9.1.0.1417-9.0.1002-28914.007
X-TMASE-Result: 10--4.161800-10.000000
X-TMASE-MatchedRID: v+sphrBU45GgOUOBLqPMtLPx3rO+jk2QK2GKtdiFmTnVjNsehGf0vb8F
	Hrw7frluf146W0iUu2tUmZgXoV1CCxTfVlVWxWRBxvp0tuDMx3l9LQinZ4QefCP/VFuTOXUTC5M
	umjkcRzWOhzOa6g8KrW3ALrb2ZTUcsGc/8dUNSsWCTTZ5QyGVyETZPqz6c0Gny6LvC6Dn+51Zim
	nmYhta94salhnTWXtbvvbbTLm8c7HVmqyAbNs4LBXBt/mUREyAj/ZFF9Wfm7hNy7ppG0IjcFQqk
	0j7vLVUewMSBDreIdk=
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0

The description of the memory.numa_stat file has been updated to clarify
that the output values can be in bytes or pages. This change ensures that
users are aware that the unit of measurement for memory values can vary
and should be verified by consulting the memory.stat

It's known that
workingset_*, pgdemote_* and pgpromote_success are counted in pages

Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>
---
 Documentation/admin-guide/cgroup-v2.rst | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/Documentation/admin-guide/cgroup-v2.rst b/Documentation/admin-guide/cgroup-v2.rst
index 315ede811c9d..5d1d44547409 100644
--- a/Documentation/admin-guide/cgroup-v2.rst
+++ b/Documentation/admin-guide/cgroup-v2.rst
@@ -1427,7 +1427,7 @@ The following nested keys are defined.
 	types of memory, type-specific details, and other information
 	on the state and past events of the memory management system.
 
-	All memory amounts are in bytes.
+	All memory amounts are in bytes or bytes.
 
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


