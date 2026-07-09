Return-Path: <cgroups+bounces-17606-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 1eLOAAVyT2qDgwIAu9opvQ
	(envelope-from <cgroups+bounces-17606-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Thu, 09 Jul 2026 12:03:49 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5729372F4DB
	for <lists+cgroups@lfdr.de>; Thu, 09 Jul 2026 12:03:48 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=resnulli-us.20251104.gappssmtp.com header.s=20251104 header.b="wommJE/9";
	dmarc=none;
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-17606-lists+cgroups=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="cgroups+bounces-17606-lists+cgroups=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A2B65310555D
	for <lists+cgroups@lfdr.de>; Thu,  9 Jul 2026 09:55:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93F8E403AEA;
	Thu,  9 Jul 2026 09:55:50 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FA8C402B96
	for <cgroups@vger.kernel.org>; Thu,  9 Jul 2026 09:55:44 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783590950; cv=none; b=ZNOfA1xCC9zm6mNt7IawuCltE3jeHzbcbGymGj3psrU7OfFxZwLaN3Ir/DnKzqLiyPcVPcfpWKVC7ec3ZXW9WCZvInzp9SFSEDnYAxvuIw2l+drCmj7ro9knZ0b9eD4t8DjzI+RmWl0Blp5xhgVvpS+g5qrHJByWEe8Ytyw7P60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783590950; c=relaxed/simple;
	bh=6UDoNf30ivPVwjp0u1PGY2LvQDt84+EYUGg+xVi35E4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ty49naaC6g16H9ruGZ2D12TDYktXY342L6ZUU98OxT6texrNk/Vo9rfQeXy3+B/ceMkvK51QwD2eck1oev+pQqUrbyQUkguzn6xDjYx79uR71erRwzxVCKeRPEwreu8wonxaKUvDnp46DMyaR3tgTGYHAc4UVN4byh0CeW0hZhU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20251104.gappssmtp.com header.i=@resnulli-us.20251104.gappssmtp.com header.b=wommJE/9; arc=none smtp.client-ip=209.85.221.42
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-4720f3bf164so348285f8f.1
        for <cgroups@vger.kernel.org>; Thu, 09 Jul 2026 02:55:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20251104.gappssmtp.com; s=20251104; t=1783590942; x=1784195742; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=QwcmY/pDkmpKC91eDSrYfQSFLQBSA53bn2owxtB0gXE=;
        b=wommJE/99uEIJY6qMxNHEh8mN8dW8fisktRD8szftZ8H1ARDfcAkU/qmYfkC9jpGmb
         vlpw+a5Kuf5pQfQsqu0GrppJOeFc1vZoIbwvsaBJn17GjyhsViZNpGVK3US8yVaGYVoT
         YNooyPbnwlSDTg6QfpAX7ICQQ3k+PT1MwitkDE0Omf3FC9gTRtk8CFEyF3quz4YiTmuw
         UzZABUe5z30UUvnNt7OuRpNUpH1wfH3L54ikP9re+StTH+M1H1TCaAjNHNJtqaERwdhg
         Txidb0n2EjqRhlwe1O5sXy8qCY+5hJkY4sqsE96Qj/6Xp1FyKdtGmtVOZdprBn7WTXa/
         AR4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783590942; x=1784195742;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=QwcmY/pDkmpKC91eDSrYfQSFLQBSA53bn2owxtB0gXE=;
        b=aviBotU9ZXyxlqBum6jvUYkKFxd1z872HqqAeSc43ZDEtv35bapEOc+D8Ih4zM615g
         ISSsceyHg+GOJZ+Hrv9kPtiZgtsHY0FOijyE8RZBNd6uRMJLNHUoXD37fiC4EQJKuCzt
         p07riQ8g3mr0xWZKc4UpbnWMwkoRJAIkOtt4cVkgTjYsTeRjyYzaYQaOtIENvLfnnX13
         JsaVYDB8Few8OzspU+Nz77x8EIy9PawNdUrhCudQf/mkgLTB3ktzntokJTy4lYDES62l
         qBXXpYKZKAWTywzXwnlcXhE5bhleaR7m6HPobwkydFztShNFPgY5uvo0L+Yg3I7c3ow9
         fuFw==
X-Gm-Message-State: AOJu0YxZhzR79DQo2bmV+dvvLCYpBbqlJEyakHjUhbmQuCSj56ERCirk
	uj4C+I5W2k76AsasPRokcGZR+cPSkWLwmS3S1LsV1RVcLXzr8Xqze90mMTUNCvnHJOM=
X-Gm-Gg: AfdE7cnKv6GC/DJ32IiubFFctJpgB7ZaG+oDk6TeO+j3/7YqzZAMat9m2ygnDHNLdzo
	Bf0YXZOSroa9DZAuOcMnwODY/KB4Was9F+bppDHrE6/ElIwFM2wW+9wzGTAvmmWTR6IL49sefDn
	iXEzBwuUbz3cC30PM/9H7DW0pxFh22/FVJZiwipdyh280Per5pEqb/03yMJ/DjCWtDFFGl+KU+z
	B1Q3g89aCTwtkw+uZ/roHN8oymHT+2UtIaIxZgHZO731YEQEDajqII771BXMv9+fKOKTwT+g2Px
	T4ZcU9YrqPTb9Sy9Ci3PQ33fKSOOHj5hb0FPEsRNNf4WUD/hAygkLG94OeO+pW7JjhiJ46JPymL
	mv+PGZ7WuHqxQgnpCdhWGeFFg+cs+BcVF2FD+7IChSaSn3Nf3q9Kk/f409usIau7rrLpvas1EgR
	5dh8QdfpDHzwUhP1/PrES55A==
X-Received: by 2002:a05:6000:420f:b0:475:f0c2:75b3 with SMTP id ffacd0b85a97d-47df75656eemr1945365f8f.30.1783590942567;
        Thu, 09 Jul 2026 02:55:42 -0700 (PDT)
Received: from localhost ([140.209.217.211])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47aa039af67sm56791163f8f.17.2026.07.09.02.55.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jul 2026 02:55:42 -0700 (PDT)
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
Subject: [PATCH rdma-next 02/13] RDMA/core: Handle device name conflicts when changing net namespace
Date: Thu,  9 Jul 2026 11:55:21 +0200
Message-ID: <20260709095532.855647-3-jiri@resnulli.us>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-17606-lists,cgroups=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[resnulli.us:mid,resnulli.us:from_mime,resnulli-us.20251104.gappssmtp.com:dkim,vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,nvidia.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 5729372F4DB

From: Jiri Pirko <jiri@nvidia.com>

Prepare namespace moves for per-netns names. Check user-initiated moves for
destination-name conflicts before disabling the device, keep same-netns
moves as no-ops, and make teardown moves detach from the exiting namespace
even if fallback naming fails.

Signed-off-by: Jiri Pirko <jiri@nvidia.com>
---
 drivers/infiniband/core/device.c | 155 ++++++++++++++++++++++++++-----
 drivers/infiniband/core/nldev.c  |   3 +
 2 files changed, 137 insertions(+), 21 deletions(-)

diff --git a/drivers/infiniband/core/device.c b/drivers/infiniband/core/device.c
index de610f52c9b2..8d169658e312 100644
--- a/drivers/infiniband/core/device.c
+++ b/drivers/infiniband/core/device.c
@@ -268,7 +268,7 @@ static struct notifier_block ibdev_lsm_nb = {
 };
 
 static int rdma_dev_change_netns(struct ib_device *device, struct net *cur_net,
-				 struct net *net);
+				 struct net *net, const char *fallback_pattern);
 
 /* Pointer to the RCU head at the start of the ib_port_data array */
 struct ib_port_data_rcu {
@@ -437,7 +437,8 @@ int ib_device_set_dim(struct ib_device *ibdev, u8 use_dim)
 }
 
 /* Pick a free index for the '%d' style @name pattern. */
-static int alloc_name_id(struct net *net, const char *name)
+static int __alloc_name_id(struct net *net, const char *name,
+			   const struct ib_device *skip)
 {
 	struct ib_device *device;
 	unsigned long index;
@@ -450,6 +451,8 @@ static int alloc_name_id(struct net *net, const char *name)
 	xa_for_each (&devices, index, device) {
 		char buf[IB_DEVICE_NAME_MAX];
 
+		if (device == skip)
+			continue;
 		if (sscanf(dev_name(&device->dev), name, &i) != 1)
 			continue;
 		if (i < 0 || i >= INT_MAX)
@@ -469,6 +472,11 @@ static int alloc_name_id(struct net *net, const char *name)
 	return rc;
 }
 
+static int alloc_name_id(struct net *net, const char *name)
+{
+	return __alloc_name_id(net, name, NULL);
+}
+
 static int alloc_name(struct ib_device *ibdev, const char *name)
 {
 	int id;
@@ -1160,8 +1168,17 @@ static void rdma_dev_exit_net(struct net *net)
 
 		/*
 		 * If the real device is in the NS then move it back to init.
+		 * Provide a fallback pattern so a name conflict in init_net
+		 * cannot make the teardown move fail.
 		 */
-		rdma_dev_change_netns(dev, net, &init_net);
+		if (net_eq(net, read_pnet(&dev->coredev.rdma_net))) {
+			ret = rdma_dev_change_netns(dev, net, &init_net,
+						    "ibdev%d");
+			if (ret)
+				WARN(1,
+				     "Failed to move RDMA device %s to init_net on netns exit: %d\n",
+				     dev_name(&dev->dev), ret);
+		}
 
 		put_device(&dev->dev);
 		down_read(&devices_rwsem);
@@ -1680,14 +1697,71 @@ void ib_unregister_device_queued(struct ib_device *ib_dev)
 }
 EXPORT_SYMBOL(ib_unregister_device_queued);
 
+static bool rdma_dev_name_in_netns(struct ib_device *skip, struct net *net,
+				   const char *name)
+{
+	struct ib_device *device;
+	unsigned long index;
+
+	lockdep_assert_held_write(&devices_rwsem);
+
+	xa_for_each(&devices, index, device)
+		if (device != skip &&
+		    !strcmp(name, dev_name(&device->dev)))
+			return true;
+
+	return false;
+}
+
+/*
+ * Choose the name @device should use in net namespace @net: keep the current
+ * name when it is free, otherwise use a trusted '%d' @fallback_pattern
+ * (namespace teardown) to pick a free index. The caller must hold the write
+ * side of devices_rwsem.
+ */
+static int rdma_dev_pick_netns_name(struct ib_device *device, struct net *net,
+				    const char *fallback_pattern,
+				    char *buf, size_t buf_len,
+				    const char **new_name)
+{
+	int id;
+
+	lockdep_assert_held_write(&devices_rwsem);
+
+	if (!rdma_dev_name_in_netns(device, net, dev_name(&device->dev))) {
+		*new_name = dev_name(&device->dev);
+		return 0;
+	}
+
+	if (!fallback_pattern)
+		return -EEXIST;
+
+	snprintf(buf, buf_len, "ibdev%u", device->index);
+	if (!rdma_dev_name_in_netns(device, net, buf)) {
+		*new_name = buf;
+		return 0;
+	}
+
+	id = __alloc_name_id(net, fallback_pattern, device);
+	if (id < 0)
+		return id;
+	snprintf(buf, buf_len, fallback_pattern, id);
+	*new_name = buf;
+	return 0;
+}
+
 /*
  * The caller must pass in a device that has the kref held and the refcount
  * released. If the device is in cur_net and still registered then it is moved
  * into net.
+ *
+ * Naming rules are handled by rdma_dev_pick_netns_name().
  */
 static int rdma_dev_change_netns(struct ib_device *device, struct net *cur_net,
-				 struct net *net)
+				 struct net *net, const char *fallback_pattern)
 {
+	char buf[IB_DEVICE_NAME_MAX];
+	const char *new_name;
 	int ret2 = -EINVAL;
 	int ret;
 
@@ -1704,30 +1778,63 @@ static int rdma_dev_change_netns(struct ib_device *device, struct net *cur_net,
 		goto out;
 	}
 
+	if (!fallback_pattern) {
+		/*
+		 * Reject a predictable name conflict before tearing anything
+		 * down, so a doomed user move does not disable a live device.
+		 */
+		down_write(&devices_rwsem);
+		ret = rdma_dev_pick_netns_name(device, net, fallback_pattern,
+					       buf, sizeof(buf), &new_name);
+		up_write(&devices_rwsem);
+		if (ret)
+			goto out;
+	}
+
 	kobject_uevent(&device->dev.kobj, KOBJ_REMOVE);
 	disable_device(device);
 
 	/*
-	 * At this point no one can be using the device, so it is safe to
-	 * change the namespace.
+	 * Recompute the destination name under the write side of devices_rwsem
+	 * now that the device is disabled, closing races with a concurrent
+	 * registration or rename, then publish the new namespace at the sysfs
+	 * level.
 	 */
-	write_pnet(&device->coredev.rdma_net, net);
+	down_write(&devices_rwsem);
+	ret = rdma_dev_pick_netns_name(device, net, fallback_pattern, buf,
+				       sizeof(buf), &new_name);
+	if (ret) {
+		if (fallback_pattern) {
+			WARN(1,
+			     "%s: failed to pick device name during namespace teardown: %d\n",
+			     __func__, ret);
+			write_pnet(&device->coredev.rdma_net, net);
+			ret = 0;
+		}
+		goto rename_done;
+	}
 
-	down_read(&devices_rwsem);
-	/*
-	 * Currently rdma devices are system wide unique. So the device name
-	 * is guaranteed free in the new namespace. Publish the new namespace
-	 * at the sysfs level.
-	 */
-	ret = device_rename(&device->dev, dev_name(&device->dev));
-	up_read(&devices_rwsem);
+	write_pnet(&device->coredev.rdma_net, net);
+	ret = device_rename(&device->dev, new_name);
 	if (ret) {
-		dev_warn(&device->dev,
-			 "%s: Couldn't rename device after namespace change\n",
-			 __func__);
-		/* Try and put things back and re-enable the device */
-		write_pnet(&device->coredev.rdma_net, cur_net);
+		if (fallback_pattern) {
+			WARN(1,
+			     "%s: failed to rename device during namespace teardown: %d\n",
+			     __func__, ret);
+			ret = 0;
+		} else {
+			dev_warn(&device->dev,
+				 "%s: Couldn't rename device after namespace change\n",
+				 __func__);
+			/* Try and put things back and re-enable the device */
+			write_pnet(&device->coredev.rdma_net, cur_net);
+		}
+	} else {
+		strscpy(device->name, dev_name(&device->dev),
+			IB_DEVICE_NAME_MAX);
 	}
+rename_done:
+	up_write(&devices_rwsem);
 
 	ret2 = enable_device_and_get(device);
 	if (ret2) {
@@ -1766,6 +1873,12 @@ int ib_device_set_netns_put(struct sk_buff *skb,
 		goto ns_err;
 	}
 
+	/* Moving a device to the namespace it already lives in is a no-op. */
+	if (net_eq(net, read_pnet(&dev->coredev.rdma_net))) {
+		ret = 0;
+		goto ns_err;
+	}
+
 	/*
 	 * All the ib_clients, including uverbs, are reset when the namespace is
 	 * changed and this cannot be blocked waiting for userspace to do
@@ -1778,7 +1891,7 @@ int ib_device_set_netns_put(struct sk_buff *skb,
 
 	get_device(&dev->dev);
 	ib_device_put(dev);
-	ret = rdma_dev_change_netns(dev, current->nsproxy->net_ns, net);
+	ret = rdma_dev_change_netns(dev, current->nsproxy->net_ns, net, NULL);
 	put_device(&dev->dev);
 
 	put_net(net);
diff --git a/drivers/infiniband/core/nldev.c b/drivers/infiniband/core/nldev.c
index f599c24b34e8..3a9ec43a16f1 100644
--- a/drivers/infiniband/core/nldev.c
+++ b/drivers/infiniband/core/nldev.c
@@ -1195,6 +1195,9 @@ static int nldev_set_doit(struct sk_buff *skb, struct nlmsghdr *nlh,
 
 		ns_fd = nla_get_u32(tb[RDMA_NLDEV_NET_NS_FD]);
 		err = ib_device_set_netns_put(skb, device, ns_fd);
+		if (err == -EEXIST)
+			NL_SET_ERR_MSG(extack,
+				       "Device name already exists in the target net namespace");
 		goto put_done;
 	}
 
-- 
2.54.0


