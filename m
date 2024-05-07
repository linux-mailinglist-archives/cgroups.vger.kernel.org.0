Return-Path: <cgroups+bounces-2818-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 91BBD8BDFE6
	for <lists+cgroups@lfdr.de>; Tue,  7 May 2024 12:40:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 46E7A289C87
	for <lists+cgroups@lfdr.de>; Tue,  7 May 2024 10:40:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8971614EC5D;
	Tue,  7 May 2024 10:39:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yshyn.com header.i=@yshyn.com header.b="tkRxsuVy"
X-Original-To: cgroups@vger.kernel.org
Received: from phoenix.uberspace.de (phoenix.uberspace.de [95.143.172.135])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BB1014D6F6
	for <cgroups@vger.kernel.org>; Tue,  7 May 2024 10:39:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.143.172.135
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715078397; cv=none; b=Qq67mq2YJ6K77L27cmkbZsiD800b5rTU4ExJj7aZfrWmRkzRXbevGyOpWjnoGPGDWjFsQES6eOQcpcOR8q6tSS43xAeWyWykJQ8bheU1Rt2lQpddxxHrVqH/eFPlCqyqMnEQXXABzo3nsjxNqmwfzLDUQCZ42oB1DTg3NbV5QpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715078397; c=relaxed/simple;
	bh=QNnIOUmGw+/4sKtvKLRny0R9Qjd8tUiqHl1cHAokzNs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=G4WvQ/Ur9y56yOAj0pblb29hYV/CvcOG99nkdsuF5G/I0FCmSmY0no3gix5rVHDbuhkrlRttxnBxdqTvWpzT6jTc8x2r92wKmlNyEZ0sg/tRrRGMoQQrfSZ6TMnsQ4aSSwFbr3Rf7hAtBsO80Wa4Xv91j5evkFXrzxhAmS6QrVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=yshyn.com; spf=pass smtp.mailfrom=yshyn.com; dkim=pass (2048-bit key) header.d=yshyn.com header.i=@yshyn.com header.b=tkRxsuVy; arc=none smtp.client-ip=95.143.172.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=yshyn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yshyn.com
Received: (qmail 8221 invoked by uid 988); 7 May 2024 10:39:53 -0000
Authentication-Results: phoenix.uberspace.de;
	auth=pass (plain)
Received: from unknown (HELO unkown) (::1)
	by phoenix.uberspace.de (Haraka/3.0.1) with ESMTPSA; Tue, 07 May 2024 12:39:53 +0200
From: Illia Ostapyshyn <illia@yshyn.com>
To: Tejun Heo <tj@kernel.org>,
	Zefan Li <lizefan.x@bytedance.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc: cgroups@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org,
	Illia Ostapyshyn <illia@yshyn.com>
Subject: [PATCH v2] docs: cgroup-v1: Update page cache removal functions
Date: Tue,  7 May 2024 12:34:27 +0200
Message-Id: <20240507103426.544488-1-illia@yshyn.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Bar: ++
X-Rspamd-Report: SUSPICIOUS_RECIPS(1.5) BAYES_HAM(-0.000492) MID_CONTAINS_FROM(1) MIME_GOOD(-0.1) R_MISSING_CHARSET(0.5)
X-Rspamd-Score: 2.899507
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=yshyn.com; s=uberspace;
	h=from:to:cc:subject:date;
	bh=QNnIOUmGw+/4sKtvKLRny0R9Qjd8tUiqHl1cHAokzNs=;
	b=tkRxsuVy35OnSL57/lXDwilDdQpvmsMNSOyBf4sDPYWRdUOP6xXPBo/5SA8Ny1M5jmFBhhBAg5
	wLEBo8hUTQJGaWTcNRf++3hvEoOJ/RIqCmv9zZMgoXp9Bg0HaoAoLf/J7L7ESXaFcomgnyelqTcS
	BAU/mmwBImm9lWTJpoXJi6Mrj1Cqnxv5kAj2F8uKa0+uG/+7EszpFwD5329lPvH5F3B/HBVP+r3u
	HjHT4SN8q/K+vK3icC6YecyYXCwSvU9NsBid1UkJyuo97FdtoScD2TR6aTh9LO6LqUsWbh0dERm4
	x4fcKnCGuyvj9V5efTvNuJZXJzkgBwY/5k6vM7tg==

Commit 452e9e6992fe ("filemap: Add filemap_remove_folio and
__filemap_remove_folio") reimplemented __delete_from_page_cache() as
__filemap_remove_folio() and delete_from_page_cache() as
filemap_remove_folio().  The compatibility wrappers were finally removed
in ece62684dcfb ("hugetlbfs: convert hugetlb_delete_from_page_cache() to
use folios") and 6ffcd825e7d0 ("mm: Remove __delete_from_page_cache()").

Update the remaining references to dead functions in the memcg
implementation memo.

Signed-off-by: Illia Ostapyshyn <illia@yshyn.com>
---

Changes in v2:
 * filemap_free_folio() was meant to be filemap_remove_folio(). Sorry.

 Documentation/admin-guide/cgroup-v1/memcg_test.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/admin-guide/cgroup-v1/memcg_test.rst b/Documentation/admin-guide/cgroup-v1/memcg_test.rst
index 1f128458ddea..9f8e27355cba 100644
--- a/Documentation/admin-guide/cgroup-v1/memcg_test.rst
+++ b/Documentation/admin-guide/cgroup-v1/memcg_test.rst
@@ -102,7 +102,7 @@ Under below explanation, we assume CONFIG_SWAP=y.
 	The logic is very clear. (About migration, see below)
 
 	Note:
-	  __remove_from_page_cache() is called by remove_from_page_cache()
+	  __filemap_remove_folio() is called by filemap_remove_folio()
 	  and __remove_mapping().
 
 6. Shmem(tmpfs) Page Cache
-- 
2.39.2


