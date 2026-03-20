Return-Path: <cgroups+bounces-14972-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2AsLKsuxvWlBAgMAu9opvQ
	(envelope-from <cgroups+bounces-14972-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Fri, 20 Mar 2026 21:44:59 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C2F52E0F7E
	for <lists+cgroups@lfdr.de>; Fri, 20 Mar 2026 21:44:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 172A63066CD2
	for <lists+cgroups@lfdr.de>; Fri, 20 Mar 2026 20:43:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A06EF363C4B;
	Fri, 20 Mar 2026 20:43:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CPt+5TIC"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDA7D363094
	for <cgroups@vger.kernel.org>; Fri, 20 Mar 2026 20:43:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774039404; cv=none; b=TjbxOdAjAhlr2XJZP4CHW3b8LpuYOQ7AWbBm1KwFepuWSx8o9r8F0YzBB438bVpwD3KXkAVY9+WtHK5Qn0kQXLEa+TgpoF+DZxAsKudJ+6mU5GGyXDo8cM7f/4/+47ZoD4t96T+7pdsrl1jtcNda0/6cVQvFKhr13OgIj9bFzBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774039404; c=relaxed/simple;
	bh=UtguZUieBxV/7vI26O4/Kz9+NfCIO8pO0P8TNbJBYFE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rhu5YVfb1QaDTkPKQE//ekxcQAFPY25IOBnu4KpTKNHbb4ExlCecWUuB+bXr0xfVFkxKxfNlPRwew7PLB8uwpJf8g9Prx032FFIYNx1CwyDc9vUgz8fXX2a5bZFsF18JcNGr8dChyHNUUsYg70MX4LdRGaFrGI9fa+kPVGQGi8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CPt+5TIC; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1774039401;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JO4fo5puVhwmWSTN9p22d3bjrul0eBuHqiTy66++5S4=;
	b=CPt+5TICRJ0f/TL2X4rP/dyJPibXmALBSZcSpCThbM6CWbiGkG7oSv0xot3RnhKOPySd6n
	nSqoKqt3kV0xpZprbZrE5KJkkY0Vx4tRp/cxrAkXhUaBTOXx7utQ1Y53KqfWNdkHIL5ded
	SeZ518Gf+XIvhKI2SzUr+5N5ikHn63U=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-120-i9oc_bP8ODSUAob25PNTlw-1; Fri,
 20 Mar 2026 16:43:17 -0400
X-MC-Unique: i9oc_bP8ODSUAob25PNTlw-1
X-Mimecast-MFC-AGG-ID: i9oc_bP8ODSUAob25PNTlw_1774039395
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id DAB3918005BB;
	Fri, 20 Mar 2026 20:43:14 +0000 (UTC)
Received: from llong-thinkpadp16vgen1.westford.csb (unknown [10.22.65.139])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 6E3CB180075C;
	Fri, 20 Mar 2026 20:43:11 +0000 (UTC)
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
Subject: [PATCH v2 5/7] selftests: memcg: Reduce the expected swap.peak with larger page size
Date: Fri, 20 Mar 2026 16:42:39 -0400
Message-ID: <20260320204241.1613861-6-longman@redhat.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,kvack.org,google.com,gmail.com,kylinos.cn,redhat.com];
	RCPT_COUNT_TWELVE(0.00)[20];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-14972-lists,cgroups=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 3C2F52E0F7E
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
index c078fc458def..3832ded1e47b 100644
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


