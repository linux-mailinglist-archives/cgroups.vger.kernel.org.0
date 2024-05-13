Return-Path: <cgroups+bounces-2868-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 141CA8C4966
	for <lists+cgroups@lfdr.de>; Tue, 14 May 2024 00:02:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9D7421F21C8F
	for <lists+cgroups@lfdr.de>; Mon, 13 May 2024 22:02:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07A9584D22;
	Mon, 13 May 2024 22:01:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QUd+97EZ"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FADD84A4D;
	Mon, 13 May 2024 22:01:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715637714; cv=none; b=YxKlz4rNEa8xWWQdCBgFHHxAyI+d+lF95WxKItdlkADaQ7SjDyuw72JT0G0vBcrvUqCzPamUr5eEO6H3MuaYTquVpXRIlw5/TRW0yDopPwV52R7vNxKjzw94rC0wt7j1Qvs497n6T4Ru4lBtNfgNn9IUh1b/d69ICFTRogxmSoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715637714; c=relaxed/simple;
	bh=XTEmg/hS44058q8iEC2rDiZ6UxIXdT7is3pHwul7Rbc=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=CKHW06H6ZteBawkxOaQq7mgtIbxJ8qeyod7i8AZ9kSoRt+MocqN4ilZBX9rXgcDe2pJrmxD51JLK4TjvkzzRQAKyz6YKbPjYmBuAYR15YcnhOHLruAd9rjM0NOFtm9ibsKSKy25/6AFheeLXsMb8FnKFHjFD4BBwY8ItuyKS/dQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QUd+97EZ; arc=none smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-62036051972so54620657b3.1;
        Mon, 13 May 2024 15:01:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715637712; x=1716242512; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6JSD1LqLj1PrAOr7CV2jbwc/Cer/cuXBqiOk+ZKJvmI=;
        b=QUd+97EZzoMSeHzZjdCt2CXstuKRk7H3F/3UwkdQG3pane+yJ81kkOsgM6C2tUDJAx
         wlUrqwY8U0OmV4QaJDHSbYrUWAf5m0MVBSU6eWQkYOoKzp2hmeZOG6k0Oea985ZgU+2R
         Eg5xCCyif/sAruX12wKhwm9YB6xRVHO7IkOzl9wrotfaND6C9a8lZ1CdcLgavID5WinO
         U2rHX6e0Xn3CUTm2N5bbGR2x+FqEXV4g39egTBbBFh9ijogNfJ0R/7sfVrQq/MoTx2z5
         vf1wsf6eC5N7GlhAabchAmyWFXSuLIZib35iy8HmMAGW2w+M3+WEsugMXh9hu1xSo6Wy
         llQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715637712; x=1716242512;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6JSD1LqLj1PrAOr7CV2jbwc/Cer/cuXBqiOk+ZKJvmI=;
        b=Bk8LirZF3mr9vMLvtdX4Tn1HbKRakhYzSIp6zqg8tXUhSfiUryxcc6OhzB9U4gZUNS
         gFSRZiEmA1aYRdRISskXQQpRi/+FXCAThKtt1SonQhNw0jsDD/TuDdndVCNdp/8JUafD
         2nJcSZ14NuvC+ZtJsqrol1SomOsKIZjVwEr1i2snljY2G7A6RzI7vwUN3s5XVxcbbFZ/
         WQKxolUyiaeHzUdoA5AK4OBw4hczrwpT70D2Ro3b6rIfOxR+ajEOjFBT5i4benT5yzTL
         8vydU4k8S03dFWgxWcJ1oUs/B1Rvy4MjEiX1jV7Q/UuoihtB8Oq8z9LY9CzPKOnaa0mH
         T8Fg==
X-Forwarded-Encrypted: i=1; AJvYcCWK1R7cc4x8vNd/pnlQ1QvMYbPA6+11bRA55hIVanwZjv81Zcpl2v1f2hBL5n3FISga4w1xRpmOpYFGklvDe8IW3gsiaZCqKQ==
X-Gm-Message-State: AOJu0YyPf/rn30fR+TdgglT6d3++HSpl1YhCz0KuIUX4UCzchAUC7dTe
	52WCANdo4frfog4JJ+RoPF6QKnsM47QSrmLUbJl7MfRkYXdw9YBVbxCNbg==
X-Google-Smtp-Source: AGHT+IHRHqyk9rRM0s7TQp3eahYHF4FDbebo43yfOmqOHVr2s/mv3LjffLHBsZfVOUFR/96ZeEUOGQ==
X-Received: by 2002:a05:690c:6610:b0:618:91a0:70f with SMTP id 00721157ae682-622affa592bmr124005737b3.6.1715637711467;
        Mon, 13 May 2024 15:01:51 -0700 (PDT)
Received: from localhost ([2601:344:8301:57f0:8acf:1c06:973:d499])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6209e37952csm23253027b3.118.2024.05.13.15.01.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 May 2024 15:01:51 -0700 (PDT)
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
Subject: [PATCH 1/6] smp: optimize smp_call_function_many_cond()
Date: Mon, 13 May 2024 15:01:41 -0700
Message-Id: <20240513220146.1461457-2-yury.norov@gmail.com>
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

The function may be called with mask == cpu_online_mask, and in this
case we can use a cheaper cpumask_cooy() instead of cpumask_and().

Signed-off-by: Yury Norov <yury.norov@gmail.com>
---
 kernel/smp.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/kernel/smp.c b/kernel/smp.c
index f085ebcdf9e7..6f41214a1b54 100644
--- a/kernel/smp.c
+++ b/kernel/smp.c
@@ -798,7 +798,10 @@ static void smp_call_function_many_cond(const struct cpumask *mask,
 
 	if (run_remote) {
 		cfd = this_cpu_ptr(&cfd_data);
-		cpumask_and(cfd->cpumask, mask, cpu_online_mask);
+		if (mask == cpu_online_mask)
+			cpumask_copy(cfd->cpumask, mask);
+		else
+			cpumask_and(cfd->cpumask, mask, cpu_online_mask);
 		__cpumask_clear_cpu(this_cpu, cfd->cpumask);
 
 		cpumask_clear(cfd->cpumask_ipi);
-- 
2.40.1


