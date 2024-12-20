Return-Path: <cgroups+bounces-5972-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AAB19F89A9
	for <lists+cgroups@lfdr.de>; Fri, 20 Dec 2024 02:43:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9DD701889F8D
	for <lists+cgroups@lfdr.de>; Fri, 20 Dec 2024 01:43:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13A1B1CD1F;
	Fri, 20 Dec 2024 01:41:15 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EAD11DFF8;
	Fri, 20 Dec 2024 01:41:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734658874; cv=none; b=PlUpaKjOFvwFjwYF+lsxAN7P2Rq4AVWu35plmIA8vRI/XPprXxpkECQIWgHBnHtYvJvX1GmwgDVPmmDjkVI9sQZaNQp0G/V6OQAcyk8jlijMiFOTwuhZQpGL2p8/hrJQscCPLX6nrqN2wtgZEdOSzDKZv/lP/U3D8dIswzcWAaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734658874; c=relaxed/simple;
	bh=cAtkpaDubJzwXHyDSAiKRXfgZ0+JdCkvoX29uraEaFc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=DxEDFsMmIKvxg+0KOzw7uz+taJ5iMa5BWriI78Ctf8MhioijzU4/XDSab25Gp955RtD8hRPD7onibaD72fVcYGQllvHsdj63W5+jwWis1XVfSYl/NPAz5KKsUK+VEr7BUt318DiOfZwG66fuV/4IcBmigrW3jgVmRoboYhSb2no=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4YDqqz264Kz4f3lDG;
	Fri, 20 Dec 2024 09:40:47 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id DC94B1A018D;
	Fri, 20 Dec 2024 09:41:07 +0800 (CST)
Received: from hulk-vt.huawei.com (unknown [10.67.174.121])
	by APP4 (Coremail) with SMTP id gCh0CgDXsYUoy2Rn+5BgFA--.16396S2;
	Fri, 20 Dec 2024 09:41:07 +0800 (CST)
From: Chen Ridong <chenridong@huaweicloud.com>
To: tj@kernel.org,
	hannes@cmpxchg.org,
	longman@redhat.com,
	mkoutny@suse.com,
	roman.gushchin@linux.dev
Cc: cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	chenridong@huawei.com,
	wangweiyang2@huawei.com
Subject: [PATCH v1] cgroup/cpuset: remove kernfs active break
Date: Fri, 20 Dec 2024 01:31:06 +0000
Message-Id: <20241220013106.3603227-1-chenridong@huaweicloud.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgDXsYUoy2Rn+5BgFA--.16396S2
X-Coremail-Antispam: 1UD129KBjvJXoWxAryrXrW5Zw1xuF1xtFyDtrb_yoWrtw18pF
	nxGry7Gr48Gr1UCw4DJr18Zw18t39rAFW7Jwn7Xr10va4Uuw1vyryUWrs5WrWUJry3t342
	yFnxXw48tw1UAw7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUv2b4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
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

A warning was found:

WARNING: CPU: 10 PID: 3486953 at fs/kernfs/file.c:828
CPU: 10 PID: 3486953 Comm: rmdir Kdump: loaded Tainted: G
RIP: 0010:kernfs_should_drain_open_files+0x1a1/0x1b0
RSP: 0018:ffff8881107ef9e0 EFLAGS: 00010202
RAX: 0000000080000002 RBX: ffff888154738c00 RCX: dffffc0000000000
RDX: 0000000000000007 RSI: 0000000000000004 RDI: ffff888154738c04
RBP: ffff888154738c04 R08: ffffffffaf27fa15 R09: ffffed102a8e7180
R10: ffff888154738c07 R11: 0000000000000000 R12: ffff888154738c08
R13: ffff888750f8c000 R14: ffff888750f8c0e8 R15: ffff888154738ca0
FS:  00007f84cd0be740(0000) GS:ffff8887ddc00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000555f9fbe00c8 CR3: 0000000153eec001 CR4: 0000000000370ee0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 kernfs_drain+0x15e/0x2f0
 __kernfs_remove+0x165/0x300
 kernfs_remove_by_name_ns+0x7b/0xc0
 cgroup_rm_file+0x154/0x1c0
 cgroup_addrm_files+0x1c2/0x1f0
 css_clear_dir+0x77/0x110
 kill_css+0x4c/0x1b0
 cgroup_destroy_locked+0x194/0x380
 cgroup_rmdir+0x2a/0x140

