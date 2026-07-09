Return-Path: <cgroups+bounces-17607-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Z8L8MEBwT2rZggIAu9opvQ
	(envelope-from <cgroups+bounces-17607-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Thu, 09 Jul 2026 11:56:16 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 64F1772F2FB
	for <lists+cgroups@lfdr.de>; Thu, 09 Jul 2026 11:56:16 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=resnulli-us.20251104.gappssmtp.com header.s=20251104 header.b=e68+VnAC;
	dmarc=none;
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-17607-lists+cgroups=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="cgroups+bounces-17607-lists+cgroups=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 05A33301B598
	for <lists+cgroups@lfdr.de>; Thu,  9 Jul 2026 09:55:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D2D94028D6;
	Thu,  9 Jul 2026 09:55:53 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A800401A02
	for <cgroups@vger.kernel.org>; Thu,  9 Jul 2026 09:55:50 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783590953; cv=none; b=TT5/829T0j0PXPaMP+P6luS5reG61qUVd2TK+jRQVxJWLCOvAhTVITa2kfocoCDvi4dwynx1rRGRsF3GQCyoSWUxd7bH4hw5aFbOkoURrT/dw/hZZyv54gViz0c3qIZzxge0bsXmYYVKyZyLF2NOehejq7D2fIQXnQqLT6okNuk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783590953; c=relaxed/simple;
	bh=Q+ioYosMcLR28Rk0UHBuj7VHjIKeDcYl6ZIU8ovFwzQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dnYESyJFZ325V6VwLp+5nq6VQ1aZESjEwKtkAJ26MEO9EqPbeTZEaBFCLMu3zU4ejI2/2jmS2tcNq2m5DITdBTwV097MRntrl7dz8MeysMScI+skipkuToYJ0gEGkhTq+LL4T8T0irxXTZaCQbPOR9ioLpcM2yfeMeEo+e0mZUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20251104.gappssmtp.com header.i=@resnulli-us.20251104.gappssmtp.com header.b=e68+VnAC; arc=none smtp.client-ip=209.85.221.48
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-4798bea72f9so314408f8f.1
        for <cgroups@vger.kernel.org>; Thu, 09 Jul 2026 02:55:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20251104.gappssmtp.com; s=20251104; t=1783590949; x=1784195749; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=cTe/xvJ3msxEWBlJbFLbtJMtjmfOZ8+sCmPsSsQl0Tk=;
        b=e68+VnACHZD5r0+cV/7XOA3nTEwnDSV3wqroEG/fEfl6PLGr4Ci5ZyMFZ65g+BWnW9
         uLrjRftydX2HvPgPhOAhbw7dLzk12+4nKpZ9kngjNEIJNQjJLgBEPmNRwhYYoBTh6ZG2
         G46vlKa/DYRXLtFIz6w6HFu7C+jXb5eNVq4xp/hDENEajydcsCHoMEnPp/7TV9n/Ggpj
         XgrPQqU7unmGcE6cJ0yMyYg4eevxwostaqgzdrfpRuh0nY75nKUrBTSlkaG577qA+tpW
         G0eCBH1qphKzjk2xobtR5QolJFMWpbtmiEXw97lhpWYG3CjaOt/RQn/VT9UG+IjqGkRX
         QbbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783590949; x=1784195749;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=cTe/xvJ3msxEWBlJbFLbtJMtjmfOZ8+sCmPsSsQl0Tk=;
        b=c2XK8eC2zNwTdx6zhAz3Uuj0at0AiMB2V7zfTzBYq45KmBLeKALPOOH7JqklfAR/ga
         Izg+vGYk7H8M25T6QC3eKHLGLpMIU+DNYjadPLmjsRK+KaX6tL4ExV0tJ84VYONsYEif
         vUPMS+ICeRLBGPa1KtxO+FxbXHtr21JN6zI0jKAofIAzhqA/tngditS+ZSu9VXgEoOkw
         WJqUCIIE2NkRGBsvEsudTFch0Cc5jaaTdex9bWalh+7N7qpKaWMrXQT3zZnyaDX9xSOB
         wnckPthdxXVIfYQaWLo5P/yolk6lIqYTtHGz5KoSmByuQEjp4eFkrx3e0Fs3bX4vHevU
         bJjA==
X-Gm-Message-State: AOJu0Yy+ZF6IzNgZFMybUNFnaTSbBp6s1IK5aQDT0/4oFSdDmA6FHqKD
	UBAlpe6UGwx6h6HTQphsbNhd08BZF3B0vs0CiP/1h60McS25M/hQsYckujVDeOrYC1s=
X-Gm-Gg: AfdE7cksUkxa1M69phKwbSGNNGOi7m96qEcRmOJfGEUlItpvQdBxfyQ1vsK17DM7I/j
	EORfLed+uWeibm+lJ3azwHo98lVZUjZUVsrYmVAEpxdBid8+RCt/EpTee2kF03o86JkUBDl58Sb
	qTRP1bHXjj6umet16+EUVSpXiKBKmqo/r1C3OrCEJnjCy2TMWIU8MqCdxuEUoaJs2syw2XypchS
	8sHjiK7NMysL1gXCSYBVG1szwVSajEKBkZT4vva3TsaUxbHyrzoNH7x/tghpoLP1frrxElaZVnN
	SHSCYNapiR+zdAKlnT4jBm1jgZwE928HnP3gVD4NEKdkr94HfDFImcC85XrPwBNYaoZfyeHiJtQ
	6942Xg93z3VJqFERNtXJ/JpY4avSq0/cVe38/lXRtqKd4ekWSPt6elVFKJbvwSd/S7m3mlntCLU
	sJVB6KLYd5xRaEwXrfzB5sHw==
X-Received: by 2002:a05:6000:230d:b0:472:76ad:b329 with SMTP id ffacd0b85a97d-47df071bac3mr6678726f8f.6.1783590948908;
        Thu, 09 Jul 2026 02:55:48 -0700 (PDT)
Received: from localhost ([140.209.217.211])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47a9de1e6ccsm50292543f8f.5.2026.07.09.02.55.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jul 2026 02:55:48 -0700 (PDT)
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
Subject: [PATCH rdma-next 04/13] RDMA/nldev: Report net namespace move errors through extack
Date: Thu,  9 Jul 2026 11:55:23 +0200
Message-ID: <20260709095532.855647-5-jiri@resnulli.us>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-17607-lists,cgroups=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,resnulli.us:mid,resnulli.us:from_mime,resnulli-us.20251104.gappssmtp.com:dkim,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,nvidia.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 64F1772F2FB

From: Jiri Pirko <jiri@nvidia.com>

Thread extack through the existing net namespace move helper and report the
main failure reasons from the core path. Keep the existing move UAPI shape
unchanged.

Signed-off-by: Jiri Pirko <jiri@nvidia.com>
---
 drivers/infiniband/core/core_priv.h |  3 ++-
 drivers/infiniband/core/device.c    | 24 ++++++++++++++++++++++--
 drivers/infiniband/core/nldev.c     |  6 ++----
 3 files changed, 26 insertions(+), 7 deletions(-)

diff --git a/drivers/infiniband/core/core_priv.h b/drivers/infiniband/core/core_priv.h
index 3bd5bb7135a3..aaf330b0d333 100644
--- a/drivers/infiniband/core/core_priv.h
+++ b/drivers/infiniband/core/core_priv.h
@@ -356,7 +356,8 @@ void ib_port_unregister_client_groups(struct ib_device *ibdev, u32 port_num,
 				     const struct attribute_group **groups);
 
 int ib_device_set_netns_put(struct sk_buff *skb,
-			    struct ib_device *dev, u32 ns_fd, const char *name);
+			    struct ib_device *dev, u32 ns_fd, const char *name,
+			    struct netlink_ext_ack *extack);
 
 int rdma_nl_net_init(struct rdma_dev_net *rnet);
 void rdma_nl_net_exit(struct rdma_dev_net *rnet);
