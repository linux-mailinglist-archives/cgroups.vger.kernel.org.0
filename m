Return-Path: <cgroups+bounces-16558-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aDw2DMmjHmq3IwAAu9opvQ
	(envelope-from <cgroups+bounces-16558-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Tue, 02 Jun 2026 11:35:05 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A92F62BA67
	for <lists+cgroups@lfdr.de>; Tue, 02 Jun 2026 11:35:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1DBF8307056A
	for <lists+cgroups@lfdr.de>; Tue,  2 Jun 2026 09:13:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E96F138A733;
	Tue,  2 Jun 2026 09:11:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="KdasGFZA"
X-Original-To: cgroups@vger.kernel.org
Received: from out-183.mta0.migadu.com (out-183.mta0.migadu.com [91.218.175.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A3C21BC2A
	for <cgroups@vger.kernel.org>; Tue,  2 Jun 2026 09:11:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780391472; cv=none; b=JnAgNT+ZEW2Mx1NtfWWEpTyKPkopw2yRUcbX6GedDtbMUKULNFywpmcSfZpHtUlfOVpTOIAQoRhul3PGF+3Jzw1Y/kenNKmUT6SuG4o0sx8o1apocHFAhODjSKhTmAmJNUSx6KLQyLA5JPn8DKCU5jyMQESfzmBjSehlGfg8UhE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780391472; c=relaxed/simple;
	bh=R5nF5fhLnhrV2GlYTBTPDzqMqYcMhqKJ/HrzeSyHhCg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gbnC7fenvtGVQBGup0lmvNy+vC8ZJ/k1o++Z01AJir1I1PgH+KlmlYOtx7PC3oddfB6KAuTVrVJXr9tOXK/UcbT51nXu7y1f8xXYEX3I1wkkCrYN+//U0NraFT/0Vhed7j4bWPX+oWHOVt6Mv++AN9opiDXjTZJ5LzCgInPpZKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=KdasGFZA; arc=none smtp.client-ip=91.218.175.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1780391469;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=360XwP/yPRhCWKhxS8hhQoZw5l/EoTdk5kd9baoql/o=;
	b=KdasGFZAj/cyjCYRC7bMGkVNyB344TePInDLAabZBJmA1NsDRUJrO2RDAlnmhU28nanMM1
	jF68aCIUSut3GYEAFM0lZZO9HyWeW5DX9t8XrmNEQ5+/BiIs444nP2kFOL8kY6WrTbIEE6
	kLfKEGbopnmnA6pOMj5b4kmE3IMZe7w=
From: Ridong Chen <ridong.chen@linux.dev>
To: Waiman Long <longman@redhat.com>,
	Tejun Heo <tj@kernel.org>,
	Johannes Weiner <hanes@cmpxchg.org>,
	=?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>
Cc: cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	ridong.chen@linux.dev
Subject: [PATCH] cgroup/cpuset: change ridong's email
Date: Tue,  2 Jun 2026 17:10:38 +0800
Message-ID: <20260602091038.26901-1-ridong.chen@linux.dev>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Queue-Id: 9A92F62BA67
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [4.84 / 15.00];
	SEM_URIBL(3.50)[huaweicloud.com:email];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	BAD_REP_POLICIES(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-16558-lists,cgroups=lfdr.de];
	PRECEDENCE_BULK(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	R_DKIM_ALLOW(0.00)[linux.dev:s=key1];
	GREYLIST(0.00)[pass,body];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_POLICY_ALLOW(0.00)[linux.dev,none];
	DKIM_TRACE(0.00)[linux.dev:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	R_SPF_ALLOW(0.00)[+ip4:172.105.105.114:c];
	TAGGED_RCPT(0.00)[cgroups];
	RCPT_COUNT_SEVEN(0.00)[7];
	FROM_NEQ_ENVFROM(0.00)[ridong.chen@linux.dev,cgroups@vger.kernel.org];
	ARC_ALLOW(0.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,linux.dev:mid,linux.dev:dkim,linux.dev:email,huaweicloud.com:email]
X-Rspamd-Action: no action

The chenridong@huaweicloud.com is no longer a valid email,
replace it with the personal email ridong.chen@linux.dev

Signed-off-by: Ridong Chen <ridong.chen@linux.dev>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 9ec290e38b44..e035a3be797c 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -6535,7 +6535,7 @@ F:	include/linux/blk-cgroup.h
 
 CONTROL GROUP - CPUSET
 M:	Waiman Long <longman@redhat.com>
-R:	Chen Ridong <chenridong@huaweicloud.com>
+R:	Ridong Chen <ridong.chen@linux.dev>
 L:	cgroups@vger.kernel.org
 S:	Maintained
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup.git
-- 
2.43.0