It can be explained by:
rmdir 				echo 1 > cpuset.cpus
				kernfs_fop_write_iter // active=0
cgroup_rm_file
kernfs_remove_by_name_ns	kernfs_get_active // active=1
__kernfs_remove					  // active=0x80000002
kernfs_drain			cpuset_write_resmask
wait_event
//waiting (active == 0x80000001)
				kernfs_break_active_protection
				// active = 0x80000001
// continue
				kernfs_unbreak_active_protection
				// active = 0x80000002
...
kernfs_should_drain_open_files
// warning occurs
				kernfs_put_active

This warning is caused by 'kernfs_break_active_protection' when it is
writing to cpuset.cpus, and the cgroup is removed concurrently.

The commit 3a5a6d0c2b03 ("cpuset: don't nest cgroup_mutex inside
get_online_cpus()") made cpuset_hotplug_workfn asynchronous, which grabs
the cgroup_mutex. To avoid deadlock. the commit 76bb5ab8f6e3 ("cpuset:
break kernfs active protection in cpuset_write_resmask()") added
'kernfs_break_active_protection' in the cpuset_write_resmask. This could
lead to this warning.

After the commit 2125c0034c5d ("cgroup/cpuset: Make cpuset hotplug
processing synchronous"), the cpuset_write_resmask no longer needs to
wait the hotplug to finish, which means that cpuset_write_resmask won't
grab the cgroup_mutex. So the deadlock doesn't exist anymore. Therefore,
remove kernfs_break_active_protection operation in the
'cpuset_write_resmask'

Fixes: 76bb5ab8f6e3 ("cpuset: break kernfs active protection in cpuset_write_resmask()")
Reported-by: Ji Fa <jifa@huawei.com>
Signed-off-by: Chen Ridong <chenridong@huawei.com>
---
 kernel/cgroup/cpuset.c | 25 -------------------------
 1 file changed, 25 deletions(-)

diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
index 7ea559fb0cbf..0f910c828973 100644
--- a/kernel/cgroup/cpuset.c
+++ b/kernel/cgroup/cpuset.c
@@ -3124,29 +3124,6 @@ ssize_t cpuset_write_resmask(struct kernfs_open_file *of,
 	int retval = -ENODEV;
 
 	buf = strstrip(buf);
-
-	/*
-	 * CPU or memory hotunplug may leave @cs w/o any execution
-	 * resources, in which case the hotplug code asynchronously updates
-	 * configuration and transfers all tasks to the nearest ancestor
-	 * which can execute.
-	 *
-	 * As writes to "cpus" or "mems" may restore @cs's execution
-	 * resources, wait for the previously scheduled operations before
-	 * proceeding, so that we don't end up keep removing tasks added
-	 * after execution capability is restored.
-	 *
-	 * cpuset_handle_hotplug may call back into cgroup core asynchronously
-	 * via cgroup_transfer_tasks() and waiting for it from a cgroupfs
-	 * operation like this one can lead to a deadlock through kernfs
-	 * active_ref protection.  Let's break the protection.  Losing the
-	 * protection is okay as we check whether @cs is online after
-	 * grabbing cpuset_mutex anyway.  This only happens on the legacy
-	 * hierarchies.
-	 */
-	css_get(&cs->css);
-	kernfs_break_active_protection(of->kn);
-
 	cpus_read_lock();
 	mutex_lock(&cpuset_mutex);
 	if (!is_cpuset_online(cs))
@@ -3179,8 +3156,6 @@ ssize_t cpuset_write_resmask(struct kernfs_open_file *of,
 out_unlock:
 	mutex_unlock(&cpuset_mutex);
 	cpus_read_unlock();
-	kernfs_unbreak_active_protection(of->kn);
-	css_put(&cs->css);
 	flush_workqueue(cpuset_migrate_mm_wq);
 	return retval ?: nbytes;
 }
-- 
2.34.1


