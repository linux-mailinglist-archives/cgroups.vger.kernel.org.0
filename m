Return-Path: <cgroups+bounces-17853-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id y62EFMKGV2osWQAAu9opvQ
	(envelope-from <cgroups+bounces-17853-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Wed, 15 Jul 2026 15:10:26 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id D47F175E7FE
	for <lists+cgroups@lfdr.de>; Wed, 15 Jul 2026 15:10:25 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linux.dev header.s=key1 header.b=wBk2u5wK;
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-17853-lists+cgroups=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="cgroups+bounces-17853-lists+cgroups=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linux.dev;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id AB8CD3058959
	for <lists+cgroups@lfdr.de>; Wed, 15 Jul 2026 13:00:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EFCE42047C;
	Wed, 15 Jul 2026 12:52:03 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from out-187.mta1.migadu.com (out-187.mta1.migadu.com [95.215.58.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67D9048096D
	for <cgroups@vger.kernel.org>; Wed, 15 Jul 2026 12:52:00 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784119923; cv=none; b=EC/SMsKNsIAfTCrMXGJZ0ZOeKIgNZGZr96f2RyVrNEUxB/0r6OQaq0EneX2FjDHAubFU6ibmrt9y/wkzmbFL8JIyHNm8zkh1LM0mYqU7Km1Qu2kbbTnOcjnVnKqJUSMyaDn0XLmWgyHJLW/hYmqh9CRFF09QONdNyAoPzBtuM/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784119923; c=relaxed/simple;
	bh=6wYSU62thzVRYKNUV2Zw4FYmAPCOH9Klhl0wgPRCNbY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=iwAxGHPiKYhiN8h8AxpTaax2mBMCGaDAc2QZWjT4l4HB8PJOOdpOfEbuH0YCSEdKGb6MvQjn7fRv9lCLK7ixdzQaSXahSwFQlfMCveGWe9vCH6/HXqFMy5V7yZD3woU6Wj57+80D7HcAMzQO8P9HVek2RtezqYdwTKL//FCDcMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=wBk2u5wK; arc=none smtp.client-ip=95.215.58.187
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1784119918;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=2ibwhVDUnRMe9w+G2O+OXs1fFptxfiDWntjqmf1tuyE=;
	b=wBk2u5wKz/Ie/2taeKa+xEwQ9TjBF7foOvqo0oj9xrlERkApdPy6GCQrojVUOUYGLYUcHs
	JsGCVBWBT4WUOyyfteICk+so1+huhkB3ocheXCOoeu0MapzqsFeGMkIv0HO1d1zFQqY9a0
	3HFzF4uNyTK+4IqDkA8V+9YOHdzxVsE=
From: Tao Cui <cui.tao@linux.dev>
To: axboe@kernel.dk,
	tj@kernel.org,
	josef@toxicpanda.com
Cc: cgroups@vger.kernel.org,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Tao Cui <cuitao@kylinos.cn>,
	David Laight <david.laight.linux@gmail.com>
Subject: [PATCH v2] blk-throttle: fix divide-by-zero on legacy iops limit of 0
Date: Wed, 15 Jul 2026 20:50:42 +0800
Message-ID: <20260715125042.1465476-1-cui.tao@linux.dev>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-17853-lists,cgroups=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[vger.kernel.org,kylinos.cn,gmail.com];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[cui.tao@linux.dev,cgroups@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:axboe@kernel.dk,m:tj@kernel.org,m:josef@toxicpanda.com,m:cgroups@vger.kernel.org,m:linux-block@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:cuitao@kylinos.cn,m:david.laight.linux@gmail.com,m:davidlaightlinux@gmail.com,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cui.tao@linux.dev,cgroups@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linux.dev:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[cgroups];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,vger.kernel.org:from_smtp,kylinos.cn:email,linux.dev:dkim,linux.dev:mid,linux.dev:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: D47F175E7FE
X-Rspamd-Action: no action

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
Changes in v2:
- Use a "void *field" local for the config write so the assignment reads
  *(u64 *)field / *(unsigned int *)field instead of the
  (type *)((void *)tg + of_cft(of)->private) casts.
- Use min(v, (u64)UINT_MAX) instead of min_t(u64, v, UINT_MAX).
---
 block/blk-throttle.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/block/blk-throttle.c b/block/blk-throttle.c
index ffc3b70065d4..9900443b0ad5 100644
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
@@ -1383,10 +1388,12 @@ static ssize_t tg_set_conf(struct kernfs_open_file *of,
 	tg = blkg_to_tg(ctx.blkg);
 	tg_update_carryover(tg);
 
+	void *field = (void *)tg + of_cft(of)->private;
+
 	if (is_u64)
-		*(u64 *)((void *)tg + of_cft(of)->private) = v;
+		*(u64 *)field = v;
 	else
-		*(unsigned int *)((void *)tg + of_cft(of)->private) = v;
+		*(unsigned int *)field = min(v, (u64)UINT_MAX);
 
 	tg_conf_updated(tg, false);
 	ret = 0;
-- 
2.43.0


