Return-Path: <cgroups+bounces-12359-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BAAECBE6AD
	for <lists+cgroups@lfdr.de>; Mon, 15 Dec 2025 15:54:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 78B823000B1A
	for <lists+cgroups@lfdr.de>; Mon, 15 Dec 2025 14:54:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17D8B308F28;
	Mon, 15 Dec 2025 14:54:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XJWdGkt7"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EEBB2C0F6E
	for <cgroups@vger.kernel.org>; Mon, 15 Dec 2025 14:54:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765810468; cv=none; b=iWWht9DXrL8MIW8Q1wzoPwJsnkecW0aeCiPCjIHQLGNa3h+eyAJTeJ3GDzGydcYbddbeVsRzRR64gYSILq49Lq4Emzc/Tn/XCTN6y5JGp29w9ioCPAHzOKhDiyfrKt93nMwY5KjjBBfvMioM0kmgEMp/vBm6bHAgVF/0U3B5qNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765810468; c=relaxed/simple;
	bh=MoG4M+eQZLvDl4DSZ2MDVZrFVLWD6KmmSZDm95qZAx0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MXuoQPoXJqvnkt5u8JK0X/CHWapivyHTaGVc2CkzrmH5lEGvb4u3FoC+MrkcAGCdlMogV5PdBc8b1DjFwTmclckPaC62PO9apX+LA8A6m5PZdC+U/vcg5+OyoebkdZv/HoagaX1EBIjSBPzgoYvkxFZwLigBKg9uBt6NWFD2YRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XJWdGkt7; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-343ea89896eso3620838a91.2
        for <cgroups@vger.kernel.org>; Mon, 15 Dec 2025 06:54:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765810467; x=1766415267; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=S3roWa5MIiHY+542QEKCeiaGQ6v+8CYrzauDwIOyQfU=;
        b=XJWdGkt7R3tSStPyRNjFLC19McYG+yC/fjMfeUmaydzZJxmkquOIZlz9pgbHOHx93b
         8SfuORdKexJGlkrOuiB5aneCk6d3WWsXv3BuFS3uZ/PMabyEpADk3KqnPPOeOjOfFkGh
         IqIM73DpqpiJxwIkR6vu3VBpzPPgfh2UtOzmDe3EVfUHNAqq2S6W5khmPs4VK31N57YB
         9r+mIdaiH6XVaRJT6+h0JInuA6bBCLQrLJ8PUnb4qqdhoBXvCJIew31l4FtZ0ATYYwjK
         9YXD7EaeSAoPwymnIbo2UcIft8CLVUwHKj6ho/m8EroAqvbfSU7opuMIIRJD9/AfRRxV
         e3Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765810467; x=1766415267;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S3roWa5MIiHY+542QEKCeiaGQ6v+8CYrzauDwIOyQfU=;
        b=gNlrTSM+8FyS0ErsG+z0lNiuC0iQmQ5Y4Xlo81l+se6dZzHf3MYQbmdqwOWlABy7y9
         tYBHgvFhHDRHMdh9HCIDVw97HfQv8Cl9F5N0fCuHsexRZpPohnY/3tb7D6p2ei6sGFlM
         7PWAXF4RK79d75u0xPD4Ntsu8p1hyojLIg+rV71hmbg8+oXsyiFlVY+KjaswhqDbVuTL
         E706cNHGZTlJk0jP4u0AV3pHT832iNd3QTcbSTiL7ee407DKVr+Z3odEweBvFfW/ftjA
         o/lJZcRtXFNVDzoVCphqy5w3+awi2cxCEh7AfTQG5FoAbrqo89s+S06H05nKmcqYrrnM
         2AJw==
X-Forwarded-Encrypted: i=1; AJvYcCWi+U/hoUv6S0UsJM6mVm6EO1Tcfo/vLJxlqSLsR00GWbHqQwaEgjS8Oc/tykw7YZ5KVN09EAuK@vger.kernel.org
X-Gm-Message-State: AOJu0YwozjTsd2VzMTaVWG9x9cJDUcM2pLtKqARKQyclA0dElQE96wdM
	fGZvOU2BBx9kklMs88UJk+heYFC6KiLviLfrFBdK2JxiBOD85W2hzxVCqBCV2bzC6wQ=
