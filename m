Return-Path: <cgroups+bounces-15368-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yJlzJTKx5Wl+nAEAu9opvQ
	(envelope-from <cgroups+bounces-15368-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Mon, 20 Apr 2026 06:53:06 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A3836426C6A
	for <lists+cgroups@lfdr.de>; Mon, 20 Apr 2026 06:53:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 02595300F5D2
	for <lists+cgroups@lfdr.de>; Mon, 20 Apr 2026 04:53:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42BB837EFE1;
	Mon, 20 Apr 2026 04:53:03 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF449379EFF
	for <cgroups@vger.kernel.org>; Mon, 20 Apr 2026 04:52:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776660783; cv=none; b=NCxqCdsLVOsc393iTINNoHAxe4OfG6qjB7UX4r9CW6I6Ljc5PBTORGTgQeOllrxPhxH+h4Woh9FmWBO45alDfoZzguP54CsjqzYYRNtAG8HwR0gUIs+0E0MwrddGSyKtENf1+897Qd3H0zPl+ISs4ABAll2yLSN/CmFgNZuC7d4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776660783; c=relaxed/simple;
	bh=yCa9k1Wxutu7HtW0Je0sCY/bOi4RPvQGVOanVGBq5oU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qGSMQuN9AK7JzOvhxWXHsObv4KV+HK0yC4gOrI0zJa09wwQnDubFHsxd58152IqH7ujjSQ535fWsps43Qd6w/ZyCkRYQ1iLTMNqTSfWoRiUAtwqPaPBAjjAUsWrltdmtjxUx2GnW7e4RsPov3De0YuCKdBIleRl674mMgJPF6kI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: c892edea3c7411f1aa26b74ffac11d73-20260420
X-CTIC-Tags:
	HR_CC_COUNT, HR_CC_DOMAIN_COUNT, HR_CC_NO_NAME, HR_CTE_8B, HR_CTT_TXT
	HR_DATE_H, HR_DATE_WKD, HR_DATE_ZONE, HR_FROM_NAME, HR_SJ_DIGIT_LEN
	HR_SJ_LANG, HR_SJ_LEN, HR_SJ_LETTER, HR_SJ_NOR_SYM, HR_SJ_PHRASE
	HR_SJ_PHRASE_LEN, HR_SJ_WS, HR_TO_COUNT, HR_TO_DOMAIN_COUNT, HR_TO_NO_NAME
	IP_TRUSTED, SRC_TRUSTED, DN_TRUSTED, SA_TRUSTED, SA_EXISTED
	SN_TRUSTED, SN_EXISTED, SPF_NOPASS, DKIM_NOPASS, DMARC_NOPASS
	CIE_BAD, CIE_GOOD, CIE_GOOD_SPF, GTI_FG_BS, GTI_C_CI
	GTI_FG_IT, GTI_RG_INFO, GTI_C_BU, AMN_GOOD, ABX_MISS_RDNS
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12,REQID:4168c0a8-2156-45e0-8e87-d7251f6427a0,IP:10,
	URL:0,TC:0,Content:100,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACT
	ION:release,TS:105
X-CID-INFO: VERSION:1.3.12,REQID:4168c0a8-2156-45e0-8e87-d7251f6427a0,IP:10,UR
	L:0,TC:0,Content:100,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Spam_GS981B3D,ACT
	ION:quarantine,TS:105
X-CID-META: VersionHash:e7bac3a,CLOUDID:5827574a0c7fc546fd8ea6e179fcc434,BulkI
	D:260420125253MR60LHXZ,BulkQuantity:0,Recheck:0,SF:17|19|66|78|81|82|127|8
	98,TC:nil,Content:3|15|50,EDM:-3,IP:-2,URL:1,File:nil,RT:nil,Bulk:nil,QS:n
	il,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC
	:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ASC,TF_CID_SPAM_FAS,TF_CID_SPAM_FSD,
	TF_CID_SPAM_ULS
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: c892edea3c7411f1aa26b74ffac11d73-20260420
X-User: cuitao@kylinos.cn
Received: from ctao-book.. [(183.242.174.20)] by mailgw.kylinos.cn
	(envelope-from <cuitao@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 1370524214; Mon, 20 Apr 2026 12:52:50 +0800
From: cuitao <cuitao@kylinos.cn>
To: mkoutny@suse.com
Cc: cgroups@vger.kernel.org,
	cuitao@kylinos.cn,
	hannes@cmpxchg.org,
	tj@kernel.org
Subject: [PATCH v2] cgroup/rdma: refactor resource parsing with match_table_t/match_token()
Date: Mon, 20 Apr 2026 12:52:33 +0800
Message-ID: <20260420045233.116375-1-cuitao@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <t2cbjvctdgzipxzovr5zkbovhptkxdaoxljeuxwrxboqqbkzqu@bcazimapp6ci>
References: <t2cbjvctdgzipxzovr5zkbovhptkxdaoxljeuxwrxboqqbkzqu@bcazimapp6ci>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_RCPT(0.00)[cgroups];
	FORGED_SENDER_MAILLIST(0.00)[];
	R_DKIM_NA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DMARC_NA(0.00)[kylinos.cn];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,kylinos.cn:mid,kylinos.cn:email];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cuitao@kylinos.cn,cgroups@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_FROM(0.00)[bounces-15368-lists,cgroups=lfdr.de];
	TO_DN_NONE(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5]
X-Rspamd-Queue-Id: A3836426C6A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Replace the hand-rolled strsep/strcmp/match_string parsing in
rdmacg_resource_set_max() with a match_table_t and match_token()
pattern, following the convention used by user_proactive_reclaim()
and ioc_cost_model_write().

This fixes the original strncmp(value, RDMACG_MAX_STR, strlen(value))
bug that matched "ma" as "max", and also robustly handles extra
whitespace in the input by splitting on " \t\n" and skipping empty
tokens.

Suggested-by: "Michal Koutný" <mkoutny@suse.com>
Signed-off-by: cuitao <cuitao@kylinos.cn>

---
Changes in v2:
- Refactor to use match_table_t/match_token() as suggested by Michal Koutný
  Link: https://lore.kernel.org/all/t2cbjvctdgzipxzovr5zkbovhptkxdaoxljeuxwrxboqqbkzqu@bcazimapp6ci/
---
 kernel/cgroup/rdma.c | 120 ++++++++++++++++++++-----------------------
 1 file changed, 57 insertions(+), 63 deletions(-)

diff --git a/kernel/cgroup/rdma.c b/kernel/cgroup/rdma.c
index 9967fb25c563..48d6bc7d9624 100644
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
@@ -474,10 +472,6 @@ static ssize_t rdmacg_resource_set_max(struct kernfs_open_file *of,
 
 	if (rpool->usage_sum == 0 &&
 	    rpool->num_max_cnt == RDMACG_RESOURCE_MAX) {
-		/*
-		 * No user of the rpool and all entries are set to max, so
-		 * safe to delete this rpool.
-		 */
 		free_cg_rpool_locked(rpool);
 	}
 
-- 
2.43.0


