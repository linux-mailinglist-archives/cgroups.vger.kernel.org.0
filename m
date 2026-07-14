Return-Path: <cgroups+bounces-17787-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id EYj0FztIVmof2wAAu9opvQ
	(envelope-from <cgroups+bounces-17787-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Tue, 14 Jul 2026 16:31:23 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C720755D67
	for <lists+cgroups@lfdr.de>; Tue, 14 Jul 2026 16:31:22 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=resnulli-us.20251104.gappssmtp.com header.s=20251104 header.b=xnM16DlI;
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-17787-lists+cgroups=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="cgroups+bounces-17787-lists+cgroups=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 1382A301F69C
	for <lists+cgroups@lfdr.de>; Tue, 14 Jul 2026 14:30:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A950547DD78;
	Tue, 14 Jul 2026 14:29:57 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D00847F2F9
	for <cgroups@vger.kernel.org>; Tue, 14 Jul 2026 14:29:53 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784039397; cv=none; b=CpqpDw1WsHURU8oPXICOt56vMLc/8xsbTkzuydXARTDZYZdcN/CZndpg6Z3QjDheNhEV0mT4/+F+uZpJy8Sh4w8pPlmDsS8hm6qo7RUs2Kn/FbmqAfO+blc/CY78OKpeS51A1aNdNrDKE7JMYiyIW/rWpRWgX6YM2CIaCvfQe04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784039397; c=relaxed/simple;
	bh=arqp4STH24gOt1WR8ANOHexprcbXDePbt4BmXI/EbWQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jEG228CIB0RWbBr3y46m/2mgfsgexCYkrTQCxA3u79XhpvgiXr1+gwluV0POGQfqwqTSR717Fpkf/HVUDgDzncpi5HFcnUHAu59vxQZ7X5pmHmoab71EEAz0woWAQiMiRFHDGMcQwaNxUoBxS7ingVVfFnDiEeMhcqCqi4uWbDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20251104.gappssmtp.com header.i=@resnulli-us.20251104.gappssmtp.com header.b=xnM16DlI; arc=none smtp.client-ip=209.85.221.53
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-47640541585so2102496f8f.1
        for <cgroups@vger.kernel.org>; Tue, 14 Jul 2026 07:29:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20251104.gappssmtp.com; s=20251104; t=1784039391; x=1784644191; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=qLqbGYXrDU0DpDR0so2JkJHWGdeLy/bGDG6GJds0Ueg=;
        b=xnM16DlIVzUY6LxMgC10w6o1KZ1GA5Ge0pBWSNrp3nPS4xlRgsO91PCdOr/S/JQRgB
         7qu+9jf3f29ab3nWMQSpMfueDgXJ8R69tFkUeHris0sDwhellQyeKVofMVCgZX0RhCeh
         fMS+0hTS8Jtex9f6F1pyxwAFysjWulzd/iXEGF7uzdO6jArS9/D8A8woD/UM3mtuI5e/
         SdyBi1aYbyXfHjZ2fPcjsUkl4JAyRVyc7F8rlDfnqo9lgG2whCiCElgueazkrZVtHAN0
         vMfUE4hcAmiqOrrjjE15IhgukjutQG/VfSzoqN3T2Y+KF2BDOaa5rs9AANvYAuSbrivr
         KcBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784039391; x=1784644191;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=qLqbGYXrDU0DpDR0so2JkJHWGdeLy/bGDG6GJds0Ueg=;
        b=JfV9Jlfmx74tRDa2BJbiPa3PM+CpfEUmHMym+kkDngbsWt+DEdyhOSIn6SuyS+8czH
         8Nej8lZoXM2bo/mY6LJaIxi/ugyERtGKtEmeQjn4syeUOA3T2rRuRHglSTyVrObKQE2f
         Rc4veFGEuwrRWy2ihuEZYOC3D3FPG5d2bccmRM6C5ZjDRNnvCoVkHAGyoFwHEz/PkvmE
         dD7rqTitsa6zy1RTvdE35tApga1tcpFV/bJk/gc3sMgJDQ8p3wI12feEP3zb3/WCxQeo
         fjEILzkF/PXfmHyMg0kzTchBWDIfjTgBZRoAh9GhGtMYtAG1cp7qB0dKWGwe/SuUSmXh
         GldA==
X-Gm-Message-State: AOJu0Yw2SvODr4ZrRWCyjuzvHMJjcsXerctpKr+5QEIX8GKR/AgkZYx7
	+HhD6azq65IitX8fxYHe7rfBXTNGQfQFg98FT1JttQV4uEYjBDarHsk1t2LwUbUZXR8=
X-Gm-Gg: AfdE7cn0U5bl1M8p8RW+qJ6MT++IM4wuvAW1tB1zHvSp7QPSwqwyBaAl38dT3mUIFP+
	Mnzj+oBhYllCvQ2WA2lX7rQVYS0TzyY3Xje9y692BMnCje3tV/YFMlnn/sMTzmdQFu7SEpBgWrb
	gLkb8/f5T0ZrfcRqEYfQXkLYcetLsWLVWgljuaaAdsnCyVuQ59Nlq4EX61RyTJpnEaujR8ItbUT
	4U/H+qEZptDtjegYBeqFSRmOoHnYcR+ccBJiNHBkkrjuCrTlEMci3Sv7Dg0pUoAn0i4wZ2Wjkzn
	tWao5l1TK00lpCw3jG7RrhBuziavz6fBsXvQQwyLLMckpkOo5eheyFu7wVZNwbW6++J7ApWp+WT
	FOuX2W8xPKIG0C957uvAWefgy78jtSem24Z0nBeLN9ousOa6MQ4lnh2PJAWQqOiBQYcJfJeCuFw
	aHTpGe/Sl6sf5HGn4AvGHsQw==
X-Received: by 2002:a05:6000:2388:b0:47d:ec60:657e with SMTP id ffacd0b85a97d-47f2dcecd20mr15946477f8f.39.1784039391456;
        Tue, 14 Jul 2026 07:29:51 -0700 (PDT)
Received: from localhost ([140.209.217.211])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f4634e0e4sm9077226f8f.4.2026.07.14.07.29.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2026 07:29:51 -0700 (PDT)
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
Subject: [PATCH rdma-next v2 05/14] RDMA/nldev: Allow setting the device name while changing net namespace
Date: Tue, 14 Jul 2026 16:29:18 +0200
Message-ID: <20260714142927.1298897-6-jiri@resnulli.us>
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
	TAGGED_FROM(0.00)[bounces-17787-lists,cgroups=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,resnulli.us:from_mime,resnulli.us:mid,resnulli-us.20251104.gappssmtp.com:dkim,nvidia.com:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 4C720755D67

From: Jiri Pirko <jiri@nvidia.com>

Accept RDMA_NLDEV_ATTR_DEV_NAME together with RDMA_NLDEV_NET_NS_FD so a
netlink move can rename the device in the destination namespace. Keep the
name semantics aligned with the existing RDMA rename path.

Signed-off-by: Jiri Pirko <jiri@nvidia.com>
---
 drivers/infiniband/core/device.c |  6 ++++++
 drivers/infiniband/core/nldev.c  | 27 ++++++++++++++++++---------
 include/uapi/rdma/rdma_netlink.h |  5 ++++-
 3 files changed, 28 insertions(+), 10 deletions(-)

diff --git a/drivers/infiniband/core/device.c b/drivers/infiniband/core/device.c
index 366bd8463c07..bb02640239d7 100644
--- a/drivers/infiniband/core/device.c
+++ b/drivers/infiniband/core/device.c
@@ -1901,6 +1901,9 @@ int ib_device_set_netns_put(struct sk_buff *skb,
 		if (ret == -EEXIST)
 			NL_SET_ERR_MSG(extack,
 				       "Device name already exists in the target net namespace");
+		else if (ret == -EINVAL && name)
+			NL_SET_ERR_MSG(extack,
+				       "Unable to use requested device name in the target net namespace");
 		goto ns_err;
 	}
 
@@ -1931,6 +1934,9 @@ int ib_device_set_netns_put(struct sk_buff *skb,
 	if (ret == -EEXIST)
 		NL_SET_ERR_MSG(extack,
 			       "Device name already exists in the target net namespace");
+	else if (ret == -EINVAL && name)
+		NL_SET_ERR_MSG(extack,
+			       "Unable to use requested device name in the target net namespace");
 
 	put_net(net);
 	return ret;
diff --git a/drivers/infiniband/core/nldev.c b/drivers/infiniband/core/nldev.c
index 8648e95700bf..4efa387ec1be 100644
--- a/drivers/infiniband/core/nldev.c
+++ b/drivers/infiniband/core/nldev.c
@@ -1178,6 +1178,24 @@ static int nldev_set_doit(struct sk_buff *skb, struct nlmsghdr *nlh,
 	if (!device)
 		return -EINVAL;
 
+	if (tb[RDMA_NLDEV_NET_NS_FD]) {
+		char name[IB_DEVICE_NAME_MAX] = {};
+		u32 ns_fd;
+
+		if (tb[RDMA_NLDEV_ATTR_DEV_NAME]) {
+			nla_strscpy(name, tb[RDMA_NLDEV_ATTR_DEV_NAME],
+				    IB_DEVICE_NAME_MAX);
+			if (strlen(name) == 0) {
+				err = -EINVAL;
+				goto done;
+			}
+		}
+		ns_fd = nla_get_u32(tb[RDMA_NLDEV_NET_NS_FD]);
+		err = ib_device_set_netns_put(skb, device, ns_fd,
+					      name[0] ? name : NULL, extack);
+		goto put_done;
+	}
+
 	if (tb[RDMA_NLDEV_ATTR_DEV_NAME]) {
 		char name[IB_DEVICE_NAME_MAX] = {};
 
@@ -1191,15 +1209,6 @@ static int nldev_set_doit(struct sk_buff *skb, struct nlmsghdr *nlh,
 		goto done;
 	}
 
-	if (tb[RDMA_NLDEV_NET_NS_FD]) {
-		u32 ns_fd;
-
-		ns_fd = nla_get_u32(tb[RDMA_NLDEV_NET_NS_FD]);
-		err = ib_device_set_netns_put(skb, device, ns_fd, NULL,
-					      extack);
-		goto put_done;
-	}
-
 	if (tb[RDMA_NLDEV_ATTR_DEV_DIM]) {
 		u8 use_dim;
 
diff --git a/include/uapi/rdma/rdma_netlink.h b/include/uapi/rdma/rdma_netlink.h
index 3af946ecbac3..ee11c3bbbae2 100644
--- a/include/uapi/rdma/rdma_netlink.h
+++ b/include/uapi/rdma/rdma_netlink.h
@@ -516,7 +516,10 @@ enum rdma_nldev_attr {
 	RDMA_NLDEV_ATTR_DEV_PROTOCOL,		/* string */
 
 	/*
-	 * File descriptor handle of the net namespace object
+	 * File descriptor handle of the net namespace object. May be combined
+	 * with RDMA_NLDEV_ATTR_DEV_NAME (a literal device name) to also rename
+	 * the device in the destination namespace; the move fails with -EEXIST
+	 * if that name is already taken there.
 	 */
 	RDMA_NLDEV_NET_NS_FD,			/* u32 */
 	/*
-- 
2.54.0


