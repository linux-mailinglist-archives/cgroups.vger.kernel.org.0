Return-Path: <cgroups+bounces-2867-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DD17E8C4963
	for <lists+cgroups@lfdr.de>; Tue, 14 May 2024 00:02:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7CF61B21F12
	for <lists+cgroups@lfdr.de>; Mon, 13 May 2024 22:01:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A03284A3B;
	Mon, 13 May 2024 22:01:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iurPFvht"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com [209.85.219.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D15D80BE3;
	Mon, 13 May 2024 22:01:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715637712; cv=none; b=Awz00lgnXB6CXaNOq8X+ApioXaobFFHtXQHcnP5A9H3cSqi2Q1O6NQgG2FyI2ykEOALLInElf6TiNZOkhzbUHhJq0MaMbCk3iyg8LAj3gbG2EV4+BKLhqcgk1F9Te6e48jesXtRuNC08nYV4xRdrr+21+xzjH1sigOW4wYRQ/0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715637712; c=relaxed/simple;
	bh=guA8g8HaYSnOistMlA7TemRmnYV5t9q8Z+s7R5rSpak=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=OhGpfAt5YkuKWr7f69HxRR9xAEKx9ra7dviCw7yJskO15gVUA98TC6lFWI0zD23f8h8wogXTrOT5nizP3l/6IBLdFk/lxDP0I8eTWGSJEUqgbFdG/ZpgYjU1wb5P1r1kW6ZHw2LYgxYJiu2iktMT6AA0fj+9YwZ3hyGRBchiMP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iurPFvht; arc=none smtp.client-ip=209.85.219.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f182.google.com with SMTP id 3f1490d57ef6-de60380c04aso5704872276.2;
        Mon, 13 May 2024 15:01:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715637710; x=1716242510; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=b/VCh3W/ZSLasS/pjZvoVa1636YXQlNvUWBji/mvBKw=;
        b=iurPFvhtJ07bE+rSRyCDzU7ZUYO8kKZvOaLuMmWmkJ5xCUhKkFFnAf6zePNPznstcM
         eNXcLA5XNdYM5sEqqyvUhcFzJifHCfSbpZ/ElUcq2EDy8JjqMvc79K8BqcZx+F4VcJrw
         sUo0ft8w9AjMeczUDzw3LGNmyGdhLUgTVTNbz7YSAGxO9Qv1dyy96wz3LXyt7i1Q4cZ6
         uqzChcAzOHXTug8b/V8Q9kec1tI7kaoiK0nCOmbBWegoS6bGSYJYJCBHw/eRuQPVRSR6
         yZp4Jf17lGXMz3RRZN3PTXE+a6Us7IgdaCWtSfYOcJPgISup7JN6WdZvkd8i4uCbgpaL
         Kdng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715637710; x=1716242510;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=b/VCh3W/ZSLasS/pjZvoVa1636YXQlNvUWBji/mvBKw=;
        b=WfNoPtMY/e3XtBVtAd7U6TYjF63gg5Ze2A27R3dZS8ZSTy2+i7+onhE7F0Z6NeWFf/
         8VQs9QfJTFEG9A6FhXl7F2pCANIcs9FSaNCy0j9rw1HzGAGWYegKgUsqhd+uw0Xhe/pY
         LCpX/Ow7gBJrgr3PJ6YozQB58VBHILzF6IucunS4HZU5E/vtXwLJXU5IJNVEP7c0V6Ov
         jOq1yxaRRPuZ6oNMIO8cCcLjxoTKqcxuUXik4oQVRdatT6WU0JSmhwy674bpAtExcONC
         0zZW948CLJUd0Bx8AD4lrlwsCXjnznljrROZHyoXZRLEy9UnkzztVf9Gm2d8bCABmO60
         tEMg==
X-Forwarded-Encrypted: i=1; AJvYcCXg10qL5ytcBwBLJT2OfRHaPU19EuDPxBeQruf9nvQyB4YAWzfLgI/TnGnwGqNcKthaKjWedrLMYF38DsPauglvnF0se61myQ==
X-Gm-Message-State: AOJu0YyPpR8YeOFgVPaEqaXwkfplPhKNms49uztQ9mGd4MR+NvWLzenB
	yvgIf72BRWIB2NU4MsP3R2pBDdSFN/fbCktrbC8kfnlG3xFek9BeafKOKw==
X-Google-Smtp-Source: AGHT+IFYqA9z8INV0+yGdSoafJUE2EK9GbwTLS2CNHKCsfX4PC50CmH3RTa8Hz97mmt97mjIjVBvgw==
X-Received: by 2002:a25:ace7:0:b0:ddd:696a:8656 with SMTP id 3f1490d57ef6-dee4f355d8emr10633973276.41.1715637710252;
        Mon, 13 May 2024 15:01:50 -0700 (PDT)
Received: from localhost ([2601:344:8301:57f0:8acf:1c06:973:d499])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-debd371389esm2312559276.8.2024.05.13.15.01.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 May 2024 15:01:49 -0700 (PDT)
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
Subject: [PATCH 0/6] bitmap: optimize API usage
Date: Mon, 13 May 2024 15:01:40 -0700
Message-Id: <20240513220146.1461457-1-yury.norov@gmail.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In a few places bitmap API is called with such a combination of
parameters that makes the call unneeded, or there's a trivial cheaper
alternative.

For example, cpumask_copy(dst, src) where dst == src is simply a no-op.
This series addresses such cases spotted on x86_64 with LTP.

All the patches are independent and may be applied separately in
corresponding subsystems. Or I can take them in bitmap branch, if it's
more convenient.

Yury Norov (6):
  smp: optimize smp_call_function_many_cond()
  sched/topology: optimize topology_span_sane()
  driver core: cpu: optimize print_cpus_isolated()
  genirq: optimze irq_do_set_affinity()
  cgroup/cpuset: optimize cpuset_mems_allowed_intersects()
  tick/common: optimize cpumask_equal() usage

 drivers/base/cpu.c        |  6 ++++--
 kernel/cgroup/cpuset.c    |  3 +++
 kernel/irq/manage.c       |  3 ++-
 kernel/sched/topology.c   |  2 +-
 kernel/smp.c              |  5 ++++-
 kernel/time/tick-common.c | 15 +++++++++++----
 6 files changed, 25 insertions(+), 9 deletions(-)

-- 
2.40.1


