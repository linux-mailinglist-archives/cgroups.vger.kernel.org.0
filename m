Return-Path: <cgroups+bounces-6102-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CD3F6A0B2BB
	for <lists+cgroups@lfdr.de>; Mon, 13 Jan 2025 10:26:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EA2553A44C8
	for <lists+cgroups@lfdr.de>; Mon, 13 Jan 2025 09:26:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA98F23A56F;
	Mon, 13 Jan 2025 09:26:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WEWtRteg"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95CF52397A6;
	Mon, 13 Jan 2025 09:26:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736760382; cv=none; b=qgrHmGqBgb+tZdsE7bOw6HF0PsSEXEkCdKKw7vUvcGiZu/07xiqdKI2Gr2RQJuWZFwR7/H4RSe1auadFKOelfGseKqZGbDepqN587z9/PhesRMYCdKW+wCjA26nTtOsJQvcYMF18PATd7VzMi142n75y4BK8vAI+Hqim2xcBudI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736760382; c=relaxed/simple;
	bh=9JhhK71wwiHcLFBErXxQpCIOlUAopR3tZpNzTbm0CgI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=r3Kzt3TemWCa2aTCj2ld+r4ptKVZsN2b+jl7EJqTXVB3e/STmAyYWvFU+qKcupGYFq/P8fT9YLN9ZkOHTEG9NqMvAVGwoUzIbxLCE2wo5TmF1xT5p7MxwvMopzbAYqMU0208SRk3lYgU+TqxsppqXH6WVKBTVOj2IKOOwtmtcvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WEWtRteg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C966CC4CEE1;
	Mon, 13 Jan 2025 09:26:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736760381;
	bh=9JhhK71wwiHcLFBErXxQpCIOlUAopR3tZpNzTbm0CgI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WEWtRtegaUWM4Xp4VwBmtOAhOwqapTTSL8DrQFPJT5gF3PMVH7ff8IvlehsNVCIEi
	 yquX+v6hHsHR66q73O89TkGVkTa0v201fle/NyWpgRi+csPsbGOzVqKU/MgbP4Kv0Y
	 M5ixAwqjQlU4bgsxezOsiTfH7+ug0teLU7ZjgtQ9CrQg8Mf5ASaqESFsU48N5J1VYG
	 3xoj/UcquPfV9L9OiaZu7vkJ6kAbc6YGFsfIezpvCVRjIakLyn0TUWNMpl89ZJVX4b
	 ydfy9lgARJ+SpT0PDBXJJVvQH/oVa6deSJl199BnorJLlMXKQbE7frHp9HbrN7Uong
	 YmNDQvtfmmTww==
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
	Stephen Rothwell <sfr@canb.auug.org.au>
Subject: [PATCH 3/4] drm/doc: Include new drm-compute documentation
Date: Mon, 13 Jan 2025 10:26:07 +0100
Message-ID: <20250113092608.1349287-3-mripard@kernel.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250113092608.1349287-1-mripard@kernel.org>
References: <20250113092608.1349287-1-mripard@kernel.org>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit b168ed458dde ("kernel/cgroup: Add "dmem" memory accounting
cgroup") introduced a new documentation file, but didn't link it
anywhere. It was thus triggering a documentation build warning. Make
sure it's included as part of the DRM documentation.

Fixes: b168ed458dde ("kernel/cgroup: Add "dmem" memory accounting cgroup")
Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Closes: https://lore.kernel.org/r/20250113155000.4a99e7b0@canb.auug.org.au/
Signed-off-by: Maxime Ripard <mripard@kernel.org>
---
 Documentation/gpu/index.rst | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/gpu/index.rst b/Documentation/gpu/index.rst
index 37e383ccf73f..7dcb15850afd 100644
--- a/Documentation/gpu/index.rst
+++ b/Documentation/gpu/index.rst
@@ -11,10 +11,11 @@ GPU Driver Developer's Guide
    drm-kms-helpers
    drm-uapi
    drm-usage-stats
    driver-uapi
    drm-client
+   drm-compute
    drivers
    backlight
    vga-switcheroo
    vgaarbiter
    automated_testing
-- 
2.47.1


