Return-Path: <cgroups+bounces-5480-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A33B9C1E10
	for <lists+cgroups@lfdr.de>; Fri,  8 Nov 2024 14:30:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9D51F2884D0
	for <lists+cgroups@lfdr.de>; Fri,  8 Nov 2024 13:30:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B4891EF93A;
	Fri,  8 Nov 2024 13:29:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZxRwg/Xa"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDBA41EC015;
	Fri,  8 Nov 2024 13:29:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731072576; cv=none; b=pOrFFYb0s14TUS0hHG/K4Zn/XMf105PY8gyoU5OUYf91mQ0nqOOdbkJi/VDLXOcuV5ubE9tUcTDLAlXCuEJufqKjgYEHujdDkSridqwNiWp4voTZFzwuLleX/+neVme83a8/K4VDhZV+8WhiJgIXzIVZuQdZkhW9Bv3P6dlO6dY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731072576; c=relaxed/simple;
	bh=7YeGjR+34IesShhjFHXrzADkVKoy/SEglkASURmL0k0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=SgloYQPw6b96YIMhx9fSh0sMxh4lbD05Fz70FS31TEJJqWMFi9RYjAx/Z6itx7k3lzz9VQjJh3073l4DRB7mYeJw1uoxgf2fir/LMJ7UnXtC8tFWMkeBxJ7ueAAeAZ9cR26s//N8mbJtfL0KOcXjQ/KypGFd4jmTPus+8arrceM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZxRwg/Xa; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-72097a5ca74so1734252b3a.3;
        Fri, 08 Nov 2024 05:29:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731072574; x=1731677374; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Bca8LHxFT6RS60KEb1zpl3Ks7DaYjeZ9NJCVw3XPDMQ=;
        b=ZxRwg/Xarxetu47u2xMQt/4x10H8TpIJNO/SfLslfJXAcLzdfTtrZH3s+JF/0uEWlx
         pPsTrgKHwxJWeLDf2SD3Dpd661ZpWVaabEKc5RLHGwMobSnPp0ak21uYUB4YUySwh1Vb
         WmyYsPh9OIpNZmBD4VZr4Ag4spe9QZAzGemOPZUbq1VKCjbTzNU26BZ7WYZK6fQ+VHim
         yQGZTbiX0vtnW4epQsmSo7P0enCrkBwX9T6OVu0ksiWFEJcOGPRApY+9xL4ZbMIIZXwY
         4IgKkkD10ujyf23LxW1tMSsBwZDqkh9GR7lt4r3KIH98vQCyt6PncRvLR77sOmiNFSNQ
         wZrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731072574; x=1731677374;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Bca8LHxFT6RS60KEb1zpl3Ks7DaYjeZ9NJCVw3XPDMQ=;
        b=kYCeEs8/Tu72jXXQDBhgAz9BieFgb/fuwhV0FXSXHruDG5DtY1wOxh8ew3ozeFhvEU
         Sl35ZGk7iko2sSRIVq3sIK8fKqw1XMS/wz9HS5+zEEqQU3PQ/KVkfY3aRXyIkeaFOrS7
         sPID5svaivPkcvxeBBJgTlEA0xceqnKDe67iRC283HgMYTab32gW3mvDt8XrIKY7H+7r
         qwZ99lEFwmTDz7IdtXUa5UT/7x6wL/+WDG8J6hC89URYQHB5+eQPOfg4IsHBGPDIY6q2
         vYXChR1RcycjTex+oSBskJgLkb2UDCUuhtCEcOMDSvlbhAewxOnkE06A5ioeZk25T0Mf
         IAhQ==
X-Forwarded-Encrypted: i=1; AJvYcCVdRSyUXPbFpfsKK6s3lQdXTjuKnPhHCufQfjGpZQtgd2CVYDNYRim3RZKUMHqRSvVtgwI7QxUq@vger.kernel.org, AJvYcCWfw/SGiI2PXlw3EH8cRaq9GzFC76oCG5EBg+Bd6YBbJTWkXcm9eT5JvDl/OAlcqkSuRv8QRwmVOskA6fC9@vger.kernel.org
X-Gm-Message-State: AOJu0YxtyVIipOhjZhIiWFJOG0ujk5zC82xxoBfG+tfbMKujB036hGtZ
	Wc3+3QQMaJSF8Urh5RP0NOF6UPpYn5h/EqjH8g2sn+ndr/Izr+AA
X-Google-Smtp-Source: AGHT+IFNFLwJWfjuEkvcYqzIeEtfd3sh1N24sfiICV4C/s/z0wc4H2d+r0QkUNdbxJ2VLE1lB3tq/g==
X-Received: by 2002:a05:6a20:1583:b0:1d8:a3ab:720d with SMTP id adf61e73a8af0-1dc224ece06mr3915725637.0.1731072574175;
        Fri, 08 Nov 2024 05:29:34 -0800 (PST)
Received: from localhost.localdomain ([183.193.178.50])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-724078ce169sm3642561b3a.86.2024.11.08.05.29.28
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 08 Nov 2024 05:29:33 -0800 (PST)
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
Subject: [PATCH v5 3/4] sched, psi: Don't account irq time if sched_clock_irqtime is disabled
Date: Fri,  8 Nov 2024 21:29:03 +0800
Message-Id: <20241108132904.6932-4-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.30.1 (Apple Git-130)
In-Reply-To: <20241108132904.6932-1-laoar.shao@gmail.com>
References: <20241108132904.6932-1-laoar.shao@gmail.com>
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
 kernel/sched/psi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/sched/psi.c b/kernel/sched/psi.c
index 84dad1511d1e..210aec717dc7 100644
--- a/kernel/sched/psi.c
+++ b/kernel/sched/psi.c
@@ -998,7 +998,7 @@ void psi_account_irqtime(struct rq *rq, struct task_struct *curr, struct task_st
 	s64 delta;
 	u64 irq;
 
-	if (static_branch_likely(&psi_disabled))
+	if (static_branch_likely(&psi_disabled) || !irqtime_enabled())
 		return;
 
 	if (!curr->pid)
-- 
2.43.5


