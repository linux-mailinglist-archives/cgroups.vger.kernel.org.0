Return-Path: <cgroups+bounces-13886-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uDWLOx6OjWl54QAAu9opvQ
	(envelope-from <cgroups+bounces-13886-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Thu, 12 Feb 2026 09:23:58 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EFA112B398
	for <lists+cgroups@lfdr.de>; Thu, 12 Feb 2026 09:23:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 0C85A30331DA
	for <lists+cgroups@lfdr.de>; Thu, 12 Feb 2026 08:23:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E43192D5C86;
	Thu, 12 Feb 2026 08:23:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="TDKuVggx"
X-Original-To: cgroups@vger.kernel.org
Received: from out-186.mta1.migadu.com (out-186.mta1.migadu.com [95.215.58.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B45CF29DB65
	for <cgroups@vger.kernel.org>; Thu, 12 Feb 2026 08:23:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770884634; cv=none; b=kRw03+ClUgDycYXZyXBJW1t/dnbBuHNxUTXAvZX2FwxYz6FM56DJo48XmSDzALZ4nlcXM2qmZEzm8yclFu/42UlXBPeI4laqFys4oc4yhLxBAJe+2gAAOWvu9WSVItgd9+ykYmKZOKiSb29lwd5dIb1d/hbBYJ39qocGkPpflvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770884634; c=relaxed/simple;
	bh=9oiwq5b/PMLGO5TFSs8W4xMUf5GGnvMwLUvLVmePqIg=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mrqtKO0Gu3Wmv4MS8XZYmhl1rDBH2rBZUix+ZNxx4yMzQu10LqELO4ijyozSMxL1axEAJRIRo8ocUfGnHFckTF6xM6Mudww4yNO/Nxv14dOEMjJqPcYOcWVRGVi7fDacgrB2MGgxjTsGvKCKV8nRqI4jQ8yPcXHRsjHxuX4Zaww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=TDKuVggx; arc=none smtp.client-ip=95.215.58.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1770884630;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=crYbU+ThqI1KboSIh+EReNJtidB4zxhxhtyNUFlO0rY=;
	b=TDKuVggxscYGSctBSiDWdBR38fcvT+Z3PytbqBFCVFWT9qlg6PqmrB3xUNFaLH/XhUnQ0V
	/cNlB+mkcXUIsmjYfm600iLmjAGnPJAZe3pq7FPg8OY0WRq6FSaPe0IjxmUObaf1pjtqLO
	L5j2gXzjnb1A/e/bJWzIh5DBJ9GmIzg=
From: Hui Zhu <hui.zhu@linux.dev>
To: Johannes Weiner <hannes@cmpxchg.org>,
	Michal Hocko <mhocko@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Muchun Song <muchun.song@linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	Hui Zhu <zhuhui@kylinos.cn>,
	JP Kobryn <inwardvessel@gmail.com>,
	cgroups@vger.kernel.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH bpf-next 1/3] selftests/bpf: Check bpf_mem_cgroup_page_state return value
Date: Thu, 12 Feb 2026 16:23:14 +0800
Message-ID: <042df9438d9e78bcd66f1fa0e7043b9ea8cda96c.1770883926.git.zhuhui@kylinos.cn>
In-Reply-To: <cover.1770883926.git.zhuhui@kylinos.cn>
References: <cover.1770883926.git.zhuhui@kylinos.cn>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-13886-lists,cgroups=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[26];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[cmpxchg.org,kernel.org,linux.dev,linux-foundation.org,iogearbox.net,gmail.com,fomichev.me,google.com,kylinos.cn,vger.kernel.org,kvack.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hui.zhu@linux.dev,cgroups@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linux.dev:+];
	PRECEDENCE_BULK(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[cgroups];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,linux.dev:dkim,kylinos.cn:mid,kylinos.cn:email]
X-Rspamd-Queue-Id: 4EFA112B398
X-Rspamd-Action: no action

From: Hui Zhu <zhuhui@kylinos.cn>

When back-porting test_progs to different kernel versions, I encountered
an issue where the test_cgroup_iter_memcg test would falsely pass even
when bpf_mem_cgroup_page_state() failed.

The problem occurs when test_progs compiled on one kernel version is
executed on another kernel with different enum values for memory
statistics (e.g., NR_ANON_MAPPED, NR_FILE_PAGES). In such cases,
bpf_mem_cgroup_page_state() returns -1 to indicate failure, but the test
didn't check for this error condition and incorrectly reported success.

This patch adds explicit checks to ensure bpf_mem_cgroup_page_state()
doesn't return -1 before validating the actual statistics values. This
prevents false positives when running test_progs in cross-kernel
environments.

Signed-off-by: Hui Zhu <zhuhui@kylinos.cn>
---
 .../selftests/bpf/prog_tests/cgroup_iter_memcg.c     | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/cgroup_iter_memcg.c b/tools/testing/selftests/bpf/prog_tests/cgroup_iter_memcg.c
index a5afd16705f0..13b299512429 100644
--- a/tools/testing/selftests/bpf/prog_tests/cgroup_iter_memcg.c
+++ b/tools/testing/selftests/bpf/prog_tests/cgroup_iter_memcg.c
@@ -53,6 +53,8 @@ static void test_anon(struct bpf_link *link, struct memcg_query *memcg_query)
 	if (!ASSERT_OK(read_stats(link), "read stats"))
 		goto cleanup;
 
+	ASSERT_NEQ(memcg_query->nr_anon_mapped, (unsigned long)-1,
+		  "bpf_mem_cgroup_page_state NR_ANON_MAPPED");
 	ASSERT_GT(memcg_query->nr_anon_mapped, 0, "final anon mapped val");
 
 cleanup:
@@ -88,6 +90,10 @@ static void test_file(struct bpf_link *link, struct memcg_query *memcg_query)
 	if (!ASSERT_OK(read_stats(link), "read stats"))
 		goto cleanup_map;
 
+	ASSERT_NEQ(memcg_query->nr_file_pages, (unsigned long)-1,
+		  "bpf_mem_cgroup_page_state NR_FILE_PAGES");
+	ASSERT_NEQ(memcg_query->nr_file_mapped, (unsigned long)-1,
+		  "bpf_mem_cgroup_page_state NR_FILE_MAPPED");
 	ASSERT_GT(memcg_query->nr_file_pages, 0, "final file value");
 	ASSERT_GT(memcg_query->nr_file_mapped, 0, "final file mapped value");
 
@@ -119,6 +125,8 @@ static void test_shmem(struct bpf_link *link, struct memcg_query *memcg_query)
 	if (!ASSERT_OK(read_stats(link), "read stats"))
 		goto cleanup;
 
+	ASSERT_NEQ(memcg_query->nr_shmem, (unsigned long)-1,
+		  "bpf_mem_cgroup_page_state NR_SHMEM");
 	ASSERT_GT(memcg_query->nr_shmem, 0, "final shmem value");
 
 cleanup:
@@ -143,6 +151,8 @@ static void test_kmem(struct bpf_link *link, struct memcg_query *memcg_query)
 	if (!ASSERT_OK(read_stats(link), "read stats"))
 		goto cleanup;
 
+	ASSERT_NEQ(memcg_query->memcg_kmem, (unsigned long)-1,
+		  "bpf_mem_cgroup_page_state MEMCG_KMEM");
 	ASSERT_GT(memcg_query->memcg_kmem, 0, "kmem value");
 
 cleanup:
@@ -170,6 +180,8 @@ static void test_pgfault(struct bpf_link *link, struct memcg_query *memcg_query)
 	if (!ASSERT_OK(read_stats(link), "read stats"))
 		goto cleanup;
 
+	ASSERT_NEQ(memcg_query->pgfault, (unsigned long)-1,
+		  "bpf_mem_cgroup_page_state PGFAULT");
 	ASSERT_GT(memcg_query->pgfault, 0, "final pgfault val");
 
 cleanup:
-- 
2.43.0


