Return-Path: <cgroups+bounces-6101-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C1D0A0B2B9
	for <lists+cgroups@lfdr.de>; Mon, 13 Jan 2025 10:26:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 218B53A56E8
	for <lists+cgroups@lfdr.de>; Mon, 13 Jan 2025 09:26:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F0812397AC;
	Mon, 13 Jan 2025 09:26:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OzqWbx6h"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCA6E2397AB;
	Mon, 13 Jan 2025 09:26:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736760378; cv=none; b=AFV+LEMYgtpFe5xvtocWgb8ntKmD0INL0mKI/Ic6pPO4l5Z7B4xgb4McPy8Uh66wp0HfBEQnT9uudGCsn9DWE4Io9DFuelfe36JCqwragv33vX7nShKBEAsVzLKG8aIZVA+c5KsXYCITEkrtFwgBlGJPIL2fYeMd3VNvJQ9w9v8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736760378; c=relaxed/simple;
	bh=lTKRTo6DTefkGzg59vzB2bAaoBDnmY8yk4vJ1qA9K1o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XOfq8TqWQwZibnBY2aLlhizVWVHrWoZcMd7S04s7YGZHe8I7FORbbOkkPdbYpblaYEq53UwNqVPQwGV0GgBCAdVoHQ4S3ucbqzb3acCBWSSMpsQhKN0ITz42erJWoz27t4VtJtyboJkfZwRtHv9g3HNIv/+oyt8ot5pLYIcQ4Ew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OzqWbx6h; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F64EC4CED6;
	Mon, 13 Jan 2025 09:26:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736760378;
	bh=lTKRTo6DTefkGzg59vzB2bAaoBDnmY8yk4vJ1qA9K1o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OzqWbx6hiBNHJ8tdDEY+OFJmaepO0rzL1ge9TJDXqJFtjZ8YP8OeUSx8s4vhGzkz1
	 m5vesovN2/YGcZKQsZk8IDJA+mrcaS1hsKvPaJG8C+TUUkUfoDkX4WRZvdvjqptzX7
	 v2+1wTJavbj4xzFyFVgychzvQdWjNWcULle4/kyQybGtSxZJqQotuOXr7JiLrmq8V8
	 T8XSyechRGTzby2gDsniqJxoA84UWR2TYMznUzAisOJ5QTPkwBrVy6IuHNpXt9QUcr
	 G/pkJvrcQjD8gn4q3aNZ4vEeFt+jPJ/XOYk6eOJ7KnPRq39vIr3A4v1jqHxBljBTU/
	 2u/lGv3bzfhQA==
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
Subject: [PATCH 2/4] cgroup/dmem: Fix parameters documentation
Date: Mon, 13 Jan 2025 10:26:06 +0100
Message-ID: <20250113092608.1349287-2-mripard@kernel.org>
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

During the dmem cgroup development, the parameters to the
dmem_cgroup_state_evict_valuable() and dmem_cgroup_try_charge() were
changed, but the documentation wasn't adjusted accordingly.

This results in a documentation build warning. Adjust the documentation
to reflect what the final functions parameters are.

Fixes: b168ed458dde ("kernel/cgroup: Add "dmem" memory accounting cgroup")
Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Closes: https://lore.kernel.org/r/20250113160334.1f09f881@canb.auug.org.au/
Signed-off-by: Maxime Ripard <mripard@kernel.org>
---
 kernel/cgroup/dmem.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/kernel/cgroup/dmem.c b/kernel/cgroup/dmem.c
index 52736ef0ccf2..ecea58abed6a 100644
--- a/kernel/cgroup/dmem.c
+++ b/kernel/cgroup/dmem.c
@@ -278,12 +278,10 @@ dmem_cgroup_calculate_protection(struct dmem_cgroup_pool_state *limit_pool,
 	rcu_read_unlock();
 }
 
 /**
  * dmem_cgroup_state_evict_valuable() - Check if we should evict from test_pool
- * @dev: &dmem_cgroup_region
- * @index: The index number of the region being tested.
  * @limit_pool: The pool for which we hit limits
  * @test_pool: The pool for which to test
  * @ignore_low: Whether we have to respect low watermarks.
  * @ret_hit_low: Pointer to whether it makes sense to consider low watermark.
  *
@@ -609,17 +607,16 @@ void dmem_cgroup_uncharge(struct dmem_cgroup_pool_state *pool, u64 size)
 }
 EXPORT_SYMBOL_GPL(dmem_cgroup_uncharge);
 
 /**
  * dmem_cgroup_try_charge() - Try charging a new allocation to a region.
- * @dev: Device to charge
+ * @region: dmem region to charge
  * @size: Size (in bytes) to charge.
  * @ret_pool: On succesfull allocation, the pool that is charged.
  * @ret_limit_pool: On a failed allocation, the limiting pool.
  *
- * This function charges the current pool for @dev with region at @index for a
- * size of @size bytes.
+ * This function charges the @region region for a size of @size bytes.
  *
  * If the function succeeds, @ret_pool is set, which must be passed to
  * dmem_cgroup_uncharge() when undoing the allocation.
  *
  * When this function fails with -EAGAIN and @ret_limit_pool is non-null, it
-- 
2.47.1


