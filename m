Return-Path: <cgroups+bounces-17795-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id BsXrGb1IVmpS2wAAu9opvQ
	(envelope-from <cgroups+bounces-17795-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Tue, 14 Jul 2026 16:33:33 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 18B8D755E02
	for <lists+cgroups@lfdr.de>; Tue, 14 Jul 2026 16:33:33 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=resnulli-us.20251104.gappssmtp.com header.s=20251104 header.b=eU3KBUJN;
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-17795-lists+cgroups=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="cgroups+bounces-17795-lists+cgroups=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 92A2E3053C88
	for <lists+cgroups@lfdr.de>; Tue, 14 Jul 2026 14:31:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94B3E36A022;
	Tue, 14 Jul 2026 14:30:30 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 479133921E6
	for <cgroups@vger.kernel.org>; Tue, 14 Jul 2026 14:30:28 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784039430; cv=none; b=PsH6e5O4iBQHWfM0RfTcRDTMyCDVU1jYoI9yJn654Xhq7Qqxy3g48wogTfTLu04IbpF+Kol2o995v2PX6RTDyFVfa+gIZJpwW5hyW8iU10T36F8MKL9uRL7OB1AQe/QlMoBv3L3J005Yldxd3xxCkkYHkh/K7NGdmeMo8QhSBqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784039430; c=relaxed/simple;
	bh=AlWKq+WCpJ6jqrd7bHxM+xUmQDKopJjD0aSNOnzQ77Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=c9dg8uEzmtxND149tccTOWpTPTUKONkSWv/m3L1VeEanbJuz3m+akHWG9daTG9Ok4pesw9FC5QgFokuI4EGSbfJp/ZTxfwV6o85gkeGkEmu/88MfX5iViBIuTbGPM34QfhUgd6nAY63pdMkg53kv5zEqoPpU13gPoGtw6XFC0DQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20251104.gappssmtp.com header.i=@resnulli-us.20251104.gappssmtp.com header.b=eU3KBUJN; arc=none smtp.client-ip=209.85.167.47
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-5aebc8cb5bcso2995605e87.2
        for <cgroups@vger.kernel.org>; Tue, 14 Jul 2026 07:30:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20251104.gappssmtp.com; s=20251104; t=1784039426; x=1784644226; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=1DAcALuj6CLiGGxg2YU+zPjUKqyxKHB8HUr7MGOtyF0=;
        b=eU3KBUJNoAxPw7pVvTRmdsZuqaSzCsRc5zvDXfoqhEXRqsJzYvuCRa20VFhhOE30sb
         sWtoh0VOxwrR+Wb36oLsaQftZjmTMtTyQP12VJTgjqGIjHpLrJvZp22+mGbjtUrHEnLK
         E1vLqDUj+W90vyHhsS3oCNcAYLtdwzSIyDEzeia2vKHmBOAnyGZ7P0q/biZofagDyyUn
         AL/jhBP9LWECGNjpAecCcCpnOU28iuPSNFx7TOAYJrvWsa76PoYR84qCM9sVeej+/ZJC
         wvCGEd27wgcXw3FDtvWPSGPQU2gWz6+mI4NbxdtFcOLSYzfZLHA0l+sYEJf/RPt5kGzP
         csWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784039426; x=1784644226;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=1DAcALuj6CLiGGxg2YU+zPjUKqyxKHB8HUr7MGOtyF0=;
        b=lKSqLLxzPAKK4Nj3Tzk3SJjVx6VsDA6tdxF5NFLjGdfInKUi3WfkalKMRD4LpDddLa
         ZNbANdwSgi4yynLqGFs8+C6Z052FSjASoAni/FIyAVVn6HAi6Gkv75d/VRsysZEx5R/J
         H8RejTjUFc39xREbTLYAo/+pEIJ91fjv9aglL3ntm0X7MrqINw+vAbHalazHKiYf2Jux
         11aWZ2S6CD94Wp4MFbeNv9TS0siQWBTbbQ9DquhLXbegJyn6UGjd7w7qCqzKNTsYT7cd
         tFQRgYBHX1hra0Q2cdahNjCIwl5k/mN3PiP5REvpKdiJw4Nmj4dAhSiRlc4u5XfM53yw
         5Tkw==
X-Gm-Message-State: AOJu0YzjgNGejxYXklUxerKdjLLNa75oL+hbepku+qwua5iCDN5XoEGK
	YOZjomjTc6wV+ZEc2/qPyaTmpCvGGTc6kOqtPEjLWobDolbjZlbAES3sIehgJ4DKDAw=
X-Gm-Gg: AfdE7cmIxNUmLhWrAIhhHbtJUMbogiR5yVDMu9pGRY6qhTd89dbhRNbuOLfw6WW6xIf
	RlHZ3MkwiqbCd7O0MeUI6LRHsQK7ZDyKUF5wk2xANoosntTEGTBQ7EZKEaWtX/xou0ky8uLzUIF
	l8+31OI/O/gqoPOXk0yI5kyft5o7BCzJMasbyEftCJ79onTtt+WNXVJk0IpYzay4i5QVu6DV9Hg
	NSJ8kG8LV7qRQ44cGTi48d6aRtlMXbD0nY3QkBq8J8lunbkeZp+B7Emt2PkcDcQwOyAfqYrgUXw
	0OrcUAVsPcTdup5LO6SAO9VzqZDIN5Q+u82X1dcGUmyUGtHsw7qgK+i69pNLkHhqBLPsP7QM8VD
	Jsc04T4DNMbeU5LYdPNB3NHI68N4j9Iz+6noAv1xFqwV6m/6JXCs/UbAvqiSqSYjSBZPn8Ho2BL
	9zrde5ktrQtgldEiUQiU0p6AU=
X-Received: by 2002:ac2:51d1:0:b0:5b0:bc3:dc05 with SMTP id 2adb3069b0e04-5b02369c7cdmr2818323e87.40.1784039424734;
        Tue, 14 Jul 2026 07:30:24 -0700 (PDT)
Received: from localhost ([140.209.217.211])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5b01ca4a2e9sm3573711e87.1.2026.07.14.07.30.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2026 07:30:23 -0700 (PDT)
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
Subject: [PATCH rdma-next v2 13/14] RDMA/rxe: Implement disassociate_ucontext callback
Date: Tue, 14 Jul 2026 16:29:26 +0200
Message-ID: <20260714142927.1298897-14-jiri@resnulli.us>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-17795-lists,cgroups=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,resnulli-us.20251104.gappssmtp.com:dkim,nvidia.com:email,resnulli.us:from_mime,resnulli.us:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 18B8D755E02

From: Jiri Pirko <jiri@nvidia.com>

Implement an empty disassociate_ucontext() callback so the RDMA core
can move rxe devices between net namespaces. The core requires this
callback to reset user contexts without waiting for userspace.

rxe needs no teardown here: its user-mapped queues live in
reference-counted vmalloc memory (see rxe_mmap.c) that stays valid
while userspace holds the mappings.

Signed-off-by: Jiri Pirko <jiri@nvidia.com>
---
 drivers/infiniband/sw/rxe/rxe_verbs.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/infiniband/sw/rxe/rxe_verbs.c b/drivers/infiniband/sw/rxe/rxe_verbs.c
index 1ec130fee8ea..6eb10d2f0653 100644
--- a/drivers/infiniband/sw/rxe/rxe_verbs.c
+++ b/drivers/infiniband/sw/rxe/rxe_verbs.c
@@ -240,6 +240,10 @@ static void rxe_dealloc_ucontext(struct ib_ucontext *ibuc)
 		rxe_err_uc(uc, "cleanup failed, err = %d\n", err);
 }
 
+static void rxe_disassociate_ucontext(struct ib_ucontext *ibuc)
+{
+}
+
 /* pd */
 static int rxe_alloc_pd(struct ib_pd *ibpd, struct ib_udata *udata)
 {
@@ -1478,6 +1482,7 @@ static const struct ib_device_ops rxe_dev_ops = {
 	.destroy_srq = rxe_destroy_srq,
 	.detach_mcast = rxe_detach_mcast,
 	.device_group = &rxe_attr_group,
+	.disassociate_ucontext = rxe_disassociate_ucontext,
 	.enable_driver = rxe_enable_driver,
 	.get_dma_mr = rxe_get_dma_mr,
 	.get_hw_stats = rxe_ib_get_hw_stats,
-- 
2.54.0


