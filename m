Return-Path: <cgroups+bounces-14921-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KD5FE302vGl3uwIAu9opvQ
	(envelope-from <cgroups+bounces-14921-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Thu, 19 Mar 2026 18:46:37 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A3AAE2D03CE
	for <lists+cgroups@lfdr.de>; Thu, 19 Mar 2026 18:46:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 194E8326202A
	for <lists+cgroups@lfdr.de>; Thu, 19 Mar 2026 17:41:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8602038F939;
	Thu, 19 Mar 2026 17:39:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="c74EOEhF"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7653839150A
	for <cgroups@vger.kernel.org>; Thu, 19 Mar 2026 17:39:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773941962; cv=none; b=UTRqcd6PcJR9n948mwHw685s0lD+EUGqbDclNk2BaqtMOvqN18xJscqaCzVy4oc0BL14rzxvkNZswc7D2MrB52GpulBTYUYnTdT+1xl40ApsJ23EBFdGry0KlcFqkq4z98CcsznXCMCl+M+mj/CL/joLmDj1sYiW7EaS4Nj8d4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773941962; c=relaxed/simple;
	bh=nxAjAjAgP+lCo3v+SKq8jvMRzDUk+BwOWF50IkkWiZc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Fotom8vhK25a+yHFTkM+c04gL3cdJTZcqoI1kOZj7L2bhe6o5Jkp4vFVnUIXRl192rnRjSV4J4y175hZzFqvqc0az7MXYkImya1ppSj5o1XCxltJi2+V/JVbh6hzvxv4RxJwompxAigF2eQJZfRXXpbwqW/g9CDWFDa+BZtbcTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=c74EOEhF; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1773941953;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zkUulf/dklOOtLe7ygalmkfZiPOwnIaF4ZwIQQPoF50=;
	b=c74EOEhFY26gD/pSfhuOPbFpMlWZGIU9DEFs9oQqyYPjVa1kLBDC4Q/3ozg8UIi60L3/QH
	Q61lj+Lfu05K8EjEeVe49rXJMcDm4kcdLREAZ+0mmvfCtNh2lIBKw2xf51vIUZ0jZLymzV
	pHqKQNfbRH21VTryPOgv+5JnsxWb50c=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-611-HIcTViPWP_quBmhI6xe-QA-1; Thu,
 19 Mar 2026 13:39:08 -0400
X-MC-Unique: HIcTViPWP_quBmhI6xe-QA-1
X-Mimecast-MFC-AGG-ID: HIcTViPWP_quBmhI6xe-QA_1773941946
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id CB044195607B;
	Thu, 19 Mar 2026 17:39:05 +0000 (UTC)
Received: from llong-thinkpadp16vgen1.westford.csb (unknown [10.22.80.194])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id C4BCD30001A1;
	Thu, 19 Mar 2026 17:39:02 +0000 (UTC)
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
Subject: [PATCH 5/7] selftests: memcg: Reduce the expected swap.peak with larger page size
Date: Thu, 19 Mar 2026 13:37:50 -0400
Message-ID: <20260319173752.1472864-6-longman@redhat.com>
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
	TAGGED_FROM(0.00)[bounces-14921-lists,cgroups=lfdr.de];
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
	NEURAL_HAM(-0.00)[-0.960];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: A3AAE2D03CE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

When running the test_memcg_swap_max_peak test which sets swap.max
to 30M on an arm64 system with 64k page size, the test failed as the
swap.peak could only reach up only to 27,328,512 bytes (about 25.45
MB which is lower than the expected 29M) before the allocating task
got oom-killed.

It is likely due to the fact that it takes longer to write out a larger
page to swap and hence a lower swap.peak is being reached. Setting
memory.high to 29M to throttle memory allocation when nearing memory.max
helps, but it still could only reach up to 29,032,448 bytes (about
27.04M). As a result, we have to reduce the expected swap.peak with
larger page size. Now swap.peak is expected to reach only 27M with 64k
page, 29M with 4k page and 28M with 16k page.

Signed-off-by: Waiman Long <longman@redhat.com>
---
 .../selftests/cgroup/test_memcontrol.c        | 26 ++++++++++++++++---
 1 file changed, 22 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/cgroup/test_memcontrol.c b/tools/testing/selftests/cgroup/test_memcontrol.c
index 2c3a838536ae..4f12d4b4f9f8 100644
--- a/tools/testing/selftests/cgroup/test_memcontrol.c
+++ b/tools/testing/selftests/cgroup/test_memcontrol.c
@@ -1032,6 +1032,7 @@ static int test_memcg_swap_max_peak(const char *root)
 	char *memcg;
 	long max, peak;
 	struct stat ss;
+	long swap_peak;
 	int swap_peak_fd = -1, mem_peak_fd = -1;
 
 	/* any non-empty string resets */
@@ -1119,6 +1120,23 @@ static int test_memcg_swap_max_peak(const char *root)
 	if (cg_write(memcg, "memory.max", "30M"))
 		goto cleanup;
 
+	/*
+	 * The swap.peak that can be reached will depend on the system page
+	 * size. With larger page size (e.g. 64k), it takes more time to write
+	 * the anonymous memory page to swap and so the peak reached will be
+	 * lower before the memory allocation process get oom-killed. One way
+	 * to allow the swap.peak to go higher is to throttle memory allocation
+	 * by setting memory.high to, say, 29M to give more time to swap out the
+	 * memory before oom-kill. This is still not enough for it to reach
+	 * 29M reachable with 4k page. So we still need to reduce the expected
+	 * swap.peak accordingly.
+	 */
+	swap_peak = (page_size == KB(4)) ? MB(29) :
+		   ((page_size <= KB(16)) ? MB(28) : MB(27));
+
+	if (cg_write(memcg, "memory.high", "29M"))
+		goto cleanup;
+
 	/* Should be killed by OOM killer */
 	if (!cg_run(memcg, alloc_anon, (void *)MB(100)))
 		goto cleanup;
@@ -1134,7 +1152,7 @@ static int test_memcg_swap_max_peak(const char *root)
 		goto cleanup;
 
 	peak = cg_read_long(memcg, "memory.swap.peak");
-	if (peak < MB(29))
+	if (peak < swap_peak)
 		goto cleanup;
 
 	peak = cg_read_long_fd(mem_peak_fd);
@@ -1142,7 +1160,7 @@ static int test_memcg_swap_max_peak(const char *root)
 		goto cleanup;
 
 	peak = cg_read_long_fd(swap_peak_fd);
-	if (peak < MB(29))
+	if (peak < swap_peak)
 		goto cleanup;
 
 	/*
@@ -1181,7 +1199,7 @@ static int test_memcg_swap_max_peak(const char *root)
 	if (cg_read_long(memcg, "memory.peak") < MB(29))
 		goto cleanup;
 
-	if (cg_read_long(memcg, "memory.swap.peak") < MB(29))
+	if (cg_read_long(memcg, "memory.swap.peak") < swap_peak)
 		goto cleanup;
 
 	if (cg_run(memcg, alloc_anon_50M_check_swap, (void *)MB(30)))
@@ -1196,7 +1214,7 @@ static int test_memcg_swap_max_peak(const char *root)
 		goto cleanup;
 
 	peak = cg_read_long(memcg, "memory.swap.peak");
-	if (peak < MB(29))
+	if (peak < swap_peak)
 		goto cleanup;
 
 	peak = cg_read_long_fd(mem_peak_fd);
-- 
2.53.0


