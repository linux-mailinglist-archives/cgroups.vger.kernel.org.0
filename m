Return-Path: <cgroups+bounces-13931-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8I5AE2LQjmnKFAEAu9opvQ
	(envelope-from <cgroups+bounces-13931-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Fri, 13 Feb 2026 08:18:58 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D8DF51336FF
	for <lists+cgroups@lfdr.de>; Fri, 13 Feb 2026 08:18:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CF5F6305ED03
	for <lists+cgroups@lfdr.de>; Fri, 13 Feb 2026 07:18:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E106280037;
	Fri, 13 Feb 2026 07:18:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ofPx+WCp"
X-Original-To: cgroups@vger.kernel.org
Received: from out-172.mta0.migadu.com (out-172.mta0.migadu.com [91.218.175.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F18C5211A28;
	Fri, 13 Feb 2026 07:18:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770967130; cv=none; b=j5Oy9OAGcSLQVpeNZbQY9q1n1vObnRiH+JvDNhlVQgzZpbt5BNjkGBQjeXSjQ4vwUTTR2UaBayZ0m2C1ru8jiMFWauG2hHmc9787WR1jtIOVlXkCqkx/Fyiz8Dqk1VqW64WqA9h9tuOb5vBG+B0tNn313aM8H0tT1Ai6C2ddqbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770967130; c=relaxed/simple;
	bh=nrZ+DfNphSQEEqYBHdHC1V4TEyPSwExeOiovDkxhc9A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rUoT7Vu149Qoz/1fy2tqPijbuqN1SPrHRiGviocB/yLnWWN/1xPzs5IuUjpLPLgHFA2tZA6MQFEf8fpUUEEqdL1ovOIFEQHqgP6rWQsRnWxhAe925JzwdZGddnue44BZVVV7V6qXe8Pf39xat+K0Idg5MzyOGN4+kHD9YIudy1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ofPx+WCp; arc=none smtp.client-ip=91.218.175.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1770967125;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=wrYq2pAJJuqrmBI86q10Z6dZRJSTibQvGpw+Z8u3inA=;
	b=ofPx+WCpUD8w8iUlCR3WoE5H+/NFqYmwHjeEhP/opwMxn+UHtNg5RK8MyxzEojkK5uUO+E
	aPX71PF+yk9CRysc4uGf+RVU3yUiOuMpzYiv90NB9CJ8dpbr6dV/HhnDmvfxGtYEOAD6v8
	Msq0w6OwAqDpSg2Yb3psPeErNC4hGcc=
From: Jiayuan Chen <jiayuan.chen@linux.dev>
To: linux-mm@kvack.org
Cc: jiayuan.chen@linux.dev,
	Tejun Heo <tj@kernel.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	=?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Michal Hocko <mhocko@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Muchun Song <muchun.song@linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>,
	Yosry Ahmed <yosry.ahmed@linux.dev>,
	Nhat Pham <nphamcs@gmail.com>,
	Chengming Zhou <chengming.zhou@linux.dev>,
	Shuah Khan <shuah@kernel.org>,
	cgroups@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH mm-new v3 0/2] mm: zswap: add per-memcg stat for incompressible pages
Date: Fri, 13 Feb 2026 15:18:21 +0800
Message-ID: <20260213071827.5688-1-jiayuan.chen@linux.dev>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-13931-lists,cgroups=lfdr.de];
	FREEMAIL_CC(0.00)[linux.dev,kernel.org,cmpxchg.org,suse.com,lwn.net,linux-foundation.org,gmail.com,vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[19];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jiayuan.chen@linux.dev,cgroups@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linux.dev:+];
	PRECEDENCE_BULK(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[cgroups];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:mid,linux.dev:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: D8DF51336FF
X-Rspamd-Action: no action

In containerized environments, knowing which cgroup is contributing
incompressible pages to zswap is essential for effective resource
management. This series adds a new per-memcg stat 'zswap_incomp' to
track incompressible pages, along with a selftest.

Patch 1: Add the per-memcg zswap_incomp stat and documentation
Patch 2: Add selftest for the new stat

Changes v2 -> v3:
https://lore.kernel.org/linux-mm/20260206072220.144008-1-jiayuan.chen@linux.dev/

- Remove inline comments for incompressibility check (Yosry Ahmed)
- Use PAGE_SIZE instead of hardcoded 4096 in selftest (SeongJae Park)
- Use pipe for parent-child synchronization instead of usleep
  (JP Kobryn, SeongJae Park)
- Use MADV_PAGEOUT instead of memory.reclaim to push pages into zswap,
  and use mmap instead of malloc accordingly (Nhat Pham)
- Collect Reviewed-by and Acked-by tags

Changes v1 -> v2:
https://lore.kernel.org/linux-mm/20260205053013.25134-1-jiayuan.chen@linux.dev/

- Rename zswpraw/MEMCG_ZSWAP_RAW to zswap_incomp/MEMCG_ZSWAP_INCOMP
  (Shakeel Butt, Yosry Ahmed)
- Drop zswap_is_incomp() helper, keep opencode (size == PAGE_SIZE) with
  comments explaining the incompressibility check (Yosry Ahmed)
- Add documentation in cgroup-v2.rst (Nhat Pham, SeongJae Park)
- Add selftest as a separate patch (Nhat Pham)
- Add reference link to Chris Li's discussion on the need for per-memcg
  incompressible page tracking (Nhat Pham)

Jiayuan Chen (2):
  mm: zswap: add per-memcg stat for incompressible pages
  selftests/cgroup: add test for zswap incompressible pages

 Documentation/admin-guide/cgroup-v2.rst     |   5 +
 include/linux/memcontrol.h                  |   1 +
 mm/memcontrol.c                             |   6 +
 tools/testing/selftests/cgroup/test_zswap.c | 136 ++++++++++++++++++++
 4 files changed, 148 insertions(+)

-- 
2.43.0


