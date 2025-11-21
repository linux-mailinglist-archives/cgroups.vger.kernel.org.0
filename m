Return-Path: <cgroups+bounces-12155-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 45E75C7A43E
	for <lists+cgroups@lfdr.de>; Fri, 21 Nov 2025 15:47:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id E87CE35F305
	for <lists+cgroups@lfdr.de>; Fri, 21 Nov 2025 14:38:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AC4A34D92F;
	Fri, 21 Nov 2025 14:35:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="muQXtMDO"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5DFC34CFD1;
	Fri, 21 Nov 2025 14:35:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763735708; cv=none; b=t8AVxU5NB+245E1rIDvwUuJHRnS7FhmYeAO6/3BzcDRxX1GL4JcC9grWCUnKwheXorO0CoQoXp6EZrUH53tG3mihhT93U4ysMNgCF7AffvpFBTUkvTfGQUhJnXM+Scl2/hPBKkejELtSD9t4Yuy69ZAetmR48pOtmF4ro6HSeGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763735708; c=relaxed/simple;
	bh=QDb2eatKiuZjTbqzmxGKoL+jm2p5mamd0Yx60gDcOd0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=i+DRSitsr9uAei/LG/xNnrgBdSN7nCO1CW89UyueVNznUV7rtFVGjEybpvkn9XptmqhBHYt1Ws8fn3+MO01yj4zR2QldsbX3sTZkiedzUTOy1MTatqTlBd5bpgJzMVbUlNCZSNU5Af+qRYwJnAxv0J/ENAL/N3MO49EfqvU7HhI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=muQXtMDO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9839DC4CEF1;
	Fri, 21 Nov 2025 14:35:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763735708;
	bh=QDb2eatKiuZjTbqzmxGKoL+jm2p5mamd0Yx60gDcOd0=;
	h=From:To:Cc:Subject:Date:From;
	b=muQXtMDOImC7QQPxGRYlwqz0wN+NyVC7xucpyRYbMTi1tclW0TFl3MjodqKhKDO/B
	 GR483G4Y/jMINYj3+cFXoDXYvCJ4GYWREDpgNtV616WrOV0wthW/6IzZ42rCfuehe0
	 Ea0/R5MxArXYEu4DbRr4lYeQhGlIn58G0SZIXIutg59u7YGPNj/vo82mKF1qEbFn7W
	 LG8N8jQVB5p0yf7PMpwxYM4s0ARrYJ5Z1PPSixYjaYC9T4f+PRz/Bdarzjr7d8A5Xa
	 gAA8Ywov1HFoA29PQbUQafBxiVM4FGeysKJ4rZ5oZEi876rkivLMJ/sGgmcD4zA6nN
	 KcYQ+tetooS5g==
From: Frederic Weisbecker <frederic@kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: LKML <linux-kernel@vger.kernel.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Marco Crivellari <marco.crivellari@suse.com>,
	Waiman Long <llong@redhat.com>,
	cgroups@vger.kernel.org
Subject: [PATCH 0/3 v3] genirq: Fix IRQ threads VS cpuset
Date: Fri, 21 Nov 2025 15:34:57 +0100
Message-ID: <20251121143500.42111-1-frederic@kernel.org>
X-Mailer: git-send-email 2.51.1
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

Here is another take after some last minutes issues reported by
Marek Szyprowski <m.szyprowski@samsung.com>:

https://lore.kernel.org/all/73356b5f-ab5c-4e9e-b57f-b80981c35998@samsung.com/


Changes since v2:

* Fix early spurious IRQ thread wake-up (to be SOB'ed by Thomas)

* Instead of applying the affinity remotely, set PF_NO_SETAFFINITY
  early, right after kthread creation, and wait for the thread to
  apply the affinity by itself. This is to prevent from early wake-up
  to mess up with kthread_bind_mask(), as reported by
  Marek Szyprowski <m.szyprowski@samsung.com>

Frederic Weisbecker (2):
  genirq: Fix interrupt threads affinity vs. cpuset isolated partitions
  genirq: Remove cpumask availability check on kthread affinity setting

Thomas Gleixner (1):
  genirq: Prevent from early irq thread spurious wake-ups

 kernel/irq/handle.c | 10 +++++++++-
 kernel/irq/manage.c | 40 +++++++++++++++++++---------------------
 2 files changed, 28 insertions(+), 22 deletions(-)

-- 
2.51.1


