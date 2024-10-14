Return-Path: <cgroups+bounces-5111-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AC1D299C7DC
	for <lists+cgroups@lfdr.de>; Mon, 14 Oct 2024 13:00:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4ABDBB22A5C
	for <lists+cgroups@lfdr.de>; Mon, 14 Oct 2024 11:00:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C98C19E802;
	Mon, 14 Oct 2024 10:59:38 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BEEE19DF45;
	Mon, 14 Oct 2024 10:59:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728903578; cv=none; b=qdwR+xld8jCMrM2gqkRm8aGVzPuTmeNSvVFYIzRDxr0bQsGnVJPFhrqwXRUk9AtIXu9jRVJmvX9V4HIRi0I6iYUX/SLszmtmtfcVyPMAfsg8LefDlIzCQM0ROg2/tyq7GrtivmigHJyfTMLyMwI4e5MATxuKbK3LbXJkfLJM2TU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728903578; c=relaxed/simple;
	bh=JMbTheclkDGS3S+GfD49eNwXVSfxy8z1/0qKFhP2pcQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lJz3lfAMed96MxFW+5/58j5+oOhlk9lqFGLjEMhXNEOtkJkJhwyxMaj63A99fAE7fVIpHRQrSOGDGmi4kLbFMEnyuKqI2yckvNn6hg6xygf1JfKRJMHrMRbWfxx26bUIv51F0Rsjlx7rpgg4wiGNGPczW21e5XjpZgVZKnfk8LA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8FB151424;
	Mon, 14 Oct 2024 04:00:05 -0700 (PDT)
Received: from e125769.cambridge.arm.com (e125769.cambridge.arm.com [10.1.196.27])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E9C283F51B;
	Mon, 14 Oct 2024 03:59:32 -0700 (PDT)
From: Ryan Roberts <ryan.roberts@arm.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	Anshuman Khandual <anshuman.khandual@arm.com>,
	Ard Biesheuvel <ardb@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	David Hildenbrand <david@redhat.com>,
	Greg Marsden <greg.marsden@oracle.com>,
	Ivan Ivanov <ivan.ivanov@suse.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Kalesh Singh <kaleshsingh@google.com>,
	Marc Zyngier <maz@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Matthias Brugger <mbrugger@suse.com>,
	Michal Hocko <mhocko@kernel.org>,
	Miroslav Benes <mbenes@suse.cz>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Will Deacon <will@kernel.org>
Cc: Ryan Roberts <ryan.roberts@arm.com>,
	cgroups@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH v1 03/57] mm/memcontrol: Fix seq_buf size to save memory when PAGE_SIZE is large
Date: Mon, 14 Oct 2024 11:58:10 +0100
Message-ID: <20241014105912.3207374-3-ryan.roberts@arm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241014105912.3207374-1-ryan.roberts@arm.com>
References: <20241014105514.3206191-1-ryan.roberts@arm.com>
 <20241014105912.3207374-1-ryan.roberts@arm.com>
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
64K page system, so we can save 60K om the static buffer used in
mem_cgroup_print_oom_meminfo(). Let's make it so.

This also has the beneficial side effect of removing a place in the code
that assumed PAGE_SIZE is a compile-time constant. So this helps our
quest towards supporting boot-time page size selection.

Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
---

***NOTE***
Any confused maintainers may want to read the cover note here for context:
https://lore.kernel.org/all/20241014105514.3206191-1-ryan.roberts@arm.com/

 mm/memcontrol.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index d563fb515766b..c5f9195f76c65 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -95,6 +95,7 @@ static DECLARE_WAIT_QUEUE_HEAD(memcg_cgwb_frn_waitq);
 
 #define THRESHOLDS_EVENTS_TARGET 128
 #define SOFTLIMIT_EVENTS_TARGET 1024
+#define SEQ_BUF_SIZE		SZ_4K
 
 static inline bool task_is_dying(void)
 {
@@ -1519,7 +1520,7 @@ void mem_cgroup_print_oom_context(struct mem_cgroup *memcg, struct task_struct *
 void mem_cgroup_print_oom_meminfo(struct mem_cgroup *memcg)
 {
 	/* Use static buffer, for the caller is holding oom_lock. */
-	static char buf[PAGE_SIZE];
+	static char buf[SEQ_BUF_SIZE];
 	struct seq_buf s;
 
 	lockdep_assert_held(&oom_lock);
@@ -1545,7 +1546,7 @@ void mem_cgroup_print_oom_meminfo(struct mem_cgroup *memcg)
 	pr_info("Memory cgroup stats for ");
 	pr_cont_cgroup_path(memcg->css.cgroup);
 	pr_cont(":");
-	seq_buf_init(&s, buf, sizeof(buf));
+	seq_buf_init(&s, buf, SEQ_BUF_SIZE);
 	memory_stat_format(memcg, &s);
 	seq_buf_do_printk(&s, KERN_INFO);
 }
@@ -4158,12 +4159,12 @@ static int memory_events_local_show(struct seq_file *m, void *v)
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


