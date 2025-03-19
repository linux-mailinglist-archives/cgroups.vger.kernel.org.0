Return-Path: <cgroups+bounces-7153-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C2BDA68A14
	for <lists+cgroups@lfdr.de>; Wed, 19 Mar 2025 11:55:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C736E4226BD
	for <lists+cgroups@lfdr.de>; Wed, 19 Mar 2025 10:55:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EEDF253F31;
	Wed, 19 Mar 2025 10:55:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="pnXW6bHG"
X-Original-To: cgroups@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A10B251796;
	Wed, 19 Mar 2025 10:55:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742381738; cv=none; b=npIcrz/KdpQJYRlbXS+rTs6jdqGiDDv9kN6fmEcWoHe44yUVWb6Q+EH7rYGwWYEm94gHXhtSNFYTXmk2xY6/NJQ5E80Vnq2yLiPS7bcab0fe0cb+odzJQuH66yNW3gwZC7DneXn2uGNB9StB/st1xqy8r+t9Vjxc3WsBN+B0PC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742381738; c=relaxed/simple;
	bh=sYwIt8UDKsFYiP+84kJEcbf3GFh76HnI05oAuSevy2I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=djyJndZz6casXBd0+f1CzJFbbXQizZsxkstiljB+erQay7PnzMIiu3tjt6fUcwLGWrsdTrbRqvubYu7QvUSZxQs1YxiZSl5y3d87jr+yXaKsKT5u7rBjto3DaAPnXMDsrQveaDln8SJjgk7DuuIZs2E5gNWlk82aKmUak8I6dHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=pnXW6bHG; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52J8IFY8008128;
	Wed, 19 Mar 2025 10:55:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=89+2XVLL4j3Qb7axBLp6uQK6454faoebrrpkMa+hy
	Ug=; b=pnXW6bHGNxCn47tRw2MgXqZFZf6SNA5x6fQUD2kDMGid6Egxd9YviXfPX
	5lXp+Ca6xIQOtIbbAuvA1HjKf4r/iEcPvl5++mefZhLkBcUOx+u4oIIe9/kNuRS8
	KfpZzm6CKkpPkegKMJpAxePsVluXq7XjvY1h06/PC9btRWdKCodJQWCJDsDiGT/G
	8umdIpgHoTZhHOTUmW5HSSFvjrbXFtURTF8VciSui1+tlIsnzPLCof6xVOTBfP9J
	Q95VHJUZlSSqiS19iSIh6jYf3Fnq3iJYrVP9HwlAjlnio78MkDDCkxQWqj5zS133
	C/eRwo6xrjcsHYfZ0xPHQj+f8X1Jw==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45fg1yk458-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 19 Mar 2025 10:55:25 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 52J8K7R4032356;
	Wed, 19 Mar 2025 10:55:24 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 45dkvthbg8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 19 Mar 2025 10:55:24 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 52JAtMmu51183966
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 19 Mar 2025 10:55:22 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A1FC92004B;
	Wed, 19 Mar 2025 10:55:22 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E6A0B20043;
	Wed, 19 Mar 2025 10:55:19 +0000 (GMT)
Received: from li-c9696b4c-3419-11b2-a85c-f9edc3bf8a84.in.ibm.com (unknown [9.109.198.185])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 19 Mar 2025 10:55:19 +0000 (GMT)
From: Nilay Shroff <nilay@linux.ibm.com>
To: linux-block@vger.kernel.org, cgroups@vger.kernel.org
Cc: hch@lst.de, hare@suse.de, ming.lei@redhat.com, dlemoal@kernel.org,
        axboe@kernel.dk, tj@kernel.org, josef@toxicpanda.com, gjoyce@ibm.com,
        lkp@intel.com, oliver.sang@intel.com
Subject: [PATCH 0/2] fix locking issues with blk-wbt parameters update
Date: Wed, 19 Mar 2025 16:23:44 +0530
Message-ID: <20250319105518.468941-1-nilay@linux.ibm.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: CwkkyalMebhtg6kQ_21UeSKQAAvF4SsG
X-Proofpoint-ORIG-GUID: CwkkyalMebhtg6kQ_21UeSKQAAvF4SsG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-19_03,2025-03-19_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=564
 priorityscore=1501 malwarescore=0 bulkscore=0 adultscore=0 clxscore=1011
 spamscore=0 lowpriorityscore=0 mlxscore=0 suspectscore=0 phishscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502280000 definitions=main-2503190072

Hi,

This patchset contains two patches.

The first patch fixes a missed release of q->elevator_lock which was
mistakenly omitted in one of the return code path of ioc_qos_write.

The second patch fixes the locdep splat reported due to the incorrect
locking order between q->elevator_lock and q->rq_qos_mutex. The commit 
245618f8e45f ("block: protect wbt_lat_usec using q->elevator_lock") 
introduced q->elevator_lock to protect updates to blk-wbt parameters 
when writing to the sysfs attribute wbt_lat_usec and the cgroup attribute 
io.cost.qos. However, writes to these attributes also acquire q->rq_qos_
mutex, creating a potential circular dependency if the locking order is 
not correctly followed. This patch ensures the correct locking sequence 
to prevent such issues. Unfortunately, blktests currently lacks a test 
case for writes to these attributes, which might have caught this issue 
earlier. I plan to submit a blktest to cover these cases.

Nilay Shroff (2):
  block: release q->elevator_lock in ioc_qos_write
  block: correct locking order for protecting blk-wbt parameters

 block/blk-cgroup.c | 51 ++++++++++++++++++++++++++++++++++++++++++++++
 block/blk-cgroup.h |  2 ++
 block/blk-iocost.c | 17 +++++-----------
 3 files changed, 58 insertions(+), 12 deletions(-)

-- 
2.47.1


