Return-Path: <cgroups+bounces-15207-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YMieM//x2GnrjwgAu9opvQ
	(envelope-from <cgroups+bounces-15207-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Fri, 10 Apr 2026 14:50:07 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E8BA3D7B44
	for <lists+cgroups@lfdr.de>; Fri, 10 Apr 2026 14:50:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7DAD4304224D
	for <lists+cgroups@lfdr.de>; Fri, 10 Apr 2026 12:39:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8EB9195811;
	Fri, 10 Apr 2026 12:39:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="Pol2o8A3"
X-Original-To: cgroups@vger.kernel.org
Received: from xmbghk7.mail.qq.com (xmbghk7.mail.qq.com [43.163.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A00F219E8;
	Fri, 10 Apr 2026 12:39:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=43.163.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775824795; cv=none; b=f5pr5ZSE/erHjV1Lrtnj/gdyvz+ud+lns9vfaU6Ff0bWnCZGENzUrmgJIMI4D4W9blDX7qXzoQDFNgl4WxPCKL5wO1O+hrEejSXCJFaR1ZMk6DlhSXo3D0j24+tRYt6Z9XVALeFcQaOwCynM2DjQPSfpqB4EpmxjRIGMuS58SPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775824795; c=relaxed/simple;
	bh=MthejXCd0ZER7QImZIUA64CG/BkwH2U7NaSU/C4eLXM=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=IWRuW6Hv03xMCX04Vh5RxVf6kdQpIEXZx4tgLJAXkDjcmPzfBbeiJWzZvLhxZW9bl0iHOtkLNsi0mhCJD6CbxXCP3K6MolrLGPJSh/Vsid++C5WCxBeS17MPyBfrWq2yhvHy7c7kf7bqotKLA0MR2Aku/aS0jey5v0T4gC2MpZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=Pol2o8A3; arc=none smtp.client-ip=43.163.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1775824789; bh=F1Ae6FTHVOQ6zslykD70RR5MNcQ71hhG3E0kf4ix2mk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Pol2o8A3sU35d3MQNy8kkSB8d+4s9TnvOvisRZbskLOcA0hP7rjKk+yi9qivNSyrf
	 C3cv0fMC+Kyyxay32pPEsWpotro78h2fa+eHqaX0eRH+qefKPo2+GLeD3sIZrw8h7I
	 LJVFhxamZdTMcGU/EQu+eInOsFBjzrMqPCn7vXg8=
Received: from lxu-ped-host.. ([111.198.231.89])
	by newxmesmtplogicsvrsza63-0.qq.com (NewEsmtp) with SMTP
	id 9EDB68FD; Fri, 10 Apr 2026 20:39:45 +0800
X-QQ-mid: xmsmtpt1775824785tqzox3pnm
Message-ID: <tencent_6F3C1F36BA97BA37AA4A2C7403766F675A09@qq.com>
X-QQ-XMAILINFO: MllZffuBkEb5EoqQDCec6LRt3XZIbUSZrleefb5kFxvm7b3fDT7FQdOHi3/gan
	 LK/RYG6SHRFEJfU3KtnGO9mOith/959BF3xjv/lUAtBIN4niMLisIKu0iv2P8/QktWU4S9UzsZV6
	 Rl3GWh5mmP2+Oykm9G/gGjni9jd4XKY12wXdIQF22t5vL2OubX3EyusdTgOb+AlyOvUrgAVuyPxr
	 ZHNMG9Ps52gf2qFckJAkf6O67ufN5qzGINZhARXbTqJx3Udps91IcmOXAgYUW4bT7YNj/V9kOwtO
	 ZQbU+kcwrnYfzRsPkFQVJkdRiuW9cdae2PoSl3oUvzc/EJoXI7SrJ6wCCkhL9iN1YykbsPVv5ATD
	 jNLKOrU23DfCUqvbGNWWOmQ9MEk8F6yiemw2ZpvtnyxfbIovqsBf5wVxVXbdSlwGrFNHeeOqrMi3
	 BhQ2caENx6TdRe8EHGw1AvKrjwrT94l0aEcz+2yy5wBPMlC5KShV9S13QfQXTufbvcLJWjCiX8Dn
	 mzSOQHVZFBjo4EE9butsXrxVw5R9KCj/1G0xJP216jEPszcjLTFsH4UnKuYNkCyQioIyO92dCLB+
	 C/V0GBE1XvUvFruObjE4G8Bb6yI2pvIHBzXdJL3XsS1ZUPcXvaTEbi5IWGauqpOoyJ2ASpNUsEbZ
	 GHvIXokp71raw2ZHwZxYDnvbnRckLPZH2eWcz9pWpgbVPcbfXl4mfqA5DjY0q7lRrWdaiIjaPYHX
	 gw4vd0MAhywEE2sxjV3+9bPWnscpLflZ2VNLhL0M5g0xMH48HP9S43S6n0bgkGkuXBUWRa5Gwp+W
	 qFPsLGEqEek9vwxNMO4dES3PILSFNLprPfJUaQVj0DjKATjrhNieb4szTUa13iyTf/lSVNX/hUdn
	 AiSRowiSXGPkmpxvCajTzAasybBMv2/HFPsNSV2TDBnEuOwd2Vpemw/LMs4fQS2zngJTNBF7GHtF
	 cXk4QEwmz/HtybU9K5YkdODCvrOzPi24UE/Fj8hN2oldRKTh7fKGHiKYucnTShehM/Yw8PJIt2r5
	 2tnlFSeDu5MOhrWbAn1IlN28i5hbcODYGR6FvxiavdPlu1UWFKbUpTC65UcHUtVUAxQfDX6lvbEj
	 sw7zkd
X-QQ-XMRINFO: OWPUhxQsoeAVwkVaQIEGSKwwgKCxK/fD5g==
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
Subject: [PATCH v2] sched/psi: fix race between file release and pressure write
Date: Fri, 10 Apr 2026 20:39:45 +0800
X-OQ-MSGID: <20260410123944.149873-2-eadavis@qq.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <tencent_90482DC16CB494F8EB1AEDE6CDD87B3A6F0A@qq.com>
References: <tencent_90482DC16CB494F8EB1AEDE6CDD87B3A6F0A@qq.com>
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
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[qq.com,quarantine];
	R_DKIM_ALLOW(-0.20)[qq.com:s=s201512];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-15207-lists,cgroups=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[qq.com];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[qq.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FREEMAIL_FROM(0.00)[qq.com];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[eadavis@qq.com,cgroups@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[cgroups,33e571025d88efd1312c];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 2E8BA3D7B44
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

 kernel/cgroup/cgroup.c | 21 +++++++++++++++++----
 1 file changed, 17 insertions(+), 4 deletions(-)

diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
index 4ca3cb993da2..46db30de817b 100644
--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -3995,34 +3995,47 @@ static int cgroup_cpu_pressure_show(struct seq_file *seq, void *v)
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
 
+	ctx = of->priv;
+	if (!ctx) {
+		ret = -ENODEV;
+		goto out_unlock;
+	}
+
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


