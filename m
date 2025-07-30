Return-Path: <cgroups+bounces-8925-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3778FB15A5B
	for <lists+cgroups@lfdr.de>; Wed, 30 Jul 2025 10:15:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9315118890C4
	for <lists+cgroups@lfdr.de>; Wed, 30 Jul 2025 08:16:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 495732512C3;
	Wed, 30 Jul 2025 08:15:49 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from mail-m49228.qiye.163.com (mail-m49228.qiye.163.com [45.254.49.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 503B536124
	for <cgroups@vger.kernel.org>; Wed, 30 Jul 2025 08:15:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.49.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753863349; cv=none; b=p4uQlskfAaPJDYcQhgZ514sYI4bZcKksUojukDiIoydOdAtV7FQo0V+57WBjAEDg7MES2uQswyykQTbqwEKoPciCEXNnMzYZjmC10AlbPg6a0St/gEQOpsuPT5/ZGMGUau9R5OUoz9gVg/i8+ZylG+2FCQO8v0dTShbWSVGwbD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753863349; c=relaxed/simple;
	bh=rNcO+57kdyWtfV8XdobJD6WwOkPbXiOTQ2J3CakTAoQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=OuzPeGE2jBzY84n/iqZ/gLeAtVYXy+UKk/hYQpuR04PYTjqvsdbQHMts79lgcIb2PixyfaPWpn1fyt97qdewUVFBFh4oeYL9HWSZ+juLeJY5ftYGmy6NE/l+26S+SHqfEfP4ax/cVtwApG/NY2Q83jJ9aWnQPyvbQSVW1R6pdy8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=easystack.cn; spf=pass smtp.mailfrom=easystack.cn; arc=none smtp.client-ip=45.254.49.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=easystack.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=easystack.cn
Received: from localhost.localdomain (unknown [218.94.118.90])
	by smtp.qiye.163.com (Hmail) with ESMTP id ddd57a2b;
	Wed, 30 Jul 2025 16:10:24 +0800 (GMT+08:00)
From: Zhen Ni <zhen.ni@easystack.cn>
To: tj@kernel.org,
	hannes@cmpxchg.org,
	mkoutny@suse.com
Cc: cgroups@vger.kernel.org,
	Zhen Ni <zhen.ni@easystack.cn>
Subject: [PATCH] cgroup: Simplify cgroup_disable loop given limited count
Date: Wed, 30 Jul 2025 16:10:15 +0800
Message-Id: <20250730081015.910435-1-zhen.ni@easystack.cn>
X-Mailer: git-send-email 2.20.1
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a985a61ed5b0229kunm458d2d3e41a822
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFJQjdXWS1ZQUlXWQ8JGhUIEh9ZQVkZTx4aVkkaSkpPGktMSU5MGFYVFAkWGhdVGRETFh
	oSFyQUDg9ZV1kYEgtZQVlJSkNVQk9VSkpDVUJLWVdZFhoPEhUdFFlBWU9LSFVKS0lIQktDVUpLS1
	VKQlkG

This patch refactors the cgroup_disable loop in cgroup_disable() to
leverage the fact that OPT_FEATURE_COUNT can only be 0 or 1, making
the loop structure unnecessary complex.

Key insights:
- OPT_FEATURE_COUNT is defined as an enum value that is either:
  * 0 when CONFIG_PSI is disabled (no optional features)
  * 1 when CONFIG_PSI is enabled (only "pressure" feature)
- Therefore, the loop will either:
  * Run 0 times (when no features exist)
  * Run exactly 1 time (when only one feature exists)

Performance considerations:
- The change has no performance impact since the loop runs at most once

Signed-off-by: Zhen Ni <zhen.ni@easystack.cn>
---
 kernel/cgroup/cgroup.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
index a723b7dc6e4e..71059b61b341 100644
--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -6895,11 +6895,11 @@ static int __init cgroup_disable(char *str)
 		}
 
 		for (i = 0; i < OPT_FEATURE_COUNT; i++) {
-			if (strcmp(token, cgroup_opt_feature_names[i]))
-				continue;
-			cgroup_feature_disable_mask |= 1 << i;
-			pr_info("Disabling %s control group feature\n",
-				cgroup_opt_feature_names[i]);
+			if (!strcmp(token, cgroup_opt_feature_names[i])) {
+				cgroup_feature_disable_mask |= 1 << i;
+				pr_info("Disabling %s control group feature\n",
+					cgroup_opt_feature_names[i]);
+			}
 			break;
 		}
 	}
-- 
2.20.1


