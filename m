Return-Path: <cgroups+bounces-2870-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 892A58C496A
	for <lists+cgroups@lfdr.de>; Tue, 14 May 2024 00:02:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3EC0D1F222F4
	for <lists+cgroups@lfdr.de>; Mon, 13 May 2024 22:02:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8221884FD0;
	Mon, 13 May 2024 22:01:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fgkOXsmu"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBE8484D1F;
	Mon, 13 May 2024 22:01:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715637716; cv=none; b=kR8ZL5fFAZBNdIiUsPZuCK++fYwDarQTjKe7NBrHrE1DI8zyHznebkdPY140n6OA+ohiMNXOBTzyHmA6Q/0l9YMoDXqCyVSR97GPqKvDZ5r4/wjrVBPG4dOTTAPKybdrI2kDNmK2VLhV+4Ax4qTxs8SQKjufzjyCswpcrhwiFT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715637716; c=relaxed/simple;
	bh=nBiBy7FlXCP7ujfPp1uf/LyH0qpEqlY9Ed0LVQjJiMU=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=RQ94WOwZa4B9JWxUxHPldmvVt6P7a03XxeSaj4c5TvY8iobcBVwuVB1KIPph8C/POd8DkPogQK5K0pcBTcakTjSTzT7/aYl21aUyZRT9VQ2EPi/j1rPbFvbzCiy+40jRj2KQ1uFhLFIq3ZaPQI/fy76OibPGk76ZWdjhlYRm76Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fgkOXsmu; arc=none smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-61b4cbb8834so48983297b3.0;
        Mon, 13 May 2024 15:01:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715637714; x=1716242514; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sIyxYS7w9O3sylA6Ofcy5e++wtKWaDEMHTTKe4epeVg=;
        b=fgkOXsmuvanS29tLpuMeqsJfz60j+2Q81idGah+LKZzBBGrvvnnGexIfXoJRmWds7d
         5LANExxwMseQStus39sby7goISBCNKqEn10Mj8IMsc6icfqyHIeTOn+WS0vB7AQEUEk9
         kDzESwpEKV3+64nKxAnd298U0B+t1VbOchh2Ouy/Xs/ePGgIXLrQfWoWlKc7zBg1CWpZ
         fZYbCFYS2IWarMym5YKBZVzNn5D/q0osD48R0RZJRUVvP1E5pM9LMCz3VKnKWTQ9IV2/
         rmS2izcCJ2o1Kalmq5W3Cr0kAsGGNGnewgqwFQzJIVKCQf7ZxckTaSrpcATscCq4bNck
         FZyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715637714; x=1716242514;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sIyxYS7w9O3sylA6Ofcy5e++wtKWaDEMHTTKe4epeVg=;
        b=Ef2B98MmboN02JXF0xBb0ESLjnl1COVSUdD0ATNrGnUluwbK0Kpk8Rt7gZ8bAWnmo1
         QgBCl32Nu4NMwVaCkVEGB6daDMP8Oe0I2cYOtdDwsvdReoIxAQW82ib/OhmBIGwL1HYP
         XJkpF+gtO2c6YA91UXHHc/o54gy0uCRLvu5ZAyuz/qE9b8CTWdfY9BMMYtpmo0avHTVm
         pnVO4hXx6txwMRmdN605sXKIg6Pb+o34NbMbG/e41behtT2TQfbyjEUVSK9i0pZSeC75
         Bqll21XGYLoO/kRfLu8a5DK1ONueAD9WKaIRRQCL6Ki/NN3kUatZACLSA+Ruq46dLLDK
         sZ7Q==
X-Forwarded-Encrypted: i=1; AJvYcCUXkvdtgryADSxjmF8eZWv8xu4dqqFb47exPPJKNh36dQogzH2r8hXu7YXNYlwnhiA68sjNv4L5cPSR3VvuQTRagNfUObNMVA==
X-Gm-Message-State: AOJu0YyAZ9Ujp2FlNjDro83WzTuyEEQTJ8lEy7/znSANUJos+vmx76Lm
	ZnLXWgO8uXbEHUFGHAbhseZ6d5xrPdHru6d7kci89W3Ajetl6d1cLY9anw==
X-Google-Smtp-Source: AGHT+IGIzVWatliUFBuHHJNBpX3gRYcxQpUGm9gJHfvw7WbY7OPk4ckhZ+rdP4c6stCKSMlTQJDSng==
X-Received: by 2002:a05:690c:f87:b0:61b:1e81:4f65 with SMTP id 00721157ae682-622afd979demr130974687b3.0.1715637713803;
        Mon, 13 May 2024 15:01:53 -0700 (PDT)
Received: from localhost ([2601:344:8301:57f0:8acf:1c06:973:d499])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6209e349e0csm22824797b3.79.2024.05.13.15.01.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 May 2024 15:01:53 -0700 (PDT)
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
Subject: [PATCH 3/6] driver core: cpu: optimize print_cpus_isolated()
Date: Mon, 13 May 2024 15:01:43 -0700
Message-Id: <20240513220146.1461457-4-yury.norov@gmail.com>
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

The function may be called with housekeeping_cpumask == cpu_possible_mask,
and in such case the 'isolated' cpumask would be just empty.

We can call cpumask_clear() in that case, and save CPU cycles.

Signed-off-by: Yury Norov <yury.norov@gmail.com>
---
 drivers/base/cpu.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/base/cpu.c b/drivers/base/cpu.c
index 56fba44ba391..1322957286dd 100644
--- a/drivers/base/cpu.c
+++ b/drivers/base/cpu.c
@@ -282,8 +282,10 @@ static ssize_t print_cpus_isolated(struct device *dev,
 	if (!alloc_cpumask_var(&isolated, GFP_KERNEL))
 		return -ENOMEM;
 
-	cpumask_andnot(isolated, cpu_possible_mask,
-		       housekeeping_cpumask(HK_TYPE_DOMAIN));
+	if (cpu_possible_mask != housekeeping_cpumask(HK_TYPE_DOMAIN))
+		cpumask_andnot(isolated, cpu_possible_mask, housekeeping_cpumask(HK_TYPE_DOMAIN));
+	else
+		cpumask_clear(isolated);
 	len = sysfs_emit(buf, "%*pbl\n", cpumask_pr_args(isolated));
 
 	free_cpumask_var(isolated);
-- 
2.40.1


