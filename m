Return-Path: <cgroups+bounces-14974-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IEcQAQiyvWlBAgMAu9opvQ
	(envelope-from <cgroups+bounces-14974-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Fri, 20 Mar 2026 21:46:00 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id AEEE92E0FA6
	for <lists+cgroups@lfdr.de>; Fri, 20 Mar 2026 21:45:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 23C48307F3BE
	for <lists+cgroups@lfdr.de>; Fri, 20 Mar 2026 20:43:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0E0B364E82;
	Fri, 20 Mar 2026 20:43:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GCYR16xy"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F12A3630BF
	for <cgroups@vger.kernel.org>; Fri, 20 Mar 2026 20:43:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774039411; cv=none; b=Cl9GRQlyjdb47QoYCKH1uPd3O7YwpHkKwKQgaCY8AyBzCG3jofI6UUapczpZHoGB9Ts3iu03wyiHPrS+vdlxuGtpsxchNgZ7FlD3mPDeQgNsHHKMZJSLIJPiXSTNlx1UngyyOEkKhv1qaqS1UsodsXykAeyGDmIeHzHfYOwlUYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774039411; c=relaxed/simple;
	bh=DWcBQegSve8SZRQHLBltrNPvoMiEi11nl1pKKqMqJtI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qcFYm2T1yzkK0MdELjqlh2mKQv6LYDAebVRd+FhBGtzxFrGXY1sBtuSsJNUcbsHL4yJqvwAHFSSPi+5ELuIo6uLssH+E/CTIk4EUB2ERObxwEZ2cBY2A5U2z6w4uCEaE8sYXaZfoF8j1gRG25lcL9/iCi/1sa4qAdtNAZqWX6Bg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GCYR16xy; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1774039408;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NNnnx0J3yeBnBNT/ZZLy4XythaRAMwcdcOOMkKfy0Ug=;
	b=GCYR16xysB/sVojLmUfRvKKX0Ft1QUk0w4FDl63YkZIoLGAE2QkDXimMYbDO1W4UG1mRLT
	c86HeSAklzoAhw+DNFhvjHH4Yxe28ssAUPC70LdQsYv3SyxCFiwjwFWxK7ZKQuosh2JskI
	jk7MvMCTZEOZ4ngz7KCGwY2QP6tIENs=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-159-QZVTQ2s2M0Stp-4wudu18w-1; Fri,
 20 Mar 2026 16:43:24 -0400
X-MC-Unique: QZVTQ2s2M0Stp-4wudu18w-1
X-Mimecast-MFC-AGG-ID: QZVTQ2s2M0Stp-4wudu18w_1774039401
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 979F41800345;
	Fri, 20 Mar 2026 20:43:21 +0000 (UTC)
Received: from llong-thinkpadp16vgen1.westford.csb (unknown [10.22.65.139])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id A2A5A180075C;
	Fri, 20 Mar 2026 20:43:18 +0000 (UTC)
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
Subject: [PATCH v2 7/7] selftests: memcg: Treat failure for zeroing sock in test_memcg_sock as XFAIL
Date: Fri, 20 Mar 2026 16:42:41 -0400
Message-ID: <20260320204241.1613861-8-longman@redhat.com>
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
	TAGGED_FROM(0.00)[bounces-14974-lists,cgroups=lfdr.de];
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
X-Rspamd-Queue-Id: AEEE92E0FA6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Although there is supposed to be a periodic and asynchronous flush of
stats every 2 seconds, the actual time lag between succesive runs can
actually vary quite a bit. In fact, I have seen time lag of up to 10s
of seconds in some cases.

At the end of test_memcg_sock, it waits up to 3 seconds for the
"sock" attribute of memory.stat to go back down to 0. Obviously it
may occasionally fail especially when the kernel has large page size
(e.g. 64k). Treat this failure as an expected failure (XFAIL) to
distinguish it from the other failure cases.

Signed-off-by: Waiman Long <longman@redhat.com>
---
 tools/testing/selftests/cgroup/test_memcontrol.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/cgroup/test_memcontrol.c b/tools/testing/selftests/cgroup/test_memcontrol.c
index 5336be5ed2f5..af3e8fe4e50e 100644
--- a/tools/testing/selftests/cgroup/test_memcontrol.c
+++ b/tools/testing/selftests/cgroup/test_memcontrol.c
@@ -1486,12 +1486,21 @@ static int test_memcg_sock(const char *root)
 	 * Poll memory.stat for up to 3 seconds (~FLUSH_TIME plus some
 	 * scheduling slack) and require that the "sock " counter
 	 * eventually drops to zero.
+	 *
+	 * The actual run-to-run elapse time between consecutive run
+	 * of asynchronous memcg rstat flush may varies quite a bit.
+	 * So the 3 seconds wait time may not be enough for the "sock"
+	 * counter to go down to 0. Treat it as a XFAIL instead of
+	 * a FAIL.
 	 */
 	sock_post = cg_read_key_long_poll(memcg, "memory.stat", "sock ", 0,
 					 MEMCG_SOCKSTAT_WAIT_RETRIES,
 					 DEFAULT_WAIT_INTERVAL_US);
-	if (sock_post)
+	if (sock_post) {
+		if (sock_post > 0)
+			ret = KSFT_XFAIL;
 		goto cleanup;
+	}
 
 	ret = KSFT_PASS;
 
@@ -1756,6 +1765,9 @@ int main(int argc, char **argv)
 		case KSFT_SKIP:
 			ksft_test_result_skip("%s\n", tests[i].name);
 			break;
+		case KSFT_XFAIL:
+			ksft_test_result_xfail("%s\n", tests[i].name);
+			break;
 		default:
 			ksft_test_result_fail("%s\n", tests[i].name);
 			break;
-- 
2.53.0


