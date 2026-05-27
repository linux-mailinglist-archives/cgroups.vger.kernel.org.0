Return-Path: <cgroups+bounces-16339-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SGWEFLuSFmrqnQcAu9opvQ
	(envelope-from <cgroups+bounces-16339-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Wed, 27 May 2026 08:44:11 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C26C85DFF5B
	for <lists+cgroups@lfdr.de>; Wed, 27 May 2026 08:44:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5E8E13035F16
	for <lists+cgroups@lfdr.de>; Wed, 27 May 2026 06:44:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E34073A75A4;
	Wed, 27 May 2026 06:44:04 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12A3D3A963B;
	Wed, 27 May 2026 06:44:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779864244; cv=none; b=CMgVmDSBGRWA/yGbwv/nJfF/dh/ZEPcuzXaDOKU51n6AsAT71uz367OCtQvS975RYlSyRb8VeXcH9H4xirUHKJjThF/xPn8HribOR6luTM/zTYiN0BSDse/M5lQc8iu9zbvVf7ypNM5eGAKi7RDZHqSMoYdPu9A8n0zb7SMeipU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779864244; c=relaxed/simple;
	bh=0JTimoMl7gshu0yNbPDuct02AhsB59YOb36+d2iboqE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Hq6Ieypc5CP5Vv/94gIutVdsaeWqNWeEFhRVqvfMVfsGm1gNm4js+PvqDEB110UPh7HY+md3W+l9EvlA+y3oEaLJC9RuZayawe2oOuJs2f6peYeX+zDirp8jeokyKYncCPn2n3VXzxCMW9HXLhF9+iAqemhi5lwryaP/AZqBrbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 6e6cd048599711f1aa26b74ffac11d73-20260527
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
X-CID-O-INFO: VERSION:1.3.12,REQID:dd89e4b2-0e91-4cdb-9774-a53958460a1a,IP:10,
	URL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:10
X-CID-INFO: VERSION:1.3.12,REQID:dd89e4b2-0e91-4cdb-9774-a53958460a1a,IP:10,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
	elease,TS:10
X-CID-META: VersionHash:e7bac3a,CLOUDID:43d6578e3ff58f01140515b261e6fed6,BulkI
	D:2605271443578UG0BU4G,BulkQuantity:0,Recheck:0,SF:10|38|66|78|81|82|102|1
	27|850|865|898,TC:nil,Content:0|15|50,EDM:-3,IP:-2,URL:0,File:nil,RT:nil,B
	ulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR
	:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 6e6cd048599711f1aa26b74ffac11d73-20260527
X-User: sunshaojie@kylinos.cn
Received: from localhost.localdomain [(223.70.159.239)] by mailgw.kylinos.cn
	(envelope-from <sunshaojie@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 1620062406; Wed, 27 May 2026 14:43:55 +0800
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
Subject: [PATCH v2 1/2] cgroup/cpuset: Use effective_xcpus in partcmd_update add/del mask calculation
Date: Wed, 27 May 2026 14:43:28 +0800
Message-Id: <20260527064329.640060-2-sunshaojie@kylinos.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260527064329.640060-1-sunshaojie@kylinos.cn>
References: <20260527064329.640060-1-sunshaojie@kylinos.cn>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-16339-lists,cgroups=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[kylinos.cn];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FROM_NEQ_ENVFROM(0.00)[sunshaojie@kylinos.cn,cgroups@vger.kernel.org];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.968];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,kylinos.cn:mid,kylinos.cn:email]
X-Rspamd-Queue-Id: C26C85DFF5B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

When sibling CPU exclusion occurs, a partition's user_xcpus may contain
CPUs that were never actually granted to it. These CPUs are present in
user_xcpus(cs) but not in cs->effective_xcpus.

The partcmd_update path in update_parent_effective_cpumask() uses
user_xcpus(cs) (via the local variable xcpus) to compute the addmask
(CPUs to return to parent) and delmask (CPUs to request from parent).
This is incorrect:

 1) When newmask removes a CPU that was previously excluded by a
    sibling, addmask incorrectly includes that CPU and tries to return
    it to the parent even though the partition never actually owned it,
    causing CPU overlap with sibling partitions and triggering warnings
    in generate_sched_domains().

 2) When newmask adds a previously excluded CPU that is now available,
    delmask fails to request it from the parent because user_xcpus(cs)
    already includes it.

