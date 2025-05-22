Return-Path: <cgroups+bounces-8304-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C193AC024C
	for <lists+cgroups@lfdr.de>; Thu, 22 May 2025 04:09:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A3C4B3B2540
	for <lists+cgroups@lfdr.de>; Thu, 22 May 2025 02:08:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2238913B293;
	Thu, 22 May 2025 02:08:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sony.com header.i=@sony.com header.b="X/BbIOCB"
X-Original-To: cgroups@vger.kernel.org
Received: from jpms-ob02.noc.sony.co.jp (jpms-ob02.noc.sony.co.jp [211.125.140.165])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF7365D8F0;
	Thu, 22 May 2025 02:08:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.125.140.165
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747879724; cv=none; b=PBAg5lUDRnDEyiPKHF7YSY+KPz38BTsmgT8h8m66xiK3a6BgdWfRQyEtlS13Tgev5yJNJc9myeQ+vyLqMFMDdHm7uyP+oAf/IYxXV4I9b9nfKSFeQNhNsdcx0/jeFWTUHXtxvEX2vz5YwaFsc6U/OAEyneZWHYVr/GYAoHpYlbs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747879724; c=relaxed/simple;
	bh=F17YJTre7W8ETwjYAoQoTHhUJ0XEXPmZDTHsHCtLFyo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=FdU0QneBzyV6lg1g12Vz892/8KIc7eAyiZmo+/tFNNmy8szAQ/zcVoxp4mO5mcw3YiZtUVYc2sb8a2Ss/kDN/hwX5jXb/Rp6PRVe28xY5z3lP1ewKSXSgrQJwz64dvg+GmMP4zxW7tQabtkeeBhSRq/6TKOq6lpFnyca60v4DaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sony.com; spf=pass smtp.mailfrom=sony.com; dkim=pass (2048-bit key) header.d=sony.com header.i=@sony.com header.b=X/BbIOCB; arc=none smtp.client-ip=211.125.140.165
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sony.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sony.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=sony.com; s=s1jp; t=1747879722; x=1779415722;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=Gl9iGIrJoqNq1g0Gx7GgNroGdFROGDZiL+YPwHC/zd8=;
  b=X/BbIOCBlGXQdVUjAAQY6qW7dw4mMU/sXYtGb6DXxy2aXHyluRlbRfuk
   EoiWToOsZGP2HTP/6MggrsJr3ZrBNjfnHGcESxO2ZPeNztHW1evd2FOnu
   c0VuSVWbLNuT7vN8UxRcHhKp4nxc6GLOux4VMwQtrSLMS87DWBoM7pNH/
   gtUyeVRj+nBSbOOtJuZ0S41W5WOP7xa2BNtB+0tI2M63sjmouN0a8dt57
   7X52ydwEwBCpT1EdfyWu6bF3ca40HC8p4P61L4ktGZbvqM8mcC71O6dxT
   f8zegEnBY0XM7Nw7P0OiCkei3QvNFpIEgXGktmNIEQavBSgttez3PkmL8
   w==;
Received: from unknown (HELO jpmta-ob1.noc.sony.co.jp) ([IPv6:2001:cf8:0:6e7::6])
  by jpms-ob02.noc.sony.co.jp with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 May 2025 11:08:37 +0900
X-IronPort-AV: E=Sophos;i="6.15,304,1739804400"; 
   d="scan'208";a="562451314"
Received: from unknown (HELO [127.0.1.1]) ([IPv6:2001:cf8:1:573:0:dddd:6b3e:119e])
  by jpmta-ob1.noc.sony.co.jp with ESMTP; 22 May 2025 11:08:37 +0900
From: Shashank Balaji <shashank.mahadasyam@sony.com>
Date: Thu, 22 May 2025 11:08:12 +0900
Subject: [PATCH v3 1/3] cgroup, docs: convert space indentation to tab
 indentation
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250522-rt-and-cpu-controller-doc-v3-1-483fc9cca591@sony.com>
References: <20250522-rt-and-cpu-controller-doc-v3-0-483fc9cca591@sony.com>
In-Reply-To: <20250522-rt-and-cpu-controller-doc-v3-0-483fc9cca591@sony.com>
To: Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>, 
 =?utf-8?q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>, 
 Jonathan Corbet <corbet@lwn.net>
