Return-Path: <cgroups+bounces-10288-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 44C31B88BFD
	for <lists+cgroups@lfdr.de>; Fri, 19 Sep 2025 12:04:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DCD4A1C80B73
	for <lists+cgroups@lfdr.de>; Fri, 19 Sep 2025 10:05:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3085D2D24BA;
	Fri, 19 Sep 2025 10:04:24 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFA1D23C4FF;
	Fri, 19 Sep 2025 10:04:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758276264; cv=none; b=oHQmqwwGxpXB/qWgWZ+QoBzQG3YlIWOt6KkiE/kY9X+FUrNqIP7jAbO1RiUmYI/rbiqntkuj1kuc+hY56N5fjVFui09xCM7dy/8+U8VgSQ71AXAqBpf5KjvSiKMxKMbuN17LRZDtNpV+zvhySYFrpw1iMBTtNlKLTGQHnwK5hSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758276264; c=relaxed/simple;
	bh=cL2A2v0YTS+Z9Fb+p2DjEm6Ty1kMPrvE6uA+rVXRv+Q=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=PlUvu7QvJ3GiCbG5euCX3nluA6FpM/wJZPo7rYfcgbLbF89A03LqzlbEY6WTsGedu/e06QeAKKWHweH+V0yabJ3tIHNMHJa2VCxvZpnBTD3IVEbXwlvW6t86gaD9sE/nZN+OsYpkiffyBMNEytTq2tLLFL5WHO7zPH6Vh9ji/ro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4cSp4q1hvzzKHNDG;
	Fri, 19 Sep 2025 18:04:11 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id 1C8F51A19DF;
	Fri, 19 Sep 2025 18:04:12 +0800 (CST)
Received: from hulk-vt.huawei.com (unknown [10.67.174.121])
	by APP2 (Coremail) with SMTP id Syh0CgAncRWZKs1ojDFoAA--.25819S2;
	Fri, 19 Sep 2025 18:04:11 +0800 (CST)
From: Chen Ridong <chenridong@huaweicloud.com>
To: longman@redhat.com,
	tj@kernel.org,
	hannes@cmpxchg.org,
	mkoutny@suse.com
Cc: cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	lujialin4@huawei.com,
	chenridong@huawei.com
Subject: [PATCH cgroup/for-next] cpuset: fix missing error return in update_cpumask
Date: Fri, 19 Sep 2025 09:49:03 +0000
Message-Id: <20250919094903.3060470-1-chenridong@huaweicloud.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250917060454.2885698-9-chenridong@huaweicloud.com>
References: <20250917060454.2885698-9-chenridong@huaweicloud.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:Syh0CgAncRWZKs1ojDFoAA--.25819S2
X-Coremail-Antispam: 1UD129KBjvdXoWrKFyrtF1fury8uFWxGFyxAFb_yoWDuFX_uw
	4Ivr10qrW8Xr1Ig3WUK3W3uF1vkr13tr4DAayYyFWIvFsYyFn2yw1Yqa45ZFy5Aa4xur4Y
	k3srG3ZxWwn2qjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbzAYFVCjjxCrM7AC8VAFwI0_Gr0_Xr1l1xkIjI8I6I8E6xAIw20E
	Y4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwV
	A0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVWDJVCq3wA2z4x0Y4vE2Ix0cI8IcVCY1x02
	67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I
	0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r106r15McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lc7CjxVAaw2AFwI0_JF0_Jw1l42xK82IYc2Ij
	64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x
	8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE
	2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42
	xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF
	7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUotCzDUUUU
X-CM-SenderInfo: hfkh02xlgr0w46kxt4xhlfz01xgou0bp/

From: Chen Ridong <chenridong@huawei.com>

The commit c6366739804f ("cpuset: refactor cpus_allowed_validate_change")
inadvertently removed the error return when cpus_allowed_validate_change()
fails. This patch restores the proper error handling by returning retval
when the validation check fails.

Fixes: c6366739804f ("cpuset: refactor cpus_allowed_validate_change")
Signed-off-by: Chen Ridong <chenridong@huawei.com>
---
 kernel/cgroup/cpuset.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
index 506a7178f0b3..20dface3c3e0 100644
--- a/kernel/cgroup/cpuset.c
+++ b/kernel/cgroup/cpuset.c
@@ -2515,7 +2515,8 @@ static int update_cpumask(struct cpuset *cs, struct cpuset *trialcs,
 	compute_trialcs_excpus(trialcs, cs);
 	trialcs->prs_err = PERR_NONE;
 
-	if (cpus_allowed_validate_change(cs, trialcs, &tmp) < 0)
+	retval = cpus_allowed_validate_change(cs, trialcs, &tmp);
+	if (retval < 0)
 		goto out_free;
 
 	/*
-- 
2.34.1


