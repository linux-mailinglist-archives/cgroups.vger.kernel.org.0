Return-Path: <cgroups+bounces-8496-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A0C15AD6296
	for <lists+cgroups@lfdr.de>; Thu, 12 Jun 2025 00:40:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4FFC31E0A1F
	for <lists+cgroups@lfdr.de>; Wed, 11 Jun 2025 22:40:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 298F824E4AF;
	Wed, 11 Jun 2025 22:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="W6EwsrQJ"
X-Original-To: cgroups@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46D9124728D;
	Wed, 11 Jun 2025 22:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749681631; cv=none; b=FJh4lnCcXteTx4qzJQGSNstxkysc+dPUjHPHPXFJc/PNWlvE1knuMlpFqrdE4Ihf74GxiTCWwBBjRGXQ32baCXZX6hLnXYYDA49M9ONMF/Nx6LwhiJt7on56DjJPSzE2IeGmdqRStTBBOscgjXfVOfY6WxI19QEkzsTFymaucxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749681631; c=relaxed/simple;
	bh=bhg6VV5fefD5/D2dMoTu5GchPBluVIuYo6VdkzioHd8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AdmdNUUXFVE4rIh7AYTf8tUzMw4FJd0fXaRc8xfPkcFaZmXAOe7BqJ+GuNBa3zO4uDMta1aq287FZwNwHTggtsreJJFsMxNnCnPIqKWhpjGBu9C4/zO+kXlAl6AmAf+iohbBVfjbhmimyXINwS+SnTYzoJWV/PQttcBhLaR6I6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=W6EwsrQJ; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55BMPKeB016901;
	Wed, 11 Jun 2025 22:40:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2025-04-25; bh=c2rub
	8hiefcE3BLuft3zzQ4IjsFpqXPHaMjPhaIqefU=; b=W6EwsrQJIXudQ5Dem7II8
	r7KQN/LISmIkXO20bHINZGLqZuCG8LgjyNmvZQnGt9II/Jcn1QRbmprccjie6okJ
	2QGUGJx5uVldNm86z4IxpKftJSSyKqcm8VB6UiZCi9cOk75/P6Rh85+4JFZHa/+k
	stLgkLSoWlxyahaRo8GsE4VnDSy5wnqw7NMfyi42EQDnpbvD4y6ypW8Eef45vNXz
	jYmiQS5fOzRIwHoswmP9IQPz6mDWWUcBGImFxhd/hzNPzWazRP8Ei+9j/KqAUcGC
	RpBMAFJGOFQjjVq8zCbDfD6uLySmWkLG41LXb9+msM4LLdHax+O0SaNvEmGmNe5R
	Q==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 474c750nb1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 11 Jun 2025 22:40:23 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 55BLrBr7021009;
	Wed, 11 Jun 2025 22:40:23 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 474bvh2j4e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 11 Jun 2025 22:40:23 +0000
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 55BMeMxU024452;
	Wed, 11 Jun 2025 22:40:22 GMT
Received: from konrad-char-us-oracle-com.osdevelopmeniad.oraclevcn.com (konrad-char-us-oracle-com.allregionaliads.osdevelopmeniad.oraclevcn.com [100.100.249.23])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 474bvh2j3t-2;
	Wed, 11 Jun 2025 22:40:22 +0000
From: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
To: allison.henderson@oracle.com, netdev@vger.kernel.org,
        linux-rdma@vger.kernel.org, rds-devel@oss.oracle.com, tj@kernel.org,
        andrew@lunn.ch
Cc: hannes@cmpxchg.org, mkoutny@suse.com, cgroups@vger.kernel.org,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Subject: [PATCH v2] rds: Expose feature parameters via sysfs
Date: Wed, 11 Jun 2025 18:39:19 -0400
Message-ID: <20250611224020.318684-2-konrad.wilk@oracle.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250611224020.318684-1-konrad.wilk@oracle.com>
References: <20250611224020.318684-1-konrad.wilk@oracle.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-11_10,2025-06-10_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxscore=0 mlxlogscore=999
 bulkscore=0 adultscore=0 suspectscore=0 malwarescore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2506110192
