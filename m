Return-Path: <cgroups+bounces-6038-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FF6EA002B8
	for <lists+cgroups@lfdr.de>; Fri,  3 Jan 2025 03:25:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3AB463A3412
	for <lists+cgroups@lfdr.de>; Fri,  3 Jan 2025 02:25:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D370148FF2;
	Fri,  3 Jan 2025 02:24:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XcOBfX3N"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC1CD84D34;
	Fri,  3 Jan 2025 02:24:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735871087; cv=none; b=mZHyDCmaCehWZ6KH1p3rB9Q7J1n9T1LYAcZFl3dnGOA6dBXc4WBQULVz9QMEkCQ50WDsXYDNgCdlkejVIZXDddXidwvI/ACeT58o05XGp+THNJWn0sDliDoOhQ+8qyKsGpPw1u5Yo72zuwt08alvPmoB/d7QrfHK+ma2QHxSXV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735871087; c=relaxed/simple;
	bh=9hkP9CNLB1Zz6HKgM9bvLOyCa2y3jW0g8uuQlxjgwmY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DsiuCv/6uyXjBXsQRnbJfGy9wr/FMftPJWdKWdQIPUTTDThB8WDoDuQDHE2K9MTVKwjcGcaBTYInCUolRs6kjTzZUVEGcrdgRVU4rEH8E12PTH7ixHHhjUVQrBQc97meKLTRn8q3xfo3fvX9Z5nXhOfi9BYaePdmcM2G6VfKNZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XcOBfX3N; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-21669fd5c7cso165646475ad.3;
        Thu, 02 Jan 2025 18:24:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1735871085; x=1736475885; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yWIE+8nwQHpR1+w81wvyLMSrJdm6DucI0YocL1dx8X8=;
        b=XcOBfX3NmUkrbLy9te8a8/NPH9x3KOS4LeZ0XbnhqGH15qpNG3WGIfhgOPUGeEZA6v
         MjYNHW4zOIsuJnDljWpLDuKjle7yrOYlLShZ66PSykr0CkblND2Pr3gC8JZHZkUEhMbi
         ejsxBUAKKcyal6kQLJJxwZRPzBHJX17t7U4JVCEI0BuHZq2ItPyRYjIf21URPK9b6nl3
         uHlVcnmKSDhCpA6QfAbCBKX9YFJBBYOMkQ8nSd7R2Z4nlsRiZnup0K3fHpsyz2ponZgP
         o5E+YQOJ0XsYFbFhyUf9SDBr97m5qWFZKhUPWrpxGzyQI3yFAbILK/mmm5L28BR8b0lT
         VTdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735871085; x=1736475885;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yWIE+8nwQHpR1+w81wvyLMSrJdm6DucI0YocL1dx8X8=;
        b=GVZqz1Z9DUV26cV5+hQVCHwRzE2lmtxT9B9F+gCT2HohQDQb4kbXxCIV1OkyGJAlzF
         k4m4ekN4WeZIr+O4vd2SY7q1PaRyXKcrTEVg14DnDjOgkJ+9Rg8u9mrUIlSTs6069ElM
         JSJPjFsDz+2fafd2D65QHVwq5cDN5lWQ/XAtz3Io+Y/DLoTaNufag4sfLssigfGnCBJQ
         DsvvYGci5UBoS/X+/1VjlKerXnYLuJfXc/bIctAUrXqNpLtmGNE/bsnNkSYMAhKRb2/D
         POw+yQd6vNxnIY5wyjUfQtKeQ7SNBergDa38ZCbmJ3CWOAzY5gQY2tV/ole5GDia+tp0
         LLag==
X-Forwarded-Encrypted: i=1; AJvYcCVID2DsVGi6vSVGawyYS7EYlQTrTWcDJESL7BwEUiUrsBYGi0oTrM8KFZ7hxoKwCs88hWAz3FDG@vger.kernel.org, AJvYcCVcEXlZ/b7ha3ZObQni/D7rVg2PTF55gnhRhs0ljf0UNBylMR3z/tFaNnQcDy2kmGpNF4FIhcHslf3ws+Zp@vger.kernel.org
X-Gm-Message-State: AOJu0YxfJREJWmBlCMfl9uuianJThJxfBGM4imKf+pdkvAc1qHSVRigd
	3LeQ3bqHANAB42RzH2UVKbnyvc4BgOQA8V6ktRYazYZ47jO/XJZZ
X-Gm-Gg: ASbGncv0Q9TF//6yukUjfXxsHZIu1QEcd5BArlLf3WGeW0Y5nvgeXgZ9WqA0OViyj1Q
	qMwRCRjYlntPmwqjo67i+LJmSypkomi8xaHX+1K5BsWnN1wVlgooKbDIKpHvHQ4w3kuzI0Ap6DW
	BOX+w1eDdF9wVM9euPWaF9SiOmo0z7E1cvpO0zNqi79EoDzSSG/lY1IINnfE1sLJ724hvAlkJqw
	s0z/fDaul5twEagvbdFTjV7+2LDn0IW+1Sgsxc77KhlKEbwdgKTP9d6p/QXo5p/i63X6Acvh4lo
	C84qcFs=
X-Google-Smtp-Source: AGHT+IGoep/6dfNw3Hd9Fb43f/Z7Syxbr1uL7dDLZJ1mEXIKN7hrQDCZeoslkNaWGJGikMtU1psqDA==
X-Received: by 2002:a17:903:1209:b0:216:36ff:ba33 with SMTP id d9443c01a7336-219e6ebcfc7mr624597085ad.26.1735871085003;
        Thu, 02 Jan 2025 18:24:45 -0800 (PST)
Received: from localhost.localdomain ([180.159.118.224])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-219dca007f3sm234184145ad.228.2025.01.02.18.24.38
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 02 Jan 2025 18:24:44 -0800 (PST)
From: Yafang Shao <laoar.shao@gmail.com>
To: peterz@infradead.org,
	mingo@redhat.com
Cc: mkoutny@suse.com,
	hannes@cmpxchg.org,
	juri.lelli@redhat.com,
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
Date: Fri,  3 Jan 2025 10:24:08 +0800
Message-Id: <20250103022409.2544-4-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.37.1 (Apple Git-137.1)
In-Reply-To: <20250103022409.2544-1-laoar.shao@gmail.com>
References: <20250103022409.2544-1-laoar.shao@gmail.com>
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


