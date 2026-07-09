Return-Path: <cgroups+bounces-17613-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id fqMfCjJyT2qPgwIAu9opvQ
	(envelope-from <cgroups+bounces-17613-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Thu, 09 Jul 2026 12:04:34 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A5D472F510
	for <lists+cgroups@lfdr.de>; Thu, 09 Jul 2026 12:04:33 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=resnulli-us.20251104.gappssmtp.com header.s=20251104 header.b=LD3Fad6o;
	dmarc=none;
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-17613-lists+cgroups=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="cgroups+bounces-17613-lists+cgroups=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 493273129C25
	for <lists+cgroups@lfdr.de>; Thu,  9 Jul 2026 09:56:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1EBC4048BD;
	Thu,  9 Jul 2026 09:56:12 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FF6D402BB6
	for <cgroups@vger.kernel.org>; Thu,  9 Jul 2026 09:56:10 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783590972; cv=none; b=s5hNnqJ5UWuhXomhaRmYP5sasJH4TXq8+rsnhnBq6G7mZMj/pK1O3D2SCIHIbVBcHhxZaWimRaaJEF0lafD8Gv3XMHglkkQ8I2HOdvSqCtr05/jdmDcH/J5xibP7ABbs5ormqO6nJKVeSGdE/pNl2bhe4FEQzA5GNRu1b/CWdec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783590972; c=relaxed/simple;
	bh=2JgBpAWc31ZSpkYiSaZDvjmnHKEA4A5V63g6j0fsopU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KAsLMThz71Ez8Vx3qiX6u8GZ7+2i/GVuH5PUJVvPS0EkgFIMOL3icbyaoupLTqbVCz1VYAyFKUfnXMMnLmlgSjYAkzaxmrTeEuY9aqNQ0rpCZcVL5txe9Mx/DhbvoXEFEF/WWWVo8dyz/U4eL+sBtS5aS5tyL15GHKfG833kEHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20251104.gappssmtp.com header.i=@resnulli-us.20251104.gappssmtp.com header.b=LD3Fad6o; arc=none smtp.client-ip=209.85.128.49
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-493ec555a26so3522595e9.0
        for <cgroups@vger.kernel.org>; Thu, 09 Jul 2026 02:56:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20251104.gappssmtp.com; s=20251104; t=1783590969; x=1784195769; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=jsn8I3x6C8T9FLWqok7MXQBFznxd0+GMkoGzBjmbnHQ=;
        b=LD3Fad6oh39v8c+zQa82JZBsYIfQEkOKAD7U54Yp6LpXoRZa3be0fua16CIXdNP137
         YKaKavVDpq5LxPMx//tGV6b8NpL894RgbRTMI/6VpCD1i2O445qTMygiCTf7U9ZlavNn
         K0Sc9CbY0APGtGIX73E0JN+JhwSXXbn/MwnG8p7s1jYO/NTY0lZDM7KPboGJEDIh61jC
         VVZxcm4LuB+efPQi73Qh2Sxua1dF48A6MAx/O6LQKJapBUZSS/jlXxGt85IHLKpDRR8B
         QJ1p0ygWV9LL0XU+WGRMJ+3r5hfo57BvXwtInPv3TTblS0Wde7efcijJfdQkc1YjECk4
         hdIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783590969; x=1784195769;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=jsn8I3x6C8T9FLWqok7MXQBFznxd0+GMkoGzBjmbnHQ=;
        b=B87Ihh5p3SVw6giiCLOtHWSisLlsH9M/nrkfdwY9+oB7Ltgzy2wC5EWt63zj+r+60A
         PlBcXq5C9VuNiW3R4A+lYZIDw4FxTsheK3wJayLx3RmiT1GEAjmaPCuoF4lPc2Cn3GnG
         3H6/q4LGVDMmFvIbUu2HNQbFAS7I+hT/6qq+fdpYhsYbKG5w/t8IwPNi2OKbbnKdQGM2
         ZUU8yMT56GBg+mZ2kMX8NW92sqeiPZPZlrcka8vSqs4o3arzsc5i97jPw5r8bo/bbWkK
         6907zbOB8lBzbO1WOV2uEgQB/kY+CArzcULJslabuJOtxRvjuQuc1QwkqlmyBngfjiDN
         pVVw==
X-Gm-Message-State: AOJu0YyuWkxgr3+Uu/lEzxEWjESQtoB2Hxd/9bDfhIk7yh+xwEctxqTE
	gviScM3LOQKRCT0Zwa3fL+LE6D2fJku33e3NrHcaaa3EVOO/BIv2bfYKMzLdf8asLwU=
X-Gm-Gg: AfdE7cnsfCbW/V599mH+N/ojfW5MIQHbXUyC/oB/nNm43fPOSAY/NY6bGnNvkF68nTJ
	K/Z1VgvJ+mVSj7Y/PvbLxCeLTSufrr/QQZPSo3MN5B6RbjcBUtD8tw3gn9YPwBx2zE2OI+WsGA9
	I02pE80QCXfiqsMAirrgTFRnwepnSbI9WOuku2ZG/jUC/Gb2i9dn1td0u5pHtOtBZefV/pkehi+
	Itzqdz6NN+38eGajVgXoLvP8rajZueZ1/Egp5/amPWqglwy2r89LGqSlZ2C2OlkVdHx7wvDHbFv
	ndQqO6f/i9XVtCHW3lnmVUNWiGWIVEu/VUMW71kwE+nGfHBzrdLdr/YkAIErGfg910nAw/LrAf5
	ZbX1bV3WZiBb1ajH57CSksofIwQEBV4DmO4BjGqEUZOHUE0jj/kpR+pR4Mfx3j+ZWVFi2CVgtko
	9Yb7uJGIjRLGW60Z8Qz23Wtk4QHnwmxMX+
X-Received: by 2002:a05:600c:c4ab:b0:493:e4b2:5290 with SMTP id 5b1f17b1804b1-493e689c26amr56899785e9.12.1783590968959;
        Thu, 09 Jul 2026 02:56:08 -0700 (PDT)
Received: from localhost ([140.209.217.211])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493e5a5d174sm148972975e9.2.2026.07.09.02.56.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jul 2026 02:56:08 -0700 (PDT)
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
Subject: [PATCH rdma-next 10/13] RDMA/core: Document the SELinux ibendport net namespace limitation
Date: Thu,  9 Jul 2026 11:55:29 +0200
Message-ID: <20260709095532.855647-11-jiri@resnulli.us>
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
	TAGGED_FROM(0.00)[bounces-17613-lists,cgroups=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[resnulli-us.20251104.gappssmtp.com:dkim,nvidia.com:email,resnulli.us:mid,resnulli.us:from_mime,vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 8A5D472F510

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


