Return-Path: <cgroups+bounces-14237-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eKzfFE1RnmmbUgQAu9opvQ
	(envelope-from <cgroups+bounces-14237-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Wed, 25 Feb 2026 02:33:01 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6503F18EF8C
	for <lists+cgroups@lfdr.de>; Wed, 25 Feb 2026 02:33:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 1D7B6305C922
	for <lists+cgroups@lfdr.de>; Wed, 25 Feb 2026 01:29:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F32E25228D;
	Wed, 25 Feb 2026 01:29:54 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85F0E2522A7;
	Wed, 25 Feb 2026 01:29:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771982994; cv=none; b=tyK2ffj4mMaZWeFhomeSEFhijd1kVJasHF4+sF/bVQw+SmA9ecnWuzUKqCSdHduQgEs+OE1Uut+77xwvavDFopC5pBuv6NWQWfBA0+hp3xF1twnJ550drJU22sxjAkGrkhm7oiMuogXemQUG3l82SVVJIvzeF0ty5nsP2K9daMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771982994; c=relaxed/simple;
	bh=OuZodcWZBPPn09Jv7V1ezRzKFZ4o2WvGDzqsFjEmv9k=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Zv3JILtp95dqSdES/LZAZoMOEsJGGVcH7JaeTv6mLiOG/9XeF6MmYC8meTz/CHd3xcGK2Wya1/F/+pmAjBWI678XUsWhUXC4FmUSSdBMvwF9YBrovFB9mnjQrNatoCHrZAeTpC1WqpvRiKrQdgU7k3YpPNqjEVNOAkS0Gkf7t+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.177])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4fLH6s67VSzKHMKG;
	Wed, 25 Feb 2026 09:28:53 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id DF2F54058C;
	Wed, 25 Feb 2026 09:29:48 +0800 (CST)
Received: from hulk-vt.huawei.com (unknown [10.67.174.121])
	by APP4 (Coremail) with SMTP id gCh0CgC3Y_SHUJ5pTLChIg--.61220S2;
	Wed, 25 Feb 2026 09:29:48 +0800 (CST)
From: Chen Ridong <chenridong@huaweicloud.com>
To: longman@redhat.com,
	chenridong@huaweicloud.com,
	tj@kernel.org,
	hannes@cmpxchg.org,
	mkoutny@suse.com
Cc: cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	lujialin4@huawei.com
Subject: [PATCH -next] cgroup/cpuset: fix null-ptr-deref in rebuild_sched_domains_cpuslocked
Date: Wed, 25 Feb 2026 01:15:23 +0000
Message-Id: <20260225011523.51365-1-chenridong@huaweicloud.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgC3Y_SHUJ5pTLChIg--.61220S2
X-Coremail-Antispam: 1UD129KBjvJXoWxAr18Gr4fJFWrJry5Cr15Arb_yoW5Xry8pF
	WjgrWUGrWFgr1UAr4q9a45Zr1F9anrAF17JwnrGr1kJF1UW3WUGr1kXa17WryDXr17C347
	JF1DZw4xtr1UtaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUkG14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_Jrv_JF1lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lc7CjxVAaw2AFwI0_
	JF0_Jw1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67
	AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIY
	rxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14
	v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8
	JwCI42IY6I8E87Iv6xkF7I0E14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x0JUQo7NUUU
	UU=
X-CM-SenderInfo: hfkh02xlgr0w46kxt4xhlfz01xgou0bp/
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.04 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	NEURAL_HAM(-0.00)[-1.000];
	FROM_NEQ_ENVFROM(0.00)[chenridong@huaweicloud.com,cgroups@vger.kernel.org];
	TAGGED_RCPT(0.00)[cgroups];
	RCVD_COUNT_FIVE(0.00)[6];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_SEVEN(0.00)[8];
	R_DKIM_NA(0.00)[];
	DMARC_NA(0.00)[huaweicloud.com];
	TAGGED_FROM(0.00)[bounces-14237-lists,cgroups=lfdr.de];
	PRECEDENCE_BULK(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[]
X-Rspamd-Queue-Id: 6503F18EF8C
X-Rspamd-Action: no action

From: Chen Ridong <chenridong@huawei.com>

A null-pointer-dereference bug was reported by syzbot:

Oops: general protection fault, probably for address 0xdffffc0000000000:
KASAN: null-ptr-deref in range [0x0000000000000000-0x0000000000000007]
RIP: 0010:bitmap_subset include/linux/bitmap.h:433 [inline]
RIP: 0010:cpumask_subset include/linux/cpumask.h:836 [inline]
RIP: 0010:rebuild_sched_domains_locked kernel/cgroup/cpuset.c:967
RSP: 0018:ffffc90003ecfbc0 EFLAGS: 00010246
RAX: 0000000000000000 RBX: 0000000000000001 RCX: 0000000000000020
RDX: ffff888028de0000 RSI: ffffffff8200f003 RDI: ffffffff8df14f28
RBP: 0000000000000000 R08: 0000000000000cc0 R09: 00000000ffffffff
R10: ffffffff8e7d95b3 R11: 0000000000000001 R12: 0000000000000000
R13: 00000000000f4240 R14: dffffc0000000000 R15: 0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000001b2f463fff CR3: 000000003704c000 CR4: 00000000003526f0
Call Trace:
 <TASK>
 rebuild_sched_domains_cpuslocked kernel/cgroup/cpuset.c:983 [inline]
 rebuild_sched_domains+0x21/0x40 kernel/cgroup/cpuset.c:990
 sched_rt_handler+0xb5/0xe0 kernel/sched/rt.c:2911
 proc_sys_call_handler+0x47f/0x5a0 fs/proc/proc_sysctl.c:600
 new_sync_write fs/read_write.c:595 [inline]
 vfs_write+0x6ac/0x1070 fs/read_write.c:688
 ksys_write+0x12a/0x250 fs/read_write.c:740
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0x106/0xf80 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

The issue occurs when generate_sched_domains() returns ndoms = 1 and
doms = NULL due to a kmalloc failure. This leads to a null-pointer
dereference when accessing doms in rebuild_sched_domains_locked().

Fix this by adding a NULL check for doms before accessing it.

Fixes: 6ee43047e8ad ("cpuset: Remove unnecessary checks in rebuild_sched_domains_locked")
Reported-by: syzbot+460792609a79c085f79f@syzkaller.appspotmail.com
Signed-off-by: Chen Ridong <chenridong@huawei.com>
---
 kernel/cgroup/cpuset.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
index 9faf34377a88..8ebf2ab8f0df 100644
--- a/kernel/cgroup/cpuset.c
+++ b/kernel/cgroup/cpuset.c
@@ -962,7 +962,8 @@ void rebuild_sched_domains_locked(void)
 	* prevent the panic.
 	*/
 	for (i = 0; i < ndoms; ++i) {
-		if (WARN_ON_ONCE(!cpumask_subset(doms[i], cpu_active_mask)))
+		if (doms && WARN_ON_ONCE(!cpumask_subset(doms[i],
+					 cpu_active_mask)))
 			return;
 	}
 
-- 
2.34.1