X-Authority-Analysis: v=2.4 cv=LIpmQIW9 c=1 sm=1 tr=0 ts=684a05d7 b=1 cx=c_pps a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17 a=6IFa9wvqVegA:10 a=yPCof4ZbAAAA:8 a=8U2Zs_ofZIoWyWS-D5wA:9 cc=ntf awl=host:13207
X-Proofpoint-ORIG-GUID: OaKRnGAI33T3a5nS2pRQGSHr3Llj6BWJ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjExMDE5MiBTYWx0ZWRfX45D4M3k4em7C eAwK3ucmwGML1K05V6E4cdqpu1yWZfTOOHPM4xnRb4Js7Nt4xnEVFEdzmu5rGHYRdU8TVvxiAcl aAVUf0OtcQhvvXM2s2rteeVxSgZStrI3Z0CivOQlSuMoy9HSiMjqYMnLh+1yM/yeFYsfw0zCSF1
 7Yx9dNOlsNCGws++p7cUtGL4+YMQPoESwDJOW/hDpLbVmjce0zvXPkzaJ9lRcsRdJ1mf5YDFdjT 1a3yC/bRpYQxNTI7DKc1zSsNt3A6edGkrRcBkot4ZA0uyTxDFEU11d+3ygbAXdT4L8yioY9XtAd 1WpdVF4tp7KzGZIf0Qq2AP5zyfNzif6EqKqnAjhTRHdWdj2yAiP7S+jrHKIzaZRKMrwi3jmq4Yn
 9r5hugiBIOO5tjzydSnCjeEHDWfxX8MiNXkG5uBmYAluMKWVr/YI8MELyQ4fCCJSj4YA2rjG
X-Proofpoint-GUID: OaKRnGAI33T3a5nS2pRQGSHr3Llj6BWJ

We would like to have a programatic way for applications
to query which of the features defined in include/uapi/linux/rds.h
are actually implemented by the kernel.

The problem is that applications can be built against newer
kernel (or older) and they may have the feature implemented or not.

The lack of a certain feature would signify that the kernel
does not support it. The presence of it signifies the existence
of it.

This would provide the application to query the sysfs and figure
out what is supported.

This patch would expose this extra sysfs file:

/sys/kernel/rds/features

which would contain string values of what the RDS driver supports.

Signed-off-by: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
---
 net/rds/af_rds.c | 37 +++++++++++++++++++++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/net/rds/af_rds.c b/net/rds/af_rds.c
index 8435a20968ef..46cb8655df20 100644
--- a/net/rds/af_rds.c
+++ b/net/rds/af_rds.c
@@ -33,6 +33,7 @@
 #include <linux/module.h>
 #include <linux/errno.h>
 #include <linux/kernel.h>
+#include <linux/kobject.h>
 #include <linux/gfp.h>
 #include <linux/in.h>
 #include <linux/ipv6.h>
@@ -871,6 +872,33 @@ static void rds6_sock_info(struct socket *sock, unsigned int len,
 }
 #endif
 
+#ifdef CONFIG_SYSFS
+static ssize_t features_show(struct kobject *kobj, struct kobj_attribute *attr,
+			     char *buf)
+{
+	return snprintf(buf, PAGE_SIZE, "get_tos\n"
+			"set_tos\n"
+			"socket_cancel_sent_to\n"
+			"socket_get_mr\n"
+			"socket_free_mr\n"
+			"socket_recverr\n"
+			"socket_cong_monitor\n"
+			"socket_get_mr_for_dest\n"
+			"socket_so_transport\n"
+			"socket_so_rxpath_latency\n");
+}
+static struct kobj_attribute rds_features_attr = __ATTR_RO(features);
+
+static struct attribute *rds_sysfs_attrs[] = {
+	&rds_features_attr.attr,
+	NULL,
+};
+static const struct attribute_group rds_sysfs_attr_group = {
+	.attrs = rds_sysfs_attrs,
+	.name = "rds",
+};
+#endif
+
 static void rds_exit(void)
 {
 	sock_unregister(rds_family_ops.family);
@@ -882,6 +910,9 @@ static void rds_exit(void)
 	rds_stats_exit();
 	rds_page_exit();
 	rds_bind_lock_destroy();
+#ifdef CONFIG_SYSFS
+	sysfs_remove_group(kernel_kobj, &rds_sysfs_attr_group);
+#endif
 	rds_info_deregister_func(RDS_INFO_SOCKETS, rds_sock_info);
 	rds_info_deregister_func(RDS_INFO_RECV_MESSAGES, rds_sock_inc_info);
 #if IS_ENABLED(CONFIG_IPV6)
@@ -923,6 +954,12 @@ static int __init rds_init(void)
 	if (ret)
 		goto out_proto;
 
+#ifdef CONFIG_SYSFS
+	ret = sysfs_create_group(kernel_kobj, &rds_sysfs_attr_group);
+	if (ret)
+		goto out_proto;
+#endif
+
 	rds_info_register_func(RDS_INFO_SOCKETS, rds_sock_info);
 	rds_info_register_func(RDS_INFO_RECV_MESSAGES, rds_sock_inc_info);
 #if IS_ENABLED(CONFIG_IPV6)
-- 
2.43.5


