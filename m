Return-Path: <cgroups+bounces-11586-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CC56C34587
	for <lists+cgroups@lfdr.de>; Wed, 05 Nov 2025 08:50:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9FE8C4F01D4
	for <lists+cgroups@lfdr.de>; Wed,  5 Nov 2025 07:50:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF98A2C3242;
	Wed,  5 Nov 2025 07:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shopee.com header.i=@shopee.com header.b="hdyMC+ls"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 002E02C21D3
	for <cgroups@vger.kernel.org>; Wed,  5 Nov 2025 07:49:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762329003; cv=none; b=sJPweBKH5lXIU8d6emGrHL5Oh65HKj8/5DmzFAQPGmPBfdPHxpsI01U856o8xzh5pyOf4iUjeNbEjAjku1nNoXIYQgFnjbFiOxmQv5xddyjoNWD8V+Yd0Ehx/FpGqIleTnmaTVEwHj1+AGXB5WekwofyMY8ctXRljgyUHbViBgc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762329003; c=relaxed/simple;
	bh=d9ZQQw6oADUCSvtmaACwRX9dnlraJPsGIprhB01RZmY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tqxiMSebAo2g8V49p21rXiHcF94RlCnQGWDPDxTHFpKU/yww6eYF2uyRtdFM2wdfnDC+Q4RgifMpFHsKvBWewESR4ZxZGfZzFZDZdwbbR87E1cEsDD3ZxdjUXJnPagcnffQFnhyZBKDlEBF43iaPS/ldETvyyyEEdyLIRlJ73Z0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=shopee.com; spf=pass smtp.mailfrom=shopee.com; dkim=pass (2048-bit key) header.d=shopee.com header.i=@shopee.com header.b=hdyMC+ls; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=shopee.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shopee.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-29555b384acso43252025ad.1
        for <cgroups@vger.kernel.org>; Tue, 04 Nov 2025 23:49:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shopee.com; s=shopee.com; t=1762328999; x=1762933799; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=h6ZDRkftaiRuIaXsVQnD3pYoLoBZQe+K8uOwtjlQzE0=;
        b=hdyMC+lsiHCSA7rW5Ei5YkvfU8qWhTBilQOeWTjMbTjhTOYjUg17IJLOjDduIteU0S
         aZvx5qG0AQ3MMkx+Bz94WUXHBIBq7q1pqP0k5injCIluZ2GQySZoUw7wCt41uTLK0LAd
         uxC5CV8Y8TVxmPlQZZnieik5cHsABrwGiBDO55F/K94pPzuK24KqJzogFoiifeVkWvqs
         XOb/WWUMz7nyxTQo9aNjpGddzOahTG8yTfWjcYWMDYoSWDZZFiJfGFMWJNAD95v2RYBa
         cCbe8oBQuzuVNln/CfFjt1FnC9t8e9iOKBK1k0KMt64kPC7pE+8jef74vu8GRbXnRS9L
         82pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762328999; x=1762933799;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=h6ZDRkftaiRuIaXsVQnD3pYoLoBZQe+K8uOwtjlQzE0=;
        b=JWj+Q6Pbpsg8H9ErTZfe8agDzt0mdAnsppvYTt7OwK1afNOC0/j9Y3QZrww4r4Yy+p
         m8fcy/V/9aNxEX3J7DEOZ0ETIAMAKRkQ+LnkkbPxO9KlcaOEEjcPbBbapeLCpeZ+CzpI
         gUen/aWiejDSnQR+VUMY68vP2ah6pK7Df8cd7iE4/0nVYQOcSGqRpisyMmkXcsH8HFpJ
         YHpevax1wgL0FjAM/kmvbRnenpIRZgihYxWSLUccI+s8hWrTHLfcjkX7hNVIJCC1+epE
         csO31v4ScnmJlZNm4QDE4oIIU7D0jdUFD4P8qdNw+U59+DyepVDUsidcPfmLPWZAIZSq
         8Hbw==
X-Forwarded-Encrypted: i=1; AJvYcCUlGe+XYgQcZhp1QXXxESp7XP0t0JuldzoF8JZDjKGgCCSDzHPkAe2TNS4VqSbxU8XbClzSwVX4@vger.kernel.org
X-Gm-Message-State: AOJu0YwSvCOQltAOyqcvqj3+hcAwEP1oN9XJZmJDPe/pX2Np75vWR01s
	lbnoNyQI8fbDo1ggMTOMTdsH/bgv78y7iglIgUCnCZ9I8iDMZnGku2sude9flbMhlRA=
