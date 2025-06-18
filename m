Return-Path: <cgroups+bounces-8579-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F56EADE18B
	for <lists+cgroups@lfdr.de>; Wed, 18 Jun 2025 05:15:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7529B3BB32E
	for <lists+cgroups@lfdr.de>; Wed, 18 Jun 2025 03:15:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F86E1D61AA;
	Wed, 18 Jun 2025 03:15:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="KEv7+wB+"
X-Original-To: cgroups@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E1547081C;
	Wed, 18 Jun 2025 03:15:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750216541; cv=none; b=lAOS8EYoxiwEwq1LRG3Hv+6/Zzeqvvqhkg/HLmKDcRFn8eyKQGamc8FNwUyw7QMSXuTJFuSBHHw3y/muVoz5PfU1qZPIx8eUc8ye9YDyVjjZe5i1fElCL1m7g68TSa0Rj4HuWPygCcnoW4vqljpB/ClR5UX6Kglw0rEKZB5xYS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750216541; c=relaxed/simple;
	bh=c+vEJdDJsRwQHhI1CpUzuBcNkccnDg+9ty9uoEZzDcU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lFadndhbEY7RfgDhEXyZjNFt9zGvPqoG9GRZ/lSgtb3Z1nt08ZrEG52wzPBuwmnC8+Zjr9co2BJUWdO8TPnChd6UxRIgc/ERtFZeoNxLIpOmkJIm659gAgAfhcc4wpEGlObYVEhwpnftBitEO5SFRCrIZr0Lse3uw3U+uhErWjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=KEv7+wB+; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55I1tZZl003415;
	Wed, 18 Jun 2025 03:15:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2025-04-25; bh=ilc0x
	ElubqWzUTRKoEIEMaqZ3ILEy4Lu1+zZo2uWQaQ=; b=KEv7+wB+QSNcnJogAsHej
	E6TSY0CfLWFRAlHuTaphY9lY460QLcAJduQrBBmSvjTw1DRUAhmWtyDmS+IIl7XC
	GCzsDmDkO4YlGhL2MAgmAAkERCbZlkcIAypw77ZcYGL7MzNiXn25kUZdczzXx8wi
	+7gXqOeFBLi1noqFTyHSprPQVP6UkuSXKoPK7QvRJWLF1YmKkpBeHENvCIh0pqOI
	ANmQdnIDeGiYdz8TiV0wFQiLDHhJwt6mFr7mLb7a2MPx0Qjt7IKOl2r3T42qmJfo
	el7ydXkvFqjHFU4e/GotSFbKsyvsj+pab8kxK2XPLvvh+SkY4hMwj8pqJOoY4VE+
	Q==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47900exw82-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 18 Jun 2025 03:15:31 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 55I0K7ZZ026880;
	Wed, 18 Jun 2025 03:15:30 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 478yhgb9rr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 18 Jun 2025 03:15:30 +0000
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 55I3FTuf002711;
	Wed, 18 Jun 2025 03:15:29 GMT
Received: from konrad-char-us-oracle-com.osdevelopmeniad.oraclevcn.com (konrad-char-us-oracle-com.allregionaliads.osdevelopmeniad.oraclevcn.com [100.100.249.23])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 478yhgb9r7-2;
	Wed, 18 Jun 2025 03:15:29 +0000
From: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
To: allison.henderson@oracle.com, netdev@vger.kernel.org,
        linux-rdma@vger.kernel.org, rds-devel@oss.oracle.com, tj@kernel.org,
        andrew@lunn.ch
Cc: hannes@cmpxchg.org, mkoutny@suse.com, cgroups@vger.kernel.org,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Subject: [PATCH net v3] rds: Expose feature parameters via sysfs (and ELF)
Date: Tue, 17 Jun 2025 23:13:09 -0400
Message-ID: <20250618031522.3859138-2-konrad.wilk@oracle.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250618031522.3859138-1-konrad.wilk@oracle.com>
References: <20250618031522.3859138-1-konrad.wilk@oracle.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-18_01,2025-06-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 spamscore=0 phishscore=0
 adultscore=0 suspectscore=0 mlxscore=0 mlxlogscore=999 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2506180025
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjE4MDAyNSBTYWx0ZWRfX04CVDqYtRVW+ Dy3loey4RLlVAOAmEhdTq8dHqvotMXjoIKog8AggAOVm1mCQ+7JUF1+yps86Kv3uBP1Qakk9lB4 36aL/Nhb+PcAKV0X8GgFnvhqIsYuSyh8Au3uWCNs1GJkYkPL7sQVWTiflCTe/74vyOWsA6gisPd
 rXFvGcBpqNc97l2S8kHADuaXON84n6nj6TVh+BLXmsZqseexyZl2N6K3DgQx0RRwwN0Uz7OaSGr Xe8QTtr1kiuMVXPOL2xijF2WBPd2Tzwn9uZolpKgEu+rJ+AsUtX44GG3K4c5zw7WlBCT86iXuWD nPCeuLVuJ2nL+qy4uR77uJzaMBRS7+wAp1FAwOa0vzb8OGcwm+EaYTTOU3n6rWAJBkOdYDeSFY8
 PIbAlGSZTgwhrYKQ1t7JR6gICGv2Cvtg4ZHUFKLc/8AL0oGGbajw7/SisQ8WX5MXXSRwpM3R
