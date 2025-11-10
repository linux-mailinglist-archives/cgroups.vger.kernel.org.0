Return-Path: <cgroups+bounces-11704-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E4D28C44C20
	for <lists+cgroups@lfdr.de>; Mon, 10 Nov 2025 03:08:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E5E193B0208
	for <lists+cgroups@lfdr.de>; Mon, 10 Nov 2025 02:08:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C9AB23E33D;
	Mon, 10 Nov 2025 02:07:44 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4BEA3F9FB;
	Mon, 10 Nov 2025 02:07:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762740463; cv=none; b=q+GO6+eWsfygfNeUjxXTQc8kihIiRyjRPgS7gzwwW7uMmDd12kxkyAX69YZsoP0AQvkWuFR3HrutlllS0KT8CS0wz9yXnAVH+KAKnKp14mwaGKV98NOen4PxsiAXIFp6XchrqcmPkto3Fv1gg09JvXhOiPT7VIAgHls7LFoaQns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762740463; c=relaxed/simple;
	bh=o7BdpqTSZH61cu5ofyfQozUm+TBZC7KAhmdZa4XkkxE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Flvij4yLb61HG9oxFZVlqgo2wx8Svvq5tHcfAlWXfPzX63ogeZHVHgs3wKFYmRfLIqNm6TePKeXQtmFLrPQ+bEkeD6iHPeurhfaj107VGzcvJdc/EeSaA18kTnRXzCES43JbM8WenbVy5M1jzA8RXTzu7YnjxrUuu8IqasNhKEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4d4Y2N0wf9zYQtwp;
	Mon, 10 Nov 2025 10:07:08 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 725D71A0902;
	Mon, 10 Nov 2025 10:07:32 +0800 (CST)
Received: from hulk-vt.huawei.com (unknown [10.67.174.121])
	by APP1 (Coremail) with SMTP id cCh0CgBXkUrUSBFpPBDaAA--.6382S3;
	Mon, 10 Nov 2025 10:07:32 +0800 (CST)
From: Chen Ridong <chenridong@huaweicloud.com>
To: longman@redhat.com,
	tj@kernel.org,
	hannes@cmpxchg.org,
	mkoutny@suse.com
Cc: cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	lujialin4@huawei.com,
	chenridong@huawei.com
Subject: [PATCH -next 1/3] cpuset: simplify node setting on error
Date: Mon, 10 Nov 2025 01:52:26 +0000
Message-Id: <20251110015228.897736-2-chenridong@huaweicloud.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251110015228.897736-1-chenridong@huaweicloud.com>
References: <20251110015228.897736-1-chenridong@huaweicloud.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgBXkUrUSBFpPBDaAA--.6382S3
X-Coremail-Antispam: 1UD129KBjvJXoW7tw1kur4xXrykCw4xGF13XFb_yoW8Xw4xpF
	W7G3WUArW5Jry3G395t39xWFyqg348JF9rGFnFqa4fCasFyF9FkF1DXwnrAFW7JF9xCF15
	JFsayFW8uF9rt37anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9Kb4IE77IF4wAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUGw
	A2048vs2IY020Ec7CjxVAFwI0_JFI_Gr1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
	w2x7M28EF7xvwVC0I7IYx2IY67AKxVWDJVCq3wA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
	W8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v2
	6rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMc
	Ij6xIIjxv20xvE14v26r106r15McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_
	Jr0_Gr1lF7xvr2IYc2Ij64vIr41lc7CjxVAaw2AFwI0_JF0_Jw1l42xK82IYc2Ij64vIr4
	1l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK
	67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI
	8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAv
	wI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14
	v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUw9a9UUUUU
X-CM-SenderInfo: hfkh02xlgr0w46kxt4xhlfz01xgou0bp/

From: Chen Ridong <chenridong@huawei.com>

There is no need to jump to the 'done' label upon failure, as no cleanup
is required. Return the error code directly instead.

Signed-off-by: Chen Ridong <chenridong@huawei.com>
---
 kernel/cgroup/cpuset.c | 21 +++++++++------------
 1 file changed, 9 insertions(+), 12 deletions(-)

diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
index 8238fd8c0c29..c90476d52f09 100644
--- a/kernel/cgroup/cpuset.c
+++ b/kernel/cgroup/cpuset.c
@@ -2897,21 +2897,19 @@ static int update_nodemask(struct cpuset *cs, struct cpuset *trialcs,
 	 */
 	retval = nodelist_parse(buf, trialcs->mems_allowed);
 	if (retval < 0)
-		goto done;
+		return retval;
 
 	if (!nodes_subset(trialcs->mems_allowed,
-			  top_cpuset.mems_allowed)) {
-		retval = -EINVAL;
-		goto done;
-	}
+			  top_cpuset.mems_allowed))
+		return -EINVAL;
+
+	/* No change? nothing to do */
+	if (nodes_equal(cs->mems_allowed, trialcs->mems_allowed))
+		return 0;
 
-	if (nodes_equal(cs->mems_allowed, trialcs->mems_allowed)) {
-		retval = 0;		/* Too easy - nothing to do */
-		goto done;
-	}
 	retval = validate_change(cs, trialcs);
 	if (retval < 0)
-		goto done;
+		return retval;
 
 	check_insane_mems_config(&trialcs->mems_allowed);
 
@@ -2921,8 +2919,7 @@ static int update_nodemask(struct cpuset *cs, struct cpuset *trialcs,
 
 	/* use trialcs->mems_allowed as a temp variable */
 	update_nodemasks_hier(cs, &trialcs->mems_allowed);
-done:
-	return retval;
+	return 0;
 }
 
 bool current_cpuset_is_being_rebound(void)
-- 
2.34.1


