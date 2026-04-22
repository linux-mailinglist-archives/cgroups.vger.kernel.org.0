Return-Path: <cgroups+bounces-15449-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sJ2WNEYy6GmeGgIAu9opvQ
	(envelope-from <cgroups+bounces-15449-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Wed, 22 Apr 2026 04:28:22 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id A2311441713
	for <lists+cgroups@lfdr.de>; Wed, 22 Apr 2026 04:28:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 79D6630200C4
	for <lists+cgroups@lfdr.de>; Wed, 22 Apr 2026 02:19:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B9EF2AF00;
	Wed, 22 Apr 2026 02:17:36 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88FF4311597
	for <cgroups@vger.kernel.org>; Wed, 22 Apr 2026 02:17:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776824255; cv=none; b=qKuetaikC5Fdx6Hd0yKuOw0Iw8PwGPWX8eNb14a6F7XCxCX/YyGBZjMI/WlmlanxRByoRt2QXgWRAWUYmTWdzg4zJNMnGYm3MOxXnO1akIFvZ7kYUXPGBMEB6de6N0cHgW6j7Jd4xTfyORAy/AwX6fkh9aIBgfNsSW51/VnP01w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776824255; c=relaxed/simple;
	bh=yRByoDqiqtpNNX7IC0TmNOkl7fzMrzIOjszpt0rVhKo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IHuzp7fhpxz+w/pcPgycFwCgONtjSPGFUgfM/ayOQwJpwwfC6HuD6e4e0aLs35Ib6Zyg6NqBTiBuZgVtVpAOmMLcj1zf5aIT8fIfExU3fZtfyqwAvwqUIqI+oVY0unXDXDw9N50IktbyeB4MUl1kfzPMS4PxKTpUMhymgYbDylI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 696004423df111f1aa26b74ffac11d73-20260422
X-CTIC-Tags:
	HR_CC_COUNT, HR_CC_DOMAIN_COUNT, HR_CC_NO_NAME, HR_CTE_8B, HR_CTT_TXT
	HR_DATE_H, HR_DATE_WKD, HR_DATE_ZONE, HR_FROM_NAME, HR_SJ_DIGIT_LEN
	HR_SJ_LANG, HR_SJ_LEN, HR_SJ_LETTER, HR_SJ_NOR_SYM, HR_SJ_PHRASE
	HR_SJ_PHRASE_LEN, HR_SJ_WS, HR_TO_COUNT, HR_TO_DOMAIN_COUNT, HR_TO_NO_NAME
	IP_TRUSTED, SRC_TRUSTED, DN_TRUSTED, SA_TRUSTED, SA_EXISTED
	SN_UNTRUSTED, SN_UNFAMILIAR, SPF_NOPASS, DKIM_NOPASS, DMARC_NOPASS
	CIE_BAD, CIE_GOOD, CIE_GOOD_SPF, GTI_FG_BS, GTI_C_CI
	GTI_FG_IT, GTI_RG_INFO, GTI_C_BU, AMN_GOOD, ABX_MISS_RDNS
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12,REQID:de430791-3b59-4751-aaec-85593f836891,IP:10,
	URL:0,TC:0,Content:100,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACT
	ION:release,TS:105
X-CID-INFO: VERSION:1.3.12,REQID:de430791-3b59-4751-aaec-85593f836891,IP:10,UR
	L:0,TC:0,Content:100,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Spam_GS981B3D,ACT
	ION:quarantine,TS:105
X-CID-META: VersionHash:e7bac3a,CLOUDID:0fce409ff07d3cadea73214296564fec,BulkI
	D:26042210173003B9ZHKB,BulkQuantity:0,Recheck:0,SF:17|19|66|78|81|82|127|8
	98,TC:nil,Content:3|15|50,EDM:-3,IP:-2,URL:99|1,File:nil,RT:nil,Bulk:nil,Q
	S:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,
	ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_FSD,TF_CID_SPAM_ULS,TF_CID_SPAM_SNR,TF_CID_SPAM_ASC,
	TF_CID_SPAM_FAS
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 696004423df111f1aa26b74ffac11d73-20260422
X-User: cuitao@kylinos.cn
Received: from ctao-book.. [(183.242.174.23)] by mailgw.kylinos.cn
	(envelope-from <cuitao@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 1998083821; Wed, 22 Apr 2026 10:17:28 +0800
From: Tao Cui <cuitao@kylinos.cn>
To: tj@kernel.org
Cc: cgroups@vger.kernel.org,
	cuitao@kylinos.cn,
	hannes@cmpxchg.org,
	mkoutny@suse.com
Subject: [PATCH v3] cgroup/rdma: refactor resource parsing with match_table_t/match_token()
Date: Wed, 22 Apr 2026 10:17:09 +0800
Message-ID: <20260422021709.333689-1-cuitao@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <d2d00a690c69213cad3d469f0ef478a9@kernel.org>
References: <d2d00a690c69213cad3d469f0ef478a9@kernel.org>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [2.44 / 15.00];
	SUSPICIOUS_URL_IN_SUSPICIOUS_MESSAGE(1.00)[];
	MID_CONTAINS_FROM(1.00)[];
	URIBL_RED(0.50)[kylinos.cn:mid,kylinos.cn:email];
	MAILLIST(-0.15)[generic];
	HAS_ANON_DOMAIN(0.10)[];
	BAD_REP_POLICIES(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-15449-lists,cgroups=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DMARC_NA(0.00)[kylinos.cn];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	ARC_ALLOW(0.00)[subspace.kernel.org:s=arc-20240116:i=1];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cuitao@kylinos.cn,cgroups@vger.kernel.org];
	RCPT_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[cgroups];
	R_DKIM_NA(0.00)[];
	R_SPF_ALLOW(0.00)[+ip4:104.64.211.4:c];
	DBL_BLOCKED_OPENRESOLVER(0.00)[kylinos.cn:mid,kylinos.cn:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: A2311441713
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Replace the hand-rolled strsep/strcmp/match_string parsing in
rdmacg_resource_set_max() with a match_table_t and match_token()
pattern, following the convention used by user_proactive_reclaim()
and ioc_cost_model_write().

The old strncmp(value, RDMACG_MAX_STR, strlen(value)) also had two
bugs that are fixed by this refactor:

  - It matched "ma" as "max" because strncmp only compared the
    shorter strlen(value) bytes.

  - It silently accepted "hca_handle=" (empty value) as "max"
    because strncmp with n=0 always returns 0.

The match_token() approach also robustly handles extra whitespace in
the input by splitting on " \t\n" and skipping empty tokens.

Suggested-by: "Michal Koutný" <mkoutny@suse.com>
Signed-off-by: Tao Cui <cuitao@kylinos.cn>

---
Changes in v3:
- Keep the comment above free_cg_rpool_locked() in
  rdmacg_resource_set_max() that was accidentally dropped.
- Expand changelog to mention the empty-value strncmp bug alongside
  the "ma" case.
  Link: https://lore.kernel.org/all/d2d00a690c69213cad3d469f0ef478a9@kernel.org/

Changes in v2:
- Refactor to use match_table_t/match_token() as suggested by Michal Koutný
  Link: https://lore.kernel.org/all/t2cbjvctdgzipxzovr5zkbovhptkxdaoxljeuxwrxboqqbkzqu@bcazimapp6ci/
---
 kernel/cgroup/rdma.c | 116 +++++++++++++++++++++----------------------
 1 file changed, 57 insertions(+), 59 deletions(-)

diff --git a/kernel/cgroup/rdma.c b/kernel/cgroup/rdma.c
index 9967fb25c563..ca9d04bc2921 100644
--- a/kernel/cgroup/rdma.c
+++ b/kernel/cgroup/rdma.c
@@ -9,6 +9,7 @@
  */
 
 #include <linux/bitops.h>
+#include <linux/limits.h>
 #include <linux/slab.h>
 #include <linux/seq_file.h>
 #include <linux/cgroup.h>
@@ -17,6 +18,22 @@
 
 #define RDMACG_MAX_STR "max"
 
+enum rdmacg_limit_tokens {
+	RDMACG_HCA_HANDLE_VAL,
+	RDMACG_HCA_HANDLE_MAX,
+	RDMACG_HCA_OBJECT_VAL,
+	RDMACG_HCA_OBJECT_MAX,
+	NR_RDMACG_LIMIT_TOKENS,
+};
+
+static const match_table_t rdmacg_limit_tokens = {
+	{ RDMACG_HCA_HANDLE_VAL,	"hca_handle=%d"	},
+	{ RDMACG_HCA_HANDLE_MAX,	"hca_handle=max"	},
+	{ RDMACG_HCA_OBJECT_VAL,	"hca_object=%d"	},
+	{ RDMACG_HCA_OBJECT_MAX,	"hca_object=max"	},
+	{ NR_RDMACG_LIMIT_TOKENS,	NULL			},
+};
+
 /*
  * Protects list of resource pools maintained on per cgroup basis
  * and rdma device list.
@@ -355,62 +372,6 @@ void rdmacg_unregister_device(struct rdmacg_device *device)
 }
 EXPORT_SYMBOL(rdmacg_unregister_device);
 
-static int parse_resource(char *c, int *intval)
-{
-	substring_t argstr;
-	char *name, *value = c;
-	size_t len;
-	int ret, i;
-
-	name = strsep(&value, "=");
-	if (!name || !value)
-		return -EINVAL;
-
-	i = match_string(rdmacg_resource_names, RDMACG_RESOURCE_MAX, name);
-	if (i < 0)
-		return i;
-
-	len = strlen(value);
-
-	argstr.from = value;
-	argstr.to = value + len;
-
-	ret = match_int(&argstr, intval);
-	if (ret >= 0) {
-		if (*intval < 0)
-			return -EINVAL;
-		return i;
-	}
-	if (strncmp(value, RDMACG_MAX_STR, len) == 0) {
-		*intval = S32_MAX;
-		return i;
-	}
-	return -EINVAL;
-}
-
-static int rdmacg_parse_limits(char *options,
-			       int *new_limits, unsigned long *enables)
-{
-	char *c;
-	int err = -EINVAL;
-
-	/* parse resource options */
-	while ((c = strsep(&options, " ")) != NULL) {
-		int index, intval;
-
-		index = parse_resource(c, &intval);
-		if (index < 0)
-			goto err;
-
-		new_limits[index] = intval;
-		*enables |= BIT(index);
-	}
-	return 0;
-
-err:
-	return err;
-}
-
 static struct rdmacg_device *rdmacg_get_device_locked(const char *name)
 {
 	struct rdmacg_device *device;
@@ -432,6 +393,7 @@ static ssize_t rdmacg_resource_set_max(struct kernfs_open_file *of,
 	struct rdmacg_resource_pool *rpool;
 	struct rdmacg_device *device;
 	char *options = strstrip(buf);
+	char *p;
 	int *new_limits;
 	unsigned long enables = 0;
 	int i = 0, ret = 0;
@@ -449,9 +411,45 @@ static ssize_t rdmacg_resource_set_max(struct kernfs_open_file *of,
 		goto err;
 	}
 
-	ret = rdmacg_parse_limits(options, new_limits, &enables);
-	if (ret)
-		goto parse_err;
+	/* parse resource limit tokens */
+	while ((p = strsep(&options, " \t\n"))) {
+		substring_t args[MAX_OPT_ARGS];
+		int tok, intval;
+
+		if (!*p)
+			continue;
+
+		tok = match_token(p, rdmacg_limit_tokens, args);
+		switch (tok) {
+		case RDMACG_HCA_HANDLE_VAL:
+			if (match_int(&args[0], &intval) || intval < 0) {
+				ret = -EINVAL;
+				goto parse_err;
+			}
+			new_limits[RDMACG_RESOURCE_HCA_HANDLE] = intval;
+			enables |= BIT(RDMACG_RESOURCE_HCA_HANDLE);
+			break;
+		case RDMACG_HCA_HANDLE_MAX:
+			new_limits[RDMACG_RESOURCE_HCA_HANDLE] = S32_MAX;
+			enables |= BIT(RDMACG_RESOURCE_HCA_HANDLE);
+			break;
+		case RDMACG_HCA_OBJECT_VAL:
+			if (match_int(&args[0], &intval) || intval < 0) {
+				ret = -EINVAL;
+				goto parse_err;
+			}
+			new_limits[RDMACG_RESOURCE_HCA_OBJECT] = intval;
+			enables |= BIT(RDMACG_RESOURCE_HCA_OBJECT);
+			break;
+		case RDMACG_HCA_OBJECT_MAX:
+			new_limits[RDMACG_RESOURCE_HCA_OBJECT] = S32_MAX;
+			enables |= BIT(RDMACG_RESOURCE_HCA_OBJECT);
+			break;
+		default:
+			ret = -EINVAL;
+			goto parse_err;
+		}
+	}
 
 	/* acquire lock to synchronize with hot plug devices */
 	mutex_lock(&rdmacg_mutex);
-- 
2.43.0


