Return-Path: <cgroups+bounces-204-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 48CDE7E2F95
	for <lists+cgroups@lfdr.de>; Mon,  6 Nov 2023 23:09:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 793E41C209A0
	for <lists+cgroups@lfdr.de>; Mon,  6 Nov 2023 22:09:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BA3E2EB09;
	Mon,  6 Nov 2023 22:09:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="SbKYPCgK"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1C2030CE2;
	Mon,  6 Nov 2023 22:09:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8C18C433C8;
	Mon,  6 Nov 2023 22:09:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1699308575;
	bh=IYP87mPslCnQl/9LQiXvTbko+eNuU/TJe/cJTwCnwiU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=SbKYPCgKGr9KACWJJS6bLYB/tEMKq+JVzVmgV5457dZ5/4owurxJXB9SOlDerCIrE
	 MF8DZWFbn5ggyJ/fnlUm6AZ6zPnZacX3M1oa0z7Q2W4l8PKgioBAX8YcaQSE1rLhF/
	 Pn5nzm0L9CpSMuvj/QZXPVeRgwlDqmEaT43OH4Qc=
Date: Mon, 6 Nov 2023 14:09:34 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Dmitry Rokosov <ddrokosov@salutedevices.com>
Cc: <hannes@cmpxchg.org>, <mhocko@kernel.org>, <roman.gushchin@linux.dev>,
 <shakeelb@google.com>, <muchun.song@linux.dev>, <kernel@sberdevices.ru>,
 <rockosov@gmail.com>, <cgroups@vger.kernel.org>, <linux-mm@kvack.org>,
 <linux-kernel@vger.kernel.org>, <bpf@vger.kernel.org>
Subject: Re: [PATCH v1] tools/cgroup: introduce cgroup v2 memory.events
 listener
Message-Id: <20231106140934.3f5d4960141562fe8da53906@linux-foundation.org>
In-Reply-To: <20231013184107.28734-1-ddrokosov@salutedevices.com>
References: <20231013184107.28734-1-ddrokosov@salutedevices.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 13 Oct 2023 21:41:07 +0300 Dmitry Rokosov <ddrokosov@salutedevices.com> wrote:

> This is a simple listener for memory events that handles counter
> changes in runtime. It can be set up for a specific memory cgroup v2.
> 
> The output example:
> =====
> $ /tmp/cgroup_v2_event_listener test
> Initialized MEMCG events with counters:
> MEMCG events:
> 	low: 0
> 	high: 0
> 	max: 0
> 	oom: 0
> 	oom_kill: 0
> 	oom_group_kill: 0
> Started monitoring memory events from '/sys/fs/cgroup/test/memory.events'...
> Received event in /sys/fs/cgroup/test/memory.events:
> *** 1 MEMCG oom_kill event, change counter 0 => 1
> Received event in /sys/fs/cgroup/test/memory.events:
> *** 1 MEMCG oom_kill event, change counter 1 => 2
> Received event in /sys/fs/cgroup/test/memory.events:
> *** 1 MEMCG oom_kill event, change counter 2 => 3
> Received event in /sys/fs/cgroup/test/memory.events:
> *** 1 MEMCG oom_kill event, change counter 3 => 4
> Received event in /sys/fs/cgroup/test/memory.events:
> *** 2 MEMCG max events, change counter 0 => 2
> Received event in /sys/fs/cgroup/test/memory.events:
> *** 8 MEMCG max events, change counter 2 => 10
>
> ...
>

Looks nice to me.

Perhaps it should be under ./samples/?

I suggest adding a comment to __memory_events_show() reminding people
to update this code if new events are added.


