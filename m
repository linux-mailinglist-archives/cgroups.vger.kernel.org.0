Return-Path: <cgroups+bounces-14969-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MOABKouxvWlBAgMAu9opvQ
	(envelope-from <cgroups+bounces-14969-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Fri, 20 Mar 2026 21:43:55 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 48D442E0F10
	for <lists+cgroups@lfdr.de>; Fri, 20 Mar 2026 21:43:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 13CA03015D13
	for <lists+cgroups@lfdr.de>; Fri, 20 Mar 2026 20:43:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8C813612E7;
	Fri, 20 Mar 2026 20:43:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cwXy0vbl"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6510435FF6B
	for <cgroups@vger.kernel.org>; Fri, 20 Mar 2026 20:43:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774039393; cv=none; b=jeyFNR/azfufWRpnTC3tpErS8LItydnIOInXOGW6d7SCnjfsyz1/QY6hDKhZ4hNaLj7HWBJ4LlwWGva+Tl1YrtDUcwKXFJNUuyTfsQVk/6hCcrwvAsh0fRblST+tj3QIb6MaXZNdDph6qLDIASwIF3DNPSXirI/Dl0A4cNU6H7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774039393; c=relaxed/simple;
	bh=nnUHfpWb+ToO3fSDL6WoOEh2rTTn/257I+eNth7K8N0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hIXJDPFw2NNy+7mChvyddN2A+wHJISbPkz8TkAigfoUwa7jfMins9iH/5Mj61uvSG2VIwgPBdfHa4dmcRQX/pJxsR+9E2cHGUs8CDR+cORMbNL+INLQAllAUaOLhM/1PQRQHhDxlDV/nZ8OZtIYGE+vBsqHod0xTVTEQi8iDXAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cwXy0vbl; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1774039391;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=n8lUtSKyFrk8YBBDo4AltLu8YBIJTZq8Ls8cEx7Gnqc=;
	b=cwXy0vblTzufMOIgwI9LOI+/CkG4YiWJqrJBtFJDeJ9UKeR8nj6e7x5snTtmC3nLTq1v54
	htDXKUy04m1giIwsUnoGCztUu0n6XK7qBnRxh6vo5kgynNO3t6RBQgIv6xRQK+squtOvz2
	UvMyllvwRX4sp1CHrVGgCwNDp1HuwfI=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-326-HS4GhqznNiSV7KJMYjamvw-1; Fri,
 20 Mar 2026 16:43:06 -0400
X-MC-Unique: HS4GhqznNiSV7KJMYjamvw-1
X-Mimecast-MFC-AGG-ID: HS4GhqznNiSV7KJMYjamvw_1774039384
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B9A4B180034E;
	Fri, 20 Mar 2026 20:43:03 +0000 (UTC)
Received: from llong-thinkpadp16vgen1.westford.csb (unknown [10.22.65.139])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id B40F4180075D;
	Fri, 20 Mar 2026 20:43:00 +0000 (UTC)
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
Subject: [PATCH v2 2/7] memcg: Scale down MEMCG_CHARGE_BATCH with increase in PAGE_SIZE
Date: Fri, 20 Mar 2026 16:42:36 -0400
Message-ID: <20260320204241.1613861-3-longman@redhat.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,kvack.org,google.com,gmail.com,kylinos.cn,redhat.com];
	RCPT_COUNT_TWELVE(0.00)[20];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-14969-lists,cgroups=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 48D442E0F10
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

For a system with 4k page size, each percpu memcg_stock can hide up
to 256 kbytes of memory with the current MEMCG_CHARGE_BATCH value of
64. For another system with 64k page size, that becomes 4 Mbytes. This
hidden charges will affect the accurary of the memory.current value.

This MEMCG_CHARGE_BATCH value also controls how often should the
memcg vmstat values need flushing. As a result, the values reported
in memory.stat cgroup control files are less indicative of the actual
memory consumption of a particular memory cgroup when the page size
increases from 4k.

This problem can be illustrated by running the test_memcontrol
selftest. Running a 4k page size kernel on a 128-core arm64 system,
the test_memcg_current_peak test which allocates a 50M anonymous memory
passed. With a 64k page size kernel on the same system, however, the
same test failed because the "anon" attribute of memory.stat file might
report a size of 0 depending on the number of CPUs the system has.

To solve this inaccurate memory stats problem, we need to scale down
the amount of memory that can be hidden by reducing MEMCG_CHARGE_BATCH
when the page size increases. The same user application will likely
consume more memory on systems with larger page size and it is also
less efficient if we scale down MEMCG_CHARGE_BATCH by too much.  So I
believe a good compromise is to scale down MEMCG_CHARGE_BATCH by 2 for
16k page size and by 4 with 64k page size.

With that change, the test_memcg_current_peak test passed again with
the modified 64k page size kernel.

Signed-off-by: Waiman Long <longman@redhat.com>
---
 include/linux/memcontrol.h | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index 70b685a85bf4..748cfd75d998 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -328,8 +328,14 @@ struct mem_cgroup {
  * size of first charge trial.
  * TODO: maybe necessary to use big numbers in big irons or dynamic based of the
  * workload.
+ *
+ * There are 3 common base page sizes - 4k, 16k & 64k. In order to limit the
+ * amount of memory that can be hidden in each percpu memcg_stock for a given
+ * memcg, we scale down MEMCG_CHARGE_BATCH by 2 for 16k and 4 for 64k.
  */
-#define MEMCG_CHARGE_BATCH 64U
+#define MEMCG_CHARGE_BATCH_BASE  64U
+#define MEMCG_CHARGE_BATCH_SHIFT ((PAGE_SHIFT <= 16) ? (PAGE_SHIFT - 12)/2 : 2)
+#define MEMCG_CHARGE_BATCH	 (MEMCG_CHARGE_BATCH_BASE >> MEMCG_CHARGE_BATCH_SHIFT)
 
 extern struct mem_cgroup *root_mem_cgroup;
 
-- 
2.53.0


