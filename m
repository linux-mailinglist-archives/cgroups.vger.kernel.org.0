Return-Path: <cgroups+bounces-17609-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Prt0HXBwT2r5ggIAu9opvQ
	(envelope-from <cgroups+bounces-17609-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Thu, 09 Jul 2026 11:57:04 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1378472F33E
	for <lists+cgroups@lfdr.de>; Thu, 09 Jul 2026 11:57:04 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=resnulli-us.20251104.gappssmtp.com header.s=20251104 header.b=N54syBis;
	dmarc=none;
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-17609-lists+cgroups=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="cgroups+bounces-17609-lists+cgroups=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id EF4713056F28
	for <lists+cgroups@lfdr.de>; Thu,  9 Jul 2026 09:56:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFF91401485;
	Thu,  9 Jul 2026 09:55:58 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1868B402BAB
	for <cgroups@vger.kernel.org>; Thu,  9 Jul 2026 09:55:56 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783590958; cv=none; b=G0pM6PqdN8jh17C/5MPhmVARzi4sq1WVEvfLYA+vx+KtjQgMRJ174TwxT7MJN3QS2a8o2Azzw8boBi6PoWU+/KwA1qbKAikm4q+nPpO3hj2vjU+roMHGcivd8qXkqWCpychv/JdpSlK/GPLcNfmNA8EU0I0ZHs6lBX5KA/wlEMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783590958; c=relaxed/simple;
	bh=pdMmpZJCv+StAJxQjGBnq4nulDEDCbuKp7xLyLbTHHY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ILDr/67JN+VoPRqCt2G9ZS/lMHKsoAoGM0yLiP+yC3ybo5TVssdRrf2H9EL14oXtdePE9vSr8cTo84ybVGk9Po2H6MsDlZr/jb6oH8tspIJmEvgTN/apTuzXc7BT/dsYjk29V6iPRaRonexL63Q5TAeN2s55fHiNVgjjmCxw2/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20251104.gappssmtp.com header.i=@resnulli-us.20251104.gappssmtp.com header.b=N54syBis; arc=none smtp.client-ip=209.85.128.51
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-493c486f012so7096845e9.3
        for <cgroups@vger.kernel.org>; Thu, 09 Jul 2026 02:55:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20251104.gappssmtp.com; s=20251104; t=1783590955; x=1784195755; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=NfMuLF2nfHbgRgmO34SL3Jj6SviYlx2uzsjm64OYl7Y=;
        b=N54syBiswM9Yk8e2fpr9lVVBcEETybUF1tI5udYUpv4oHGx0pm3G3j9HCZ0uWX4EAM
         zY719SAoQ3LW8R/m2rwbA4CFuMt2dcW0dmkpd9T7mJTKi+a7bjKgQrdi/Isj/Rxofy3R
         DrcnkJAw8aLRzMMqVe4q+I07EuqfeHV4RThu/3+rQoUCzpLdwTDG0Y0c4v6dWTQqdhr3
         qJ1JlzrGKOoBwqssop5hmxZplWSMNUv3d+kgOIHp4DJC6pax29POn/xpxZcIDhYZzGQ6
         ONEAmkPd3b5JHV9gnmkB1e/Z8Iu7QIUY2jEeV3TUODc8BVSFY6vFrH2XVJlKDn3AbZyZ
         KtNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783590955; x=1784195755;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=NfMuLF2nfHbgRgmO34SL3Jj6SviYlx2uzsjm64OYl7Y=;
        b=qI9I4Oho9k/xvBVXkLmp0h/cK8JXU8gQqUiG1MD8HT5g8QhIk4T6QqBkS4sJs1ZVpv
         IAbJ97G5lQEa3XzvsYoShvEs9eO2Agzqg48TGa9N6J0vlRaDqlJ4sjUPn+xd+XbArE9z
         RhtJ80+62NATRchiG4L41CaQ/bg181Z3zkJw69/HTCSC1XHT/OBoUwFZ3pFPMFeWPGms
         4Obf9tz6+WafFyW1SCN1XmxACisK3qjHb7UdVwrIPcNFOFZSB8l1AdYSGuo0PwZAX5KT
         KTi4JZORIm9WnamTO2ewOvaMYUT1yIrhAnwIZgD8OXEdbVXfZw3f8mNSyehx73W4Fwzw
         wacQ==
X-Gm-Message-State: AOJu0YydUJQfKQgRUKNgQZ6W2TwS39kBitT6TE7Gf1gvB5KOYPGQFlvC
	ZMal4I3nNsfFjLRqwuMs9eRKYH4F2VgR9P8fi+rMZruvk4v3PZoyYDRxn0MuYfRqzzs=
X-Gm-Gg: AfdE7cmKCY4rojxPOeHMZlUuk1aFqKlk5DWGhcf8LBJ+KwtasrTrJaFiSJZsht5I/zW
	ibU/mgX3CQCG4F4ihW3JqGI6+2jFocxBm9ZHmVbShRi+aaAHgKnuG4302o4/p83FNrd+mNK/R8G
	kLZeR1cQ/Xxj3A6yAdP1bft4EJuNAndCcFCTuoIs4icB2DYu4JO+zCIowqVFwhGut3oZ1IEt3d9
	Qw4cJSYTaKvtPS5bIOEBRURJP4J7NWfn0G0ut2HxdCYxSInuWIVhr4up2BhLHkxmo6qYgQxThCU
	GBWtlIUY7P1bOdMsmlm3CHGX7RAsbQzCk+syYZ362yo8pgiRhfWf8UsDZzpSn0KyiXWCzGGOVje
	wg/BVx28G7N44FE3XIS+oyJtHVC44BJ7ojhqeUphPyQ+56iUYzC+ZIE1nAnZFtlqngH9yM3Ii87
	stQLF8xYUX399HEJsPy/Gdag==
X-Received: by 2002:a05:600c:83c6:b0:493:b8cd:2555 with SMTP id 5b1f17b1804b1-493e690497emr64042885e9.3.1783590955326;
        Thu, 09 Jul 2026 02:55:55 -0700 (PDT)
Received: from localhost ([140.209.217.211])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47a9de1e6ccsm50293284f8f.5.2026.07.09.02.55.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jul 2026 02:55:54 -0700 (PDT)
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
Subject: [PATCH rdma-next 06/13] net/smc: Look up the pnetid ib device within the net namespace
Date: Thu,  9 Jul 2026 11:55:25 +0200
Message-ID: <20260709095532.855647-7-jiri@resnulli.us>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-17609-lists,cgroups=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[resnulli-us.20251104.gappssmtp.com:dkim,resnulli.us:mid,resnulli.us:from_mime,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,nvidia.com:email,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 1378472F33E

From: Jiri Pirko <jiri@nvidia.com>

Scope smc_pnet_find_ib() to the caller's net namespace so pnetid setup
cannot bind to a same-named RDMA device from another namespace once names
become per-netns.

Signed-off-by: Jiri Pirko <jiri@nvidia.com>
---
 net/smc/smc_pnet.c | 20 ++++++++++++++------
 1 file changed, 14 insertions(+), 6 deletions(-)

diff --git a/net/smc/smc_pnet.c b/net/smc/smc_pnet.c
index 63e286e2dfaa..ff9c9c35cc2f 100644
--- a/net/smc/smc_pnet.c
+++ b/net/smc/smc_pnet.c
@@ -304,13 +304,18 @@ static bool smc_pnetid_valid(const char *pnet_name, char *pnetid)
 	return true;
 }
 
-/* Find an infiniband device by a given name. The device might not exist. */
-static struct smc_ib_device *smc_pnet_find_ib(char *ib_name)
+/*
+ * Find an infiniband device by a given name, restricted to the devices
+ * accessible from @net. The device might not exist.
+ */
+static struct smc_ib_device *smc_pnet_find_ib(struct net *net, char *ib_name)
 {
 	struct smc_ib_device *ibdev;
 
 	mutex_lock(&smc_ib_devices.mutex);
 	list_for_each_entry(ibdev, &smc_ib_devices.list, list) {
+		if (!rdma_dev_access_netns(ibdev->ibdev, net))
+			continue;
 		if (!strncmp(ibdev->ibdev->name, ib_name,
 			     sizeof(ibdev->ibdev->name)) ||
 		    (ibdev->ibdev->dev.parent &&
@@ -408,8 +413,8 @@ static int smc_pnet_add_eth(struct smc_pnettable *pnettable, struct net *net,
 	return rc;
 }
 
-static int smc_pnet_add_ib(struct smc_pnettable *pnettable, char *ib_name,
-			   u8 ib_port, char *pnet_name)
+static int smc_pnet_add_ib(struct smc_pnettable *pnettable, struct net *net,
+			   char *ib_name, u8 ib_port, char *pnet_name)
 {
 	struct smc_pnetentry *tmp_pe, *new_pe;
 	struct smc_ib_device *ib_dev;
@@ -419,7 +424,7 @@ static int smc_pnet_add_ib(struct smc_pnettable *pnettable, char *ib_name,
 	bool new_ibdev;
 
 	/* try to apply the pnetid to active devices */
-	ib_dev = smc_pnet_find_ib(ib_name);
+	ib_dev = smc_pnet_find_ib(net, ib_name);
 	if (ib_dev) {
 		ibdev_applied = smc_pnet_apply_ib(ib_dev, ib_port, pnet_name);
 		if (ibdev_applied)
@@ -518,7 +523,7 @@ static int smc_pnet_enter(struct net *net, struct nlattr *tb[])
 			if (ibport < 1 || ibport > SMC_MAX_PORTS)
 				goto error;
 		}
-		rc = smc_pnet_add_ib(pnettable, string, ibport, pnet_name);
+		rc = smc_pnet_add_ib(pnettable, net, string, ibport, pnet_name);
 		if (!rc)
 			new_ibdev = true;
 		else if (rc != -EEXIST)
@@ -1170,6 +1175,9 @@ int smc_pnetid_by_table_ib(struct smc_ib_device *smcibdev, u8 ib_port)
 	struct smc_net *sn;
 	int rc = -ENOENT;
 
+	if (!rdma_dev_access_netns(smcibdev->ibdev, &init_net))
+		return -ENOENT;
+
 	/* get pnettable for init namespace */
 	sn = net_generic(&init_net, smc_net_id);
 	pnettable = &sn->pnettable;
-- 
2.54.0


