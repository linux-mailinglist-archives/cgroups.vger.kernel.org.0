Return-Path: <cgroups+bounces-5721-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E7E49DF587
	for <lists+cgroups@lfdr.de>; Sun,  1 Dec 2024 13:43:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0DA682815F4
	for <lists+cgroups@lfdr.de>; Sun,  1 Dec 2024 12:43:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EB311B4F2E;
	Sun,  1 Dec 2024 12:43:22 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65C691B4F10;
	Sun,  1 Dec 2024 12:43:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733057002; cv=none; b=XC23y5Dwk0kbizYhjc/jzhNGATL/+S9JptC4uEsJYBOuXDbacS3N0SloelrkaS+nZHKs1zZRuEYy/nseZ224B3POrfspxvV0eq2dAfmGARwEFXKbwzYLKtzk9iaWJSBs1bEnoss4FrXR5H01iCfQaSozmMz8xPF7yOZbzbCfiZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733057002; c=relaxed/simple;
	bh=gt4HCElhbhYUl7PT+3Z3hy7r8+X5V1aFs9mZhgDDa4g=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lXuBVhx8+rek6yUQeSDs4NR6j4KkXlKYuQMOmOfLQcYfMvszMJmZg9qVZVI9LkH3sQ+B/eVjK690My66zdT+aGOEIPf58WQaviTvL5rE4gb6m95v6RQNPbuq5r3UlrBv9kWOLdKopqO/04Hk+YMkHlu34z+K6xjw6eMa7ZYgaSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-434a10588f3so20380785e9.1;
        Sun, 01 Dec 2024 04:43:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733056999; x=1733661799;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VWr8vxwwo0ySNy1XE3FLPwaz+usxzE+up40Zsz5K9bM=;
        b=kRCdIBD9tPhlBDdMHG3BVqs81TxabEuVV4vhBCZ6+xcYQg+4fTD9KQLJLP4rGQCy6a
         rVb20MearlduQFyHZXdA85aPwiZ5EPFrrzceCPApxbU6vUE9GeZ5WbFe5UgEqM7pdo1z
         hG6keYwimrHkZfQuGSyzTn74UrYOSsY916i4m9SwDfWbAb7c0Wh0hlZuhIt21YJShTQk
         vLQcPNQkk/vjx5S3No5b9tz+A9u3nln54Q6dga+Zn7i4qIZzaZBkuxzX3/3Cum3MOVfz
         vGJH/toyGd9gdZxIwcX6SqQHQJlBLNXcPuAUkEhJR+0AYAl6OIrKJuPMuIrQOFjfkNqY
         29Og==
X-Forwarded-Encrypted: i=1; AJvYcCUlgjpf6sXSQyc4VSGs3zkCavTVmsO2xSd1HhYfNtgQMX0BWx134rOEefOCNHltDGBgDPcXZa9R@vger.kernel.org, AJvYcCWo3ebI19GxauGyw4d4ysZ77FW2SFCSkkaXUmfh31ir7W3gtS/sA+Hzori8lOKeIq5NULikW6hht/JKncOs@vger.kernel.org
X-Gm-Message-State: AOJu0YyBABWnAl3ZAE0hdhcCHNQaPWFcFPYyHUT8TexXK+TbZhQFN40J
	CIwWvtrj7xMsGEbgiNGomWuq9IcbrQNWYuqxQXpLEwyre5cU/sEm
X-Gm-Gg: ASbGnctl76sHbGHA82ru+uD42Cn7frdPnrTOTKGWO1D05jb2KbbslUXwl5rhTavnQnz
	dx+j4kEb+FU5IfJA7DEswF03AQXtYS4h+C0Nbjm3/cBF/ZlGNHwvH8gR9X6LxXYujLoPYCMLuQS
	wjEMSMFrEURLMhU53KRthLHgvfKO1q0Le2yH1I54ebn84wlDIOFglq9uM2nYumrMxHFya8W0ESb
	ZZCwKxLjeI1b5get39L4pD+RYpA/W6+8QIKAMX39UtTbx72adciYMGEKozDoNXQ/Bg=
X-Google-Smtp-Source: AGHT+IHZeN6XY4DEY6A6dqVAV62+FxLC6/hUWxBqHcvVzwZN/CLzBgowoZRoNZwShLCfTrVQHlVErg==
X-Received: by 2002:a05:600c:314a:b0:434:9e63:fb15 with SMTP id 5b1f17b1804b1-434a9dbb864mr149899785e9.1.1733056998529;
        Sun, 01 Dec 2024 04:43:18 -0800 (PST)
Received: from costa-tp.redhat.com ([2a00:a041:e280:5300:9068:704e:a31a:c135])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-434b0f70d91sm114434985e9.39.2024.12.01.04.43.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Dec 2024 04:43:17 -0800 (PST)
From: Costa Shulyupin <costa.shul@redhat.com>
To: longman@redhat.com,
	ming.lei@redhat.com,
	pauld@redhat.com,
	juri.lelli@redhat.com,
	vschneid@redhat.com,
	Tejun Heo <tj@kernel.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	=?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Costa Shulyupin <costa.shul@redhat.com>,
	linux-kernel@vger.kernel.org,
	cgroups@vger.kernel.org
Subject: [RFC PATCH v4 2/4] genirq/cpuhotplug: Dynamically isolate CPUs from managed interrupts
Date: Sun,  1 Dec 2024 14:42:42 +0200
Message-ID: <20241201124244.997754-3-costa.shul@redhat.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241201124244.997754-1-costa.shul@redhat.com>
References: <20241201124244.997754-1-costa.shul@redhat.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

After change of housekeeping_cpumask(HK_TYPE_MANAGED_IRQ) during runtime
managed interrupts continue to run on isolated CPUs.

Dynamic CPUs isolation is complex task. One of approaches is:
1. Set affected CPUs offline and disable relevant interrupts
2. Change housekeeping_cpumask
3. Set affected CPUs online and enable relevant interrupts

irq_restore_affinity_of_irq() restores managed interrupts
during complex CPU hotplug process of bringing back a CPU online.

Leave the interrupts disabled those affinity doesn't intersect
with new housekeeping_cpumask thereby ensuring isolation
of the CPU from managed intrrupts.

Signed-off-by: Costa Shulyupin <costa.shul@redhat.com>
---
 kernel/irq/cpuhotplug.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/kernel/irq/cpuhotplug.c b/kernel/irq/cpuhotplug.c
index ec2cdcd20bee..839d3e879c0d 100644
--- a/kernel/irq/cpuhotplug.c
+++ b/kernel/irq/cpuhotplug.c
@@ -218,6 +218,9 @@ static void irq_restore_affinity_of_irq(struct irq_desc *desc, unsigned int cpu)
 	if (desc->istate & IRQS_SUSPENDED)
 		return;
 
+	if (!cpumask_intersects(affinity, housekeeping_cpumask(HK_TYPE_MANAGED_IRQ)))
+		return;
+
 	if (irqd_is_managed_and_shutdown(data))
 		irq_startup(desc, IRQ_RESEND, IRQ_START_COND);
 
-- 
2.47.0


