Return-Path: <cgroups+bounces-15229-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iBU6CgcI22nI8QgAu9opvQ
	(envelope-from <cgroups+bounces-15229-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Sun, 12 Apr 2026 04:48:39 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 84CD63E28CE
	for <lists+cgroups@lfdr.de>; Sun, 12 Apr 2026 04:48:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A5830301841B
	for <lists+cgroups@lfdr.de>; Sun, 12 Apr 2026 02:48:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCAD51EB5E3;
	Sun, 12 Apr 2026 02:48:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="TzAXZ741"
X-Original-To: cgroups@vger.kernel.org
Received: from out203-205-221-209.mail.qq.com (out203-205-221-209.mail.qq.com [203.205.221.209])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CC60883F;
	Sun, 12 Apr 2026 02:48:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.209
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775962112; cv=none; b=YNqAg68OkEXpm2EIg4OAHUp9HrYMAESPcI+ta8f1m94yB98ttIAIbLV48e78fibZN97iO5f5UwZwqOnFUfyZAHMJrXRqVMXE43ptJIAqtTWalo3xE/iW7kddRB1aQIES5fJv4vShBYfU0I9pvETAl96X+CEynaReAmBKM4GpOCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775962112; c=relaxed/simple;
	bh=4bZez45wX1tONsFn+sdhvCNeqwz6D8cRYlK/EfbXSqw=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=bdG9S1e7p846nXaf29+QfsSqz/b66OUFne7J4aQHs0B5oqIYbn5hFZPMl65k/qKKTbZEupP+Lb6FNngHHE9hzw86rcniWMfn5CFtFr+7YRr0HiVnpzVZGWBOsf6VK3z2n/HTgh+7Wwzbj8Uy9D9+btnmTwyYXXSxp9+RN54xJL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=TzAXZ741; arc=none smtp.client-ip=203.205.221.209
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1775962107; bh=hDJKoPZ28NvwCYgTG+e3GiMbln0U8KQEclXpwKyaONo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=TzAXZ7413y5/AOknh0JfJiSsIliMo1aOAU5Ms2P6HZzb9P66lyQCP6dA8bXj0zMoJ
	 KuaQCt0JJ8gHIgFYrNtKuv4NXIN9pppXx8sxsHsmKBWnDW2t7R2V2N+y/0FeN8l5Ss
	 UUKMJPzi9Kq5jwgQYBtEPa36vpVMBAYyxPBo5Nd4=
Received: from lxu-ped-host.. ([111.198.231.89])
	by newxmesmtplogicsvrszc50-0.qq.com (NewEsmtp) with SMTP
	id BC915057; Sun, 12 Apr 2026 10:47:09 +0800
X-QQ-mid: xmsmtpt1775962029tjrcqvo21
Message-ID: <tencent_4EBF67F246C092DF064149932ECC6ECC8C06@qq.com>
X-QQ-XMAILINFO: MllZffuBkEb5ie534oxXaZdAEzQmuTymua/DIBc9fADJFXTr0wikI8vzkQzD3G
	 DMPtTkTYiIXuUtqemFhVTdl6Zw0iN7142q6XNx145qDS6dBi5+A3WVge5Fb7B1PDVKFBKthCyOVw
	 JzdhoAJ+cHb2fe1Wqng5pRYn5GYvKxaAcC+XDTPbs+C+pMwLluzN025vZH7Gw2wsplTxIqkU20yJ
	 xoZ/n8KUGODaAlLHFC9czygGUZz5L/GyRCemxt5iH29lwKmBEr8spqlPNTnh11Zb71FjmQu32Ss3
	 St/sJBRa6P86BgyL26l7SwcqfzO/ImC2CsxOOIS/U4Jwi9S6qjq1esY/MMK6ennnfCWRuZ0vYSyg
	 XvkcN11dWIgiqyJNlzEzkaQi9/EXGAqpVNSrxEpLJ2SF0ADOcXXUaJKE5Bp7dFSPM+L3+NDgAhc7
	 MruZr5lDII8juz810kGTVfuZIj0PNNCzjG+Soh245xLG+k+0zRHF6PbI+1O972KssKBwm2o8Fjeq
	 uFr+5WzNtV+EL3dVdZ0yRf4XoVSIPbRhb0WdUXytj3+wE0oMzKE8mBAUdgjCQ3HTMgxc6OW0zRD3
	 3Y1SQ2+fUpg0tiLgLbZQT1EvAp68ihEDqXAxcZCLHV/H07JbY647sw/nc+9w5/AbQaAvY4CC5+G4
	 tJ85jEII6vEF7+KCmPcJfGtBkv5YQ+w6KYPJkRnlaFabFz20P6P+knUbu5uQSIymMLQLkDgro4Du
	 KFySgECSLW+LRUfJdnEJFvcqVgZNm1E2WP4XP4/WNUQP6kWN246xHWvgRNJT+iDeKLMcWPNqZxEJ
	 9FZkD5hdSwZGx3kChez0WddgXUAm6RUJhhUym5jF5wLCI4xPXWvqHPsMPKZ48IXEwNHKGgZr/oIm
	 ZGkhG04N38yG+peQfpDaNyUkluJmhJ5HENgt8SEwQ2OdBHfh5eFflxiAbTa3jKkXMboUO14R6LEG
	 vWANncasATj2HOm9zGyMb5elRALXMJ+QPjathS37qmidb9riVD60sdClMPaPfVonvGFtVZWntZb6
	 N28v/MvI9iXB7FcmlciZO4aV7rBovWWesYR5717VsZsp1L2kHCN35JV6iZTmAa9OueZxy2Gw==
X-QQ-XMRINFO: Nq+8W0+stu50tPAe92KXseR0ZZmBTk3gLg==
From: Edward Adam Davis <eadavis@qq.com>
To: eadavis@qq.com
Cc: cgroups@vger.kernel.org,
	chenridong@huaweicloud.com,
	hannes@cmpxchg.org,
	linux-kernel@vger.kernel.org,
	mkoutny@suse.com,
	syzbot+33e571025d88efd1312c@syzkaller.appspotmail.com,
	syzkaller-bugs@googlegroups.com,
	tj@kernel.org
Subject: [PATCH v3] sched/psi: fix race between file release and pressure write
Date: Sun, 12 Apr 2026 10:47:09 +0800
X-OQ-MSGID: <20260412024708.192123-2-eadavis@qq.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <tencent_A146D952E4866889986EDAAECA8CB1A7EA06@qq.com>
References: <tencent_A146D952E4866889986EDAAECA8CB1A7EA06@qq.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qq.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64];
	R_DKIM_ALLOW(-0.20)[qq.com:s=s201512];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-15229-lists,cgroups=lfdr.de];
	TO_DN_NONE(0.00)[];
	FREEMAIL_TO(0.00)[qq.com];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[eadavis@qq.com,cgroups@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[qq.com:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	FREEMAIL_FROM(0.00)[qq.com];
	TAGGED_RCPT(0.00)[cgroups,33e571025d88efd1312c];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,qq.com:dkim,qq.com:email,qq.com:mid,appspotmail.com:email]
X-Rspamd-Queue-Id: 84CD63E28CE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

A potential race condition exists between pressure write and cgroup file
release regarding the priv member of struct kernfs_open_file, which
triggers the uaf reported in [1].

Consider the following scenario involving execution on two separate CPUs:

   CPU0					CPU1
   ====					====
					vfs_rmdir()
					kernfs_iop_rmdir()
					cgroup_rmdir()
					cgroup_kn_lock_live()
					cgroup_destroy_locked()
					cgroup_addrm_files()
					cgroup_rm_file()
					kernfs_remove_by_name()
					kernfs_remove_by_name_ns()
 vfs_write()				__kernfs_remove()
 new_sync_write()			kernfs_drain()
 kernfs_fop_write_iter()		kernfs_drain_open_files()
 cgroup_file_write()			kernfs_release_file()
 pressure_write()			cgroup_file_release()
 ctx = of->priv;
					kfree(ctx);
 					of->priv = NULL;
					cgroup_kn_unlock()
 cgroup_kn_lock_live()
 cgroup_get(cgrp)
 cgroup_kn_unlock()
 if (ctx->psi.trigger)  // here, trigger uaf for ctx, that is of->priv

The cgroup_rmdir() is protected by the cgroup_mutex, it also safeguards
the memory deallocation of of->priv performed within cgroup_file_release().
However, the operations involving of->priv executed within pressure_write()
are not entirely covered by the protection of cgroup_mutex. Consequently,
if the code in pressure_write(), specifically the section handling the
ctx variable executes after cgroup_file_release() has completed, a uaf
vulnerability involving of->priv is triggered.

Therefore, the issue can be resolved by extending the scope of the
cgroup_mutex lock within pressure_write() to encompass all code paths
involving of->priv, thereby properly synchronizing the race condition
occurring between cgroup_file_release() and pressure_write().

And, if an active kn lock can be successfully acquired while executing
the pressure write operation, it indicates that the cgroup deletion
process has not yet reached its final stage; consequently, the priv
pointer within open_file cannot be NULL. Therefore, the operation to
retrieve the ctx value must be moved to a point *after* the active kn
lock has been successfully acquired.

[1]
BUG: KASAN: slab-use-after-free in pressure_write+0xa4/0x210 kernel/cgroup/cgroup.c:4011
Call Trace:
 pressure_write+0xa4/0x210 kernel/cgroup/cgroup.c:4011
 cgroup_file_write+0x36f/0x790 kernel/cgroup/cgroup.c:4311
 kernfs_fop_write_iter+0x3b0/0x540 fs/kernfs/file.c:352

Allocated by task 9352:
 cgroup_file_open+0x90/0x3a0 kernel/cgroup/cgroup.c:4256
 kernfs_fop_open+0x9eb/0xcb0 fs/kernfs/file.c:724
 do_dentry_open+0x83d/0x13e0 fs/open.c:949

Freed by task 9353:
 cgroup_file_release+0xd6/0x100 kernel/cgroup/cgroup.c:4283
 kernfs_release_file fs/kernfs/file.c:764 [inline]
 kernfs_drain_open_files+0x392/0x720 fs/kernfs/file.c:834
 kernfs_drain+0x470/0x600 fs/kernfs/dir.c:525

Fixes: 0e94682b73bf ("psi: introduce psi monitor")
Reported-by: syzbot+33e571025d88efd1312c@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=33e571025d88efd1312c
Tested-by: syzbot+33e571025d88efd1312c@syzkaller.appspotmail.com
Signed-off-by: Edward Adam Davis <eadavis@qq.com>
---
v1 -> v2: refactor unlock and update comments
v2 -> v3: remove check for !ctx and update comments

 kernel/cgroup/cgroup.c | 17 +++++++++++++----
 1 file changed, 13 insertions(+), 4 deletions(-)

diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
index 4ca3cb993da2..1d89fab82850 100644
--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -3995,34 +3995,43 @@ static int cgroup_cpu_pressure_show(struct seq_file *seq, void *v)
 static ssize_t pressure_write(struct kernfs_open_file *of, char *buf,
 			      size_t nbytes, enum psi_res res)
 {
-	struct cgroup_file_ctx *ctx = of->priv;
+	struct cgroup_file_ctx *ctx;
 	struct psi_trigger *new;
 	struct cgroup *cgrp;
 	struct psi_group *psi;
+	ssize_t ret = 0;
 
 	cgrp = cgroup_kn_lock_live(of->kn, false);
 	if (!cgrp)
 		return -ENODEV;
 
+	/* of->priv can not be NULL, because cgroup is CSS_ONLINE */
+	ctx = of->priv;
 	cgroup_get(cgrp);
-	cgroup_kn_unlock(of->kn);
 
 	/* Allow only one trigger per file descriptor */
 	if (ctx->psi.trigger) {
 		cgroup_put(cgrp);
-		return -EBUSY;
+		ret = -EBUSY;
+		goto out_unlock;
 	}
 
 	psi = cgroup_psi(cgrp);
 	new = psi_trigger_create(psi, buf, res, of->file, of);
 	if (IS_ERR(new)) {
 		cgroup_put(cgrp);
-		return PTR_ERR(new);
+		ret = PTR_ERR(new);
+		goto out_unlock;
 	}
 
 	smp_store_release(&ctx->psi.trigger, new);
 	cgroup_put(cgrp);
 
+out_unlock:
+	cgroup_kn_unlock(of->kn);
+	if (ret)
+		return ret;
+
 	return nbytes;
 }
 
-- 
2.43.0


