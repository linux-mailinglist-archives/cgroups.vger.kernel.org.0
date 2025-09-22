Return-Path: <cgroups+bounces-10348-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B725B915C3
	for <lists+cgroups@lfdr.de>; Mon, 22 Sep 2025 15:18:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0669A3A3920
	for <lists+cgroups@lfdr.de>; Mon, 22 Sep 2025 13:18:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A68930CDBD;
	Mon, 22 Sep 2025 13:18:00 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92FC11DBB3A;
	Mon, 22 Sep 2025 13:17:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758547079; cv=none; b=bp4MVskLBuqdhKujH+/XM0ZGEpiJg2fI/bxH8OFKLaLMRROMkxExQ/BaXZbLRK5n2gGEIP6kl32nnkpeZ/CE/XDRsNHDqTSRRlYhzvvd3oP1gbF7O8cRerUD3Rqe4xq62L+EooGbgoo4D3fiNQWXoSKnq/hJR173p3p0lUbmpIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758547079; c=relaxed/simple;
	bh=nT/4BYn6CiOPJFOIZOZVP2rIVAAaffeP/tWq6h/x8ko=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jXecO1lb7fWLUvvQ2PgpOtC78o986FKoEJe/ENBzDxMJ2E4WcXVD37w/XsOZSRAYwGHTNTT90xup/bfiMczeSWZ6ipYIYD8fnLUAGh/yEpz4/TnaYv1TJqk45LwZEZ0vnstBPT6MjQa6ryOFPLRe3+B5ymLDehArI/ej75VSrBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4cVkDt4JDWzKHMhD;
	Mon, 22 Sep 2025 21:17:50 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id 588EC1A1881;
	Mon, 22 Sep 2025 21:17:54 +0800 (CST)
Received: from hulk-vt.huawei.com (unknown [10.67.174.121])
	by APP2 (Coremail) with SMTP id Syh0CgCH0hZ3TNFoBhXHAQ--.54770S5;
	Mon, 22 Sep 2025 21:17:54 +0800 (CST)
From: Chen Ridong <chenridong@huaweicloud.com>
To: longman@redhat.com,
	tj@kernel.org,
	hannes@cmpxchg.org,
	mkoutny@suse.com
Cc: cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	lujialin4@huawei.com,
	chenridong@huawei.com
Subject: [PATCH -next 3/3] cpuset: remove is_prs_invalid helper
Date: Mon, 22 Sep 2025 13:02:33 +0000
Message-Id: <20250922130233.3237521-4-chenridong@huaweicloud.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250922130233.3237521-1-chenridong@huaweicloud.com>
References: <20250922130233.3237521-1-chenridong@huaweicloud.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:Syh0CgCH0hZ3TNFoBhXHAQ--.54770S5
X-Coremail-Antispam: 1UD129KBjvJXoW7KF4xGF18CrW3Jr4UXFyUAwb_yoW8CF13pF
	yUKa1UJ3y8WF1UC34DtFs29345KwsFqa47tF98W348XF17Ja1v9Fy0k34aqrW5t345WF1U
	Z3Z0vr4IgasFy3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUPab4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUWw
	A2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
	w2x7M28EF7xvwVC0I7IYx2IY67AKxVW7JVWDJwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
	W8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v2
	6rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMc
	Ij6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_
	Jr0_Gr1lF7xvr2IYc2Ij64vIr41lc7CjxVAaw2AFwI0_JF0_Jw1l42xK82IYc2Ij64vIr4
	1l4c8EcI0Ec7CjxVAaw2AFwI0_JF0_Jw1l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAq
	x4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r
	43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF
	7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxV
	WUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxU
	whFxUUUUU
X-CM-SenderInfo: hfkh02xlgr0w46kxt4xhlfz01xgou0bp/

From: Chen Ridong <chenridong@huawei.com>

The is_prs_invalid helper function is redundant as it serves a similar
purpose to is_partition_invalid. It can be fully replaced by the existing
is_partition_invalid function, so this patch removes the is_prs_invalid
helper.

Signed-off-by: Chen Ridong <chenridong@huawei.com>
---
 kernel/cgroup/cpuset.c | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
index 196645b38b24..52468d2c178a 100644
--- a/kernel/cgroup/cpuset.c
+++ b/kernel/cgroup/cpuset.c
@@ -132,11 +132,6 @@ static bool force_sd_rebuild;
 #define PRS_INVALID_ROOT	-1
 #define PRS_INVALID_ISOLATED	-2
 
-static inline bool is_prs_invalid(int prs_state)
-{
-	return prs_state < 0;
-}
-
 /*
  * Temporary cpumasks for working with partitions that are passed among
  * functions to avoid memory allocation in inner functions.
@@ -1767,7 +1762,7 @@ static int update_parent_effective_cpumask(struct cpuset *cs, int cmd,
 	old_prs = new_prs = cs->partition_root_state;
 
 	if (cmd == partcmd_invalidate) {
-		if (is_prs_invalid(old_prs))
+		if (is_partition_invalid(cs))
 			return 0;
 
 		/*
@@ -1874,7 +1869,7 @@ static int update_parent_effective_cpumask(struct cpuset *cs, int cmd,
 		 * For invalid partition:
 		 *   delmask = newmask & parent->effective_xcpus
 		 */
-		if (is_prs_invalid(old_prs)) {
+		if (is_partition_invalid(cs)) {
 			adding = false;
 			deleting = cpumask_and(tmp->delmask,
 					newmask, parent->effective_xcpus);
@@ -2964,7 +2959,7 @@ static int update_prstate(struct cpuset *cs, int new_prs)
 	/*
 	 * Treat a previously invalid partition root as if it is a "member".
 	 */
-	if (new_prs && is_prs_invalid(old_prs))
+	if (new_prs && is_partition_invalid(cs))
 		old_prs = PRS_MEMBER;
 
 	if (alloc_tmpmasks(&tmpmask))
-- 
2.34.1


