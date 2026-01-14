Return-Path: <cgroups+bounces-13227-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D0A6D21BFD
	for <lists+cgroups@lfdr.de>; Thu, 15 Jan 2026 00:23:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9E7B4302C8F6
	for <lists+cgroups@lfdr.de>; Wed, 14 Jan 2026 23:23:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DF8338BF66;
	Wed, 14 Jan 2026 23:23:00 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from omta40.uswest2.a.cloudfilter.net (omta40.uswest2.a.cloudfilter.net [35.89.44.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AE9537F0F5
	for <cgroups@vger.kernel.org>; Wed, 14 Jan 2026 23:22:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.89.44.39
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768432977; cv=none; b=Z3umqd4RObDYmTHi4hhSqSD8+2rEQNrBVt4cnbCFDFuUjMWUavtTowGUzCfCE2wrnbBz4E0mmEOoxOiq611w5gd82GPLU83FDSOzWuyHZYTPbOsMr3bYdPzceMahuiEa47ZEDjzc4NUkYhSCm6NTTpG4cXO68UJ0mPnSo596LNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768432977; c=relaxed/simple;
	bh=u898Lcp1FuXk3wlOY/VvFyiXKVlKxrnp6D7HFuBfvPE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=vD8b5WQrZll4UQvS5jZKf2CrNM8XPcryqz6vKlJ9U2XLG06ozIwUKuCuk1hIb+ebhennc2mqI2qVqEAA0GP8XR48LSUyqbaCCGAT6UQHiowCMjJpQR6Y3w93HrmUgwBHrA2npwLv6+0srsHyditExGrFzjk5r5CxjPjCwsX+fGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=sony.com; spf=fail smtp.mailfrom=sony.com; arc=none smtp.client-ip=35.89.44.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=sony.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=sony.com
Received: from eig-obgw-6006b.ext.cloudfilter.net ([10.0.30.211])
	by cmsmtp with ESMTPS
	id g7PfvVYHDaPqLgACEvnKH1; Wed, 14 Jan 2026 23:22:38 +0000
Received: from host2044.hostmonster.com ([67.20.76.238])
	by cmsmtp with ESMTPS
	id gACDvnT5rvXvHgACDvp9zE; Wed, 14 Jan 2026 23:22:37 +0000
X-Authority-Analysis: v=2.4 cv=e4IGSbp/ c=1 sm=1 tr=0 ts=6968253d
 a=O1AQXT3IpLm5MaED65xONQ==:117 a=uc9KWs4yn0V/JYYSH7YHpg==:17
 a=vUbySO9Y5rIA:10 a=z6gsHLkEAAAA:8 a=VnNF1IyMAAAA:8 a=oTZ0yMsC93kIkOJjF8UA:9
 a=iekntanDnrheIxGr1pkv:22
Received: from [66.118.46.62] (port=42648 helo=timdesk..)
	by host2044.hostmonster.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.99.1)
	(envelope-from <tim.bird@sony.com>)
	id 1vgACA-00000001DR0-3yAe;
	Wed, 14 Jan 2026 16:22:35 -0700
From: Tim Bird <tim.bird@sony.com>
To: clg@redhat.com,
	mhelsley@vmware.com,
	longman@redhat.com,
	tj@kernel.org,
	hannes@cmpxchg.org,
	mkoutny@suse.com
Cc: linux-spdx@vger.kernel.org,
	cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Tim Bird <tim.bird@sony.com>
Subject: [PATCH] kernel: cgroup: Add LGPL-2.1 SPDX license ID to legacy_freezer.c
Date: Wed, 14 Jan 2026 16:22:08 -0700
Message-ID: <20260114232208.592606-1-tim.bird@sony.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - host2044.hostmonster.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - sony.com
X-BWhitelist: no
X-Source-IP: 66.118.46.62
X-Source-L: No
X-Exim-ID: 1vgACA-00000001DR0-3yAe
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (timdesk..) [66.118.46.62]:42648
X-Source-Auth: tim@bird.org
X-Email-Count: 3
X-Org: HG=bhshared_hm;ORG=bluehost;
X-Source-Cap: YmlyZG9yZztiaXJkb3JnO2hvc3QyMDQ0Lmhvc3Rtb25zdGVyLmNvbQ==
X-Local-Domain: no
X-CMAE-Envelope: MS4xfF46gaakwrOso4dkBOCdO/p6MEOyk2CFC5Bn6w2gHrlxepqEwWJ+V53kO3db1w/3ZmChiIBAcCg+hRcM9kQ8XJK4z/zKqMqazP11Pwp69H3WusWnh6j2
 hkDJmLXz1eE9qrXOGykE34XXEy14pYKiBJBjJkltrLfZhLLx5QZKPNko03yXQ1BIV4O8EcwV/iWuUlALWznGX0TN7GZOnRRYIkY=

Add an appropriate SPDX-License-Identifier line to the file,
and remove the GNU boilerplate text.

Signed-off-by: Tim Bird <tim.bird@sony.com>
---
 kernel/cgroup/legacy_freezer.c | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/kernel/cgroup/legacy_freezer.c b/kernel/cgroup/legacy_freezer.c
index 915b02f65980..817c33450fee 100644
--- a/kernel/cgroup/legacy_freezer.c
+++ b/kernel/cgroup/legacy_freezer.c
@@ -1,17 +1,10 @@
+// SPDX-License-Identifier: LGPL-2.1
 /*
  * cgroup_freezer.c -  control group freezer subsystem
  *
  * Copyright IBM Corporation, 2007
  *
  * Author : Cedric Le Goater <clg@fr.ibm.com>
- *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms of version 2.1 of the GNU Lesser General Public License
- * as published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it would be useful, but
- * WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
  */
 
 #include <linux/export.h>
-- 
2.43.0


