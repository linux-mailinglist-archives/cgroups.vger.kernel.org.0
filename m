Return-Path: <cgroups+bounces-1720-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A3D7485D23E
	for <lists+cgroups@lfdr.de>; Wed, 21 Feb 2024 09:11:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C57A71C22E44
	for <lists+cgroups@lfdr.de>; Wed, 21 Feb 2024 08:11:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69D393BB2D;
	Wed, 21 Feb 2024 08:11:46 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A79A3B78D;
	Wed, 21 Feb 2024 08:11:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708503106; cv=none; b=AFbgVSTOv7glz1Zao6s6au5FzpTIaCiqEkJpZmOxNxN/v6H/4uloTU1AWZImgnaHIQR9NhLLncyFr8kn5zv9U+t0L0zliJApjqqIiTiaIdNkYKnMY499HWg/XjGg5A3g2c7ww/s8/qDijsr7aZM3BOpEFH+F50pxzE96vFKnJNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708503106; c=relaxed/simple;
	bh=+2+yAJpVza7viz8w2DkLR7wHx5qlz5d/JWVKzbzMLbQ=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=RzDpM62x27hkspPPn1/iriHDBUb3p7k4KbYvGisfS0d8kZRrUB5NMlWsIGatJjMjc0osLYhOSdSfTr4X2PIlbdRk9nssijDZKm8K8ZpgAQV+nG4x0rpUfhhWaCFmvzJTo0/ipNMhkrwWxUCLwGZOhV1gxIHsIi4HFaXamBUUmgI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.105])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4Tfpq72rMSzNlm7;
	Wed, 21 Feb 2024 16:10:11 +0800 (CST)
Received: from dggpemd100002.china.huawei.com (unknown [7.185.36.164])
	by mail.maildlp.com (Postfix) with ESMTPS id 55334140114;
	Wed, 21 Feb 2024 16:11:34 +0800 (CST)
Received: from huawei.com (10.67.174.33) by dggpemd100002.china.huawei.com
 (7.185.36.164) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.1258.28; Wed, 21 Feb
 2024 16:11:34 +0800
From: "GONG, Ruiqi" <gongruiqi1@huawei.com>
To: <linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>, Johannes Weiner
	<hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>, Roman Gushchin
	<roman.gushchin@linux.dev>, Shakeel Butt <shakeelb@google.com>, Muchun Song
	<muchun.song@linux.dev>
CC: <cgroups@vger.kernel.org>, <linux-mm@kvack.org>, Wang Weiyang
	<wangweiyang2@huawei.com>, Xiu Jianfeng <xiujianfeng@huawei.com>
Subject: [PATCH stable] memcg: add refcnt for pcpu stock to avoid UAF problem in drain_all_stock()
Date: Wed, 21 Feb 2024 16:18:01 +0800
Message-ID: <20240221081801.69764-1-gongruiqi1@huawei.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpemd100002.china.huawei.com (7.185.36.164)

commit 1a3e1f40962c445b997151a542314f3c6097f8c3 upstream.

There was a kernel panic happened on an in-house environment running
3.10, and the same problem was reproduced on 4.19:

