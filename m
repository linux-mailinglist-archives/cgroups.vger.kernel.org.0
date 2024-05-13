Return-Path: <cgroups+bounces-2871-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 09CD58C496D
	for <lists+cgroups@lfdr.de>; Tue, 14 May 2024 00:02:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9C478B23FC9
	for <lists+cgroups@lfdr.de>; Mon, 13 May 2024 22:02:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2044685955;
	Mon, 13 May 2024 22:01:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eFWJkdXQ"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85DDD84FD2;
	Mon, 13 May 2024 22:01:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715637717; cv=none; b=tv1Jt6cqT61bWRCKZQaAE6FrjJDVkw8RDxth7ln5XUJKdnSX+9ygHmIW/ySc0wC9+4w5fOnsL4bqvTNcTny9l0vjauiNx51XAXiy/Cg+LG/VjkCt1Rr9WVhVKYvIliMrZxQS4w/45myhOnIYN0dNBdvoH1q+N5S/BfzH5Us9Ups=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715637717; c=relaxed/simple;
	bh=Ix9Coy/qu+1Zq7Gd5fg/8EWLc8Pf3aPinseA69cbQO0=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=X69/m9qv9ZLLQqqwR5HfVmqmj3L+9M5dSygDNgssTBXGM1BlnyyaCgouL5vf++p3ty47zH77rXzI8T+jSXEX6GccMfdMyUnj58FWzBnt9+KENuK17Ta6TVuuSmDoSpsojPvyeikJdN95fEziUj21Ukl7AX+iRmQAf/zDcNJFCe8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eFWJkdXQ; arc=none smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-61be74097cbso52625577b3.1;
        Mon, 13 May 2024 15:01:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715637715; x=1716242515; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tMnBK/XyNMBSy+HUKP6h71zL5+rKZfas4ejQ4zNN5ps=;
        b=eFWJkdXQj6KOK2UXb+CCYl8LHrP2SzBeTuJXMFxBDnUxuuZP2WCBwiswrfi/brALpb
         kt+wAIitkMUB8t4ml69uZTkz5pi626BZxC387QRP+eFoKeuus7zn6B/gYjc3/JguX8Bm
         OARkw4l5oiNXHvwMLGz5O/nWRAtnOevAg01uJnA0Drm3X3eHhMIM3Mgv0TYU4+Yi91oH
         4KAn7gldCvfmqgScT4XfB0Dw30Iwo25Bj3GsJnGOInAmaxS5unWLxJpZ2/fwJy3lhoOh
         ouJzloYs3jOvIo6WXsjuGyosbsumTZZksFjbuYunIt0ulnBaWhypFAMtfTjlypecWz5Z
         Kd3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715637715; x=1716242515;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tMnBK/XyNMBSy+HUKP6h71zL5+rKZfas4ejQ4zNN5ps=;
        b=YpGRAYYd8LuIhnMx93wuFn6b14mG+//1mFGzU8hGIxiQy+TvTdknU4vzmTxO88uXRT
         U9KrCz/JugJcoIgx0Jl8ADPIWlFtXnDgV8InFAK64ny5L5mXCkYxsorFRRwcXCQ57e18
         f9dfk/Ym3BgHfOGR/pyD2IPmoTeO7e0vaZV2FxoAEcqfUQB/B9hm5s6RFO8D6sGZbnIX
         eU+Iycqu72uc/1vWj42Fg2USoVJjUaXhbCiuMYEANq65TaystsyNULQjjXeuhLS9v/pk
         v2/hzwW0zNLIOSvplU0cA7BFHAv9RskZdYZme7ShU4qo8GYhBIXybdig1LXtL2o+ZRUa
         lFKQ==
X-Forwarded-Encrypted: i=1; AJvYcCUFVzCw3+2nhg7d8WXrKwZCH3IBqTDIQ0wG9RUUmxYD2pNJa7Lnixv4bMxd61dcHK7fL6lCBXHLipcbo2tbVKwzVZQ3onTLjw==
X-Gm-Message-State: AOJu0Yx18A9Jaw3N2skEvtXsXnN31C34iEOENLkVRJz4P4hybbZEHgLO
	UfvCeJIBE7kIlzHnnAYob4XH1RrAaHpe59WqnPelehdhKW166gqXcgsDTQ==
X-Google-Smtp-Source: AGHT+IHwlzXZd0n1tEC+TfFua7XYxnKiw801k8/NgQcyzcgsKuv7SmbWyKK1IkFTqcY+3pEp0aAytw==
X-Received: by 2002:a81:b28a:0:b0:61b:c89:1e73 with SMTP id 00721157ae682-622b01384b9mr102086057b3.45.1715637715407;
        Mon, 13 May 2024 15:01:55 -0700 (PDT)
Received: from localhost ([2601:344:8301:57f0:8acf:1c06:973:d499])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-622deaa12d1sm8128727b3.1.2024.05.13.15.01.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 May 2024 15:01:55 -0700 (PDT)
From: Yury Norov <yury.norov@gmail.com>
To: linux-kernel@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Anna-Maria Behnsen <anna-maria@linutronix.de>,
	Ben Segall <bsegall@google.com>,
	Daniel Bristot de Oliveira <bristot@redhat.com>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Imran Khan <imran.f.khan@oracle.com>,
	Ingo Molnar <mingo@redhat.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Leonardo Bras <leobras@redhat.com>,
	Mel Gorman <mgorman@suse.de>,
	Peter Zijlstra <peterz@infradead.org>,
	Rik van Riel <riel@surriel.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Tejun Heo <tj@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Valentin Schneider <vschneid@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Waiman Long <longman@redhat.com>,
	Yury Norov <yury.norov@gmail.com>,
	Zefan Li <lizefan.x@bytedance.com>,
	cgroups@vger.kernel.org
Subject: [PATCH 4/6] genirq: optimize irq_do_set_affinity()
Date: Mon, 13 May 2024 15:01:44 -0700
Message-Id: <20240513220146.1461457-5-yury.norov@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240513220146.1461457-1-yury.norov@gmail.com>
References: <20240513220146.1461457-1-yury.norov@gmail.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If mask == desc->irq_common_data.affinity, copying one to another is
useless, and we can just skip it.

Signed-off-by: Yury Norov <yury.norov@gmail.com>
---
 kernel/irq/manage.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/irq/manage.c b/kernel/irq/manage.c
index bf9ae8a8686f..ad9ed9fdf919 100644
--- a/kernel/irq/manage.c
+++ b/kernel/irq/manage.c
@@ -285,7 +285,8 @@ int irq_do_set_affinity(struct irq_data *data, const struct cpumask *mask,
 	switch (ret) {
 	case IRQ_SET_MASK_OK:
 	case IRQ_SET_MASK_OK_DONE:
-		cpumask_copy(desc->irq_common_data.affinity, mask);
+		if (desc->irq_common_data.affinity != mask)
+			cpumask_copy(desc->irq_common_data.affinity, mask);
 		fallthrough;
 	case IRQ_SET_MASK_OK_NOCOPY:
 		irq_validate_effective_affinity(data);
-- 
2.40.1


