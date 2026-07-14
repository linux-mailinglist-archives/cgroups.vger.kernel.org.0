Return-Path: <cgroups+bounces-17793-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 5W/eBpVIVmpF2wAAu9opvQ
	(envelope-from <cgroups+bounces-17793-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Tue, 14 Jul 2026 16:32:53 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C283755DD4
	for <lists+cgroups@lfdr.de>; Tue, 14 Jul 2026 16:32:52 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=resnulli-us.20251104.gappssmtp.com header.s=20251104 header.b=yiRL3cZY;
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-17793-lists+cgroups=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="cgroups+bounces-17793-lists+cgroups=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 51FD2304D722
	for <lists+cgroups@lfdr.de>; Tue, 14 Jul 2026 14:30:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2360147DFB2;
	Tue, 14 Jul 2026 14:30:20 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3016A37DAB3
	for <cgroups@vger.kernel.org>; Tue, 14 Jul 2026 14:30:18 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784039419; cv=none; b=bPPEykoAlMYnBGVDUY5eg+ExrLNWRjt0Pl7ydLGraCAalew4KTEqkAp3DaM7N8mkflw44pFBKPkH+ylEQrvY369gNk4CnLNOOKh5gk5CzFZRzEJ2CJBrRQ0q4INmuLjQwI6McgOlnPABotImDFcesadAnsxGKbd9E54XuFsD9Eo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784039419; c=relaxed/simple;
	bh=vXTVHC8jrIfunzmq69nH+ECf64rA25Ltg6ybB9/xSAY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ub/1fszJBWqWlE+AUUFwk1ctRVkm90PrfB7gb0PMS187DYIS0o82I4z09USiGgpvFWm2MnwliKDZRVJ5p2PN/5TyzZTsGCDXr6Ri9S81JliHxuB4JKpHpdT7VLK4FprT5rf8qsCS8/xTeSjtTR3VqgroeDTluxnnYMlVyZmu8E4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20251104.gappssmtp.com header.i=@resnulli-us.20251104.gappssmtp.com header.b=yiRL3cZY; arc=none smtp.client-ip=209.85.208.176
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-39c7ac9b8c3so9990751fa.0
        for <cgroups@vger.kernel.org>; Tue, 14 Jul 2026 07:30:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20251104.gappssmtp.com; s=20251104; t=1784039416; x=1784644216; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=axmo6X45l643i+ylWNgoVG07bt+75yV7VClJ23IyRYM=;
        b=yiRL3cZY7eyG1TxmA7qo4lIGpnJYumz4/n1g5qcE1/Z2loCuguzG4swBu0DViUKfZG
         bX64uFF1VLuOSd3VTkVSTA03Zg5KU0shpHG42LsVvCYC6mUnjx9qMxEMmolc40Gov5++
         nP+gGJ73SBtiyBiGoOYKvH8v8fjXAXwF+hUUwy4O5FNKuvBHGfF6vVXXvCGqPEQyE8sb
         ef9jcwjy89H0cyIu2b9MMAVoR5PH0xKZ0E412v1ErfdMW5dAIZIy+TjWmruWvUgrxClw
         ik9Zf8e5kt3nRppJ8EsmkH/6BHl5Lw4GDvStE0KnYE80UUT9jjCzJFhP+vDAfNe/fTQV
         mMqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784039416; x=1784644216;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=axmo6X45l643i+ylWNgoVG07bt+75yV7VClJ23IyRYM=;
        b=cSnhCqSMP24bD22wiBr+RCyNTeWFBLPXFXbCNzjgyGQqpmLA5xUp+9ONfMlrThtjYR
         KtAs5CoUFEuxx4pOov0/XjrLFdv4KN32KA2J5OBmLwteFJ/sj8Oz15R2uhTlKRhi4G+3
         wnRwiwLxj7+fSMDjtvkJvSY4vQb/gtJrY7yLFFNuiQLgXXCJbFhcinve3juoFflTUg+A
         o2I8semV1chQDEf7RMFBmEREiFN2rK4lGlr0ujtA1vi8N1heOPMdEENXSj8J5Kw8q2C/
         YFR3cf0CUJVkK06nh+bj69SYCgtTyWV9tcH3HWiVVzWBBebgvwZWg1FHZ0F28sihRQDd
         CvBA==
X-Gm-Message-State: AOJu0YxlBP3SMzSJ1a1FyfuzqCdcQTXQp24/o9j7f2iDaGV8K3nqMkti
	/c4wO2uGANLbZHkBLsSRWHtaf4F+xLA3eETYNqcThCTuWPdgvlmXQk15AHmsT5Sn1jM=
X-Gm-Gg: AfdE7ckgnRvzNCFyQg6pRlKVV6h8DWGtQWRapaWzj88F2dHx+dZZKM8yB/4gUTSl8I9
	RSP5+LWJ+X3lEBWXZLPpza9IlR/fLEQHIHBTCpo09irDkBTvwAutJcWi/n7USyPsSsjN+1iRhfi
	oTn3ZUkIPdaVGFXMsWCTRljxCeEF35o5tAOWRuI6Et1oEx4kXu2vAX/4iV6rMSRTPPMm4F8WTfz
	HAL1fTXiYH5459fgEYjxfb3sAzSieSr6LexyH0z8IYl5umCQ1kHEAMGx4QmUh4q/i2/SEzQ9EQf
	ytNouAv1PbGaI12usm+wrXjCd6ClczIGjdnd5wbatwYCzuPYUfVpm2P6NuIeC3YToD1uwCOPduU
	/JdNUaOQEq2umVuda+Y93Xzw7xm8aYsFUDR6pWrdQyHOHOR0KkW7o0OfkzdQPg2t1ZIJgYnM75A
	gnr3dfVRxh0a2ZQ/P5NMvu9g==
X-Received: by 2002:a2e:a584:0:b0:39d:ab29:b731 with SMTP id 38308e7fff4ca-39dab29bc4dmr8571781fa.27.1784039415388;
        Tue, 14 Jul 2026 07:30:15 -0700 (PDT)
Received: from localhost ([140.209.217.211])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-39c84bb39fesm34469241fa.42.2026.07.14.07.30.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2026 07:30:13 -0700 (PDT)
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
Subject: [PATCH rdma-next v2 11/14] RDMA/core: Make device names unique per net namespace
Date: Tue, 14 Jul 2026 16:29:24 +0200
Message-ID: <20260714142927.1298897-12-jiri@resnulli.us>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-17793-lists,cgroups=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,resnulli.us:from_mime,resnulli.us:mid,nvidia.com:email,resnulli-us.20251104.gappssmtp.com:dkim]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 9C283755DD4

