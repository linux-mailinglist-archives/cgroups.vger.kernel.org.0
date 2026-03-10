Return-Path: <cgroups+bounces-14737-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IBzQOQwusGlHgwIAu9opvQ
	(envelope-from <cgroups+bounces-14737-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Tue, 10 Mar 2026 15:43:24 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B051D2524DD
	for <lists+cgroups@lfdr.de>; Tue, 10 Mar 2026 15:43:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 1AA35303E858
	for <lists+cgroups@lfdr.de>; Tue, 10 Mar 2026 14:40:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A6352EFDAD;
	Tue, 10 Mar 2026 14:40:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="O0uOO2mK"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ACEA2E9749
	for <cgroups@vger.kernel.org>; Tue, 10 Mar 2026 14:40:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773153639; cv=none; b=HJEZa4jdb8yLt2VkCVoAEBcmRfOIDoRv3pD2cmKmC0KRQSwR7KOQWmSxqXvB85p3qQt0vLoudCJsodhTU+MymfQeKDlIJ8C6hts4QMJBOohQSfWsBmcpIsXFH694ujOnPpc7t2cyuqFPfCPqXGdQkjzputZibxGiMxaEZB4+oqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773153639; c=relaxed/simple;
	bh=54MdOd7UPJE9DfCnnlpjXdOzIeGfGg2JFwQWuRnt93w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bLjUSdpa9g2NYNoNcP1oXmIsoPZxN1lU3pqANO/Eqf+GvJ8Eu0uc6kHIHfUGalhiGK9upDe6zxz9EIcgUvaT/OsXjSW4HiUnr/98UAl84vgNHVVaxL7T8V7BmOgIu7uZ4ak+x3E8tOr1LTT1wE2FnG0QCIjOfj3DBtUtYLbvuNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=O0uOO2mK; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1773153637;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=H2KXlUhYjyvsk/adOesgn1eiMUOMZJsVsfNB2OlVCtA=;
	b=O0uOO2mKmN4Fq18gYsd6zEfzcPQpYtSM+zgWmguzS0FGktASFvXlMQIDBh3J8M8VsXYxWc
	bjbSL8r3zZHJKHhk4mDesNkAhhr82lRMN0yg1PRAwCJUk2JxKk/RfB9gwd2WeCjwOtomvS
	0y1Ipod2krf+50bl2QTcEoMuDqBmbJ8=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-508-tdmInL87MA-qqhnECWWfXA-1; Tue,
 10 Mar 2026 10:40:32 -0400
X-MC-Unique: tdmInL87MA-qqhnECWWfXA-1
X-Mimecast-MFC-AGG-ID: tdmInL87MA-qqhnECWWfXA_1773153630
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 55B31186A475;
	Tue, 10 Mar 2026 14:39:50 +0000 (UTC)
Received: from llong-thinkpadp16vgen1.westford.csb (unknown [10.22.89.94])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 9457E1800759;
	Tue, 10 Mar 2026 14:39:47 +0000 (UTC)
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
	Waiman Long <longman@redhat.com>
Subject: [PATCH v2] selftest: memcg: Skp memcg_sock test if address family not supported
Date: Tue, 10 Mar 2026 10:39:35 -0400
Message-ID: <20260310143936.720592-1-longman@redhat.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Rspamd-Queue-Id: B051D2524DD
X-Rspamd-Server: lfdr
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
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[15];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-14737-lists,cgroups=lfdr.de];
	DKIM_TRACE(0.00)[redhat.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[longman@redhat.com,cgroups@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[cgroups];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Action: no action

The test_memcg_sock test in memcontrol.c sets up an IPv6 socket and
send data over it to consume memory and verify that memory.stat.sock
and memory.current values are close.

On systems where IPv6 isn't enabled or not configured to support
SOCK_STREAM, the test_memcg_sock test always fails.  When the socket()
call fails, there is no way we can test the memory consumption and
verify the above claim. I believe it is better to just skip the test
in this case instead of reporting a test failure hinting that there
may be something wrong with the memcg code.

Fixes: 5f8f019380b8 ("selftests: cgroup/memcontrol: add basic test for socket accounting")
Signed-off-by: Waiman Long <longman@redhat.com>

[v2] Update and commit log & adjust the skip code as suggested by Michael.

---
 tools/testing/selftests/cgroup/test_memcontrol.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/cgroup/test_memcontrol.c b/tools/testing/selftests/cgroup/test_memcontrol.c
index 2fb096a2a9f9..a25eb097b31c 100644
--- a/tools/testing/selftests/cgroup/test_memcontrol.c
+++ b/tools/testing/selftests/cgroup/test_memcontrol.c
@@ -1280,8 +1280,11 @@ static int tcp_server(const char *cgroup, void *arg)
 	saddr.sin6_port = htons(srv_args->port);
 
 	sk = socket(AF_INET6, SOCK_STREAM, 0);
-	if (sk < 0)
+	if (sk < 0) {
+		/* Pass back errno to the ctl_fd */
+		write(ctl_fd, &errno, sizeof(errno));
 		return ret;
+	}
 
 	if (setsockopt(sk, SOL_SOCKET, SO_REUSEADDR, &yes, sizeof(yes)) < 0)
 		goto cleanup;
@@ -1412,6 +1415,12 @@ static int test_memcg_sock(const char *root)
 			goto cleanup;
 		close(args.ctl[0]);
 
+		/* Skip if address family not supported by protocol */
+		if (err == EAFNOSUPPORT) {
+			ret = KSFT_SKIP;
+			goto cleanup;
+		}
+
 		if (!err)
 			break;
 		if (err != EADDRINUSE)
-- 
2.53.0


