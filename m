Return-Path: <cgroups+bounces-5364-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 92A459B89E7
	for <lists+cgroups@lfdr.de>; Fri,  1 Nov 2024 04:18:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 23DC61F24182
	for <lists+cgroups@lfdr.de>; Fri,  1 Nov 2024 03:18:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31C04144304;
	Fri,  1 Nov 2024 03:18:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g7bLsg96"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A575143C72;
	Fri,  1 Nov 2024 03:18:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730431105; cv=none; b=ZwDpBn9viWMIPcX1JI0NoqZRSPlNfOLEcIrFfB4JRwr/R55EVNo2SnruabonzRqDKU4SbCJOhMeDjBK1D1ZLQISMkx99a5UvFL9Sj0hFGxNv7hG1iwm5T+26l0JhkxxD+0u2s8TVnRWToYzymQovORbR5Kq/ewGl0oMaLrjh5IY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730431105; c=relaxed/simple;
	bh=r8YcZ0dpdXNp/7S1zdAyAeQPX/2DPYDPXuaHe/RSVM4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=fvqWX9BbPkEK8XQHa+j9q+f3KUCRPiJoXrm4c/6q/L7+gTNsU1MMCCsRzQxEw7ovGQXS4XrCK7wxQ2buyOQEoylPEp5VNKWVd28w2JNNg/ymA0XECbheFXGsqu4+HrY6kIP8V0ZlMRCSyNbSkzNekKBWYi7MDN5gTyz4guF+Wl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g7bLsg96; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-720b2d8bb8dso1225707b3a.1;
        Thu, 31 Oct 2024 20:18:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730431102; x=1731035902; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UUgCvhOKE3smcEC280xZ+zWa212yApUb0NoA+1fbR/I=;
        b=g7bLsg96DuQ+uGEPUwHuy2OpW5Xtlx3mkHll430Xwut/BFaFkYbodpvQygoq2om3GM
         NYm5oxiq11iVD9IBX3zZcInWxdCPQ2QvXEkI2W1iM1LnSBpp8gBu6yvtBrpzUnyq3zzm
         zAqlNiZDQ6O/92Ad+VOqxIdHAUP2KBdzGidN+vYszt5UTS2Wnnk5z4EWrOL7yVpAJou3
         FA6hzwAzy923fA8hh0i42qe2sL8EnOOCHtVWWeR+XalJV2TZHeZqQHwdd7U2zec1FLA5
         hwwCtnZrIzZrdLNW1rkrKxsaLDxztSGQV5YJYmLOYGgOt3NAYhZVqFBi7z+4BPNGOXIH
         qOhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730431102; x=1731035902;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UUgCvhOKE3smcEC280xZ+zWa212yApUb0NoA+1fbR/I=;
        b=SuuOSZhktBZayVLjQRQH2jz2BSjoKck2rM4Wb9FhOVJjnyC5FsLwkxplur52oSAmns
         F17nkXAefYuZLfvH88DS20U5vcPkQR094bfsDb+iSaDxTXnBEkKGtMVx5w86a2QPOZ6+
         qUtA0ipr6pT68kvAI+tnfzlYrgaE0vq6SynBIp5AKPdoWhl/zDFRFDXASSjOs6agftjB
         f3YQr83K3aOlXmrkik2z+qDwFblfPAAcuh6O7K+7uVAnkuRa8EhjP65p+ZLFIstUVqQu
         oopQnw9ghZmdHa9eGGBL0zIuY5TrlR8N8wvPMIcbi0y4IwzmXIogZPtDq5Yt7qvY99js
         yBIA==
X-Forwarded-Encrypted: i=1; AJvYcCUa4p+zl7hW9REIIBdqW5gmEMJ5gN2X0UfqMUlGumn2xX8senlXxyHFBZgZSjk1vvKChKOFMqbHv9G9B/EE@vger.kernel.org, AJvYcCWwy3wtgKAaYpsk3H3ZT3qd7k4zPUfyKCxYlmtXKPH9eNmuOquBS+Egb0KvacnD3VgbDliKA+T7@vger.kernel.org
X-Gm-Message-State: AOJu0Yyc0MbD87NCFYKbnB0vXjSvTKbUnrUI4iK2dZPHRwsIUYa+OcTi
	tmRQ0w5wegjggQHiwfMPcH0AVfIHgko2F/nGJcmvGKfnLr4/95d4
X-Google-Smtp-Source: AGHT+IFerp3i9PMi0KaUp00Djg4A3gCBpMNYApZcLGXOBnYchDqJbxy1LByYRd7ppnrDP3jVK8UcrA==
X-Received: by 2002:a05:6a20:b40b:b0:1d9:651:7d6c with SMTP id adf61e73a8af0-1d9a84d97famr29656569637.38.1730431102334;
        Thu, 31 Oct 2024 20:18:22 -0700 (PDT)
Received: from localhost.localdomain ([39.144.44.206])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-720bc31af9dsm1854445b3a.217.2024.10.31.20.18.17
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 31 Oct 2024 20:18:21 -0700 (PDT)
From: Yafang Shao <laoar.shao@gmail.com>
To: mingo@redhat.com,
	peterz@infradead.org
Cc: juri.lelli@redhat.com,
	vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com,
	rostedt@goodmis.org,
	bsegall@google.com,
	mgorman@suse.de,
	vschneid@redhat.com,
	hannes@cmpxchg.org,
	surenb@google.com,
	cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yafang Shao <laoar.shao@gmail.com>
Subject: [PATCH v4 3/4] sched, psi: Don't account irq time if sched_clock_irqtime is disabled
Date: Fri,  1 Nov 2024 11:17:49 +0800
Message-Id: <20241101031750.1471-4-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.30.1 (Apple Git-130)
In-Reply-To: <20241101031750.1471-1-laoar.shao@gmail.com>
References: <20241101031750.1471-1-laoar.shao@gmail.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

sched_clock_irqtime may be disabled due to the clock source. When disabled,
irq_time_read() won't change over time, so there is nothing to account. We
can save iterating the whole hierarchy on every tick and context switch.

Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
Acked-by: Johannes Weiner <hannes@cmpxchg.org>
---
 kernel/sched/psi.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/sched/psi.c b/kernel/sched/psi.c
index 84dad1511d1e..4d26a106f03b 100644
--- a/kernel/sched/psi.c
+++ b/kernel/sched/psi.c
@@ -998,7 +998,8 @@ void psi_account_irqtime(struct rq *rq, struct task_struct *curr, struct task_st
 	s64 delta;
 	u64 irq;
 
-	if (static_branch_likely(&psi_disabled))
+	if (static_branch_likely(&psi_disabled) ||
+	    !static_branch_likely(&sched_clock_irqtime))
 		return;
 
 	if (!curr->pid)
-- 
2.43.5


