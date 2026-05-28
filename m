Return-Path: <cgroups+bounces-16380-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id dJ/bGqHEF2qiQAgAu9opvQ
	(envelope-from <cgroups+bounces-16380-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Thu, 28 May 2026 06:29:21 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id D2C2C5EC802
	for <lists+cgroups@lfdr.de>; Thu, 28 May 2026 06:29:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6B0EC3043390
	for <lists+cgroups@lfdr.de>; Thu, 28 May 2026 04:29:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 872E82F8E88;
	Thu, 28 May 2026 04:29:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mMaCQqUD"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 165F72C3259
	for <cgroups@vger.kernel.org>; Thu, 28 May 2026 04:29:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779942556; cv=none; b=LoGmVi6VMesBRtxS/ufmpKfRG6A6CIgoMtTWiWdy5kpIoGH4bchV+zUZmgfBGifkksPhAlgJpJcMX7f/9v0dgMYeMtCNgx2BSMgLabnOaz+cxX9je0ElGEah3/7pdhImRdlVpgEqITtKk+tjFYAoMaiKlQFkATQbIih0JvTO0UE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779942556; c=relaxed/simple;
	bh=cY2a5W/nIKwHBly6hYcs7h3YMk2FJ4n2UXhDqpuNXGk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Ps3J/aIIC1h63a6yzcb8YU2APPunvvOZ68HW6kXtlWoD8s4frIbRzaTrAHkKVDhGOj/4juWndqouzNnxm1H/Z5/I2pPTh1X61A+P9snKAQR2rhAFoyUXFX+uc/PuZyTKKdnPFXmo/NFlCqcV80EpxW2yNN+dMTdz6Cl1IB7GBNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mMaCQqUD; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-824c9da9928so6054446b3a.3
        for <cgroups@vger.kernel.org>; Wed, 27 May 2026 21:29:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779942554; x=1780547354; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=EhiW+uhYb7yOkQVsq9tZ39UUfuEazA56TlzvJ4Ekon0=;
        b=mMaCQqUDV+0qLDvKG0FrJ8s77aiCs9DXhJU2ZHcab/TURPoLWNkXriCYNlgKa0oOCK
         fetzswzOXKVy6cA9fJzryrDZFLIJvMALDwGVRgkZW4qS2SN5OYyC6EVHMufzaeqo0Buk
         IPXIWN1gbUO2+FunQV80Gn9MSRETs+jnwlznpMyaRaDGEg3iwGAkgskgeTVNABHgXfcx
         oTQO0HCyndJPB0dkeqQpKR4qnGhFBLsxhFi5ZhIiehi5rHG2FEsFYgDqHjh+yKHR+3uH
         lTLHj1FNN02yPPg62NVmqbtt1s1hNkN6GYbVj0EXaJjFqdbfKx2V5lj0q5Dcd7klz/FI
         ICMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779942554; x=1780547354;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EhiW+uhYb7yOkQVsq9tZ39UUfuEazA56TlzvJ4Ekon0=;
        b=AAGIvC5N2xHqQWoy+dG97u1o41zblTSmXSk+N0xa6L00guH3Yj8Oc7krbh7hNncDqH
         E+NcFMne0eeqp2RnJ5LqjK+0L9reXXE9v+N8aBiI1Ui7M4t5F0bedWpDoFV0H3JUvlGt
         rcqC9/UVgjnasxzfJEdXZv3ooMmjg8h4fBywm3lIDdA9xPdDvIf0eOxu6Ivd+WoM5aay
         k7xv/yfEDHnoZ1BjKPdJDyNvWre6rZlH20AW1gyfhJNx9FI8m2fKjOkzZeGQGMha+eO5
         6qNYWGIQXZF88WxGcY0GnPpQQsCyvBMfO43QBkWMGF9XEyyIYIbt28gobBB70eWzCav8
         k3yQ==
X-Gm-Message-State: AOJu0Yx0QbJxb+UN5Fckw4eQPMJriL+3CXNgBR3w0ecMn5oFWq51NbdV
	uS6eqaaDqq5Maqf0Y0txXAJT0zfPUQqZpZ4D+Vy8sh6xS3gxpw1TFJV3
X-Gm-Gg: Acq92OFGMhU/9jHOlBeHJ+uQ0FUDJxb7aiSg0l8mFeloEZX1OOW4AW0CKS1kwSla77I
	6K0yojNfo+Jzk7Rb3g+2uvKyXpB9EbOR8eO/m7IG5FdeFiNnNbluYW4wdrzRYd82kXnNGMBNTbd
	hE679ePjbeU9VLFzj6fueDE0EtG6SxyBwr685uD8tcCSAir6xM68dmXYWsKd4w5BahtXTNA1zl0
	1YtZSKZYLUKyEMX1Fxwr1gsVNBwIlw3gylBpGjeX1EZDMf525aavToEyvTY2Y3q4xBdzvhZ7dLx
	uPPCkmQCjF6yFWq+DKw3EqtiE3CHEcyQeC2v7ppzQDA62nzzsXOcjX3x2cRY8g8tDDRJchJyYfA
	alR8kRTHnK+8CIdRBRv5n/8IM1EP2oihV2QQfI+O8xjvi04OsRCT7gs5g8OxsdANlXcS1eI2vPN
	F0bLaoii+jd5ODmwdcj8ksHABG1OS/uxNOjd9a9VPUN0vjS9xY2g==
X-Received: by 2002:a05:6a00:140e:b0:83a:4846:90b0 with SMTP id d2e1a72fcca58-8415f3c6635mr25622392b3a.46.1779942554488;
        Wed, 27 May 2026 21:29:14 -0700 (PDT)
Received: from elysia090-Inspiron-7790-AIO ([2400:2411:d120:da00:480:dca6:feb8:54eb])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-841d6eb3aa5sm3808022b3a.22.2026.05.27.21.29.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 May 2026 21:29:14 -0700 (PDT)
From: Ren Tamura <ren.tamura.oss@gmail.com>
To: tj@kernel.org,
	hannes@cmpxchg.org,
	mkoutny@suse.com
Cc: cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Ren Tamura <ren.tamura.oss@gmail.com>
Subject: [PATCH] cgroup: pair max limit READ_ONCE() with WRITE_ONCE()
Date: Thu, 28 May 2026 13:28:39 +0900
Message-ID: <20260528042839.28472-1-ren.tamura.oss@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-16380-lists,cgroups=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rentamuraoss@gmail.com,cgroups@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: D2C2C5EC802
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

cgroup.max.descendants and cgroup.max.depth are shown through seq_file.
Their show callbacks read cgrp->max_descendants and cgrp->max_depth with
READ_ONCE(), respectively.

The corresponding write callbacks update the same scalar fields while
holding the cgroup lock, but the seq_file show path does not serialize
against those stores. This leaves the lockless show-side loads annotated
with READ_ONCE(), while the corresponding stores remain plain stores.

Use WRITE_ONCE() for the updates so the intended lockless access is marked
consistently on both sides. This does not change locking, ordering, or
user-visible semantics.

Assisted-by: OpenAI-Codex:gpt-5.5
Signed-off-by: Ren Tamura <ren.tamura.oss@gmail.com>
---
 kernel/cgroup/cgroup.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
index 6152add0c..daddfc2b9 100644
--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -3726,7 +3726,7 @@ static ssize_t cgroup_max_descendants_write(struct kernfs_open_file *of,
 	if (!cgrp)
 		return -ENOENT;
 
-	cgrp->max_descendants = descendants;
+	WRITE_ONCE(cgrp->max_descendants, descendants);
 
 	cgroup_kn_unlock(of->kn);
 
@@ -3769,7 +3769,7 @@ static ssize_t cgroup_max_depth_write(struct kernfs_open_file *of,
 	if (!cgrp)
 		return -ENOENT;
 
-	cgrp->max_depth = depth;
+	WRITE_ONCE(cgrp->max_depth, depth);
 
 	cgroup_kn_unlock(of->kn);
 

base-commit: eb3f4b7426cfd2b79d65b7d37155480b32259a11
-- 
2.53.0


