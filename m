Return-Path: <cgroups+bounces-14968-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KHzOMnexvWlBAgMAu9opvQ
	(envelope-from <cgroups+bounces-14968-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Fri, 20 Mar 2026 21:43:35 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C31F2E0F02
	for <lists+cgroups@lfdr.de>; Fri, 20 Mar 2026 21:43:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1538130338B0
	for <lists+cgroups@lfdr.de>; Fri, 20 Mar 2026 20:43:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE3D136167D;
	Fri, 20 Mar 2026 20:43:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Dy1u3OZE"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75FCF36074F
	for <cgroups@vger.kernel.org>; Fri, 20 Mar 2026 20:43:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774039389; cv=none; b=hF+rJMr8uQ0MUWZRlFrUkg9/hsNyvj5vaQA5MG/NqwaGx35k4MDm8LH42EnkowepuQ6wrWs4/spqOzY4tmipSUvY4qSEgZj3w/EevFeJKa1B6uW8e2rFZI2ozm/o6Dk24ANK/pzSb31tbyUohMPL+IOSwk0PbwJHK9/iz1LeJ9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774039389; c=relaxed/simple;
	bh=onxeeSmwVzoB7N64JyWSHvvF13229GQf5wYZgwtu4T8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sytHBSFypuYWo0tCm6mr9gHIQIfBpJSQz7y/8HlEyLIL1ln5muiF8RSd4THXNWDc+CeltC57aLs2GHOayOcbxKVTlnVvbu58sZTjmEaQplFwPKARYU8lv3SVSBbHZIs8yBhtZ4r/Vd15Z4I9UmXaY08B4C5V1GIbA8r4/SjZ8TY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Dy1u3OZE; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1774039386;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+VsJFp2tNWi9W0z5ic43UYrbznU9xub21G0oKpjTUlA=;
	b=Dy1u3OZEu1vX287/vwpnv7AfUMoTmfcPOL7AI8MNYRc/PmzT/D7dR+yFAZz/g5bJr3zIBQ
	BkvYD94GaysamTviOAeCi6xO7fHNuM9TnMEk/ziN+IK0zGIJXNBtHOHqxk3dmLbPOqg8PN
	MoCL5wb2xZ2UZOuNQkn0EPtZiWHbJWE=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-691-l_GXzCzJMD-UhlKZH8gwFw-1; Fri,
 20 Mar 2026 16:43:03 -0400
X-MC-Unique: l_GXzCzJMD-UhlKZH8gwFw-1
X-Mimecast-MFC-AGG-ID: l_GXzCzJMD-UhlKZH8gwFw_1774039381
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 78E78195609D;
	Fri, 20 Mar 2026 20:43:00 +0000 (UTC)
Received: from llong-thinkpadp16vgen1.westford.csb (unknown [10.22.65.139])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 9FAEC180075C;
	Fri, 20 Mar 2026 20:42:56 +0000 (UTC)
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
	Waiman Long <longman@redhat.com>,
	Li Wang <liwang@redhat.com>
Subject: [PATCH v2 1/7] memcg: Scale up vmstats flush threshold with int_sqrt(nr_cpus+2)
Date: Fri, 20 Mar 2026 16:42:35 -0400
Message-ID: <20260320204241.1613861-2-longman@redhat.com>
In-Reply-To: <20260320204241.1613861-1-longman@redhat.com>
References: <20260320204241.1613861-1-longman@redhat.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,kvack.org,google.com,gmail.com,kylinos.cn,redhat.com];
	RCPT_COUNT_TWELVE(0.00)[21];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-14968-lists,cgroups=lfdr.de];
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
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 8C31F2E0F02
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

To make the output of memory.stat more correct, it is better to scale
up the threshold slower than linearly with the number of CPUs. The
int_sqrt() function is a good compromise as suggested by Li Wang [1].
An extra 2 is added to make sure that we will double the threshold for
a 2-core system. The increase will be slower after that.

With the int_sqrt() scale, we can use the possibly larger
num_possible_cpus() instead of num_online_cpus() which may change at
run time.

Although there is supposed to be a periodic and asynchronous flush of
vmstats every 2 seconds, the actual time lag between succesive runs
can actually vary quite a bit. In fact, I have seen time lags of up
to 10s of seconds in some cases. So we couldn't too rely on the hope
that there will be an asynchronous vmstats flush every 2 seconds. This
may be something we need to look into.

[1] https://lore.kernel.org/lkml/ab0kAE7mJkEL9kWb@redhat.com/

Suggested-by: Li Wang <liwang@redhat.com>
Signed-off-by: Waiman Long <longman@redhat.com>
---
 mm/memcontrol.c | 18 +++++++++++++-----
 1 file changed, 13 insertions(+), 5 deletions(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 772bac21d155..cc1fc0f5aeea 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -548,20 +548,20 @@ struct memcg_vmstats {
  *    rstat update tree grow unbounded.
  *
  * 2) Flush the stats synchronously on reader side only when there are more than
- *    (MEMCG_CHARGE_BATCH * nr_cpus) update events. Though this optimization
- *    will let stats be out of sync by atmost (MEMCG_CHARGE_BATCH * nr_cpus) but
- *    only for 2 seconds due to (1).
+ *    (MEMCG_CHARGE_BATCH * int_sqrt(nr_cpus+2)) update events. Though this
+ *    optimization will let stats be out of sync by up to that amount. This is
+ *    supposed to last for up to 2 seconds due to (1).
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
@@ -5191,6 +5191,14 @@ int __init mem_cgroup_init(void)
 
 	memcg_pn_cachep = KMEM_CACHE(mem_cgroup_per_node,
 				     SLAB_PANIC | SLAB_HWCACHE_ALIGN);
+	/*
+	 * Scale up vmstats flush threshold with int_sqrt(nr_cpus+2). The extra
+	 * 2 constant is to make sure that the threshold is double for a 2-core
+	 * system. After that, it will increase by MEMCG_CHARGE_BATCH when the
+	 * number of the CPUs reaches the next (2^n - 2) value.
+	 */
+	vmstats_flush_threshold = MEMCG_CHARGE_BATCH *
+				  (int_sqrt(num_possible_cpus() + 2));
 
 	return 0;
 }
-- 
2.53.0