X-Proofpoint-ORIG-GUID: q4UoCfT7CCMlSABd7WTVllV7vQEVFbpz
X-Authority-Analysis: v=2.4 cv=X/5SKHTe c=1 sm=1 tr=0 ts=68522f53 b=1 cx=c_pps a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17 a=6IFa9wvqVegA:10 a=yPCof4ZbAAAA:8 a=m4ZG2DmCZvx6Djf13nYA:9 cc=ntf awl=host:13207
X-Proofpoint-GUID: q4UoCfT7CCMlSABd7WTVllV7vQEVFbpz

We would like to have a programmatic way for applications
to query which of the features defined in include/uapi/linux/rds.h
are actually implemented by the kernel.

The problem is that applications can be built against newer
kernel (or older) and they may have the feature implemented or not.

The lack of a certain feature would signify that the kernel
does not support it. The presence of it signifies the existence
of it.

This would provide the application to query the sysfs and figure
out what is supported on a running system.

This patch would expose this extra sysfs file:

/sys/kernel/rds/features/ioctl_get_tos
/sys/kernel/rds/features/ioctl_set_tos
/sys/kernel/rds/features/socket_cancel_sent_to
/sys/kernel/rds/features/socket_cong_monitor
/sys/kernel/rds/features/socket_free_mr
/sys/kernel/rds/features/socket_get_mr
/sys/kernel/rds/features/socket_get_mr_for_dest
/sys/kernel/rds/features/socket_recverr
/sys/kernel/rds/features/socket_so_rxpath_latency
/sys/kernel/rds/features/socket_so_transport

With the value of 'supported' in them. In the future this value
could change to say 'deprecated' or have other values (for example
different versions) or can be runtime changed.

The choice to use sysfs and this particular way is modeled on the
filesystems usage exposing their features.

Alternative solution such as exposing one file ('features') with
each feature enumerated (which cgroup does) is a bit limited in
that it does not provide means to provide extra content in the future
for each feature. For example if one of the features had three
modes and one wanted to set a particular one at runtime - that
does not exist in cgroup (albeit it can be implemented but it would
be quite hectic to have just one single attribute).

Another solution of using an ioctl to expose a bitmask has the
disadvantage of being less flexible in the future and while it can
have a bit of supported/unsupported, it is not clear how one would
change modes or expose versions. It is most certainly feasible
but it can get seriously complex fast.

As such this mechanism offers the basic support we require
now and offers the flexibility for the future.

Lastly, we also utilize the ELF note macro to expose these via
so that applications that have not yet initialized RDS transport
can inspect the kernel module to see if they have the appropiate
support and choose an alternative protocol if they wish so.

Signed-off-by: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
---
v3: Add the missing documentation
    Remove the CONFIG_SYSFS #ifdef machinations
    Redo it with each feature as a seperate file in 'features'
    directory.
---
 Documentation/ABI/stable/sysfs-transport-rds | 55 +++++++++++++++++
 net/rds/af_rds.c                             | 62 +++++++++++++++++++-
 2 files changed, 116 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/ABI/stable/sysfs-transport-rds

diff --git a/Documentation/ABI/stable/sysfs-transport-rds b/Documentation/ABI/stable/sysfs-transport-rds
new file mode 100644
index 000000000000..db4de277f717
--- /dev/null
+++ b/Documentation/ABI/stable/sysfs-transport-rds
@@ -0,0 +1,55 @@
+What:          /sys/kernel/rds/features/*
+Date:          June 2025
+KernelVersion: 6.17
+Contact:       rds-devel@oss.oracle.com
+Description:   This directory contains the features that this kernel
+               has been built with and supports. They correspond
+               to the include/uapi/linux/rds.h features.
+
+	       The intent is for applications compiled against rds.h
+	       to be able to query and find out what features the
+	       driver supports. The current expected value is 'supported'.
+
+	       The features so far are:
+
+	       ioctl_get_tos
+	       ioctl_set_tos
+
+		Allows the user to set on the socket a type of
+		service(tos) value associated forever.
+
+	       socket_cancel_sent_to
+
+		Allows to cancel all pending messages to a given destination.
+
+	       socket_cong_monitor
+
+		RDS provides an explicit monitoring wherein a 64-bit mask value
+		on the socket and each bit corresponds to a group of ports.
+
+		When a congestion update arrives, RDS checks the set of ports
+		that became uncongested against the bit mask.
+
+		If they overlap, a control messages is enqueued on the socket,
+		and the application is woken up.
+
+	       socket_get_mr
+	       socket_get_mr_for_dest
+	       socket_free_mr
+
+		RDS allows a process to register or release memory ranges for
+		RDMA.
+
+	       socket_recverr
+
+		RDS will send RDMA notification messages to the application for
+		any RDMA operation that fails. By default this is off.
+
+	       socket_so_rxpath_latency
+
+		Receive path latency in various stages of receive path.
+
+	       socket_so_transport
+
+		Attach the socket to the underlaying transport (TCP or RDMA)
+		before invoking bind on the socket.
diff --git a/net/rds/af_rds.c b/net/rds/af_rds.c
index 8435a20968ef..449b20f236a5 100644
--- a/net/rds/af_rds.c
+++ b/net/rds/af_rds.c
@@ -32,7 +32,9 @@
  */
 #include <linux/module.h>
 #include <linux/errno.h>
