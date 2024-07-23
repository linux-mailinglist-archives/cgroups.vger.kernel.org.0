Return-Path: <cgroups+bounces-3863-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC89793A4C5
	for <lists+cgroups@lfdr.de>; Tue, 23 Jul 2024 19:15:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8805A283E0B
	for <lists+cgroups@lfdr.de>; Tue, 23 Jul 2024 17:15:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D1FD17BD5;
	Tue, 23 Jul 2024 17:15:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="euIksZmS"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA87815688E
	for <cgroups@vger.kernel.org>; Tue, 23 Jul 2024 17:15:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721754915; cv=none; b=SGO5H+PT5M1Cub/YBALL0DrB2Wp0X6mbNMyTZB0GkbvajDIdEs4y6avyID28Rj8d/U6pcwQU7FreSoeml1FcvDcQUkjSKsnP4GZuOvdlsaRIX5yFu8L1btSyoeokUEBvi4LIDxxBoORlWgKRbqRgsyn4IgMpcf+DK0MX68tkBB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721754915; c=relaxed/simple;
	bh=2QinIKl01BYviRchpWq/nNONs7eDAT1sG9Q27g5MtLQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GeHHfWVQzsMqh+eWd7qrNkjzVqXnScmxGyB/EpPx/a77zCXE7VE8EH17jiId3M5/eVmbtLC1mp4rm7ehegXiT+Xfb1gVyxxIkzae42tqF7RS1V54R408p6HfR1ca/8Ir7il9I+P6pDK8ZhzCih39h+xQbiO3yqyR3keJojxtzeo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=euIksZmS; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721754912;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=48En1slowwZTq+Dy/oIa0R4wANx/Eecm2csRiLHBo6U=;
	b=euIksZmSuWei6rA12KOhQnfWHA2jioM1/FUqlG5/sp4UuiOX47RLEapdqzzp5+ktgpFrtR
	bIV03WDjzdMmkdtCyTzh8BCVwlkpQz5ylKxl+9UEAabxmHBSa6JVchKqsJqq3OPYCDxafK
	1s5tDGjSHhLtxEQHA/xBk4N/oZErUhw=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-442-hVtQla4sNLq_bwaQT9zOmA-1; Tue,
 23 Jul 2024 13:15:04 -0400
X-MC-Unique: hVtQla4sNLq_bwaQT9zOmA-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 1BB2D1955D45;
	Tue, 23 Jul 2024 17:15:01 +0000 (UTC)
Received: from tpad.localdomain (unknown [10.96.133.4])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 77132195605A;
	Tue, 23 Jul 2024 17:14:59 +0000 (UTC)
Received: by tpad.localdomain (Postfix, from userid 1000)
	id F2B23400DF27F; Tue, 23 Jul 2024 14:14:34 -0300 (-03)
Date: Tue, 23 Jul 2024 14:14:34 -0300
From: Marcelo Tosatti <mtosatti@redhat.com>
To: Leonardo Bras <leobras@redhat.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Muchun Song <muchun.song@linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>,
	Christoph Lameter <cl@linux.com>, Pekka Enberg <penberg@kernel.org>,
	David Rientjes <rientjes@google.com>,
	Joonsoo Kim <iamjoonsoo.kim@lge.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Hyeonggon Yoo <42.hyeyoo@gmail.com>,
	Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
	cgroups@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [RFC PATCH v1 0/4] Introduce QPW for per-cpu operations
Message-ID: <Zp/k+rJuVV+EcXqL@tpad>
References: <20240622035815.569665-1-leobras@redhat.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240622035815.569665-1-leobras@redhat.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

On Sat, Jun 22, 2024 at 12:58:08AM -0300, Leonardo Bras wrote:
> The problem:
> Some places in the kernel implement a parallel programming strategy
> consisting on local_locks() for most of the work, and some rare remote
> operations are scheduled on target cpu. This keeps cache bouncing low since
> cacheline tends to be mostly local, and avoids the cost of locks in non-RT
> kernels, even though the very few remote operations will be expensive due
> to scheduling overhead.
> 
> On the other hand, for RT workloads this can represent a problem: getting
> an important workload scheduled out to deal with remote requests is
> sure to introduce unexpected deadline misses.

Another hang with a busy polling workload (kernel update hangs on
grub2-probe):

[342431.665417] INFO: task grub2-probe:24484 blocked for more than 622 seconds.
[342431.665458]       Tainted: G        W      X  -------  ---  5.14.0-438.el9s.x86_64+rt #1
[342431.665488] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
[342431.665515] task:grub2-probe     state:D stack:0     pid:24484 ppid:24455  flags:0x00004002
[342431.665523] Call Trace:
[342431.665525]  <TASK>
[342431.665527]  __schedule+0x22a/0x580
[342431.665537]  schedule+0x30/0x80
[342431.665539]  schedule_timeout+0x153/0x190
[342431.665543]  ? preempt_schedule_thunk+0x16/0x30
[342431.665548]  ? preempt_count_add+0x70/0xa0
[342431.665554]  __wait_for_common+0x8b/0x1c0
[342431.665557]  ? __pfx_schedule_timeout+0x10/0x10
[342431.665560]  __flush_work.isra.0+0x15b/0x220
[342431.665565]  ? __pfx_wq_barrier_func+0x10/0x10
[342431.665570]  __lru_add_drain_all+0x17d/0x220
[342431.665576]  invalidate_bdev+0x28/0x40
[342431.665583]  blkdev_common_ioctl+0x714/0xa30
[342431.665588]  ? bucket_table_alloc.isra.0+0x1/0x150
[342431.665593]  ? cp_new_stat+0xbb/0x180
[342431.665599]  blkdev_ioctl+0x112/0x270
[342431.665603]  ? security_file_ioctl+0x2f/0x50
[342431.665609]  __x64_sys_ioctl+0x87/0xc0
[342431.665614]  do_syscall_64+0x5c/0xf0
[342431.665619]  ? __ct_user_enter+0x89/0x130
[342431.665623]  ? syscall_exit_to_user_mode+0x22/0x40
[342431.665625]  ? do_syscall_64+0x6b/0xf0
[342431.665627]  ? __ct_user_enter+0x89/0x130
[342431.665629]  entry_SYSCALL_64_after_hwframe+0x6e/0x76
[342431.665635] RIP: 0033:0x7f39856c757b
[342431.665666] RSP: 002b:00007ffd9541c488 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
[342431.665670] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f39856c757b
[342431.665673] RDX: 0000000000000000 RSI: 0000000000001261 RDI: 0000000000000005
[342431.665674] RBP: 00007ffd9541c540 R08: 0000000000000003 R09: 006164732f766564
[342431.665676] R10: 0000000000000000 R11: 0000000000000246 R12: 00007ffd9543ca68
[342431.665678] R13: 000055ea758a0708 R14: 000055ea759de338 R15: 00007f398586f000


