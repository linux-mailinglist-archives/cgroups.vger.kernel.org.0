Return-Path: <cgroups+bounces-17611-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id WJeGLCZyT2qKgwIAu9opvQ
	(envelope-from <cgroups+bounces-17611-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Thu, 09 Jul 2026 12:04:22 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 061D572F4F9
	for <lists+cgroups@lfdr.de>; Thu, 09 Jul 2026 12:04:22 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=resnulli-us.20251104.gappssmtp.com header.s=20251104 header.b=uq4blo77;
	dmarc=none;
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-17611-lists+cgroups=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="cgroups+bounces-17611-lists+cgroups=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9F324311FF41
	for <lists+cgroups@lfdr.de>; Thu,  9 Jul 2026 09:56:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34D06403B1A;
	Thu,  9 Jul 2026 09:56:06 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E651403126
	for <cgroups@vger.kernel.org>; Thu,  9 Jul 2026 09:56:03 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783590966; cv=none; b=CtxtUq6NeTf+snhEg5EssVNcbPhsD8doXMHxCoBc9d4UDSTqTKucng/f6e3OS9zFIPo77+TR8J2vu48QZ+yOoOWniAwZYp1eci+GKjyqCEyf6TcxBLHGHFy85iQVtryMd1wtLh9o8e5vF3Tu957vfwTbdq0TNWbP5Fgu1xZyZQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783590966; c=relaxed/simple;
	bh=wDbwoVsgO2rVtHWVAThF48BqSQpp7CEaq90+IBet3Zc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PxG0AWrcrLoynlSkQUA0mBL1wnar6sbMSBRz6RYM/H5gWyidSguj/JEWG6zzbTlYk+DqkZNUIfCLhUtvdNm/m4rHCY6S3M/HRoqhq7d1SWONSQe86kKUwRqanopPO5vBgP6CXRPcEYIF9qFygbI5N5hOMEv6Eeg+tT4PAorMwCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20251104.gappssmtp.com header.i=@resnulli-us.20251104.gappssmtp.com header.b=uq4blo77; arc=none smtp.client-ip=209.85.128.41
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-493c5220cb7so12834845e9.3
        for <cgroups@vger.kernel.org>; Thu, 09 Jul 2026 02:56:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20251104.gappssmtp.com; s=20251104; t=1783590962; x=1784195762; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/iSsG89EPD/8IN7Bi/SGrk6H7a407NpggfiGQgfGsnY=;
        b=uq4blo779sL+B5YI+Ja2FU87By9P3vZLRBEcSu9HbwiXM8c4VH6Bd8SDy+xMvD9+wK
         uFX+xS3a4nj4ZZfD61aZnlJ0ZF4pxQrqm1Oa2ajdS6dNGz99xQmknXp3XQ1Vd2mylxgW
         VHXDj1vk0P9ucsiZnuNcnLe5z5118iHT51VrFyIpHAwrOoUB6zl14UfeUPsHzmttVcbF
         A9S6sRuuQXMHe9kYEov3lFSKEoqGZeLNRC9LrNqv2Kaen4Lkg8ongYCON06hc0xBwoAK
         uhyPs7CRVCo5ZTBh9oeI53zy7kLxLaPOE33Wgq6rFlzk7H+gDEa6TolfKeeMwVjhpeYm
         IpwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783590962; x=1784195762;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=/iSsG89EPD/8IN7Bi/SGrk6H7a407NpggfiGQgfGsnY=;
        b=lUMDJkLqQSszITyxU8+n3IvZPB7xwijcAWrR8HwHicNaFaj9I6wWrX2ezv+9+p9rUK
         0XH/AWVEg2qikIA/ZH5wG/Ns4mFi7Kpz0Kr3H0gWE5t+GjxNDIbMbs4HBMazvBn1xWfN
         kKZ+FTF+fUY2EwAI5ppVpOsc0/+0qRU68BfR1SrRsJvwDit6u6ppmcGKKuEdxj5KP30C
         fhC/Ege/f3qmwF3e9StpCFqPlAQwE9iD5LRoeh0/ciBYcVPK3t5kBw2ae+cUBzKgttBa
         tFikj173hzbMmN/4zE25l9FkJMg8Ofv8MOg6FTXKJCV5sgc6VRCEG+lxCZc+umyv0/nC
         pQmA==
X-Gm-Message-State: AOJu0YwZSNNfa5YlkLAgimCffRDH7Qs16mFCWLjxZtL1R+cCyolxO8Pg
	qqyKwA3h6LoPv1qQ3svMSSU0MLJ5ld0ra1aJxr6/+gHNCKkAXYBPchPctkC3i0kCjyI=
X-Gm-Gg: AfdE7clL8Qu5460HugIGMsH4pvni3RPkX9gL9k93udG+LZ/nSd52fxr2+34SeFhA5Ay
	dc4FzzifM5/DGC7T/JyKGi/xOpg0VYLISoMporEdRQ5HnAp3Fou+KD2Xm+53b6oWhJT6SnwFz80
	ucPa82GJkHBljcp0sMIhjtQWORDhcjBq8RJSnL0eF2otxw60DkImPFPAT3+oplTCrd0vgwevJ48
	V1Gtv3dDG9WthTb77Kgv0TMtDz0QU0EIi0hgW1nz6htdnHAHYndGHy8Usy+7NVWBx/bW2VBM+zc
	OcggjinFgmKPry6R12CobD4XGNG387Z17weILqQ5cjkOZmIn2AVrY5SCIdY3jZWHBTZUIV1/Fob
	LZ0r0FNJew0wTLIBK10SxxZMrDZT5DUYWPdx2GRzq4bYR0UIAWXVOIcp2ebiY0EFXJIulaYaRAX
	RztU04wePh3qM3V2lJaGwgJw==
X-Received: by 2002:a05:600c:3515:b0:493:bc92:2a2f with SMTP id 5b1f17b1804b1-493e6894936mr65419465e9.1.1783590962332;
        Thu, 09 Jul 2026 02:56:02 -0700 (PDT)
Received: from localhost ([140.209.217.211])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493eb70a677sm45548625e9.8.2026.07.09.02.56.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jul 2026 02:56:01 -0700 (PDT)
From: Jiri Pirko <jiri@resnulli.us>
To: linux-rdma@vger.kernel.org
Cc: cgroups@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-s390@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	jgg@ziepe.ca,
	leon@kernel.org,
	parav@nvidia.com,
	mbloch@nvidia.com,
	cmeiohas@nvidia.com,
	roman.gushchin@linux.dev,
	bvanassche@acm.org,
	zyjzyj2000@gmail.com,
	shuah@kernel.org,
	tj@kernel.org,
	mkoutny@suse.com,
	hannes@cmpxchg.org,
	alibuda@linux.alibaba.com,
	dust.li@linux.alibaba.com,
	sidraya@linux.ibm.com,
	wenjia@linux.ibm.com
Subject: [PATCH rdma-next 08/13] RDMA/cgroup: Scope rdma cgroup device visibility to the net namespace
Date: Thu,  9 Jul 2026 11:55:27 +0200
Message-ID: <20260709095532.855647-9-jiri@resnulli.us>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260709095532.855647-1-jiri@resnulli.us>
References: <20260709095532.855647-1-jiri@resnulli.us>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[resnulli-us.20251104.gappssmtp.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-17611-lists,cgroups=lfdr.de];
	FREEMAIL_CC(0.00)[vger.kernel.org,ziepe.ca,kernel.org,nvidia.com,linux.dev,acm.org,gmail.com,suse.com,cmpxchg.org,linux.alibaba.com,linux.ibm.com];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	DMARC_NA(0.00)[resnulli.us];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:linux-rdma@vger.kernel.org,m:cgroups@vger.kernel.org,m:netdev@vger.kernel.org,m:linux-s390@vger.kernel.org,m:linux-kselftest@vger.kernel.org,m:jgg@ziepe.ca,m:leon@kernel.org,m:parav@nvidia.com,m:mbloch@nvidia.com,m:cmeiohas@nvidia.com,m:roman.gushchin@linux.dev,m:bvanassche@acm.org,m:zyjzyj2000@gmail.com,m:shuah@kernel.org,m:tj@kernel.org,m:mkoutny@suse.com,m:hannes@cmpxchg.org,m:alibuda@linux.alibaba.com,m:dust.li@linux.alibaba.com,m:sidraya@linux.ibm.com,m:wenjia@linux.ibm.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[jiri@resnulli.us,cgroups@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[resnulli-us.20251104.gappssmtp.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_TWELVE(0.00)[21];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jiri@resnulli.us,cgroups@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[resnulli-us.20251104.gappssmtp.com:dkim,nvidia.com:email,resnulli.us:mid,resnulli.us:from_mime,vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 061D572F4F9

From: Jiri Pirko <jiri@nvidia.com>

Track each rdma cgroup device's net namespace and sharing mode, then filter
name lookups and cgroupfs enumeration to devices visible from the caller's
namespace. Keep the cached sharing mode synchronized across registration,
netns moves, and runtime mode changes.

Signed-off-by: Jiri Pirko <jiri@nvidia.com>
---
 Documentation/admin-guide/cgroup-v2.rst |  7 +++++++
 drivers/infiniband/core/cgroup.c        | 12 ++++++++++++
 drivers/infiniband/core/core_priv.h     | 12 ++++++++++++
 drivers/infiniband/core/device.c        | 11 +++++++++++
 include/linux/cgroup_rdma.h             | 10 ++++++++++
 kernel/cgroup/rdma.c                    | 20 +++++++++++++++++++-
 6 files changed, 71 insertions(+), 1 deletion(-)

diff --git a/Documentation/admin-guide/cgroup-v2.rst b/Documentation/admin-guide/cgroup-v2.rst
index 993446ab66d0..4523c1884d67 100644
--- a/Documentation/admin-guide/cgroup-v2.rst
+++ b/Documentation/admin-guide/cgroup-v2.rst
@@ -2752,6 +2752,13 @@ RDMA
 The "rdma" controller regulates the distribution and accounting of
 RDMA resources.
 
+When RDMA devices are isolated per network namespace (exclusive mode),
+device names are unique only within a network namespace. The device lines
+below are therefore scoped to the reading or writing process's network
+namespace: only devices accessible from that namespace are listed, and a
+limit is applied to the device of that name in that namespace. Configure
+limits from the same network namespace as the workloads.
+
 RDMA Interface Files
 ~~~~~~~~~~~~~~~~~~~~
 
diff --git a/drivers/infiniband/core/cgroup.c b/drivers/infiniband/core/cgroup.c
index 1f037fe01450..7a216ed45199 100644
--- a/drivers/infiniband/core/cgroup.c
+++ b/drivers/infiniband/core/cgroup.c
@@ -17,6 +17,8 @@
 void ib_device_register_rdmacg(struct ib_device *device)
 {
 	device->cg_device.name = device->name;
+	device->cg_device.netns_shared = ib_devices_shared_netns;
+	write_pnet(&device->cg_device.net, rdma_dev_net(device));
 	rdmacg_register_device(&device->cg_device);
 }
 
@@ -34,6 +36,16 @@ void ib_device_unregister_rdmacg(struct ib_device *device)
 	rdmacg_unregister_device(&device->cg_device);
 }
 
+void ib_device_rdmacg_change_netns(struct ib_device *device, struct net *net)
+{
+	write_pnet(&device->cg_device.net, net);
+}
+
+void ib_device_rdmacg_set_netns_shared(struct ib_device *device, bool shared)
+{
+	WRITE_ONCE(device->cg_device.netns_shared, shared);
+}
+
 int ib_rdmacg_try_charge(struct ib_rdmacg_object *cg_obj,
 			 struct ib_device *device,
 			 enum rdmacg_resource_type resource_index)
diff --git a/drivers/infiniband/core/core_priv.h b/drivers/infiniband/core/core_priv.h
index aaf330b0d333..9cd671e2db20 100644
--- a/drivers/infiniband/core/core_priv.h
+++ b/drivers/infiniband/core/core_priv.h
@@ -156,6 +156,8 @@ void ib_dispatch_event_clients(struct ib_event *event);
 #ifdef CONFIG_CGROUP_RDMA
 void ib_device_register_rdmacg(struct ib_device *device);
 void ib_device_unregister_rdmacg(struct ib_device *device);
+void ib_device_rdmacg_change_netns(struct ib_device *device, struct net *net);
+void ib_device_rdmacg_set_netns_shared(struct ib_device *device, bool shared);
 
 int ib_rdmacg_try_charge(struct ib_rdmacg_object *cg_obj,
 			 struct ib_device *device,
@@ -173,6 +175,16 @@ static inline void ib_device_unregister_rdmacg(struct ib_device *device)
 {
 }
 
+static inline void ib_device_rdmacg_change_netns(struct ib_device *device,
+						 struct net *net)
+{
+}
+
+static inline void ib_device_rdmacg_set_netns_shared(struct ib_device *device,
+						     bool shared)
+{
+}
+
 static inline int ib_rdmacg_try_charge(struct ib_rdmacg_object *cg_obj,
 				       struct ib_device *device,
 				       enum rdmacg_resource_type resource_index)
diff --git a/drivers/infiniband/core/device.c b/drivers/infiniband/core/device.c
index 8705011fab66..3ccf4731154a 100644
--- a/drivers/infiniband/core/device.c
+++ b/drivers/infiniband/core/device.c
@@ -1112,6 +1112,7 @@ static int add_all_compat_devs(void)
 int rdma_compatdev_set(u8 enable)
 {
 	struct rdma_dev_net *rnet;
+	struct ib_device *dev;
 	unsigned long index;
 	int ret = 0;
 
@@ -1134,6 +1135,12 @@ int rdma_compatdev_set(u8 enable)
 	if (ret)
 		return -EBUSY;
 
+	/* Keep each registered device's rdma cgroup visibility in sync. */
+	down_read(&devices_rwsem);
+	xa_for_each_marked(&devices, index, dev, DEVICE_REGISTERED)
+		ib_device_rdmacg_set_netns_shared(dev, enable);
+	up_read(&devices_rwsem);
+
 	if (enable)
 		ret = add_all_compat_devs();
 	else
@@ -1350,6 +1357,7 @@ static int enable_device_and_get(struct ib_device *device)
 	 */
 	refcount_set(&device->refcount, 2);
 	down_write(&devices_rwsem);
+	ib_device_rdmacg_set_netns_shared(device, ib_devices_shared_netns);
 	xa_set_mark(&devices, device->index, DEVICE_REGISTERED);
 
 	/*
@@ -1823,12 +1831,14 @@ static int rdma_dev_change_netns(struct ib_device *device, struct net *cur_net,
 			     "%s: failed to pick device name during namespace teardown: %d\n",
 			     __func__, ret);
 			write_pnet(&device->coredev.rdma_net, net);
+			ib_device_rdmacg_change_netns(device, net);
 			ret = 0;
 		}
 		goto rename_done;
 	}
 
 	write_pnet(&device->coredev.rdma_net, net);
+	ib_device_rdmacg_change_netns(device, net);
 	ret = device_rename(&device->dev, new_name);
 	if (ret) {
 		if (fallback_pattern) {
@@ -1842,6 +1852,7 @@ static int rdma_dev_change_netns(struct ib_device *device, struct net *cur_net,
 				 __func__);
 			/* Try and put things back and re-enable the device */
 			write_pnet(&device->coredev.rdma_net, cur_net);
+			ib_device_rdmacg_change_netns(device, cur_net);
 		}
 	} else {
 		strscpy(device->name, dev_name(&device->dev),
diff --git a/include/linux/cgroup_rdma.h b/include/linux/cgroup_rdma.h
index 404e746552ca..71170cb0e19e 100644
--- a/include/linux/cgroup_rdma.h
+++ b/include/linux/cgroup_rdma.h
@@ -7,6 +7,7 @@
 #define _CGROUP_RDMA_H
 
 #include <linux/cgroup.h>
+#include <net/net_namespace.h>
 
 enum rdmacg_resource_type {
 	RDMACG_RESOURCE_HCA_HANDLE,
@@ -34,6 +35,15 @@ struct rdmacg_device {
 	struct list_head	dev_node;
 	struct list_head	rpools;
 	char			*name;
+	/*
+	 * Net namespace the device belongs to. @netns_shared mirrors
+	 * ib_devices_shared_netns: when true the device is visible from every
+	 * net namespace (shared mode); otherwise @net is the only namespace
+	 * that may see and configure it. @netns_shared is updated when the
+	 * sharing mode changes, so use {READ,WRITE}_ONCE() to access it.
+	 */
+	possible_net_t		net;
+	bool			netns_shared;
 };
 
 /*
diff --git a/kernel/cgroup/rdma.c b/kernel/cgroup/rdma.c
index 5e82a03b3270..c8b4e3de7630 100644
--- a/kernel/cgroup/rdma.c
+++ b/kernel/cgroup/rdma.c
@@ -15,6 +15,7 @@
 #include <linux/cgroup.h>
 #include <linux/parser.h>
 #include <linux/cgroup_rdma.h>
+#include <linux/nsproxy.h>
 
 #define RDMACG_MAX_STR "max"
 
@@ -464,6 +465,13 @@ void rdmacg_unregister_device(struct rdmacg_device *device)
 }
 EXPORT_SYMBOL(rdmacg_unregister_device);
 
+/* netns_shared is toggled without rdmacg_mutex, hence READ_ONCE(). */
+static bool rdmacg_device_visible(const struct rdmacg_device *device)
+{
+	return READ_ONCE(device->netns_shared) ||
+	       net_eq(read_pnet(&device->net), current->nsproxy->net_ns);
+}
+
 static struct rdmacg_device *rdmacg_get_device_locked(const char *name)
 {
 	struct rdmacg_device *device;
@@ -471,7 +479,8 @@ static struct rdmacg_device *rdmacg_get_device_locked(const char *name)
 	lockdep_assert_held(&rdmacg_mutex);
 
 	list_for_each_entry(device, &rdmacg_devices, dev_node)
-		if (!strcmp(name, device->name))
+		if (rdmacg_device_visible(device) &&
+		    !strcmp(name, device->name))
 			return device;
 
 	return NULL;
@@ -626,6 +635,9 @@ static int rdmacg_resource_read(struct seq_file *sf, void *v)
 	mutex_lock(&rdmacg_mutex);
 
 	list_for_each_entry(device, &rdmacg_devices, dev_node) {
+		if (!rdmacg_device_visible(device))
+			continue;
+
 		seq_printf(sf, "%s ", device->name);
 
 		rpool = find_cg_rpool_locked(cg, device);
@@ -648,6 +660,9 @@ static int rdmacg_events_show(struct seq_file *sf, void *v)
 	mutex_lock(&rdmacg_mutex);
 
 	list_for_each_entry(device, &rdmacg_devices, dev_node) {
+		if (!rdmacg_device_visible(device))
+			continue;
+
 		rpool = find_cg_rpool_locked(cg, device);
 
 		seq_printf(sf, "%s ", device->name);
@@ -677,6 +692,9 @@ static int rdmacg_events_local_show(struct seq_file *sf, void *v)
 	mutex_lock(&rdmacg_mutex);
 
 	list_for_each_entry(device, &rdmacg_devices, dev_node) {
+		if (!rdmacg_device_visible(device))
+			continue;
+
 		rpool = find_cg_rpool_locked(cg, device);
 
 		seq_printf(sf, "%s ", device->name);
-- 
2.54.0


