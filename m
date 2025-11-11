Return-Path: <cgroups+bounces-11810-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 464B8C4E322
	for <lists+cgroups@lfdr.de>; Tue, 11 Nov 2025 14:40:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id F10CF4E1EAF
	for <lists+cgroups@lfdr.de>; Tue, 11 Nov 2025 13:40:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C68B34252A;
	Tue, 11 Nov 2025 13:39:36 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2475B33121E;
	Tue, 11 Nov 2025 13:39:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762868376; cv=none; b=e5xYctIHV1gr9/E5D133qoR+wR6759UxflPaNOrsXOp2u1Ec3AxwR88m9dudTvr/hPsNdjxdz1wKvZHOq5WDa/R/pejvu7O3SDZ2D0lDw2fPZouFfvXQg46LT/Nb1+xfVHg0chCVK0V437UGlWhAxHq8QlGWVV0J5I3hAZXO8vA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762868376; c=relaxed/simple;
	bh=uCfWoPN8J85W8IJ1RDl6gTNYyFDWCaJAL4I8xCrPM+I=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EJJHEdb5C85UmK86tY2ZLlSSTq9eMLSXM384bYMmzbeWpW5I+Q12GBFWcqFv2RwCur9Cnu1wQHkrW0A5LCdOevhRArFSdDj8CNRtl5OZg9JrVibd5kCwWnTlm0bq5qoFYHg0q32EAAnsmeVWHY3SzsmfMerXmR3t1HfpBH0g9dQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4d5SLV2B2lzKHM0R;
	Tue, 11 Nov 2025 21:39:14 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 6D3E11A0B97;
	Tue, 11 Nov 2025 21:39:30 +0800 (CST)
Received: from hulk-vt.huawei.com (unknown [10.67.174.121])
	by APP4 (Coremail) with SMTP id gCh0CgBXgF2EPBNpML6FAQ--.14435S3;
	Tue, 11 Nov 2025 21:39:30 +0800 (CST)
From: Chen Ridong <chenridong@huaweicloud.com>
To: longman@redhat.com,
	tj@kernel.org,
	hannes@cmpxchg.org,
	mkoutny@suse.com
Cc: cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	lujialin4@huawei.com,
	chenridong@huawei.com
Subject: [PATCH -next v2 1/3] cpuset: simplify node setting on error
Date: Tue, 11 Nov 2025 13:24:27 +0000
Message-Id: <20251111132429.950343-2-chenridong@huaweicloud.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251111132429.950343-1-chenridong@huaweicloud.com>
References: <20251111132429.950343-1-chenridong@huaweicloud.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgBXgF2EPBNpML6FAQ--.14435S3
X-Coremail-Antispam: 1UD129KBjvJXoW7tw1kur43CrW3ZFy5JF17GFg_yoW8Ww1UpF
	W7G3WUArW5Jry3G395J39xWFyqg348JF9rGFnFqa4fCasFyF9FkF1DXwnFyFW7JasxCF15
	JF4SyFW8uF9rt37anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9Kb4IE77IF4wAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUGw
	A2048vs2IY020Ec7CjxVAFwI0_JFI_Gr1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
	w2x7M28EF7xvwVC0I7IYx2IY67AKxVWDJVCq3wA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
	W8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v2
	6rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMc
	Ij6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_
	Jr0_Gr1lF7xvr2IYc2Ij64vIr41lc7CjxVAaw2AFwI0_JF0_Jw1l42xK82IYc2Ij64vIr4
	1l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK
	67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI
	8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAv
	wI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14
	v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxU7qjgUUUUU
X-CM-SenderInfo: hfkh02xlgr0w46kxt4xhlfz01xgou0bp/

From: Chen Ridong <chenridong@huawei.com>

There is no need to jump to the 'done' label upon failure, as no cleanup
is required. Return the error code directly instead.

Signed-off-by: Chen Ridong <chenridong@huawei.com>
Reviewed-by: Waiman Long <longman@redhat.com>
Reviewed-by: Michal Koutný <mkoutny@suse.com>
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


