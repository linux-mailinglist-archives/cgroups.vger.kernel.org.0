Return-Path: <cgroups+bounces-16548-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UComMgNeHmo/iwkAu9opvQ
	(envelope-from <cgroups+bounces-16548-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Tue, 02 Jun 2026 06:37:23 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B1706281F1
	for <lists+cgroups@lfdr.de>; Tue, 02 Jun 2026 06:37:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3DA97301EC4A
	for <lists+cgroups@lfdr.de>; Tue,  2 Jun 2026 04:37:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A17922D9ECD;
	Tue,  2 Jun 2026 04:37:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="aWKTDbeq"
X-Original-To: cgroups@vger.kernel.org
Received: from out-181.mta0.migadu.com (out-181.mta0.migadu.com [91.218.175.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 589EA2D73BC
	for <cgroups@vger.kernel.org>; Tue,  2 Jun 2026 04:37:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780375041; cv=none; b=gegy1Hk8JPg8aZswLmIg9ELeE/C5N2somxPx3CqKnnvOuPY/u2ikIQbd+lfz4ogf/4RsWvC0RltvqyiRni3iTUYVqAiG+K/hp4OK1RY3Cr8TJpa35nR2kzaQHbFYChoQpWvstx6lqX2IySTchnBLwRelQBTSWll/40r5o1EkfqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780375041; c=relaxed/simple;
	bh=9/SOrUNrdv5pDRn74T/OmcwpB6DT/cLzDd/WdzogI5c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ax5BfRx+Sg67dQX5QpGbSiOinHWQIwgHos0hyq4kTDicO2Z8yZ03qNvDVwLVx2aqHSj03mWTvuBUGzzmF3q66pjuFUl0JvtCyBQEybQdIB8wwMHeZHClSmyzgx8fZj1RPxNnGmUBOVVsv3VEy0yzoF6ejrOucsAeZGfDUXeT7fw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=aWKTDbeq; arc=none smtp.client-ip=91.218.175.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1780375038;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=peuZHFf5XR1rBPnHRF4an7rYxjYHirpHAFohNH2pvbg=;
	b=aWKTDbeqiqB+uHFGWIC30xrjPt41MBLN1b0kXlMwUGcF4ftvwTmRbDxenuMK9YnGQnwhaE
	9IJ+LgxvFFSVYXBAJ+jeNE3qDoLgCsH8NOlefgmQsoXHcCp1BBo4QuJdrzuifzLuPun02A
	3YHaGqdFxp8ePm1KVR5FNJFMUYeZDRU=
From: Tao Cui <cui.tao@linux.dev>
To: longman@redhat.com,
	chenridong@huaweicloud.com,
	tj@kernel.org,
	hannes@cmpxchg.org,
	mkoutny@suse.com,
	cgroups@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Tao Cui <cuitao@kylinos.cn>,
	"Claude Opus 4 . 7" <noreply@anthropic.com>
Subject: [PATCH] cgroup/cpuset: Fix update_prstate() always returning 0 on partition errors
Date: Tue,  2 Jun 2026 12:36:52 +0800
Message-ID: <20260602043652.2380163-1-cui.tao@linux.dev>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spamd-Result: default: False [2.94 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	SUSPICIOUS_URL_IN_SUSPICIOUS_MESSAGE(1.00)[];
	URIBL_RED(0.50)[kylinos.cn:email];
	R_MISSING_CHARSET(0.50)[];
	MAILLIST(-0.15)[generic];
	BAD_REP_POLICIES(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	HAS_ANON_DOMAIN(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-16548-lists,cgroups=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cui.tao@linux.dev,cgroups@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	R_DKIM_ALLOW(0.00)[linux.dev:s=key1];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	DMARC_POLICY_ALLOW(0.00)[linux.dev,none];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ARC_ALLOW(0.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(0.00)[+ip4:172.105.105.114:c];
	TAGGED_RCPT(0.00)[cgroups];
	DKIM_TRACE(0.00)[linux.dev:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_SPAM(0.00)[0.069];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,linux.dev:mid,linux.dev:dkim,kylinos.cn:email]
X-Rspamd-Queue-Id: 3B1706281F1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Tao Cui <cuitao@kylinos.cn>

update_prstate() stores the error code in cs->prs_err and transitions
the partition to an invalid state, but always returns 0. The caller
cpuset_partition_write() uses "return retval ?: nbytes", so the write
syscall always appears to succeed from userspace even when the partition
became invalid. Return -EINVAL when err is set so userspace can detect
the failure immediately.

Co-Authored-By: Claude Opus 4.7 <noreply@anthropic.com>
---
 kernel/cgroup/cpuset.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
index 591e3aa487fc..8605b4da610e 100644
--- a/kernel/cgroup/cpuset.c
+++ b/kernel/cgroup/cpuset.c
@@ -2965,7 +2965,7 @@ static int update_prstate(struct cpuset *cs, int new_prs)
 	if (force_sd_rebuild)
 		rebuild_sched_domains_locked();
 	free_tmpmasks(&tmpmask);
-	return 0;
+	return err ? -EINVAL : 0;
 }
 
 static struct cpuset *cpuset_attach_old_cs;
-- 
2.43.0


