Return-Path: <cgroups+bounces-3015-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 277F68D112A
	for <lists+cgroups@lfdr.de>; Tue, 28 May 2024 02:57:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8969B1F21743
	for <lists+cgroups@lfdr.de>; Tue, 28 May 2024 00:57:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01B618827;
	Tue, 28 May 2024 00:56:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JrS9xzYM"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AFEB1C2E;
	Tue, 28 May 2024 00:56:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716857813; cv=none; b=M4RASYVn4UxjqyQTLKgQuK5BvqRvBqbUrAEBMiv904monuTv4HK8RjemoOeEGpwG2M53ktvIkG0OxY1V/36QHPIfA4pkbUSp2a/W8SjQUWEZxy1pQIEsoEKFwAg01nyhcxdlyWCUKtRHJ6R35KRYhsLJ88/TWFpjLXCYoAeMuxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716857813; c=relaxed/simple;
	bh=VIByQsRIRWXyiavO0JopjOwT9I3BGWmXRDeKDW0vxaE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=sun5kcXPkTPMi8JwupydPuMs/WHVVSbdHES6+t4rENZ2w+2ZxSEsld8+vd+eHgxGUNDKzZGMGhmtMbV45ExqhxZ+0hzkohrYmgAXt/nBpq6HjeRRy+OrTSc/Y69XVBJ/qDhofeoHP456f2mrzFejyZAM2VwCz1LnMJZOOnRaoNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JrS9xzYM; arc=none smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-627ebbefd85so2861187b3.3;
        Mon, 27 May 2024 17:56:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716857811; x=1717462611; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5Ez0J0qtAkKq9DhtNvT58fIFshyeGP2st4dotGSlOno=;
        b=JrS9xzYMzyRDBwIWQwT+K9C8NajlO5du6VfXZBSreZrgJKWhKWr1JzLQbu3oy52xS0
         hBxN2XJLle2wz1ZCno8A16uk6q5GIgdIMle62v44H9ufDduY2K8HWNhzORehZUKrgPq1
         l9ElMJpGgjIrlDM4PgYcpnmURz93TEhBSFYOKVSptwubft2CHuekrgFQ2S9truGv+AiV
         ipsGuY0s5zZQnSCP1xVxgcz98TC+T5Kl5MG4AegkF2ShXXEiOB7rZn8C19DKdmRu92zH
         O6s+IsmJl7/8VmUtPpQMgiGf60tXK7Z8OHnK8j7HRmI9JZrqcNyVU40nizW3gR0F2g1l
         CYfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716857811; x=1717462611;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5Ez0J0qtAkKq9DhtNvT58fIFshyeGP2st4dotGSlOno=;
        b=rfcP3JmwKT1qZLrXyts4sGQlqfbCw8i/XmylQcfzzV0a2gxKRiZnihKwrraCkAECuM
         2s3OWqqbSHOE8hwXKGS4B5HSBEYVH8QjdUoBn+q7gTGxot7iShyN5fMw52eXi/5Bc8P7
         v+HIG1WiTG707KY2SlvQAxZ6Nx2GCsLwSO5ZpM5qwXvgoWjpExH7eD7W3xqRC60XgEmF
         TcAkTZe2mzEq0mwRonlKwvHWieHTSMbnn1evoit2kprOdcFUnwyWW3H3+dWDiRSuzF2s
         7XhVyLLU0+oOUPAIhhjh+g0hwNJiOfuzzzafgBvncndXFbqqnIUyMhrsvzpHYUxxJ+oQ
         +RAA==
X-Forwarded-Encrypted: i=1; AJvYcCXyBB1VQWa8aW8QbL2E+j6f/5t8bx+hJ1W+fHVcIEGa6N3jJMUTsSm67Q4JKnUf33+AGeQ2MQqyqseTfua3O7hQ+vqu57Prd8MzmQYgXg4DrjQ4PZk3Cj8uc0EU8Zc1A5hrutIgF63+JRRXa5UJFmZNn5Gv0Wmz8ZoevCWQ6PFcZQ==
X-Gm-Message-State: AOJu0Yx6oQLKj67/PaXLBzAX+wnzt4BHudhP8gt4xCSRqoNLk+jhpOYg
	r1sYCO3+HX5NWKvwV1j4NRidRlCEA1HcF3Sk0NQBC2XSDFho/x1lldGr+w==
