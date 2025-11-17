Return-Path: <cgroups+bounces-12025-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id BC885C62309
	for <lists+cgroups@lfdr.de>; Mon, 17 Nov 2025 04:05:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E9F4E4ED7AF
	for <lists+cgroups@lfdr.de>; Mon, 17 Nov 2025 03:04:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00F172882BE;
	Mon, 17 Nov 2025 03:01:54 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93E78258ED9;
	Mon, 17 Nov 2025 03:01:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763348513; cv=none; b=BTbQquAvTuLehiPT0T7S5m01QKuIZZ+jAmomD5jFPlWU1Uks9Ov8I3nuyVS8a7sIfE/fFIiBYv1rZvfKRSiNOQh8t7b2GHzQs8coOdtxYL9xwktZIxpUdi7OghTaPwMd+XJDfOmqUS7K7RzaSZR4c0scr6wALmk4Bj7HG/orA9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763348513; c=relaxed/simple;
	bh=ECywYBUqG+2rO4GFortbENsj4uXQwDIbZ5MXQc1ETmI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ZsP2qn6LCyCiLwvIOS5DgaSSyzbVAWWTr+KdJR3CJHVfRi4RKVe7XQn2t3Vnwe0bNr5rhZhLVecYS4j8jpoEvqGzzkbZsyD46b8twkBKN4hKB3CrdLl6u0YprR7F5XmTJgSIrkshdcF/v3GHYF44656zhFEc+gla7jvaUa0Y3/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4d8svY4XdMzKHMVr;
	Mon, 17 Nov 2025 11:01:13 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id 2B8E41A1F48;
	Mon, 17 Nov 2025 11:01:38 +0800 (CST)
Received: from hulk-vt.huawei.com (unknown [10.67.174.121])
	by APP2 (Coremail) with SMTP id Syh0CgA3lHr5jxpp+kwRBA--.27716S19;
	Mon, 17 Nov 2025 11:01:38 +0800 (CST)
From: Chen Ridong <chenridong@huaweicloud.com>
To: longman@redhat.com,
	tj@kernel.org,
	hannes@cmpxchg.org,
	mkoutny@suse.com
Cc: cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	lujialin4@huawei.com,
	chenridong@huawei.com
Subject: [PATCH -next 17/21] cpuset: use validate_local_partition in local_partition_enable
Date: Mon, 17 Nov 2025 02:46:23 +0000
Message-Id: <20251117024627.1128037-18-chenridong@huaweicloud.com>
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
X-CM-TRANSID:Syh0CgA3lHr5jxpp+kwRBA--.27716S19
X-Coremail-Antispam: 1UD129KBjvJXoW7Zr47Kw4ruFW3WF1DCFykZrb_yoW8Xr17pF
	nxKrWxWrW5WFy5C3srJan7uwn5KwsFqF1UA3Zxt3yrXF17J3WqkFy0y3yDAr1YqFZrCr45
	Xa43Zr4Iga42krDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUBFb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUAV
	Cq3wA2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0
	rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVWDJVCq3wA2z4x0Y4vE2Ix0cI8IcVCY1x0267
	AKxVWxJr0_GcWl84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAF
	wI0_GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2
	WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkE
	bVWUJVW8JwACjcxG0xvY0x0EwIxGrwCY1x0262kKe7AKxVWUAVWUtwCF04k20xvY0x0EwI
	xGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480
	Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7
	IYx2IY67AKxVW8JVW5JwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F4UJwCI42IY6xAI
	w20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr0_Cr1lIxAIcVC2z280aVCY1x
	0267AKxVW8Jr0_Cr1UYxBIdaVFxhVjvjDU0xZFpf9x07UM6wAUUUUU=
X-CM-SenderInfo: hfkh02xlgr0w46kxt4xhlfz01xgou0bp/

From: Chen Ridong <chenridong@huawei.com>

Replace the partition error checks within `local_partition_enable()` by
utilizing the common `validate_local_partition()` function.

Signed-off-by: Chen Ridong <chenridong@huawei.com>
---
 kernel/cgroup/cpuset.c | 12 +-----------
 1 file changed, 1 insertion(+), 11 deletions(-)

diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
index af2966cd685d..b75d27a59ba9 100644
--- a/kernel/cgroup/cpuset.c
+++ b/kernel/cgroup/cpuset.c
@@ -1950,16 +1950,6 @@ static int local_partition_enable(struct cpuset *cs,
 	lockdep_assert_held(&cpuset_mutex);
 	WARN_ON_ONCE(is_remote_partition(cs));	/* For local partition only */
 
-	/*
-	 * The parent must be a partition root.
-	 * The new cpumask, if present, or the current cpus_allowed must
-	 * not be empty.
-	 */
-	if (!is_partition_valid(parent)) {
-		return is_partition_invalid(parent)
-			? PERR_INVPARENT : PERR_NOTPART;
-	}
-
 	/*
 	 * Need to call compute_excpus() in case
 	 * exclusive_cpus not set. Sibling conflict should only happen
@@ -1968,7 +1958,7 @@ static int local_partition_enable(struct cpuset *cs,
 	if (compute_excpus(cs, tmp->new_cpus))
 		WARN_ON_ONCE(!cpumask_empty(cs->exclusive_cpus));
 
-	err = validate_partition(cs, new_prs, tmp->new_cpus, tmp->new_cpus, NULL);
+	err = validate_local_partition(cs, new_prs, tmp->new_cpus, false, NULL);
 	if (err)
 		return err;
 
-- 
2.34.1


