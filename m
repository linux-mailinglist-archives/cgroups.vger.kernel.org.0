Return-Path: <cgroups+bounces-17857-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 9YcEN4eKV2pTWgAAu9opvQ
	(envelope-from <cgroups+bounces-17857-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Wed, 15 Jul 2026 15:26:31 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 79A0E75EA84
	for <lists+cgroups@lfdr.de>; Wed, 15 Jul 2026 15:26:31 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linux.dev header.s=key1 header.b="SF9I7/lZ";
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-17857-lists+cgroups=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="cgroups+bounces-17857-lists+cgroups=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linux.dev;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 3785C300D4CA
	for <lists+cgroups@lfdr.de>; Wed, 15 Jul 2026 13:24:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 881FE2931CF;
	Wed, 15 Jul 2026 13:24:43 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from out-181.mta0.migadu.com (out-181.mta0.migadu.com [91.218.175.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BF3641DEF1;
	Wed, 15 Jul 2026 13:24:40 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784121883; cv=none; b=D6UQ3J1FV/m0/8omp2Bpprk9TvlpwSnCboJ7thuIrEgekWeqenLatIJMbOpYFylHGWBtlDlsdj4M6OUyKR35pwBPvlRznCd05F60zeKuwygbvdPUIKWV9Wf027hIXwlkFptFHJrkO+G1N9twBI//uS068U8mo+UhNOQm0TJ+xNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784121883; c=relaxed/simple;
	bh=oNvvz7J2Hu5fu36ODaZxmH1lq4ffgOu6G6kz95Tperw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=CqQXR5luFV2gN9/dzP8GMmmj7nhBPI0ZBX2Xway+KJS0UAIq1daRrfFJTCRjDM1GDhPmzFrVhij8HpelrgPVwF3ICTFEOqMaiGkfRPyvnJkgGeG0rtUCBOiW3Ysa7zBB6kz8mb5nBNBc6zojNIPh3EaD5Yn05Afl3wW10HocWBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=SF9I7/lZ; arc=none smtp.client-ip=91.218.175.181
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1784121879;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=VVC8BP6HSrZ601d9eEJEZtY6cb1rMz2d7T5MCvA0R3k=;
	b=SF9I7/lZMX+u/QqdYTqudSyhNKcIiUMpMxiK0v4P92tLTHBZr0JAVBuZVQgLUBugXdndUb
	NRjdMTi7nv/nXXSk25IlyokymrrBT4e80pYGjh6LilWP6/pOQzSyrLjh8wKm3OOH8fbg5c
	am1Dxrsi3P3HEU4b6FHH0StNZIDB544=
From: Tao Cui <cui.tao@linux.dev>
To: tj@kernel.org,
	axboe@kernel.dk,
	josef@toxicpanda.com
Cc: cgroups@vger.kernel.org,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	cui.tao@linux.dev,
	Tao Cui <cuitao@kylinos.cn>
Subject: [PATCH v4] blk-cgroup: fix leaks and online flag on radix_tree_insert failure
Date: Wed, 15 Jul 2026 21:24:07 +0800
Message-ID: <20260715132407.1469777-1-cui.tao@linux.dev>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-17857-lists,cgroups=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER(0.00)[cui.tao@linux.dev,cgroups@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:tj@kernel.org,m:axboe@kernel.dk,m:josef@toxicpanda.com,m:cgroups@vger.kernel.org,m:linux-block@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:cui.tao@linux.dev,m:cuitao@kylinos.cn,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cui.tao@linux.dev,cgroups@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.dev:+];
	RCPT_COUNT_SEVEN(0.00)[8];
	TAGGED_RCPT(0.00)[cgroups];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,linux.dev:dkim,linux.dev:mid,linux.dev:from_mime,kylinos.cn:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 79A0E75EA84
X-Rspamd-Action: no action

From: Tao Cui <cuitao@kylinos.cn>

When radix_tree_insert() fails in blkg_create(), the error path has two
issues:

1. blkg->online is set to true unconditionally, even when the blkg was
   never fully inserted.  Move the assignment inside the success block.

2. The error path calls blkg_put() without first calling
   percpu_ref_kill().  Because the refcount is still in percpu mode,
   percpu_ref_put() only does this_cpu_sub() without checking for zero,
   so blkg_release() is never triggered.  This permanently leaks the
   blkg memory, its percpu iostat, policy data, the parent blkg
   reference, and the cgroup css reference — the latter preventing the
   cgroup from ever being destroyed.

Fix by replacing blkg_put() with percpu_ref_kill(), matching the pattern
used in blkg_destroy().

Acked-by: Tejun Heo <tj@kernel.org>
Signed-off-by: Tao Cui <cuitao@kylinos.cn>

---
v4:
- Resend. No functional change. Folded in Acked-by from Tejun Heo and
  rebased onto current mainline (context-only: the err_put_css label was
  renamed to err_free_blkg upstream).

v3:
- Remove the redundant blkg_put() after percpu_ref_kill() to avoid a
  double-put that causes the refcount to go negative and bypass
  blkg_release(), as pointed out by the sashiko AI review.
  v3: https://lore.kernel.org/all/20260507061229.57466-1-cuitao@kylinos.cn/

v2:
- Also fix the percpu_ref leak on the radix_tree_insert() error path by
  adding percpu_ref_kill() before blkg_put(), as pointed out by the
  sashiko AI review.
  v1: https://lore.kernel.org/all/20260506131124.16755-1-cuitao@kylinos.cn/
---
 block/blk-cgroup.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/block/blk-cgroup.c b/block/blk-cgroup.c
index d2a1f5903f24..d9676126c5b5 100644
--- a/block/blk-cgroup.c
+++ b/block/blk-cgroup.c
@@ -434,15 +434,15 @@ static struct blkcg_gq *blkg_create(struct blkcg *blkcg, struct gendisk *disk,
 				blkg->pd[i]->online = true;
 			}
 		}
+		blkg->online = true;
 	}
-	blkg->online = true;
 	spin_unlock(&blkcg->lock);
 
 	if (!ret)
 		return blkg;
 
 	/* @blkg failed fully initialized, use the usual release path */
-	blkg_put(blkg);
+	percpu_ref_kill(&blkg->refcnt);
 	return ERR_PTR(ret);
 
 err_free_blkg:
-- 
2.43.0