Cc: cgroups@vger.kernel.org, linux-doc@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Shinya Takumi <shinya.takumi@sony.com>, 
 Shashank Balaji <shashank.mahadasyam@sony.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3179;
 i=shashank.mahadasyam@sony.com; h=from:subject:message-id;
 bh=F17YJTre7W8ETwjYAoQoTHhUJ0XEXPmZDTHsHCtLFyo=;
 b=owGbwMvMwCV2mPH4Ij++H1mMp9WSGDL02pWT7tgr1536cGZHwglDg4Nzog5tOLSp9KHGttCzO
 wvucPCu6yhlYRDjYpAVU2R5J7PuwkEry6avxxm+wcxhZQIZwsDFKQATKVdn+KfTcnLax3TJw76a
 ZaZeIevWt52c7v0zqjVceIXIlW+b171nZJh8fseEf4vvfGhJXCWz/E6HVNKhrfxKP3/fuOF6zsi
 N/SQzAA==
X-Developer-Key: i=shashank.mahadasyam@sony.com; a=openpgp;
 fpr=EE1CAED0C13A3982F5C700F6C301C7A24E0EF86A

The paragraphs on cpu.uclamp.{min,max} are space indented. Convert them to
tab indentation to make them uniform with the other paragraphs.

Signed-off-by: Shashank Balaji <shashank.mahadasyam@sony.com>
---
 Documentation/admin-guide/cgroup-v2.rst | 36 +++++++++++++++++----------------
 1 file changed, 19 insertions(+), 17 deletions(-)

diff --git a/Documentation/admin-guide/cgroup-v2.rst b/Documentation/admin-guide/cgroup-v2.rst
index 1a16ce68a4d7f6f8c9070be89c4975dbfa79077e..226fc7f9212eafcbf83c81f5b08391f215c1d894 100644
--- a/Documentation/admin-guide/cgroup-v2.rst
+++ b/Documentation/admin-guide/cgroup-v2.rst
@@ -1162,30 +1162,32 @@ All time durations are in microseconds.
 	:ref:`Documentation/accounting/psi.rst <psi>` for details.
 
   cpu.uclamp.min
-        A read-write single value file which exists on non-root cgroups.
-        The default is "0", i.e. no utilization boosting.
+	A read-write single value file which exists on non-root cgroups.
+	The default is "0", i.e. no utilization boosting.
 
-        The requested minimum utilization (protection) as a percentage
-        rational number, e.g. 12.34 for 12.34%.
+	The requested minimum utilization (protection) as a percentage
+	rational number, e.g. 12.34 for 12.34%.
 
-        This interface allows reading and setting minimum utilization clamp
-        values similar to the sched_setattr(2). This minimum utilization
-        value is used to clamp the task specific minimum utilization clamp.
+	This interface allows reading and setting minimum utilization clamp
+	values similar to the sched_setattr(2). This minimum utilization
+	value is used to clamp the task specific minimum utilization clamp,
+	including those of realtime processes.
 
-        The requested minimum utilization (protection) is always capped by
-        the current value for the maximum utilization (limit), i.e.
-        `cpu.uclamp.max`.
+	The requested minimum utilization (protection) is always capped by
+	the current value for the maximum utilization (limit), i.e.
+	`cpu.uclamp.max`.
 
   cpu.uclamp.max
-        A read-write single value file which exists on non-root cgroups.
-        The default is "max". i.e. no utilization capping
+	A read-write single value file which exists on non-root cgroups.
+	The default is "max". i.e. no utilization capping
 
-        The requested maximum utilization (limit) as a percentage rational
-        number, e.g. 98.76 for 98.76%.
+	The requested maximum utilization (limit) as a percentage rational
+	number, e.g. 98.76 for 98.76%.
 
-        This interface allows reading and setting maximum utilization clamp
-        values similar to the sched_setattr(2). This maximum utilization
-        value is used to clamp the task specific maximum utilization clamp.
+	This interface allows reading and setting maximum utilization clamp
+	values similar to the sched_setattr(2). This maximum utilization
+	value is used to clamp the task specific maximum utilization clamp,
+	including those of realtime processes.
 
   cpu.idle
 	A read-write single value file which exists on non-root cgroups.

-- 
2.43.0


