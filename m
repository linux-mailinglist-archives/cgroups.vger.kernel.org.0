Return-Path: <cgroups+bounces-6103-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EA14BA0B2BC
	for <lists+cgroups@lfdr.de>; Mon, 13 Jan 2025 10:26:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0E2C91669B1
	for <lists+cgroups@lfdr.de>; Mon, 13 Jan 2025 09:26:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 916E423A571;
	Mon, 13 Jan 2025 09:26:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b3Mir3fs"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CE6D233159;
	Mon, 13 Jan 2025 09:26:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736760384; cv=none; b=G52QrWS492v0u4y83nRPYnpb4le96VaEpwy9NuiKTxogF5xxGcZPrqgkbtUolYqxrf8YiYjLpci5lOOYtCqIR0+u1ffGO18h1yjp2Kk4IWSPTZ8akerzE75DIz4qRVxB5VnzxrQ/6X1vtoXSFz3StgrGoG+tidyCPHePXX/i1do=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736760384; c=relaxed/simple;
	bh=rKYRxwVH9G5tQwnPWN7e8BfY/H/rOa2mgN6RvB1yR3Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OS4fgSl0D+5dWv8Ck0UDzEFuXvZGVoyhzknmEBlCykXn1oRCChK81K7ejhOXtKUVXOfSx5zBu2p8osDn3d++XO8gA2Xsp4TQ7Oz2p/d6xGQRtbUA4eiE+XHMt7jjWhd6DUbCQ5CiCRkc4MPMcoI42JzQEWRhOCw+1flD8pO61zI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b3Mir3fs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8FDEAC4CEE1;
	Mon, 13 Jan 2025 09:26:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736760383;
	bh=rKYRxwVH9G5tQwnPWN7e8BfY/H/rOa2mgN6RvB1yR3Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=b3Mir3fsZqeqgviEiyMCwErgpkWgzeXc0Qiw+jwgoU5IukW5Q7AzAXU+D+kY1L2Z9
	 yTUcTDxk/+2l4guY0iBl7F8cjC3m0FTEvxAoPvcDTKwzSrK53fcgKoxVSw9SeD/c3r
	 v+JDFBMr6jb4dXvxJSArgCyBa+VUUo3KNqADV/n8L3uEA0rlLMdrj8cPRG3Aen7z6i
	 oHammgNfgMfhWE03QUae0HpB9UpuCkVs+h41ifzOevQlsuRVOLnNWgGG3JUPfOjckx
	 FYKpxgBdRf5Wdjr1YOybIiSnzEkM2cxoRcf8UEo7v4UO0cBvRCR7mO4ELrqY7gWgVG
	 idu+OhOXGRxnw==
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
Subject: [PATCH 4/4] doc/cgroup: Fix title underline length
Date: Mon, 13 Jan 2025 10:26:08 +0100
Message-ID: <20250113092608.1349287-4-mripard@kernel.org>
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

Commit

Commit b168ed458dde ("kernel/cgroup: Add "dmem" memory accounting
cgroup") introduced a new documentation file, with a shorter than
expected underline. This results in a documentation build warning. Fix
that underline length.

Fixes: b168ed458dde ("kernel/cgroup: Add "dmem" memory accounting cgroup")
Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Closes: https://lore.kernel.org/r/20250113154611.624256bf@canb.auug.org.au/
Signed-off-by: Maxime Ripard <mripard@kernel.org>
---
 Documentation/core-api/cgroup.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/core-api/cgroup.rst b/Documentation/core-api/cgroup.rst
index 8696e9513f51..734ea21e1e17 100644
--- a/Documentation/core-api/cgroup.rst
+++ b/Documentation/core-api/cgroup.rst
@@ -1,9 +1,9 @@
 ==================
 Cgroup Kernel APIs
 ==================
 
 Device Memory Cgroup API (dmemcg)
-=========================
+=================================
 .. kernel-doc:: kernel/cgroup/dmem.c
    :export:
 
-- 
2.47.1


