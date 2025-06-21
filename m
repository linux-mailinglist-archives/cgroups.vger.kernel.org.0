Return-Path: <cgroups+bounces-8620-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 96D0BAE26BA
	for <lists+cgroups@lfdr.de>; Sat, 21 Jun 2025 02:48:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 57C1917C878
	for <lists+cgroups@lfdr.de>; Sat, 21 Jun 2025 00:48:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9F3511185;
	Sat, 21 Jun 2025 00:47:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="L1L2J7qy"
X-Original-To: cgroups@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE6EB539A;
	Sat, 21 Jun 2025 00:47:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750466875; cv=none; b=axkeWi1KDU71Mo8xVsieLQqVzGWOTpmYSHXHIRkQ9r2fh0ruB9gpm70In1kGtk3N8dgvLE87kJYvuJ9psjevu6TL844flitGlBYUZ+tmAPQ0fe/8hHM4LdUAoh4CqBhxdYRvo2qZWgkvHVdWgWrbMYJJwiDPPReQUsDicf1J/7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750466875; c=relaxed/simple;
	bh=/45otv5zF2ad1IYUZ9cdo9KC/e70G11Qigzwmcd30Jc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Za2Rn29lAV3nE0rnhxNYjAf/mV2pE9yiLvuwzFEhWtnlRCBnZOvxPj6fLUNJapQfbqRUGVtYh1gQY3Cjy4xibtINfek/af5ZUD7hLwZPtKeEzowvCYk0qtww3RdrG1Fb/6y2qlmPKm3K61t1WITFtqh8hu8For6ogjk0sRcZSPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=L1L2J7qy; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55L0LDk9029646;
	Sat, 21 Jun 2025 00:47:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2025-04-25; bh=vDhvG
	+Uprxt1jxcq2Z0FtRn3OUH4623Q9nNim7CI1S4=; b=L1L2J7qyEF2YA9igClyX/
	QjLtHR/AIh5GCC3t/2k2rhmv4A8aBKMiEf3xhJXjDmnkpyB19twLt9jPwdx2rCQ9
	SHQoKTcsTuPLsTelcQDNJb9IdAPsPrKoKDguFx0qXVEYhNYETNe+QYUaM3wSNVmF
	vGevUFcRaoshCmKQMT6mHN1DsVYgzrxmPEHag+J2/P6c2rH8ZpTe/MmhhCWz8t2C
	4dzsshnghVayauho2O14XNgMCkEWSl/ne0N6ZnfTMtLuDOqcAD6Q6nKXe9r5icbb
	cso2OFNRbwQu3JcSyMJbN0EcS52dPdDaOsSpe7ap6HIJnFM4y70pQHczbK87fm+n
	Q==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 478yv5cjgd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 21 Jun 2025 00:47:47 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 55KMXrMJ037413;
	Sat, 21 Jun 2025 00:47:46 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 478yhd7nnu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 21 Jun 2025 00:47:46 +0000
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 55L0ixOj038657;
	Sat, 21 Jun 2025 00:47:45 GMT
Received: from konrad-char-us-oracle-com.osdevelopmeniad.oraclevcn.com (konrad-char-us-oracle-com.allregionaliads.osdevelopmeniad.oraclevcn.com [100.100.249.23])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 478yhd7nn3-2;
	Sat, 21 Jun 2025 00:47:45 +0000
From: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
To: allison.henderson@oracle.com, netdev@vger.kernel.org,
        linux-rdma@vger.kernel.org, rds-devel@oss.oracle.com, tj@kernel.org,
        andrew@lunn.ch
Cc: hannes@cmpxchg.org, mkoutny@suse.com, cgroups@vger.kernel.org,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Subject: [PATCH net-next v4] rds: Expose feature parameters via sysfs (and ELF)
Date: Fri, 20 Jun 2025 20:26:11 -0400
Message-ID: <20250621004741.2883507-2-konrad.wilk@oracle.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250621004741.2883507-1-konrad.wilk@oracle.com>
References: <20250621004741.2883507-1-konrad.wilk@oracle.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-20_08,2025-06-20_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=0 adultscore=0
 mlxlogscore=999 spamscore=0 mlxscore=0 phishscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2506210002
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjIxMDAwMiBTYWx0ZWRfX+X8UHAiGW8sf yB2tj7dj3XxFU6/VaHSCg91OMNALE4oBMtac1NkQyqxDNy3TqQDly2J+fkw8ZH0t5eT24VxXyUO iwG2b65N83C3q57zIJWcs1YP2mZ3r7CpdlHrIRgjvSsv26Fc2Ru4hzUXJFs0akspyO8pGPxe7Ve
 3UiRd71eFhiOnj/fgVvPBMQMV5+ZgC1JbWZ+JzUxAJvKUBm0ToH+TYtcTG2mterFHcdKF8ww5Xy Z1kgQXgyExnGggoN7rhGrF13RyzCGG8tV9FE7JqGpcKLwn3Totzm9/Zh0fJxVlZ4TEAPISp3uTf JcHh5cfpZvsrOFuL1U9RyPvAOkmc0Y5klqXkg0lJhjFR4ybI86XqhKmhwKmFaqtNR4CIQjgPWbh
 kmhoI9FS5MSC2TEiOIUTwfmnWWVEJMGs829rp4nyIF8mV8jEc5LpUCrb7vwOKkmeQ77IO5Hg
