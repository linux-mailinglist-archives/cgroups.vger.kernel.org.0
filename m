Return-Path: <cgroups+bounces-10541-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id D171CBB81D8
	for <lists+cgroups@lfdr.de>; Fri, 03 Oct 2025 22:39:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 5506E347E41
	for <lists+cgroups@lfdr.de>; Fri,  3 Oct 2025 20:39:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2ADE2475D0;
	Fri,  3 Oct 2025 20:38:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S4L3F+p0"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 598DE2459C6;
	Fri,  3 Oct 2025 20:38:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759523936; cv=none; b=dFPEqdPnSyg3t4EwBR0buX3hb3x5qQAmaoQwB2U9/WJHuunlJ7yPyH42UCFPnxkUwmE0/6GWzDtmGqdvZFhHq4K7Zq9gJuKBqFVZ6UPZeCD7RGTfPr54SZc/dY9/dSRjyDykAp38/FhpuLrXuOdEWZMnAiLs9qdNYW5orxhVOfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759523936; c=relaxed/simple;
	bh=AeleWDuyUJnZpkc4cw1hO6AX2XUTuOPcOCcE8L+UJic=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=qZkShCx66SprrDrm7JO3zC6Dnqg/IbRmR+K/kZxCtJEgCeZAL1C6yWHYAtYCua7PSlYSVf8dVtibUvajHb68vKwSerKJxGYr0tkCStS6gbd0+lHER87Q0OQMvnms6sY/F9ixCeXIRU5V/zK0poV6n/TXMBmWWdJPgQfI8ykmGJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S4L3F+p0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 150B2C4CEF5;
	Fri,  3 Oct 2025 20:38:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759523936;
	bh=AeleWDuyUJnZpkc4cw1hO6AX2XUTuOPcOCcE8L+UJic=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=S4L3F+p0Ttkg83PfSG5zfqt7CI7+pPYaDjiPpSuK35EUoIoIVcuv6V3Srzu1o/oKT
	 9k5MNgcTUyTGP/6F/niObr5CU6kwDh1uTRUkFuXkatr32bordchdMQnkRl0y094nju
	 eTi74st4JX/ZgYbTKIZ1GzKKL6KGtwE5YbGha4Hdwmh549xHD5PF9gkls4rkvCnAvD
	 /4S6BzjJ4j7n+OEb1uZ6TWMF/GML3AsDTMWqhK9ESVCCjPXLQssq9I/yNoc0wl8jxO
	 MjAoh0wHLzU652q6+EVeUyv5+wU4eC/gUVoPHunRMdBcZm25AoUQu1TZMn3rqkYwU0
	 JlYwX08bTtpVg==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Chengming Zhou <chengming.zhou@linux.dev>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Michal Hocko <mhocko@kernel.org>,
	Muchun Song <muchun.song@linux.dev>,
	Nhat Pham <nphamcs@gmail.com>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Yosry Ahmed <yosry.ahmed@linux.dev>,
	cgroups@vger.kernel.org,
	kernel-team@meta.com,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 2/4] mm/zswap: fix typos: s/zwap/zswap/
Date: Fri,  3 Oct 2025 13:38:49 -0700
Message-Id: <20251003203851.43128-3-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20251003203851.43128-1-sj@kernel.org>
References: <20251003203851.43128-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

As the subject says.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/memcontrol.c | 2 +-
 mm/zswap.c      | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 69c970554e85..74b1bc2252b6 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -5421,7 +5421,7 @@ bool obj_cgroup_may_zswap(struct obj_cgroup *objcg)
  * @size: size of compressed object
  *
  * This forces the charge after obj_cgroup_may_zswap() allowed
- * compression and storage in zwap for this cgroup to go ahead.
+ * compression and storage in zswap for this cgroup to go ahead.
  */
 void obj_cgroup_charge_zswap(struct obj_cgroup *objcg, size_t size)
 {
diff --git a/mm/zswap.c b/mm/zswap.c
index 80619c8589a7..f6b1c8832a4f 100644
--- a/mm/zswap.c
+++ b/mm/zswap.c
@@ -879,7 +879,7 @@ static bool zswap_compress(struct page *page, struct zswap_entry *entry,
 	 * acomp instance, then get those requests done simultaneously. but in this
 	 * case, zswap actually does store and load page by page, there is no
 	 * existing method to send the second page before the first page is done
-	 * in one thread doing zwap.
+	 * in one thread doing zswap.
 	 * but in different threads running on different cpu, we have different
 	 * acomp instance, so multiple threads can do (de)compression in parallel.
 	 */
@@ -1128,7 +1128,7 @@ static enum lru_status shrink_memcg_cb(struct list_head *item, struct list_lru_o
 	 *
 	 * 1. We extract the swp_entry_t to the stack, allowing
 	 *    zswap_writeback_entry() to pin the swap entry and
-	 *    then validate the zwap entry against that swap entry's
+	 *    then validate the zswap entry against that swap entry's
 	 *    tree using pointer value comparison. Only when that
 	 *    is successful can the entry be dereferenced.
 	 *
-- 
2.39.5

