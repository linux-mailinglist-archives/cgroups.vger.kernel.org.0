Return-Path: <cgroups+bounces-15572-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YKPSGjsO9GmJ+AEAu9opvQ
	(envelope-from <cgroups+bounces-15572-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Fri, 01 May 2026 04:21:47 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C9734A9C95
	for <lists+cgroups@lfdr.de>; Fri, 01 May 2026 04:21:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6567430221C4
	for <lists+cgroups@lfdr.de>; Fri,  1 May 2026 02:21:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EFF02E62C4;
	Fri,  1 May 2026 02:21:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="pFLCKW17"
X-Original-To: cgroups@vger.kernel.org
Received: from out-173.mta0.migadu.com (out-173.mta0.migadu.com [91.218.175.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A7A12E5B2A
	for <cgroups@vger.kernel.org>; Fri,  1 May 2026 02:21:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777602085; cv=none; b=O6oX0mgkTRNkpBsC3oSf1OUL6aQrmdFkSp8t5hH0tsrJF9IPps981gGh+dpuS/y9NLaIzaZ9OHsvclbkXOgO1uMMIvNyhF/53nTYX6uGfqtKT3wqBW/olF53oGcsdGmrSmBEn4f1+52ijslUGAZH7nk87tsUGxOU3R8UFmCBvVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777602085; c=relaxed/simple;
	bh=nWZpn+zuYeF1V9x/teR05sIUTrIzFNN47Ulj38ZPNeA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HaVZyeoFpnzAJWSCI+rYrAVtxIEpy4GveNaqH42lwQxaVLrfu4awGPRbEpprkrO2zshxLOrQYiFv+DEJtsWj7U78tZmeS+rTXf4iq+sUrleD+Qr52oeyjFzw/4W3NN/wvk/58bmoG8+nEFoeDFPzKdq4gMVpOhVu+n4T55kHEww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=pFLCKW17; arc=none smtp.client-ip=91.218.175.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1777602080;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NBtGLtjRvE4baHy0eRK4mwql+K6PPxqXdGnpl9fPIQ0=;
	b=pFLCKW176QPS1YiBgSYn6EPexE20q/Nhgy7otY2RejVxCOOgcgct00JRvsqeP7snox6NOo
	L0jeV/ZbzDieXaq2pKtdp48NdkClEIMNtOl1U0wUHV6rLg5k7Gc6uwrAZwD1WqMD4u2qf8
	yRgg/5V2jD5mHAAOUVvV1ymCYwLzyc0=
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
Subject: [PATCH v2 1/2] selftests/cgroup: Fix hardcoded page size in test_percpu_basic
Date: Fri,  1 May 2026 10:20:57 +0800
Message-ID: <20260501022058.18024-2-li.wang@linux.dev>
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
X-Rspamd-Queue-Id: 0C9734A9C95
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-15572-lists,cgroups=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[cgroups];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:email,linux.dev:dkim,linux.dev:mid,suse.cz:email]

MAX_VMSTAT_ERROR uses a hardcoded page size of 4096, which assumes
4K pages. This causes test_percpu_basic to fail on systems where
the kernel is configured with a larger page size, such as aarch64
systems using 16K or 64K pages, where the maximum permissible
discrepancy between memory.current and percpu charges is
proportionally larger.

Replace the hardcoded 4096 with sysconf(_SC_PAGESIZE) to correctly
derive the page size at runtime regardless of the underlying
architecture or kernel configuration.

Signed-off-by: Li Wang <li.wang@linux.dev>
Cc: Waiman Long <longman@redhat.com>
Cc: Christoph Lameter <cl@linux.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>
Cc: Michal Hocko <mhocko@kernel.org>
Cc: Shakeel Butt <shakeelb@google.com>
Cc: Tejun Heo <tj@kernel.org>
Cc: Vlastimil Babka <vbabka@suse.cz>
Acked-by: Waiman Long <longman@redhat.com>
---
 tools/testing/selftests/cgroup/test_kmem.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/cgroup/test_kmem.c b/tools/testing/selftests/cgroup/test_kmem.c
index eeabd34bf08..249d7911306 100644
--- a/tools/testing/selftests/cgroup/test_kmem.c
+++ b/tools/testing/selftests/cgroup/test_kmem.c
@@ -24,7 +24,7 @@
  * the maximum discrepancy between charge and vmstat entries is number
  * of cpus multiplied by 64 pages.
  */
-#define MAX_VMSTAT_ERROR (4096 * 64 * get_nprocs())
+#define MAX_VMSTAT_ERROR (sysconf(_SC_PAGESIZE) * 64 * get_nprocs())
 
 #define KMEM_DEAD_WAIT_RETRIES        80
 
-- 
2.54.0


