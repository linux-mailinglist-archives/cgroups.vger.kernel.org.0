Return-Path: <cgroups+bounces-7346-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 50665A7B56A
	for <lists+cgroups@lfdr.de>; Fri,  4 Apr 2025 03:25:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D2627188FE24
	for <lists+cgroups@lfdr.de>; Fri,  4 Apr 2025 01:25:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB7F71CD3F;
	Fri,  4 Apr 2025 01:25:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aK4VrS/P"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9A4C45945
	for <cgroups@vger.kernel.org>; Fri,  4 Apr 2025 01:25:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743729910; cv=none; b=NkJgetrawr93a1vxo10iLgX44jSdUWCod1vlG8rJE6P5mOC2bJJNaic8yC+PSueWi1IP87W8fAK4wwl9zlzu9fpxMthyKWUGU1hFL/0RdGhEQ6+LbxP97lMme4SJcxbchT9a7Bjsyg4kMPZH7nxGptpuFzh8aPB+JkiumimuRYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743729910; c=relaxed/simple;
	bh=LpA9FyU6S3VEfDl9/LNHrnpW1DCPvRJq3D3FwBIgIGY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=aC6ywNYU6x3IqHnge9FM+SgdwPZo+TrpzJ4exWFJCUE34ABBHkQ51uknId5S7DC9jO3IaCyApawBqm5IK/yoSEHFd8O4wEOn4uHp8OObX3LclLxchCwkOJe28AE8EW+pA9x1g1XU8V9eYH1T7sFqvPLvpEQm0W8OKwD/kFuSk4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=aK4VrS/P; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1743729907;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=eeDF4dFIWOS0DFmcqcZYB3wJsohtT8Hr0IIadggs/8c=;
	b=aK4VrS/Pu73xwESGR6IYpRb0OZAjxcO8LXJsazfhrSRiiIjU10DUH+phWyzux5VHzlBxoa
	EjwtgbQRCAaULOfAuOQ5ZVw/ONu38+6FasdGn2oD18PvxZBk/fD889nA8jRQRqlJP4GxPg
	55mGyPBYB169SHEbaCNMUDbB2RujMn8=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-360-qnvY40IQO2C4Esh2un-iuA-1; Thu,
 03 Apr 2025 21:25:00 -0400
X-MC-Unique: qnvY40IQO2C4Esh2un-iuA-1
X-Mimecast-MFC-AGG-ID: qnvY40IQO2C4Esh2un-iuA_1743729898
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id BCD5C1956089;
	Fri,  4 Apr 2025 01:24:57 +0000 (UTC)
Received: from llong-thinkpadp16vgen1.westford.csb (unknown [10.22.89.4])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 5B1B3180B489;
	Fri,  4 Apr 2025 01:24:54 +0000 (UTC)
From: Waiman Long <longman@redhat.com>
To: Johannes Weiner <hannes@cmpxchg.org>,
	Michal Hocko <mhocko@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Muchun Song <muchun.song@linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>,
	Tejun Heo <tj@kernel.org>,
	=?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>,
	Shuah Khan <shuah@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	cgroups@vger.kernel.org,
	linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org,
	Waiman Long <longman@redhat.com>
Subject: [PATCH v2 1/2] memcg: Don't generate low/min events if either low/min or elow/emin is 0
Date: Thu,  3 Apr 2025 21:24:34 -0400
Message-ID: <20250404012435.656045-1-longman@redhat.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

The test_memcontrol selftest consistently fails its test_memcg_low
sub-test due to the fact that two of its test child cgroups which
have a memmory.low of 0 or an effective memory.low of 0 still have low
events generated for them since mem_cgroup_below_low() use the ">="
operator when comparing to elow.

The two failed use cases are as follows:

1) memory.low is set to 0, but low events can still be triggered and
   so the cgroup may have a non-zero low event count. I doubt users are
   looking for that as they didn't set memory.low at all.

2) memory.low is set to a non-zero value but the cgroup has no task in
   it so that it has an effective low value of 0. Again it may have a
   non-zero low event count if memory reclaim happens. This is probably
   not a result expected by the users and it is really doubtful that
   users will check an empty cgroup with no task in it and expecting
   some non-zero event counts.

The simple and naive fix of changing the operator to ">", however,
changes the memory reclaim behavior which can lead to other failures
as low events are needed to facilitate memory reclaim.  So we can't do
that without some relatively riskier changes in memory reclaim.

Another simpler alternative is to avoid reporting below_low failure
if either memory.low or its effective equivalent is 0 which is done
by this patch specifically for the two failed use cases above.

With this patch applied, the test_memcg_low sub-test finishes
successfully without failure in most cases. Though both test_memcg_low
and test_memcg_min sub-tests may still fail occasionally if the
memory.current values fall outside of the expected ranges.

To be consistent, similar change is appled to mem_cgroup_below_min()
as to avoid the two failed use cases above with low replaced by min.

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


