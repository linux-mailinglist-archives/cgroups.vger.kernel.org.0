Return-Path: <cgroups+bounces-15288-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qJVhH6/b3WnukAkAu9opvQ
	(envelope-from <cgroups+bounces-15288-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Tue, 14 Apr 2026 08:16:15 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D0AE93F5E29
	for <lists+cgroups@lfdr.de>; Tue, 14 Apr 2026 08:16:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 94DD53044832
	for <lists+cgroups@lfdr.de>; Tue, 14 Apr 2026 06:15:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E26F12F362B;
	Tue, 14 Apr 2026 06:15:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="Cgpqr71x"
X-Original-To: cgroups@vger.kernel.org
Received: from out162-62-58-216.mail.qq.com (out162-62-58-216.mail.qq.com [162.62.58.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06E742222CC;
	Tue, 14 Apr 2026 06:15:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.58.216
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776147354; cv=none; b=VhiTmPwLsTfUQZo9etQW7VFjfd3GWvD6h4mLD8FxuHqCRGrgHjkrFH8mWP3I68RQvT4xB1Jyh0s+5b7wMOzXrVkOdeRAZg70bM0Y8XBuE0pXCmy/NbAiUkmrXJ4HSpftZmCUM3x8RIY1QNVkXYs/hWTsLUgAUbqT4Rf52LS4VOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776147354; c=relaxed/simple;
	bh=ZjBn+C9UZ5DtzZPyouJhpvMMpAeQVV/IpgLfq6ekMqM=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=BhU85Q5YWlJ7Aw5Phaq8ZNtGQHl/2UwazkW7/4ikoLKYuCmpiT3XO3EnqU0OYc6G/GsuZ3gyADJ7spVMwH1eQFCDFj3KPvCl+JmygDsh6IxkvJ7PeYjiiihRa7EaPLUPOqQNtL/WZFEqpf3iVrx6FnBnJd+U18LhnaJHUBBLj5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=Cgpqr71x; arc=none smtp.client-ip=162.62.58.216
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1776147346; bh=dyzb4M5HCHxfsTFf0caUdDxxMuGa6sn1JzxcOHviYMg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Cgpqr71x0QZs5muW2v0Wku7dPjY5M+dXv8TdIh1BqK6N9LdqVNdZQBGNga1KdfdV2
	 sFDynkHG5AcrRvTDjBTy8HM0OdivisYWWKsIbyVnxzBnNoaDu9jZXnrSJq1iUzHSwa
	 /CNulYfBsRqvKg4XpbyNRdNpPRtPsJHMCFJzAkXU=
Received: from lxu-ped-host.. ([111.198.231.89])
	by newxmesmtplogicsvrszb43-0.qq.com (NewEsmtp) with SMTP
	id 3EB3963E; Tue, 14 Apr 2026 14:15:43 +0800
X-QQ-mid: xmsmtpt1776147343th5kwsi6a
Message-ID: <tencent_FBCECE887BCA6C3C2CE96E5896C8E9AEEE0A@qq.com>
X-QQ-XMAILINFO: MrFh2a21gtCz9hXBkKmH/c9go/BaiuNULEkuYiONbdC7mFIDPVvoSjW1lrR8bZ
	 YDVkyS/peIZVP0Kxptbcl7CglFKK3WHwQiTQ4Vk4cxeWr8CHm7AUnGzgvJtRpb5KWKqTOIB1vIf7
	 pvB+Gip5gwvGR2dre07Dz7N24UWUcUwLCdwo4l7eazbqGIOBU/U0IXp60nMdIF/rA1lpUWff+QuI
	 FSCikJqMiadY6sDTZID45V/6Dfo/43eJI6hed1piqXrX7Qy3ar4rEbZ325/y83dR7F3TRDWN40fJ
	 ekUHSMtYcRNvsvMst31BD33M/KpSMmd3wZNV2RMHgNyARYhkVZQxOGXlid3a9v3gJCBT9H6SnHf/
	 yakKg3NV7bzt/Nb7Wkivna/qfpd4NrPS5TOJ8teMSNra+RFXEIeMz1Wlnu3aR99/TQg359RRINAl
	 v5y58/GPlRSPtshLkUQX16rSXAQbAW6o74xmfV/P1fnOgz5Wl3e4CaT/Cn67zbbBLJEcWXf9zG3D
	 h9/o879eGIde2FRHBm4QtDKUMwbVNKDC2PM6ktjWaoD7doMQc81l+pTPOVbZDV37WdiKdylpFNwo
	 21FiUPasEKv62gXXgaOsVwkgp4j/3+1vO03F3hqgWRKBeF2dlfIbP0w7qyjSwdw65hBZLHMTM3YW
	 ZRddkYt/boXOqVZyaroh0QCtwI1OQq6CFQarcR1t686mLJQ3xca9kTtyAjU/kz1YS4MGLa8NiUCC
	 Y7mzK6tNOVfiN0NJMIRbKC3kaL7VyhzM0PUwAsrVxxbeuok+NZ2/BFPZ/Cqfc5UoyojTCWmPbWAY
	 x37qvLIonD9+CKZGRVEMWGLcAuBwX3R2OanZ6MSF7lTidgLlVd3WrA5SguUjRUhAdswBYSx2DDoH
	 dE1kDP0NLO2VDShMQ0J3f7mUYoFcNtP/jfHQ0sMiGcnAKzNZDMC5JH0as9PqPQ/qluV7gIVPMcKW
	 ZpiZnm//XSv1yzOSh/TZuZiDQNC1TX3VnsdCWSmVKQQhsvqA4VBBpBPQakeplzXLftm1u9o7NH2o
	 8/kKD0QjNqlAqmIoXGaKVQhranji0qtkD9Hk3RR+PG6qBBpBDUUoSOkEannoxEMCIvZOgSuA==
X-QQ-XMRINFO: OD9hHCdaPRBwH5bRRRw8tsiH4UAatJqXfg==
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
Subject: [PATCH v5] sched/psi: fix race between file release and pressure write
Date: Tue, 14 Apr 2026 14:15:43 +0800
X-OQ-MSGID: <20260414061542.266620-2-eadavis@qq.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <tencent_4ED99363237E896983BEC4571777B767C605@qq.com>
References: <tencent_4ED99363237E896983BEC4571777B767C605@qq.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[qq.com:s=s201512];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-15288-lists,cgroups=lfdr.de];
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
	NEURAL_HAM(-0.00)[-0.998];
	DKIM_TRACE(0.00)[qq.com:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	FREEMAIL_FROM(0.00)[qq.com];
	TAGGED_RCPT(0.00)[cgroups,33e571025d88efd1312c];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[appspotmail.com:email,syzkaller.appspot.com:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,qq.com:dkim,qq.com:email,qq.com:mid]
X-Rspamd-Queue-Id: D0AE93F5E29
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

And, if an live kn lock can be successfully acquired while executing
the pressure write operation, it indicates that the cgroup deletion
process has not yet reached its final stage; consequently, the priv
pointer within open_file cannot be NULL. Therefore, the operation to
retrieve the ctx value must be moved to a point *after* the live kn
lock has been successfully acquired.

In another situation, specifically after entering cgroup_kn_lock_live()
but before acquiring cgroup_mutex, there exists a different class of
race condition:

CPU0: write memory.pressure               CPU1: write cgroup.pressure=0
===========================		  =============================

kernfs_fop_write_iter()
 kernfs_get_active_of(of)
 pressure_write()
   cgroup_kn_lock_live(memory.pressure)
     cgroup_tryget(cgrp)
     kernfs_break_active_protection(kn)
     ... blocks on cgroup_mutex

                                     	  cgroup_pressure_write()
                                     	  cgroup_kn_lock_live(cgroup.pressure)
                                     	  cgroup_file_show(memory.pressure, false)
                                     	    kernfs_show(false)
                                     	      kernfs_drain_open_files()
                                     	        cgroup_file_release(of)
                                     	          kfree(ctx)
                                     	            of->priv = NULL
                                     	  cgroup_kn_unlock()

   ... acquires cgroup_mutex
   ctx = of->priv;        // may now be NULL
   if (ctx->psi.trigger)  // NULL dereference

Consequently, there is a possibility that of->priv is NULL, the pressure
write needs to check for this.

Now that the scope of the cgroup_mutex has been expanded, the original
explicit cgroup_get/put operations are no longer necessary, this is
because acquiring/releasing the live kn lock inherently executes a
cgroup get/put operation. 

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
v3 -> v4: remove orig get/put for get cgroup refcnt and update comments
v4 -> v5: check !ctx

 kernel/cgroup/cgroup.c | 24 ++++++++++++++++--------
 1 file changed, 16 insertions(+), 8 deletions(-)

diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
index 4ca3cb993da2..4366fd62eb3d 100644
--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -3995,33 +3995,41 @@ static int cgroup_cpu_pressure_show(struct seq_file *seq, void *v)
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
 
-	cgroup_get(cgrp);
-	cgroup_kn_unlock(of->kn);
+	ctx = of->priv;
+	if (!ctx) {
+		ret = -ENODEV;
+		goto out_unlock;
+	}
 
 	/* Allow only one trigger per file descriptor */
 	if (ctx->psi.trigger) {
-		cgroup_put(cgrp);
-		return -EBUSY;
+		ret = -EBUSY;
+		goto out_unlock;
 	}
 
 	psi = cgroup_psi(cgrp);
 	new = psi_trigger_create(psi, buf, res, of->file, of);
 	if (IS_ERR(new)) {
-		cgroup_put(cgrp);
-		return PTR_ERR(new);
+		ret = PTR_ERR(new);
+		goto out_unlock;
 	}
 
 	smp_store_release(&ctx->psi.trigger, new);
-	cgroup_put(cgrp);
+
+out_unlock:
+	cgroup_kn_unlock(of->kn);
+	if (ret)
+		return ret;
 
 	return nbytes;
 }
-- 
2.43.0


