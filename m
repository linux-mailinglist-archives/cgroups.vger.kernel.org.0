Return-Path: <cgroups+bounces-17790-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id J5XVLXpIVmpD2wAAu9opvQ
	(envelope-from <cgroups+bounces-17790-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Tue, 14 Jul 2026 16:32:26 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 09A35755DCF
	for <lists+cgroups@lfdr.de>; Tue, 14 Jul 2026 16:32:26 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=resnulli-us.20251104.gappssmtp.com header.s=20251104 header.b=ROAkY+Va;
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-17790-lists+cgroups=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="cgroups+bounces-17790-lists+cgroups=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 7A21D30317FD
	for <lists+cgroups@lfdr.de>; Tue, 14 Jul 2026 14:30:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3526D3A5E7A;
	Tue, 14 Jul 2026 14:30:06 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0658F36A022
	for <cgroups@vger.kernel.org>; Tue, 14 Jul 2026 14:30:03 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784039405; cv=none; b=RraXOnl2K/18gGqe7sl5Br1eB6fahNNw0qxXJARO7XU2Amapo0MVuySwH/BJfWkenFhvMGJbCkhVY83HScszW5jmrW0aatCshkrG+aAP+YwitsSR/aW6784voU7Iye1lcLOptChuoVIfxy2cl7Cmq9UB0JVx08NEXMDUzcjB6jQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784039405; c=relaxed/simple;
	bh=LDxEmI3TVHKUYrMzZXZyrOOfTxlXtBU8VlpAoeWy5yM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hsi1zbzePTuoWKY3pa08ltcO3m7KJtx+roRhWGi7asDnY938L1XK+1HJ5FFpGkl81rlouho1K+V8nk7fcNIlKd/h6zcZrwaeLwV3xC8D4YMm2XN3f2XCGS3ZvGK0Zs+wXw3OrF+cjyHSW/A9lh1VHGTNOWN+3nhsutZCDkpyOtE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20251104.gappssmtp.com header.i=@resnulli-us.20251104.gappssmtp.com header.b=ROAkY+Va; arc=none smtp.client-ip=209.85.221.52
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-4799b3f7c83so3329684f8f.2
        for <cgroups@vger.kernel.org>; Tue, 14 Jul 2026 07:30:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20251104.gappssmtp.com; s=20251104; t=1784039402; x=1784644202; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=bRy0m6NWNW2PQCoNaWlnRG4v0MDoFwNVbRxZWj5ydd0=;
        b=ROAkY+Va1RhknRon4sNjR1BdxgQKm7vZNt5NjxZEeLIM/2XO6783676tw/OvM+2lkS
         xtclMXJw/kLAJyXXcpSniC878MegV3m7D0zqKicbQsBRCXCDLpt3QcZCvlIQc3OULwze
         aoEAL8pWAwGtRChODh/ovw2dwEIskAP5IXWucP1tujWFhTAZIzBU8WskvdvSQyNOZPko
         ZtCHetYRvqqoX6PdevgyDdvbzP7k9AJZw+SsIbpfYy3pq4IV9to3L9buS5bHoFVLfEMv
         x52wh0341tORM1oYBjULVISziPzeixqs+yYswP5+Q7ieeXqRsCrMsq76x2Jb51pcswH6
         qcdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784039402; x=1784644202;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=bRy0m6NWNW2PQCoNaWlnRG4v0MDoFwNVbRxZWj5ydd0=;
        b=ObI7bx/k3j4h81t8hSYu09cE1TpPi4RK2LO/0ILgflEdeZgeUprnO5z6yKGniofe07
         ybzCuHAOiu4YZWJ2ncaXeTzCzDCuH+6dfyn0nQJ93CEZn2sPSsMH/HBJEPmUjS3qLcz2
         f1pvh5nDaNWJwMaCA/7iBj7oWSvh88aYjOYxpBgdxSqY4viqhaOC75Iq25puyNjBISYx
         LBtMboxtUIrKV4ggyFO4xayeR46fxfO+7wfpKilTI2Q7STPBOkdxOLrc9wgk6kXrND0i
         /qbon4thAPgDaRIvuZWkArjkOaBdldQDxkuTU6N2qKEllDU4T1yGTzUkgVbEpOhsaV+/
         4nuQ==
X-Gm-Message-State: AOJu0YwBnqxRgLE+ANNva/M//j+vkctneBrACr1/XcFQ+i/JSTX+xaG6
	4Tr+OgyLWwIxI5TU3MHjE2Y71DqPP6Al9jSdwEWxCtLl0sW+vyrIME+lXHfBwifdKY8=
X-Gm-Gg: AfdE7clSSTfn+V3wMFbwKRaITW7niq/hcy4v6rCPZZ3OyAPD8HemFf9lf1+R/LoEI3c
	CE7EgLh147p7q74pjGnBLT18CV1MKtB/EP61Cvd1AEuRndea/flLbhgUcvrsbug5u5YskWlkEfH
	Yp1IgQvUZsopAGzUEDnpVJ1bm7xie6H8Vs61NtKecxcNm9Ls2UGJWbM9AG2iFcdNeR0k2/pPsID
	Nnbse0VwjsQHUHopzaXc6s66gc/lzpkcjjMt1opXi6n/+9PtgotdH0wcMFDZ/igFyTnn7Ije8sw
	lcOeelZAAoFdC6/ZBc3YB06uJ2epCk9n2NidsVuDNi82FCTjbGLP6g1l13vlABmdTy3bJzzuUvf
	4M6Eti5VQ8q9S7dg+0xL64Ce02EdDTXAfV7iB7QR0MdfHfujYV3/jTvNqVHfBN82v2iD44ETmL3
	ucvI2GAYvv68EO9sHLK3UCOA==
X-Received: by 2002:a05:6000:250f:b0:46e:8226:96ba with SMTP id ffacd0b85a97d-47f2dcb517dmr16620596f8f.13.1784039402174;
        Tue, 14 Jul 2026 07:30:02 -0700 (PDT)
Received: from localhost ([140.209.217.211])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f4635ac2esm8714389f8f.13.2026.07.14.07.30.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2026 07:30:01 -0700 (PDT)
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
	wenjia@linux.ibm.com,
	yanjun.zhu@linux.dev,
	cui.tao@linux.dev
Subject: [PATCH rdma-next v2 08/14] RDMA/cgroup: Disambiguate devices across net namespaces
Date: Tue, 14 Jul 2026 16:29:21 +0200
Message-ID: <20260714142927.1298897-9-jiri@resnulli.us>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260714142927.1298897-1-jiri@resnulli.us>
References: <20260714142927.1298897-1-jiri@resnulli.us>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-17790-lists,cgroups=lfdr.de];
	FREEMAIL_CC(0.00)[vger.kernel.org,ziepe.ca,kernel.org,nvidia.com,linux.dev,acm.org,gmail.com,suse.com,cmpxchg.org,linux.alibaba.com,linux.ibm.com];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	DMARC_NA(0.00)[resnulli.us];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:linux-rdma@vger.kernel.org,m:cgroups@vger.kernel.org,m:netdev@vger.kernel.org,m:linux-s390@vger.kernel.org,m:linux-kselftest@vger.kernel.org,m:jgg@ziepe.ca,m:leon@kernel.org,m:parav@nvidia.com,m:mbloch@nvidia.com,m:cmeiohas@nvidia.com,m:roman.gushchin@linux.dev,m:bvanassche@acm.org,m:zyjzyj2000@gmail.com,m:shuah@kernel.org,m:tj@kernel.org,m:mkoutny@suse.com,m:hannes@cmpxchg.org,m:alibuda@linux.alibaba.com,m:dust.li@linux.alibaba.com,m:sidraya@linux.ibm.com,m:wenjia@linux.ibm.com,m:yanjun.zhu@linux.dev,m:cui.tao@linux.dev,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[jiri@resnulli.us,cgroups@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[resnulli-us.20251104.gappssmtp.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCPT_COUNT_TWELVE(0.00)[23];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,resnulli.us:from_mime,resnulli.us:mid,resnulli-us.20251104.gappssmtp.com:dkim,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,nvidia.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 09A35755DCF

From: Jiri Pirko <jiri@nvidia.com>

RDMA device names are unique only within a network namespace, but an
RDMA cgroup can account resources for devices from multiple namespaces.
Duplicate names therefore make cgroup output ambiguous and can cause
limit writes to select the wrong device.

Use the system-wide RDMA device index to distinguish duplicate names
while preserving the existing UAPI for unique names. Reject ambiguous
name-only writes with -ENOTUNIQ and expose a complete device view to
administrators.

Signed-off-by: Jiri Pirko <jiri@nvidia.com>
---
v1->v2:
- replace caller-netns filtering with global visibility and index-based
  disambiguation
---
 Documentation/admin-guide/cgroup-v1/rdma.rst |  8 +++
 Documentation/admin-guide/cgroup-v2.rst      | 15 ++++-
 drivers/infiniband/core/cgroup.c             |  1 +
 include/linux/cgroup_rdma.h                  |  1 +
 kernel/cgroup/rdma.c                         | 71 ++++++++++++++++----
 5 files changed, 83 insertions(+), 13 deletions(-)

diff --git a/Documentation/admin-guide/cgroup-v1/rdma.rst b/Documentation/admin-guide/cgroup-v1/rdma.rst
index e69369b7252e..8d0c3a796ee3 100644
--- a/Documentation/admin-guide/cgroup-v1/rdma.rst
+++ b/Documentation/admin-guide/cgroup-v1/rdma.rst
@@ -90,6 +90,13 @@ Following resources can be accounted by rdma controller.
   hca_object 	Maximum number of HCA Objects
   ==========    =============================
 
+RDMA devices from all network namespaces are listed. Each line starts with
+the device name. If more than one device has the same name, ``index=N``
+follows the name, where ``N`` is the system-wide RDMA device index, unique
+among registered devices. When configuring a limit, the index is optional
+for a globally unique name and required for a duplicate name. A write without
+the required index fails with ``-ENOTUNIQ``.
+
 2. Usage Examples
 =================
 
@@ -97,6 +104,7 @@ Following resources can be accounted by rdma controller.
 
 	echo mlx4_0 hca_handle=2 hca_object=2000 > /sys/fs/cgroup/rdma/1/rdma.max
 	echo ocrdma1 hca_handle=3 > /sys/fs/cgroup/rdma/2/rdma.max
+	echo "rxe0 index=5 hca_handle=2" > /sys/fs/cgroup/rdma/3/rdma.max
 
 (b) Query resource limit::
 
diff --git a/Documentation/admin-guide/cgroup-v2.rst b/Documentation/admin-guide/cgroup-v2.rst
index 993446ab66d0..df74d554d2cd 100644
--- a/Documentation/admin-guide/cgroup-v2.rst
+++ b/Documentation/admin-guide/cgroup-v2.rst
@@ -2752,6 +2752,11 @@ RDMA
 The "rdma" controller regulates the distribution and accounting of
 RDMA resources.
 
+RDMA devices from all network namespaces are listed. Each line starts with
+the device name. If more than one device has the same name, ``index=N``
+follows the name, where ``N`` is the system-wide RDMA device index, unique
+among registered devices.
+
 RDMA Interface Files
 ~~~~~~~~~~~~~~~~~~~~
 
@@ -2760,7 +2765,11 @@ RDMA Interface Files
 	except root that describes current configured resource limit
 	for a RDMA/IB device.
 
-	Lines are keyed by device name and are not ordered.
+	Lines are keyed by device name and are not ordered. A write may
+	include ``index=N`` after the device name. The index is optional
+	when the name is globally unique. If multiple devices have that
+	name, the index is required and a write without it fails with
+	``-ENOTUNIQ``.
 	Each line contains space separated resource name and its configured
 	limit that can be distributed.
 
@@ -2776,6 +2785,10 @@ RDMA Interface Files
 	  mlx4_0 hca_handle=2 hca_object=2000
 	  ocrdma1 hca_handle=3 hca_object=max
 
+	For devices with duplicate names, select the device by index::
+
+	  echo "rxe0 index=5 hca_handle=2" > rdma.max
+
   rdma.current
 	A read-only file that describes current resource usage.
 	It exists for all the cgroup except root.
diff --git a/drivers/infiniband/core/cgroup.c b/drivers/infiniband/core/cgroup.c
index 1f037fe01450..8611b4e32cfb 100644
--- a/drivers/infiniband/core/cgroup.c
+++ b/drivers/infiniband/core/cgroup.c
@@ -17,6 +17,7 @@
 void ib_device_register_rdmacg(struct ib_device *device)
 {
 	device->cg_device.name = device->name;
+	device->cg_device.index = device->index;
 	rdmacg_register_device(&device->cg_device);
 }
 
diff --git a/include/linux/cgroup_rdma.h b/include/linux/cgroup_rdma.h
index 404e746552ca..9a5c9ee728e7 100644
--- a/include/linux/cgroup_rdma.h
+++ b/include/linux/cgroup_rdma.h
@@ -34,6 +34,7 @@ struct rdmacg_device {
 	struct list_head	dev_node;
 	struct list_head	rpools;
 	char			*name;
+	u32			index;
 };
 
 /*
diff --git a/kernel/cgroup/rdma.c b/kernel/cgroup/rdma.c
index 5e82a03b3270..9489f3df0bf3 100644
--- a/kernel/cgroup/rdma.c
+++ b/kernel/cgroup/rdma.c
@@ -19,6 +19,7 @@
 #define RDMACG_MAX_STR "max"
 
 enum rdmacg_limit_tokens {
+	RDMACG_DEVICE_INDEX,
 	RDMACG_HCA_HANDLE_VAL,
 	RDMACG_HCA_HANDLE_MAX,
 	RDMACG_HCA_OBJECT_VAL,
@@ -27,6 +28,7 @@ enum rdmacg_limit_tokens {
 };
 
 static const match_table_t rdmacg_limit_tokens = {
+	{ RDMACG_DEVICE_INDEX,		"index=%u"	},
 	{ RDMACG_HCA_HANDLE_VAL,	"hca_handle=%d"	},
 	{ RDMACG_HCA_HANDLE_MAX,	"hca_handle=max"	},
 	{ RDMACG_HCA_OBJECT_VAL,	"hca_object=%d"	},
@@ -464,17 +466,53 @@ void rdmacg_unregister_device(struct rdmacg_device *device)
 }
 EXPORT_SYMBOL(rdmacg_unregister_device);
 
-static struct rdmacg_device *rdmacg_get_device_locked(const char *name)
+static struct rdmacg_device *
+rdmacg_get_device_locked(const char *name, bool has_index, u32 index)
 {
+	struct rdmacg_device *match = NULL;
 	struct rdmacg_device *device;
 
 	lockdep_assert_held(&rdmacg_mutex);
 
-	list_for_each_entry(device, &rdmacg_devices, dev_node)
-		if (!strcmp(name, device->name))
-			return device;
+	list_for_each_entry(device, &rdmacg_devices, dev_node) {
+		if (strcmp(name, device->name))
+			continue;
 
-	return NULL;
+		if (has_index) {
+			if (device->index == index)
+				return device;
+			continue;
+		}
+
+		if (match)
+			return ERR_PTR(-ENOTUNIQ);
+		match = device;
+	}
+
+	return match ?: ERR_PTR(-ENODEV);
+}
+
+static bool
+rdmacg_device_name_unique_locked(const struct rdmacg_device *device)
+{
+	struct rdmacg_device *other;
+
+	lockdep_assert_held(&rdmacg_mutex);
+
+	list_for_each_entry(other, &rdmacg_devices, dev_node)
+		if (other != device && !strcmp(other->name, device->name))
+			return false;
+
+	return true;
+}
+
+static void rdmacg_print_device_key(struct seq_file *sf,
+				    const struct rdmacg_device *device)
+{
+	seq_puts(sf, device->name);
+	if (!rdmacg_device_name_unique_locked(device))
+		seq_printf(sf, " index=%u", device->index);
+	seq_putc(sf, ' ');
 }
 
 static ssize_t rdmacg_resource_set_max(struct kernfs_open_file *of,
@@ -488,6 +526,8 @@ static ssize_t rdmacg_resource_set_max(struct kernfs_open_file *of,
 	char *p;
 	int *new_limits;
 	unsigned long enables = 0;
+	u32 dev_index = 0;
+	bool has_index = false;
 	int i = 0, ret = 0;
 
 	/* extract the device name first */
@@ -503,7 +543,7 @@ static ssize_t rdmacg_resource_set_max(struct kernfs_open_file *of,
 		goto err;
 	}
 
-	/* parse resource limit tokens */
+	/* parse the optional device index and resource limit tokens */
 	while ((p = strsep(&options, " \t\n"))) {
 		substring_t args[MAX_OPT_ARGS];
 		int tok, intval;
@@ -513,6 +553,13 @@ static ssize_t rdmacg_resource_set_max(struct kernfs_open_file *of,
 
 		tok = match_token(p, rdmacg_limit_tokens, args);
 		switch (tok) {
+		case RDMACG_DEVICE_INDEX:
+			if (has_index || match_uint(&args[0], &dev_index)) {
+				ret = -EINVAL;
+				goto parse_err;
+			}
+			has_index = true;
+			break;
 		case RDMACG_HCA_HANDLE_VAL:
 			if (match_int(&args[0], &intval) || intval < 0) {
 				ret = -EINVAL;
@@ -546,9 +593,9 @@ static ssize_t rdmacg_resource_set_max(struct kernfs_open_file *of,
 	/* acquire lock to synchronize with hot plug devices */
 	mutex_lock(&rdmacg_mutex);
 
-	device = rdmacg_get_device_locked(dev_name);
-	if (!device) {
-		ret = -ENODEV;
+	device = rdmacg_get_device_locked(dev_name, has_index, dev_index);
+	if (IS_ERR(device)) {
+		ret = PTR_ERR(device);
 		goto dev_err;
 	}
 
@@ -626,7 +673,7 @@ static int rdmacg_resource_read(struct seq_file *sf, void *v)
 	mutex_lock(&rdmacg_mutex);
 
 	list_for_each_entry(device, &rdmacg_devices, dev_node) {
-		seq_printf(sf, "%s ", device->name);
+		rdmacg_print_device_key(sf, device);
 
 		rpool = find_cg_rpool_locked(cg, device);
 		print_rpool_values(sf, rpool);
@@ -650,7 +697,7 @@ static int rdmacg_events_show(struct seq_file *sf, void *v)
 	list_for_each_entry(device, &rdmacg_devices, dev_node) {
 		rpool = find_cg_rpool_locked(cg, device);
 
-		seq_printf(sf, "%s ", device->name);
+		rdmacg_print_device_key(sf, device);
 		for (i = 0; i < RDMACG_RESOURCE_MAX; i++) {
 			seq_printf(sf, "%s.max=%llu %s.alloc_fail=%llu",
 				   rdmacg_resource_names[i],
@@ -679,7 +726,7 @@ static int rdmacg_events_local_show(struct seq_file *sf, void *v)
 	list_for_each_entry(device, &rdmacg_devices, dev_node) {
 		rpool = find_cg_rpool_locked(cg, device);
 
-		seq_printf(sf, "%s ", device->name);
+		rdmacg_print_device_key(sf, device);
 		for (i = 0; i < RDMACG_RESOURCE_MAX; i++) {
 			seq_printf(sf, "%s.max=%llu %s.alloc_fail=%llu",
 				   rdmacg_resource_names[i],
-- 
2.54.0