+#include <linux/elfnote.h>
 #include <linux/kernel.h>
+#include <linux/kobject.h>
 #include <linux/gfp.h>
 #include <linux/in.h>
 #include <linux/ipv6.h>
@@ -871,6 +873,53 @@ static void rds6_sock_info(struct socket *sock, unsigned int len,
 }
 #endif
 
+static ssize_t supported_show(struct kobject *kobj, struct kobj_attribute *attr,
+			     char *buf)
+{
+	return sysfs_emit(buf, "supported\n");
+}
+
+#define SYSFS_ATTR(_name)					\
+ELFNOTE64("rds." #_name, 0, 1);				\
+static struct kobj_attribute rds_attr_##_name = {		\
+	.attr = {.name = __stringify(_name), .mode = 0444 },	\
+	.show = supported_show,					\
+}
+
+SYSFS_ATTR(ioctl_set_tos);
+SYSFS_ATTR(ioctl_get_tos);
+SYSFS_ATTR(socket_cancel_sent_to);
+SYSFS_ATTR(socket_cong_monitor);
+SYSFS_ATTR(socket_get_mr);
+SYSFS_ATTR(socket_get_mr_for_dest);
+SYSFS_ATTR(socket_free_mr);
+SYSFS_ATTR(socket_recverr);
+SYSFS_ATTR(socket_so_rxpath_latency);
+SYSFS_ATTR(socket_so_transport);
+
+#define ATTR_LIST(_name) &rds_attr_##_name.attr
+
+static struct attribute *rds_feat_attrs[] = {
+	ATTR_LIST(ioctl_set_tos),
+	ATTR_LIST(ioctl_get_tos),
+	ATTR_LIST(socket_cancel_sent_to),
+	ATTR_LIST(socket_cong_monitor),
+	ATTR_LIST(socket_get_mr),
+	ATTR_LIST(socket_get_mr_for_dest),
+	ATTR_LIST(socket_free_mr),
+	ATTR_LIST(socket_recverr),
+	ATTR_LIST(socket_so_rxpath_latency),
+	ATTR_LIST(socket_so_transport),
+	NULL,
+};
+
+static const struct attribute_group rds_feat_group = {
+	.attrs = rds_feat_attrs,
+	.name = "features",
+};
+
+static struct kobject *rds_sysfs_kobj;
+
 static void rds_exit(void)
 {
 	sock_unregister(rds_family_ops.family);
@@ -882,6 +931,8 @@ static void rds_exit(void)
 	rds_stats_exit();
 	rds_page_exit();
 	rds_bind_lock_destroy();
+	sysfs_remove_group(rds_sysfs_kobj, &rds_feat_group);
+	kobject_put(rds_sysfs_kobj);
 	rds_info_deregister_func(RDS_INFO_SOCKETS, rds_sock_info);
 	rds_info_deregister_func(RDS_INFO_RECV_MESSAGES, rds_sock_inc_info);
 #if IS_ENABLED(CONFIG_IPV6)
@@ -923,6 +974,14 @@ static int __init rds_init(void)
 	if (ret)
 		goto out_proto;
 
+	rds_sysfs_kobj = kobject_create_and_add("rds", kernel_kobj);
+	if (!rds_sysfs_kobj)
+		goto out_proto;
+
+	ret = sysfs_create_group(rds_sysfs_kobj, &rds_feat_group);
+	if (ret)
+		goto out_kobject;
+
 	rds_info_register_func(RDS_INFO_SOCKETS, rds_sock_info);
 	rds_info_register_func(RDS_INFO_RECV_MESSAGES, rds_sock_inc_info);
 #if IS_ENABLED(CONFIG_IPV6)
@@ -931,7 +990,8 @@ static int __init rds_init(void)
 #endif
 
 	goto out;
-
+out_kobject:
+	kobject_put(rds_sysfs_kobj);
 out_proto:
 	proto_unregister(&rds_proto);
 out_stats:
-- 
2.43.5


