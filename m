Return-Path: <cgroups+bounces-13258-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id EAC95D27983
	for <lists+cgroups@lfdr.de>; Thu, 15 Jan 2026 19:34:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 51C99323B83A
	for <lists+cgroups@lfdr.de>; Thu, 15 Jan 2026 18:15:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A8353C00A2;
	Thu, 15 Jan 2026 18:12:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KQPEU50m"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16A333C0094
	for <cgroups@vger.kernel.org>; Thu, 15 Jan 2026 18:12:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768500757; cv=none; b=Gwj35feRIrHbzjUVX2mmMTv81YmSybSYbw2MjKS3r/Ux8p6BRQI3z5zTKN3xaNZYrl1AcnZe6S0NAJky0BsLpWLHW1ZQKPGY91U+blIb3SNZxoYP7eL2+JGkRD1ljFTjnyZNWfj6cvA+JavmOtm3C0EH4vupq0DbCMUfTCjoefY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768500757; c=relaxed/simple;
	bh=jmCS3Eb/Caa2A/NEtHVTaZDmAlTTPtXeXUmluff264E=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=tdMKCbnq1ye3gQiyc9yrW6evWu2qRahxdDhHED1MzSw8/d95xsPwCvpUMy1mxMbDpSSkolye9izTbgmvl4eNsrmRzhIHJRiExruSJDq27aBrI2YGQg6C6vMSyUfAgBdf8Qz1tCb/DHe4A9nmR30m2+gj3s4j/p/qdubnjhbVBXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KQPEU50m; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-81db1530173so597767b3a.1
        for <cgroups@vger.kernel.org>; Thu, 15 Jan 2026 10:12:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768500755; x=1769105555; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=zUtEq9E7qiL8dJjHmHDx5LMsOLb73VrWL6F69DedpRQ=;
        b=KQPEU50mi4uMtaIJV92WmC3+5pfTiVl09B8QO7SBAkEjwvfQtVK2Puuj0ELLImtLz5
         EBBkSxYdr01zQcPRdaUxoUJnRLsPBfHQu5jAQInt+oWRRIWzJ0sQkL4rQUTNU8bMOtG6
         /wr7ro3lu5huBYbtOJKQwyrSCNFcSwcZdTzDj1eF8nVhDIYXSXGolhB4XIQRV6zWJJIy
         W5dmhCiKT1ZALGQmXmnd5ubiH/xcwMCWXMUt2VlXu0M++OEGuIv5gG53oKZaq1o8PPg4
         /48FJNguAcGciTw0ArKkHZT3r/uVecQYGvbnbZuRjSqTa8afhAidNkgY8XBcqDELSmjh
         xhiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768500755; x=1769105555;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zUtEq9E7qiL8dJjHmHDx5LMsOLb73VrWL6F69DedpRQ=;
        b=KHGMYs06kJxMI2dFImoUgQJpNf3COgIT8qd2bSC/5ng4vZrnzumZ+bvGFtQ6Ioxibp
         8GGCAU9E5X1w9ZPvi5aRjEiXXkysHLaibwA5Fe6GFbkHDI/06ct/UPmH+Oxpwh07Rl+y
         KAdZGrUp+IrA2ByfkrSq9CppBDP2pJyP5/fqK3KscAKff63b+gS7+PCYdxO41hZ9/4ky
         Btld45eefDR40Rq2mmbUFAvepTqpsbbFUEkH/IPuWIELvp0rkQFHu6UGvSBPeX41x/qU
         QvmxF6NjO2qbXx+4KYReeTLikNJciWHBa9+XYaPj6fbF88hafxMd5fAQ1PpMxIe4i44t
         afug==
X-Gm-Message-State: AOJu0YzzOwtT2x3whVd1qEscu8HZWD/8ZFXGlDUJr6epnNslo4pNqqtD
	2/WCIYXOc6c/91N4yK2KZYQquc0UNzndDrruPxeCIxoM3AInBqBQJOdZ