Fix this by using cs->effective_xcpus instead of user_xcpus(cs) in all
partcmd_update paths that calculate addmask or delmask, including the
PERR_NOCPUS error handling paths.

Reproducers:

  Example 1 - Removing a sibling-excluded CPU incorrectly returns it:

    # cd /sys/fs/cgroup
    # echo "0-1" > a1/cpuset.cpus
    # echo "root" > a1/cpuset.cpus.partition
    # echo "0-2" > b1/cpuset.cpus
    # echo "root" > b1/cpuset.cpus.partition
    # echo "2" > b1/cpuset.cpus
    # cat cpuset.cpus.effective
    # Actual: 0-1,3    Expected: 3

  Example 2 - Expanding to a previously excluded CPU fails to request it:

    # cd /sys/fs/cgroup
    # echo "0-1" > a1/cpuset.cpus
    # echo "root" > a1/cpuset.cpus.partition
    # echo "0-2" > b1/cpuset.cpus
    # echo "root" > b1/cpuset.cpus.partition
    # echo "member" > a1/cpuset.cpus.partition
    # echo "1-2" > b1/cpuset.cpus
    # cat cpuset.cpus.effective
    # Actual: 0-1,3    Expected: 0,3

Fixes: 2a3602030d80 ("cgroup/cpuset: Don't invalidate sibling partitions on cpuset.cpus conflict")
Suggested-by: Zhang Guopeng <zhangguopeng@kylinos.cn>
Signed-off-by: Sun Shaojie <sunshaojie@kylinos.cn>
---
 kernel/cgroup/cpuset.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
index 1335e437098e..2395c5aec871 100644
--- a/kernel/cgroup/cpuset.c
+++ b/kernel/cgroup/cpuset.c
@@ -1807,9 +1807,9 @@ static int update_parent_effective_cpumask(struct cpuset *cs, int cmd,
 		 * Compute add/delete mask to/from effective_cpus
 		 *
 		 * For valid partition:
-		 *   addmask = exclusive_cpus & ~newmask
+		 *   addmask = effective_xcpus & ~newmask
 		 *			      & parent->effective_xcpus
-		 *   delmask = newmask & ~exclusive_cpus
+		 *   delmask = newmask & ~effective_xcpus
 		 *		       & parent->effective_xcpus
 		 *
 		 * For invalid partition:
@@ -1821,11 +1821,11 @@ static int update_parent_effective_cpumask(struct cpuset *cs, int cmd,
 			deleting = cpumask_and(tmp->delmask,
 					newmask, parent->effective_xcpus);
 		} else {
-			cpumask_andnot(tmp->addmask, xcpus, newmask);
+			cpumask_andnot(tmp->addmask, cs->effective_xcpus, newmask);
 			adding = cpumask_and(tmp->addmask, tmp->addmask,
 					     parent->effective_xcpus);
 
-			cpumask_andnot(tmp->delmask, newmask, xcpus);
+			cpumask_andnot(tmp->delmask, newmask, cs->effective_xcpus);
 			deleting = cpumask_and(tmp->delmask, tmp->delmask,
 					       parent->effective_xcpus);
 		}
@@ -1864,7 +1864,7 @@ static int update_parent_effective_cpumask(struct cpuset *cs, int cmd,
 			part_error = PERR_NOCPUS;
 			deleting = false;
 			adding = cpumask_and(tmp->addmask,
-					     xcpus, parent->effective_xcpus);
+					     cs->effective_xcpus, parent->effective_xcpus);
 		}
 	} else {
 		/*
@@ -1886,7 +1886,8 @@ static int update_parent_effective_cpumask(struct cpuset *cs, int cmd,
 			part_error = PERR_NOCPUS;
 			if (is_partition_valid(cs))
 				adding = cpumask_and(tmp->addmask,
-						xcpus, parent->effective_xcpus);
+						     cs->effective_xcpus,
+						     parent->effective_xcpus);
 		} else if (is_partition_invalid(cs) && !cpumask_empty(xcpus) &&
 			   cpumask_subset(xcpus, parent->effective_xcpus)) {
 			struct cgroup_subsys_state *css;
-- 
2.43.0