diff --git a/drivers/infiniband/core/device.c b/drivers/infiniband/core/device.c
index 191f05898bae..2391bc7c8d23 100644
--- a/drivers/infiniband/core/device.c
+++ b/drivers/infiniband/core/device.c
@@ -1871,18 +1871,22 @@ static int rdma_dev_change_netns(struct ib_device *device, struct net *cur_net,
 }
 
 int ib_device_set_netns_put(struct sk_buff *skb,
-			    struct ib_device *dev, u32 ns_fd, const char *name)
+			    struct ib_device *dev, u32 ns_fd, const char *name,
+			    struct netlink_ext_ack *extack)
 {
 	struct net *net;
 	int ret;
 
 	net = get_net_ns_by_fd(ns_fd);
 	if (IS_ERR(net)) {
+		NL_SET_ERR_MSG(extack, "Invalid target net namespace fd");
 		ret = PTR_ERR(net);
 		goto net_err;
 	}
 
 	if (!netlink_ns_capable(skb, net->user_ns, CAP_NET_ADMIN)) {
+		NL_SET_ERR_MSG(extack,
+			       "Missing CAP_NET_ADMIN in the target net namespace");
 		ret = -EPERM;
 		goto ns_err;
 	}
@@ -1893,6 +1897,10 @@ int ib_device_set_netns_put(struct sk_buff *skb,
 	 */
 	if (net_eq(net, read_pnet(&dev->coredev.rdma_net))) {
 		ret = name ? ib_device_rename(dev, name) : 0;
+
+		if (ret == -EEXIST)
+			NL_SET_ERR_MSG(extack,
+				       "Device name already exists in the target net namespace");
 		goto ns_err;
 	}
 
@@ -1901,7 +1909,16 @@ int ib_device_set_netns_put(struct sk_buff *skb,
 	 * changed and this cannot be blocked waiting for userspace to do
 	 * something, so disassociation is mandatory.
 	 */
-	if (!dev->ops.disassociate_ucontext || ib_devices_shared_netns) {
+	if (ib_devices_shared_netns) {
+		NL_SET_ERR_MSG(extack,
+			       "Cannot change net namespace of RDMA device in shared netns mode");
+		ret = -EOPNOTSUPP;
+		goto ns_err;
+	}
+
+	if (!dev->ops.disassociate_ucontext) {
+		NL_SET_ERR_MSG(extack,
+			       "Device does not support namespace changes (no disassociate support)");
 		ret = -EOPNOTSUPP;
 		goto ns_err;
 	}
@@ -1911,6 +1928,9 @@ int ib_device_set_netns_put(struct sk_buff *skb,
 	ret = rdma_dev_change_netns(dev, current->nsproxy->net_ns, net, name,
 				    NULL);
 	put_device(&dev->dev);
+	if (ret == -EEXIST)
+		NL_SET_ERR_MSG(extack,
+			       "Device name already exists in the target net namespace");
 
 	put_net(net);
 	return ret;
diff --git a/drivers/infiniband/core/nldev.c b/drivers/infiniband/core/nldev.c
index 3540cb0b9d4f..5fd1ef2c5050 100644
--- a/drivers/infiniband/core/nldev.c
+++ b/drivers/infiniband/core/nldev.c
@@ -1194,10 +1194,8 @@ static int nldev_set_doit(struct sk_buff *skb, struct nlmsghdr *nlh,
 		u32 ns_fd;
 
 		ns_fd = nla_get_u32(tb[RDMA_NLDEV_NET_NS_FD]);
-		err = ib_device_set_netns_put(skb, device, ns_fd, NULL);
-		if (err == -EEXIST)
-			NL_SET_ERR_MSG(extack,
-				       "Device name already exists in the target net namespace");
+		err = ib_device_set_netns_put(skb, device, ns_fd, NULL,
+					      extack);
 		goto put_done;
 	}
 
-- 
2.54.0


