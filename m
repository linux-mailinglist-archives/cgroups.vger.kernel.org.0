Return-Path: <cgroups+bounces-10255-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E916EB849E1
	for <lists+cgroups@lfdr.de>; Thu, 18 Sep 2025 14:41:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 66AAA7B13EB
	for <lists+cgroups@lfdr.de>; Thu, 18 Sep 2025 12:39:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 474E52F5320;
	Thu, 18 Sep 2025 12:40:53 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 220E82E3B11;
	Thu, 18 Sep 2025 12:40:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758199253; cv=none; b=mOWsAQcHQJzJQSwCWpVr5pdcA8XMsklDBEjuDRbEwBX+fqixhq/Ood4oaCmQhGkzEGSaBWLsKuaJTsSaTSnXVoQ2HBkyRc1ju5qwb4kDA3P9Oe09yVRHBXVh6EOpk8SQb8HBDk/9ern/SswgEO0Z4DtbcFkxdj1gzPkHZwzObl0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758199253; c=relaxed/simple;
	bh=wo4IV68DiBeTWlF/CeqKMffFhb3GLL52f47Dm+lxmjA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=lu8P9QXkAC8kZIRxjm6lhVJaBRG+op2CKfVoVLmfZZq2HLt7V8nGxZAU8NdjpwipqpsoxYEQsQioKrIUSG3K2XHf7hXYMBtKXEzkvUo5TggvFCCIAmRQ0GNpYUfcwt79Xxu3P6Mrv3VGTrVdr8+/GjJe7Avn3WyGlpmNFA/iyEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4cSFc23yLmzYQtHb;
	Thu, 18 Sep 2025 20:40:50 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id 308DA1A0F7F;
	Thu, 18 Sep 2025 20:40:49 +0800 (CST)
Received: from hulk-vt.huawei.com (unknown [10.67.174.121])
	by APP2 (Coremail) with SMTP id Syh0CgCX4RXF_ctoY2EDAA--.7338S4;
	Thu, 18 Sep 2025 20:40:49 +0800 (CST)
From: Chen Ridong <chenridong@huaweicloud.com>
To: longman@redhat.com,
	tj@kernel.org,
	hannes@cmpxchg.org,
	mkoutny@suse.com
Cc: cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	lujialin4@huawei.com,
	chenridong@huawei.com
Subject: [PATCH cgroup/for-next 2/2] cpuset: Use new excpus for nocpu error check when enabling root partition
Date: Thu, 18 Sep 2025 12:25:32 +0000
Message-Id: <20250918122532.2981503-3-chenridong@huaweicloud.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250918122532.2981503-1-chenridong@huaweicloud.com>
References: <20250918122532.2981503-1-chenridong@huaweicloud.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:Syh0CgCX4RXF_ctoY2EDAA--.7338S4
X-Coremail-Antispam: 1UD129KBjvJXoW7XF48KryxGFWkCry7GFyxGrg_yoW8Jr4xpF
	WfGa1Ut3yYgF1UC3sFqa95Ww1rWws3JF1Ut3WkWayxZa43J3W0kryDuws0qryjqFZ3Cayj
	qFsIvw4Svayqy37anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUPab4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUXw
	A2048vs2IY020Ec7CjxVAFwI0_Gr0_Xr1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
	w2x7M28EF7xvwVC0I7IYx2IY67AKxVWDJVCq3wA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
	W8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v2
	6rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMc
	Ij6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_
	Jr0_Gr1lF7xvr2IYc2Ij64vIr41lc7CjxVAaw2AFwI0_JF0_Jw1l42xK82IYc2Ij64vIr4
	1l4c8EcI0Ec7CjxVAaw2AFwI0_JF0_Jw1l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAq
	x4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r
	43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF
	7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxV
	WUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxU
	cTmhUUUUU
X-CM-SenderInfo: hfkh02xlgr0w46kxt4xhlfz01xgou0bp/

From: Chen Ridong <chenridong@huawei.com>

A previous patch fixed a bug where new_prs should be assigned before
checking housekeeping conflicts. This patch addresses another potential
issue: the nocpu error check currently uses the xcpus which is not updated.
Although no issue has been observed so far, the check should be performed
using the new effective exclusive cpus.

The comment has been removed because the function returns an error if
nocpu checking fails, which is unrelated to the parent.

Signed-off-by: Chen Ridong <chenridong@huawei.com>
---
 kernel/cgroup/cpuset.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
index 2b7e2f17577e..44d65890326a 100644
--- a/kernel/cgroup/cpuset.c
+++ b/kernel/cgroup/cpuset.c
@@ -1818,11 +1818,7 @@ static int update_parent_effective_cpumask(struct cpuset *cs, int cmd,
 		if (prstate_housekeeping_conflict(new_prs, xcpus))
 			return PERR_HKEEPING;
 
-		/*
-		 * A parent can be left with no CPU as long as there is no
-		 * task directly associated with the parent partition.
-		 */
-		if (nocpu)
+		if (tasks_nocpu_error(parent, cs, xcpus))
 			return PERR_NOCPUS;
 
 		/*
-- 
2.34.1


