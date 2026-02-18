Return-Path: <cgroups+bounces-14000-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YFbFBuerlWkbTgIAu9opvQ
	(envelope-from <cgroups+bounces-14000-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Wed, 18 Feb 2026 13:09:11 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F9B115637A
	for <lists+cgroups@lfdr.de>; Wed, 18 Feb 2026 13:09:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id BEB7330066BD
	for <lists+cgroups@lfdr.de>; Wed, 18 Feb 2026 12:09:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7601305047;
	Wed, 18 Feb 2026 12:09:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="k9pu0NEc"
X-Original-To: cgroups@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 997B43033EB
	for <cgroups@vger.kernel.org>; Wed, 18 Feb 2026 12:09:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771416546; cv=none; b=RqZeceUMIlZKAS7Eh8XlYVSSNCC9+Gpkh+Ss2QmFp2jL8kkEbzV7O2fmN8ppJHmVIRI578DKJjtotrS2gXD3zrlVbvexk8TBaqKJk7LHNbs/LOhWKnrH98n2pqGXkYNAvNNTse2PjILdDfFn5BIWqOcOl0N/z/hIaAqGJ6DRLGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771416546; c=relaxed/simple;
	bh=PEG4JEVdEI1trv+ro+d+VLifmpvb+POOdLs9mtC3ohc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=FpEJ/mf+VPbXhL1w4l8HnK/5n+7MljIQQaXLEfIgotjtatDi7+GvSU1QYhKDj5ngQJ+TG5T4SEV8r82PoUoJfZDYCNHvSAgoPZGYhFWDexhDTB7aPhx0qyEKn5M1ZBl5uulHu/anCoPFHrK5RpH+JvJNv1MIeYzSOVSHQ/yBESo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=k9pu0NEc; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1771416545; x=1802952545;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=PEG4JEVdEI1trv+ro+d+VLifmpvb+POOdLs9mtC3ohc=;
  b=k9pu0NEcau+7oXXZfdCNB2fmd+yY04Xu/cMecOjZLJaJYnZHZVWjTW+E
   TTRJGfiu/ZSy0X5hT8f6/aKUJDuMNSYriUXR4Egsw9A5vGaoWiIHGLcqz
   4m2ykxAsioZZ8894xpivW5Kvn94kbNjBSUPM3ah0V80Ua4QVRubo0wJZ2
   X8j75u0pZJ2NydGXY56RRfTWsceBoJoFftlKiqNqLwXVUQWGUr8zA+8zW
   Mki4HK9DQp5g8kthxQJwpMVpyNg3IEM6qk+hkiX6b+4veMJ6R7QVGCjzp
   kRHYH9VRkxPNEoWAxj5pHEKLO9Bz0tkTKb3gTqNII7+FF7BhyXXqcKflX
   Q==;
X-CSE-ConnectionGUID: ipRu4u1fT2qaL/V+2+xSYw==
X-CSE-MsgGUID: 2sMrpHSPSkeK33rTW1hJjQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11704"; a="72534489"
X-IronPort-AV: E=Sophos;i="6.21,298,1763452800"; 
   d="scan'208";a="72534489"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Feb 2026 04:08:55 -0800
X-CSE-ConnectionGUID: iz6a8qeRSq+hNH9A1f+iLg==
X-CSE-MsgGUID: JXWg475fRXyjkivjwT5OAA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,298,1763452800"; 
   d="scan'208";a="212842745"
Received: from baandr0id001.iind.intel.com ([10.66.253.151])
  by fmviesa007.fm.intel.com with ESMTP; 18 Feb 2026 04:08:53 -0800
From: Kaushlendra Kumar <kaushlendra.kumar@intel.com>
To: tj@kernel.org,
	hannes@cmpxchg.org,
	mkoutny@suse.com
Cc: cgroups@vger.kernel.org,
	Kaushlendra Kumar <kaushlendra.kumar@intel.com>
Subject: [PATCH] cgroup: free cset links on find_css_set() failure
Date: Wed, 18 Feb 2026 17:35:43 +0530
Message-Id: <20260218120543.1113594-1-kaushlendra.kumar@intel.com>
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
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-14000-lists,cgroups=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kaushlendra.kumar@intel.com,cgroups@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:mid,intel.com:dkim,intel.com:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 8F9B115637A
X-Rspamd-Action: no action

When the recursive find_css_set() call for the domain
cset fails, tmp_links allocated earlier are not freed,
causing a memory leak.

Free tmp_links before returning NULL to prevent the leak.

Fixes: 454000adaa2a ("cgroup: introduce cgroup->dom_cgrp and threaded css_set handling")

Signed-off-by: Kaushlendra Kumar <kaushlendra.kumar@intel.com>
---
 kernel/cgroup/cgroup.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
index 5f0d33b04910..b1f66311e8d3 100644
--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -1308,6 +1308,7 @@ static struct css_set *find_css_set(struct css_set *old_cset,
 		dcset = find_css_set(cset, cset->dfl_cgrp->dom_cgrp);
 		if (!dcset) {
 			put_css_set(cset);
+			free_cgrp_cset_links(&tmp_links);
 			return NULL;
 		}
 
-- 
2.34.1


