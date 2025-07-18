Return-Path: <cgroups+bounces-8766-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A5A8B0A3A4
	for <lists+cgroups@lfdr.de>; Fri, 18 Jul 2025 13:56:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D3572A853C5
	for <lists+cgroups@lfdr.de>; Fri, 18 Jul 2025 11:54:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5711E2D94AD;
	Fri, 18 Jul 2025 11:54:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VeiVE1Tq"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9DC72C08D4;
	Fri, 18 Jul 2025 11:54:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752839666; cv=none; b=Z5RURl+dmCrEyOyILZb4gYax8PXuUxV9FZVF9iJCNOpnzyW6beJ8kTLYCaOWQmPDnGfbcySQ994BGyNnouJb4+sOKXfzqqUtueWeQfJ3RYIF4voC1hIqLauOoZP5iweLGpItbAVLXZ9Xwur6MATBPDNeOtZJyePqNT5plwqrBtM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752839666; c=relaxed/simple;
	bh=UN0O+pIQg6Glg8Oua8IzJCVXQa4h97piXys6CU6sOBE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KlAwy5gBDefdSli2wrxfxlx5q5KRsnx0evBkv0Axuwk0v0WO/uVqo4EdVLr5/TkeIEENYXgAPwWU04jOOhKPiP8MmKmsOzvVQcmHXeTJjDGZcoEa+dX2VKm8PYqaYzEDSeBhKvd3jkcdqdAuCNvqgu7TLTIlIlxu+R4h9d8wzSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VeiVE1Tq; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-311da0bef4aso2114806a91.3;
        Fri, 18 Jul 2025 04:54:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752839664; x=1753444464; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=FUjZ1QjCwxsShFOjEqW/dcUlvmZBvKECdHobMCf4NrQ=;
        b=VeiVE1TqJPlKHcVbS7p/dYtvUChHsS5taYjKtf5nR5LY7DdfRkD/OU6cbZA56ciU8k
         602nL9gV/ASBrKGWmLbhSZgQChZwpZHJNIJmL16uIuM9aSzNymQ4B2FWK8zHQIfkayjO
         x2HUKLHuLB3GUibToUTgv/ge22IuOda+79x9URzj4WXOAVZZfGjX3FFHLWSBLsKWI3h6
         WvGvZlfJcwQLu/Lu+tt/0yhfMRuG+ipK0y5H50kBcPpOFLUnqPv0e96aMrw5Hk67KVQh
         P/rOOEVas39SF2wf8ZkZ9CSRJbTvkRiZfWuKsgJgtnVJ9bm7Vc2Oge8afTvZ8SRcUl5e
         A4KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752839664; x=1753444464;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FUjZ1QjCwxsShFOjEqW/dcUlvmZBvKECdHobMCf4NrQ=;
        b=GilfWKDUPhZlWaMVm2De7w3X7KNJf/Tm5j0gdUUR1H4NfN+pWplScgllEcHKq6JyY7
         Zfnv96d4+zLVLAMpiUrWa7mK/397QVY2woBzg+R32RrCT9TiY+MD9iPmmxuWUxgwNeHg
         VzC4QKsTPKW0WZfzKtpar81aTU96FpC/JHJ5Au6CiPeex5642/rW+NENF5FKrl9qHtJq
         nnXhbmpwTWJ7e2Ypihjg31rv96P3UZ+2XLB+5iN2TGw7kpX/3rANKpHDRrJGDK+LkB0L
         bGwKxLBycb4V0cv0Hsk6cab5IFB1ZtnENQiJyoG9Gr5ItcZ2Erp1JhsmkFch58X1Mjpa
         objw==
X-Forwarded-Encrypted: i=1; AJvYcCXJig8Ckihvzk9ZII6BkVtWgl43TiCJRWhKLtIa4+geDyXm6dqThM+dsWfQAwaaSLe6UMJDD/bMbn5CAH0=@vger.kernel.org
X-Gm-Message-State: AOJu0YydJcztRV6nRpF5R1g5oOl0eq3dTDzfZLy2InnRxk6Y6wRx/rwp
	goY2af5ecHXRrtHsGYM6QF/ZG0A5qe+7yXMHsD6vkuFYDGXeexR+haab
