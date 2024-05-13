Return-Path: <cgroups+bounces-2869-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CF9FD8C4967
	for <lists+cgroups@lfdr.de>; Tue, 14 May 2024 00:02:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F37331C20A02
	for <lists+cgroups@lfdr.de>; Mon, 13 May 2024 22:02:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4ECE284D3E;
	Mon, 13 May 2024 22:01:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PUtoSZLA"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF5BF84A56;
	Mon, 13 May 2024 22:01:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715637715; cv=none; b=ffxFYYRdlpfE0CjzvoI7IBPvkzW427d5a/XFZHMVcDuzZbdvux+XjbFIfehNVq0ffMSol7Dc6nsn3XMh07zKTkBGv6kgvba/p/E4yfBbVuLPHVh9av1/TVHNhnCqkkk/cLZzbQLMy8hxsIbyzOxaj5vjB4DlDjU3RzNEZn0UXYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715637715; c=relaxed/simple;
	bh=ZhkiaUtTBV4sSkcaAXAYusiHCrJIwiwNrjA2rNBwfck=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jdItl3mV8Jts6fAlUhe5xO4VUPCcxyomwgp4p1wJKSzOK0RD9/1IdKNz5bohSC6NUDvj3LeeGhVkh0ddCEO4RkdnYloTbSzMXZDvQUtaHplwciEuOJBEcqrv8kSVY5sdNi2i6U9ftYDBMgt6/0wQfMVrGkiK4KzV7xzj3mkdeHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PUtoSZLA; arc=none smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-61804067da0so48870907b3.0;
        Mon, 13 May 2024 15:01:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715637713; x=1716242513; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NZpiVbm0k8/V4I8fmDlOntjijimOcwopvoeWS8JbgE0=;
        b=PUtoSZLAgciRxD9erhbo4ARDe4deox+nvpOv99jbeSnQa7q2yvRMjnJNn9Vbb9pV70
         o/A1i8UqAAkQFruOZBejjabefv2GrhWRDqppeyu6bj6JS4B7/4OkTRG+/ieMYaMWAGxa
         x0c2G3X+dq8OUGYmcR5Qu3v+MPReytHD8zHPqKr567+VqgSeegDCPoCZITzCIMZ3sQXH
         hKR72b7oUJ/nP0+ARl3iDaxKVyFn7SCs4gLIZm4/7rTqipDb1nbp6nuIEGei+8Le2rUI
         i81ByL63mA/kIw34IJpNwR/GxA7Rf7HATEln6uXi4QLMeMYmOrwzc/UHvuw6UB/2o+kz
         BZ0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715637713; x=1716242513;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NZpiVbm0k8/V4I8fmDlOntjijimOcwopvoeWS8JbgE0=;
        b=Vuq/3s7koz43LxW03J9k3WkFLMQzHc3FcOTI/55l5SXeUzhMTf7npnwhpKWj0E9A9E
         ybgjRaSYc0B6aLJ6s+PFYvCMMp9PFk/nlkKbyfJZJfdNsyZOa35RMQzRUtBoMix8OV9D
         c20Jx1RdBfMEtdE//Wnrk/oRy+KzFB4r7Vpqij3Mc/+FKCgkEen1jnyS0OeKXgXX/Un6
         uVvW+6iplcVau4tCD6S0bGQkOFfyfHAWimRUv+CbM8gV5wGyRQlZQYVfsWxf8DyN/tfz
         yLYPlsaQW0CoxqlfWhdTK+aMFR++W8z1KU8jKpSbHPDBF5FeuwJGDhxLk8pV9Mz8ax1K
         qRyQ==
X-Forwarded-Encrypted: i=1; AJvYcCXRkyMBe83KfswZAQvEFMi3XdWA75QK8BoBazyWgvIxaGeefGw0X8m9CC5qHKFwcFnvFL1UmI92FHHp0J6Rzj9ZbfA+c7ppuw==
X-Gm-Message-State: AOJu0YwTvJk8zuDIQGimlrzIqdufxEW7d6kC1xGpDzbZk027JGDSB4Hr
	6oiFT+wYFkGbnGurcSueiFxGTG14f2ErzReXpLDaEOTlwqjDJd+2useDOQ==
X-Google-Smtp-Source: AGHT+IEhYN4ZsuHX2byEJ9sT5z885Oyk0iNtbYYvNmB6wxwnp779Didkj9Qgnu/TBaDFEJFvd6J9yw==
X-Received: by 2002:a0d:d652:0:b0:61b:11d5:a675 with SMTP id 00721157ae682-622afff6ad2mr107541507b3.32.1715637712670;
        Mon, 13 May 2024 15:01:52 -0700 (PDT)
Received: from localhost ([2601:344:8301:57f0:8acf:1c06:973:d499])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-622cd7e0117sm11902287b3.44.2024.05.13.15.01.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 May 2024 15:01:52 -0700 (PDT)
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
Subject: [PATCH 2/6] sched/topology: optimize topology_span_sane()
Date: Mon, 13 May 2024 15:01:42 -0700
Message-Id: <20240513220146.1461457-3-yury.norov@gmail.com>
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

The function may call cpumask_equal with tl->mask(cpu) == tl->mask(i),
even though cpu != i. In such case, cpumask_equal() would always return
true, and we can proceed to the next CPU immediately.

Signed-off-by: Yury Norov <yury.norov@gmail.com>
---
 kernel/sched/topology.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
index 99ea5986038c..eb9eb17b0efa 100644
--- a/kernel/sched/topology.c
+++ b/kernel/sched/topology.c
@@ -2360,7 +2360,7 @@ static bool topology_span_sane(struct sched_domain_topology_level *tl,
 	 * breaks the linking done for an earlier span.
 	 */
 	for_each_cpu(i, cpu_map) {
-		if (i == cpu)
+		if (i == cpu || tl->mask(cpu) == tl->mask(i))
 			continue;
 		/*
 		 * We should 'and' all those masks with 'cpu_map' to exactly
-- 
2.40.1


