Return-Path: <cgroups+bounces-6613-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F325A3DC2E
	for <lists+cgroups@lfdr.de>; Thu, 20 Feb 2025 15:11:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C036616B78D
	for <lists+cgroups@lfdr.de>; Thu, 20 Feb 2025 14:08:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77DCC1C3308;
	Thu, 20 Feb 2025 14:08:27 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from mblankhorst.nl (lankhorst.se [141.105.120.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 004441BBBF7
	for <cgroups@vger.kernel.org>; Thu, 20 Feb 2025 14:08:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.105.120.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740060507; cv=none; b=bQVHkEzShlA+4CTUGE3sCK/VKhKcsFyHUE3DFXRdF/86kCPhuIFe6Zm9Fl11GoG9p4oEbbI7mlZvdyH/M7prIr173+aDh15WGfC7OhJ/NSClhLSVr00t0U/VhQ1ulfYlyd+am5BF9poJONnydz2aJfbC25SLt7o1eXi1uJVdyjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740060507; c=relaxed/simple;
	bh=oDpCAkI0VTc4pXLxwslNxCtB+xUvhkBCp0cS3I97qlo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LM/+QkGDvqqzV73o6/4RuWpZM/UG7dasgdFTYJw0KOUxz4wTwyajkJmZiz1Wfey73y9bYPRguo/zmBxsONxabPVawDJjXohptJNPf4jBiVt82mI74YG6KnxewQOFEtSb94SJnHdpX9p2W5OT6+CY3CQVnqLIX8KVFVsTCeLkgdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lankhorst.se; spf=none smtp.mailfrom=mblankhorst.nl; arc=none smtp.client-ip=141.105.120.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lankhorst.se
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mblankhorst.nl
From: Maarten Lankhorst <dev@lankhorst.se>
To: dri-devel@lists.freedesktop.org,
	cgroups@vger.kernel.org
Cc: Tejun Heo <tj@kernel.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	=?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>,
	Simona Vetter <simona.vetter@ffwll.ch>,
	David Airlie <airlied@gmail.com>,
	Maarten Lankhorst <dev@lankhorst.se>,
	Maxime Ripard <mripard@kernel.org>,
	Natalie Vock <natalie.vock@gmx.de>
Subject: [PATCH] MAINTAINERS: Add entry for DMEM cgroup controller
Date: Thu, 20 Feb 2025 15:07:57 +0100
Message-ID: <20250220140757.16823-1-dev@lankhorst.se>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The cgroups controller is currently maintained through the
drm-misc tree, so lets add add Maxime Ripard, Natalie Vock
and me as specific maintainers for dmem.

We keep the cgroup mailing list CC'd on all cgroup specific patches.

Signed-off-by: Maarten Lankhorst <dev@lankhorst.se>
Acked-by: Maxime Ripard <mripard@kernel.org>
Acked-by: Natalie Vock <natalie.vock@gmx.de>
---
 .mailmap    |  1 +
 MAINTAINERS | 11 +++++++++++
 2 files changed, 12 insertions(+)

diff --git a/.mailmap b/.mailmap
index fedebf86640ad..52718c77aa479 100644
--- a/.mailmap
+++ b/.mailmap
@@ -519,6 +519,7 @@ Nadav Amit <nadav.amit@gmail.com> <namit@cs.technion.ac.il>
 Nadia Yvette Chambers <nyc@holomorphy.com> William Lee Irwin III <wli@holomorphy.com>
 Naoya Horiguchi <nao.horiguchi@gmail.com> <n-horiguchi@ah.jp.nec.com>
 Naoya Horiguchi <nao.horiguchi@gmail.com> <naoya.horiguchi@nec.com>
+Natalie Vock <natalie.vock@gmx.de> <friedrich.vock@gmx.de>
 Nathan Chancellor <nathan@kernel.org> <natechancellor@gmail.com>
 Naveen N Rao <naveen@kernel.org> <naveen.n.rao@linux.ibm.com>
 Naveen N Rao <naveen@kernel.org> <naveen.n.rao@linux.vnet.ibm.com>
diff --git a/MAINTAINERS b/MAINTAINERS
index 4684e38368db2..5d57278904534 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -5926,6 +5926,17 @@ F:	tools/testing/selftests/cgroup/test_cpuset.c
 F:	tools/testing/selftests/cgroup/test_cpuset_prs.sh
 F:	tools/testing/selftests/cgroup/test_cpuset_v1_base.sh
 
+CONTROL GROUP - DEVICE MEMORY CONTROLLER (DMEM)
+M:	Maarten Lankhorst <dev@lankhorst.se>
+M:	Maxime Ripard <mripard@kernel.org>
+M:	Natalie Vock <natalie.vock@gmx.de>
+S:	Maintained
+L:	cgroups@vger.kernel.org
+L:	dri-devel@lists.freedesktop.org
+T:	git https://gitlab.freedesktop.org/drm/misc/kernel.git
+F:	include/linux/cgroup_dmem.h
+F:	kernel/cgroup/dmem.c
+
 CONTROL GROUP - MEMORY RESOURCE CONTROLLER (MEMCG)
 M:	Johannes Weiner <hannes@cmpxchg.org>
 M:	Michal Hocko <mhocko@kernel.org>
-- 
2.45.2


