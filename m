Return-Path: <cgroups+bounces-15203-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kLToJwN22GkxdggAu9opvQ
	(envelope-from <cgroups+bounces-15203-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Fri, 10 Apr 2026 06:01:07 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0155F3D1FC3
	for <lists+cgroups@lfdr.de>; Fri, 10 Apr 2026 06:01:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6012F30107C1
	for <lists+cgroups@lfdr.de>; Fri, 10 Apr 2026 04:01:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6797F30F7F3;
	Fri, 10 Apr 2026 04:01:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="x8Sbeaey"
X-Original-To: cgroups@vger.kernel.org
Received: from out162-62-58-216.mail.qq.com (out162-62-58-216.mail.qq.com [162.62.58.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C74541917FB;
	Fri, 10 Apr 2026 04:01:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.58.216
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775793664; cv=none; b=QR0Ll/tdtT0GaL8NdD7+XxUDPSc+Bs8PG+sXQG0DdLxSmijoRbGmysyaDNUJAacGaPRXlju5OpGJ/6KavRGyBO8CIAKCMVmaM3RHwMeygOwWiVOqILlaFuwJokmSzIb1027Rs3NFjaaD+rA1/E+P2OB+POCjpKRP7BWeqcLhHrs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775793664; c=relaxed/simple;
	bh=l1KWqwSmXA5VTVa5SdJHmfhEUO5xAS7d/OrQeLtzu/E=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=GUR3WglePTtrx4edpumXmV2x0LMgd9LY7xRnHq87kcheIrFau4yNYVtPQSTEcvcU/WRyviuX2MuOgnBTvJaybiOQfDfxCFPBWKIIMfAige/mW7591W/AKt294+sx5u5lB1i1FruLxXwlwTJO0s+VzVAGuj3CRrLZT6Vyw8pTSsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=x8Sbeaey; arc=none smtp.client-ip=162.62.58.216
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1775793656; bh=KpinhzaRukwvHAPxAbUQvK8S/zHI9VCE4CGwGsOGlQg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=x8SbeaeyOQKdn44shSVUyE/Z1cTypt/Y9af2WgWhwsjQpY3xM3YKeAGBqsbqlw841
	 KfYyEdBtZBOGlDudgzBRqAvhSC18ytgW3wQTfL3Xo+82Bkz0iKH9rVOAqonTecgYoh
	 yiq65KTg+vJd9LBZAu4c0nAkrf8zY6ExcGHURbRA=
Received: from lxu-ped-host.. ([111.198.231.89])
	by newxmesmtplogicsvrszb43-0.qq.com (NewEsmtp) with SMTP
	id 358F49F; Fri, 10 Apr 2026 12:00:53 +0800
X-QQ-mid: xmsmtpt1775793653t9jywx4qz
Message-ID: <tencent_304A97FC36264BDE745777E366603C8F3709@qq.com>
X-QQ-XMAILINFO: No7DFzN00JnRGwPmp0HeVo/8uR48CtQasjpTa83aWMd2Uhej5K4XLSZA+XVf5p
	 9HONFQqFKDh5AS8n9OHoeC7nt0rN236yyMXVVNWjs9+IuOs7Gk80qSWMUy48NlQqQWM2UO+ZyxQn
	 lfDDAJf4HHLS9Fbe9BdJIwE3z+IN6mXlkw1QU3L6HmXv58Xc2mRpnvV88F2ZLxz0jGq53fFbYs1k
	 FVCTA1Ektb+V/GE9UCrVOtKd22bQXKmKEUtkSS4wNI8hU2rm64YzmG0OqP28QJzxond7F0fWD8gP
	 w/hXGPDk7o76gN+AH3k8QPC0QKY+Ye8HCg2SmTJgYv5dI016fLuzYaO7d0YdkI1KvOwzNgohCFNp
	 H6qPo4rD18ISbkwLe25DtX03MiVXMGgAUlvO3kpBEKnUcVKfXAhsdBl0yiUzTnNZ88/wWJU95lCU
	 +WCsAw44oDKb6ecy7f99dt4WjqRy6jVyIAZMUwHEI2LcLZCYzBGudSd8Erswhd4UpZ++wkwjnqDR
	 +3BQOSRBKgMZmXPGspPgnpkcOgaar+QZ91kz+xf2TWNEfnB/QkH5WF70HKfw6OpNFWd+txb3kndd
	 YfCZ/f3xhWybYWXijauarO4dC8+RH9Krn/j6JpJJpnSZ19oGKIXE7iul9zCCRWMGTG8hqw5TOdnx
	 0HTcUbkQROY4ROiI1wQv7zZ56F//20WT+8XI+MNr0dCLtk5URt0nP2LBwIa52cz3kog4JZ6qt1Vr
	 DSwxf6SHTI44UYC62lAtlFumNVFcl81N/rdovk+32g8fDMY0rvZ/k7K8CtGSGCb9ixGHWtWk0qiI
	 mRUr0KR5LwIN/vFVLOZmLRklnLT3uz7Oy9SsiFwzutAYZLG+4CPmKGeTx0vAyq2QlMbvL23aCzqL
	 S6KRi2NLwrF8H+sDIi6x+vWJZN3+IcJeoF8B9myU2D0y16ZJr6b4USYzzh3neivqMz8w/8xA/wSd
	 PBYo3EM8/l2Cl7lYj51GHSuOWipvZczzMwaO/J4MLp9lwQdtF4dyAIPotDBzqouiRZ6ESbUHAjmL
	 b6fLr5PY52Hhk/faiU84I/RP/2FZc=
X-QQ-XMRINFO: M/715EihBoGS47X28/vv4NpnfpeBLnr4Qg==
From: Edward Adam Davis <eadavis@qq.com>
To: syzbot+33e571025d88efd1312c@syzkaller.appspotmail.com
Cc: cgroups@vger.kernel.org,
	hannes@cmpxchg.org,
	linux-kernel@vger.kernel.org,
	mkoutny@suse.com,
	syzkaller-bugs@googlegroups.com,
	tj@kernel.org
Subject: [PATCH] sched/psi: fix race between file release and pressure write
Date: Fri, 10 Apr 2026 12:00:54 +0800
X-OQ-MSGID: <20260410040053.124906-2-eadavis@qq.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <69d779b0.a00a0220.468cb.0018.GAE@google.com>
References: <69d779b0.a00a0220.468cb.0018.GAE@google.com>
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
	R_DKIM_ALLOW(-0.20)[qq.com:s=s201512];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-15203-lists,cgroups=lfdr.de];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[eadavis@qq.com,cgroups@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[qq.com:+];
	RCPT_COUNT_SEVEN(0.00)[7];
	FREEMAIL_FROM(0.00)[qq.com];
	TAGGED_RCPT(0.00)[cgroups,33e571025d88efd1312c];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[syzkaller.appspot.com:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,qq.com:dkim,qq.com:email,qq.com:mid]
X-Rspamd-Queue-Id: 0155F3D1FC3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

A potential race condition exists between pressure write and cgroup file
release regarding the priv member of struct kernfs_open_file, which
triggers the uaf reported in [1].

The scope of the cgroup_mutex protection in pressure write has been
expanded to prevent the uaf described in [1].

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
 kernel/cgroup/cgroup.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
index 4ca3cb993da2..c0cfe91c2991 100644
--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -4005,11 +4005,11 @@ static ssize_t pressure_write(struct kernfs_open_file *of, char *buf,
 		return -ENODEV;
 
 	cgroup_get(cgrp);
-	cgroup_kn_unlock(of->kn);
 
 	/* Allow only one trigger per file descriptor */
 	if (ctx->psi.trigger) {
 		cgroup_put(cgrp);
+		cgroup_kn_unlock(of->kn);
 		return -EBUSY;
 	}
 
@@ -4017,12 +4017,14 @@ static ssize_t pressure_write(struct kernfs_open_file *of, char *buf,
 	new = psi_trigger_create(psi, buf, res, of->file, of);
 	if (IS_ERR(new)) {
 		cgroup_put(cgrp);
+		cgroup_kn_unlock(of->kn);
 		return PTR_ERR(new);
 	}
 
 	smp_store_release(&ctx->psi.trigger, new);
 	cgroup_put(cgrp);
 
+	cgroup_kn_unlock(of->kn);
 	return nbytes;
 }
 
-- 
2.43.0


