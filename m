Return-Path: <cgroups+bounces-6497-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F123DA305C0
	for <lists+cgroups@lfdr.de>; Tue, 11 Feb 2025 09:29:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 861A618861D1
	for <lists+cgroups@lfdr.de>; Tue, 11 Feb 2025 08:29:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CC991EEA59;
	Tue, 11 Feb 2025 08:29:26 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D83E1EEA47;
	Tue, 11 Feb 2025 08:29:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739262566; cv=none; b=ptKoUhR2iDKrbpn97t3SnZJ2mKAns15+ECCuZMDYqioXuFGdwrbgu251UNtUCSKYrHChTv8/BjqVBiDg43Pc8fxgJCFD7uEorsKsQ+89IbaUY6tEkVHISYO3F7C+6SqiT9i02QZSzu4sfhS5EtdFnDyIEPrLyldRp9xHjCOMk0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739262566; c=relaxed/simple;
	bh=5mLlG7UJKSNSJiUN+gLdBG8mvz50NDCZxBPd4G5dwuU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=gaJLs1yqPLF6o1WrcV1BaPueZdJ0WeHnB1S3Ji0Mg+Ygis8coq8np0zoQGrMOabAM0Xk4V2Jo0ZnYsElNSnO60sk6kEYANsT1akEbKVP7TfIODlrKKvUYFCC6/+xPxYGCVQnpAzVVviJwdfP/p+S8y4aQYYuVS7aUv2iEW7QwOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4YsZNL4kw6z4f3lCm;
	Tue, 11 Feb 2025 16:28:50 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.252])
	by mail.maildlp.com (Postfix) with ESMTP id 55B631A0CA9;
	Tue, 11 Feb 2025 16:29:13 +0800 (CST)
Received: from hulk-vt.huawei.com (unknown [10.67.174.121])
	by APP3 (Coremail) with SMTP id _Ch0CgAHp8FICqtnfiPrDQ--.42730S2;
	Tue, 11 Feb 2025 16:29:13 +0800 (CST)
From: Chen Ridong <chenridong@huaweicloud.com>
To: hannes@cmpxchg.org,
	mhocko@kernel.org,
	roman.gushchin@linux.dev,
	shakeel.butt@linux.dev,
	muchun.song@linux.dev,
	akpm@linux-foundation.org
Cc: cgroups@vger.kernel.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	chenridong@huawei.com,
	wangweiyang2@huawei.com
Subject: [PATCH] memcg: avoid dead loop when setting memory.max
Date: Tue, 11 Feb 2025 08:18:19 +0000
Message-Id: <20250211081819.33307-1-chenridong@huaweicloud.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_Ch0CgAHp8FICqtnfiPrDQ--.42730S2
X-Coremail-Antispam: 1UD129KBjvJXoWxJw1fZr4DXw15ZF4ftw1kXwb_yoW5Cw1DpF
	13Jw1UGF48Jr1kXr4UJF1fWr15Ga1kCFy7JrW7ur1rA3ZxG3WUJ34rK3yUXryDXr1rZr1a
	vF1DJw4xtw4DJaUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUv2b4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7MxkF7I0E
	n4kS14v26r1q6r43MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I
	0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWU
	tVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcV
	CY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAF
	wI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa
	7IUbmii3UUUUU==
X-CM-SenderInfo: hfkh02xlgr0w46kxt4xhlfz01xgou0bp/

From: Chen Ridong <chenridong@huawei.com>

A softlockup issue was found with stress test:
 watchdog: BUG: soft lockup - CPU#27 stuck for 26s! [migration/27:181]
 CPU: 27 UID: 0 PID: 181 Comm: migration/27 6.14.0-rc2-next-20250210 #1
 Stopper: multi_cpu_stop <- stop_machine_from_inactive_cpu
 RIP: 0010:stop_machine_yield+0x2/0x10
 RSP: 0000:ff4a0dcecd19be48 EFLAGS: 00000246
 RAX: ffffffff89c0108f RBX: ff4a0dcec03afe44 RCX: 0000000000000000
 RDX: ff1cdaaf6eba5808 RSI: 0000000000000282 RDI: ff1cda80c1775a40
 RBP: 0000000000000001 R08: 00000011620096c6 R09: 7fffffffffffffff
 R10: 0000000000000001 R11: 0000000000000100 R12: ff1cda80c1775a40
 R13: 0000000000000000 R14: 0000000000000001 R15: ff4a0dcec03afe20
 FS:  0000000000000000(0000) GS:ff1cdaaf6eb80000(0000)
 CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
 CR2: 0000000000000000 CR3: 00000025e2c2a001 CR4: 0000000000773ef0
 DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
 DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
 PKRU: 55555554
 Call Trace:
  multi_cpu_stop+0x8f/0x100
  cpu_stopper_thread+0x90/0x140
  smpboot_thread_fn+0xad/0x150
  kthread+0xc2/0x100
  ret_from_fork+0x2d/0x50

The stress test involves CPU hotplug operations and memory control group
(memcg) operations. The scenario can be described as follows:

 echo xx > memory.max 	cache_ap_online			oom_reaper
 (CPU23)						(CPU50)
 xx < usage		stop_machine_from_inactive_cpu
 for(;;)			// all active cpus
 trigger OOM		queue_stop_cpus_work
 // waiting oom_reaper
 			multi_cpu_stop(migration/xx)
 			// sync all active cpus ack
 			// waiting cpu23 ack
 			// CPU50 loops in multi_cpu_stop
 							waiting cpu50

Detailed explanation:
1. When the usage is larger than xx, an OOM may be triggered. If the
   process does not handle with ths kill signal immediately, it will loop
   in the memory_max_write.
2. When cache_ap_online is triggered, the multi_cpu_stop is queued to the
   active cpus. Within the multi_cpu_stop function,  it attempts to
   synchronize the CPU states. However, the CPU23 didn't acknowledge
   because it is stuck in a loop within the for(;;).
3. The oom_reaper process is blocked because CPU50 is in a loop, waiting
   for CPU23 to acknowledge the synchronization request.
4. Finally, it formed cyclic dependency and lead to softlockup and dead
   loop.

To fix this issue, add cond_resched() in the memory_max_write, so that
it will not block migration task.

Fixes: b6e6edcfa405 ("mm: memcontrol: reclaim and OOM kill when shrinking memory.max below usage")
Signed-off-by: Chen Ridong <chenridong@huawei.com>
---
 mm/memcontrol.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 8d21c1a44220..16f3bdbd37d8 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -4213,6 +4213,7 @@ static ssize_t memory_max_write(struct kernfs_open_file *of,
 		memcg_memory_event(memcg, MEMCG_OOM);
 		if (!mem_cgroup_out_of_memory(memcg, GFP_KERNEL, 0))
 			break;
+		cond_resched();
 	}
 
 	memcg_wb_domain_size_changed(memcg);
-- 
2.34.1


