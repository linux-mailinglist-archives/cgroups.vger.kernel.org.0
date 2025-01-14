Return-Path: <cgroups+bounces-6117-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 07EBFA100D4
	for <lists+cgroups@lfdr.de>; Tue, 14 Jan 2025 07:28:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3CEA91888A53
	for <lists+cgroups@lfdr.de>; Tue, 14 Jan 2025 06:28:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85F3023497D;
	Tue, 14 Jan 2025 06:28:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="LxcYgr5I"
X-Original-To: cgroups@vger.kernel.org
Received: from out30-113.freemail.mail.aliyun.com (out30-113.freemail.mail.aliyun.com [115.124.30.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02704233522;
	Tue, 14 Jan 2025 06:28:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.113
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736836102; cv=none; b=MYHmmbqOHfUqZ4Ed8rmRtE/6Y9N7/fBYAgt8znQxGtzTzEmrD20umVMWhdZxyLzWBBq6m+5G/3sKPIrJxwElc85P4gTVsXP9BCn7HjIOLk1xtDU4aHXQsngnNPODXoQIeYQzLx2Svvt8QMigPhjm84AJh1dN7ssVyurwfJJ1p/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736836102; c=relaxed/simple;
	bh=oulMsQ0U5u/ZRyNRpgvi5yh3d7a3wSXGEyS7JxFXAUg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=SIb0vWT6xPffmgVFrI6OivOOHp7wveGnOSWAKR2hKQ4CMq8SSOqh4HHfxm/bmO/wSLtRfzAcNAXKdKKS2bsKODCOmN7vT6ocYsN2+05zsYrrFguyePjrfu6xuHzg4CwRFC1X7ovwqrhFbZWSAgiQpiH3e3fEb2qGZjREr3S3FSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=LxcYgr5I; arc=none smtp.client-ip=115.124.30.113
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1736836089; h=From:To:Subject:Date:Message-Id:MIME-Version:Content-Type;
	bh=Vuu7eRPXxp/CyR/Kg/hAZb0idN+VpA9yj9zvsIETRbM=;
	b=LxcYgr5IMhpqKDQOWeQFy6lC75OtrygtXyNeeXPBrFJh81RjBSC3H9C3dLb8DjTID7ESFdETiLMPXCBk+tGlvPnRyIKPgBrwGuzemhaqZ5QjN7csJJ01NVaHFIpCAGaoOPKQSrHTbnc36K1IsTT77OuvQmC/0GepDXiprdt2PEk=
Received: from localhost(mailfrom:jiapeng.chong@linux.alibaba.com fp:SMTPD_---0WNe89iK_1736836086 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 14 Jan 2025 14:28:08 +0800
From: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
To: tj@kernel.org
Cc: hannes@cmpxchg.org,
	mkoutny@suse.com,
	cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
	Abaci Robot <abaci@linux.alibaba.com>
Subject: [PATCH -next] kernel/cgroup: Remove the unused variable climit
Date: Tue, 14 Jan 2025 14:28:04 +0800
Message-Id: <20250114062804.5092-1-jiapeng.chong@linux.alibaba.com>
X-Mailer: git-send-email 2.32.0.3.g01195cf9f
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Variable climit is not effectively used, so delete it.

kernel/cgroup/dmem.c:302:23: warning: variable ‘climit’ set but not used.

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Closes: https://bugzilla.openanolis.cn/show_bug.cgi?id=13512
Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
---
 kernel/cgroup/dmem.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/kernel/cgroup/dmem.c b/kernel/cgroup/dmem.c
index 52736ef0ccf2..78d9361ed521 100644
--- a/kernel/cgroup/dmem.c
+++ b/kernel/cgroup/dmem.c
@@ -299,7 +299,7 @@ bool dmem_cgroup_state_evict_valuable(struct dmem_cgroup_pool_state *limit_pool,
 				      bool ignore_low, bool *ret_hit_low)
 {
 	struct dmem_cgroup_pool_state *pool = test_pool;
-	struct page_counter *climit, *ctest;
+	struct page_counter *ctest;
 	u64 used, min, low;
 
 	/* Can always evict from current pool, despite limits */
@@ -324,7 +324,6 @@ bool dmem_cgroup_state_evict_valuable(struct dmem_cgroup_pool_state *limit_pool,
 			{}
 	}
 
-	climit = &limit_pool->cnt;
 	ctest = &test_pool->cnt;
 
 	dmem_cgroup_calculate_protection(limit_pool, test_pool);
-- 
2.32.0.3.g01195cf9f


