Return-Path: <cgroups+bounces-6376-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 87D4FA22476
	for <lists+cgroups@lfdr.de>; Wed, 29 Jan 2025 20:13:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 57A143A2BCB
	for <lists+cgroups@lfdr.de>; Wed, 29 Jan 2025 19:13:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DB301E2847;
	Wed, 29 Jan 2025 19:13:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fnLasy5h"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27D13194089
	for <cgroups@vger.kernel.org>; Wed, 29 Jan 2025 19:13:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738178023; cv=none; b=B2hlJdNX1ZqQoolydsuDiBmOm0CN2YcvvaAGz4OSR7BD7uR7TX85LCU01OyNHWhyUurs5YatAvyo7OgMRqV21BO5KTp8if+uzcrIFbxhVZcUUGL9Weg558Ve+86ALneUbLWPkTrdodpQTItnkqas9/Znt8vLgmAbzNJAiIcwFgc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738178023; c=relaxed/simple;
	bh=rzLzjYrQFIGsBb/wF5fNiV+zZdxHUAcvPCnP/FaLu04=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=d0L02G1GEQdbibag3NHOwG/QDCp6B3qFu2kTPBm7qoGWcE1uFoYPlO28/0hlED09rAXgKh7ZeVjnoZwGGZmFkq+KeRLxQxbjEFRILZk4Bi5mG3Uted8QcxIlHJHTGaeIuMIP7jwQQzHxfffaQsEOelEQSICINo7NqAF16q+Q2Ds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fnLasy5h; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1738178019;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=ESCwOFGjc2CRHxjS2qaB93dnoCB0+FE5/DZ0ZcBVXU8=;
	b=fnLasy5hiyE+iFyGzrIFE9irDvqrUYsmSOGTGvoF5QfwPG3V1As9EfNBLXGP71Y4uhHjBc
	0U8HI/XOzcG0wUbW0XT5Xl3RXG7dQ76rL7EJ4FUXJm4olV7C5QuiApZT7lw16ZIZjKqIlu
	ggv3OyPyrhlUK/WmlPzuxBEA4l5R2/4=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-79-b4VoASIBNvaRCCa7iNt4nQ-1; Wed,
 29 Jan 2025 14:13:35 -0500
X-MC-Unique: b4VoASIBNvaRCCa7iNt4nQ-1
X-Mimecast-MFC-AGG-ID: b4VoASIBNvaRCCa7iNt4nQ
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id DB3551956087;
	Wed, 29 Jan 2025 19:13:32 +0000 (UTC)
Received: from llong-thinkpadp16vgen1.westford.csb (unknown [10.22.64.23])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 9EE8130001BE;
	Wed, 29 Jan 2025 19:13:28 +0000 (UTC)
From: Waiman Long <longman@redhat.com>
To: Tejun Heo <tj@kernel.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	=?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Michal Hocko <mhocko@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Muchun Song <muchun.song@linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org,
	cgroups@vger.kernel.org,
	linux-mm@kvack.org,
	linux-doc@vger.kernel.org,
	Peter Hunt <pehunt@redhat.com>,
	Waiman Long <longman@redhat.com>
Subject: [RFC PATCH] mm, memcg: introduce memory.high.throttle
Date: Wed, 29 Jan 2025 14:12:04 -0500
Message-ID: <20250129191204.368199-1-longman@redhat.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

