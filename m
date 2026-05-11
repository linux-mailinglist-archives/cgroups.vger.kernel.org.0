Return-Path: <cgroups+bounces-15719-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2OjdLpWQAWrTeQEAu9opvQ
	(envelope-from <cgroups+bounces-15719-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Mon, 11 May 2026 10:17:25 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BE63509F58
	for <lists+cgroups@lfdr.de>; Mon, 11 May 2026 10:17:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B0EE1302E7BB
	for <lists+cgroups@lfdr.de>; Mon, 11 May 2026 08:16:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73FAC3BAD95;
	Mon, 11 May 2026 08:16:57 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 839C1265CBE;
	Mon, 11 May 2026 08:16:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778487414; cv=none; b=BKUC6PU32zncTJOO6z3aVYyGFL5glNBFm21ikFBta0//pCLE9PEGeW9BUJAZ4hIoOOelMUbdQ5RYHoyFzM7LmrRJ6s7/qfr1Pq8EE01sKmojTt85I2VsnisE1sOY1rdT3A7koWRl/4VLzgN4/yfMTRWtoJ8Ffce9qC1h/cK+i2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778487414; c=relaxed/simple;
	bh=KJUwlmt96GQhcbXO7vOHe8FGLFI4hK0UDQQOnYBtIcs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=V8IhCxfUjI7asFy6zo/EW8Zk5itJHTbl1hp1pZ6FhwJZEYzOTw144tVqrNVWGDMRmn+fdKCmjIgAClx1QZaY/1g/LnC61WzkNwW0wv6aZr0Q1IlCJu/Ry+OTklcKbZf6BTT72w1ZoaUi6QQdT7dWdFHWQGd28vJrECiEaGQoUy0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: badf451a4d1111f1aa26b74ffac11d73-20260511
X-CTIC-Tags:
	HR_CC_COUNT, HR_CC_DOMAIN_COUNT, HR_CC_NAME, HR_CC_NO_NAME, HR_CHARSET
	HR_CHARSET_NUM, HR_CTE_8B, HR_CTT_MISS, HR_DATE_H, HR_DATE_WKD
	HR_DATE_ZONE, HR_FROM_NAME, HR_SJ_LANG, HR_SJ_LEN, HR_SJ_LETTER
	HR_SJ_NOR_SYM, HR_SJ_PHRASE, HR_SJ_PHRASE_LEN, HR_SJ_WS, HR_TO_CHARSET
	HR_TO_CHARSET_NUM, HR_TO_COUNT, HR_TO_DOMAIN_COUNT, HR_TO_NAME, IP_TRUSTED
	SRC_TRUSTED, DN_TRUSTED, SA_TRUSTED, SA_EXISTED, SN_TRUSTED
	SN_EXISTED, SPF_NOPASS, DKIM_NOPASS, DMARC_NOPASS, CIE_BAD
	CIE_GOOD, CIE_GOOD_SPF, GTI_FG_BS, GTI_RG_INFO, GTI_C_BU
	AMN_GOOD, ABX_MISS_RDNS
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12,REQID:5ee020d6-35c6-488f-99cf-bfa9f665ae89,IP:10,
	URL:0,TC:0,Content:0,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:5
X-CID-INFO: VERSION:1.3.12,REQID:5ee020d6-35c6-488f-99cf-bfa9f665ae89,IP:10,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:5
X-CID-META: VersionHash:e7bac3a,CLOUDID:1a9d43e9493c60f6914cdcfdb79c6f77,BulkI
	D:2605111616390IXV0GWK,BulkQuantity:0,Recheck:0,SF:17|19|38|66|78|102|127|
	898,TC:nil,Content:0|15|50,EDM:-3,IP:-2,URL:0,File:nil,RT:nil,Bulk:nil,QS:
	nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,AR
	C:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_FAS,TF_CID_SPAM_FSD,TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: badf451a4d1111f1aa26b74ffac11d73-20260511
X-User: zhangguopeng@kylinos.cn
Received: from yan.. [(223.70.159.239)] by mailgw.kylinos.cn
	(envelope-from <zhangguopeng@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 576499349; Mon, 11 May 2026 16:16:37 +0800
From: Guopeng Zhang <zhangguopeng@kylinos.cn>
To: Tejun Heo <tj@kernel.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	=?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>
Cc: Yi Tao <escape@linux.alibaba.com>,
	cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Guopeng Zhang <zhangguopeng@kylinos.cn>
Subject: [PATCH] cgroup: Keep favordynmods enabled once per-threadgroup rwsem is active
Date: Mon, 11 May 2026 16:16:06 +0800
Message-ID: <20260511081607.83490-1-zhangguopeng@kylinos.cn>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 1BE63509F58
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.04 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-15719-lists,cgroups=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[kylinos.cn];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FROM_NEQ_ENVFROM(0.00)[zhangguopeng@kylinos.cn,cgroups@vger.kernel.org];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.883];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,kylinos.cn:email,kylinos.cn:mid]
X-Rspamd-Action: no action

