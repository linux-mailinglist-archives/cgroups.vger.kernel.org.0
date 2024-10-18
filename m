Return-Path: <cgroups+bounces-5159-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 80DB19A38DA
	for <lists+cgroups@lfdr.de>; Fri, 18 Oct 2024 10:42:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 272B11F2137A
	for <lists+cgroups@lfdr.de>; Fri, 18 Oct 2024 08:42:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B626E18E756;
	Fri, 18 Oct 2024 08:41:53 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D239718E02F;
	Fri, 18 Oct 2024 08:41:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729240913; cv=none; b=OFkM2v91NFiA+rffnTc5PIe3Zxnvo/bdvumwaQncs5+J7nq1MAQSM2TOzZOg8V21GNFMjn3eVUmVkhc64zvfli9qgK6W4UMD7ug3MFODdSzvr9rkaBRdAXF2hwWLC10P90mxGSasYrkVk2dIHsJnUOGgv5++eG9MUEiMUctAM+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729240913; c=relaxed/simple;
	bh=WLcINmbfmi58Iha37hEqQR0ZIMk0Bqv5bvSUn567lP4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=qoB/VOLALw0IV8zKW3S/LpXHu35XLAJJnFGL3SvevxP39Bwl1CkKID9OgvvdZ0ft9Vhx565G15aS47IXfokKxTHk8TjpzUG0VyaaCBQf9Wbn6uJTOyu9l/z7X8dM/1tafuRf+JGBcYcQZY1H1yIv5WYEIHfUAPjPO2eppWG9SLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4XVHls4Kycz4f3jdG;
	Fri, 18 Oct 2024 16:23:37 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id C8FBF1A07B6;
	Fri, 18 Oct 2024 16:23:54 +0800 (CST)
Received: from hulk-vt.huawei.com (unknown [10.67.174.121])
	by APP4 (Coremail) with SMTP id gCh0CgBn58MLGxJnOtqxEQ--.35884S4;
	Fri, 18 Oct 2024 16:23:54 +0800 (CST)
From: Chen Ridong <chenridong@huaweicloud.com>
To: tj@kernel.org,
	lizefan.x@bytedance.com,
	hannes@cmpxchg.org,
	longman@redhat.com,
	mkoutny@suse.com,
	john.fastabend@gmail.com,
	roman.gushchin@linux.dev,
	quanyang.wang@windriver.com,
	ast@kernel.org
Cc: cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	chenridong@huawei.com,
	wangweiyang2@huawei.com
Subject: [PATCH v1 2/2] cgroup/bpf: only cgroup v2 can be attached by bpf programs
Date: Fri, 18 Oct 2024 08:15:20 +0000
Message-Id: <20241018081520.694139-3-chenridong@huaweicloud.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241018081520.694139-1-chenridong@huaweicloud.com>
References: <20241018081520.694139-1-chenridong@huaweicloud.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgBn58MLGxJnOtqxEQ--.35884S4
X-Coremail-Antispam: 1UD129KBjvJXoW7ArWxWF1xAFWfGr1fCw17Jrb_yoW8ZF48pr
	s2kryYgw4rGF4qya92qasYgFyFka10q34jgw47Jw48AF17Xr1Yqr97ur1UZr15AF9rKr1f
	JFWYvr17Kw1jy3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUmlb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUXw
	A2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
	w2x7M28EF7xvwVC0I7IYx2IY67AKxVW7JVWDJwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
	W8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v2
	6rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMc
	Ij6xIIjxv20xvE14v26r106r15McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_
	Jr0_Gr1lF7xvr2IYc2Ij64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7CjxVAaw2AFwI
	0_Jw0_GFyl42xK82IYc2Ij64vIr41l4c8EcI0Ec7CjxVAaw2AFwI0_Jw0_GFyl4I8I3I0E
	4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGV
	WUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_
	Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rV
	WUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4U
	JbIYCTnIWIevJa73UjIFyTuYvjxUob18DUUUU
X-CM-SenderInfo: hfkh02xlgr0w46kxt4xhlfz01xgou0bp/

From: Chen Ridong <chenridong@huawei.com>

Only cgroup v2 can be attached by bpf programs, so this patch introduces
that cgroup_bpf_inherit and cgroup_bpf_offline can only be called in
cgroup v2, and this can fix the memleak mentioned by commit 04f8ef5643bc
("cgroup: Fix memory leak caused by missing cgroup_bpf_offline"), which
has been reverted.

Fixes: 2b0d3d3e4fcf ("percpu_ref: reduce memory footprint of percpu_ref in fast path")
Fixes: 4bfc0bb2c60e ("bpf: decouple the lifetime of cgroup_bpf from cgroup itself")
Link: https://lore.kernel.org/cgroups/aka2hk5jsel5zomucpwlxsej6iwnfw4qu5jkrmjhyfhesjlfdw@46zxhg5bdnr7/
Signed-off-by: Chen Ridong <chenridong@huawei.com>
---
 kernel/cgroup/cgroup.c | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
index 30444e096027..e275eaf2de7f 100644
--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -2140,8 +2140,10 @@ int cgroup_setup_root(struct cgroup_root *root, u16 ss_mask)
 	if (ret)
 		goto exit_stats;
 
-	ret = cgroup_bpf_inherit(root_cgrp);
-	WARN_ON_ONCE(ret);
+	if (root == &cgrp_dfl_root) {
+		ret = cgroup_bpf_inherit(root_cgrp);
+		WARN_ON_ONCE(ret);
+	}
 
 	trace_cgroup_setup_root(root);
 
@@ -5708,9 +5710,11 @@ static struct cgroup *cgroup_create(struct cgroup *parent, const char *name,
 	if (ret)
 		goto out_kernfs_remove;
 
-	ret = cgroup_bpf_inherit(cgrp);
-	if (ret)
-		goto out_psi_free;
+	if (cgrp->root == &cgrp_dfl_root) {
+		ret = cgroup_bpf_inherit(cgrp);
+		if (ret)
+			goto out_psi_free;
+	}
 
 	/*
 	 * New cgroup inherits effective freeze counter, and
@@ -6024,7 +6028,8 @@ static int cgroup_destroy_locked(struct cgroup *cgrp)
 
 	cgroup1_check_for_release(parent);
 
-	cgroup_bpf_offline(cgrp);
+	if (cgrp->root == &cgrp_dfl_root)
+		cgroup_bpf_offline(cgrp);
 
 	/* put the base reference */
 	percpu_ref_kill(&cgrp->self.refcnt);
-- 
2.34.1


