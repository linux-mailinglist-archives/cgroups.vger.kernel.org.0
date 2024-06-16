Return-Path: <cgroups+bounces-3191-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 66720909E4E
	for <lists+cgroups@lfdr.de>; Sun, 16 Jun 2024 18:06:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 048AB28165E
	for <lists+cgroups@lfdr.de>; Sun, 16 Jun 2024 16:06:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF473168B7;
	Sun, 16 Jun 2024 16:05:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hEzSkrxb"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C03FE15ACB
	for <cgroups@vger.kernel.org>; Sun, 16 Jun 2024 16:05:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718553956; cv=none; b=BUGxxDsxuZgMCeuZIeWucb+ca7V+kdsMbxRbqEhTP8i/Rl7qffX6UgpkD5dSxwPpHrbhOe+dbqcrG1IAM/ztH983VU/zuoIkKaCaaY39DJSoMdoWd8CMjSdNf5u6uXtcMgEQlZeX6gI29eTh2wn7sfPyimgYbgTHMGfd0IQ3EOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718553956; c=relaxed/simple;
	bh=jWPn9iHaLtLH42siBzpBDgnax3bP3yA0wAFza39sHXM=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=MY2tCMKSZXX9eSorjINh0tRAvJ6ZRlRNiztAKY1v/bhoccXI4bUoTOwCk3uX2QG9wjXsV6kRLgztYeTIUk1Xm+T/tBuwawouNPipKnOb9+rMQBMx6iTEiXx2TGAcgrCXzWLqyjarCTKOcCxo/rgsAmOTU/OXMqDpWiwwEGkpdRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hEzSkrxb; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718553953;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MvMJu7sYbHTnFA3tw1OE+4otMrjKcOURe4Vll9EDiOI=;
	b=hEzSkrxbyCohzyB+ZcLBrrsD0XGcrO9w9HrBIw9ITIMuZyrWHi+eIPTZbBs2DjEIlwVOKU
	6U9ijF8vitRDPZ9p3zrjnRQ9hmtIHAacN2PGU7c6a/4TiRQffvgVHSpUaMrWvWF7KnyBtA
	ebjJDf3sWdVqd6oy4/sHV8texQt0Vys=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-317-6kxyAy5_M5u40q3GMwna6w-1; Sun,
 16 Jun 2024 12:05:47 -0400
X-MC-Unique: 6kxyAy5_M5u40q3GMwna6w-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 42D8C1956094;
	Sun, 16 Jun 2024 16:05:45 +0000 (UTC)
Received: from [10.22.32.70] (unknown [10.22.32.70])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 65FC13000218;
	Sun, 16 Jun 2024 16:05:41 +0000 (UTC)
Message-ID: <139fd239-49e3-4591-965e-82c9f7d627e9@redhat.com>
Date: Sun, 16 Jun 2024 12:05:40 -0400
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [syzbot] [mm?] possible deadlock in
 __mmap_lock_do_trace_start_locking
To: syzbot <syzbot+6ff90931779bcdfc840c@syzkaller.appspotmail.com>,
 akpm@linux-foundation.org, cgroups@vger.kernel.org, hannes@cmpxchg.org,
 hawk@kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 linux-trace-kernel@vger.kernel.org, lizefan.x@bytedance.com,
 mathieu.desnoyers@efficios.com, mhiramat@kernel.org, netdev@vger.kernel.org,
 rostedt@goodmis.org, syzkaller-bugs@googlegroups.com, tj@kernel.org
References: <000000000000d05580061b025528@google.com>
Content-Language: en-US
From: Waiman Long <longman@redhat.com>
In-Reply-To: <000000000000d05580061b025528@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

On 6/16/24 10:05, syzbot wrote:
> syzbot has bisected this issue to:
>
> commit 21c38a3bd4ee3fb7337d013a638302fb5e5f9dc2
> Author: Jesper Dangaard Brouer <hawk@kernel.org>
> Date:   Wed May 1 14:04:11 2024 +0000
>
>      cgroup/rstat: add cgroup_rstat_cpu_lock helpers and tracepoints
>
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=16695261980000
> start commit:   36534d3c5453 tcp: use signed arithmetic in tcp_rtx_probe0_..
> git tree:       bpf
> final oops:     https://syzkaller.appspot.com/x/report.txt?x=15695261980000
> console output: https://syzkaller.appspot.com/x/log.txt?x=11695261980000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=333ebe38d43c42e2
> dashboard link: https://syzkaller.appspot.com/bug?extid=6ff90931779bcdfc840c
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1585acfa980000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=17bdb7ee980000
>
> Reported-by: syzbot+6ff90931779bcdfc840c@syzkaller.appspotmail.com
> Fixes: 21c38a3bd4ee ("cgroup/rstat: add cgroup_rstat_cpu_lock helpers and tracepoints")
>
> For information about bisection process see: https://goo.gl/tpsmEJ#bisection
>
+static __always_inline
+unsigned long _cgroup_rstat_cpu_lock(raw_spinlock_t *cpu_lock, int cpu,
+                                    struct cgroup *cgrp, const bool 
fast_path)
+{
+       unsigned long flags;
+       bool contended;
+
+       /*
+        * The _irqsave() is needed because cgroup_rstat_lock is
+        * spinlock_t which is a sleeping lock on PREEMPT_RT. Acquiring
+        * this lock with the _irq() suffix only disables interrupts on
+        * a non-PREEMPT_RT kernel. The raw_spinlock_t below disables
+        * interrupts on both configurations. The _irqsave() ensures
+        * that interrupts are always disabled and later restored.
+        */
+       contended = !raw_spin_trylock_irqsave(cpu_lock, flags);
+       if (contended) {
+               if (fast_path)
+ trace_cgroup_rstat_cpu_lock_contended_fastpath(cgrp, cp>
+               else
+                       trace_cgroup_rstat_cpu_lock_contended(cgrp, cpu, 
conten>
+
+               raw_spin_lock_irqsave(cpu_lock, flags);
+       }

I believe the problem may be caused by the fact that 
trace_cgroup_rstat_cpu_lock_contended*() can be called with IRQ enabled. 
I had suggested before IRQ should be disabled first before doing any 
trace operation. See

https://lore.kernel.org/linux-mm/203fdb35-f4cf-4754-9709-3c024eecade9@redhat.com/

Doing so may be able to resolve this possible deadlock.

Cheers,
Longman


