Return-Path: <cgroups+bounces-6100-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FC8AA0B2B6
	for <lists+cgroups@lfdr.de>; Mon, 13 Jan 2025 10:26:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 774861674D2
	for <lists+cgroups@lfdr.de>; Mon, 13 Jan 2025 09:26:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58D1623A566;
	Mon, 13 Jan 2025 09:26:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CaVPrLz+"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10BB52397B9;
	Mon, 13 Jan 2025 09:26:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736760376; cv=none; b=NOM5qqTyDc2slkqFTVXtC1BDxa0MkclQYZU4brDSEjkKHAmRLhBaTZjRtSS5RwfrnOQDpR13W58fkLRV0/WUoWSOM3c0SBt7BHAyg4n1UyeUHK6mvgKtKip+tB0HOp3hbcgejQAQHK5fOmnCT9zKSX0kFfycwDc6YovjnwHZDdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736760376; c=relaxed/simple;
	bh=zN8vr8gKCDgzIHKOCZHlsEiuMBVTM1Ku6GESR0iPOnU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Fia6ylGYD5/VgTqDNA+4Zssfy97VrUSPnxQGv7qdU0T0guMm/vk+GGAlg9XPs35yI3hKg3LlWEQ2xzAdTKGij9m3u2KdABbPFDUPt4g8oSpNITlt9FZvjsPp2ykkSBmrh3ldAfGdH0xLaezbsj5re2sr5UfbNQcWpRe1DlTC/x0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CaVPrLz+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53031C4CED6;
	Mon, 13 Jan 2025 09:26:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736760375;
	bh=zN8vr8gKCDgzIHKOCZHlsEiuMBVTM1Ku6GESR0iPOnU=;
	h=From:To:Cc:Subject:Date:From;
	b=CaVPrLz+r6HPfO9HFyVrJB4hKSMDjcmtu3+dgPLBrIl7QtqmXaawN8rPur9fcKrpd
	 c5NsN4iZzowCkMfV5l2E0EjktHGL7M6Pgl6F2s47OtWP9oV/O4wWGVKNiSZNLOdGXr
	 bhfIlKWuNK4Zmnp85Srcc+3YCoengoEQigiqR7o27ztz7yAwONzI44WDTSSZ1WN6T+
	 OJkxoeIuD/Z7jDRo1VuZ/hOveqLSyaUpKkIUTwcihFggaZDMtjhaGKsSYiPJMkqcEi
	 AV3rQ73oW5fukQIxQuu2gvi+DS+NDHVsHeW658LdaxKG650rjMaLODsop/QjyNyN/V
	 pd3vA92HFeXxw==
From: Maxime Ripard <mripard@kernel.org>
To: Jonathan Corbet <corbet@lwn.net>,
	Tejun Heo <tj@kernel.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	=?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>,
	Simona Vetter <simona.vetter@ffwll.ch>,
	David Airlie <airlied@gmail.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Maxime Ripard <mripard@kernel.org>,
	dri-devel@lists.freedesktop.org,
	linux-doc@vger.kernel.org,
	cgroups@vger.kernel.org,
	kernel test robot <lkp@intel.com>
Subject: [PATCH 1/4] cgroup/dmem: Select PAGE_COUNTER
Date: Mon, 13 Jan 2025 10:26:05 +0100
Message-ID: <20250113092608.1349287-1-mripard@kernel.org>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The dmem cgroup the page counting API implemented behing the
PAGE_COUNTER kconfig option. However, it doesn't select it, resulting in
potential build breakages. Select PAGE_COUNTER.

Fixes: b168ed458dde ("kernel/cgroup: Add "dmem" memory accounting cgroup")
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202501111330.3VuUx8vf-lkp@intel.com/
Signed-off-by: Maxime Ripard <mripard@kernel.org>
---
 init/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/init/Kconfig b/init/Kconfig
index 61f50cafa815..5e5328506138 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -1137,10 +1137,11 @@ config CGROUP_RDMA
 	  Attaching processes with active RDMA resources to the cgroup
 	  hierarchy is allowed even if can cross the hierarchy's limit.
 
 config CGROUP_DMEM
 	bool "Device memory controller (DMEM)"
+	select PAGE_COUNTER
 	help
 	  The DMEM controller allows compatible devices to restrict device
 	  memory usage based on the cgroup hierarchy.
 
 	  As an example, it allows you to restrict VRAM usage for applications
-- 
2.47.1


