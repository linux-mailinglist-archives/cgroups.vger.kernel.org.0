Return-Path: <cgroups+bounces-9603-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9348BB3F3C2
	for <lists+cgroups@lfdr.de>; Tue,  2 Sep 2025 06:27:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2E0913B3015
	for <lists+cgroups@lfdr.de>; Tue,  2 Sep 2025 04:27:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AE4C25EFBB;
	Tue,  2 Sep 2025 04:27:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="RZ93D43K"
X-Original-To: cgroups@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69D7F146D45;
	Tue,  2 Sep 2025 04:27:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756787229; cv=none; b=ghEwAIYQgdfduBKBupuLrqX3maInbb4gTN1ZxhkkbA6/SqWrPzRUpl7NxIDamsP51el5wBGXAM9dBgrtJ/ThYseHtxusPBDGL/Meo1juuXJyZRv7TprYjU8vceSoVrQKuv5gmzNI6o61y10F3sBlAEVI+KAfiZzX2iN2V+ub64o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756787229; c=relaxed/simple;
	bh=BzEQe7z2eZIf/9PZ+iso7TZVX1oUzVRZugXRarpVhfo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:To:CC; b=HPMNTWr3yJpZwRDeJtoesG8u6up6oSXYwXs7fxXQ4MsE7HrvbgCHhSxW1xpMXspR7XJjezrg+Kgr5UEXCDenh85+In/qa2Gocu8Ni8OaJRYVwabr7ANMcxyOU2S3ZcTdn2RhrMT02TwIerIPbiT2/8869BB9cbjf+XXQfSAmzDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=RZ93D43K; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5822SJZA013446;
	Tue, 2 Sep 2025 04:26:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=DBb++vrz8+pFt/pxc18p1N
	Mxi16v2g61+luakcGnuzI=; b=RZ93D43KHudNTo5usC6M0ldNePFtD+oUxW/dYE
	Tb0yvJOv/+vAfr8U/ViPVZod/koGKuPR6bE+GFX6qWt2sA0jygDg9i9PQkSPNjwS
	7oPHii1fxUIBqFa12hbCVigV7stoxaz8CBd1MBBWA3HFn5K4FS+y/Q/LkYoOpNHI
	AT0JRX5zK6km2Vu/n9LQA476UXLQurGwct99KnqpRvGI3sbOlJowdu2j0nZW1L2u
	bQgQHzUJwDzVQRtA5GChSlpbixc2hDFS8eFfVqSVi9L4WgUSVfXhad0A09aEMWCt
	6/0SiBzTJdGdpq43TcsVA8sqEvyCVGpdNQmBfBM/2aJCR1/Q==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48ut2fecp7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 02 Sep 2025 04:26:58 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 5824QvJ1031151
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 2 Sep 2025 04:26:57 GMT
Received: from hu-ashayj-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.24; Mon, 1 Sep 2025 21:26:54 -0700
From: Ashay Jaiswal <quic_ashayj@quicinc.com>
Date: Tue, 2 Sep 2025 09:56:17 +0530
Subject: [PATCH] cpuset: prevent freeing unallocated cpumask in hotplug
 handling
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20250902-cpuset-free-on-condition-v1-1-f46ffab53eac@quicinc.com>
X-B4-Tracking: v=1; b=H4sIAOhxtmgC/x3MMQqFMBBF0a3I1H8gBgV1K2KhkxedJpFEP4K4d
 4PlLc69KSMpMg3VTQl/zRpDifpXkWxzWMHqSpM1tjW9sSz7mXGwTwDHwBKD06Mg7lrxDWa31J1
 Q4XuC1+tbj9PzvIn9xKxqAAAA
X-Change-ID: 20250902-cpuset-free-on-condition-85cf4eadb18c
To: Waiman Long <longman@redhat.com>, Tejun Heo <tj@kernel.org>,
        "Johannes
 Weiner" <hannes@cmpxchg.org>,
        =?utf-8?q?Michal_Koutn=C3=BD?=
	<mkoutny@suse.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>
CC: <cgroups@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <stable@vger.kernel.org>, Ashay Jaiswal <quic_ashayj@quicinc.com>
X-Mailer: b4 0.14.2
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODMwMDAzOCBTYWx0ZWRfX+nE8uaPrnf/U
 ycuRSs0XBjnYFSWGgDE2u5KKONR7fvanxtN8n0IjxQyEs/NIuNqKjyzO7zJoDwT70+eYK8v6Rpk
 3i1UzdtIBd9XB+hpnqlCNOCuADLlIOdr8UWMV7m4SXhMMKg6bVQD8QtK6OUCXSJmQtsJ6qouNHI
 zDtzl9akVSwhJaZ5QYNBKnPLSAeyZhDzDsPy5T6COXyDbFR+ZAUwaQIs1zOoOPx1Zl6wPXrqVqJ
 mygBjnO6OPIovWHvxqDos+uV8vT/aHXDkKn6oLWNPQ8WzBWT1GIjBBXl06ReUvyf1tnzPCqJp6s
 bR4vWWU06ckqTxfT5A6Dn1PqcQbx9inOONwyttMMFNJ7CoN+kzcTz6j9NNNXIDT30gcXX0DEQXC
 zVNxbPqf
X-Proofpoint-ORIG-GUID: rFcTCFlEdLvgF89P4R4FONRQDJGH3C1K
X-Proofpoint-GUID: rFcTCFlEdLvgF89P4R4FONRQDJGH3C1K
X-Authority-Analysis: v=2.4 cv=U7iSDfru c=1 sm=1 tr=0 ts=68b67212 cx=c_pps
 a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=GEpy-HfZoHoA:10 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=VwQbUJbxAAAA:8
 a=COk6AnOGAAAA:8 a=RKQ4q15g12NdbudFmkEA:9 a=QEXdDO2ut3YA:10
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-02_01,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 clxscore=1011 impostorscore=0 suspectscore=0
 malwarescore=0 priorityscore=1501 adultscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508300038

In cpuset hotplug handling, temporary cpumasks are allocated only when
running under cgroup v2. The current code unconditionally frees these
masks, which can lead to a crash on cgroup v1 case.

Free the temporary cpumasks only when they were actually allocated.

Fixes: 4b842da276a8 ("cpuset: Make CPU hotplug work with partition")
Cc: stable@vger.kernel.org
Signed-off-by: Ashay Jaiswal <quic_ashayj@quicinc.com>
---
 kernel/cgroup/cpuset.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
index a78ccd11ce9b43c2e8b0e2c454a8ee845ebdc808..a4f908024f3c0a22628a32f8a5b0ae96c7dccbb9 100644
--- a/kernel/cgroup/cpuset.c
+++ b/kernel/cgroup/cpuset.c
@@ -4019,7 +4019,8 @@ static void cpuset_handle_hotplug(void)
 	if (force_sd_rebuild)
 		rebuild_sched_domains_cpuslocked();
 
-	free_tmpmasks(ptmp);
+	if (on_dfl && ptmp)
+		free_tmpmasks(ptmp);
 }
 
 void cpuset_update_active_cpus(void)

---
base-commit: 33bcf93b9a6b028758105680f8b538a31bc563cf
change-id: 20250902-cpuset-free-on-condition-85cf4eadb18c

Best regards,
-- 
Ashay Jaiswal <quic_ashayj@quicinc.com>


