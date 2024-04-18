Return-Path: <cgroups+bounces-2584-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1371F8A99F2
	for <lists+cgroups@lfdr.de>; Thu, 18 Apr 2024 14:36:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C465C282FCA
	for <lists+cgroups@lfdr.de>; Thu, 18 Apr 2024 12:36:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5BED1EA91;
	Thu, 18 Apr 2024 12:36:49 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB4C11DA26;
	Thu, 18 Apr 2024 12:36:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713443809; cv=none; b=u61AClSL4I8nd7Z0gzPpNL5fEmAmvA1ugTDnRI1jKDHwMbtxmaijmuZExxbZh3j9aS4Fj7+MZsdd41St95nqgsBSZgTcDRh6yVtz5TJ1rrJ0RyTgzbv17lNgvUcCQ01DRixOjM1W/0u41nynn/+TRemuoULu6PCz4C5lwUpML94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713443809; c=relaxed/simple;
	bh=3YUauoGbeJ5ZxfusdnLISD6V1rVbaD0VMA4lUVm8NDU=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=PRbuY3HpWwtH+w2Ira+Iw8pFVrs9Sy9LB8PsVWVH6P1wKuZ+6OXfay8Wf99m1Wn9wVj0FGPgGNRLzzZcNJNqLIRDvB54JJNYNxAHfNj/6HECFlRctscU9GXzkbQ9pu6dKB9Szgj2t7/MOFGB+DqADkeAIOjkkvQV2a0dFGiJ4RA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.48])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4VKxzT4Q43zNnwl;
	Thu, 18 Apr 2024 20:34:13 +0800 (CST)
Received: from dggpeml500023.china.huawei.com (unknown [7.185.36.114])
	by mail.maildlp.com (Postfix) with ESMTPS id 8908418006B;
	Thu, 18 Apr 2024 20:36:38 +0800 (CST)
Received: from hulk-vt.huawei.com (10.67.174.26) by
 dggpeml500023.china.huawei.com (7.185.36.114) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 18 Apr 2024 20:36:38 +0800
From: Xiu Jianfeng <xiujianfeng@huawei.com>
To: <tj@kernel.org>, <lizefan.x@bytedance.com>, <hannes@cmpxchg.org>,
	<corbet@lwn.net>
CC: <cgroups@vger.kernel.org>, <linux-doc@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH -next] docs, cgroup: add entries for pids to cgroup-v2.rst
Date: Thu, 18 Apr 2024 12:30:12 +0000
Message-ID: <20240418123012.916411-1-xiujianfeng@huawei.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpeml500023.china.huawei.com (7.185.36.114)

This patch add two entries (pids.peak and pids.events) for pids
controller, and also update pids.current because it's on non-root.

Signed-off-by: Xiu Jianfeng <xiujianfeng@huawei.com>
---
 Documentation/admin-guide/cgroup-v2.rst | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/Documentation/admin-guide/cgroup-v2.rst b/Documentation/admin-guide/cgroup-v2.rst
index d8b00f0ea96d..6f6fe744452e 100644
--- a/Documentation/admin-guide/cgroup-v2.rst
+++ b/Documentation/admin-guide/cgroup-v2.rst
@@ -2188,11 +2188,25 @@ PID Interface Files
 	Hard limit of number of processes.
 
   pids.current
-	A read-only single value file which exists on all cgroups.
+	A read-only single value file which exists on non-root cgroups.
 
 	The number of processes currently in the cgroup and its
 	descendants.
 
+  pids.peak
+	A read-only single value file which exists on non-root cgroups.
+
+	The maximum value that the number of processes in the cgroup and its
+	descendants has ever reached.
+
+  pids.events
+	A read-only flat-keyed file which exists on non-root cgroups. The
+	following entries are defined. Unless specified otherwise, a value
+	change in this file generates a file modified event.
+
+	  max
+		Number of times fork failed because limit was hit.
+
 Organisational operations are not blocked by cgroup policies, so it is
 possible to have pids.current > pids.max.  This can be done by either
 setting the limit to be smaller than pids.current, or attaching enough
-- 
2.34.1