From: Jiri Pirko <jiri@nvidia.com>

Use rdma_dev_access_netns() to scope RDMA device name lookup and "%d" name
allocation to the relevant net namespace. Keep shared mode and
CONFIG_NET_NS=n behaviour system-wide.

Signed-off-by: Jiri Pirko <jiri@nvidia.com>
---
 drivers/infiniband/core/device.c | 22 +++++++++++++++-------
 1 file changed, 15 insertions(+), 7 deletions(-)

diff --git a/drivers/infiniband/core/device.c b/drivers/infiniband/core/device.c
index bb02640239d7..4c75078448a3 100644
--- a/drivers/infiniband/core/device.c
+++ b/drivers/infiniband/core/device.c
@@ -129,7 +129,7 @@ static DECLARE_RWSEM(rdma_nets_rwsem);
 bool ib_devices_shared_netns = true;
 module_param_named(netns_mode, ib_devices_shared_netns, bool, 0444);
 MODULE_PARM_DESC(netns_mode,
-		 "Share device among net namespaces; default=1 (shared)");
+		 "Share device among net namespaces; default=1 (shared). In exclusive mode device names are unique per net namespace");
 /**
  * rdma_dev_access_netns() - Return whether an rdma device can be accessed
  *			     from a specified net namespace or not.
@@ -359,7 +359,8 @@ static struct ib_device *__ib_device_get_by_name(const char *name,
 	unsigned long index;
 
 	xa_for_each (&devices, index, device)
-		if (!strcmp(name, dev_name(&device->dev)))
+		if (rdma_dev_access_netns(device, net) &&
+		    !strcmp(name, dev_name(&device->dev)))
 			return device;
 
 	return NULL;
@@ -437,7 +438,11 @@ int ib_device_set_dim(struct ib_device *ibdev, u8 use_dim)
 	return 0;
 }
 
-/* Pick a free index for the '%d' style @name pattern. */
+/*
+ * Pick a free index for the '%d' style @name pattern within net namespace
+ * @net. Returns the index on success or a negative errno. The caller builds
+ * the final unique device name from the returned index.
+ */
 static int __alloc_name_id(struct net *net, const char *name,
 			   const struct ib_device *skip)
 {
@@ -452,7 +457,7 @@ static int __alloc_name_id(struct net *net, const char *name,
 	xa_for_each (&devices, index, device) {
 		char buf[IB_DEVICE_NAME_MAX];
 
-		if (device == skip)
+		if (device == skip || !rdma_dev_access_netns(device, net))
 			continue;
 		if (sscanf(dev_name(&device->dev), name, &i) != 1)
 			continue;
@@ -1233,7 +1238,8 @@ static __net_init int rdma_dev_init_net(struct net *net)
 }
 
 /*
- * Assign the unique string device name and the unique device index. This is
+ * Assign the unique string device name and the unique device index. The device
+ * name is unique within the net namespace the device is assigned to. This is
  * undone by ib_dealloc_device.
  */
 static int assign_name(struct ib_device *device, const char *name)
@@ -1416,8 +1422,9 @@ static void ib_device_notify_register(struct ib_device *device)
 /**
  * ib_register_device - Register an IB device with IB core
  * @device: Device to register
- * @name: unique string device name. This may include a '%' which will
- * 	  cause a unique index to be added to the passed device name.
+ * @name: device name, unique within the device's net namespace. This may
+ *	  include a '%' which will cause a unique index to be added to the
+ *	  passed device name.
  * @dma_device: pointer to a DMA-capable device. If %NULL, then the IB
  *	        device will be used. In this case the caller should fully
  *		setup the ibdev for DMA. This usually means using dma_virt_ops.
@@ -1708,6 +1715,7 @@ static bool rdma_dev_name_in_netns(struct ib_device *skip, struct net *net,
 
 	xa_for_each(&devices, index, device)
 		if (device != skip &&
+		    rdma_dev_access_netns(device, net) &&
 		    !strcmp(name, dev_name(&device->dev)))
 			return true;
 
-- 
2.54.0