X-Gm-Gg: ASbGncsugLxDtBSmsJ26ZXHHlDAxnjfFzP17OVr1jJnWxICeLujR57PRNmDDe3Zd1bV
	mbFSc5S2sKJ0oIH1+xe23BAE3wkpbeWf4RSi5xxxxNtkCa8qZeFR8Qf0Zq4UvGheJjCeNCUjkFP
	vHBgxD7IKHAdsAR6faEI32+rbqWr+cw7iU5NLCF+BrR4rUrBXD/2Fkk7MK/PJN9zO23A1W1aWrk
	u7mKKlyWpnJpLpXoU4fvtU/048dF6yjAJXJfKbrvAcy78w5Rw0pg9+o9oTvV3rIbRdrgy91CxX9
	lwixBhtaZr4Fm+NroM/DlA04aisB7nYDTlLxwMxL4/eGbztX3bwyr8STulpXMV2+OoiBPUPuPPq
	Wt/WixUrolIbVl6aUs4ykpZxKvjxwgk18AfQxB8i2AHKnQjqXN8aD8iE/YKeRiYE7S6w4MpeSB5
	VcLjq5aliB35R6000pybuJ8HBv
X-Google-Smtp-Source: AGHT+IHKjbv/6sAUPJqMP9Dl0+FTFfNEli/mX7VCSD5WGbBzuqeNeE5PeGE+njoNMn23lIVIEk6Frg==
X-Received: by 2002:a17:902:ef49:b0:295:4620:3e18 with SMTP id d9443c01a7336-2962ad2b255mr39869055ad.24.1762328999123;
        Tue, 04 Nov 2025 23:49:59 -0800 (PST)
Received: from .shopee.com ([122.11.166.8])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7acd6a10f8fsm5295564b3a.68.2025.11.04.23.49.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Nov 2025 23:49:58 -0800 (PST)
From: Leon Huang Fu <leon.huangfu@shopee.com>
To: linux-mm@kvack.org
Cc: hannes@cmpxchg.org,
	mhocko@kernel.org,
	roman.gushchin@linux.dev,
	shakeel.butt@linux.dev,
	muchun.song@linux.dev,
	akpm@linux-foundation.org,
	joel.granados@kernel.org,
	jack@suse.cz,
	laoar.shao@gmail.com,
	mclapinski@google.com,
	kyle.meyer@hpe.com,
	corbet@lwn.net,
	lance.yang@linux.dev,
	leon.huangfu@shopee.com,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	cgroups@vger.kernel.org
Subject: [PATCH mm-new v2] mm/memcontrol: Flush stats when write stat file
Date: Wed,  5 Nov 2025 15:49:16 +0800
Message-ID: <20251105074917.94531-1-leon.huangfu@shopee.com>
X-Mailer: git-send-email 2.51.2
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On high-core count systems, memory cgroup statistics can become stale
due to per-CPU caching and deferred aggregation. Monitoring tools and
management applications sometimes need guaranteed up-to-date statistics
at specific points in time to make accurate decisions.

This patch adds write handlers to both memory.stat and memory.numa_stat
files to allow userspace to explicitly force an immediate flush of
memory statistics. When "1" is written to either file, it triggers
__mem_cgroup_flush_stats(memcg, true), which unconditionally flushes
all pending statistics for the cgroup and its descendants.

The write operation validates the input and only accepts the value "1",
returning -EINVAL for any other input.

Usage example:
  # Force immediate flush before reading critical statistics
  echo 1 > /sys/fs/cgroup/mygroup/memory.stat
  cat /sys/fs/cgroup/mygroup/memory.stat

This provides several benefits:

1. On-demand accuracy: Tools can flush only when needed, avoiding
   continuous overhead

2. Targeted flushing: Allows flushing specific cgroups when precision
   is required for particular workloads

3. Integration flexibility: Monitoring scripts can decide when to pay
   the flush cost based on their specific accuracy requirements

The implementation is shared between cgroup v1 and v2 interfaces,
with memory_stat_write() providing the common validation and flush
logic. Both memory.stat and memory.numa_stat use the same write
handler since they both benefit from forcing accurate statistics.

Documentation is updated to reflect that these files are now read-write
instead of read-only, with clear explanation of the write behavior.

Signed-off-by: Leon Huang Fu <leon.huangfu@shopee.com>
---
v1 -> v2:
  - Flush stats when write the file (per Michal).
  - https://lore.kernel.org/linux-mm/20251104031908.77313-1-leon.huangfu@shopee.com/

 Documentation/admin-guide/cgroup-v2.rst | 31 +++++++++++++++++--------
 mm/memcontrol-v1.c                      |  2 ++
 mm/memcontrol-v1.h                      |  1 +
 mm/memcontrol.c                         | 13 +++++++++++
 4 files changed, 37 insertions(+), 10 deletions(-)

diff --git a/Documentation/admin-guide/cgroup-v2.rst b/Documentation/admin-guide/cgroup-v2.rst
index 3345961c30ac..2a4a81d2cc2f 100644
--- a/Documentation/admin-guide/cgroup-v2.rst
+++ b/Documentation/admin-guide/cgroup-v2.rst
@@ -1337,7 +1337,7 @@ PAGE_SIZE multiple when read back.
 	cgroup is within its effective low boundary, the cgroup's
 	memory won't be reclaimed unless there is no reclaimable
 	memory available in unprotected cgroups.
