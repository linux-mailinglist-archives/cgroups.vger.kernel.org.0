Return-Path: <cgroups+bounces-11262-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 68516C15167
	for <lists+cgroups@lfdr.de>; Tue, 28 Oct 2025 15:13:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2557B645955
	for <lists+cgroups@lfdr.de>; Tue, 28 Oct 2025 14:06:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE43C33EB06;
	Tue, 28 Oct 2025 14:04:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="pWzdGFK9"
X-Original-To: cgroups@vger.kernel.org
Received: from out-183.mta0.migadu.com (out-183.mta0.migadu.com [91.218.175.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6165633DEDF
	for <cgroups@vger.kernel.org>; Tue, 28 Oct 2025 14:04:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761660250; cv=none; b=g5NT9gTDwXY6WDsUdAo6sDQkhwP1YoAIuic5CaO76i/VqQlu9GvaOxvqKGfUHJzAk2f8zq9ler7F65tQXUnxPtw4YXOiFVoCBB3b0N5T64iUgJ5vNvp0OvZWTswatt0CwNEhDe7+PsPzxRLkM2wfX/FqI/JCBQelfagMX2xo30c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761660250; c=relaxed/simple;
	bh=OSy/9GGCdN7m8F02iyVvXHlEK7sNx7mHMO14zaERKGQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uppg7z/jZea5dTzH208PvsV29ODXMoHSpFRPFuP6wx0filsUX1UezvrYe/k9CqmSt3E2d4SF1PIqx9jOUMmfAQn9b/JZuyUiIUT4qvlBXA9nT3x0rgPdQwFBb+I4j1eIR10IubSksc1iJLkPUdzFdBddZ4zI8ijVykxr9Iq5NY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=pWzdGFK9; arc=none smtp.client-ip=91.218.175.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1761660244;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=d2EOOSlZh8oRwtRfQtnzgpJLzbPe1acyr5pcLzwWU68=;
	b=pWzdGFK9jp5/gKWOoMPYfN/1zgwDvyk5R6UyUH2ocXAJcYLiJkqMhI+d2hIraioYk881Hw
	7rzlQkLG3uO06lrW3XshXYI5VB2JcP+sh5murHeNw1f62HR7cktjcNoiJHB7FiwL0hTSM1
	7bK+5TfatVR2jrRm9JSuNcGrGdlqOCQ=
From: Qi Zheng <qi.zheng@linux.dev>
To: hannes@cmpxchg.org,
	hughd@google.com,
	mhocko@suse.com,
	roman.gushchin@linux.dev,
	shakeel.butt@linux.dev,
	muchun.song@linux.dev,
	david@redhat.com,
	lorenzo.stoakes@oracle.com,
	ziy@nvidia.com,
	harry.yoo@oracle.com,
	imran.f.khan@oracle.com,
	kamalesh.babulal@oracle.com,
	axelrasmussen@google.com,
	yuanchu@google.com,
	weixugc@google.com,
	akpm@linux-foundation.org
Cc: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	cgroups@vger.kernel.org,
	Muchun Song <songmuchun@bytedance.com>,
	Qi Zheng <zhengqi.arch@bytedance.com>
Subject: [PATCH v1 17/26] mm: workingset: prevent lruvec release in workingset_refault()
Date: Tue, 28 Oct 2025 21:58:30 +0800
Message-ID: <7d58f7f924961bc9ce386b3101448a49d7aa1daa.1761658310.git.zhengqi.arch@bytedance.com>
In-Reply-To: <cover.1761658310.git.zhengqi.arch@bytedance.com>
References: <cover.1761658310.git.zhengqi.arch@bytedance.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Muchun Song <songmuchun@bytedance.com>

In the near future, a folio will no longer pin its corresponding
memory cgroup. So an lruvec returned by folio_lruvec() could be
released without the rcu read lock or a reference to its memory
cgroup.

In the current patch, the rcu read lock is employed to safeguard
against the release of the lruvec in workingset_refault().

This serves as a preparatory measure for the reparenting of the
LRU pages.

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
---
 mm/workingset.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/mm/workingset.c b/mm/workingset.c
index c4d21c15bad51..a69cc7bf9246d 100644
--- a/mm/workingset.c
+++ b/mm/workingset.c
@@ -560,11 +560,12 @@ void workingset_refault(struct folio *folio, void *shadow)
 	 * locked to guarantee folio_memcg() stability throughout.
 	 */
 	nr = folio_nr_pages(folio);
+	rcu_read_lock();
 	lruvec = folio_lruvec(folio);
 	mod_lruvec_state(lruvec, WORKINGSET_REFAULT_BASE + file, nr);
 
 	if (!workingset_test_recent(shadow, file, &workingset, true))
-		return;
+		goto out;
 
 	folio_set_active(folio);
 	workingset_age_nonresident(lruvec, nr);
@@ -580,6 +581,8 @@ void workingset_refault(struct folio *folio, void *shadow)
 		lru_note_cost_refault(folio);
 		mod_lruvec_state(lruvec, WORKINGSET_RESTORE_BASE + file, nr);
 	}
+out:
+	rcu_read_unlock();
 }
 
 /**
-- 
2.20.1