X-Gm-Gg: AY/fxX7OVM8Q4TwFfPNPLog1ESZHjTLm/7xHZwfA2nPw41/IJgb5JcEy3EJHijk30bK
	33uGW48ge9u/dEcs1MoaTNveIWYY+zasmShzJwN/d2eSrtWZJNRlwIke0zjBlM3JjZuLQ2eUvOK
	Ota4+L0yYIpcF3tUmI6sfZ+yEPaGCJeZQg4Ash4Dq50qwkAUhoH7HlhEFDqSyWBbwqp+Ak9VpKX
	tJGldQeCSTT/Q1mRN+mufUaMWxjeUPX7c4o3rtJMzGz3Toomuu37Zzp01lVGkj6IthDUZVfgsrf
	et6tb8pN6Bs9y9w3LwNgeqPm3jdzLwchu/GmSWqFx9ahB3Eqm5PTxVz1lvQ6eR2P44NF9g+MM8j
	s7uJcAAx8Ie/bVyloDZgjBu/rOUjxo24ZYjMb2rJ6k0NOpuboMuonWRg+nzgyoxHxsVyD8P6uED
	NJhB1j85EbVTcu+13jbZA=
X-Received: by 2002:a05:6a00:f8f:b0:81f:47ad:6a7b with SMTP id d2e1a72fcca58-81fa01eb473mr401131b3a.33.1768500755228;
        Thu, 15 Jan 2026 10:12:35 -0800 (PST)
Received: from [172.16.80.107] ([210.228.119.9])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-81fa1094e23sm61988b3a.4.2026.01.15.10.12.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jan 2026 10:12:34 -0800 (PST)
From: Ryota Sakamoto <sakamo.ryota@gmail.com>
Date: Fri, 16 Jan 2026 03:12:14 +0900
Subject: [PATCH] cgroup/rstat: fix missing prototype warning for
 bpf_rstat_flush()
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260116-fix-bpf_rstat_flush-v1-1-b068c230fdff@gmail.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/x2MQQqAIBAAvxJ7TmiFLPpKRGituRAVbkUQ/j3pO
 DAzLwhFJoGueCHSzcL7lgHLAqZgt4UUz5lBV9pUiEZ5fpQ7/BjltOfo10uCMmZC29Stdhohl0e
 krP3XfkjpA38DRv5lAAAA
X-Change-ID: 20260116-fix-bpf_rstat_flush-66c1a7582b21
To: Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>, 
 =?utf-8?q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>
Cc: cgroups@vger.kernel.org, linux-kernel@vger.kernel.org, 
 bpf@vger.kernel.org, Ryota Sakamoto <sakamo.ryota@gmail.com>
X-Mailer: b4 0.14.2

Add the prototype to cgroup-internal.h to resolve the Sparse warning.

The function bpf_rstat_flush() is defined as __weak and global in
kernel/cgroup/rstat.c, but lack of prototype in header file causes warning
with Sparse (C=1):

  kernel/cgroup/rstat.c:342:22: warning: symbol 'bpf_rstat_flush' was not declared. Should it be static?

Signed-off-by: Ryota Sakamoto <sakamo.ryota@gmail.com>
---
 kernel/cgroup/cgroup-internal.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/cgroup/cgroup-internal.h b/kernel/cgroup/cgroup-internal.h
index 22051b4f1ccbc0812641e4716b7a5b5f7138bbc9..ecb2b3a2f06ffcc3d747adf666a6134cc54059e1 100644
--- a/kernel/cgroup/cgroup-internal.h
+++ b/kernel/cgroup/cgroup-internal.h
@@ -277,6 +277,7 @@ int css_rstat_init(struct cgroup_subsys_state *css);
 void css_rstat_exit(struct cgroup_subsys_state *css);
 int ss_rstat_init(struct cgroup_subsys *ss);
 void cgroup_base_stat_cputime_show(struct seq_file *seq);
+void bpf_rstat_flush(struct cgroup *cgrp, struct cgroup *parent, int cpu);
 
 /*
  * namespace.c

---
base-commit: 944aacb68baf7624ab8d277d0ebf07f025ca137c
change-id: 20260116-fix-bpf_rstat_flush-66c1a7582b21

Best regards,
-- 
Ryota Sakamoto <sakamo.ryota@gmail.com>