general protection fault: 0000 [#1] SMP PTI
CPU: 1 PID: 2085 Comm: bash Kdump: loaded Tainted: G             L    4.19.90+ #7
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.15.0-0-g2dd4b9b3f840-prebuilt.qemu.org 04/01/2014
RIP: 0010 drain_all_stock+0xad/0x140
Code: 00 00 4d 85 ff 74 2c 45 85 c9 74 27 4d 39 fc 74 42 41 80 bc 24 28 04 00 00 00 74 17 49 8b 04 24 49 8b 17 48 8b 88 90 02 00 00 <48> 39 8a 90 02 00 00 74 02 eb 86 48 63 88 3c 01 00 00 39 8a 3c 01
RSP: 0018:ffffa7efc5813d70 EFLAGS: 00010202
RAX: ffff8cb185548800 RBX: ffff8cb89f420160 RCX: ffff8cb1867b6000
RDX: babababababababa RSI: 0000000000000001 RDI: 0000000000231876
RBP: 0000000000000000 R08: 0000000000000415 R09: 0000000000000002
R10: 0000000000000000 R11: 0000000000000001 R12: ffff8cb186f89040
R13: 0000000000020160 R14: 0000000000000001 R15: ffff8cb186b27040
FS:  00007f4a308d3740(0000) GS:ffff8cb89f440000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007ffe4d634a68 CR3: 000000010b022000 CR4: 00000000000006e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 mem_cgroup_force_empty_write+0x31/0xb0
 cgroup_file_write+0x60/0x140
 ? __check_object_size+0x136/0x147
 kernfs_fop_write+0x10e/0x190
 __vfs_write+0x37/0x1b0
 ? selinux_file_permission+0xe8/0x130
 ? security_file_permission+0x2e/0xb0
 vfs_write+0xb6/0x1a0
 ksys_write+0x57/0xd0
 do_syscall_64+0x63/0x250
 ? async_page_fault+0x8/0x30
 entry_SYSCALL_64_after_hwframe+0x5c/0xc1
Modules linked in: ...

It is found that in case of stock->nr_pages == 0, the memcg on
stock->cached could be freed due to its refcnt decreased to 0, which
made stock->cached become a dangling pointer. It could cause a UAF
problem in drain_all_stock() in the following concurrent scenario. Note
that drain_all_stock() doesn't disable irq but only preemption.

CPU1                             CPU2
==============================================================================
stock->cached = memcgA (freed)
                                 drain_all_stock(memcgB)
                                  rcu_read_lock()
                                  memcg = CPU1's stock->cached (memcgA)
                                  (interrupted)
refill_stock(memcgC)
 drain_stock(memcgA)
 stock->cached = memcgC
 stock->nr_pages += xxx (> 0)
                                  stock->nr_pages > 0
                                  mem_cgroup_is_descendant(memcgA, memcgB) [UAF]
                                  rcu_read_unlock()

This problem is, unintenionally, fixed at 5.9, where commit 1a3e1f40962c
("mm: memcontrol: decouple reference counting from page accounting")
adds memcg refcnt for stock. Therefore affected LTS versions include
4.19 and 5.4.

For 4.19, memcg's css offline process doesn't call drain_all_stock(). so
it's easier for the released memcg to be left on the stock. For 5.4,
although mem_cgroup_css_offline() does call drain_all_stock(), but the
flushing could be skipped when stock->nr_pages happens to be 0, and
besides the async draining could be delayed and take place after the UAF
problem has happened.

Fix this problem by adding (and decreasing) memcg's refcnt when memcg is
put onto (and removed from) stock, just like how commit 1a3e1f40962c
("mm: memcontrol: decouple reference counting from page accounting")
does. After all, "being on the stock" is a kind of reference with
regards to memcg. As such, it's guaranteed that a css on stock would not
be freed.

Cc: stable@vger.kernel.org      # 4.19 5.4
Fixes: cdec2e4265df ("memcg: coalesce charging via percpu storage")
Signed-off-by: GONG, Ruiqi <gongruiqi1@huawei.com>
---
 mm/memcontrol.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 5a366cf79821..8c04296df1c7 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -2015,6 +2015,9 @@ static void drain_stock(struct memcg_stock_pcp *stock)
 {
 	struct mem_cgroup *old = stock->cached;
 
+	if (!old)
+		return;
+
 	if (stock->nr_pages) {
 		page_counter_uncharge(&old->memory, stock->nr_pages);
 		if (do_memsw_account())
@@ -2022,6 +2025,8 @@ static void drain_stock(struct memcg_stock_pcp *stock)
 		css_put_many(&old->css, stock->nr_pages);
 		stock->nr_pages = 0;
 	}
+
+	css_put(&old->css);
 	stock->cached = NULL;
 }
 
@@ -2057,6 +2062,7 @@ static void refill_stock(struct mem_cgroup *memcg, unsigned int nr_pages)
 	stock = this_cpu_ptr(&memcg_stock);
 	if (stock->cached != memcg) { /* reset if necessary */
 		drain_stock(stock);
+		css_get(&memcg->css);
 		stock->cached = memcg;
 	}
 	stock->nr_pages += nr_pages;
-- 
2.25.1


