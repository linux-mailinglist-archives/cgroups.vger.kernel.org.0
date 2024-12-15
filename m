Return-Path: <cgroups+bounces-5899-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 192209F220D
	for <lists+cgroups@lfdr.de>; Sun, 15 Dec 2024 04:24:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3A6781658D5
	for <lists+cgroups@lfdr.de>; Sun, 15 Dec 2024 03:24:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0317928370;
	Sun, 15 Dec 2024 03:23:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m4dNmkCb"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 238508F5B;
	Sun, 15 Dec 2024 03:23:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734233019; cv=none; b=iAIfqn4W8DEgOutfc8geujWlzWF5LwtOqVIxXxLjAmymgI51QcqA5R4Jd/oYC4boYZ+dLR/n7HvhFmRQOxjSbu5h7iXlh/Q8q831gaVvgL5jUAtWSBP0TmYjqc05Ihe/fsnfEpmCIvxuVkKqeqtXnQwdMoKDoAcBu79p09Dza/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734233019; c=relaxed/simple;
	bh=jjsXex1Xl/raNdbKQJH8s8+9pwFrdykkMbetCt2qLW0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=b8U3kmTfSZJUZ+j63sqSL1e8zkbO4kZisAmTl5oectGxmVgZ9q5ziRY5SQz7+UIJYYpoTbRTMIvCVEdgMsCAUlmDwqkrPjus4Pc/nZTAmB2YVDvVjuDjbs9IRHa3tO4kY0H0wOMv6E+k/AzbPF2nP44dATZGemvXsUZtUkwE9DU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m4dNmkCb; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-725f2f79ed9so2276367b3a.2;
        Sat, 14 Dec 2024 19:23:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734233017; x=1734837817; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2tiXygfzzGb3qZx3mLMCF1CBYULfvbDzHXwBRr7eEbg=;
        b=m4dNmkCbQyhfBcIZYc4aMjD24rEKbEiRBSgPxqynRw4hsNZMRzuhaYesOdFSgstPbn
         Oh/OCH0REMWFI4h7QppRGFhCh4HTVwSnCMWsuHNeICDRy2R4Jdk6+fCy/+oKfbzEsrUn
         qeGZ6iMWoUGxzLY2qGhjdY4Ajul4mxM6JiV4jVuDOoxmAti6dbVLtmKn+2/C2jyiSiHU
         C8+CV9wsqC+5T7dU0fpY7loydsbBsdE4MAQbVfdmmDLh6KAwcQYxwSQJbYGT2k4lRpK+
         TAwyY9T6/HkGsGEZxZReXPO0Fc/WQRNRvAYQKGDE6zvaFbRT2z9SJ4pO+IMAmfOStmet
         capg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734233017; x=1734837817;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2tiXygfzzGb3qZx3mLMCF1CBYULfvbDzHXwBRr7eEbg=;
        b=i2NwFSTdAAoRtjKxLhr/mQxNbYTKiIS7sOWHAKdaSka65YivJVDYv/m7TGIC9Ek86U
         UNn7ylZ7G9VC/JLkyjz7VryfuSNELxpVVXH8HN6m2v2SfYYmYh6O2LbyStY7LRWVJeBc
         cWOBrol2DES0VhBtOHbYaio4Oh4O1fRxpqtV2xfBkxYj4SaMtWZKQuCQusn3l+gpTEin
         MSBd0wePRSwWBj9q4hYTipsRCvCa6i8arb2Cg0o4+MFDZRWfWyCpJMNS5k3wLp9aE1ZW
         /dVaTuceRUnGxP/uJt3S221vh7Lv7jBBRsoidRVbtA9hCWq5PC2HiPHv5KEwJUqUatv/
         7i5w==
X-Forwarded-Encrypted: i=1; AJvYcCXCJ2ozSUa6yYrLpwIDQRRlcHEEpdqu9PBQOM81TM5pswTSerhvRjV6lAWpZQ5UpFTDggz7z5Hu@vger.kernel.org, AJvYcCXcH5j1MPShUOHDQ+n4HL3RFDUtXvinaHHXWEXY30JaP0baI/IQ3wym35dG1UEnHK2pXtctaT9m3Gz8X0HC@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3EvIGw+hKOUw2Ud6S4oCOZf0Gw4AnGbe3JPbO5kaHaxt86OIg
	d9fTTxCE2/hIDDO0HHG/nh6G+mhcjbc3tcGhspKUcoZNhg9pX8jKNRYSaqcNwrs=
X-Gm-Gg: ASbGncsnckv4foU6VPUsdlt92BWWR2ZUxaatgvIflGPsrdfssBeD6RnIcrPTKTBILyC
	EXCiVC6DRNmDR2Q4MEBg2G2QiAOLivdp6NxiW8IOB1dV7FIBhJRjUdCmhzMv+G8aFJQgLDUoFMd
	4h5CgX2/rM5T9Kf8XtEP1rL3Fcq1SBV+VP37Nh5v92RXpKXMZuCoyqOHXqy5ZMIx7aGr0tR2qbX
	zdrKly9AIQHWNu1FrY1Jo5kd0JWjcbfVbGV0nMlmrWXHVCj1tk7Wapb3aEJw//7iC5BUCqHmY5z
	Y0cxLd0=
X-Google-Smtp-Source: AGHT+IFM5aopze3V3Q2iMtHWoWSjzxTzpDMhGsveZtQ8dcWisJ4flmNz+ag2QXcc27PQ+eqIJu+Nsw==
X-Received: by 2002:a05:6a00:3309:b0:727:3ac3:7f9c with SMTP id d2e1a72fcca58-7290c12ee39mr12104699b3a.10.1734233017383;
        Sat, 14 Dec 2024 19:23:37 -0800 (PST)
Received: from localhost.localdomain ([180.159.118.224])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72918b78f1esm2176586b3a.92.2024.12.14.19.23.33
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 14 Dec 2024 19:23:36 -0800 (PST)
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
	Yafang Shao <laoar.shao@gmail.com>
Subject: [PATCH v7 3/4] sched, psi: Don't account irq time if sched_clock_irqtime is disabled
Date: Sun, 15 Dec 2024 11:23:14 +0800
Message-Id: <20241215032315.43698-4-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.37.1 (Apple Git-137.1)
In-Reply-To: <20241215032315.43698-1-laoar.shao@gmail.com>
References: <20241215032315.43698-1-laoar.shao@gmail.com>
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
---
 kernel/sched/psi.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/kernel/sched/psi.c b/kernel/sched/psi.c
index 84dad1511d1e..893d454c82ae 100644
--- a/kernel/sched/psi.c
+++ b/kernel/sched/psi.c
@@ -998,7 +998,7 @@ void psi_account_irqtime(struct rq *rq, struct task_struct *curr, struct task_st
 	s64 delta;
 	u64 irq;
 
-	if (static_branch_likely(&psi_disabled))
+	if (static_branch_likely(&psi_disabled) || !irqtime_enabled())
 		return;
 
 	if (!curr->pid)
@@ -1240,6 +1240,9 @@ int psi_show(struct seq_file *m, struct psi_group *group, enum psi_res res)
 	if (static_branch_likely(&psi_disabled))
 		return -EOPNOTSUPP;
 
+	if (!irqtime_enabled() && res == PSI_IRQ)
+		return -EOPNOTSUPP;
+
 	/* Update averages before reporting them */
 	mutex_lock(&group->avgs_lock);
 	now = sched_clock();
-- 
2.43.5


