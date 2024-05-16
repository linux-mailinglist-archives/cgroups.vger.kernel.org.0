Return-Path: <cgroups+bounces-2938-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 890848C7D0C
	for <lists+cgroups@lfdr.de>; Thu, 16 May 2024 21:13:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 40E011F25A7C
	for <lists+cgroups@lfdr.de>; Thu, 16 May 2024 19:13:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20E6815B570;
	Thu, 16 May 2024 19:08:33 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E60915B571;
	Thu, 16 May 2024 19:08:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715886513; cv=none; b=JlRCxH0bGJYUZRz6RMbOMCY/WvrSUdn+eHq3qTDLxXpEVZPBTjUpTRNQ+gSguf+ijvt7I0VedMiQiCxdndR5zxJDV/9efOtxVZ9UCD2TfT9WgjQS54Jdx3PKhCHjd2yGJBnsEvY2obNifxi3/AvjHnELa0L/eo619/upLwDlwiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715886513; c=relaxed/simple;
	bh=8kbqqHhC8hqJWztiJ4S0vBrzZ4vEVAmywhl/Drj8bP8=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=U1DVRFsbszru4/RJYwuBXHclx0dxcTm3KpV4OXEjwPh6gpdVG6msW0H+HZvVa8LY2m/2HhsLBpKFMkCTLe/xrPmau49EnmG4RIqiX0r3ZuevlAoOMBqCIStMM+d2OsCcGZERXS6cyiJdt2DNO28vu5N0+eJTs6UxDhuy8LPRXnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-420180b5897so34934195e9.3;
        Thu, 16 May 2024 12:08:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715886510; x=1716491310;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KKc3fp/jI+BvIXedy1D0TYqFMPTw9ko9fdbmFGrVOU8=;
        b=drNowamVeICSyaeTWBAQUoIqHtkZGjREWEdR7cQi4lxBUB5vp8mqHNq+4t8Vv1pYtZ
         GaV5qn1/vN12rQBax6ADaQYaY5oewd1i2nMu1rXjp63ei3NMpWaNpPQqw6kD1hcDX+zj
         o1ECya54JQBs95HzjubTpeaFYYQpVzpUc5Q+raOW9jTuiwBa4ca3uzvj1bqFSXtlPmat
         deNdFVFwPvTnpCfEvemp/eGICtY8kQd4t+jG7KdEb7YPZXjtLGx6o8HPGSvmaQpGqpXs
         WHszNaKnh3geJHY2LGJBPDNkxw1RA0Bz64yJFEeqaBJTtpNr4btIE6+MQ9GQayphDWSv
         XWVw==
X-Forwarded-Encrypted: i=1; AJvYcCV59nIk/Lo9vlRb7WRyQEiaYU/pj2/6RgT9hBoZW0UrwP5LjJLIslEvLP4jmENKkqCem9I8PTLdeYapLPvTtLI9jwi22gYxPFJNqEN2VH+LzBfqeQbSCKs3AYO77vA4QELw2aVYoQ==
X-Gm-Message-State: AOJu0YyFpdClXn4TJXLVAAW6T0Vvu7+LOAQJ7R1pzaAIS+Kjq9YxFsrk
	y8BMCUUHYVTO8hEydGnaLWWhjXlUObbJUn+SZfapbfFAhtmmLNp+
X-Google-Smtp-Source: AGHT+IE+8OzEl7GN/XD1Evd2s20T59JGOPsfzEjJ78E96nJYaDJAN5YoScVDZUfO86b85wduS8T3cQ==
X-Received: by 2002:a05:600c:4a16:b0:41a:5d49:6143 with SMTP id 5b1f17b1804b1-41feaa3873dmr163546945e9.12.1715886509604;
        Thu, 16 May 2024 12:08:29 -0700 (PDT)
Received: from costa-tp.redhat.com ([2a00:a040:1a3:c059:8b18:f13e:da9b:5a8e])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-41fccee9335sm275834155e9.29.2024.05.16.12.08.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 May 2024 12:08:29 -0700 (PDT)
From: Costa Shulyupin <costa.shul@redhat.com>
To: longman@redhat.com,
	pauld@redhat.com,
	juri.lelli@redhat.com,
	prarit@redhat.com,
	vschneid@redhat.com,
	Anna-Maria Behnsen <anna-maria@linutronix.de>,
	Frederic Weisbecker <frederic@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Zefan Li <lizefan.x@bytedance.com>,
	Tejun Heo <tj@kernel.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>,
	Mel Gorman <mgorman@suse.de>,
	Daniel Bristot de Oliveira <bristot@redhat.com>,
	Petr Mladek <pmladek@suse.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Masahiro Yamada <masahiroy@kernel.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Yoann Congal <yoann.congal@smile.fr>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Nhat Pham <nphamcs@gmail.com>,
	Costa Shulyupin <costa.shul@redhat.com>,
	linux-kernel@vger.kernel.org,
	cgroups@vger.kernel.org
Subject: [PATCH v1 5/7] [NOT-FOR-MERGE] test timers affinity adjustment
Date: Thu, 16 May 2024 22:04:35 +0300
Message-ID: <20240516190437.3545310-6-costa.shul@redhat.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240516190437.3545310-1-costa.shul@redhat.com>
References: <20240516190437.3545310-1-costa.shul@redhat.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There must be no timers on the specified cpu
at the end of timers_resettle_from_cpu.

Signed-off-by: Costa Shulyupin <costa.shul@redhat.com>
---
 kernel/time/timer.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/kernel/time/timer.c b/kernel/time/timer.c
index 2d15c0e7b0550..b7d253d230453 100644
--- a/kernel/time/timer.c
+++ b/kernel/time/timer.c
@@ -2658,6 +2658,27 @@ int timers_prepare_cpu(unsigned int cpu)
 	return 0;
 }
 
+static int count_timers(int cpu)
+{
+	struct timer_base *base;
+	int b, v, count = 0;
+
+	for (b = 0; b < NR_BASES; b++) {
+		base = per_cpu_ptr(&timer_bases[b], cpu);
+		raw_spin_lock_irq(&base->lock);
+
+		for (v = 0; v < WHEEL_SIZE; v++) {
+			struct hlist_node *c;
+
+			hlist_for_each(c, base->vectors + v)
+				count++;
+		}
+		raw_spin_unlock_irq(&base->lock);
+	}
+
+	return count;
+}
+
 /**
  * timers_resettle_from_cpu - resettles timers from
  * specified cpu to housekeeping cpus.
@@ -2697,6 +2718,7 @@ void timers_resettle_from_cpu(unsigned int cpu)
 		raw_spin_unlock_irq(&new_base->lock);
 	}
 	local_irq_enable();
+	WARN_ON(count_timers(cpu));
 }
 
 int timers_dead_cpu(unsigned int cpu)
-- 
2.45.0


