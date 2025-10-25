Return-Path: <cgroups+bounces-11169-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DDCE8C08CFC
	for <lists+cgroups@lfdr.de>; Sat, 25 Oct 2025 09:07:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 55629404E2F
	for <lists+cgroups@lfdr.de>; Sat, 25 Oct 2025 07:05:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 757DB2E172B;
	Sat, 25 Oct 2025 07:04:00 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6314A2512EE;
	Sat, 25 Oct 2025 07:03:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761375840; cv=none; b=WXnhAWTMBLXaRM+zQ54tfc48ob6e31Nvb/wUXW3kphpWJsXG1vvz2cveDLHqhh/SQBv/tT6ns//3zM+067FXXmXGW/EiBaZDD0KiBLBdzV1+rMkzaohHVQNp3AY018xf8qtOysfN9vvNWx2RmVBA9aV0rCsQwVvYVS3Aou6L4VY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761375840; c=relaxed/simple;
	bh=IgOwrtXwx52XJd3Lsp6lb3dBNRJTzz5fUvDKUIT2wKg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=PX4V1MRvZVKvv7HpU3d0x+Pb+TE3HiEnjnCb5OmxeYPW1/GBcpzmHbTHlKRgHvzH3PbpyTRJE6Sd6Ck4KigRKSn2A3nIXbLEtt7gBwo1Ju5vwaENIfXnu8k4gIgx7zBXbCY20WhH830XHqf0aFGXWSr5B3yhBHZf0sPAo5f+GNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4ctrLz0h8BzYQttS;
	Sat, 25 Oct 2025 15:02:51 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id F3B231A121F;
	Sat, 25 Oct 2025 15:03:49 +0800 (CST)
Received: from hulk-vt.huawei.com (unknown [10.67.174.121])
	by APP2 (Coremail) with SMTP id Syh0CgCHKUJGdvxovSssBg--.49460S4;
	Sat, 25 Oct 2025 15:03:49 +0800 (CST)
From: Chen Ridong <chenridong@huaweicloud.com>
To: longman@redhat.com,
	tj@kernel.org,
	hannes@cmpxchg.org,
	mkoutny@suse.com
Cc: cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	lujialin4@huawei.com,
	chenridong@huawei.com
Subject: [PATCH RFC v2 02/22] cpuset: add early empty cpumask check in partition_xcpus_add/del
Date: Sat, 25 Oct 2025 06:48:24 +0000
Message-Id: <20251025064844.495525-3-chenridong@huaweicloud.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251025064844.495525-1-chenridong@huaweicloud.com>
References: <20251025064844.495525-1-chenridong@huaweicloud.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:Syh0CgCHKUJGdvxovSssBg--.49460S4
X-Coremail-Antispam: 1UD129KBjvdXoWrZF1UKF1rGF1rZFy7trWfGrg_yoWDKrX_Cr
	y8WF1UurWkAF1Iq3WqkayfJFWkK3ykZF1vkrZ8trW2yF18Crn3Zwnavas0yrW5uw1xWry5
	CasxGFn5J3Z8tjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbTkYFVCjjxCrM7AC8VAFwI0_Wr0E3s1l1xkIjI8I6I8E6xAIw20E
	Y4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l82xGYIkIc2x26280x7IE14v26r15M2
	8IrcIa0xkI8VCY1x0267AKxVW8JVW5JwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK
	021l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r
	4UJVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
	GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx
	0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWU
	JVW8JwACjcxG0xvY0x0EwIxGrwCY1x0262kKe7AKxVWUAVWUtwCF04k20xvY0x0EwIxGrw
	CFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE
	14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2
	IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxK
	x2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI
	0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07jYLvtUUUUU=
X-CM-SenderInfo: hfkh02xlgr0w46kxt4xhlfz01xgou0bp/

From: Chen Ridong <chenridong@huawei.com>

Add a check for an empty cpumask at the start of partition_xcpus_add()
and partition_xcpus_del(). This allows the functions to return early,
avoiding unnecessary computation when there is no work to be done.

Signed-off-by: Chen Ridong <chenridong@huawei.com>
---
 kernel/cgroup/cpuset.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
index 6af4d80b53c4..3ba9ca4e8f5e 100644
--- a/kernel/cgroup/cpuset.c
+++ b/kernel/cgroup/cpuset.c
@@ -1345,6 +1345,9 @@ static bool partition_xcpus_add(int new_prs, struct cpuset *parent,
 
 	WARN_ON_ONCE(new_prs < 0);
 	lockdep_assert_held(&callback_lock);
+	if (cpumask_empty(xcpus))
+		return false;
+
 	if (!parent)
 		parent = &top_cpuset;
 
@@ -1377,6 +1380,9 @@ static bool partition_xcpus_del(int old_prs, struct cpuset *parent,
 
 	WARN_ON_ONCE(old_prs < 0);
 	lockdep_assert_held(&callback_lock);
+	if (cpumask_empty(xcpus))
+		return false;
+
 	if (!parent)
 		parent = &top_cpuset;
 
-- 
2.34.1


