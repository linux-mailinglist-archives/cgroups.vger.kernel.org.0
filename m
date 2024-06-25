Return-Path: <cgroups+bounces-3331-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 38CF2915B64
	for <lists+cgroups@lfdr.de>; Tue, 25 Jun 2024 03:01:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6B9501C218C4
	for <lists+cgroups@lfdr.de>; Tue, 25 Jun 2024 01:01:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B3B7175BF;
	Tue, 25 Jun 2024 00:59:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="PlGf6lnG"
X-Original-To: cgroups@vger.kernel.org
Received: from out-182.mta0.migadu.com (out-182.mta0.migadu.com [91.218.175.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB0554CB4E
	for <cgroups@vger.kernel.org>; Tue, 25 Jun 2024 00:59:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719277193; cv=none; b=FR6geT+kq4Mpi4p+60tPUCBTJJ/wyV8lRIiSyUgxoEx9ym6sByF4FTY+ZsW9kXEs+qGqBxwjOBfxl1QMwxgR2N/UVxyXWNMuuFpseGy0zsJGRF1YrjU1pHNxPIez0TIn8urhQcFcG0BrF/wD8dmcp2eLXrnWLyuuFQmuNbdMO44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719277193; c=relaxed/simple;
	bh=Pz7OL3KQbrtV83W/iSFgHROsNnyda+pJCYcSrpY3Zt8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qJDwIJkU4DJuwn8Cqpw83vTxdbVTuZ2Moqilesnn9R8F1kclBtSi5zgogBe2MuvF/rHp8WW6nImX67IwoCJoO6wPfRh2yM+3ZqM2wh035dxE33j0ISn9PVUa+S/1hFMw6HNksUI0KZZzw3765zxMyc4puwF4eaUnmsI8/TSziDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=PlGf6lnG; arc=none smtp.client-ip=91.218.175.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: akpm@linux-foundation.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1719277190;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=i6OtryeQEKVoJSpeL/4FN+6EUWrG1/pihifLngpHrqA=;
	b=PlGf6lnGIQXNmfnq2Lb4Tkf4shhTkmXLgelP2ND3Ym1XBUrQgwU2RRuocobaKhgUDIawY9
	y/qwRqVY0IWNNQJ78VvWbqijJuUQHx0Fx3ff0YC5Hnm0PZzzLh8G6Fp4u+r+ci0iSk4sBa
	ygiGKYxBilotTIeiKryEUQaV54ffcHg=
X-Envelope-To: hannes@cmpxchg.org
X-Envelope-To: mhocko@kernel.org
X-Envelope-To: shakeel.butt@linux.dev
X-Envelope-To: muchun.song@linux.dev
X-Envelope-To: linux-kernel@vger.kernel.org
X-Envelope-To: cgroups@vger.kernel.org
X-Envelope-To: linux-mm@kvack.org
X-Envelope-To: roman.gushchin@linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Roman Gushchin <roman.gushchin@linux.dev>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Johannes Weiner <hannes@cmpxchg.org>,
	Michal Hocko <mhocko@kernel.org>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Muchun Song <muchun.song@linux.dev>,
	linux-kernel@vger.kernel.org,
	cgroups@vger.kernel.org,
	linux-mm@kvack.org,
	Roman Gushchin <roman.gushchin@linux.dev>
Subject: [PATCH v2 11/14] mm: memcg: make memcg1_update_tree() static
Date: Mon, 24 Jun 2024 17:59:03 -0700
Message-ID: <20240625005906.106920-12-roman.gushchin@linux.dev>
In-Reply-To: <20240625005906.106920-1-roman.gushchin@linux.dev>
References: <20240625005906.106920-1-roman.gushchin@linux.dev>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

memcg1_update_tree() is not used outside of mm/memcontrol-v1.c
anymore, define it as static and remove the declaration from
the header file.

Signed-off-by: Roman Gushchin <roman.gushchin@linux.dev>
---
 mm/memcontrol-v1.c | 2 +-
 mm/memcontrol-v1.h | 1 -
 2 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/mm/memcontrol-v1.c b/mm/memcontrol-v1.c
index 1b7337d0170d..f89de413004b 100644
--- a/mm/memcontrol-v1.c
+++ b/mm/memcontrol-v1.c
@@ -201,7 +201,7 @@ static unsigned long soft_limit_excess(struct mem_cgroup *memcg)
 	return excess;
 }
 
-void memcg1_update_tree(struct mem_cgroup *memcg, int nid)
+static void memcg1_update_tree(struct mem_cgroup *memcg, int nid)
 {
 	unsigned long excess;
 	struct mem_cgroup_per_node *mz;
diff --git a/mm/memcontrol-v1.h b/mm/memcontrol-v1.h
index 7be4670d9abb..7d6ac4a4fb36 100644
--- a/mm/memcontrol-v1.h
+++ b/mm/memcontrol-v1.h
@@ -5,7 +5,6 @@
 
 #include <linux/cgroup-defs.h>
 
-void memcg1_update_tree(struct mem_cgroup *memcg, int nid);
 void memcg1_remove_from_trees(struct mem_cgroup *memcg);
 
 static inline void memcg1_soft_limit_reset(struct mem_cgroup *memcg)
-- 
2.45.2