-	Above the effective low	boundary (or
+	Above the effective low	boundary (or
 	effective min boundary if it is higher), pages are reclaimed
 	proportionally to the overage, reducing reclaim pressure for
 	smaller overages.
@@ -1525,11 +1525,17 @@ The following nested keys are defined.
 	generated on this file reflects only the local events.

   memory.stat
-	A read-only flat-keyed file which exists on non-root cgroups.
+	A read-write flat-keyed file which exists on non-root cgroups.

-	This breaks down the cgroup's memory footprint into different
-	types of memory, type-specific details, and other information
-	on the state and past events of the memory management system.
+	Reading this file breaks down the cgroup's memory footprint into
+	different types of memory, type-specific details, and other
+	information on the state and past events of the memory management
+	system.
+
+	Writing the value "1" to this file forces an immediate flush of
+	memory statistics for this cgroup and its descendants, improving
+	the accuracy of subsequent reads. Any other value will result in
+	an error.

 	All memory amounts are in bytes.

@@ -1786,11 +1792,16 @@ The following nested keys are defined.
 		cgroup is mounted with the memory_hugetlb_accounting option).

   memory.numa_stat
-	A read-only nested-keyed file which exists on non-root cgroups.
+	A read-write nested-keyed file which exists on non-root cgroups.
+
+	Reading this file breaks down the cgroup's memory footprint into
+	different types of memory, type-specific details, and other
+	information per node on the state of the memory management system.

-	This breaks down the cgroup's memory footprint into different
-	types of memory, type-specific details, and other information
-	per node on the state of the memory management system.
+	Writing the value "1" to this file forces an immediate flush of
+	memory statistics for this cgroup and its descendants, improving
+	the accuracy of subsequent reads. Any other value will result in
+	an error.

 	This is useful for providing visibility into the NUMA locality
 	information within an memcg since the pages are allowed to be
@@ -2173,7 +2184,7 @@ of the two is enforced.

 cgroup writeback requires explicit support from the underlying
 filesystem.  Currently, cgroup writeback is implemented on ext2, ext4,
-btrfs, f2fs, and xfs.  On other filesystems, all writeback IOs are
+btrfs, f2fs, and xfs.  On other filesystems, all writeback IOs are
 attributed to the root cgroup.

 There are inherent differences in memory and writeback management
diff --git a/mm/memcontrol-v1.c b/mm/memcontrol-v1.c
index 6eed14bff742..8cab6b52424b 100644
--- a/mm/memcontrol-v1.c
+++ b/mm/memcontrol-v1.c
@@ -2040,6 +2040,7 @@ struct cftype mem_cgroup_legacy_files[] = {
 	{
 		.name = "stat",
 		.seq_show = memory_stat_show,
+		.write_u64 = memory_stat_write,
 	},
 	{
 		.name = "force_empty",
@@ -2078,6 +2079,7 @@ struct cftype mem_cgroup_legacy_files[] = {
 	{
 		.name = "numa_stat",
 		.seq_show = memcg_numa_stat_show,
+		.write_u64 = memory_stat_write,
 	},
 #endif
 	{
diff --git a/mm/memcontrol-v1.h b/mm/memcontrol-v1.h
index 6358464bb416..1c92d58330aa 100644
--- a/mm/memcontrol-v1.h
+++ b/mm/memcontrol-v1.h
@@ -29,6 +29,7 @@ void drain_all_stock(struct mem_cgroup *root_memcg);
 unsigned long memcg_events(struct mem_cgroup *memcg, int event);
 unsigned long memcg_page_state_output(struct mem_cgroup *memcg, int item);
 int memory_stat_show(struct seq_file *m, void *v);
+int memory_stat_write(struct cgroup_subsys_state *css, struct cftype *cft, u64 val);

 void mem_cgroup_id_get_many(struct mem_cgroup *memcg, unsigned int n);
 struct mem_cgroup *mem_cgroup_id_get_online(struct mem_cgroup *memcg);
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index c34029e92bab..d6a5d872fbcb 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -4531,6 +4531,17 @@ int memory_stat_show(struct seq_file *m, void *v)
 	return 0;
 }

+int memory_stat_write(struct cgroup_subsys_state *css, struct cftype *cft, u64 val)
+{
+	if (val != 1)
+		return -EINVAL;
+
+	if (css)
+		css_rstat_flush(css);
+
+	return 0;
+}
+
 #ifdef CONFIG_NUMA
 static inline unsigned long lruvec_page_state_output(struct lruvec *lruvec,
 						     int item)
@@ -4666,11 +4677,13 @@ static struct cftype memory_files[] = {
 	{
 		.name = "stat",
 		.seq_show = memory_stat_show,
+		.write_u64 = memory_stat_write,
 	},
 #ifdef CONFIG_NUMA
 	{
 		.name = "numa_stat",
 		.seq_show = memory_numa_stat_show,
+		.write_u64 = memory_stat_write,
 	},
 #endif
 	{
--
2.51.2


