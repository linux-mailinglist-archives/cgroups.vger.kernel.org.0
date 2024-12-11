Return-Path: <cgroups+bounces-5801-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DD679ECD08
	for <lists+cgroups@lfdr.de>; Wed, 11 Dec 2024 14:18:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E0777167D28
	for <lists+cgroups@lfdr.de>; Wed, 11 Dec 2024 13:18:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F7CE2336A8;
	Wed, 11 Dec 2024 13:18:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HE6ZVgxk"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3F0E23369B;
	Wed, 11 Dec 2024 13:18:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733923090; cv=none; b=WMu9XRWh/+2pi5Tv5rxj+f3YPBjqPdtvhX1iOV4unaJ7KucQLn+cYs379pi6WoIWWddshYV1ri+QmdhAvCDPBVKSbyLMU0GdDoPf9FlUQ9tnWZ79eDEA/+uZntuZdPrLxRx6dnBGTJVGFbMz/RpRZHam71Pv/ytSC+UyxqZwB6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733923090; c=relaxed/simple;
	bh=vKkrBqKm9COEooD0h7vQYFL3hcLGirif2vplKVkqqdg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FpA+f/rZaboYB9PRjx49WXv7B7b4omIBNyNiguid3lWwA6novHrbrEKPFaT3u29niVRj4qrZzTl4TT8y2D6sKTSLLutZBVGm73J5nnExxl+1ZsD9KfHuy56X8MvBjVyqHt3W6LjiJ+7U8aCsBfWkkc63zAUzVjqhUjvPlBgQ938=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HE6ZVgxk; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-725ea1e19f0so2899987b3a.3;
        Wed, 11 Dec 2024 05:18:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733923088; x=1734527888; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/0KyEyNTdp/tWCBWO59LjYCklod3SgANT6I6z/q0u0k=;
        b=HE6ZVgxk9jFq3qANyltb/DrBkflZFd1NRo4WyvaOSBSG0mLXN4lUmazvkNEZnwYOMm
         lKemjK1A4l60zJJ5KxYviPw80QOgj/H8EoTktsURihMkhJB3LbuSVLi3p6YZFIYz64XK
         j9/ES5IqqFLJYwVfkb5dnSJ+HeszGt50KV3WLhkRzohrA7NDsyDz0zzflQZk4CfXD1sm
         7ql4rk+OUNEUZdMxWpZH2maq34k/HIMoY1sT48DfsRFBHf8OSqV2eC+NptWtTtMv0Mp7
         B/DJjJrRMBJ6ozwoexNZuSP9TFM1PEZ/pCorn5x2k/3blqHAr9OJ5OmyrFsZvz5UjjUc
         zgZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733923088; x=1734527888;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/0KyEyNTdp/tWCBWO59LjYCklod3SgANT6I6z/q0u0k=;
        b=L4BNPhGM84DhYeHuSiMEHebXCW2ifwpCXylJhPaeTzdZ1NvJRBS/yO8I7RWZj2Jbut
         P0wzP5PcabakrXhG5Ko4H6VQ4A9jFYP3yC+yFIK1uIibVRMypZJOrNPQcpRe4lm95SSU
         QbwfsKi/vffodMMMuT3tUmW85v0XzeiyasYqUkHKDURTisyuWmeW9njGFkXjNUfLbblJ
         wcmszzIpbqQ+5gYld4+iqOXXnmhvsd8/jguhbyA95bUWCVoO8FpW8EBK0q4QTCswuJQw
         zsMhnxo/BAx0Tw7emHm6ghxtyJa9pPOM+mW4H5psH3DtH4swzcisf3aO5fI9ENKGGUbY
         ATjw==
X-Forwarded-Encrypted: i=1; AJvYcCU/TGTyFLXYzCD8hz6xkILnO6VFWDm5dzUc9Nr1VFJRCiuqgjlZoFbWHHmUgMfZgJt/+z8d2WH7B3I77QeI@vger.kernel.org, AJvYcCXv7w40WQmdnn/mzCuMSpdrfyqbu4cw+MqC3bHroVJ5H58BOfs+I5eKDGniykB2rBa0IBX1k0uS@vger.kernel.org
X-Gm-Message-State: AOJu0YzPgGmCEycwyLBnCZMWxL+GFHBsHay/WTOgIBJYCf8/ealxtqAQ
	ksCAWNKBM6ES3Fl4m2HVJFn90PTCQOboogUJG8Cd2xFe+7sUS5qw
X-Gm-Gg: ASbGncsf9szkJy9YVIShikXasaBIqYUjWaLUVxCvCSuyfGRJY0SNBg7RHu5sO5/FHiX
	XShUN16QhQrQ3U3DCSvT5z3rmt57BxrPm8MHJiAF6OiGw83+rVjIE4OuK3VI4WHiuWXuVBRDjIv
	QOydriZ3/TtPw8JGfhQSvBkRIh3Zjz+4MtqQ0/fvPhDsV1joStfYbJ87EFAyh9JuQQ9YWuPaYfc
	q38MHl9OjdbyINVBte5GicfKuYLjAKuFxJDvLdmG6U65GAc1lHbOmyE6Gg9IhzZaVEEpzsLIB83
	dwER
X-Google-Smtp-Source: AGHT+IHH1w+18MF9BXwc6uIn6C8RpvtOv/r6dioYOS2ofRZ3nJQGv4zZXZsl4bf7K+zxuTc1TmRo/A==
X-Received: by 2002:a05:6a20:43ac:b0:1e1:c07b:b087 with SMTP id adf61e73a8af0-1e1c109a134mr4471981637.0.1733923088020;
        Wed, 11 Dec 2024 05:18:08 -0800 (PST)
Received: from localhost.localdomain ([180.159.118.224])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-725eeb536a1sm5272628b3a.115.2024.12.11.05.18.01
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 11 Dec 2024 05:18:07 -0800 (PST)
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
Subject: [PATCH v6 3/4] sched, psi: Don't account irq time if sched_clock_irqtime is disabled
Date: Wed, 11 Dec 2024 21:17:28 +0800
Message-Id: <20241211131729.43996-4-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.37.1 (Apple Git-137.1)
In-Reply-To: <20241211131729.43996-1-laoar.shao@gmail.com>
References: <20241211131729.43996-1-laoar.shao@gmail.com>
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
 kernel/sched/psi.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/psi.c b/kernel/sched/psi.c
index 84dad1511d1e..6836c34d063e 100644
--- a/kernel/sched/psi.c
+++ b/kernel/sched/psi.c
@@ -998,7 +998,7 @@ void psi_account_irqtime(struct rq *rq, struct task_struct *curr, struct task_st
 	s64 delta;
 	u64 irq;
 
-	if (static_branch_likely(&psi_disabled))
+	if (static_branch_likely(&psi_disabled) || !irqtime_enabled())
 		return;
 
 	if (!curr->pid)
@@ -1286,7 +1286,7 @@ struct psi_trigger *psi_trigger_create(struct psi_group *group, char *buf,
 	bool privileged;
 	u32 window_us;
 
-	if (static_branch_likely(&psi_disabled))
+	if (static_branch_likely(&psi_disabled) || !irqtime_enabled())
 		return ERR_PTR(-EOPNOTSUPP);
 
 	/*
-- 
2.43.5


