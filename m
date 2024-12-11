Return-Path: <cgroups+bounces-5809-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 891579ED080
	for <lists+cgroups@lfdr.de>; Wed, 11 Dec 2024 16:55:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 71AD2188325B
	for <lists+cgroups@lfdr.de>; Wed, 11 Dec 2024 15:55:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 161461D63FA;
	Wed, 11 Dec 2024 15:54:54 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from shelob.surriel.com (shelob.surriel.com [96.67.55.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E792A1DAC8E;
	Wed, 11 Dec 2024 15:54:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=96.67.55.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733932493; cv=none; b=s9bpFtGqQfVLynw3wSo1y7Sb4wH4VHS0pSnBRXS5tyYA93P1B3bpHgyxOE3sh5te+zk9LB967zPxTopwHlf1bv8HnI5ZynrFZ3p3pD9MsHJfjKjc8drkZTbL+5rVsKhKXsrmfOSPFfMYX/QwEzX98sLaP4EvJp5jNgVt3rRjYRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733932493; c=relaxed/simple;
	bh=5DoJ17glcptI6ZVGbX8JVu6yYbvuguoJLJoC8IAjSBQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=RTxMcYWMFpaoA7YKq8U8hmAyxbzox3f4IC/3oBA3cxlaJilQAwivSdtFKJGQkXm8mU30FlT9a6Zfm63OBMv0WCbeHbNsoJ9eVI1aSx7oMW8Bk4G/4bYf5BbSeUH3zc8geO9x7K5DYb1uy5JtLSRzO3srd3lke6Ld9lndw/V7PSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=surriel.com; spf=pass smtp.mailfrom=shelob.surriel.com; arc=none smtp.client-ip=96.67.55.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=surriel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shelob.surriel.com
Received: from [2601:18c:9101:a8b6:82e7:cf5d:dfd9:50ef] (helo=fangorn)
	by shelob.surriel.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.97.1)
	(envelope-from <riel@shelob.surriel.com>)
	id 1tLP1t-0000000007A-3AYU;
	Wed, 11 Dec 2024 10:53:37 -0500
Date: Wed, 11 Dec 2024 10:53:36 -0500
From: Rik van Riel <riel@surriel.com>
To: Johannes Weiner <hannes@cmpxchg.org>
Cc: Michal Hocko <mhocko@kernel.org>, Roman Gushchin
 <roman.gushchin@linux.dev>, Shakeel Butt <shakeel.butt@linux.dev>, Muchun
 Song <muchun.song@linux.dev>, Andrew Morton <akpm@linux-foundation.org>,
 cgroups@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 kernel-team@meta.com, Nhat Pham <nphamcs@gmail.com>, Yosry Ahmed
 <yosryahmed@google.com>
Subject: [PATCH] memcg: allow exiting tasks to write back data to swap
Message-ID: <20241211105336.380cb545@fangorn>
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

Loading this fix as a live patch on a system where a workload got stuck
exiting allowed the workload to exit within a fraction of a second.

Signed-off-by: Rik van Riel <riel@surriel.com>
---
 mm/memcontrol.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 7b3503d12aaf..03d77e93087e 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -5371,6 +5371,15 @@ bool mem_cgroup_zswap_writeback_enabled(struct mem_cgroup *memcg)
 	if (!zswap_is_enabled())
 		return true;
 
+	/*
+	 * Always allow exiting tasks to push data to swap. A process in
+	 * the middle of exit cannot get OOM killed, but may need to push
+	 * uncompressible data to swap in order to get the cgroup memory
+	 * use below the limit, and make progress with the exit.
+	 */
+	if ((current->flags & PF_EXITING) && memcg == mem_cgroup_from_task(current))
+		return true;
+
 	for (; memcg; memcg = parent_mem_cgroup(memcg))
 		if (!READ_ONCE(memcg->zswap_writeback))
 			return false;
-- 
2.47.0



