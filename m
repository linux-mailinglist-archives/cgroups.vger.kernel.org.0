Return-Path: <cgroups+bounces-15574-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qEsPDGMO9GmJ+AEAu9opvQ
	(envelope-from <cgroups+bounces-15574-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Fri, 01 May 2026 04:22:27 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CF19A4A9CBB
	for <lists+cgroups@lfdr.de>; Fri, 01 May 2026 04:22:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2566E30305E3
	for <lists+cgroups@lfdr.de>; Fri,  1 May 2026 02:21:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 881B52EAB82;
	Fri,  1 May 2026 02:21:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="vzRjGgtu"
X-Original-To: cgroups@vger.kernel.org
Received: from out-189.mta0.migadu.com (out-189.mta0.migadu.com [91.218.175.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D80A12EACEF
	for <cgroups@vger.kernel.org>; Fri,  1 May 2026 02:21:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777602090; cv=none; b=gD9snsYg/P5zXvyXtB2cMbalfdkHQv8KxwLYL44pbsfxZFyBB6bhgY9bzolg9RSZq0lltpg1f174QbPrAz1K/EykmHEd2Ay0IaHQS5tsfdtxlWDYn4UrQBBHr45301RkoYWaOv55Y0xUzOn7s6MI5ygnN5LSF3ujd5KaFPoRbkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777602090; c=relaxed/simple;
	bh=85yqVfc9aiA3OqKgXtUAbwLO/KOrXwWM03KlTyAOUow=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hJXrZTE0HG4smH8Xc/xqhZi5J8RsrokUNhuvviE5b4F/m4sTiczpzLd4ZD0qOHCdbKwqDWGjkWGLqykg18MxnR9qQ//8+svYKS/GEEQbBGGOTtevr2OmSUJa153wSWFSbjTdxjgh7l2GPr1aYnXTYHh1ue0r3SXLAYZvNUym9Ro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=vzRjGgtu; arc=none smtp.client-ip=91.218.175.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1777602086;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=O2N4+x1Sn+wQRdLiVZolUUHuNzDmAcEVcLCFnksgkqM=;
	b=vzRjGgtuFJ1JAtGsc21WhF7K4u4Px7oOGVVXWwhcVFAaoFiF4WrwGixClRcwplk3TT/yOA
	YKlrafWQIZddgGjYIzxPPtgfc9+svL48E8wXWBqVqG+/JNkB9NSt/0BLp+9ktmyYGf4BR0
	//dM0MNYWNijWA4/VQynOLmUvtjXGQg=
From: Li Wang <li.wang@linux.dev>
To: akpm@linux-foundation.org,
	hannes@cmpxchg.org,
	mhocko@kernel.org,
	roman.gushchin@linux.dev,
	shakeel.butt@linux.dev,
	muchun.song@linux.dev,
	tj@kernel.org,
	mkoutny@suse.com,
	shuah@kernel.org
Cc: cgroups@vger.kernel.org,
	linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Waiman Long <longman@redhat.com>,
	Christoph Lameter <cl@linux.com>,
	Shakeel Butt <shakeelb@google.com>,
	Vlastimil Babka <vbabka@suse.cz>
Subject: [PATCH v2 2/2] selftests/cgroup: include slab in test_percpu_basic memory check
Date: Fri,  1 May 2026 10:20:58 +0800
Message-ID: <20260501022058.18024-3-li.wang@linux.dev>
In-Reply-To: <20260501022058.18024-1-li.wang@linux.dev>
References: <20260501022058.18024-1-li.wang@linux.dev>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Queue-Id: CF19A4A9CBB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-15574-lists,cgroups=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	RCVD_COUNT_THREE(0.00)[3];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[li.wang@linux.dev,cgroups@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linux.dev:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[cgroups];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linux.dev:email,linux.dev:dkim,linux.dev:mid,linux.com:email,suse.cz:email]

test_percpu_basic() currently compares memory.current against only
memory.stat:percpu after creating 1000 child cgroups.

Observed failure:
  #./test_kmem
  ok 1 test_kmem_basic
  ok 2 test_kmem_memcg_deletion
  ok 3 test_kmem_proc_kpagecgroup
  ok 4 test_kmem_kernel_stacks
  ok 5 test_kmem_dead_cgroups
  memory.current 11530240
  percpu 8440000
  not ok 6 test_percpu_basic

That assumption is too strict: child cgroup creation also allocates
slab-backed metadata, so memory.current is expected to be larger than
percpu alone. One visible path is:

  cgroup_mkdir()
    cgroup_create()
      cgroup_addrm_file()
        cgroup_add_file()
          __kernfs_create_file()
            __kernfs_new_node()
              kmem_cache_zalloc()

These kernfs allocations are charged as slab and show up in
memory.stat:slab.

Update the check to compare memory.current against (percpu + slab)
within MAX_VMSTAT_ERROR, and print slab/delta in the failure message to
improve diagnostics.

Signed-off-by: Li Wang <li.wang@linux.dev>
Cc: Waiman Long <longman@redhat.com>
Cc: Christoph Lameter <cl@linux.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>
Cc: Michal Hocko <mhocko@kernel.org>
Cc: Shakeel Butt <shakeelb@google.com>
Cc: Tejun Heo <tj@kernel.org>
Cc: Vlastimil Babka <vbabka@suse.cz>
Reviewed-by: Waiman Long <longman@redhat.com>
---
 tools/testing/selftests/cgroup/test_kmem.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/tools/testing/selftests/cgroup/test_kmem.c b/tools/testing/selftests/cgroup/test_kmem.c
index 249d7911306..4b579969889 100644
--- a/tools/testing/selftests/cgroup/test_kmem.c
+++ b/tools/testing/selftests/cgroup/test_kmem.c
@@ -353,7 +353,7 @@ static int test_percpu_basic(const char *root)
 {
 	int ret = KSFT_FAIL;
 	char *parent, *child;
-	long current, percpu;
+	long current, percpu, slab;
 	int i;
 
 	parent = cg_name(root, "percpu_basic_test");
@@ -379,13 +379,14 @@ static int test_percpu_basic(const char *root)
 
 	current = cg_read_long(parent, "memory.current");
 	percpu = cg_read_key_long(parent, "memory.stat", "percpu ");
+	slab = cg_read_key_long(parent, "memory.stat", "slab ");
 
-	if (current > 0 && percpu > 0 && labs(current - percpu) <
-	    MAX_VMSTAT_ERROR)
+	if (current > 0 && percpu > 0 && slab >= 0 &&
+			labs(current - (percpu + slab)) < MAX_VMSTAT_ERROR)
 		ret = KSFT_PASS;
 	else
-		printf("memory.current %ld\npercpu %ld\n",
-		       current, percpu);
+		printf("memory.current %ld\npercpu %ld\nslab %ld\ndelta %ld\n",
+			current, percpu, slab, current - (percpu + slab));
 
 cleanup_children:
 	for (i = 0; i < 1000; i++) {
-- 
2.54.0


