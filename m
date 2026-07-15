Return-Path: <cgroups+bounces-17824-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id fC+ZCt9FV2rGIQEAu9opvQ
	(envelope-from <cgroups+bounces-17824-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Wed, 15 Jul 2026 10:33:35 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 15CEC75BEBE
	for <lists+cgroups@lfdr.de>; Wed, 15 Jul 2026 10:33:34 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linux.alibaba.com header.s=default header.b=POHvkA16;
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-17824-lists+cgroups=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="cgroups+bounces-17824-lists+cgroups=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linux.alibaba.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id D3085301A04E
	for <lists+cgroups@lfdr.de>; Wed, 15 Jul 2026 08:33:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38B683CEBA6;
	Wed, 15 Jul 2026 08:33:01 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from out30-119.freemail.mail.aliyun.com (out30-119.freemail.mail.aliyun.com [115.124.30.119])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E6A938BF6A;
	Wed, 15 Jul 2026 08:32:58 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784104381; cv=none; b=DdOZsSC0LRGVhSJn9J1WULezogiCiy79EK2kyI0A+m0l5sOw5HpwsuzxsAkh3kDVV7zKgVEZxrYArgna6jS2NdxVYcD22Yn4VBQbfUFv9ApCMmTvBD+ShwEHMUhc0rktk1Ycrwm1SPWW9w4+6t/4lNs8nMJTc3cJFzvLs0Vc5Sk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784104381; c=relaxed/simple;
	bh=NtTqy9IIdmaODYdz283W4hYkGijeJ8iu21rtx7yC97g=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=fIwfypa6BoKQUVFBQCJXQLejYUfIVahRzFxdJkaJD8Hgt53+vylQjP0cNpGWIEumnjpPS9k4NkQK0ug14kS7Ilw/1OjFWfhfqoM/D0gpkrFY3vtJaQqPBH5rb6QFb5YaY7Qgv8XTqSRBaA7XNUZW7NW7QH1OuvlInU1hCm8szHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=POHvkA16; arc=none smtp.client-ip=115.124.30.119
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1784104369; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=ZS2xF3IWdReXQinPDmamEcncE7IOalmQXMqVE+vBxUw=;
	b=POHvkA16oxoq28tNeyWj3Nz7R8tE4o6EAzubv2yYQ89+XjD5U+Q9cIfqcI9pg3K39XF0Z3bupC4pt3IqkFTD7irX35HNqw505nY5yqW59RLG3jZcXWPrZffPy9tupP4CTV809UYeHIF6W7nWqiUWzrDWfsXpXpUkOsTjBKEs7e4=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R101e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037009110;MF=lulie@linux.alibaba.com;NM=1;PH=DS;RN=13;SR=0;TI=SMTPD_---0X78YbmC_1784104367;
Received: from localhost(mailfrom:lulie@linux.alibaba.com fp:SMTPD_---0X78YbmC_1784104367 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 15 Jul 2026 16:32:48 +0800
From: Philo Lu <lulie@linux.alibaba.com>
To: stable@vger.kernel.org
Cc: chenridong@huawei.com,
	tj@kernel.org,
	lulie@linux.alibaba.com,
	lizefan.x@bytedance.com,
	hannes@cmpxchg.org,
	cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	eadavis@qq.com,
	chenridong@huaweicloud.com,
	akpm@linux-foundation.org,
	surenb@google.com,
	dust.li@linux.alibaba.com
Subject: [PATCH 6.12.y 2/2] sched/psi: fix race between file release and pressure write
Date: Wed, 15 Jul 2026 16:32:45 +0800
Message-Id: <20260715083245.32115-3-lulie@linux.alibaba.com>
X-Mailer: git-send-email 2.32.0.3.g01195cf9f
In-Reply-To: <20260715083245.32115-1-lulie@linux.alibaba.com>
References: <20260715083245.32115-1-lulie@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-10.66 / 15.00];
	WHITELIST_DMARC(-7.00)[alibaba.com:D:+];
	WHITELIST_SPF_DKIM(-3.00)[alibaba.com:d:+,kernel.org:s:+];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.alibaba.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[linux.alibaba.com:s=default];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-17824-lists,cgroups=lfdr.de];
	FREEMAIL_CC(0.00)[huawei.com,kernel.org,linux.alibaba.com,bytedance.com,cmpxchg.org,vger.kernel.org,qq.com,huaweicloud.com,linux-foundation.org,google.com];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:chenridong@huawei.com,m:tj@kernel.org,m:lulie@linux.alibaba.com,m:lizefan.x@bytedance.com,m:hannes@cmpxchg.org,m:cgroups@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:eadavis@qq.com,m:chenridong@huaweicloud.com,m:akpm@linux-foundation.org,m:surenb@google.com,m:dust.li@linux.alibaba.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[lulie@linux.alibaba.com,cgroups@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lulie@linux.alibaba.com,cgroups@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linux.alibaba.com:+];
	TO_DN_NONE(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TAGGED_RCPT(0.00)[cgroups];
	DBL_BLOCKED_OPENRESOLVER(0.00)[huaweicloud.com:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,vger.kernel.org:from_smtp,appspotmail.com:email,linux.alibaba.com:from_mime,linux.alibaba.com:dkim,linux.alibaba.com:mid,alibaba.com:email,qq.com:email,syzkaller.appspot.com:url]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 15CEC75BEBE

From: Edward Adam Davis <eadavis@qq.com>

commit a5b98009f16d8a5fb4a8ff9a193f5735515c38fa upstream.

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
Reviewed-by: Chen Ridong <chenridong@huaweicloud.com>
Signed-off-by: Tejun Heo <tj@kernel.org>
Signed-off-by: Philo Lu <lulie@linux.alibaba.com>
---
 kernel/cgroup/cgroup.c | 24 ++++++++++++++++--------
 1 file changed, 16 insertions(+), 8 deletions(-)

diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
index 3ce02650f9484..693959a6b2f3e 100644
--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -3876,33 +3876,41 @@ static int cgroup_cpu_pressure_show(struct seq_file *seq, void *v)
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
2.47.3