X-Gm-Gg: ASbGnctWih154lOsLYnQTI8u0bQosj9jUEVyci2/caZQ4lxfBdVrHxbPrOQfzgQVVrL
	0oEphYTRBSKAPOSDN8dIfW00RIcNdMBOCIL/N790Nt/bKqxg6hUVY2k/G9Yt98lY676rXsC+ZpM
	LWGDLxHkvrvZOStq+NGt7FF6KKEytC8XiJOCdDJpj/6L52uVFi1OzvBeUb5r6O2EV3QokUELjJK
	BRdhhwGbKCZer36nrfzq6wOCxLIoml3DsjBqd99emC/pp8iV3Mc9GuJ1HxCOCVixrHVZVph0LPK
	ziJobVDMw7MRm8OcS2c9CMgF9aqhjgbpEql7sNJK9g9DSXnJPEijZppjDxL9yZ3U5HhO0yAoZEU
	Csc0FlHZ3npO9zAdUjK+0BpPK+0YG7h1+UlCspALbNUFh/uRqxXXVr1Au+uA=
X-Google-Smtp-Source: AGHT+IGOdF3rwJ/FyhT1NPmrh0q9I1qR7G4EWEQsBJZmzFqdyODx/5SLyLos+cfm+vOtOuDp7IVY6w==
X-Received: by 2002:a17:90b:4fc4:b0:311:c939:c859 with SMTP id 98e67ed59e1d1-31c9f44dca6mr13660879a91.30.1752839664102;
        Fri, 18 Jul 2025 04:54:24 -0700 (PDT)
Received: from localhost.localdomain ([14.22.11.161])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-31cb603aee1sm2729890a91.30.2025.07.18.04.54.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Jul 2025 04:54:23 -0700 (PDT)
From: Zijiang Huang <huangzjsmile@gmail.com>
X-Google-Original-From: Zijiang Huang <kerayhuang@tencent.com>
To: tj@kernel.org,
	hannes@cmpxchg.org,
	mkoutny@suse.com
Cc: cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Zijiang Huang <kerayhuang@tencent.com>,
	Hao Peng <flyingpeng@tencent.com>
Subject: [PATCH 1/2] cgroup-v1: Fix missing mutex_unlock in error paths
Date: Fri, 18 Jul 2025 19:54:08 +0800
Message-ID: <20250718115409.878122-1-kerayhuang@tencent.com>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In the function, after acquiring the mutex with mutex_lock, multiple return
paths (such as returning ERR_PTR, NULL, or normal pointers)fail to call
mutex_unlock to release the lock, which could lead to deadlock risks.

Signed-off-by: Zijiang Huang <kerayhuang@tencent.com>
Reviewed-by: Hao Peng <flyingpeng@tencent.com>
---
 kernel/cgroup/cgroup-v1.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/kernel/cgroup/cgroup-v1.c b/kernel/cgroup/cgroup-v1.c
index fa24c032ed6f..73e0fd93111a 100644
--- a/kernel/cgroup/cgroup-v1.c
+++ b/kernel/cgroup/cgroup-v1.c
@@ -423,8 +423,10 @@ static void *cgroup_pidlist_start(struct seq_file *s, loff_t *pos)
 	 */
 	if (!ctx->procs1.pidlist) {
 		ret = pidlist_array_load(cgrp, type, &ctx->procs1.pidlist);
-		if (ret)
+		if (ret) {
+			mutex_unlock(&cgrp->pidlist_mutex);
 			return ERR_PTR(ret);
+		}
 	}
 	l = ctx->procs1.pidlist;
 
@@ -443,11 +445,14 @@ static void *cgroup_pidlist_start(struct seq_file *s, loff_t *pos)
 		}
 	}
 	/* If we're off the end of the array, we're done */
-	if (index >= l->length)
+	if (index >= l->length) {
+		mutex_unlock(&cgrp->pidlist_mutex);
 		return NULL;
+	}
 	/* Update the abstract position to be the actual pid that we found */
 	iter = l->list + index;
 	*pos = *iter;
+	mutex_unlock(&cgrp->pidlist_mutex);
 	return iter;
 }
 
-- 
2.43.5


