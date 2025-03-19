Return-Path: <cgroups+bounces-7154-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 57A0DA68A16
	for <lists+cgroups@lfdr.de>; Wed, 19 Mar 2025 11:55:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DDEDA42299B
	for <lists+cgroups@lfdr.de>; Wed, 19 Mar 2025 10:55:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E666925486F;
	Wed, 19 Mar 2025 10:55:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="UdOBKBvl"
X-Original-To: cgroups@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B29B251796;
	Wed, 19 Mar 2025 10:55:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742381741; cv=none; b=aGxKHJYiPFZnMxAy4GR8BMy/3y5SxUsRm8kYA2GNSjU3Q4wDx/kmKQYfKTB4xTfpE2ZzRCYdYRTgbIDId6LgE+eDFw2LiWkhbUMa+7t2PhZGHmr2bl2c4oFtL9zTmf2+hKTJeAhqOqd0U6rfvPexJ47tM3RYVzplU/Aj8SVwDfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742381741; c=relaxed/simple;
	bh=YhDjtau0Ur47kT9FDi9sqfGrSlyg86Gx3w05as78sDs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IGtDm6SIvKzXLyDLcSrGb+V8PhXV/RjCO2wEf1oshuG5srGURjbaQRuKmF0camIRiq7VYK+P9ODPkg9Zm4cnNzStXJhNYXqombG2b83M6hKOHJHdeTfDnEjao641+L0Lo+BRrU+vKBehUayKE//5wAYsovivJoYyi5OWP+4lohs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=UdOBKBvl; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52J8qtGA008117;
	Wed, 19 Mar 2025 10:55:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=YgRMJOtBYGFKIrW2n
	V2OBGkOO0bjjFUww/5HuaT8054=; b=UdOBKBvlwPVQE2n3UL4QYcyAkXrklf/nb
	h6idGvRfsSMhwdTqdOhDv7ZObtd+AW0KwHIm1V3N1z2FhhjvzXNr4KfNBd02Iwsd
	i5KUe/lpDUjhgBonUNwbBUaGQtlsSHcU2yEpVimq2gby4VuEhKljBk1oMuow77yq
	mJw+W2t7XEPKV4wFTCgIMMVYiUS8Dv7iU08vUKkhfsQNHU7tRWeY8dByNGfPtEfc
	NOzCvAn1uleXLf+nNJs5ptJIQAhVZlfXEEQVRF7aRT4OoQ+ifh7cHUFFJ6onBGo9
	FjD4/r1WxIhTdERtkKwq8eQs6sj/hy177+ufyQfJZ+wFoVP6+x++A==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45fg1yk45b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 19 Mar 2025 10:55:28 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 52J9GFYE012451;
	Wed, 19 Mar 2025 10:55:28 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 45dmvp14ax-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 19 Mar 2025 10:55:27 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 52JAtQRx56426812
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 19 Mar 2025 10:55:26 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id F18D32004B;
	Wed, 19 Mar 2025 10:55:25 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1DBE920043;
	Wed, 19 Mar 2025 10:55:23 +0000 (GMT)
Received: from li-c9696b4c-3419-11b2-a85c-f9edc3bf8a84.in.ibm.com (unknown [9.109.198.185])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 19 Mar 2025 10:55:22 +0000 (GMT)
From: Nilay Shroff <nilay@linux.ibm.com>
To: linux-block@vger.kernel.org, cgroups@vger.kernel.org
Cc: hch@lst.de, hare@suse.de, ming.lei@redhat.com, dlemoal@kernel.org,
        axboe@kernel.dk, tj@kernel.org, josef@toxicpanda.com, gjoyce@ibm.com,
        lkp@intel.com, oliver.sang@intel.com
Subject: [PATCH 1/2] block: release q->elevator_lock in ioc_qos_write
Date: Wed, 19 Mar 2025 16:23:45 +0530
Message-ID: <20250319105518.468941-2-nilay@linux.ibm.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250319105518.468941-1-nilay@linux.ibm.com>
References: <20250319105518.468941-1-nilay@linux.ibm.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: _ubETg40YwhBTxCz3CGWdpJvWmVbZxNh
X-Proofpoint-ORIG-GUID: _ubETg40YwhBTxCz3CGWdpJvWmVbZxNh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-19_03,2025-03-19_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999
 priorityscore=1501 malwarescore=0 bulkscore=0 adultscore=0 clxscore=1015
 spamscore=0 lowpriorityscore=0 mlxscore=0 suspectscore=0 phishscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502280000 definitions=main-2503190072

The ioc_qos_write method acquires q->elevator_lock to protect
updates to blk-wbt parameters. Once these updates are complete,
the lock should be released before returning from ioc_qos_write.

However, in one code path, the release of q->elevator_lock was
mistakenly omitted, potentially leading to a lock leak. This commit
fixes the issue by ensuring that q->elevator_lock is properly
released in all return paths of ioc_qos_write.

Fixes: 245618f8e45f ("block: protect wbt_lat_usec using q->elevator_lock")
Reported-by: kernel test robot <oliver.sang@intel.com>
Closes: https://lore.kernel.org/oe-lkp/202503171650.cc082b66-lkp@intel.com
Signed-off-by: Nilay Shroff <nilay@linux.ibm.com>
---
 block/blk-iocost.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/block/blk-iocost.c b/block/blk-iocost.c
index 38e7bf3c3b4f..56e6fb51316d 100644
--- a/block/blk-iocost.c
+++ b/block/blk-iocost.c
@@ -3348,6 +3348,7 @@ static ssize_t ioc_qos_write(struct kernfs_open_file *of, char *input,
 		wbt_enable_default(disk);
 
 	blk_mq_unquiesce_queue(disk->queue);
+	mutex_unlock(&disk->queue->elevator_lock);
 	blk_mq_unfreeze_queue(disk->queue, memflags);
 
 	blkg_conf_exit(&ctx);
-- 
2.47.1


