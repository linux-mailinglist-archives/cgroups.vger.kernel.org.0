Return-Path: <cgroups+bounces-6208-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 17701A147F6
	for <lists+cgroups@lfdr.de>; Fri, 17 Jan 2025 03:14:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 87DC53A710F
	for <lists+cgroups@lfdr.de>; Fri, 17 Jan 2025 02:14:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 514C81F5607;
	Fri, 17 Jan 2025 02:14:48 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D72A25A65B;
	Fri, 17 Jan 2025 02:14:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737080088; cv=none; b=SrEMJOIKuwjjKD7nKQB9kl/wQqbIgmrBNCsYlPdU58Im+zVcnvPHk07ZGOf+2WfB8wo02Q6LOX+XUGT1yH2qzWbeYQedi7ONrAqjitrHDv9ZXqwugyXrTssq3F83YhpZOR83StP1MbwDRT4tLCg+CEW4aGjGFW7XO8+QBKC3/Wk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737080088; c=relaxed/simple;
	bh=t8ZApSVZF7kYvsUpMXc542nOM3zha9IX6Jo+ZeLhhiE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XsROT4Ng1tloTEVCsLe8y2hVi1sEHs3H7UF90p+VKRyOMfhRGLyUeUscod/4df2hTMCOtCM7yF2RDlvnIHfSauBkjfYuOQDDzFJbPY7XHJYgBg9i39dz3mwTRbdRt2Zrpucnc1Uyx7p5qtptU1y3W9mtnR3I8kDoElwgNAPZ6EM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4YZ2t661Rpz4f3jt1;
	Fri, 17 Jan 2025 09:57:18 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id 185F81A177B;
	Fri, 17 Jan 2025 09:57:34 +0800 (CST)
Received: from hulk-vt.huawei.com (unknown [10.67.174.121])
	by APP2 (Coremail) with SMTP id Syh0CgCnsWT7uIln8NWrBA--.20802S3;
	Fri, 17 Jan 2025 09:57:33 +0800 (CST)
From: Chen Ridong <chenridong@huaweicloud.com>
To: akpm@linux-foundation.org,
	mhocko@kernel.org,
	hannes@cmpxchg.org,
	yosryahmed@google.com,
	roman.gushchin@linux.dev,
	shakeel.butt@linux.dev,
	muchun.song@linux.dev,
	davidf@vimeo.com,
	vbabka@suse.cz,
	mkoutny@suse.com
Cc: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	cgroups@vger.kernel.org,
	chenridong@huawei.com,
	wangweiyang2@huawei.com
Subject: [PATCH v3 next 1/5] memcg: use OFP_PEAK_UNSET instead of -1
Date: Fri, 17 Jan 2025 01:46:41 +0000
Message-Id: <20250117014645.1673127-2-chenridong@huaweicloud.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250117014645.1673127-1-chenridong@huaweicloud.com>
References: <20250117014645.1673127-1-chenridong@huaweicloud.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:Syh0CgCnsWT7uIln8NWrBA--.20802S3
X-Coremail-Antispam: 1UD129KBjvdXoWrZFWrJF43Cw1xWF1xWr4Uurg_yoWfGFX_uF
	WkKr1DZr15J3ySk3Z0yrySvrnayF1UX347Kw45tw13AFyqqasYvF1vqr4vvw1kXr47try3
	Cwsaqayqgw12gjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbDAYFVCjjxCrM7AC8VAFwI0_Wr0E3s1l1xkIjI8I6I8E6xAIw20E
	Y4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l82xGYIkIc2x26280x7IE14v26r18M2
	8IrcIa0xkI8VCY1x0267AKxVW8JVW5JwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK
	021l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r
	4UJVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
	GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx
	0E2Ix0cI8IcVAFwI0_JrI_JrylYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWU
	JVW8JwACjcxG0xvY0x0EwIxGrwACI402YVCY1x02628vn2kIc2xKxwCY1x0262kKe7AKxV
	WUtVW8ZwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E
	14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIx
	kGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAF
	wI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r
	4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07jjuWdU
	UUUU=
X-CM-SenderInfo: hfkh02xlgr0w46kxt4xhlfz01xgou0bp/

From: Chen Ridong <chenridong@huawei.com>

The 'OFP_PEAK_UNSET' has been defined, use it instead of '-1'.

Signed-off-by: Chen Ridong <chenridong@huawei.com>
Reviewed-by: Michal Koutný <mkoutny@suse.com>
Acked-by: David Finkel <davidf@vimeo.com>
Acked-by: Shakeel Butt <shakeel.butt@linux.dev>
---
 mm/memcontrol.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 46f8b372d212..05a32c860554 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -4004,7 +4004,7 @@ static ssize_t peak_write(struct kernfs_open_file *of, char *buf, size_t nbytes,
 			WRITE_ONCE(peer_ctx->value, usage);
 
 	/* initial write, register watcher */
-	if (ofp->value == -1)
+	if (ofp->value == OFP_PEAK_UNSET)
 		list_add(&ofp->list, watchers);
 
 	WRITE_ONCE(ofp->value, usage);
-- 
2.34.1


