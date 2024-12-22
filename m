Return-Path: <cgroups+bounces-5987-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 58A049FA383
	for <lists+cgroups@lfdr.de>; Sun, 22 Dec 2024 03:49:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A8841166FC0
	for <lists+cgroups@lfdr.de>; Sun, 22 Dec 2024 02:48:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC76713B791;
	Sun, 22 Dec 2024 02:48:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B5+PjbzG"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04DD713A26D;
	Sun, 22 Dec 2024 02:48:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734835688; cv=none; b=h6yPtwgwd4un0v0XE5b/7UCCOKs9EM5yzZ6gbyIUNtZiYtk9N1RPmuKp5Q11iMGlNA2UH3IGxjFV3O6yKfHFvb1DwA642l/SQ0t7fHt+cYTtQErH0ncFXrpG3c3H+5dGhDm6KB36oB6mOPTfX0m5nj28EBucAG+GnSx3reMnCuo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734835688; c=relaxed/simple;
	bh=9hkP9CNLB1Zz6HKgM9bvLOyCa2y3jW0g8uuQlxjgwmY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YWxrrNFxCfrptqbVisspZ3IEl1z1y6+UbYMuSAk5sU7PDlf4oYeUtXFGjY6QOt0QMk8GrARkZ/LrLdWE1wycVV+5JtWfMP3cZ7lNJCJH1OHsos/n9RY0BiEeTWuENT65E4/otfTWSFx55fCpezoWMANWJdIvMga0BVvgBktn110=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B5+PjbzG; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-728eedfca37so3426080b3a.2;
        Sat, 21 Dec 2024 18:48:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734835686; x=1735440486; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yWIE+8nwQHpR1+w81wvyLMSrJdm6DucI0YocL1dx8X8=;
        b=B5+PjbzG2UKMs5GMtnmevkJThJbbAPe5UhgSlgkAupfjfZPjE8Av/ZAxJ2SNkcrVOJ
         2pAyOANtQXAseEw8FR26IqB0v7ysETD9NYv/hiyGoR5qlucJXiz8fgniJkBIUzaEhITM
         WbCkaj2AoctLUZqMyoeLhc4sUumeKYAyM/QsXu5Yu+lJk5GGglqv/HtmTyvdMAtJdimC
         pUNE/rB17gvmbjaKcmaMzp0gkyUatez5+ElgYlWmYYllrFVyHQUhuNMYmVywVjuvFQtF
         SgmSvJ36yAYittKN2/O5DYEQHQ/Zd5vdo9lqj8GAME86IYcN63fzewSwu834uJPfXLP2
         2J0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734835686; x=1735440486;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yWIE+8nwQHpR1+w81wvyLMSrJdm6DucI0YocL1dx8X8=;
        b=waz8fD2icD+mWVAdhuAYEcIv38nVJFvTSB2Pu90VazJzIJ5fQGtBv7nYVLwFWvAe2q
         vVbcUPaw2VhVaOHMBhF7UeKcMYvFlWImWRAtWTJSbxbrCgpRubetWaIYeY8ims+DaAF9
         YCu0Yo+x5OKd6Tt6zyxZXlw+8QOJTBvulKMjoNHaCFIda4gE8ctujBcz/4ZOpoNUm04u
         yWMWbL9R91up/UIai/0USasB1ZLrbSEXbosiKiN1A0wMYBuT+yDNRFxFNXiJWO1nay3g
         eRttC7eSbPmCibrztvBHYc/U24fmcwppyxrm7X2aUEktHvdTCMaNX7PE67YUg3G/5yWs
         hr6w==
X-Forwarded-Encrypted: i=1; AJvYcCVd8N+PEOtDCbjw+1qEXQkqgeawlFY3e6g6JNv3MRpDK8Po8IJzKXJykchHl4EQu4gDoH/01K8B@vger.kernel.org, AJvYcCVr4Ay0J25OyteZBr5aujhlAuMMPrZJlJbVpnOlOxTX8m85PE+h8PhMDH7a0Qs75dLDzxOD7XZRIR4WV0/d@vger.kernel.org
X-Gm-Message-State: AOJu0YwRkFJSxzjWkaN9rm3Aa7FOipgExGhZ81KZV3vFUrGNmgoFRLOi
	20cHH3ldK+yt53Q5tCRYrPVW7Qt1SXABK6+/0dBkImv/8snkICxV