cgroup_enable_per_threadgroup_rwsem is a one-way switch. Once it is
enabled, cgroup.procs writes use the per-threadgroup rwsem and
cgroup_threadgroup_change_begin()/end() use the same global state to
decide whether to take and release the per-threadgroup rwsem.

The disable path warned that the per-threadgroup rwsem mechanism could not
be disabled but still called rcu_sync_exit() and cleared
CGRP_ROOT_FAVOR_DYNMODS. That partially disabled favordynmods while the
global per-threadgroup rwsem mode remained enabled: cgroup.procs writes
would continue to use the per-threadgroup rwsem, while
cgroup_threadgroup_change_begin()/end() could observe the exited rcu_sync
state. The root would also no longer report favordynmods.

Make the transition match the documented one-way semantics. Call
rcu_sync_enter() only for the first favordynmods enable, and make later
disable attempts a no-op after warning once the per-threadgroup rwsem mode
has been enabled.

Fixes: 0568f89d4fb8 ("cgroup: replace global percpu_rwsem with per threadgroup resem when writing to cgroup.procs")
Signed-off-by: Guopeng Zhang <zhangguopeng@kylinos.cn>
---
Manual AB test:

Before this patch:
  enable favordynmods:
    cgroup2 opts: rw,relatime,favordynmods
  disable attempt:
    cgroup2 opts: rw,relatime
  dmesg:
    cgroup: cgroup favordynmods: per threadgroup rwsem mechanism can't be disabled

After this patch:
  enable favordynmods:
    cgroup2 opts: rw,relatime,favordynmods
  disable attempt:
    cgroup2 opts: rw,relatime,favordynmods
  dmesg:
    cgroup: cgroup favordynmods: per threadgroup rwsem mechanism can't be disabled

 kernel/cgroup/cgroup.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
index 6152add0c5eb..fd10fb5b3598 100644
--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -1297,14 +1297,13 @@ void cgroup_favor_dynmods(struct cgroup_root *root, bool favor)
 	 */
 	percpu_down_write(&cgroup_threadgroup_rwsem);
 	if (favor && !favoring) {
-		cgroup_enable_per_threadgroup_rwsem = true;
-		rcu_sync_enter(&cgroup_threadgroup_rwsem.rss);
+		if (!cgroup_enable_per_threadgroup_rwsem) {
+			cgroup_enable_per_threadgroup_rwsem = true;
+			rcu_sync_enter(&cgroup_threadgroup_rwsem.rss);
+		}
 		root->flags |= CGRP_ROOT_FAVOR_DYNMODS;
 	} else if (!favor && favoring) {
-		if (cgroup_enable_per_threadgroup_rwsem)
-			pr_warn_once("cgroup favordynmods: per threadgroup rwsem mechanism can't be disabled\n");
-		rcu_sync_exit(&cgroup_threadgroup_rwsem.rss);
-		root->flags &= ~CGRP_ROOT_FAVOR_DYNMODS;
+		pr_warn_once("cgroup favordynmods: per threadgroup rwsem mechanism can't be disabled\n");
 	}
 	percpu_up_write(&cgroup_threadgroup_rwsem);
 }
-- 
2.43.0

