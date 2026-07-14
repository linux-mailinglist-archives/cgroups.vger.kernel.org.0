Return-Path: <cgroups+bounces-17769-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id wKvCK+gPVmrFygAAu9opvQ
	(envelope-from <cgroups+bounces-17769-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Tue, 14 Jul 2026 12:31:04 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 23E487536BD
	for <lists+cgroups@lfdr.de>; Tue, 14 Jul 2026 12:31:04 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linux.dev header.s=key1 header.b=d+vIPa9i;
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-17769-lists+cgroups=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="cgroups+bounces-17769-lists+cgroups=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linux.dev;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 9F686302B46C
	for <lists+cgroups@lfdr.de>; Tue, 14 Jul 2026 10:30:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C800F37CD27;
	Tue, 14 Jul 2026 10:30:46 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from out-173.mta0.migadu.com (out-173.mta0.migadu.com [91.218.175.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05ADD37757A
	for <cgroups@vger.kernel.org>; Tue, 14 Jul 2026 10:30:44 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784025046; cv=none; b=TUZgeaOj9ouTNPvfKvoQnNQd4JqZtSmRl9XSvx2/mYeLN6dAkgnW8h+uH2VR/T2UGQTQRTDVkyJdNEH3dGejQ+Bl9R3pjRSnpCjK9pC+97ujjXr31bUaVBckNayaPwkcs/eld7wSXKeNiLkV/fqJc8NhZtX0DQH3Ocmg0EKDaiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784025046; c=relaxed/simple;
	bh=n7uUnAsByIjvSgaZQkwQiCfH1Ys8honPYx+MozQ4Pg4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=q/tdRcRc8Ji3dxGsmrUVhTHWZOKXFKHZso6EOf81RxMkzqQ3W+P7VxpUkMD5cGT14sMF1i6Pod1TNLxD82FQA/bDh+I6Vb7eiybgOyip5zyZ4shTvK7HG7RP+1oud7UDfvq5Xhvxu9SQf8N/E25qu3YATmGqV3CuLHyeJM8bArg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=d+vIPa9i; arc=none smtp.client-ip=91.218.175.173
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1784025043;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=m/u7naX1aPgWaBFngKTQYarR31o9MXmyDdVdpFnIeS8=;
	b=d+vIPa9i1s8p6qSV0TrH4u+qccCQe5ntPIXvm3qUR9EVyWZ1PQh1+ijqc1/j1yHxftdNjA
	yw33ivNTTpcNGupo17itWaRhOhZhS+TFuVWMEcR4OGk/FoFMCm80BKqVei7oWyVcQmyl5J
	z92H3ugX5kfuH0Uybl327Fk06qWWWrs=
From: Tao Cui <cui.tao@linux.dev>
To: axboe@kernel.dk,
	tj@kernel.org,
	josef@toxicpanda.com
Cc: cgroups@vger.kernel.org,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Tao Cui <cuitao@kylinos.cn>
Subject: [PATCH 1/2] blk-throttle: avoid ilog2(0) in calculate_bytes_allowed()
Date: Tue, 14 Jul 2026 18:30:27 +0800
Message-ID: <20260714103028.1334831-2-cui.tao@linux.dev>
In-Reply-To: <20260714103028.1334831-1-cui.tao@linux.dev>
References: <20260714103028.1334831-1-cui.tao@linux.dev>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-17769-lists,cgroups=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[cgroups];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,linux.dev:from_mime,linux.dev:dkim,linux.dev:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 23E487536BD

From: Tao Cui <cuitao@kylinos.cn>

__tg_update_carryover() can call calculate_bytes_allowed() with a zero
jiffy_elapsed right after a slice starts. The overflow guard

    if (ilog2(bps_limit) + ilog2(jiffy_elapsed) - ilog2(HZ) > 62)

relies on ilog2(0) == -1 (fls64(0) - 1) to stay below the threshold so
that the subsequent mul_u64_u64_div_u64(bps, 0, HZ) == 0 is reached.
That works, but the ilog2(0) dependency is non-obvious.

Add an explicit early return for jiffy_elapsed == 0, which is equivalent
(mul_u64_u64_div_u64(bps_limit, 0, HZ) == 0) and removes the reliance on
ilog2(0).

No behavior change.

Signed-off-by: Tao Cui <cuitao@kylinos.cn>
---
 block/blk-throttle.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/block/blk-throttle.c b/block/blk-throttle.c
index ffc3b70065d4..f37911abefdd 100644
--- a/block/blk-throttle.c
+++ b/block/blk-throttle.c
@@ -603,6 +603,10 @@ static unsigned int calculate_io_allowed(u32 iops_limit,
 
 static u64 calculate_bytes_allowed(u64 bps_limit, unsigned long jiffy_elapsed)
 {
+	/* 0 elapsed => 0 bytes allowed; also avoids ilog2(0) below. */
+	if (!jiffy_elapsed)
+		return 0;
+
 	/*
 	 * Can result be wider than 64 bits?
 	 * We check against 62, not 64, due to ilog2 truncation.
-- 
2.43.0