X-Proofpoint-GUID: KZ-22x_aQ4uMiQKDOdonKKxko6UtRhpt
X-Proofpoint-ORIG-GUID: KZ-22x_aQ4uMiQKDOdonKKxko6UtRhpt
X-Authority-Analysis: v=2.4 cv=W9c4VQWk c=1 sm=1 tr=0 ts=68560133 cx=c_pps a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17 a=6IFa9wvqVegA:10 a=yPCof4ZbAAAA:8 a=m4ZG2DmCZvx6Djf13nYA:9

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
v4: Follow the syntax in Documentation/ABI/stable/sysfs-module
    Tack on the ret value if we fail kobject_create_and_add
---
 Documentation/ABI/stable/sysfs-transport-rds | 43 +++++++++++++
 net/rds/af_rds.c                             | 63 +++++++++++++++++++-
 2 files changed, 105 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/ABI/stable/sysfs-transport-rds

diff --git a/Documentation/ABI/stable/sysfs-transport-rds b/Documentation/ABI/stable/sysfs-transport-rds
new file mode 100644
index 000000000000..749a043d4e88
--- /dev/null
+++ b/Documentation/ABI/stable/sysfs-transport-rds
@@ -0,0 +1,43 @@
+What:		/sys/kernel/rds/features/*
+Date:		June 2025
+KernelVersion:	6.17
+Contact:	rds-devel@oss.oracle.com
+Description:	This directory contains the features that this kernel
+		has been built with and supports. They correspond
+		to the include/uapi/linux/rds.h features.
+
+		The intent is for applications compiled against rds.h
+		to be able to query and find out what features the
+		driver supports. The current expected value is 'supported'.
+
+What:		/sys/kernel/rds/features/ioctl_[get,set]_tos
+Description:	Allows the user to set on the socket a type of
+		service(tos) value associated forever.
+
+What:		/sys/kernel/rds/features/socket_cancel_sent_to
+Description:	Allows to cancel all pending messages to a given destination.
+
+What:		/sys/kernel/rds/features/socket_cong_monitor
+Description:	RDS provides explicit congestion monitoring for a socket using
+		a 64-bit mask. Each bit in the mask corresponds to a group of ports.
+
+		When a congestion update arrives, RDS checks the set of ports
+		that became uncongested against the bit mask.
+
+		If they overlap, a control messages is enqueued on the socket,
+		and the application is woken up.
+
+What:		/sys/kernel/rds/features/socket_[get_mr.get_mr_for_dest,free_mr]
+Description:	RDS allows a process to register or release memory ranges for
+		RDMA.
+
+What:		/sys/kernel/rds/features/socket_recverr
+Description:	RDS will send RDMA notification messages to the application for
+		any RDMA operation that fails. By default this is off.
+
+What:		/sys/kernel/rds/features/socket_so_rxpath_latency
+Description:	Receive path latency in various stages of receive path.
+
+What:		/sys/kernel/rds/features/socket_so_transport
+Description:	Attach the socket to the underlaying transport (TCP, RDMA
+		or loop) before invoking bind on the socket.
diff --git a/net/rds/af_rds.c b/net/rds/af_rds.c
index 8435a20968ef..f920cc6f0b2b 100644
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
@@ -923,6 +974,15 @@ static int __init rds_init(void)
 	if (ret)
 		goto out_proto;
 
+	rds_sysfs_kobj = kobject_create_and_add("rds", kernel_kobj);
+	if (!rds_sysfs_kobj) {
+		ret = -ENOMEM;
+		goto out_proto;
+	}
+	ret = sysfs_create_group(rds_sysfs_kobj, &rds_feat_group);
+	if (ret)
+		goto out_kobject;
+
 	rds_info_register_func(RDS_INFO_SOCKETS, rds_sock_info);
 	rds_info_register_func(RDS_INFO_RECV_MESSAGES, rds_sock_inc_info);
 #if IS_ENABLED(CONFIG_IPV6)
@@ -931,7 +991,8 @@ static int __init rds_init(void)
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


