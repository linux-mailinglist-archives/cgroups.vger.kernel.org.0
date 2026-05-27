Return-Path: <cgroups+bounces-16340-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QG2fDcGXFmq1ngcAu9opvQ
	(envelope-from <cgroups+bounces-16340-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Wed, 27 May 2026 09:05:37 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AA2825E031F
	for <lists+cgroups@lfdr.de>; Wed, 27 May 2026 09:05:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 981C8301F188
	for <lists+cgroups@lfdr.de>; Wed, 27 May 2026 07:05:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B855F3B7B9E;
	Wed, 27 May 2026 07:05:32 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B41F122339;
	Wed, 27 May 2026 07:05:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779865532; cv=none; b=o4aVcZ/LY+Sz4MT2Jc7qQ91VF6AV6SgbMQo3e9/wqXJvxwwM+ZEopfguzRa0uPdDY47eRXSgcKlIx3KaADYnQZdJX/psEIQjPAIBVQt4SNpuhTFHoLmXbkT2ArlOkkTNiL8H1Bj2zcIdhYNk8b8vR+Y/l1yXvHYWvHmIfQNEoDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779865532; c=relaxed/simple;
	bh=VEsHvxZJHPU9nLj5yBeu8jcW9WEiHxVruMlXWI4eyRo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Dfq/JMzjLDJGYwKDKf/5oVrdm0r/jdtgWOS7Yf98wPPC7905PmXFAnb+CD6AMEaZWvQMsz+0+B54p2RYuK2kty8SctRJHnr2Wuck8gNCyvSCP4jPhuPuPYWVtJ7VoZugDfRb58nVw82Q+DbceVPXDbiWz40jsmngF+f/hsJMueU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 6e771ffa599a11f1aa26b74ffac11d73-20260527
X-CTIC-Tags:
	HR_CC_COUNT, HR_CC_DOMAIN_COUNT, HR_CC_NAME, HR_CC_NO_NAME, HR_CHARSET
	HR_CHARSET_NUM, HR_CTE_8B, HR_CTT_MISS, HR_DATE_H, HR_DATE_WKD
	HR_DATE_ZONE, HR_FROM_NAME, HR_SJ_DIGIT_LEN, HR_SJ_LANG, HR_SJ_LEN
	HR_SJ_LETTER, HR_SJ_NOR_SYM, HR_SJ_PHRASE, HR_SJ_PHRASE_LEN, HR_SJ_WS
	HR_TO_CHARSET, HR_TO_CHARSET_NUM, HR_TO_COUNT, HR_TO_DOMAIN_COUNT, HR_TO_NAME
	IP_TRUSTED, SRC_TRUSTED, DN_TRUSTED, SA_TRUSTED, SA_EXISTED
	SN_TRUSTED, SN_EXISTED, SPF_NOPASS, DKIM_NOPASS, DMARC_NOPASS
	CIE_BAD, CIE_GOOD, CIE_GOOD_SPF, GTI_FG_BS, GTI_RG_INFO
	GTI_C_BU, AMN_GOOD, ABX_MISS_RDNS
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12,REQID:ce686c43-7d84-46e0-8979-c54fba9f3255,IP:10,
	URL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:10
X-CID-INFO: VERSION:1.3.12,REQID:ce686c43-7d84-46e0-8979-c54fba9f3255,IP:10,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
	elease,TS:10
X-CID-META: VersionHash:e7bac3a,CLOUDID:927e0f360854b200a12624a74309bb5d,BulkI
	D:26052715052409ZW2TFC,BulkQuantity:0,Recheck:0,SF:10|38|66|78|81|82|102|1
	27|850|865|898,TC:nil,Content:0|15|50,EDM:-3,IP:-2,URL:0,File:nil,RT:nil,B
	ulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR
	:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 6e771ffa599a11f1aa26b74ffac11d73-20260527
X-User: sunshaojie@kylinos.cn
Received: from localhost.localdomain [(223.70.159.239)] by mailgw.kylinos.cn
	(envelope-from <sunshaojie@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 2088613332; Wed, 27 May 2026 15:05:23 +0800
From: Sun Shaojie <sunshaojie@kylinos.cn>
To: Waiman Long <longman@redhat.com>,
	Chen Ridong <chenridong@huaweicloud.com>,
	Tejun Heo <tj@kernel.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	=?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>
Cc: cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	zhangguopeng@kylinos.cn,
	Sun Shaojie <sunshaojie@kylinos.cn>
Subject: [PATCH v2 2/2] cgroup/cpuset: Add test cases for sibling CPU exclusion on partition update
Date: Wed, 27 May 2026 15:05:09 +0800
Message-Id: <20260527070509.648304-1-sunshaojie@kylinos.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260527064329.640060-2-sunshaojie@kylinos.cn>
References: <20260527064329.640060-2-sunshaojie@kylinos.cn>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.04 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-16340-lists,cgroups=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[kylinos.cn];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FROM_NEQ_ENVFROM(0.00)[sunshaojie@kylinos.cn,cgroups@vger.kernel.org];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.975];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	DBL_BLOCKED_OPENRESOLVER(0.00)[kylinos.cn:mid,kylinos.cn:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: AA2825E031F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

When sibling CPU exclusion occurs, a partition's effective_xcpus may be
a subset of its user_xcpus. The partcmd_update path must use
effective_xcpus instead of user_xcpus when calculating CPUs to return
to or request from the parent.

Add two test cases to verify this behavior:

  1) Narrowing cpuset.cpus to only the sibling-excluded CPUs should not
     return CPUs to parent that the partition never actually owned.

  2) Expanding cpuset.cpus after a sibling becomes a member should
     correctly request the additional CPUs from parent.

Co-developed-by: Zhang Guopeng <zhangguopeng@kylinos.cn>
Signed-off-by: Zhang Guopeng <zhangguopeng@kylinos.cn>
Signed-off-by: Sun Shaojie <sunshaojie@kylinos.cn>
---
 tools/testing/selftests/cgroup/test_cpuset_prs.sh | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/tools/testing/selftests/cgroup/test_cpuset_prs.sh b/tools/testing/selftests/cgroup/test_cpuset_prs.sh
index a56f4153c64d..683b05062810 100755
--- a/tools/testing/selftests/cgroup/test_cpuset_prs.sh
+++ b/tools/testing/selftests/cgroup/test_cpuset_prs.sh
@@ -492,6 +492,16 @@ REMOTE_TEST_MATRIX=(
 	"  C1-5:P1   .  C1-4:P1   C2-3     .       .  \
 	      .      .     .       P1      .       .     p1:5|c11:1-4|c12:5 \
 							 p1:P1|c11:P1|c12:P-1"
+	# Narrowing cpuset.cpus to previously sibling-excluded CPUs should
+	# not return CPUs that were never actually owned.
+	"  C1-4:P1   .   C1-2:P1  C1-3:P2  .       .  \
+	      .      .     .         C3    .       .     p1:4|c11:1-2|c12:3 \
+							 p1:P1|c11:P1|c12:P2 3"
+	# Expanding cpuset.cpus to include a previously sibling-excluded CPU
+	# after the sibling has become a member should correctly request it.
+	"  C1-4:P1   .   C1-2:P1  C1-3:P2  .       .  \
+	      .      .      P0     C2-3    .       .     p1:1,4|c11:1|c12:2-3 \
+							 p1:P1|c11:P0|c12:P2 2-3"
 )
 
 #
-- 
2.43.0


