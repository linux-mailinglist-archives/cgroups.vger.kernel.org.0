Return-Path: <cgroups+bounces-15185-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eCFLNJk+1WlY3AcAu9opvQ
	(envelope-from <cgroups+bounces-15185-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Tue, 07 Apr 2026 19:27:53 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7458A3B259A
	for <lists+cgroups@lfdr.de>; Tue, 07 Apr 2026 19:27:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 76747308B3A5
	for <lists+cgroups@lfdr.de>; Tue,  7 Apr 2026 17:24:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F2B833D4E8;
	Tue,  7 Apr 2026 17:24:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="lFh9jx7D"
X-Original-To: cgroups@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F0F533262F;
	Tue,  7 Apr 2026 17:24:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775582649; cv=none; b=T9xHpHk+NeS0Qdkb0xCru8vvHg7QYVWhO+a4zbTIgTdkBWXfo8L499UoSxGnNKktah80iAIjAq7Pbltvl/wXqObppl/DuBl85zetWsbJuWMiGqJH7cVQhmO5dSH4m0PiwqAkhab6iNSqQoeR3azphWHxBKH4uGKZ40TbWM52vKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775582649; c=relaxed/simple;
	bh=axM5y/o8FpOCtguoVRVMvvqhBMT7H+XXxGUPfsqUKhw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=AvI01wteD22+GLXQhCY4eb/7B9yTKMbEI7yo2lLm9O89sMC3ksk8vxFBZTkznJHpc62sXN5BBqZ2o3lArZRkLAvmnunhQkR6p9cJHx8PvHr/l/BT8G1QNavaQWoHqHIGeuqyrF7lxb7Nf6F1x8Uican42csBg0h+cNG5Oq40RxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=lFh9jx7D; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 637EAF9m2598628;
	Tue, 7 Apr 2026 17:24:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=corp-2025-04-25; bh=/xJzzR4ouARsSHxhk9+FFA85Eyz86
	yG7pwPPqcVb1RY=; b=lFh9jx7DNAOsH8DaaA4XKFeazg30OqZj8BPerQGpwyUH2
	2S3wuSVU7JlTGLDR6CyXXO624HKB1LW44Po7CDBLmVYKhtQwdaMp0KeCeQ0QPF0j
	cbd5tISFPQR62845NYV/9XSmNeVSd3whAY49QHWA0ZfQ+ZQrtHgr+w7/fxd51e83
	O1/ttnUy9xBBz9u7sb5EO8rQPITMDzj5RrORbbT8tig0n/adnC1/SOaLKLi8Z/t+
	A8gCee8Wd4ls1KMS+F8VSSPddnxb09H5RH/2hdFHfXStQuQF+k7l97XrEZb3FiCf
	ME0PpWgaAKXGI8Cg7Hq6rGWWYtIiXZnG8KzX5ftGA==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4dcmqbhx7g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 07 Apr 2026 17:24:00 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 637Fg5SP003530;
	Tue, 7 Apr 2026 17:23:59 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4dcn5vmt41-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Tue, 07 Apr 2026 17:23:59 +0000
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 637HNxFf037379;
	Tue, 7 Apr 2026 17:23:59 GMT
Received: from psang-work.osdevelopmeniad.oraclevcn.com (psang-work.allregionaliads.osdevelopmeniad.oraclevcn.com [100.100.253.35])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4dcn5vmsw4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Tue, 07 Apr 2026 17:23:59 +0000
From: Prakash Sangappa <prakash.sangappa@oracle.com>
To: linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        cgroups@vger.kernel.org
Cc: davem@davemloft.net, kuba@kernel.org, edumazet@google.com, tj@kernel.org,
        hannes@cmpxchg.org, mkoutny@suse.com, tom.hromatka@oracle.com,
        kamalesh.babulal@oracle.com, prakash.sangappa@oracle.com
Subject: [RFC PATCH 0/1] netlink: Netlink process event for cgroup migration
Date: Tue,  7 Apr 2026 17:23:38 +0000
Message-ID: <20260407172339.2017158-1-prakash.sangappa@oracle.com>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-07_03,2026-04-07_05,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 suspectscore=0 bulkscore=0
 mlxlogscore=610 phishscore=0 adultscore=0 malwarescore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2604010000
 definitions=main-2604070157
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA3MDE1NiBTYWx0ZWRfX5OQ3H1/P667z
 oiw66huVBFiL1vu4dWDJivIhS0cDpXYWhJiwJbzPT2mPP7+0LTQl3IIPc+UVLD6oCE58hJbhUhv
 0EOsg3FzpfwLGYrxby/lk1jaBZ2xTwsV+4TPaPwigK5VHA3ma0VODEiAfbFURpbLOkX0FGomQNA
 cU5Esdpbb3S4MOc3VFjwHJYgpUmVmkePhX6Vhq4251I0M14J1lm4hVYoDFheKA59ZSYQZbq/zY6
 6YdCNplTUomticrEelETwv7OokJPUozpa87/i/R/z+2Io3fyJ+X8MvzBxRo9ptDmLHXZQKSPwdJ
 zKaGkQHMRhg5dW86g4yu7wqikfHMoHMUtwGf2iZGhNN7sFsNJiZXOP6nC+cHJtNTKR+vecv/Cc6
 egamalN8nJpuLh+WL7DQ6G9ys4h1J1JW3k7AUNgjRI0DWe/N30/5UhcQIDLv964n81Sy7u16qDg
 c/B7fAOA/DCN6PzBhP75LRn/if6IyTOjt69LlrwI=
X-Proofpoint-ORIG-GUID: cNMfjP0aKo4U6AuZqWIiZDe6JV7cxW71
X-Proofpoint-GUID: cNMfjP0aKo4U6AuZqWIiZDe6JV7cxW71
X-Authority-Analysis: v=2.4 cv=KO1qylFo c=1 sm=1 tr=0 ts=69d53db0 b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=BqU2WV_vvsyTyxaotp0D:22 a=Nl_3NYohawBlkYsMUqsA:9 cc=ntf awl=host:12291
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[oracle.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[oracle.com:s=corp-2025-04-25];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-15185-lists,cgroups=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_NONE(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[prakash.sangappa@oracle.com,cgroups@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oracle.com:dkim,oracle.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	DKIM_TRACE(0.00)[oracle.com:+];
	TAGGED_RCPT(0.00)[cgroups];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_TWELVE(0.00)[12];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: 7458A3B259A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

With cgroup based resource management, it becomes useful for
userspace to be notified when a task changes cgroup membership.
Unexpected migrations can lead to incorrect resource accounting
and enforcement resulting in undesirable behavior or failures.
Applications/userspace have to poll /proc to detect changes to 
cgroup membership, which is inefficient when dealing with a large
number of tasks.

Add a new netlink proc connector event that gets generated when
a task migrates between cgroups. This allows applications/tools
to monitor cgroup membership changes without periodic polling. 

The netlink proc event will include task's pid/tgid, initiator
process pid/tgid and the cgroup id.  

Prakash Sangappa (1):
  netlink: Add Netlink process event for cgroup migration

 drivers/connector/cn_proc.c  | 28 ++++++++++++++++++++++++++++
 include/linux/cn_proc.h      |  3 +++
 include/uapi/linux/cn_proc.h | 14 ++++++++++++--
 kernel/cgroup/cgroup-v1.c    |  7 ++++++-
 kernel/cgroup/cgroup.c       |  5 ++++-
 5 files changed, 53 insertions(+), 4 deletions(-)

-- 
2.43.7


