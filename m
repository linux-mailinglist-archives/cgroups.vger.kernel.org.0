Return-Path: <cgroups+bounces-16200-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mPwPBtYMEGpqSwYAu9opvQ
	(envelope-from <cgroups+bounces-16200-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Fri, 22 May 2026 09:59:18 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 398AA5B04A4
	for <lists+cgroups@lfdr.de>; Fri, 22 May 2026 09:59:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 506C1301CF8B
	for <lists+cgroups@lfdr.de>; Fri, 22 May 2026 07:54:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D434D3905F8;
	Fri, 22 May 2026 07:54:38 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20B03320CD3;
	Fri, 22 May 2026 07:54:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779436478; cv=none; b=bu/IR22Z+glIpElfUNDxA91R33u3z4ivgBQwhhS/9Cj/JyZud8pb3sUP8KVfGpfbyq2ESD0WesJAizRkhsT4y2P05JlLEFdckM/iWO9H3hEY+DLVHWDltv5Mx8asvvktI/8b6V4i4FNdWptNYuJQpQf+78+UpJusmxpw2VsI6AE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779436478; c=relaxed/simple;
	bh=19yXxCTNoGDor8FECE2H9b4FwfizRg5vArAjCRyfXuM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=gxXkR8P62ZfYAnMsoxw8YHN8Vi3WJmalKrTrOaTemlR8AqqhQhmaiqBBiXtvG3DU3K1JGM1GHJdec82vwYSSswDBpOuAIUhBVHPi5i9C96M0k4MBDVjujNAa+VthZ0uvhGB9G7NTn/ISeL6H5Br+b+4VKn9lOYzdvtSiCymtLmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 7257989c55b311f1aa26b74ffac11d73-20260522
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12,REQID:8a9fb68f-3e4d-49a9-a16a-2e98f0241f2b,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:e7bac3a,CLOUDID:9ff1e3bee7041725f4c2638d03ae42cc,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:102|850|865|898,TC:nil,Content:0|15|50,E
	DM:-3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA
	:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 7257989c55b311f1aa26b74ffac11d73-20260522
X-User: sunshaojie@kylinos.cn
Received: from localhost.localdomain [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <sunshaojie@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 687849201; Fri, 22 May 2026 15:54:23 +0800
From: Sun Shaojie <sunshaojie@kylinos.cn>
To: Waiman Long <longman@redhat.com>,
	Chen Ridong <chenridong@huaweicloud.com>,
	Tejun Heo <tj@kernel.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	=?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>
Cc: cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Sun Shaojie <sunshaojie@kylinos.cn>
Subject: [PATCH] cgroup/cpuset: Use effective_xcpus in partcmd_update add/del mask calculation
Date: Fri, 22 May 2026 15:53:57 +0800
Message-Id: <20260522075357.127075-1-sunshaojie@kylinos.cn>
X-Mailer: git-send-email 2.25.1
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
	TAGGED_FROM(0.00)[bounces-16200-lists,cgroups=lfdr.de];
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
	NEURAL_HAM(-0.00)[-0.966];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,kylinos.cn:mid,kylinos.cn:email]
X-Rspamd-Queue-Id: 398AA5B04A4
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
Signed-off-by: Sun Shaojie <sunshaojie@kylinos.cn>
---
 kernel/cgroup/cpuset.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
index 1335e437098e..5a5fa2481467 100644
--- a/kernel/cgroup/cpuset.c
+++ b/kernel/cgroup/cpuset.c
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


