Return-Path: <cgroups+bounces-12030-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 52B19C6253F
	for <lists+cgroups@lfdr.de>; Mon, 17 Nov 2025 05:35:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 44FC34E237A
	for <lists+cgroups@lfdr.de>; Mon, 17 Nov 2025 04:35:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2E3830B519;
	Mon, 17 Nov 2025 04:35:42 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 770BF2EC56E;
	Mon, 17 Nov 2025 04:35:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763354142; cv=none; b=cLfBHfL0sMGLyG+3sxbA1JSZ47nzgZp5YbnkLu5VrVer2+tqDuZkRvXaBA1PrIVDUC7koH3xHiEnoAML4rMxUfglsl0CLtGzTahj81XDI58o+jT2sJqv16x+4KAQtgoHOuEhEglSeIluRNwYyvvh3Fxlj7bWS3XP469aFAZ4Mc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763354142; c=relaxed/simple;
	bh=lc3wkzTY1adIG7fu36QrobrMlZATISet2Fq1DN6nmcg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=MXU+FuyVJpJJn4pHdshyPUSXhZZXyMdmTX9VYpSuPShgVkfJF07PXyh4RR+N1eTCNzFRiWFsRkogYYTuW7wnuUhAvZm33RDhvnZQwmbfiMIss+QJybIIGW2E2AoTdQhd707so9mAZQxbVyWpO59f5kgJ1acrX/ikeEtMyTPaGPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: d86ab68cc36e11f0a38c85956e01ac42-20251117
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.6,REQID:fa3f2253-43b5-4794-a2dc-1a2513c12102,IP:10,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:5
X-CID-INFO: VERSION:1.3.6,REQID:fa3f2253-43b5-4794-a2dc-1a2513c12102,IP:10,URL
	:0,TC:0,Content:0,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
	elease,TS:5