Since commit 0e4b01df8659 ("mm, memcg: throttle allocators when failing
reclaim over memory.high"), the amount of allocator throttling had
increased substantially. As a result, it could be difficult for a
misbehaving application that consumes increasing amount of memory from
being OOM-killed if memory.high is set. Instead, the application may
just be crawling along holding close to the allowed memory.high memory
for the current memory cgroup for a very long time especially those
that do a lot of memcg charging and uncharging operations.

This behavior makes the upstream Kubernetes community hesitate to
use memory.high. Instead, they use only memory.max for memory control
similar to what is being done for cgroup v1 [1].

To allow better control of the amount of throttling and hence the
speed that a misbehving task can be OOM killed, a new single-value
memory.high.throttle control file is now added. The allowable range
is 0-32.  By default, it has a value of 0 which means maximum throttling
like before. Any non-zero positive value represents the corresponding
power of 2 reduction of throttling and makes OOM kills easier to happen.

System administrators can now use this parameter to determine how easy
they want OOM kills to happen for applications that tend to consume
a lot of memory without the need to run a special userspace memory
management tool to monitor memory consumption when memory.high is set.

Below are the test results of a simple program showing how different
values of memory.high.throttle can affect its run time (in secs) until
it gets OOM killed. This test program allocates pages from kernel
continuously. There are some run-to-run variations and the results
are just one possible set of samples.

  # systemd-run -p MemoryHigh=10M -p MemoryMax=20M -p MemorySwapMax=10M \
	--wait -t timeout 300 /tmp/mmap-oom

  memory.high.throttle	service runtime
  --------------------	---------------
            0		    120.521
            1		    103.376
            2		     85.881
            3		     69.698
            4		     42.668
            5		     45.782
            6		     22.179
            7		      9.909
            8		      5.347
            9		      3.100
           10		      1.757
           11		      1.084
           12		      0.919
           13		      0.650
           14		      0.650
           15		      0.655

[1] https://docs.google.com/document/d/1mY0MTT34P-Eyv5G1t_Pqs4OWyIH-cg9caRKWmqYlSbI/edit?tab=t.0

Signed-off-by: Waiman Long <longman@redhat.com>
---
 Documentation/admin-guide/cgroup-v2.rst | 16 ++++++++--
 include/linux/memcontrol.h              |  2 ++
 mm/memcontrol.c                         | 41 +++++++++++++++++++++++++
 3 files changed, 57 insertions(+), 2 deletions(-)

diff --git a/Documentation/admin-guide/cgroup-v2.rst b/Documentation/admin-guide/cgroup-v2.rst
index cb1b4e759b7e..df9410ad8b3b 100644
--- a/Documentation/admin-guide/cgroup-v2.rst
+++ b/Documentation/admin-guide/cgroup-v2.rst
@@ -1291,8 +1291,20 @@ PAGE_SIZE multiple when read back.
 	Going over the high limit never invokes the OOM killer and
 	under extreme conditions the limit may be breached. The high
 	limit should be used in scenarios where an external process
-	monitors the limited cgroup to alleviate heavy reclaim
-	pressure.
+	monitors the limited cgroup to alleviate heavy reclaim pressure
+	unless a high enough value is set in "memory.high.throttle".
+
+  memory.high.throttle
+	A read-write single value file which exists on non-root
+	cgroups.  The default is 0.
+
+	Memory usage throttle control.	This value controls the amount
+	of throttling that will be applied when memory consumption
+	exceeds the "memory.high" limit.  The larger the value is,
+	the smaller the amount of throttling will be and the easier an
+	offending application may get OOM killed.
+
+	The valid range of this control file is 0-32.
 
   memory.max
 	A read-write single value file which exists on non-root
diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index 6e74b8254d9b..b184d7b008d4 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -199,6 +199,8 @@ struct mem_cgroup {
 	struct list_head swap_peaks;
 	spinlock_t	 peaks_lock;
 
+	int high_throttle_shift;
+
 	/* Range enforcement for interrupt charges */
 	struct work_struct high_work;
 
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 46f8b372d212..2fa3fd99ebc9 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -2112,6 +2112,7 @@ void mem_cgroup_handle_over_high(gfp_t gfp_mask)
 	unsigned long nr_reclaimed;
 	unsigned int nr_pages = current->memcg_nr_pages_over_high;
 	int nr_retries = MAX_RECLAIM_RETRIES;
+	int throttle_shift;
 	struct mem_cgroup *memcg;
 	bool in_retry = false;
 
@@ -2156,6 +2157,13 @@ void mem_cgroup_handle_over_high(gfp_t gfp_mask)
 	penalty_jiffies += calculate_high_delay(memcg, nr_pages,
 						swap_find_max_overage(memcg));
 
+	/*
+	 * Reduce penalty according to the high_throttle_shift value.
+	 */
+	throttle_shift = READ_ONCE(memcg->high_throttle_shift);
+	if (throttle_shift)
+		penalty_jiffies >>= throttle_shift;
+
 	/*
 	 * Clamp the max delay per usermode return so as to still keep the
 	 * application moving forwards and also permit diagnostics, albeit
@@ -4172,6 +4180,33 @@ static ssize_t memory_max_write(struct kernfs_open_file *of,
 	return nbytes;
 }
 
+static u64 memory_high_throttle_read(struct cgroup_subsys_state *css,
+				     struct cftype *cft)
+{
+	struct mem_cgroup *memcg = mem_cgroup_from_css(css);
+
+	return READ_ONCE(memcg->high_throttle_shift);
+}
+
+static ssize_t memory_high_throttle_write(struct kernfs_open_file *of,
+				char *buf, size_t nbytes, loff_t off)
+{
+	struct mem_cgroup *memcg = mem_cgroup_from_css(of_css(of));
+	u64 val;
+	int err;
+
+	buf = strstrip(buf);
+	err = kstrtoull(buf, 10, &val);
+	if (err)
+		return err;
+
+	if (val > 32)
+		return -EINVAL;
+
+	WRITE_ONCE(memcg->high_throttle_shift, (int)val);
+	return nbytes;
+}
+
 /*
  * Note: don't forget to update the 'samples/cgroup/memcg_event_listener'
  * if any new events become available.
@@ -4396,6 +4431,12 @@ static struct cftype memory_files[] = {
 		.seq_show = memory_high_show,
 		.write = memory_high_write,
 	},
+	{
+		.name = "high.throttle",
+		.flags = CFTYPE_NOT_ON_ROOT,
+		.read_u64 = memory_high_throttle_read,
+		.write = memory_high_throttle_write,
+	},
 	{
 		.name = "max",
 		.flags = CFTYPE_NOT_ON_ROOT,
-- 
2.48.1


