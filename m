Return-Path: <cgroups+bounces-8625-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B905CAE4950
	for <lists+cgroups@lfdr.de>; Mon, 23 Jun 2025 17:53:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D82023A4C7E
	for <lists+cgroups@lfdr.de>; Mon, 23 Jun 2025 15:53:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 645E828DF3D;
	Mon, 23 Jun 2025 15:53:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="gpCpXTeQ"
X-Original-To: cgroups@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 763FA26FA5E;
	Mon, 23 Jun 2025 15:53:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750694000; cv=none; b=VzVEqMIEuOypjbjuWfQNR1OBcFE7UADOLyCs/F9X2ZnBpx/zUuZcHPkOxFezfAtbjWtyxNc+TVGpfwqsTkQ372oHqytLUfmx4nIm1mrAda84uXk6XHdWumELUCrEPlfx5QicddNpCRJvbbfB5bD+r2HLm7czVEspI8o4ZSi4KdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750694000; c=relaxed/simple;
	bh=5U1E+0UtPmcBs2sQkMMhSG5fDKoafz2FVzv6zDTp4jk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CIqe71gI8cmO6YzUz2ycTuCsRmm6LyzixDypWAltaHDispBbSOmKd18iFZTufR1vzVuBsilJdsld3G0pmnrvpl3ZuIPVPsK20CdmuYHLJwxT4fJqm3lImC78AspVwE7zPcA13fQ1xMRHYoF0H9Qf+NQzqwPJynBUWJ8qkyoN8hY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=gpCpXTeQ; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55NCidfY002163;
	Mon, 23 Jun 2025 15:53:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2025-04-25; bh=s0JvY
	ZMeU9XmP0tS3yAp5DmvZyBOIIV+evdDNel3z/s=; b=gpCpXTeQ2c23aDsiO7tf8
	fDLoH8Go1EOMEO8lZGDh36Dqc3hZaPlME92SBpVcQjOXL0CywXT4OUba9VU6M4yO
	xr7vX4yKu8vHsn1V45Yv1PukyYC0Ih38GMjWZgZr8GI1nhJpbyB6DNTVZljztxrj
	XiyWRBknhcYP9C/UEhyq4KbEREhSukMz1+Zbh+Z6nsKv82u7E1aNDSV6tzaz7/TZ
	lJghah0V3evGWwaaSJXYrAjy0Sup4Qw74VedrN3NLeydMqO9WXELwlV4onY4hbHY
	FWJ4meu7GN8e+xSdHHN/fH09bFq8KTWloQ3mf51MqJ9YDw41n+4P/ddNxaCQPVWH
	g==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47egumhygc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 23 Jun 2025 15:53:12 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 55NFPnFL005725;
	Mon, 23 Jun 2025 15:53:11 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 47ehq2h5wg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 23 Jun 2025 15:53:11 +0000
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 55NFr9NY013518;
	Mon, 23 Jun 2025 15:53:10 GMT
Received: from konrad-char-us-oracle-com.osdevelopmeniad.oraclevcn.com (konrad-char-us-oracle-com.allregionaliads.osdevelopmeniad.oraclevcn.com [100.100.249.23])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 47ehq2h5tu-2;
	Mon, 23 Jun 2025 15:53:10 +0000
From: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
To: allison.henderson@oracle.com, netdev@vger.kernel.org,
        linux-rdma@vger.kernel.org, rds-devel@oss.oracle.com, tj@kernel.org,
        andrew@lunn.ch
Cc: hannes@cmpxchg.org, mkoutny@suse.com, cgroups@vger.kernel.org,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Subject: [PATCH net-next v4.1] rds: Expose feature parameters via sysfs (and ELF)
Date: Mon, 23 Jun 2025 11:51:36 -0400
Message-ID: <20250623155305.3075686-2-konrad.wilk@oracle.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250623155305.3075686-1-konrad.wilk@oracle.com>
References: <20250623155305.3075686-1-konrad.wilk@oracle.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-06-23_04,2025-06-23_06,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxlogscore=999
 spamscore=0 malwarescore=0 suspectscore=0 mlxscore=0 bulkscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2505160000 definitions=main-2506230096
X-Proofpoint-ORIG-GUID: dw4nY_8TUE9vybrnTMkDcbJfV8avrj8p
X-Proofpoint-GUID: dw4nY_8TUE9vybrnTMkDcbJfV8avrj8p
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjIzMDA5NiBTYWx0ZWRfX5iV77gTU5yfh 1YA46s39uXp21+ZTfWz4NqM64b9LsFJOK9OK0dhot3KCIl2fgEMfaneU0VD87BQVy7Ol5LGdJ+z X/95kwTjnp0rH/2BEzjpslptytUbQrMHSxegufwORsCqKGEVSwZNfwpNtgbYYlnjEXRY4ZmXazy
 cTvyQglBOwuaav3MaSg0r/Bq4VqGZahWkis/sPYP0FfHEA2M/VBFJObExvWtIqoaeymGM+hxxXi PvqHmuCXJv0/WpgWkEoMCh8lWCucydRnHaQCP6N+yVf7L0zX+0iqu6ERmjrfAV/A9N5AxpbQMx4 L3dZNiXTngrl9hLPjns01vLK+FikthSNXkCwrsgzT//AQYHP0DxQs4JUPQVyvItutMiWc4T9AQH
 k2yNIFjvEmHoAaLOS/90Y5g+qT4CE2dvx5PL7jBKRLB8i9HV9SMAskEUpppuAkASEtNhfeY7
X-Authority-Analysis: v=2.4 cv=S5rZwJsP c=1 sm=1 tr=0 ts=68597868 cx=c_pps a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17 a=6IFa9wvqVegA:10 a=yPCof4ZbAAAA:8 a=U52QDiKvcbk3jN7n6wgA:9

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

Reviewed-by: Allison Henderson <allison.henderson@oracle.com>
Signed-off-by: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
---
v3: Add the missing documentation
    Remove the CONFIG_SYSFS #ifdef machinations
    Redo it with each feature as a seperate file in 'features'
    directory.
v4: Follow the syntax in Documentation/ABI/stable/sysfs-module
    Tack on the ret value if we fail kobject_create_and_add
v4.1: Change period to coma in the sysfs-transport-rds
    Added Allison's Reviewed-by
---
 Documentation/ABI/stable/sysfs-transport-rds | 43 +++++++++++++
 net/rds/af_rds.c                             | 63 +++++++++++++++++++-
 2 files changed, 105 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/ABI/stable/sysfs-transport-rds

diff --git a/Documentation/ABI/stable/sysfs-transport-rds b/Documentation/ABI/stable/sysfs-transport-rds
new file mode 100644
index 000000000000..cd7559b9517c
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
+What:		/sys/kernel/rds/features/socket_[get_mr,get_mr_for_dest,free_mr]
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