X-Google-Smtp-Source: AGHT+IFtIWzXOyFRH+mmAemFEAEjq0S6YTXWPFy1QE68aOtKfOPGRU/J566TydAC2cqpZmcJMXliyQ==
X-Received: by 2002:a0d:e897:0:b0:61a:f59a:c1b5 with SMTP id 00721157ae682-62a08db6ef6mr107669807b3.23.1716857810435;
        Mon, 27 May 2024 17:56:50 -0700 (PDT)
Received: from localhost ([2601:344:8301:57f0:35f3:16c3:302:8fdb])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-62a0a3bf743sm18245997b3.40.2024.05.27.17.56.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 May 2024 17:56:49 -0700 (PDT)
From: Yury Norov <yury.norov@gmail.com>
To: linux-kernel@vger.kernel.org,
	cgroups@vger.kernel.org,
	linux-mm@kvack.org,
	rcu@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Cc: Yury Norov <yury.norov@gmail.com>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Amit Daniel Kachhap <amit.kachhap@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Anna-Maria Behnsen <anna-maria@linutronix.de>,
	Christoph Lameter <cl@linux.com>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Dennis Zhou <dennis@kernel.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Kees Cook <keescook@chromium.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Tejun Heo <tj@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Zefan Li <lizefan.x@bytedance.com>
Subject: [PATCH 0/6] Cleanup cpumask.h inclusion in core headers
Date: Mon, 27 May 2024 17:56:42 -0700
Message-Id: <20240528005648.182376-1-yury.norov@gmail.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Many core headers include linux/cpumask.h for nothing, and some others
include it just for types. We already have nodemask_types.h, and this
series adds cpumask_types.h to optimize core headers inclusion paths.

Interestingly, it doesn't improve on build time for me, but the headers
cleanup work should keep going.

Yury Norov (6):
  MAINTAINERS: add linux/nodemask_types.h to BITMAP API
  sched: pre-caculate ilog2(TASK_REPORT_MAX)
  cpumask: split out include/linux/cpumask_types.h
  sched: drop dependency on cpumask.h
  cpumask: cleanup core headers inclusion
  cpumask: make core headers including cpumask_types.h where possible

Yury Norov (6):
  MAINTAINERS: add linux/nodemask_types.h to BITMAP API
  sched: pre-caculate ilog2(TASK_REPORT_MAX)
  cpumask: split out include/linux/cpumask_types.h
  sched: drop dependency on cpumask.h
  cpumask: cleanup core headers inclusion
  cpumask: make core headers including cpumask_types.h where possible

 MAINTAINERS                                  |  2 +
 include/linux/cacheinfo.h                    |  2 +-
 include/linux/cgroup.h                       |  1 -
 include/linux/clockchips.h                   |  2 +-
 include/linux/cpu.h                          |  1 -
 include/linux/cpu_cooling.h                  |  1 -
 include/linux/cpu_rmap.h                     |  2 +-
 include/linux/cpumask.h                      | 56 +----------------
 include/linux/cpumask_types.h                | 66 ++++++++++++++++++++
 include/linux/interrupt.h                    |  2 +-
 include/linux/irqchip/irq-partition-percpu.h |  2 +-
 include/linux/kernel_stat.h                  |  1 -
 include/linux/msi.h                          |  2 +-
 include/linux/node.h                         |  1 -
 include/linux/percpu.h                       |  1 -
 include/linux/pm_domain.h                    |  2 +-
 include/linux/profile.h                      |  1 -
 include/linux/rcupdate.h                     |  1 -
 include/linux/sched.h                        |  7 ++-
 include/linux/seq_file.h                     |  1 -
 include/linux/stop_machine.h                 |  2 +-
 include/linux/torture.h                      |  2 +-
 include/linux/tracepoint.h                   |  1 -
 include/linux/workqueue.h                    |  2 +-
 24 files changed, 83 insertions(+), 78 deletions(-)
 create mode 100644 include/linux/cpumask_types.h

-- 
2.40.1