X-Gm-Gg: ASbGncurc8+WYDQxe1tMEpAF6g+kD8japS17OYycU0EnETGvmFpDM4Wnu1R/YzPr674
	t2d88gTxOnT7zbbgtJZICmdZUNO1Vjn/jgF2ghMpL7uMW1KTvIJwTlW351loLyJ8QUfcKcqnH9m
	KZ35p0GsdE3l133vhQ1dNLX9/5D0uS2uLagNTy8yOa/1c0/GkSYPYEteyq7xmMCQpZV9vtQ/e2/
	xLccTIg3TNKk4/njmGlrvT9W3n0GulsXs2CWqVWrl98ksaeMEBx5VAZEcRSrYMRBIdz+djHEa2n
	QAz502o=
X-Google-Smtp-Source: AGHT+IHnYgq18uWNBphjBQfgjsbvSr8OCffovbEjg0kGG2TDCwJSt6O/67ICGV+ujVpcuiOiI4LbrQ==
X-Received: by 2002:a05:6a00:3406:b0:725:eacf:cfdb with SMTP id d2e1a72fcca58-72abdeeed6emr13475021b3a.24.1734835686302;
        Sat, 21 Dec 2024 18:48:06 -0800 (PST)
Received: from localhost.localdomain ([180.159.118.224])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-842b1ce01b8sm4219265a12.20.2024.12.21.18.48.02
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 21 Dec 2024 18:48:05 -0800 (PST)
From: Yafang Shao <laoar.shao@gmail.com>
To: mingo@redhat.com,
	peterz@infradead.org,
	mkoutny@suse.com,
	hannes@cmpxchg.org
Cc: juri.lelli@redhat.com,
	vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com,
	rostedt@goodmis.org,
	bsegall@google.com,
	mgorman@suse.de,
	vschneid@redhat.com,
	surenb@google.com,
	linux-kernel@vger.kernel.org,
	cgroups@vger.kernel.org,
	lkp@intel.com,
	Yafang Shao <laoar.shao@gmail.com>
Subject: [PATCH v8 3/4] sched, psi: Don't account irq time if sched_clock_irqtime is disabled
Date: Sun, 22 Dec 2024 10:47:33 +0800
Message-Id: <20241222024734.63894-4-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.37.1 (Apple Git-137.1)
In-Reply-To: <20241222024734.63894-1-laoar.shao@gmail.com>
References: <20241222024734.63894-1-laoar.shao@gmail.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

sched_clock_irqtime may be disabled due to the clock source. When disabled,
irq_time_read() won't change over time, so there is nothing to account. We
can save iterating the whole hierarchy on every tick and context switch.

Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
Acked-by: Johannes Weiner <hannes@cmpxchg.org>
Reviewed-by: Michal Koutný <mkoutny@suse.com>
Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
---
 kernel/sched/psi.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/kernel/sched/psi.c b/kernel/sched/psi.c
index 84dad1511d1e..bb56805e3d47 100644
--- a/kernel/sched/psi.c
+++ b/kernel/sched/psi.c
@@ -998,7 +998,7 @@ void psi_account_irqtime(struct rq *rq, struct task_struct *curr, struct task_st
 	s64 delta;
 	u64 irq;
 
-	if (static_branch_likely(&psi_disabled))
+	if (static_branch_likely(&psi_disabled) || !irqtime_enabled())
 		return;
 
 	if (!curr->pid)
@@ -1240,6 +1240,11 @@ int psi_show(struct seq_file *m, struct psi_group *group, enum psi_res res)
 	if (static_branch_likely(&psi_disabled))
 		return -EOPNOTSUPP;
 
+#ifdef CONFIG_IRQ_TIME_ACCOUNTING
+	if (!irqtime_enabled() && res == PSI_IRQ)
+		return -EOPNOTSUPP;
+#endif
+
 	/* Update averages before reporting them */
 	mutex_lock(&group->avgs_lock);
 	now = sched_clock();
-- 
2.43.5


