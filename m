Return-Path: <cgroups+bounces-15821-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kIwGMqTTAmrPxwEAu9opvQ
	(envelope-from <cgroups+bounces-15821-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Tue, 12 May 2026 09:15:48 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 723B551B9BA
	for <lists+cgroups@lfdr.de>; Tue, 12 May 2026 09:15:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C3427301D30D
	for <lists+cgroups@lfdr.de>; Tue, 12 May 2026 07:15:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24FA43672AA;
	Tue, 12 May 2026 07:15:23 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E2BA368D5C;
	Tue, 12 May 2026 07:15:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778570122; cv=none; b=jtLlXIPqMrGBvYbAfX0kq+ooYG7mM/sdgcAyORETACuhpgci8imjphfMi6af3pwHYqrmFJ+ftaIXxp33CErzJLIsCNy8RhVxvGEILH/LmqNu5cAQ5eSHvjp8Q4SW1wiTMWWNIygfWPxVeIAXHf2tmluVeS8UhXtWZzEg07GiRwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778570122; c=relaxed/simple;
	bh=iLFLRbsK6t46Y6F4N+Yd13Of2BLo4wGHx/Lb2GGHcQQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=rMult4q4T83UnjZkW83Z4k3gkbjyoF8FWbKSWDiwYlrNCWRm3KFWN0TY+TjlhxxdTpUex20Ntz2NQaq/HNz3zbfJ9VHypX69E2aQ0RqX+qrOn8mPiXFv0REtDGERqi8r8THOYuHU6uuIAeECR/16L+RXHQVFrPh1CV26aC2ctM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 4eef91f44dd211f1aa26b74ffac11d73-20260512
X-CTIC-Tags:
	HR_CC_COUNT, HR_CC_DOMAIN_COUNT, HR_CC_NAME, HR_CC_NO_NAME, HR_CTE_8B
	HR_CTT_MISS, HR_DATE_H, HR_DATE_WKD, HR_DATE_ZONE, HR_FROM_NAME
	HR_SJ_DIGIT_LEN, HR_SJ_LANG, HR_SJ_LEN, HR_SJ_LETTER, HR_SJ_NOR_SYM
	HR_SJ_PHRASE, HR_SJ_PHRASE_LEN, HR_SJ_WS, HR_TO_COUNT, HR_TO_DOMAIN_COUNT
	HR_TO_NO_NAME, IP_TRUSTED, SRC_TRUSTED, DN_TRUSTED, SA_TRUSTED
	SA_EXISTED, SN_TRUSTED, SN_EXISTED, SPF_NOPASS, DKIM_NOPASS
	DMARC_NOPASS, CIE_GOOD, CIE_GOOD_SPF, GTI_FG_BS, GTI_RG_INFO
	GTI_C_BU, AMN_GOOD, ABX_MISS_RDNS
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12,REQID:f9674a71-c2c8-4f0f-879b-b5182cad1869,IP:10,
	URL:0,TC:0,Content:0,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:5
X-CID-INFO: VERSION:1.3.12,REQID:f9674a71-c2c8-4f0f-879b-b5182cad1869,IP:10,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:5
X-CID-META: VersionHash:e7bac3a,CLOUDID:a4fa77afa57655aead32552bc0befba1,BulkI
	D:260512151511UXZ7AZTA,BulkQuantity:0,Recheck:0,SF:17|19|38|66|78|102|127|
	850|898,TC:nil,Content:0|15|50,EDM:-3,IP:-2,URL:0,File:nil,RT:nil,Bulk:nil
	,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:
	0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_FAS,TF_CID_SPAM_FSD
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 4eef91f44dd211f1aa26b74ffac11d73-20260512
X-User: lihongfu@kylinos.cn
Received: from localhost.localdomain [(223.70.159.239)] by mailgw.kylinos.cn
	(envelope-from <lihongfu@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 588572323; Tue, 12 May 2026 15:15:08 +0800
From: Hongfu Li <lihongfu@kylinos.cn>
To: hannes@cmpxchg.org,
	mhocko@kernel.org,
	roman.gushchin@linux.dev,
	shakeel.butt@linux.dev,
	muchun.song@linux.dev,
	tj@kernel.org,
	mkoutny@suse.com,
	shuah@kernel.org,
	vishal.moola@gmail.com
Cc: cgroups@vger.kernel.org,
	linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Hongfu Li <lihongfu@kylinos.cn>
Subject: [PATCH v2] selftests/cgroup: check malloc return value in alloc_anon functions
Date: Tue, 12 May 2026 15:14:24 +0800
Message-Id: <20260512071424.59449-1-lihongfu@kylinos.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 723B551B9BA
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.54 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-15821-lists,cgroups=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	DMARC_NA(0.00)[kylinos.cn];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	FREEMAIL_TO(0.00)[cmpxchg.org,kernel.org,linux.dev,suse.com,gmail.com];
	NEURAL_SPAM(0.00)[0.203];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lihongfu@kylinos.cn,cgroups@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	R_DKIM_NA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[kylinos.cn:email,kylinos.cn:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linux.dev:email]
X-Rspamd-Action: no action

The alloc_anon() function calls malloc() without checking for a NULL
return. If memory allocation fails, a NULL pointer dereference will
occur when accessing the buffer.

Add proper error handling to return -1 when malloc() fails in all
four alloc_anon variants:
- alloc_anon()
- alloc_anon_50M_check()
- alloc_anon_noexit()
- alloc_anon_50M_check_swap()

Signed-off-by: Hongfu Li <lihongfu@kylinos.cn>
Reviewed-by: Vishal Moola <vishal.moola@gmail.com>
Reviewed-by: Muchun Song <muchun.song@linux.dev>
---
v2:
- Refactored repeated malloc() patterns in alloc_anon_* into a helper
  function.
---
 .../selftests/cgroup/test_memcontrol.c        | 53 ++++++++++---------
 1 file changed, 27 insertions(+), 26 deletions(-)

diff --git a/tools/testing/selftests/cgroup/test_memcontrol.c b/tools/testing/selftests/cgroup/test_memcontrol.c
index b43da9bc20c4..21aedb35cc12 100644
--- a/tools/testing/selftests/cgroup/test_memcontrol.c
+++ b/tools/testing/selftests/cgroup/test_memcontrol.c
@@ -55,15 +55,31 @@ int alloc_pagecache(int fd, size_t size)
 	return -1;
 }
 
-int alloc_anon(const char *cgroup, void *arg)
+static char *alloc_and_populate_anon(size_t size)
 {
-	size_t size = (unsigned long)arg;
 	char *buf, *ptr;
 
 	buf = malloc(size);
+	if (buf == NULL) {
+		fprintf(stderr, "malloc() failed\n");
+		return NULL;
+	}
+
 	for (ptr = buf; ptr < buf + size; ptr += PAGE_SIZE)
 		*ptr = 0;
 
+	return buf;
+}
+
+int alloc_anon(const char *cgroup, void *arg)
+{
+	size_t size = (unsigned long)arg;
+	char *buf;
+
+	buf = alloc_and_populate_anon(size);
+	if (!buf)
+		return -1;
+
 	free(buf);
 	return 0;
 }
@@ -174,18 +190,13 @@ static int test_memcg_subtree_control(const char *root)
 static int alloc_anon_50M_check(const char *cgroup, void *arg)
 {
 	size_t size = MB(50);
-	char *buf, *ptr;
+	char *buf;
 	long anon, current;
 	int ret = -1;
 
-	buf = malloc(size);
-	if (buf == NULL) {
-		fprintf(stderr, "malloc() failed\n");
+	buf = alloc_and_populate_anon(size);
+	if (!buf)
 		return -1;
-	}
-
-	for (ptr = buf; ptr < buf + size; ptr += PAGE_SIZE)
-		*ptr = 0;
 
 	current = cg_read_long(cgroup, "memory.current");
 	if (current < size)
@@ -406,16 +417,11 @@ static int alloc_anon_noexit(const char *cgroup, void *arg)
 {
 	int ppid = getppid();
 	size_t size = (unsigned long)arg;
-	char *buf, *ptr;
+	char *buf;
 
-	buf = malloc(size);
-	if (buf == NULL) {
-		fprintf(stderr, "malloc() failed\n");
+	buf = alloc_and_populate_anon(size);
+	if (!buf)
 		return -1;
-	}
-
-	for (ptr = buf; ptr < buf + size; ptr += PAGE_SIZE)
-		*ptr = 0;
 
 	while (getppid() == ppid)
 		sleep(1);
@@ -990,18 +996,13 @@ static int alloc_anon_50M_check_swap(const char *cgroup, void *arg)
 {
 	long mem_max = (long)arg;
 	size_t size = MB(50);
-	char *buf, *ptr;
+	char *buf;
 	long mem_current, swap_current;
 	int ret = -1;
 
-	buf = malloc(size);
-	if (buf == NULL) {
-		fprintf(stderr, "malloc() failed\n");
+	buf = alloc_and_populate_anon(size);
+	if (!buf)
 		return -1;
-	}
-
-	for (ptr = buf; ptr < buf + size; ptr += PAGE_SIZE)
-		*ptr = 0;
 
 	mem_current = cg_read_long(cgroup, "memory.current");
 	if (!mem_current || !values_close(mem_current, mem_max, 3))
-- 
2.25.1


