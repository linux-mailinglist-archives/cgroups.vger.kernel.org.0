Return-Path: <cgroups+bounces-5859-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A94B39EF4BC
	for <lists+cgroups@lfdr.de>; Thu, 12 Dec 2024 18:10:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F0D96163771
	for <lists+cgroups@lfdr.de>; Thu, 12 Dec 2024 17:03:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD44F226527;
	Thu, 12 Dec 2024 16:59:15 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from shelob.surriel.com (shelob.surriel.com [96.67.55.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C683213E6B;
	Thu, 12 Dec 2024 16:59:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=96.67.55.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734022755; cv=none; b=P2mPSMRIq5zlnF1+yVDra5M8K1Re0CYDkS9/NuPKo9X3apPe2fqh8kCsF16571eIY7wpScjLla1/q97sh+q+tPpfXtU0e14I7yvjzdMEaAtXf5GHj+uoezvTv7t5hF1nUaCUZrmTe9bJ2SA6PQCWvd1jGi8cYHFuOdLACGqlgFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734022755; c=relaxed/simple;
	bh=UoVn7YgqG67MmpzHVdBzGefEpiXVqwUID793qHLxEb0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=GXAvtfckz5+aQ/hvNzkU6B3E4AsOjV7QwDqG32kjzS23qbIvfZHUrSLORuaDU7xtArmsCWOIPmWWeypNL/LuEly7nvodUyTflw0uSciKYRtA0NjUnXLq8hg8tyRZ/dw0tTz0a0f5rEayF5awY0oNEy7HUldQtJWYjq+LThsjoao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=surriel.com; spf=pass smtp.mailfrom=shelob.surriel.com; arc=none smtp.client-ip=96.67.55.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=surriel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shelob.surriel.com
Received: from [2601:18c:9101:a8b6:82e7:cf5d:dfd9:50ef] (helo=fangorn)
	by shelob.surriel.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.97.1)
	(envelope-from <riel@shelob.surriel.com>)
	id 1tLmVe-0000000073q-41Zi;
	Thu, 12 Dec 2024 11:57:55 -0500
Date: Thu, 12 Dec 2024 11:57:54 -0500
From: Rik van Riel <riel@surriel.com>
To: Yosry Ahmed <yosryahmed@google.com>
Cc: Balbir Singh <balbirs@nvidia.com>, Johannes Weiner <hannes@cmpxchg.org>,
 Michal Hocko <mhocko@kernel.org>, Roman Gushchin
 <roman.gushchin@linux.dev>, hakeel Butt <shakeel.butt@linux.dev>, Muchun
 Song <muchun.song@linux.dev>, Andrew Morton <akpm@linux-foundation.org>,
 cgroups@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 kernel-team@meta.com, Nhat Pham <nphamcs@gmail.com>
Subject: [PATCH v2] memcg: allow exiting tasks to write back data to swap
Message-ID: <20241212115754.38f798b3@fangorn>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: riel@surriel.com

A task already in exit can get stuck trying to allocate pages, if its
cgroup is at the memory.max limit, the cgroup is using zswap, but
zswap writeback is enabled, and the remaining memory in the cgroup is
not compressible.

This seems like an unlikely confluence of events, but it can happen
quite easily if a cgroup is OOM killed due to exceeding its memory.max
limit, and all the tasks in the cgroup are trying to exit simultaneously.

When this happens, it can sometimes take hours for tasks to exit,
as they are all trying to squeeze things into zswap to bring the group's
memory consumption below memory.max.

Allowing these exiting programs to push some memory from their own
cgroup into swap allows them to quickly bring the cgroup's memory
consumption below memory.max, and exit in seconds rather than hours.

Signed-off-by: Rik van Riel <riel@surriel.com>
---
v2: use mm_match_cgroup as suggested by Yosry Ahmed

 mm/memcontrol.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 7b3503d12aaf..ba1cd9c04a02 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -5371,6 +5371,18 @@ bool mem_cgroup_zswap_writeback_enabled(struct mem_cgroup *memcg)
 	if (!zswap_is_enabled())
 		return true;
 
+	/*
+	 * Always allow exiting tasks to push data to swap. A process in
+	 * the middle of exit cannot get OOM killed, but may need to push
+	 * uncompressible data to swap in order to get the cgroup memory
+	 * use below the limit, and make progress with the exit.
+	 */
+	if (unlikely(current->flags & PF_EXITING)) {
+		struct mm_struct *mm = READ_ONCE(current->mm);
+		if (mm && mm_match_cgroup(mm, memcg))
+			return true;
+	}
+
 	for (; memcg; memcg = parent_mem_cgroup(memcg))
 		if (!READ_ONCE(memcg->zswap_writeback))
 			return false;
-- 
2.47.0



