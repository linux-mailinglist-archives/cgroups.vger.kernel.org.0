Return-Path: <cgroups+bounces-7310-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 79257A79A5A
	for <lists+cgroups@lfdr.de>; Thu,  3 Apr 2025 05:13:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7D9A7171DD7
	for <lists+cgroups@lfdr.de>; Thu,  3 Apr 2025 03:13:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE4D91854;
	Thu,  3 Apr 2025 03:12:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="h28YYKy9"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB63B1953A2
	for <cgroups@vger.kernel.org>; Thu,  3 Apr 2025 03:12:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743649976; cv=none; b=XA/OSmtPMcCa7eyGwlDks+PYI1eri/upYpgjUf/8MfeBEqee5OyfAtdF4FJIjKO1DKTamAJUhYYXrJ9XZwXMHpIbeFda9BZ4xdGC3Z4fSXRFy9extR1J4ldctlFEpr6A9zj0XZjXyXy032MFoJuqWbj2jlFqmk1BfLZL9Xxdu3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743649976; c=relaxed/simple;
	bh=pSQIlSO4V2XllUgBP3J9byvX7GNKqbpUPy7+SqN7W/U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XoSTFWzJBK3hY6sp812BAXM287r5MOOpyepFx0mlJ/+PXXY2YqvrpyFN9tKS+3B8mDqaUkFtB5mSG++xcB8iUAEPOHoZik/QhB7S8pJ8Wl84m456Y9v0wBO9rgK/QfnzTBmGfqway0ohK+McK9DsQ2O+mWzpkaQ9wALLPQyVuLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=h28YYKy9; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1743649973;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=tHphIEaw5gDaEtW0EdbaEwdklWHfbt6vvd4IdDuXcxU=;
	b=h28YYKy91wtwhlSd2qOLBcRxu8R+DPWqstnK0Ie+TLKAnk85timM26DWmJhBNwc0W4kZQJ
	tLBElbnea91fQdq5khzQFwg76m6P2uq6bDPVUQxHZksUW9bW7lReWag8wXHyCGS58CoqMD
	TbIB6y4MOXcdpQNZroa2t45sPbdGRSY=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-367-FeCn6EObM2q3ZsXIDduRxg-1; Wed,
 02 Apr 2025 23:12:50 -0400
X-MC-Unique: FeCn6EObM2q3ZsXIDduRxg-1
X-Mimecast-MFC-AGG-ID: FeCn6EObM2q3ZsXIDduRxg_1743649969
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B50FA19560B3;
	Thu,  3 Apr 2025 03:12:48 +0000 (UTC)
Received: from llong-thinkpadp16vgen1.westford.csb (unknown [10.22.81.199])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id E991E1955BC2;
	Thu,  3 Apr 2025 03:12:45 +0000 (UTC)
From: Waiman Long <longman@redhat.com>
To: Johannes Weiner <hannes@cmpxchg.org>,
	Michal Hocko <mhocko@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Muchun Song <muchun.song@linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org,
	cgroups@vger.kernel.org,
	linux-mm@kvack.org,
	Waiman Long <longman@redhat.com>
Subject: [PATCH] memcg: Don't generate low/min events if either low/min or elow/emin is 0
Date: Wed,  2 Apr 2025 23:12:12 -0400
Message-ID: <20250403031212.317837-1-longman@redhat.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

The test_memcontrol selftest consistently fails its test_memcg_low
sub-test because of the fact that two of its test child cgroups which
have a memmory.low of 0 or an effective memory.low of 0 still have low
events generated for them since mem_cgroup_below_low() use the ">="
operator when comparing to elow.

The simple fix of changing the operator to ">", however, changes the
way memory reclaim works quite drastically leading to other failures.
So we can't do that without some relatively riskier changes in memory
reclaim.

Another simpler alternative is to avoid reporting below_low failure
if either memory.low or its effective equivalent is 0 which is done
by this patch.

With this patch applied, the test_memcg_low sub-test finishes
successfully without failure in most cases. Though both test_memcg_low
and test_memcg_min sub-tests may fail occasionally if the memory.current
values fall outside of the expected ranges.

To be consistent, similar change is appled to mem_cgroup_below_min()
as well.

Signed-off-by: Waiman Long <longman@redhat.com>
---
 include/linux/memcontrol.h | 18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index 53364526d877..4d4a1f159eaa 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -601,21 +601,31 @@ static inline bool mem_cgroup_unprotected(struct mem_cgroup *target,
 static inline bool mem_cgroup_below_low(struct mem_cgroup *target,
 					struct mem_cgroup *memcg)
 {
+	unsigned long elow;
+
 	if (mem_cgroup_unprotected(target, memcg))
 		return false;
 
-	return READ_ONCE(memcg->memory.elow) >=
-		page_counter_read(&memcg->memory);
+	elow = READ_ONCE(memcg->memory.elow);
+	if (!elow || !READ_ONCE(memcg->memory.low))
+		return false;
+
+	return page_counter_read(&memcg->memory) <= elow;
 }
 
 static inline bool mem_cgroup_below_min(struct mem_cgroup *target,
 					struct mem_cgroup *memcg)
 {
+	unsigned long emin;
+
 	if (mem_cgroup_unprotected(target, memcg))
 		return false;
 
-	return READ_ONCE(memcg->memory.emin) >=
-		page_counter_read(&memcg->memory);
+	emin = READ_ONCE(memcg->memory.emin);
+	if (!emin || !READ_ONCE(memcg->memory.min))
+		return false;
+
+	return page_counter_read(&memcg->memory) <= emin;
 }
 
 int __mem_cgroup_charge(struct folio *folio, struct mm_struct *mm, gfp_t gfp);
-- 
2.48.1


