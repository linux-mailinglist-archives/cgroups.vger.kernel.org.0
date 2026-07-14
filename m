Return-Path: <cgroups+bounces-17792-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id ofR0CnlIVmpB2wAAu9opvQ
	(envelope-from <cgroups+bounces-17792-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Tue, 14 Jul 2026 16:32:25 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BE82755DC9
	for <lists+cgroups@lfdr.de>; Tue, 14 Jul 2026 16:32:24 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=resnulli-us.20251104.gappssmtp.com header.s=20251104 header.b=tIplLQKz;
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-17792-lists+cgroups=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="cgroups+bounces-17792-lists+cgroups=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 1DDDD303630C
	for <lists+cgroups@lfdr.de>; Tue, 14 Jul 2026 14:30:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C9DD4446F6;
	Tue, 14 Jul 2026 14:30:13 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4097147DF94
	for <cgroups@vger.kernel.org>; Tue, 14 Jul 2026 14:30:11 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784039413; cv=none; b=NhkgpOT0czmxEvWu7lcOM67c7i7ypgzskdylnX08ibjgWZzWitJY5a3fHSJaZG6d8FHNW2TMuJtggZwt2S5AzTMhevCjxbeAfdu0RTcFgffTaczS8Wd33CzbkbX2ruCNjkgwku0YltiT6q2U1+KIWsCUk9yoFYAQFn6hbUjSpYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784039413; c=relaxed/simple;
	bh=2JgBpAWc31ZSpkYiSaZDvjmnHKEA4A5V63g6j0fsopU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qltXtn1keSZnDH+a9eSizGZBW9oIIPcXj0xLPD5QDdrcNOxszHtvDL2RNPKJIyZaOvLC04IysD2t9c3YpZMWirL4VQvxI+9ljTNSh1fuvkGD96Sqkxmf8dzPvBxOPtlw4iXG5wF/MhdByUfMOBoGEai/q65bJSjKG+HfXk/xf+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20251104.gappssmtp.com header.i=@resnulli-us.20251104.gappssmtp.com header.b=tIplLQKz; arc=none smtp.client-ip=209.85.221.45
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-4758bd3731bso814714f8f.0
        for <cgroups@vger.kernel.org>; Tue, 14 Jul 2026 07:30:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20251104.gappssmtp.com; s=20251104; t=1784039409; x=1784644209; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=jsn8I3x6C8T9FLWqok7MXQBFznxd0+GMkoGzBjmbnHQ=;
        b=tIplLQKz7ETUgWcKFbHl0CWUrXenVkiXEyO3ng32niwGV71m/oIlqG0zutHaXUDmTn
         YXtlbK43Zle+QsSGZvahavbXjyKpupb2yhLdTwQbwyu+aE9aBLPKB3MzuH0tBTFbi0Fo
         w28wbfwUYeOoAbbs+DS1Ue++EkO7RQuVFmDxcSdN4t7lZTR1biPzQzSHco/so5vimC5y
         l0qcL1mvsChAugvRgeaMTPj6i43RpPrLaqRnILoJihFe1XIWbF0x3xz0Ge0wsW+I1E4d
         TGcE3lOQNqAJlhvSQ+hwOpokRo4GvE9inrTL/mcdyaB1TF1T59c/Ci8fOGj0LoYRID2V
         AgDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784039409; x=1784644209;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=jsn8I3x6C8T9FLWqok7MXQBFznxd0+GMkoGzBjmbnHQ=;
        b=g9X2cPloRMiqoU9CTP+G458C7FkQV+Bd/oRunqsy9kjLiFI4Mb1RKM4HpG2IveeE34
         h1yJfRZDPqy7dOYzI+Uo7EcJkby0f9EUtofwi6cSpeO5TB5YWCXc6xUw8nZJOcQ03EaU
         7AjIW8nGsiHSYdO/ZXZ+t6/3b/gxQ2ub9xNI4u8YkkimIfkQikgNSFzTott3sKb25WJn
         KNebOUToxoPYJDxmaaDBKyz/UyBj4/0L/qpzrcPiAWsZTRQo1ftHzK8VK8xvZC/7MPjf
         voiAPK87WJclLxSqYPtIB6EZYJ3teC6jW4EeidVks2bw5+2Y7I6E349c/p3YIey6isvb
         8r+g==
X-Gm-Message-State: AOJu0YzsuoPwigpRjhi/1YsZ//+Ri0jzcSed3Kf+X4zZFD1h/haRxRvP
	lUwyfWngozqAg/6nhAZXmqKWBnCC1H9uYETl7R6EICtKihgTe8ne9tvX+CUSzOXx7uw=
X-Gm-Gg: AfdE7ckrYgs8dfLgZEo9ZVKfIQyjD4y0PMhM4vpMJ43cjPDiuG+4M/0YDpcYQgskf+N
	meu4iEJmN70dkGnOgqQZRCgqk49l2vNv9cXANeN+CEjNJYYjPsy6Gc2tAHUuAEU9aot8jzCyGg7
	KuJxRFTtB2pMqJV0Tymu6OCfBCk7Wd0haDbxoTousg0MN8sn6OQjOyA1rbnO5G3oQJNxr4y/lCu
	tPwYuU60h5x6UrvxqozLXToXhzrKa2QWqlf0gidW2gpFpEvJTjbyw3TADRDbMBisfA4r3sGUvuS
	YWhOjuQX7w2cAIsYBy+vCGXlaN8i9CDUOgu/sUnOGFW14SPyDbV5+zDWSShM7uq+vzPiejG6dGF
	y0U8jH9qsXAgGnWAa4TreJfNzH5MpyCoEhV7jB4sDzLMinH3cw9SbUVZU9N6OsxL82mJWL0PXK1
	Wo4e1nXewQvtClWPLzMDMlqQ==
X-Received: by 2002:a05:6000:480b:b0:46f:1b89:999 with SMTP id ffacd0b85a97d-47ef69910b9mr23198373f8f.30.1784039409490;
        Tue, 14 Jul 2026 07:30:09 -0700 (PDT)
Received: from localhost ([140.209.217.211])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f4635082csm9292456f8f.7.2026.07.14.07.30.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2026 07:30:08 -0700 (PDT)
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
Subject: [PATCH rdma-next v2 10/14] RDMA/core: Document the SELinux ibendport net namespace limitation
Date: Tue, 14 Jul 2026 16:29:23 +0200
Message-ID: <20260714142927.1298897-11-jiri@resnulli.us>
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
	TAGGED_FROM(0.00)[bounces-17792-lists,cgroups=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,resnulli.us:from_mime,resnulli.us:mid,resnulli-us.20251104.gappssmtp.com:dkim,nvidia.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 9BE82755DC9

From: Jiri Pirko <jiri@nvidia.com>

Document that SELinux ibendport labels use a global (device name, port)
key, so same-named RDMA devices in different net namespaces share a label.

Signed-off-by: Jiri Pirko <jiri@nvidia.com>
---
 drivers/infiniband/core/security.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/infiniband/core/security.c b/drivers/infiniband/core/security.c
index 9af31d1d9d70..a82c46965416 100644
--- a/drivers/infiniband/core/security.c
+++ b/drivers/infiniband/core/security.c
@@ -700,6 +700,12 @@ int ib_mad_agent_security_setup(struct ib_mad_agent *agent,
 	if (qp_type != IB_QPT_SMI)
 		return 0;
 
+	/*
+	 * SELinux labels an endport by (device name, port) from a global
+	 * policy. If devices in different net namespaces share a name, they get
+	 * the same label; distinguishing them would need net namespace support
+	 * in the policy language and tooling.
+	 */
 	spin_lock(&mad_agent_list_lock);
 	ret = security_ib_endport_manage_subnet(agent->security,
 						dev_name(&agent->device->dev),
-- 
2.54.0


