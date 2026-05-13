Return-Path: <cgroups+bounces-15881-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8PM3KnhWBGqjHAIAu9opvQ
	(envelope-from <cgroups+bounces-15881-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Wed, 13 May 2026 12:46:16 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 06E29531934
	for <lists+cgroups@lfdr.de>; Wed, 13 May 2026 12:46:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 07A77307BCD8
	for <lists+cgroups@lfdr.de>; Wed, 13 May 2026 10:38:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1867A3E5A30;
	Wed, 13 May 2026 10:38:14 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B293E37DE80;
	Wed, 13 May 2026 10:38:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778668693; cv=none; b=A4mho4BBkhPZyDSZdDbVZoOcuiji3RnCs2ksoKdDaGFVhUAx35UddDjt3S2M5QrIZMdSMmN2mNlr+TUp7jDYDKwczuaJPvaQ5TW0PCZZgp3ps/CkeeUah+CnMIaPlakm1NaukRJkIXVSP8QDRthdVxh22yPmVKkhCOvw5jLUMro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778668693; c=relaxed/simple;
	bh=cZze7zXP4tXLthGsb3Vyrx5gJE9uJFeNChnVbAGTKK4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=SnO59BTdJ8nU6PRRAu/nhPthhjv0FhH6WWvr/LuKQZQF6hmlzImxs7VGtE9erH6DLh8aw0N/iOp7SB6re69+eXGGuZj2LtUzpWkpygW7V+zO8O28LNzX8L5U7+vnAsLHJ2PeCdP1djJ0TEcxU1B9d2PmK/4n3yCA8rBldT0LTPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: d37eb4824eb711f1aa26b74ffac11d73-20260513
X-CTIC-Tags:
	HR_CC_COUNT, HR_CC_DOMAIN_COUNT, HR_CC_NAME, HR_CC_NO_NAME, HR_CHARSET
	HR_CHARSET_NUM, HR_CTE_8B, HR_CTT_MISS, HR_DATE_H, HR_DATE_WKD
	HR_DATE_ZONE, HR_FROM_NAME, HR_SJ_DIGIT_LEN, HR_SJ_LANG, HR_SJ_LEN
	HR_SJ_LETTER, HR_SJ_NOR_SYM, HR_SJ_PHRASE, HR_SJ_PHRASE_LEN, HR_SJ_WS
	HR_TO_CHARSET, HR_TO_CHARSET_NUM, HR_TO_COUNT, HR_TO_DOMAIN_COUNT, HR_TO_NAME
	IP_TRUSTED, SRC_TRUSTED, DN_TRUSTED, SA_TRUSTED, SA_EXISTED
	SN_TRUSTED, SN_EXISTED, SPF_NOPASS, DKIM_NOPASS, DMARC_NOPASS
	CIE_GOOD, CIE_GOOD_SPF, GTI_FG_BS, GTI_RG_INFO, GTI_C_BU
	AMN_GOOD, ABX_MISS_RDNS
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12,REQID:1d02204c-bf6f-4e2f-84a3-13e4f8acb5c4,IP:20,
	URL:0,TC:0,Content:0,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:15
X-CID-INFO: VERSION:1.3.12,REQID:1d02204c-bf6f-4e2f-84a3-13e4f8acb5c4,IP:20,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:15
X-CID-META: VersionHash:e7bac3a,CLOUDID:815f06b2d1fd0c0d488fc86a302b9d42,BulkI
	D:260513183806PTAVA6HI,BulkQuantity:0,Recheck:0,SF:17|19|38|66|78|102|127|
	850|898,TC:nil,Content:0|15|50,EDM:-3,IP:-2,URL:0,File:nil,RT:nil,Bulk:nil
	,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:
	0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_FAS,TF_CID_SPAM_FSD
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: d37eb4824eb711f1aa26b74ffac11d73-20260513
X-User: sunshaojie@kylinos.cn
Received: from localhost.localdomain [(223.70.159.239)] by mailgw.kylinos.cn
	(envelope-from <sunshaojie@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 1154263807; Wed, 13 May 2026 18:38:05 +0800
From: Sun Shaojie <sunshaojie@kylinos.cn>
To: Waiman Long <longman@redhat.com>,
	Chen Ridong <chenridong@huaweicloud.com>,
	Tejun Heo <tj@kernel.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	=?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>
Cc: cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	sunshaojie <sunshaojie@kylinos.cn>
Subject: [PATCH v2] cgroup/cpuset: Return only actually allocated CPUs during partition invalidation
Date: Wed, 13 May 2026 18:37:38 +0800
Message-Id: <20260513103738.442779-1-sunshaojie@kylinos.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 06E29531934
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [4.84 / 15.00];
	SEM_URIBL(3.50)[huaweicloud.com:email];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	MAILLIST(-0.15)[generic];
	BAD_REP_POLICIES(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-15881-lists,cgroups=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	GREYLIST(0.00)[pass,body];
	DMARC_NA(0.00)[kylinos.cn];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ARC_ALLOW(0.00)[subspace.kernel.org:s=arc-20240116:i=1];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sunshaojie@kylinos.cn,cgroups@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-0.967];
	RCPT_COUNT_SEVEN(0.00)[8];
	R_DKIM_NA(0.00)[];
	R_SPF_ALLOW(0.00)[+ip4:172.234.253.10:c];
	TAGGED_RCPT(0.00)[cgroups];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,kylinos.cn:email,kylinos.cn:mid,huaweicloud.com:email]
X-Rspamd-Action: no action

From: sunshaojie <sunshaojie@kylinos.cn>

In update_parent_effective_cpumask() with partcmd_invalidate, the CPUs
to return to the parent are computed as:

    adding = cpumask_and(tmp->addmask, xcpus, parent->effective_xcpus);

where xcpus = user_xcpus(cs) which returns cs->exclusive_cpus (if set)
or cs->cpus_allowed. When exclusive_cpus is not set, user_xcpus(cs) can
contain CPUs that were never actually granted to the partition due to
sibling exclusion in compute_excpus(). Consequently, the invalidation
may return CPUs to the parent that remain in use by sibling partitions,
causing overlapping effective_cpus and triggering the
WARN_ON_ONCE(1) in generate_sched_domains().

Use cs->effective_xcpus instead, which reflects the CPUs actually
granted to this partition.

Reproducer (on a 4-CPU machine):

    cd /sys/fs/cgroup
    mkdir a1 b1

    # a1 becomes partition root with CPUs 0-1
    echo "0-1" > a1/cpuset.cpus
    echo "root" > a1/cpuset.cpus.partition

    # b1 becomes partition root with CPUs 1-2, but sibling exclusion
    # reduces its effective_xcpus to CPU 2 only
    echo "1-2" > b1/cpuset.cpus
    echo "root" > b1/cpuset.cpus.partition

    # b1 changes cpus_allowed to 0-1 -> partition invalidation
    echo "0-1" > b1/cpuset.cpus

    # Expected: CPUs 2-3  (only CPU 2 returned from b1)
    # Actual:   CPUs 1-3  (CPU 0-1 returned, overlapping with a1)
    cat cpuset.cpus.effective

dmesg will also show a WARNING from generate_sched_domains() reporting
overlapping partition root effective_cpus.

Fixes: 2a3602030d80 ("cgroup/cpuset: Don't invalidate sibling partitions on cpuset.cpus conflict")
Signed-off-by: sunshaojie <sunshaojie@kylinos.cn>
Test-by: Chen Ridong <chenridong@huaweicloud.com>
Reviewed-by: Chen Ridong <chenridong@huaweicloud.com>

---
Changes in v2:
- Updated Fixes tag per review by Chen Ridong
---
 kernel/cgroup/cpuset.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
index 1335e437098e..2311470ef077 100644
--- a/kernel/cgroup/cpuset.c
+++ b/kernel/cgroup/cpuset.c
@@ -1715,7 +1715,8 @@ static int update_parent_effective_cpumask(struct cpuset *cs, int cmd,
 		 */
 		if (is_partition_valid(parent))
 			adding = cpumask_and(tmp->addmask,
-					     xcpus, parent->effective_xcpus);
+					     cs->effective_xcpus,
+					     parent->effective_xcpus);
 		if (old_prs > 0)
 			new_prs = -old_prs;
 
-- 
2.43.0


