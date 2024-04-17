Return-Path: <cgroups+bounces-2557-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D26F48A7A78
	for <lists+cgroups@lfdr.de>; Wed, 17 Apr 2024 04:20:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8C6CB283AD3
	for <lists+cgroups@lfdr.de>; Wed, 17 Apr 2024 02:20:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E127B79E0;
	Wed, 17 Apr 2024 02:20:40 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B75E4690;
	Wed, 17 Apr 2024 02:20:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713320440; cv=none; b=QVV52H1JVBg2csrZtFx2sJDIJyo/PJWCCIVhCN+gRk9M2i+iHC6Pf8OJ9J0bWK1p8vvPaektoWaR41MddXPhHUvAea09ja8krwN0/ESTrSF7KKSk+3RwyVnI6u/bz1F1/WtfgKm9QV7QH9tBgDdFBE6Ys4NDi3cyCUrSKDwXXqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713320440; c=relaxed/simple;
	bh=O/kGnqJdzeQNFQSSx2VGenOa0lWt9blEJEfyihoQbos=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=AEa+JEhiu77z4l+bpQmckt7ybNNeJWb5XUdilbY7ddn6d+xIQSnI0gJx8rDbMR4RZ1+oLfLRajwOaSPGf3p4hnx1OLJeLC2xhvzVWhvfbdY7wPxLsVgjJUhSyoHB/ZT1ffJXOMUaYObFHnnmckRBghaCIoXL3Dnb/giNDVihDHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4VK4Pg5kXsz4f3pr3;
	Wed, 17 Apr 2024 10:20:23 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 6B1F41A04C2;
	Wed, 17 Apr 2024 10:20:28 +0800 (CST)
Received: from huaweicloud.com (unknown [10.67.174.26])
	by APP1 (Coremail) with SMTP id cCh0CgAX5g7rMR9mdhjAKA--.50594S4;
	Wed, 17 Apr 2024 10:20:28 +0800 (CST)
From: Xiu Jianfeng <xiujianfeng@huaweicloud.com>
To: tj@kernel.org,
	lizefan.x@bytedance.com,
	hannes@cmpxchg.org
Cc: cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH -next] cgroup: don't call cgroup1_pidlist_destroy_all() for v2
Date: Wed, 17 Apr 2024 02:13:59 +0000
Message-Id: <20240417021359.883736-1-xiujianfeng@huaweicloud.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgAX5g7rMR9mdhjAKA--.50594S4
X-Coremail-Antispam: 1UD129KBjvdXoW7JrWkXFWrAF1UKF45GFW8Crg_yoWfCFg_A3
	4xXFyvqryxZw1kuFsFvrn5ZFZ5Cr45Kr1qkwnIyrWUJF1Utwn8Jwn3ZFn5ArZxuFWxKrn8
	Cr9xXa93trn0gjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
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
 kernel/cgroup/cgroup-v1.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/cgroup/cgroup-v1.c b/kernel/cgroup/cgroup-v1.c
index 520a11cb12f4..46d89157d558 100644
--- a/kernel/cgroup/cgroup-v1.c
+++ b/kernel/cgroup/cgroup-v1.c
@@ -197,6 +197,8 @@ void cgroup1_pidlist_destroy_all(struct cgroup *cgrp)
 {
 	struct cgroup_pidlist *l, *tmp_l;
 
+	if (cgroup_on_dfl(cgrp))
+		return;
 	mutex_lock(&cgrp->pidlist_mutex);
 	list_for_each_entry_safe(l, tmp_l, &cgrp->pidlists, links)
 		mod_delayed_work(cgroup_pidlist_destroy_wq, &l->destroy_dwork, 0);
-- 
2.34.1


