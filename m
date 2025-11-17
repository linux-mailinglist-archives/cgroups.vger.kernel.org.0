Return-Path: <cgroups+bounces-12011-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DE27C622D2
	for <lists+cgroups@lfdr.de>; Mon, 17 Nov 2025 04:02:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 4A0CC4E75B8
	for <lists+cgroups@lfdr.de>; Mon, 17 Nov 2025 03:02:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 526E7264619;
	Mon, 17 Nov 2025 03:01:48 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37DB623EA92;
	Mon, 17 Nov 2025 03:01:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763348508; cv=none; b=gQJNy+vIALPk4Gh4GOk7lSCkHIZtkqgDcNBqsny4IcM28tGoKIrBI82fCr51I3nvzueB6f1NMNNY1D7zWAtA0gCRgqTNCUxxxqxXrK/zMDQvoCZ3lFt8X4G6nYigV/u10LMXJ6BzmdyKMGNhaTbLp89Lf2mnbr/F3eCvbctAlwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763348508; c=relaxed/simple;
	bh=Ehkw2dzAbCx2+mBUthfdeXqF4aAHrcDLDQ5ISkFRABg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=arFOtCYbfEiNj3fNCgUX6+YJglkkTwYCNLUcqfTEZ1PKFppjMIuOQXU+dP+oR14zXnjJcggnqCMKGPsUvsnn540BquDdGlnnKZCyNKtLxdeanuOiuvldOgeLxC5kDen4s8JHqJK1me03N+tbw2lP/7zAGMzz7a+/CCYuBZDVAV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4d8svX6SC6zKHMPX;
	Mon, 17 Nov 2025 11:01:12 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id 687FB1A07C0;
	Mon, 17 Nov 2025 11:01:37 +0800 (CST)
Received: from hulk-vt.huawei.com (unknown [10.67.174.121])
	by APP2 (Coremail) with SMTP id Syh0CgA3lHr5jxpp+kwRBA--.27716S3;
	Mon, 17 Nov 2025 11:01:37 +0800 (CST)
From: Chen Ridong <chenridong@huaweicloud.com>
To: longman@redhat.com,
	tj@kernel.org,
	hannes@cmpxchg.org,
	mkoutny@suse.com
Cc: cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	lujialin4@huawei.com,
	chenridong@huawei.com
Subject: [PATCH -next 01/21] cpuset: add early empty cpumask check in partition_xcpus_add/del
Date: Mon, 17 Nov 2025 02:46:07 +0000
Message-Id: <20251117024627.1128037-2-chenridong@huaweicloud.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251117024627.1128037-1-chenridong@huaweicloud.com>
References: <20251117024627.1128037-1-chenridong@huaweicloud.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:Syh0CgA3lHr5jxpp+kwRBA--.27716S3
X-Coremail-Antispam: 1UD129KBjvJXoW7tw1fKw4xGFWxXr17CrWruFg_yoW8GFy7pF
	15GrW7JFW5Kr15C3sFqan3Wrn3Kws5GFy2yF4Fgr1rJFy7X3Wv9Fyqk3sIq3WrXayDCrWU
	ZFsIvrsFg3W7AwUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9Cb4IE77IF4wAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUGw
	A2048vs2IY020Ec7CjxVAFwI0_JFI_Gr1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
	w2x7M28EF7xvwVC0I7IYx2IY67AKxVWDJVCq3wA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
	WxJr0_GcWl84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
	GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx
	0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWU
	JVW8JwACjcxG0xvY0x0EwIxGrwCY1x0262kKe7AKxVWUAVWUtwCF04k20xvY0x0EwIxGrw
	CFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE
	14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2
	IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxK
	x2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI
	0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07jb8n5UUUUU=
X-CM-SenderInfo: hfkh02xlgr0w46kxt4xhlfz01xgou0bp/

From: Chen Ridong <chenridong@huawei.com>

Add a check for an empty cpumask at the start of partition_xcpus_add()
and partition_xcpus_del(). This allows the functions to return early,
avoiding unnecessary computation when there is no work to be done. With
these changes, partition_xcpus_add() and partition_xcpus_del() can be
called even if xcpus is empty. The caller no longer needs to check whether
xcpus is empty, eliminating many conditional statements.

Signed-off-by: Chen Ridong <chenridong@huawei.com>
---
 kernel/cgroup/cpuset.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
index 8bf7c38ba320..0b7545ca4c18 100644
--- a/kernel/cgroup/cpuset.c
+++ b/kernel/cgroup/cpuset.c
@@ -1367,10 +1367,13 @@ static void partition_xcpus_add(int new_prs, struct cpuset *parent,
 {
 	WARN_ON_ONCE(new_prs < 0);
 	lockdep_assert_held(&callback_lock);
+
+	if (cpumask_empty(xcpus))
+		return;
+
 	if (!parent)
 		parent = &top_cpuset;
 
-
 	if (parent == &top_cpuset)
 		cpumask_or(subpartitions_cpus, subpartitions_cpus, xcpus);
 
@@ -1394,6 +1397,10 @@ static void partition_xcpus_del(int old_prs, struct cpuset *parent,
 {
 	WARN_ON_ONCE(old_prs < 0);
 	lockdep_assert_held(&callback_lock);
+
+	if (cpumask_empty(xcpus))
+		return;
+
 	if (!parent)
 		parent = &top_cpuset;
 
-- 
2.34.1


