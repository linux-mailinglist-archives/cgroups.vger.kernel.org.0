Return-Path: <cgroups+bounces-6346-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AE98CA201F4
	for <lists+cgroups@lfdr.de>; Tue, 28 Jan 2025 00:52:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ECAAB188637D
	for <lists+cgroups@lfdr.de>; Mon, 27 Jan 2025 23:52:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B31E1DFD8B;
	Mon, 27 Jan 2025 23:52:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b="MaXFLBhT"
X-Original-To: cgroups@vger.kernel.org
Received: from mx.treblig.org (mx.treblig.org [46.235.229.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2D531DF72D;
	Mon, 27 Jan 2025 23:52:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.229.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738021940; cv=none; b=VuBNy+bwLud7o3BcN0Zi/rnwuJZm02NqOtxsLNFf5CoyVD2TbK130fiqqzWdHS6dWxLfQtciT6XAZFr25I4aDUHDGvwe1Cr73F6uJX+ufbq4iskSaJtx3K5IzUZ6U7r4jmit8tEsxnpBSLgpeKN0s5W2Jvum2qGafRIY/QNd0qQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738021940; c=relaxed/simple;
	bh=58R6BdkbNY1jmSjq/TWUUuT4ZrrH4uniFDe6RiJrGrY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QWaoDU0EYBvdYFKbY2RKoYRS44TT7DGbIfCXWoLAS46xlaE561l2jI5ZOr4uS5SPhSS+7aLTbrPd36WQs9AdSNrPeH6evZn5tUI57Ry3wBT0lvvYo1R1YQ/We8EqBBYNIDvBAOTmeSbVbszKIa32vWkgHj5YwCD06rl7ya1a2o0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org; spf=pass smtp.mailfrom=treblig.org; dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b=MaXFLBhT; arc=none smtp.client-ip=46.235.229.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=treblig.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
	; s=bytemarkmx; h=MIME-Version:Message-ID:Date:Subject:From:Content-Type:From
	:Subject; bh=dZIbMpFLplxfZ+jHrHCeJ6XWVzUEJyQxqI0HpMXdXZk=; b=MaXFLBhTMRF85v40
	uMEmbczrRFoRY9Ht01fxRy5kGbzExfCQpgov9Ay8aGInM5eqjuozQksZNz9sv4tLLt92kIS8jtkgK
	w1/RHKRiQx4iFe0Jy3oE76NdfMm3v3TgLStEvrH9L58I+Nom2DAr6JQupAJ6GTE8f98nGo+0uStDN
	5gJVKlZ6ux7YpEDzPorMI/phquy/8XsOwDwkdF+Z18r3RqSvJ1JUHh26kYxk8HuPzqffFw8GaWXy5
	UuFg1vVhzzMZGoV8QT1XSWrFqPOH5VgwjrCkOX7v1NKf0DcwEFqCgZbij9rGCxrKXLIW06bey0q12
	r5QmoJVq5CI8qDdnIQ==;
Received: from localhost ([127.0.0.1] helo=dalek.home.treblig.org)
	by mx.treblig.org with esmtp (Exim 4.96)
	(envelope-from <linux@treblig.org>)
	id 1tcYtq-00CO8t-2S;
	Mon, 27 Jan 2025 23:52:14 +0000
From: linux@treblig.org
To: tj@kernel.org,
	hannes@cmpxchg.org,
	mkoutny@suse.com
Cc: cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Dr. David Alan Gilbert" <linux@treblig.org>
Subject: [PATCH] cgroup/misc: Remove unused misc_cg_res_total_usage
Date: Mon, 27 Jan 2025 23:52:14 +0000
Message-ID: <20250127235214.277512-1-linux@treblig.org>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Dr. David Alan Gilbert" <linux@treblig.org>

misc_cg_res_total_usage() was added in 2021 by
commit a72232eabdfc ("cgroup: Add misc cgroup controller")

but has remained unused.

Remove it.

Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>
---
 include/linux/misc_cgroup.h |  6 ------
 kernel/cgroup/misc.c        | 16 ----------------
 2 files changed, 22 deletions(-)

diff --git a/include/linux/misc_cgroup.h b/include/linux/misc_cgroup.h
index 49eef10c8e59..4bf261d41a6d 100644
--- a/include/linux/misc_cgroup.h
+++ b/include/linux/misc_cgroup.h
@@ -60,7 +60,6 @@ struct misc_cg {
 	struct misc_res res[MISC_CG_RES_TYPES];
 };
 
-u64 misc_cg_res_total_usage(enum misc_res_type type);
 int misc_cg_set_capacity(enum misc_res_type type, u64 capacity);
 int misc_cg_try_charge(enum misc_res_type type, struct misc_cg *cg, u64 amount);
 void misc_cg_uncharge(enum misc_res_type type, struct misc_cg *cg, u64 amount);
@@ -104,11 +103,6 @@ static inline void put_misc_cg(struct misc_cg *cg)
 
 #else /* !CONFIG_CGROUP_MISC */
 
-static inline u64 misc_cg_res_total_usage(enum misc_res_type type)
-{
-	return 0;
-}
-
 static inline int misc_cg_set_capacity(enum misc_res_type type, u64 capacity)
 {
 	return 0;
diff --git a/kernel/cgroup/misc.c b/kernel/cgroup/misc.c
index 0e26068995a6..2fa3a4fb2aaf 100644
--- a/kernel/cgroup/misc.c
+++ b/kernel/cgroup/misc.c
@@ -67,22 +67,6 @@ static inline bool valid_type(enum misc_res_type type)
 	return type >= 0 && type < MISC_CG_RES_TYPES;
 }
 
-/**
- * misc_cg_res_total_usage() - Get the current total usage of the resource.
- * @type: misc res type.
- *
- * Context: Any context.
- * Return: Current total usage of the resource.
- */
-u64 misc_cg_res_total_usage(enum misc_res_type type)
-{
-	if (valid_type(type))
-		return atomic64_read(&root_cg.res[type].usage);
-
-	return 0;
-}
-EXPORT_SYMBOL_GPL(misc_cg_res_total_usage);
-
 /**
  * misc_cg_set_capacity() - Set the capacity of the misc cgroup res.
  * @type: Type of the misc res.
-- 
2.48.1