X-Gm-Gg: AY/fxX7QyS/PzcisjMvh9IPsLFDLop0YHsLwAaaFJpFGBOuy4MIoqguh0zw1twrveQe
	M8xlT4JxV74Dj/XXOpcz6khWhaYzaLoyXMDJTHAcwZTDwxTY6KkmT3rdpTsdcjgrEWYMYYdkNS+
	0mUcS/eKHV6in8ybP661UxA4aAGFpFaspR0aqP/cEt37O6GxspOmVYmhAKckpUv69IfK1lfHTav
	W2qYS6VNNqUPG1H3lFLX1aOZZsC4h++5Mh/B96pBSTGA/5DsbQ5aEpy8ZB0/WTuA4blICkHUOeJ
	6zhtH9EsoMA1oBAlqYUiHrPMw5fwdA7Zdjbr8kaupXled7kCz+M3u9YXuyl2FwWiz6qqOS7uQOF
	Gv3aFDhlyx7ZePiPV0fYFzIIa+2deZa2cJDZbNKRY4H0ntTKGgFl3Xb31HnnNBPB18OIJamb3eF
	ZteoFeKGUEKw==
X-Google-Smtp-Source: AGHT+IG4GmC2JCSdgqBSfS3P0q9Pr3chOIKBF667RgIXXqBS4dAzymKUM3pzhVWLtqecRCwmu+IP3Q==
X-Received: by 2002:a17:90a:d407:b0:343:c3d1:8b9b with SMTP id 98e67ed59e1d1-34abd768603mr9052686a91.19.1765810466731;
        Mon, 15 Dec 2025 06:54:26 -0800 (PST)
Received: from ubuntu.. ([49.207.232.133])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-34abe41237csm9396651a91.17.2025.12.15.06.54.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Dec 2025 06:54:26 -0800 (PST)
From: Dipendra Khadka <kdipendra88@gmail.com>
To: akpm@linux-foundation.org
Cc: hannes@cmpxchg.org,
	mhocko@kernel.org,
	roman.gushchin@linux.dev,
	shakeel.butt@linux.dev,
	muchun.song@linux.dev,
	cgroups@vger.kernel.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] mm/memcg: reorder retry checks for clarity in try_charge_memcg
Date: Mon, 15 Dec 2025 14:54:19 +0000
Message-ID: <20251215145419.3097-1-kdipendra88@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In try_charge_memcg(), reorder the retry logic checks to follow the
early-exit pattern by testing for dying task before decrementing the
retry counter:

Before:
    if (nr_retries--)
        goto retry;
    
    if (passed_oom && task_is_dying())
        goto nomem;

After:
    if (passed_oom && task_is_dying())
        goto nomem;
    
    if (nr_retries--)
        goto retry;

This makes the control flow more obvious: check exit conditions first,
then decide whether to retry. When current task is dying (e.g., has
received SIGKILL or is exiting), we should exit immediately rather than
consuming a retry count first.

No functional change for the common case where task is not dying.

Signed-off-by: Dipendra Khadka <kdipendra88@gmail.com>
---
 mm/memcontrol.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index be810c1fbfc3..7c9145538683 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -2412,16 +2412,16 @@ static int try_charge_memcg(struct mem_cgroup *memcg, gfp_t gfp_mask,
 	if (nr_reclaimed && nr_pages <= (1 << PAGE_ALLOC_COSTLY_ORDER))
 		goto retry;

+	/* Avoid endless loop for tasks bypassed by the oom killer */
+	if (passed_oom && task_is_dying())
+		goto nomem;
+
 	if (nr_retries--)
 		goto retry;
 
 	if (gfp_mask & __GFP_RETRY_MAYFAIL)
 		goto nomem;
 
-	/* Avoid endless loop for tasks bypassed by the oom killer */
-	if (passed_oom && task_is_dying())
-		goto nomem;
-
 	/*
 	 * keep retrying as long as the memcg oom killer is able to make
 	 * a forward progress or bypass the charge if the oom killer
-- 
2.43.0


