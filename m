Return-Path: <cgroups+bounces-2577-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CEC918A9148
	for <lists+cgroups@lfdr.de>; Thu, 18 Apr 2024 04:46:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5D904B21AF0
	for <lists+cgroups@lfdr.de>; Thu, 18 Apr 2024 02:46:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 882C345BEA;
	Thu, 18 Apr 2024 02:46:34 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B847D8F66;
	Thu, 18 Apr 2024 02:46:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713408394; cv=none; b=PNfh/5JZV/08DSaReRe0039hr1JkKEgKvKp+5wLdAaoZn0YwJ9cNgHT4Cosyyt7V9Pq/7d5sQkwskAWN7369rXaxwbTEguN5ay0DDHXT9qZYg9DJJPPEVilHOCPao48eMGCzPE7sPxxqnDY3ts5QBz/rkICtxgy28oOvBLvd4Uc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713408394; c=relaxed/simple;
	bh=EWnyp9SNEcYCJoyKl94n+LgIAMCy5SuHVa2NQGvM52Y=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ByRhi29vLJ0mAXsWlJTsjrS0x73WkfzI/0j3xyGPYMJWUTMNxTq/NT2ylPz35f/frynXbB4t7RJBzpcR1l3iLUXUkc+D0gb11t1AKhCfbsfJNfX1UpYdj0S+VI2F1pFTVwM9y70pwcLqN4Yu8EePBGPeShoXr8Bhuqdt7NscGb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4VKhV76GC3z4f3lfD;
	Thu, 18 Apr 2024 10:26:23 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id CCA121A0572;
	Thu, 18 Apr 2024 10:26:32 +0800 (CST)
Received: from huaweicloud.com (unknown [10.67.174.26])
	by APP1 (Coremail) with SMTP id cCh0CgCXaBHXhCBmsYwXKQ--.24960S4;
	Thu, 18 Apr 2024 10:26:32 +0800 (CST)
From: Xiu Jianfeng <xiujianfeng@huaweicloud.com>
To: tj@kernel.org,
	lizefan.x@bytedance.com,
	hannes@cmpxchg.org
Cc: cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 -next] cgroup: don't call cgroup1_pidlist_destroy_all() for v2
Date: Thu, 18 Apr 2024 02:19:30 +0000
Message-Id: <20240418021930.914245-1-xiujianfeng@huaweicloud.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgCXaBHXhCBmsYwXKQ--.24960S4
X-Coremail-Antispam: 1UD129KBjvdXoW7JrWkXFWrArW8ZFWUWryUZFb_yoWfKFg_Ca
	4jvFyvgrWxZ3yq9asI9FsavFWvkrZ0qryv9wn5KrW7JFyUtrn8Jwn3urn3ZrsrCFZ3Gr98
	Cr9xCFyxtrn8KjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbokYFVCjjxCrM7AC8VAFwI0_Gr0_Xr1l1xkIjI8I6I8E6xAIw20E
	Y4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwV
	A0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVWDJVCq3wA2z4x0Y4vE2Ix0cI8IcVCY1x02
	67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I
	0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Y
	z7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zV
	AF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4l
	IxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWrZr1j6s
	0DMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsG
	vfC2KfnxnUUI43ZEXa7IU1zuWJUUUUU==
X-CM-SenderInfo: x0lxyxpdqiv03j6k3tpzhluzxrxghudrp/

From: Xiu Jianfeng <xiujianfeng@huawei.com>

Currently cgroup1_pidlist_destroy_all() will be called when releasing
cgroup even if the cgroup is on default hierarchy, however it doesn't
make any sense for v2 to destroy pidlist of v1.

Signed-off-by: Xiu Jianfeng <xiujianfeng@huawei.com>

---
v2: move the test to the caller
---
 kernel/cgroup/cgroup.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
index a66c088c851c..e32b6972c478 100644
--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -5368,7 +5368,8 @@ static void css_free_rwork_fn(struct work_struct *work)
 	} else {
 		/* cgroup free path */
 		atomic_dec(&cgrp->root->nr_cgrps);
-		cgroup1_pidlist_destroy_all(cgrp);
+		if (!cgroup_on_dfl(cgrp))
+			cgroup1_pidlist_destroy_all(cgrp);
 		cancel_work_sync(&cgrp->release_agent_work);
 		bpf_cgrp_storage_free(cgrp);
 
-- 
2.34.1


