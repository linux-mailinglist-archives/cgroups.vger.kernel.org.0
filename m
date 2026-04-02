Return-Path: <cgroups+bounces-15161-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qP8mGO4QzmmnkgYAu9opvQ
	(envelope-from <cgroups+bounces-15161-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Thu, 02 Apr 2026 08:47:10 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DC8A384AB9
	for <lists+cgroups@lfdr.de>; Thu, 02 Apr 2026 08:47:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 3E778306911D
	for <lists+cgroups@lfdr.de>; Thu,  2 Apr 2026 06:38:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C7D531A567;
	Thu,  2 Apr 2026 06:38:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YOI0GoQh"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEEAA186284
	for <cgroups@vger.kernel.org>; Thu,  2 Apr 2026 06:38:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775111923; cv=none; b=F36iiIR8+qm8BgM/CRXwKLaV6GOMRILd4pMtX6dI9LEYoxoU8h5LIoThVP3V4Bdk43Xf4iRBhTdA++HTCBM9ijHK9PcmrEnyYcFyULxUB9EeGWyYyWVsUNRZ66HH7iE7YMDuGvtYmRbUXdU4RvMFflAB/cvPmoKqjhvaeBBlTIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775111923; c=relaxed/simple;
	bh=boH1xaT2FPFODLeR6LxaFpYzqqE3ZEfiJaiaWiseVoA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XoU3lj3kGoEztIEGtQIMafWND71ze7p2d49y8k7xLLG1DQMY/vKraPjeE2rqYHKRvPMWVYY6MvrmN52hyqZO+w2wGiknmHsCGKNeh/cbU4seaVq/oUafHoI1SryO8AEi31HLY7KK3PbvqLeDGpBgKbPVGTJA3wnxk9GWZhCKIQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YOI0GoQh; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1775111921;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FLyaDgFkfHvrMzV28TVPMgU6GEppSWS1kB1nw8OA6yE=;
	b=YOI0GoQhPCg6mof+pTC/p2pWAXzRdFlsKjEj7uQonrKvqFbkMDMKOtMdA6jVqmRgudcUPx
	9+LncR4Y8hC3mkUILfcr2U5CEGiK1YrHi9w80fRuKDm4wjQ1rPCMJXyIe63XCKH8uqmzXN
	ypOvVXxMHDBkWIiX9sqUWUAeQiHSMJg=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-396-6dIlcf2TPkS6AUr5eh3JIg-1; Thu,
 02 Apr 2026 02:38:36 -0400
X-MC-Unique: 6dIlcf2TPkS6AUr5eh3JIg-1
X-Mimecast-MFC-AGG-ID: 6dIlcf2TPkS6AUr5eh3JIg_1775111914
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 160021956096;
	Thu,  2 Apr 2026 06:38:34 +0000 (UTC)
Received: from fedora-laptop-x1.redhat.com (unknown [10.72.112.158])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A83B01800351;
	Thu,  2 Apr 2026 06:38:25 +0000 (UTC)
From: Li Wang <liwang@redhat.com>
To: akpm@linux-foundation.org,
	rppt@kernel.org,
	david@kernel.org,
	hannes@cmpxchg.org,
	yosry@kernel.org,
	ljs@kernel.org,
	Liam.Howlett@oracle.com,
	mhocko@suse.com,
	shuah@kernel.org,
	chengming.zhou@linux.dev,
	longman@redhat.com,
	nphamcs@gmail.com
Cc: linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	cgroups@vger.kernel.org,
	Michal Hocko <mhocko@kernel.org>,
	=?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>,
	Muchun Song <muchun.song@linux.dev>,
	Tejun Heo <tj@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Shakeel Butt <shakeel.butt@linux.dev>
Subject: [PATCH v6 7/8] selftest/cgroup: fix zswap attempt_writeback() on 64K pagesize system
Date: Thu,  2 Apr 2026 14:37:13 +0800
Message-ID: <20260402063714.55124-8-liwang@redhat.com>
In-Reply-To: <20260402063714.55124-1-liwang@redhat.com>
References: <20260402063714.55124-1-liwang@redhat.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-15161-lists,cgroups=lfdr.de];
	FREEMAIL_TO(0.00)[linux-foundation.org,kernel.org,cmpxchg.org,oracle.com,suse.com,linux.dev,redhat.com,gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[22];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[liwang@redhat.com,cgroups@vger.kernel.org];
	DKIM_TRACE(0.00)[redhat.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TAGGED_RCPT(0.00)[cgroups];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,cmpxchg.org:email,linux.dev:email]
X-Rspamd-Queue-Id: 5DC8A384AB9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

In attempt_writeback(), a memsize of 4M only covers 64 pages on 64K
page size systems. When memory.reclaim is called, the kernel prefers
reclaiming clean file pages (binary, libc, linker, etc.) over swapping
anonymous pages. With only 64 pages of anonymous memory, the reclaim
target can be largely or entirely satisfied by dropping file pages,
resulting in very few or zero anonymous pages being pushed into zswap.

This causes zswap_usage to be extremely small or zero, making
zswap_usage/4 insufficient to create meaningful writeback pressure.
The test then fails because no writeback is triggered.

On 4K page size systems this is not an issue because 4M covers 1024
pages, and file pages are a small fraction of the reclaim target.

Fix this by:
- Always allocating 1024 pages regardless of page size. This ensures
  enough anonymous pages to reliably populate zswap and trigger
  writeback, while keeping the original 4M allocation on 4K systems.
- Setting zswap.max to zswap_usage/4 instead of zswap_usage/2 to
  create stronger writeback pressure, ensuring reclaim reliably
  triggers writeback even on large page size systems.

=== Error Log ===
  # uname -rm
  6.12.0-211.el10.ppc64le ppc64le

  # getconf PAGESIZE
  65536

  # ./test_zswap
  TAP version 13
  1..7
  ok 1 test_zswap_usage
  ok 2 test_swapin_nozswap
  ok 3 test_zswapin
  not ok 4 test_zswap_writeback_enabled
  ...

Signed-off-by: Li Wang <liwang@redhat.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>
Cc: Michal Hocko <mhocko@kernel.org>
Cc: Michal Koutný <mkoutny@suse.com>
Cc: Muchun Song <muchun.song@linux.dev>
Cc: Nhat Pham <nphamcs@gmail.com>
Cc: Tejun Heo <tj@kernel.org>
Cc: Roman Gushchin <roman.gushchin@linux.dev>
Cc: Shakeel Butt <shakeel.butt@linux.dev>
Acked-by: Yosry Ahmed <yosry@kernel.org>
---

Notes:
    v6:
    	- Adjust the code comments.
    v5:
    	- Setting zswap.max to zswap_usage/4 to create stronger writeback pressure.
    v3-4:
    	- No changes.
    v2:
    	- use pagesize * 1024 which clearly shows the page numbers.

 tools/testing/selftests/cgroup/test_zswap.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/cgroup/test_zswap.c b/tools/testing/selftests/cgroup/test_zswap.c
index 2b14683f9a77..ffc037922e1b 100644
--- a/tools/testing/selftests/cgroup/test_zswap.c
+++ b/tools/testing/selftests/cgroup/test_zswap.c
@@ -266,14 +266,14 @@ static int test_zswapin(const char *root)
       This will move it into zswap.
  * 3. Save current zswap usage.
  * 4. Move the memory allocated in step 1 back in from zswap.
- * 5. Set zswap.max to half the amount that was recorded in step 3.
+ * 5. Set zswap.max to 1/4 of the amount that was recorded in step 3.
  * 6. Attempt to reclaim memory equal to the amount that was allocated,
       this will either trigger writeback if it's enabled, or reclamation
       will fail if writeback is disabled as there isn't enough zswap space.
  */
 static int attempt_writeback(const char *cgroup, void *arg)
 {
-	size_t memsize = MB(4);
+	size_t memsize = page_size * 1024;
 	char buf[page_size];
 	long zswap_usage;
 	bool wb_enabled = *(bool *) arg;
@@ -311,12 +311,12 @@ static int attempt_writeback(const char *cgroup, void *arg)
 		}
 	}
 
-	if (cg_write_numeric(cgroup, "memory.zswap.max", zswap_usage/2))
+	if (cg_write_numeric(cgroup, "memory.zswap.max", zswap_usage/4))
 		goto out;
 
 	/*
 	 * If writeback is enabled, trying to reclaim memory now will trigger a
-	 * writeback as zswap.max is half of what was needed when reclaim ran the first time.
+	 * writeback as zswap.max is 1/4 of what was needed when reclaim ran the first time.
 	 * If writeback is disabled, memory reclaim will fail as zswap is limited and
 	 * it can't writeback to swap.
 	 */
-- 
2.53.0


