Return-Path: <cgroups+bounces-13601-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uKBrLBqcgGl2/wIAu9opvQ
	(envelope-from <cgroups+bounces-13601-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Mon, 02 Feb 2026 13:44:10 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 330B0CC727
	for <lists+cgroups@lfdr.de>; Mon, 02 Feb 2026 13:44:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A16F1303FFD4
	for <lists+cgroups@lfdr.de>; Mon,  2 Feb 2026 12:42:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C583036655E;
	Mon,  2 Feb 2026 12:42:19 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DB772E7185;
	Mon,  2 Feb 2026 12:42:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770036139; cv=none; b=A2snzJIRCqeBJcQsBYR01Pbjnun2mzK7SP263jwB43Slrv9/oRZC1kcZe/SrIZnNvGT4eUy7+2jci1CGdSkSFtr4d7lmOO6AoHPOiEIeVb5adxj1XDDdSfaa6eKnszuKUUPay8bqVVsmsxiWNXtNW0DVz+TiO7TiRfP2bxlHSrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770036139; c=relaxed/simple;
	bh=SyqtQPnPXw0GUmPyHRqgLP2+GiVntEoeujEnzZN995Y=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=g3xrjbQFku9bu0slh+4EBqURnQWdXI4Eimdv//FixGAEbSkRhEVU3bx1LW03/JlWVPImQHSSYa3YZa+99iGoxDWlR553tXRULkNOMyQQgBnq12O3qo2LMT8zBGSMq6vpPzGnAMZoVFem64qaqYXm0b0Xy19H30acuaauL6ZkL4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.177])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4f4R7S5C3PzYQv5x;
	Mon,  2 Feb 2026 20:41:24 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 6D47F40593;
	Mon,  2 Feb 2026 20:42:10 +0800 (CST)
Received: from hulk-vt.huawei.com (unknown [10.67.174.121])
	by APP1 (Coremail) with SMTP id cCh0CgDXj+WWm4Bpt7ipFw--.14648S3;
	Mon, 02 Feb 2026 20:42:10 +0800 (CST)
From: Chen Ridong <chenridong@huaweicloud.com>
To: dev@lankhorst.se,
	mripard@kernel.org,
	natalie.vock@gmx.de,
	tj@kernel.org,
	hannes@cmpxchg.org,
	mkoutny@suse.com
Cc: cgroups@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	lujialin4@huawei.com,
	chenridong@huaweicloud.com
Subject: [PATCH -next v2 1/4] cgroup/dmem: fix NULL pointer dereference when setting max
Date: Mon,  2 Feb 2026 12:27:16 +0000
Message-Id: <20260202122719.414466-2-chenridong@huaweicloud.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260202122719.414466-1-chenridong@huaweicloud.com>
References: <20260202122719.414466-1-chenridong@huaweicloud.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgDXj+WWm4Bpt7ipFw--.14648S3
X-Coremail-Antispam: 1UD129KBjvJXoW7CFWrtF1xXryrAryDtF4ruFg_yoW8uFyxpr
	1rGryUCr48tr1UAF40vF15Zry5GF4xAa17Jwn7Jwn5JF1UKw1UtrykJ3yUJF98Jry7uw4I
	qFn8Zw4Iq345taUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUm014x267AKxVW5JVWrJwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_Jr4l82xGYIkIc2
	x26xkF7I0E14v26r4j6ryUM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0
	Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F4UJw
	A2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq3wAS
	0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2
	IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0
	Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628vn2kIc2
	xKxwCY1x0262kKe7AKxVWUtVW8ZwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWU
	JVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67
	kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY
	6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0x
	vEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVj
	vjDU0xZFpf9x0JU2dgAUUUUU=
X-CM-SenderInfo: hfkh02xlgr0w46kxt4xhlfz01xgou0bp/
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.04 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-13601-lists,cgroups=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FREEMAIL_TO(0.00)[lankhorst.se,kernel.org,gmx.de,cmpxchg.org,suse.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DMARC_NA(0.00)[huaweicloud.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	RCPT_COUNT_SEVEN(0.00)[11];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[chenridong@huaweicloud.com,cgroups@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_FIVE(0.00)[6];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	R_DKIM_NA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[huaweicloud.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,huawei.com:email]
X-Rspamd-Queue-Id: 330B0CC727
X-Rspamd-Action: no action

From: Chen Ridong <chenridong@huawei.com>

An issue was triggered:

 BUG: kernel NULL pointer dereference, address: 0000000000000000
 #PF: supervisor read access in kernel mode
 #PF: error_code(0x0000) - not-present page
 PGD 0 P4D 0
 Oops: Oops: 0000 [#1] SMP NOPTI
 CPU: 15 UID: 0 PID: 658 Comm: bash Tainted: 6.19.0-rc6-next-2026012
 Tainted: [O]=OOT_MODULE
 Hardware name: QEMU Standard PC (i440FX + PIIX, 1996),
 RIP: 0010:strcmp+0x10/0x30
 RSP: 0018:ffffc900017f7dc0 EFLAGS: 00000246
 RAX: 0000000000000000 RBX: 0000000000000000 RCX: ffff888107cd4358
 RDX: 0000000019f73907 RSI: ffffffff82cc381a RDI: 0000000000000000
 RBP: ffff8881016bef0d R08: 000000006c0e7145 R09: 0000000056c0e714
 R10: 0000000000000001 R11: ffff888107cd4358 R12: 0007ffffffffffff
 R13: ffff888101399200 R14: ffff888100fcb360 R15: 0007ffffffffffff
 CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
 CR2: 0000000000000000 CR3: 0000000105c79000 CR4: 00000000000006f0
 Call Trace:
  <TASK>
  dmemcg_limit_write.constprop.0+0x16d/0x390
  ? __pfx_set_resource_max+0x10/0x10
  kernfs_fop_write_iter+0x14e/0x200
  vfs_write+0x367/0x510
  ksys_write+0x66/0xe0
  do_syscall_64+0x6b/0x390
  entry_SYSCALL_64_after_hwframe+0x76/0x7e
 RIP: 0033:0x7f42697e1887

It was trriggered setting max without limitation, the command is like:
"echo test/region0 > dmem.max". To fix this issue, add check whether
options is valid after parsing the region_name.

Fixes: b168ed458dde ("kernel/cgroup: Add "dmem" memory accounting cgroup")
Signed-off-by: Chen Ridong <chenridong@huawei.com>
---
 kernel/cgroup/dmem.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/kernel/cgroup/dmem.c b/kernel/cgroup/dmem.c
index e12b946278b6..1f0d6caaf2fb 100644
--- a/kernel/cgroup/dmem.c
+++ b/kernel/cgroup/dmem.c
@@ -700,6 +700,9 @@ static ssize_t dmemcg_limit_write(struct kernfs_open_file *of,
 		if (!region_name[0])
 			continue;
 
+		if (!options || !*options)
+			return -EINVAL;
+
 		rcu_read_lock();
 		region = dmemcg_get_region_by_name(region_name);
 		rcu_read_unlock();
-- 
2.34.1


