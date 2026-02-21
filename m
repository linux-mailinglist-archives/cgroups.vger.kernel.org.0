Return-Path: <cgroups+bounces-14081-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 64nEFvkrmWlkRQMAu9opvQ
	(envelope-from <cgroups+bounces-14081-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Sat, 21 Feb 2026 04:52:25 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AA2CD16C13C
	for <lists+cgroups@lfdr.de>; Sat, 21 Feb 2026 04:52:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DE07A303E4B3
	for <lists+cgroups@lfdr.de>; Sat, 21 Feb 2026 03:52:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5528829B216;
	Sat, 21 Feb 2026 03:52:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="L98+xfWQ"
X-Original-To: cgroups@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A5422B9B7
	for <cgroups@vger.kernel.org>; Sat, 21 Feb 2026 03:52:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771645941; cv=none; b=BZI4prCylDY2BtvZnXFk2QzHY8G+H3yCvJEUNK42vzVpQlwk/NiA3xz00cjfvbNkEip6JU5e/KXErBzqY+lqfG2w7g3VotCnRNw75xFAHOyYHbYp1iAN82B7mBxJa+U/i3A9FuDunQgZ6zOUzZtkLXTHzQq7bTKEOo86m+2HbEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771645941; c=relaxed/simple;
	bh=FXKkeTxlRWlD1Bud7fsOHtku+9SZaVG5kxRow6Vok50=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=A0xNnH+Lt3i2qDEF26qFoTE70gmmV28CX+euejqHQq5H1JEX6uIEbtS2f0gdeWYIRsIqHysscoa5rWPKNrXpVN08jhJn49VQ0r7lBRYQc23uuXiVmHp0SP7G2Pq59Z6i42V6h8AM1F5nd5YK5pgmjEi5dPK1v8Y63gznfjeE3no=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=L98+xfWQ; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1771645939; x=1803181939;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=FXKkeTxlRWlD1Bud7fsOHtku+9SZaVG5kxRow6Vok50=;
  b=L98+xfWQbpSt/UOFrdQTIY9IRVjYVrMzRRcdT2gPSrfgkTqXcd/atS2M
   UbfTowf6ZMUFqtnF+0yDdVCdH61Vtwy7vzFo3WdPO8IpoebfpsjSJ0H8E
   duMzUzhGJXzoakvmfU+q059UFlGZgq93hBWmtj/UAJgBRTzllrKgc88Rz
   +b2pzJF5QF/Wf4wtgcDLjd1+uL0ecLrkOMzzYVzfpvyPyXnb4SSYeWy75
   2RmR34VtvhqPJ3MFHDu6TQRg/SJUjznOySYJOgW0vuBNb0yKQU5k9R4t+
   Zj+bQBoRb2UakEKpAJHUdQSVL0OwSBcjUATTHowK6zOVZKXM5mE/al2LJ
   g==;
X-CSE-ConnectionGUID: /87IIs1ATbuRNq/12wrXnQ==
X-CSE-MsgGUID: bNTfae1JRnS1NP7DOH45VA==
X-IronPort-AV: E=McAfee;i="6800,10657,11707"; a="72778532"
X-IronPort-AV: E=Sophos;i="6.21,302,1763452800"; 
   d="scan'208";a="72778532"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Feb 2026 19:52:19 -0800
X-CSE-ConnectionGUID: AvNe6DtYQxeeajLu9D88UA==
X-CSE-MsgGUID: 9gSl+p5cQV22gvh2HxnHDQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,302,1763452800"; 
   d="scan'208";a="213094293"
Received: from baandr0id001.iind.intel.com ([10.66.253.151])
  by fmviesa006.fm.intel.com with ESMTP; 20 Feb 2026 19:52:17 -0800
From: Kaushlendra Kumar <kaushlendra.kumar@intel.com>
To: tj@kernel.org,
	hannes@cmpxchg.org,
	mkoutny@suse.com
Cc: cgroups@vger.kernel.org,
	Kaushlendra Kumar <kaushlendra.kumar@intel.com>
Subject: [PATCH] cgroup: ensure stable pid sorting in cmppid()
Date: Sat, 21 Feb 2026 09:19:07 +0530
Message-Id: <20260221034907.2110829-1-kaushlendra.kumar@intel.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-14081-lists,cgroups=lfdr.de];
	DKIM_TRACE(0.00)[intel.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[kaushlendra.kumar@intel.com,cgroups@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[cgroups];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: AA2CD16C13C
X-Rspamd-Action: no action

The subtraction-based comparator (a - b) in cmppid() can
overflow for large pid_t differences, producing incorrect
sign values. This breaks qsort() ordering guarantees and
may cause unstable or wrong sort results in pidlist output.

Replace with a three-way comparison idiom:
  (a > b) - (a < b)

This reliably returns -1, 0, or +1 without overflow,
ensuring correct and stable qsort() behavior for all
pid_t values.

Signed-off-by: Kaushlendra Kumar <kaushlendra.kumar@intel.com>
---
 kernel/cgroup/cgroup-v1.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/kernel/cgroup/cgroup-v1.c b/kernel/cgroup/cgroup-v1.c
index 724950c4b690..7fdfa37aaa5f 100644
--- a/kernel/cgroup/cgroup-v1.c
+++ b/kernel/cgroup/cgroup-v1.c
@@ -281,7 +281,10 @@ static int pidlist_uniq(pid_t *list, int length)
  */
 static int cmppid(const void *a, const void *b)
 {
-	return *(pid_t *)a - *(pid_t *)b;
+	pid_t pa = *(pid_t *)a;
+	pid_t pb = *(pid_t *)b;
+
+	return (pa > pb) - (pa < pb);
 }
 
 static struct cgroup_pidlist *cgroup_pidlist_find(struct cgroup *cgrp,
-- 
2.34.1