X-CID-META: VersionHash:a9d874c,CLOUDID:f5a68f10e5446d71b6c252e4159b51a9,BulkI
	D:2511171235311XBXILTJ,BulkQuantity:0,Recheck:0,SF:17|19|64|66|78|80|81|82
	|83|102|841|850,TC:nil,Content:0|15|50,EDM:-3,IP:-2,URL:0,File:nil,RT:nil,
	Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BR
	R:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_FSD,TF_CID_SPAM_SNR,TF_CID_SPAM_FAS
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: d86ab68cc36e11f0a38c85956e01ac42-20251117
X-User: sunshaojie@kylinos.cn
Received: from localhost.localdomain [(223.70.159.239)] by mailgw.kylinos.cn
	(envelope-from <sunshaojie@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 612225712; Mon, 17 Nov 2025 12:35:29 +0800
From: Sun Shaojie <sunshaojie@kylinos.cn>
To: chenridong@huaweicloud.com
Cc: cgroups@vger.kernel.org,
	hannes@cmpxchg.org,
	linux-kernel@vger.kernel.org,
	longman@redhat.com,
	mkoutny@suse.com,
	tj@kernel.org
Subject: Re: [PATCH -next] cpuset: treate root invalid trialcs as exclusive
Date: Mon, 17 Nov 2025 12:35:16 +0800
Message-Id: <20251117043516.1019183-1-sunshaojie@kylinos.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20251115093140.1121329-1-chenridong@huaweicloud.com>
References: <20251115093140.1121329-1-chenridong@huaweicloud.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On 2025/11/15 09:31, Chen Ridong wrote:
>A test scenario revealed inconsistent results based on operation order:
>Scenario 1:
>	#cd /sys/fs/cgroup/
>	#mkdir A1
>	#mkdir B1
>	#echo 1-2 > B1/cpuset.cpus
>	#echo 0-1 > A1/cpuset.cpus
>	#echo root > A1/cpuset.cpus.partition
>	#cat A1/cpuset.cpus.partition
>	root invalid (Cpu list in cpuset.cpus not exclusive)
>
>Scenario 2:
>	#cd /sys/fs/cgroup/
>	#mkdir A1
>	#mkdir B1
>	#echo 1-2 > B1/cpuset.cpus
>	#echo root > A1/cpuset.cpus.partition
>	#echo 0-1 > A1/cpuset.cpus
>	#cat A1/cpuset.cpus.partition
>	root
>
>The second scenario produces an unexpected result: A1 should be marked
>as invalid but is incorrectly recognized as valid. This occurs because
>when validate_change is invoked, A1 (in root-invalid state) may
>automatically transition to a valid partition, with non-exclusive state
>checks against siblings, leading to incorrect validation.
>
>To fix this inconsistency, treat trialcs in root-invalid state as exclusive
>during validation and set the corresponding exclusive flags, ensuring
>consistent behavior regardless of operation order.
>
>Signed-off-by: Chen Ridong <chenridong@huawei.com>
>---
> kernel/cgroup/cpuset.c | 19 ++++++++++++++-----
> 1 file changed, 14 insertions(+), 5 deletions(-)
>
>diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
>index daf813386260..a189f356b5f1 100644
>--- a/kernel/cgroup/cpuset.c
>+++ b/kernel/cgroup/cpuset.c
>@@ -2526,6 +2526,18 @@ static void partition_cpus_change(struct cpuset *cs, struct cpuset *trialcs,
> 	}
> }
> 
>+static int init_trialcs(struct cpuset *cs, struct cpuset *trialcs)
>+{
>+	trialcs->prs_err = PERR_NONE;
>+	/*
>+	 * If partition_root_state != 0, it may automatically change to a partition,
>+	 * Therefore, we should treat trialcs as exclusive during validation
>+	 */
>+	if (trialcs->partition_root_state)
>+		set_bit(CS_CPU_EXCLUSIVE, &trialcs->flags);
>+	return compute_trialcs_excpus(trialcs, cs);
>+}
>+
> /**
>  * update_cpumask - update the cpus_allowed mask of a cpuset and all tasks in it
>  * @cs: the cpuset to consider
>@@ -2551,9 +2563,7 @@ static int update_cpumask(struct cpuset *cs, struct cpuset *trialcs,
> 	if (alloc_tmpmasks(&tmp))
> 		return -ENOMEM;
> 
>-	compute_trialcs_excpus(trialcs, cs);
>-	trialcs->prs_err = PERR_NONE;
>-
>+	init_trialcs(cs, trialcs);
> 	retval = cpus_allowed_validate_change(cs, trialcs, &tmp);
> 	if (retval < 0)
> 		goto out_free;
>@@ -2612,7 +2622,7 @@ static int update_exclusive_cpumask(struct cpuset *cs, struct cpuset *trialcs,
> 	 * Reject the change if there is exclusive CPUs conflict with
> 	 * the siblings.
> 	 */
>-	if (compute_trialcs_excpus(trialcs, cs))
>+	if (init_trialcs(cs, trialcs))
> 		return -EINVAL;
> 
> 	/*
>@@ -2628,7 +2638,6 @@ static int update_exclusive_cpumask(struct cpuset *cs, struct cpuset *trialcs,
> 	if (alloc_tmpmasks(&tmp))
> 		return -ENOMEM;
> 
>-	trialcs->prs_err = PERR_NONE;
> 	partition_cpus_change(cs, trialcs, &tmp);
> 
> 	spin_lock_irq(&callback_lock);

Hi, Ridong,

Maybe, this patch does not apply to the following cases:
 Step
 #1> echo "root" > A1/cpuset.cpus.partition
 #1> echo "0-1" > B1/cpuset.cpus
 #2> echo "1-2" > A1/cpuset.cpus.exclusive  -> return error
 It should return success here.

Please consider the following modification.

diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
index 52468d2c178a..b4085438368c 100644
--- a/kernel/cgroup/cpuset.c
+++ b/kernel/cgroup/cpuset.c
@@ -609,6 +609,9 @@ static inline bool cpus_excl_conflict(struct cpuset *cs1, struct cpuset *cs2)
 	    cpumask_subset(cs2->cpus_allowed, cs1->exclusive_cpus))
 		return true;
 
+	if (cpumask_empty(cs1->exclusive_cpus))
+		return cpumask_intersects(cs1->cpus_allowed, cs2->cpus_allowed);
+
 	return false;
 }
 
Thanks,
Sun Shaojie

