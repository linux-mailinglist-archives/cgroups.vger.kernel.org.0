Return-Path: <cgroups+bounces-5170-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AFC39A6964
	for <lists+cgroups@lfdr.de>; Mon, 21 Oct 2024 15:00:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8A19A1C228FB
	for <lists+cgroups@lfdr.de>; Mon, 21 Oct 2024 13:00:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71BA11EF083;
	Mon, 21 Oct 2024 13:00:39 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CDF81D0F77;
	Mon, 21 Oct 2024 13:00:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729515639; cv=none; b=vGLnS9WF+R1KehPx3+M01LeOq9XkEfRFJVK8aGaCDWfefYUtdCnuDW9LMs3S6M60nAEIRosmoJY8stV+j2t7awnucoP7zIyfGUW5uWJE0ZCYYkrGm3grcKbmRn/CRGoSrYxG50QORtvAqiTOsZ3MnOz+C7R3RyHyv0/YhBTp6NM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729515639; c=relaxed/simple;
	bh=sAssCSQak9kO8zSxwQR4fD3toTlDyHCeyHZpYyBznQ4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XSAexGQC4lU2O8qoC0GaDyv7IM5hafYQg+C/IqRX6s5WqgTvUrUCFIo4DYdvGRnMEKVNTLyDMqd2zFT476XntOpboOSpExksmCVOtO4tGhLs4Za5r3QbezhQMS55eMSY9a+BLsafbSiG4j3ylYL24Hp9ev9MdJj6iMitPScXsYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1BF0DDA7;
	Mon, 21 Oct 2024 06:01:06 -0700 (PDT)
Received: from e125769.cambridge.arm.com (e125769.cambridge.arm.com [10.1.196.27])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C20A53F73B;
	Mon, 21 Oct 2024 06:00:34 -0700 (PDT)
From: Ryan Roberts <ryan.roberts@arm.com>
To: Johannes Weiner <hannes@cmpxchg.org>,
	Michal Hocko <mhocko@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Muchun Song <muchun.song@linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: Ryan Roberts <ryan.roberts@arm.com>,
	cgroups@vger.kernel.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Michal Hocko <mhocko@suse.com>
Subject: [PATCH v2] mm/memcontrol: Fix seq_buf size to save memory when PAGE_SIZE is large
Date: Mon, 21 Oct 2024 14:00:26 +0100
Message-ID: <20241021130027.3615969-1-ryan.roberts@arm.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Previously the seq_buf used for accumulating the memory.stat output was
sized at PAGE_SIZE. But the amount of output is invariant to PAGE_SIZE;
If 4K is enough on a 4K page system, then it should also be enough on a
64K page system, so we can save 60K on the static buffer used in
mem_cgroup_print_oom_meminfo(). Let's make it so.

This also has the beneficial side effect of removing a place in the code
that assumed PAGE_SIZE is a compile-time constant. So this helps our
quest towards supporting boot-time page size selection.

Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
Acked-by: Johannes Weiner <hannes@cmpxchg.org>
Acked-by: Shakeel Butt <shakeel.butt@linux.dev>
Acked-by: Michal Hocko <mhocko@suse.com>
Acked-by: Roman Gushchin <roman.gushchin@linux.dev>
---
 mm/memcontrol.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 17af08367c68..5c3a8629ef3e 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -118,6 +118,7 @@ struct mem_cgroup *vmpressure_to_memcg(struct vmpressure *vmpr)
 	return container_of(vmpr, struct mem_cgroup, vmpressure);
 }

+#define SEQ_BUF_SIZE SZ_4K
 #define CURRENT_OBJCG_UPDATE_BIT 0
 #define CURRENT_OBJCG_UPDATE_FLAG (1UL << CURRENT_OBJCG_UPDATE_BIT)

@@ -1527,7 +1528,7 @@ void mem_cgroup_print_oom_context(struct mem_cgroup *memcg, struct task_struct *
 void mem_cgroup_print_oom_meminfo(struct mem_cgroup *memcg)
 {
 	/* Use static buffer, for the caller is holding oom_lock. */
-	static char buf[PAGE_SIZE];
+	static char buf[SEQ_BUF_SIZE];
 	struct seq_buf s;

 	lockdep_assert_held(&oom_lock);
@@ -1553,7 +1554,7 @@ void mem_cgroup_print_oom_meminfo(struct mem_cgroup *memcg)
 	pr_info("Memory cgroup stats for ");
 	pr_cont_cgroup_path(memcg->css.cgroup);
 	pr_cont(":");
-	seq_buf_init(&s, buf, sizeof(buf));
+	seq_buf_init(&s, buf, SEQ_BUF_SIZE);
 	memory_stat_format(memcg, &s);
 	seq_buf_do_printk(&s, KERN_INFO);
 }
@@ -4194,12 +4195,12 @@ static int memory_events_local_show(struct seq_file *m, void *v)
 int memory_stat_show(struct seq_file *m, void *v)
 {
 	struct mem_cgroup *memcg = mem_cgroup_from_seq(m);
-	char *buf = kmalloc(PAGE_SIZE, GFP_KERNEL);
+	char *buf = kmalloc(SEQ_BUF_SIZE, GFP_KERNEL);
 	struct seq_buf s;

 	if (!buf)
 		return -ENOMEM;
-	seq_buf_init(&s, buf, PAGE_SIZE);
+	seq_buf_init(&s, buf, SEQ_BUF_SIZE);
 	memory_stat_format(memcg, &s);
 	seq_puts(m, buf);
 	kfree(buf);
--
2.43.0


