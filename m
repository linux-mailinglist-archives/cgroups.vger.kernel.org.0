Return-Path: <cgroups+bounces-14916-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QAjiFkM2vGl3uwIAu9opvQ
	(envelope-from <cgroups+bounces-14916-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Thu, 19 Mar 2026 18:45:39 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B3B4C2D0386
	for <lists+cgroups@lfdr.de>; Thu, 19 Mar 2026 18:45:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C1D8930763DD
	for <lists+cgroups@lfdr.de>; Thu, 19 Mar 2026 17:40:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 804C1374722;
	Thu, 19 Mar 2026 17:39:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TTI3XbwL"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1092D396D10
	for <cgroups@vger.kernel.org>; Thu, 19 Mar 2026 17:38:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773941945; cv=none; b=k+Ds0sjJIixdNaZPkQ+HuOviCFXtYOGjXNkHKVe/g/ht0pc9EcQCSCiT1tSbpd18X6Hp/GqO0ZE7OXqU8q+z332jwdgPFh1A5ucYi+YB7QYkaLdb26vnu3HHJ4eRuKmjK6Ahi5yHUky7f1eBeHUmxoetjeAUgqY7J6KWa4Ynjf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773941945; c=relaxed/simple;
	bh=dsedcvfs3WyPJKy5VxmTHtgUuAYNcPWg7HL9k5nXoXo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=o6589XK8ulYck2iL3a5GdrVjFWGF1YyOX9oSx+v7BPiCx1EBt+1x+70rVsRdQC03PCnPPm6lYCPI8pgkpPbtB6sctjrsJTc8sMzuAz9XvNRvCvahj/MfI1sUl6IGyFrxUb1WTuqQE75qdhozm1FbqPYIyMoG5w8uF2ra0Rvc7Pc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TTI3XbwL; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1773941938;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nqbIelhKh/+RMtXT/TasUG8zStElNREsucgnnLo8/DM=;
	b=TTI3XbwLQt5w500mWVRusPcdEliyeCwPIzXb3ZklAJfDC1Ha2/lbRPNMULqBidYSX/wvMI
	GuAnLY8GlpuUQZ20j9gr5esK3gl6u1hbn3wKTG97VUAv3A8D02MSaJfneGoWpNeZ48ZFEK
	sV0u/s0Im6lRtuGSbtr+CZi+c0J1Too=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-523-lNQCi7DFNEiVKg0aQMKFfw-1; Thu,
 19 Mar 2026 13:38:55 -0400
X-MC-Unique: lNQCi7DFNEiVKg0aQMKFfw-1
X-Mimecast-MFC-AGG-ID: lNQCi7DFNEiVKg0aQMKFfw_1773941933
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 627591956062;
	Thu, 19 Mar 2026 17:38:52 +0000 (UTC)
Received: from llong-thinkpadp16vgen1.westford.csb (unknown [10.22.80.194])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id D86ED30002DF;
	Thu, 19 Mar 2026 17:38:48 +0000 (UTC)
From: Waiman Long <longman@redhat.com>
To: Johannes Weiner <hannes@cmpxchg.org>,
	Michal Hocko <mhocko@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Muchun Song <muchun.song@linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>,
	Tejun Heo <tj@kernel.org>,
	=?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>,
	Shuah Khan <shuah@kernel.org>,
	Mike Rapoport <rppt@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	cgroups@vger.kernel.org,
	linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org,
	Sean Christopherson <seanjc@google.com>,
	James Houghton <jthoughton@google.com>,
	Sebastian Chlad <sebastianchlad@gmail.com>,
	Guopeng Zhang <zhangguopeng@kylinos.cn>,
	Li Wang <liwan@redhat.com>,
	Waiman Long <longman@redhat.com>
Subject: [PATCH 1/7] memcg: Scale up vmstats flush threshold with log2(nums_possible_cpus)
Date: Thu, 19 Mar 2026 13:37:46 -0400
Message-ID: <20260319173752.1472864-2-longman@redhat.com>
In-Reply-To: <20260319173752.1472864-1-longman@redhat.com>
References: <20260319173752.1472864-1-longman@redhat.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,kvack.org,google.com,gmail.com,kylinos.cn,redhat.com];
	RCPT_COUNT_TWELVE(0.00)[20];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-14916-lists,cgroups=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[longman@redhat.com,cgroups@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[cgroups];
	NEURAL_HAM(-0.00)[-0.957];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: B3B4C2D0386
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The vmstats flush threshold currently increases linearly with the
number of online CPUs. As the number of CPUs increases over time, it
will become increasingly difficult to meet the threshold and update the
vmstats data in a timely manner. These days, systems with hundreds of
CPUs or even thousands of them are becoming more common.

For example, the test_memcg_sock test of test_memcontrol always fails
when running on an arm64 system with 128 CPUs. It is because the
threshold is now 64*128 = 8192. With 4k page size, it needs changes in
32 MB of memory. It will be even worse with larger page size like 64k.

To make the output of memory.stat more correct, it is better to
scale up the threshold logarithmically instead of linearly with the
number of CPUs. With the log2 scale, we can use the possibly larger
num_possible_cpus() instead of num_online_cpus() which may change at
run time.

Although there is supposed to be a periodic and asynchronous flush of
vmstats every 2 seconds, the actual time lag between succesive runs
can actually vary quite a bit. In fact, I have seen time lags of up
to 10s of seconds in some cases. So we couldn't too rely on the hope
that there will be an asynchronous vmstats flush every 2 seconds. This
may be something we need to look into.

Signed-off-by: Waiman Long <longman@redhat.com>
---
 mm/memcontrol.c | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 772bac21d155..8d4ede72f05c 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -548,20 +548,20 @@ struct memcg_vmstats {
  *    rstat update tree grow unbounded.
  *
  * 2) Flush the stats synchronously on reader side only when there are more than
- *    (MEMCG_CHARGE_BATCH * nr_cpus) update events. Though this optimization
- *    will let stats be out of sync by atmost (MEMCG_CHARGE_BATCH * nr_cpus) but
- *    only for 2 seconds due to (1).
+ *    (MEMCG_CHARGE_BATCH * (ilog2(nr_cpus) + 1)) update events. Though this
+ *    optimization will let stats be out of sync by up to that amount but only
+ *    for 2 seconds due to (1).
  */
 static void flush_memcg_stats_dwork(struct work_struct *w);
 static DECLARE_DEFERRABLE_WORK(stats_flush_dwork, flush_memcg_stats_dwork);
 static u64 flush_last_time;
+static int vmstats_flush_threshold __ro_after_init;
 
 #define FLUSH_TIME (2UL*HZ)
 
 static bool memcg_vmstats_needs_flush(struct memcg_vmstats *vmstats)
 {
-	return atomic_read(&vmstats->stats_updates) >
-		MEMCG_CHARGE_BATCH * num_online_cpus();
+	return atomic_read(&vmstats->stats_updates) > vmstats_flush_threshold;
 }
 
 static inline void memcg_rstat_updated(struct mem_cgroup *memcg, int val,
@@ -5191,6 +5191,13 @@ int __init mem_cgroup_init(void)
 
 	memcg_pn_cachep = KMEM_CACHE(mem_cgroup_per_node,
 				     SLAB_PANIC | SLAB_HWCACHE_ALIGN);
+	/*
+	 * Logarithmically scale up vmstats flush threshold with the number
+	 * of CPUs.
+	 * N.B. ilog2(1) = 0.
+	 */
+	vmstats_flush_threshold = MEMCG_CHARGE_BATCH *
+				  (ilog2(num_possible_cpus()) + 1);
 
 	return 0;
 }
-- 
2.53.0


