Return-Path: <cgroups+bounces-5060-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E706993ED3
	for <lists+cgroups@lfdr.de>; Tue,  8 Oct 2024 08:47:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 39A27281C56
	for <lists+cgroups@lfdr.de>; Tue,  8 Oct 2024 06:47:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD5531C1AAF;
	Tue,  8 Oct 2024 06:22:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Nq+KbRAE"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3768F190463;
	Tue,  8 Oct 2024 06:22:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728368557; cv=none; b=V0csvKmtv20YjEZ8q7GohBWfVETubha4yriee+SECOWFDhUacUfmK/iG4FBYdkEa+E0qHDNT+1Enncw3dG+4ugHUqIwmTLS33bmmGHGBQTy2behwoflHh1UJogHw9e8YDBGksKpys8TLXTeD/HwjIYMuQ89KDaSWolXkyDdWysg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728368557; c=relaxed/simple;
	bh=l5SirwIs4fa/kJ+TrNpd43oWvaho729bYKl0VngKc14=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=WiCkcQtZQjRfMnmVBHMj2uLJIC/8BRtNY3gA6DBk9PMbBJBycb3sSbbvByPmfCTr98v+8/nhW89kIOj5XCoLCXDE130ugWc5/n4m7MX00ieIRskEb2eMQksU54XPHL1PGjwV6SU7Tx1T0sfJdzAA1wWu40D6Baeoi6YAvlaEg74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Nq+KbRAE; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-2e1bfa9ddb3so4031540a91.0;
        Mon, 07 Oct 2024 23:22:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728368554; x=1728973354; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bm9QXwvwwNOIs45Ze0l+LKqVq0pGGiMbOKHfffqvuOM=;
        b=Nq+KbRAEU3j58hRJ877uGZc8+x6dNnyxpgVGlPU+GJG5EYI2wqebnjdztw6i3eUnTK
         K60J7Vn6oewoUV6jksAtP6W4wA6gfGhGcqJS1AilivGGM4psxrXsR4Xc01WdcIl/BdLj
         3KDvGk06PUvoWjFX8d1C/RGqbIPXDHKwSnJsMjqB8jUCbWeuOjX6qCZiIrUpAy42y5wa
         BVlUIyVtVt4jEcoE8p0tt15MGC25Xx+1/T3ahzF2wGr2ka0VJ3or0ES6uJTXKi99wmlk
         JrNiv7sbNSP91p9dDRTvWXqBcYjnIViwoQCzXwaiGeKAInruIi2W5RKrosXkfrdsXHXR
         84dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728368554; x=1728973354;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bm9QXwvwwNOIs45Ze0l+LKqVq0pGGiMbOKHfffqvuOM=;
        b=KjS8CaCkB0D2015zAujZKHEWWHtNAMsfAvCwQBuWTWe6WNg4Mr9f98+jgX5Ro6N5Mh
         sn6ODGX357d14L2H2ZqVKaT5YMdRHjjAvmm1bVnLjC9LcwVU70GIxqgqXFgEbnyYoc2E
         lyYT8wlDjfTu5i2T9+17JOddbewwJYbTF55gmPw1kyEU1MI9yTlFtDFX5C7c+BxYK9ls
         kW49NrYKSy4G6vB8E79snBo5G3Bg4TEV0BG52D1ABl4euoDLA5ZPVrmqYty3eTa4PdoS
         p5YigEzWbZFVurjCQzb4+ZJgM8vmmG6IKNMC6758GcckBu8+00g36hFj6zwFKUMzUUqS
         kZAQ==
X-Forwarded-Encrypted: i=1; AJvYcCWhP0YqhthCG3BMPN7N1KJVHKRaEIqdgtTrSKHO0QeE6Nt5Ori5ZP0FN9CvnGqUMiKn4nueNUSa6iltOQU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyTzUWB3rSQaCaJwdH2yZ73BIz/2vycaJ53yCHmvVQ0+tJ/84UG
	WezgG6x3oBmdMY/hVa7vCpKIoo+LdJTuDsvAGd+lwdfeTtucUhgD
X-Google-Smtp-Source: AGHT+IEsUru35H3naDJFkp7mestgxOGxUXNbPwc7QGF7zWh3F8pFCwITAqaeWfDJK5Rpt3jYDJoFxw==
X-Received: by 2002:a17:90a:b013:b0:2d8:82da:2627 with SMTP id 98e67ed59e1d1-2e1e6354232mr16548925a91.27.1728368554524;
        Mon, 07 Oct 2024 23:22:34 -0700 (PDT)
Received: from localhost.localdomain ([39.144.105.70])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e1e85c8fd1sm8357525a91.18.2024.10.07.23.22.25
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 07 Oct 2024 23:22:34 -0700 (PDT)
From: Yafang Shao <laoar.shao@gmail.com>
To: mingo@redhat.com,
	peterz@infradead.org,
	juri.lelli@redhat.com,
	vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com,
	rostedt@goodmis.org,
	bsegall@google.com,
	mgorman@suse.de,
	vschneid@redhat.com,
	hannes@cmpxchg.org,
	surenb@google.com
Cc: cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yafang Shao <laoar.shao@gmail.com>
Subject: [PATCH v2 3/4] sched, psi: Don't account irq time if sched_clock_irqtime is disabled
Date: Tue,  8 Oct 2024 14:19:50 +0800
Message-Id: <20241008061951.3980-4-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.30.1 (Apple Git-130)
In-Reply-To: <20241008061951.3980-1-laoar.shao@gmail.com>
References: <20241008061951.3980-1-laoar.shao@gmail.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

sched_clock_irqtime may be disabled due to the clock source, in which case
IRQ time should not be accounted. Let's add a conditional check to avoid
unnecessary logic.

Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
---
 kernel/sched/psi.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/sched/psi.c b/kernel/sched/psi.c
index 020d58967d4e..49d9c75be0c8 100644
--- a/kernel/sched/psi.c
+++ b/kernel/sched/psi.c
@@ -1000,7 +1000,8 @@ void psi_account_irqtime(struct rq *rq, struct task_struct *curr, struct task_st
 	u64 now, irq;
 	s64 delta;
 
-	if (static_branch_likely(&psi_disabled))
+	if (static_branch_likely(&psi_disabled) ||
+	    !static_branch_likely(&sched_clock_irqtime))
 		return;
 
 	if (!curr->pid)
-- 
2.43.5


