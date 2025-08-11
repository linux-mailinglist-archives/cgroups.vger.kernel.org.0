Return-Path: <cgroups+bounces-9073-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D3A3CB21174
	for <lists+cgroups@lfdr.de>; Mon, 11 Aug 2025 18:19:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 526EF1905810
	for <lists+cgroups@lfdr.de>; Mon, 11 Aug 2025 16:13:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C6BB2C21CE;
	Mon, 11 Aug 2025 16:08:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="C+nOk/Fz"
X-Original-To: cgroups@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.2])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC852296BDB;
	Mon, 11 Aug 2025 16:08:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754928523; cv=none; b=uop4vS9bYmXGnksxVTZZxQA3OGJ5jof1XHKQVceMKP6lO2e4sYgELGVe3zFBFcsMpQ+6spDsbb2fKyXVXxZHw7/wq+w+bZjIV0ApCkQyzM01pfB4srNG4y8o3v101l+76s2szV+AVM6vnD8VwnPlkoR1ATgaDcEKUTVYwUHxz0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754928523; c=relaxed/simple;
	bh=iAW1jKNjD0UVSoigxPrR9o3sKwZoev9A1KPjVuJvzAY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=c8+ywQD1eUJuZnIwHhND5MRU/sMe3GTkZnKNc8G+rDiZPvkqngjvN8FD4ItaALPYZB62ZjvKtPOgOySBEYZut9/4w3v7LWsx6uzCpjW3p4c/GvYtVlkt9OSH6e9x12oZkZCxPU5mGZIR4oZwSinZulu1970Cwf3DNYaMuk1zhc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=C+nOk/Fz; arc=none smtp.client-ip=220.197.31.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=iA
	W1jKNjD0UVSoigxPrR9o3sKwZoev9A1KPjVuJvzAY=; b=C+nOk/Fz2j5xcQwo6/
	YUGs7VSVwQuhtfQvBjbSasCUfl4XONEMJV9PyRODOJtEzFsB1iXLQJEn6e0xD8Uj
	CnJWKvvSVqDwB7Vp2cEHEW0kLUWUxcy/vao2Tdi7KssTIYuIj9VPzMf92f/+HTya
	Lm5g4rdCRdYqmq2jRlBiU/2GQ=
Received: from zhaoxin-MS-7E12.. (unknown [])
	by gzga-smtp-mtada-g0-2 (Coremail) with SMTP id _____wDnftqmFJpoiA8xAw--.21078S2;
	Tue, 12 Aug 2025 00:04:55 +0800 (CST)
From: Xin Zhao <jackzxcui1989@163.com>
To: tj@kernel.org,
	hannes@cmpxchg.org,
	mkoutny@suse.com,
	mingo@redhat.com,
	peterz@infradead.org,
	juri.lelli@redhat.com,
	vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com,
	rostedt@goodmis.org,
	bsegall@google.com,
	mgorman@suse.de,
	vschneid@redhat.com,
	will@kernel.org,
	boqun.feng@gmail.com,
	longman@redhat.com,
	bigeasy@linutronix.de,
	clrkwllms@kernel.org
Cc: cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-rt-devel@lists.linux.dev
Subject: Re: [PATCH] sched/cgroup: Lock optimize for cgroup cpu throttle
Date: Tue, 12 Aug 2025 00:04:54 +0800
Message-Id: <20250811160454.884224-1-jackzxcui1989@163.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDnftqmFJpoiA8xAw--.21078S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7WF4DAr4UArW7uF1fGFW7Arb_yoW8GF13pa
	yUJr9I9F4kKF13tw18J3yxZ34Fg3s8GrW3GFy8Jrs0ka1qqryF9F13Kr43ua1xCFZxu3WU
	Xr1Y934DKFnrZaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07j8DGOUUUUU=
X-CM-SenderInfo: pmdfy650fxxiqzyzqiywtou0bp/1tbioxWmCmiaBhczAwABsI

On Mon, 2025-08-11 at 22:18 +0800, Sebastian wrote:

> Yeah, please have a look at:
> https://lore.kernel.org/lkml/20250715071658.267-1-ziqianlu@bytedance.com/


Dear Valentin,

In addition to the information in my previous response to Sebastian, I would
like to add the following point as a reason for my self-recommendation (to
explore my patch for solving the cgroup performance issue in RT-Linux):
RT-Linux is a system that places a high emphasis on real-time performance.
The fact that regular tasks are also included in cgroup groups and throttled
suggests that they are relatively low-priority tasks that are not expected to
interfere with high-priority tasks. Therefore, is it not a bit too late to
impose limits only after returning to user mode? Furthermore, when a throttled
task is awakened from S or D state, according to the logic of "imposing limits
after returning to user mode," it could cause that low-priority task to wake
up associated low-priority tasks one after another, leading to a sudden
increase in running time, which contradicts the relatively precise CPU usage
targets typically required in RT-Linux systems.
Additionally, I believe there are still many areas for improvement in my patch,
and I hope to bring it to the community to gather suggestions from experts to
see if there are areas for iterative improvement.


Thanks
Xin Zhao


