Return-Path: <cgroups+bounces-14917-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oDAaGtc2vGl3uwIAu9opvQ
	(envelope-from <cgroups+bounces-14917-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Thu, 19 Mar 2026 18:48:07 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DDA8B2D0416
	for <lists+cgroups@lfdr.de>; Thu, 19 Mar 2026 18:48:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C7ABC321D546
	for <lists+cgroups@lfdr.de>; Thu, 19 Mar 2026 17:40:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8304A399004;
	Thu, 19 Mar 2026 17:39:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZI/WlMTP"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE5FC396D29
	for <cgroups@vger.kernel.org>; Thu, 19 Mar 2026 17:39:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773941947; cv=none; b=CKqQL/JX72FTmKk9oRlFghQKh6w0IBZSE/NDc0i+6ZGIZ7ZaroRYocFinr+1Z3JsClbZ2iewYi8vBK8zi3BwHX9L5obCJzjubkmlrGnK9URJCftAc7aXhgg4BAFSHBDvz86rLeYQfFgpVrBZjv/w7VxFo+it4h3NLD2INRwG50o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773941947; c=relaxed/simple;
	bh=QW2o/0pD/nuSxdJjX8MhdFuXchFJ54Qmtj8E6QWwEtQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QFDC0p/FOxZkVB1pd2kuX80bXkPDNpT2Rq86WcWImcQkk/bo4abnHMfWxb/FSY44tEUDxdxiVBMt2X6f3g8NKfJodR6ywijPo8vAI2nkr7J9LdMDpcNQVeYHNpbvhAxtBpDiz3dOD0BP/qWcZrk7Y6nEv8UmOuxUWVlPU6iY1LI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZI/WlMTP; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1773941941;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=v3fioxjDFRlSnWZiLdEAmcRT6TY1ObgyXmYFMHdPXDc=;
	b=ZI/WlMTPWPQrhaYXnG7OavNkDyE2c0thECHA8+zcc+zkID9c+H3W0BpNtx4jSGdxV2rfd3
	b48m6mLKGQnMoLBpTdYLp4+F40Zzvui+qBVWiXkwMmeTZaYWRztIcgf0t/J4YlVDI7Qcxe
	lM/G75XqkbyaCmkbAluvrLsfZc6jxRY=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-612-cGyfdEitMnu807dx5kH8Ug-1; Thu,
 19 Mar 2026 13:38:58 -0400
X-MC-Unique: cGyfdEitMnu807dx5kH8Ug-1
X-Mimecast-MFC-AGG-ID: cGyfdEitMnu807dx5kH8Ug_1773941935
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B0B611800365;
	Thu, 19 Mar 2026 17:38:55 +0000 (UTC)
Received: from llong-thinkpadp16vgen1.westford.csb (unknown [10.22.80.194])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id CF49330001A1;
	Thu, 19 Mar 2026 17:38:52 +0000 (UTC)
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
Subject: [PATCH 2/7] memcg: Scale down MEMCG_CHARGE_BATCH with increase in PAGE_SIZE
Date: Thu, 19 Mar 2026 13:37:47 -0400
Message-ID: <20260319173752.1472864-3-longman@redhat.com>
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
	TAGGED_FROM(0.00)[bounces-14917-lists,cgroups=lfdr.de];
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
	NEURAL_HAM(-0.00)[-0.955];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: DDA8B2D0416
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

For a system with 4k page size, each percpu memcg_stock can hide up
to 256 kbytes of memory with the current MEMCG_CHARGE_BATCH value of
64. For another system with 64k page size, that becomes 4 Mbytes.
This MEMCG_CHARGE_BATCH value also controls how often should the
memcg vmstat values need flushing. As a result, the values reported
in various memory cgroup control files are even less indicative of the
actual memory consumption of a particular memory cgroup when the page
size increases from 4k.

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


