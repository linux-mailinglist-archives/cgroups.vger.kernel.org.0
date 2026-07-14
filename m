Return-Path: <cgroups+bounces-17772-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id LBgmIR4RVmr4ygAAu9opvQ
	(envelope-from <cgroups+bounces-17772-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Tue, 14 Jul 2026 12:36:14 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C6A9B75375A
	for <lists+cgroups@lfdr.de>; Tue, 14 Jul 2026 12:36:13 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linux.dev header.s=key1 header.b=SuCwnIiX;
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-17772-lists+cgroups=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="cgroups+bounces-17772-lists+cgroups=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linux.dev;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 95157303CE84
	for <lists+cgroups@lfdr.de>; Tue, 14 Jul 2026 10:36:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F7AD35E95A;
	Tue, 14 Jul 2026 10:36:12 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from out-178.mta0.migadu.com (out-178.mta0.migadu.com [91.218.175.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1894017A300
	for <cgroups@vger.kernel.org>; Tue, 14 Jul 2026 10:36:09 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784025371; cv=none; b=LyyUVASY2Bl4C+Z5PK6X0ugPP4d9X6176qVRZST74WfBwSvRzRzlL0f+Gd0fi+Ixtig+OMK/y/Wgp9vzWm3C01eUpPooX5dNW7Delqjcxr3kLe5bVrFQFNr+BTW9Azj2K3J3EOz3sujhnCEoceHGHMJ2qHXgjLckvLymgl4kLFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784025371; c=relaxed/simple;
	bh=SOND1/Cxd1OOLqvNiLextOeAYdI//+q16RGWGj0LE+I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dbWyoz/BL7sqaabLET46nlQyqKJetjMlkdvAal/q85KDBnwGD+YnnHGVHcG9HqB6jutZQE3gSiZ1hMBvSfJJjSE/Aqvwv0/bPXJRD/FMAFfY3ZC8ABTUnXa/YQCPfh+TZC4+RMUgok72Q+x9BPFOy/cOLoeg2f4qqoZpLWwSoJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=SuCwnIiX; arc=none smtp.client-ip=91.218.175.178
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1784025367;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=NEYNgmwx4kxnQMtFaBoS8gmVo4HcRL7TLFRWxtR0Xb0=;
	b=SuCwnIiXtg5Xp0cr/kgIQLrJZmbpj1YOkcyXYs+9nolJRnYFghnR71L9q9MViEB/AonSnk
	pS431YofVAEAkixQ0OqNZgPmLm56M52fv+ox4DMhISvNkRvloYzlPHad4PU9aWwTndgVVI
	n8WvmfskHNqAtcQxaJBkiaVULvgJV60=
From: Tao Cui <cui.tao@linux.dev>
To: axboe@kernel.dk,
	tj@kernel.org,
	josef@toxicpanda.com
Cc: cgroups@vger.kernel.org,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Tao Cui <cuitao@kylinos.cn>
Subject: [PATCH] blk-throttle: fix divide-by-zero on legacy iops limit of 0
Date: Tue, 14 Jul 2026 18:35:52 +0800
Message-ID: <20260714103552.1335658-1-cui.tao@linux.dev>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-17772-lists,cgroups=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[cui.tao@linux.dev,cgroups@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:axboe@kernel.dk,m:tj@kernel.org,m:josef@toxicpanda.com,m:cgroups@vger.kernel.org,m:linux-block@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:cuitao@kylinos.cn,s:lists@lfdr.de];
	DKIM_TRACE(0.00)[linux.dev:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cui.tao@linux.dev,cgroups@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[cgroups];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linux.dev:from_mime,linux.dev:dkim,linux.dev:mid,kylinos.cn:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: C6A9B75375A

From: Tao Cui <cuitao@kylinos.cn>

Writing a multiple of 2^32 (e.g. 4294967296) to a legacy cgroup v1
throttle iops file (blkio.throttle.{read,write}_iops_device) silently
truncates to 0: tg_set_conf() stores the sscanf-parsed u64 value into
an unsigned int field with no clamping. The cgroup v2 path,
tg_set_limit(), already clamps the same kind of value with
min_t(u64, val, UINT_MAX), but the legacy path never did. Note that
the "!v -> U64_MAX" mapping only catches an explicit zero and does not
catch a value that truncates to zero.

With iops stored as 0, tg_update_has_rules() sets has_rules_iops[] and
the next IO reaches tg_within_iops_limit(), which computes

    jiffy_wait = max(jiffy_wait, HZ / iops_limit + 1);

triggering a divide-by-zero oops.

Fix it in two places:

  * tg_set_conf(): clamp the value to UINT_MAX, consistent with
    tg_set_limit(). This closes the truncation root cause (and the
    general silent truncation for any value above UINT_MAX).

  * tg_dispatch_iops_time(): treat iops_limit == 0 as unlimited so the
    divide in tg_within_iops_limit() is never reached, defending
    against any future path that could produce a zero limit.

Signed-off-by: Tao Cui <cuitao@kylinos.cn>
---
 block/blk-throttle.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/block/blk-throttle.c b/block/blk-throttle.c
index ffc3b70065d4..3f3c1374f4b2 100644
--- a/block/blk-throttle.c
+++ b/block/blk-throttle.c
@@ -883,7 +883,12 @@ static unsigned long tg_dispatch_iops_time(struct throtl_grp *tg, struct bio *bi
 	u32 iops_limit = tg_iops_limit(tg, rw);
 	unsigned long iops_wait;
 
-	if (iops_limit == UINT_MAX || tg->flags & THROTL_TG_CANCELING)
+	/*
+	 * iops_limit == 0 is not a valid limit. Treat it as unlimited so we
+	 * never reach the HZ / iops_limit divide in tg_within_iops_limit().
+	 */
+	if (iops_limit == UINT_MAX || iops_limit == 0 ||
+	    tg->flags & THROTL_TG_CANCELING)
 		return 0;
 
 	tg_update_slice(tg, rw);
@@ -1386,7 +1391,8 @@ static ssize_t tg_set_conf(struct kernfs_open_file *of,
 	if (is_u64)
 		*(u64 *)((void *)tg + of_cft(of)->private) = v;
 	else
-		*(unsigned int *)((void *)tg + of_cft(of)->private) = v;
+		*(unsigned int *)((void *)tg + of_cft(of)->private) =
+			min_t(u64, v, UINT_MAX);
 
 	tg_conf_updated(tg, false);
 	ret = 0;
-- 
2.43.0


