Return-Path: <cgroups+bounces-9198-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D7B7EB274DA
	for <lists+cgroups@lfdr.de>; Fri, 15 Aug 2025 03:49:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 34D533B1448
	for <lists+cgroups@lfdr.de>; Fri, 15 Aug 2025 01:49:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77A5B292B36;
	Fri, 15 Aug 2025 01:49:07 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A9341459F7;
	Fri, 15 Aug 2025 01:49:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755222547; cv=none; b=imMBUgffzw7r3BOz5fiiZgd+ER0EDFfR0SoPlCpmZdnSJ9od7P0wAvd8714dVEvVCobfcqgAbtPtymm31W1Nlc3x3xRS2uErSAaZ86xg/Ld9lcy4K+hV23Vw7Z1hJwqcddx4U5XTbu/KSlUxoNqA5XAN2E6tFyHL3MjYHMQiMS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755222547; c=relaxed/simple;
	bh=Z54yWXBe1NRvXtU74+14GPnATXdRJmNE1S2qdqNFXjg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=IqqQb5gHljyDqqBIMgUqSjEzeUZrXA6xruaO3YjajgQmSNGiVTJibBj0+bjnWk/NnLY23+oCb9XNGo5zrAiNh+kyuw2ADtJyBxDiohHaR/RVTPfFYiz4++kgxoXNA/E8rOMGScuKAON4g/omhzwIl45bEhrzR7ZEiOBHhexGFz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4c34ld3bgBzKHMtl;
	Fri, 15 Aug 2025 09:49:01 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.252])
	by mail.maildlp.com (Postfix) with ESMTP id CB02C1A07BB;
	Fri, 15 Aug 2025 09:49:00 +0800 (CST)
Received: from hulk-vt.huawei.com (unknown [10.67.174.121])
	by APP3 (Coremail) with SMTP id _Ch0CgBHwNoCkp5oaw2bDg--.60271S2;
	Fri, 15 Aug 2025 09:49:00 +0800 (CST)
From: Chen Ridong <chenridong@huaweicloud.com>
To: gregkh@linuxfoundation.org,
	tj@kernel.org,
	hannes@cmpxchg.org,
	mkoutny@suse.com,
	peterz@infradead.org,
	zhouchengming@bytedance.com
Cc: linux-kernel@vger.kernel.org,
	cgroups@vger.kernel.org,
	lujialin4@huawei.com,
	chenridong@huawei.com
Subject: [PATCH] kernfs: Fix UAF in PSI polling when open file is released
Date: Fri, 15 Aug 2025 01:34:29 +0000
Message-Id: <20250815013429.1255241-1-chenridong@huaweicloud.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_Ch0CgBHwNoCkp5oaw2bDg--.60271S2
X-Coremail-Antispam: 1UD129KBjvJXoWxGF4rKryxWw1UCr1UtF43Wrg_yoW5uFy7pa
	n8Ary8G395Xr1DCrs7ta409F1rCan7Xay7Wan7G39ay3W3tr1vywn29r1Yqr1kAFs3JrZF
	qF9I93yjkw4YyF7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUv2b4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7MxkF7I0E
	n4kS14v26r1q6r43MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I
	0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWU
	tVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcV
	CY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAF
	wI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa
	7IU17KsUUUUUU==
X-CM-SenderInfo: hfkh02xlgr0w46kxt4xhlfz01xgou0bp/

From: Chen Ridong <chenridong@huawei.com>

A use-after-free (UAF) vulnerability was identified in the PSI (Pressure
Stall Information) monitoring mechanism:

BUG: KASAN: slab-use-after-free in psi_trigger_poll+0x3c/0x140
Read of size 8 at addr ffff3de3d50bd308 by task systemd/1

psi_trigger_poll+0x3c/0x140
cgroup_pressure_poll+0x70/0xa0
cgroup_file_poll+0x8c/0x100
kernfs_fop_poll+0x11c/0x1c0
ep_item_poll.isra.0+0x188/0x2c0

Allocated by task 1:
cgroup_file_open+0x88/0x388
kernfs_fop_open+0x73c/0xaf0
do_dentry_open+0x5fc/0x1200
vfs_open+0xa0/0x3f0
do_open+0x7e8/0xd08
path_openat+0x2fc/0x6b0
do_filp_open+0x174/0x368

Freed by task 8462:
cgroup_file_release+0x130/0x1f8
kernfs_drain_open_files+0x17c/0x440
kernfs_drain+0x2dc/0x360
kernfs_show+0x1b8/0x288
cgroup_file_show+0x150/0x268
cgroup_pressure_write+0x1dc/0x340
cgroup_file_write+0x274/0x548

Reproduction Steps:
1. Open test/cpu.pressure and establish epoll monitoring
2. Disable monitoring: echo 0 > test/cgroup.pressure
3. Re-enable monitoring: echo 1 > test/cgroup.pressure

The race condition occurs because:
1. When cgroup.pressure is disabled (echo 0 > cgroup.pressure), it:
   - Releases PSI triggers via cgroup_file_release()
   - Frees of->priv through kernfs_drain_open_files()
2. While epoll still holds reference to the file and continues polling
3. Re-enabling (echo 1 > cgroup.pressure) accesses freed of->priv

epolling			disable/enable cgroup.pressure
fd=open(cpu.pressure)
while(1)
...
epoll_wait
kernfs_fop_poll
kernfs_get_active = true	echo 0 > cgroup.pressure
...				cgroup_file_show
				kernfs_show
				// inactive kn
				kernfs_drain_open_files
				cft->release(of);
				kfree(ctx);
				...
kernfs_get_active = false
				echo 1 > cgroup.pressure
				kernfs_show
				kernfs_activate_one(kn);
kernfs_fop_poll
kernfs_get_active = true
cgroup_file_poll
psi_trigger_poll
// UAF
...
end: close(fd)

Fix this by adding released flag check in kernfs_fop_poll(), which is
treated as kn is inactive.

Fixes: 34f26a15611a ("sched/psi: Per-cgroup PSI accounting disable/re-enable interface")
Reported-by: Zhang Zhantian <zhangzhaotian@huawei.com>
Signed-off-by: Chen Ridong <chenridong@huawei.com>
---
 fs/kernfs/file.c       | 2 +-
 kernel/cgroup/cgroup.c | 1 +
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/kernfs/file.c b/fs/kernfs/file.c
index a6c692cac616..d5d01f0b9392 100644
--- a/fs/kernfs/file.c
+++ b/fs/kernfs/file.c
@@ -852,7 +852,7 @@ static __poll_t kernfs_fop_poll(struct file *filp, poll_table *wait)
 	struct kernfs_node *kn = kernfs_dentry_node(filp->f_path.dentry);
 	__poll_t ret;
 
-	if (!kernfs_get_active(kn))
+	if (of->released || !kernfs_get_active(kn))
 		return DEFAULT_POLLMASK|EPOLLERR|EPOLLPRI;
 
 	if (kn->attr.ops->poll)
diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
index 312c6a8b55bb..d8b82afed181 100644
--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -4159,6 +4159,7 @@ static void cgroup_file_release(struct kernfs_open_file *of)
 		cft->release(of);
 	put_cgroup_ns(ctx->ns);
 	kfree(ctx);
+	of->priv = NULL;
 }
 
 static ssize_t cgroup_file_write(struct kernfs_open_file *of, char *buf,
-- 
2.34.1


