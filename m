Return-Path: <cgroups+bounces-14973-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OHu4G4+xvWlBAgMAu9opvQ
	(envelope-from <cgroups+bounces-14973-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Fri, 20 Mar 2026 21:43:59 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E2D92E0F18
	for <lists+cgroups@lfdr.de>; Fri, 20 Mar 2026 21:43:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 6B73B302408C
	for <lists+cgroups@lfdr.de>; Fri, 20 Mar 2026 20:43:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 916AC364021;
	Fri, 20 Mar 2026 20:43:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JTFBlMlo"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06DD936165F
	for <cgroups@vger.kernel.org>; Fri, 20 Mar 2026 20:43:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774039407; cv=none; b=UfaSiIj4KNMbdMQBvgXR6QNfmugT3+87lfyZH0Fce3TcHDxsQAvNWFL0jkRKQsYMFUx1zuyJ95lN1YztRFSDYSEQWlZtfOm8R4VHzOAuKB9qgf8KpT5L6TFCp1dGL2z/Tho+J8TWT2idwE1DAviXzQ+9KjZUlTN0dCsGZjy9I6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774039407; c=relaxed/simple;
	bh=4kS4kT8EQrGjU2lOop+QwuSnOC0/MXNObpBVeXoFY3o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=T8Rs3Ej+w+l/Q7+ATLfWlzAVejEXnnl1XSJta6t43L0gD5HADZFH5XWeVt/79JfWTbso7gZ9zL1IQvSm2MuzsrSEWyktUUf27Wa8nkcZ3OG58zSXY9KoCe1YldqWGpy8Kj9ea55nSKDepxIldQ2XVM87DL90S6TnYQbCis2gFO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JTFBlMlo; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1774039405;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sHG2nfg0B6suxMqU67D+nlAd3e+FK+NpiYnNJSdtKWs=;
	b=JTFBlMloBx3GlT+Kz+1i80Dg72RvPU3ad5Cvds5vfvOBNYq5imjzoUstmh9rG6OlLkL9Th
	8oOB6P94QNGmu//gMZaTfHsXb9gqgwh5nLWvXXq7jECjuS9O5nBRx7/3b1jA8ii2s21KKF
	PV9qQj/pXsdeNCSqpHNdCwp+S/4F4z4=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-553-3zwt_kK3PZmZkZVa34aB0w-1; Fri,
 20 Mar 2026 16:43:20 -0400
X-MC-Unique: 3zwt_kK3PZmZkZVa34aB0w-1
X-Mimecast-MFC-AGG-ID: 3zwt_kK3PZmZkZVa34aB0w_1774039398
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 682C819560B4;
	Fri, 20 Mar 2026 20:43:18 +0000 (UTC)
Received: from llong-thinkpadp16vgen1.westford.csb (unknown [10.22.65.139])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 23EE81800764;
	Fri, 20 Mar 2026 20:43:15 +0000 (UTC)
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
Subject: [PATCH v2 6/7] selftests: memcg: Don't call reclaim_until() if already in target
Date: Fri, 20 Mar 2026 16:42:40 -0400
Message-ID: <20260320204241.1613861-7-longman@redhat.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,kvack.org,google.com,gmail.com,kylinos.cn,redhat.com];
	RCPT_COUNT_TWELVE(0.00)[20];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-14973-lists,cgroups=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 4E2D92E0F18
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Near the end of test_memcg_protection(), reclaim_until() is called
to reduce memory.current of children[0] to 10M. It was found that
with larger page size (e.g. 64k) the various memory cgroups in
test_memcg_protection() would deviate further from the expected values
especially for the test_memcg_low test. As a result, children[0] might
have reached the target already without reclamation. The will cause the
reclaim_until() function to report failure as no reclamation is needed.

Avoid this unexpected failure by skipping the reclaim_until() call if
memory.current of children[0] has already reached the target size for
kernel with non-4k page size.

Signed-off-by: Waiman Long <longman@redhat.com>
---
 tools/testing/selftests/cgroup/test_memcontrol.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/cgroup/test_memcontrol.c b/tools/testing/selftests/cgroup/test_memcontrol.c
index 3832ded1e47b..5336be5ed2f5 100644
--- a/tools/testing/selftests/cgroup/test_memcontrol.c
+++ b/tools/testing/selftests/cgroup/test_memcontrol.c
@@ -490,6 +490,7 @@ static int test_memcg_protection(const char *root, bool min)
 	long current;
 	int i, attempts;
 	int fd;
+	bool do_reclaim;
 
 	fd = get_temp_fd();
 	if (fd < 0)
@@ -602,7 +603,15 @@ static int test_memcg_protection(const char *root, bool min)
 				       9 + (min ? 0 : 6) * pscale_factor))
 		goto cleanup;
 
-	if (!reclaim_until(children[0], MB(10)))
+	/*
+	 * With larger page size, it is possible that memory.current of
+	 * children[0] is close to 10M. Skip the reclaim_until() call if
+	 * that is the case.
+	 */
+	current = cg_read_long(children[0], "memory.current");
+	do_reclaim = (page_size == KB(4)) ||
+		     ((current > MB(10)) && !values_close(current, MB(10), 3));
+	if (do_reclaim && !reclaim_until(children[0], MB(10)))
 		goto cleanup;
 
 	if (min) {
-- 
2.53.0


