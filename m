Return-Path: <cgroups+bounces-15830-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YB4CL7/vAmrAywEAu9opvQ
	(envelope-from <cgroups+bounces-15830-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Tue, 12 May 2026 11:15:43 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F99551D72E
	for <lists+cgroups@lfdr.de>; Tue, 12 May 2026 11:15:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id D13C9304FAA6
	for <lists+cgroups@lfdr.de>; Tue, 12 May 2026 09:03:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 807FF3A1A44;
	Tue, 12 May 2026 09:01:06 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53DF339937C;
	Tue, 12 May 2026 09:01:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778576465; cv=none; b=jsCc9+2b2OxQbcoTKMcQI8Jl/z5xncDw21uL+pB6IP9/vLbfSwbLiCmki2OJZQ2q82UQrjzUjJSeGDjlDFhGCPcXWy7agwd4Y81qC9roERi2pIWqFpMCYPaxM3xD4KvpHbt9A6UN+YWBa5RaMfFp+bPY19DhmgujM6f5SkQu+YY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778576465; c=relaxed/simple;
	bh=6Z0u23d16c8XJnA5FhWp2rU8pNn6ua0KrG7WvNX7ouU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=OCZ5qpuk8AqqpHdUvQn8qu67o4yWX9AVckPBsumwYo3IRMSOKEjEne2Ylqi0MclUfNQcNHAhiY9JmwrjJNMZ+B3BC3ib2COtG+y327u7hYPw3GQJvcsfy/fZ4qinnWeeYJpIybxZnSeCZ4TBilD3ZwDWtu+oUljtRyflT72KxjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 13ffdcc04de111f1aa26b74ffac11d73-20260512
X-CTIC-Tags:
	HR_CC_COUNT, HR_CC_DOMAIN_COUNT, HR_CC_NAME, HR_CC_NO_NAME, HR_CHARSET
	HR_CHARSET_NUM, HR_CTE_8B, HR_CTT_MISS, HR_DATE_H, HR_DATE_WKD
	HR_DATE_ZONE, HR_FROM_NAME, HR_SJ_LANG, HR_SJ_LEN, HR_SJ_LETTER
	HR_SJ_NOR_SYM, HR_SJ_PHRASE, HR_SJ_PHRASE_LEN, HR_SJ_WS, HR_TO_CHARSET
	HR_TO_CHARSET_NUM, HR_TO_COUNT, HR_TO_DOMAIN_COUNT, HR_TO_NAME, IP_TRUSTED
	SRC_TRUSTED, DN_TRUSTED, SA_TRUSTED, SA_EXISTED, SN_TRUSTED
	SN_EXISTED, SPF_NOPASS, DKIM_NOPASS, DMARC_NOPASS, CIE_GOOD
	CIE_GOOD_SPF, GTI_FG_BS, GTI_RG_INFO, GTI_C_BU, AMN_GOOD
	ABX_MISS_RDNS
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12,REQID:32f6c264-44f3-4f1c-a0bc-d5ae7b2be884,IP:20,
	URL:0,TC:0,Content:0,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:15
X-CID-INFO: VERSION:1.3.12,REQID:32f6c264-44f3-4f1c-a0bc-d5ae7b2be884,IP:20,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:15
X-CID-META: VersionHash:e7bac3a,CLOUDID:8e896fa5dde146f648f103697075b0d5,BulkI
	D:2605121700523Q9ZZCVN,BulkQuantity:0,Recheck:0,SF:17|19|38|66|78|102|127|
	850|898,TC:nil,Content:0|15|50,EDM:-3,IP:-2,URL:0,File:nil,RT:nil,Bulk:nil
	,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:
	0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_FAS,TF_CID_SPAM_FSD
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 13ffdcc04de111f1aa26b74ffac11d73-20260512
X-User: sunshaojie@kylinos.cn
Received: from localhost.localdomain [(223.70.159.239)] by mailgw.kylinos.cn
	(envelope-from <sunshaojie@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 30499878; Tue, 12 May 2026 17:00:52 +0800
From: Sun Shaojie <sunshaojie@kylinos.cn>
To: Waiman Long <longman@redhat.com>,
	Chen Ridong <chenridong@huaweicloud.com>,
	Tejun Heo <tj@kernel.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	=?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>
Cc: cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	sunshaojie <sunshaojie@kylinos.cn>
Subject: [PATCH] cgroup/cpuset: Return only actually allocated CPUs during partition invalidation
Date: Tue, 12 May 2026 17:00:34 +0800
Message-Id: <20260512090034.183133-1-sunshaojie@kylinos.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 8F99551D72E
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.04 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-15830-lists,cgroups=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[kylinos.cn];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FROM_NEQ_ENVFROM(0.00)[sunshaojie@kylinos.cn,cgroups@vger.kernel.org];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.875];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,kylinos.cn:email,kylinos.cn:mid]
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

Fixes: 0c7f293efc87 ("cgroup/cpuset: Add cpuset.cpus.exclusive.effective for v2")
Signed-off-by: sunshaojie <sunshaojie@kylinos.cn>
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


