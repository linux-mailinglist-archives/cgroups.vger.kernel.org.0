Return-Path: <cgroups+bounces-6057-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E0E2AA021DB
	for <lists+cgroups@lfdr.de>; Mon,  6 Jan 2025 10:29:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F092D7A174A
	for <lists+cgroups@lfdr.de>; Mon,  6 Jan 2025 09:29:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E61B1D9A40;
	Mon,  6 Jan 2025 09:29:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="H0tgWrcN"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05E531D9593
	for <cgroups@vger.kernel.org>; Mon,  6 Jan 2025 09:29:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736155750; cv=none; b=HWkTlk44mcICW+i3M88xZRy6ftplsyAXdgYuHEguIiLnL6MFy6NX5XZoaP7nvbejF3fwDFzDy6hZ3WM9D35U/blBluXyUGaFVtW1LAU0FjDqFp+6K9uEZTI6MAj+SyKHUWMxxQ6Skr+e2/4gctF/ThJy7lFjQuyfT0piK8BXsJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736155750; c=relaxed/simple;
	bh=VbCJIMeCHTK9k7HjgX/Fs+x2vqfKQDoRR8yF/QcQdnU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Jl8V7dfgoNi4SxF4uZsY3h6QR0AnVGqRQuM6t6ksedO9a3rO9Jf+N2qZlV0soUUtxhbcOQxcdGnhIAxDupcdvy13PcnM5ooywjBXouLwJX1pGqRt8OizbX5Y0tI17DCgR+ItmRRJWE9oy6De3QjzvQXL2XQnsup5m3ZGgDjlemw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=H0tgWrcN; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-aaf900cc7fbso672024066b.3
        for <cgroups@vger.kernel.org>; Mon, 06 Jan 2025 01:29:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1736155746; x=1736760546; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=pRxlTsw4noJRO4PTJ4WE4xz8vvmd5m1JovKox4IgnXM=;
        b=H0tgWrcNKPNxyYB5X1NgdXqgBU+FBcitB45a/ndeGk8dUgF0R73sJFqJ9FwtUyYvXZ
         pVjjzV1s0/8LRoPcZ49R0NjRjKbEj8akzYKmWJBude0UacxYV+rSmq/o4jmDjt1Uxxmc
         8RCc+U9sdq9wjk/G6x2EkKKZbI+hyn3lIAwcNCI1T1XQHNp3A5NqBZwgfZd0KpbiEtHi
         lNcUAVyYQkZMNgZDe8+Nd1Lm1ZwBJOwx1HCGvjkn7vDegSHcMzXE2balDWQrKg5mGQwK
         r0VoYiglRIMoUaUEwPkCCrVFO94hbhBbougTaRNGkG0lV+xUiO9R0jFnFSEvp1HR9qZK
         vJtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736155746; x=1736760546;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pRxlTsw4noJRO4PTJ4WE4xz8vvmd5m1JovKox4IgnXM=;
        b=WR+Dsyl57aV/jtqX1zpSanzspqQqY62OOXGsu6dx3cj7SngvFhrpy+SsAOcx5n+VNb
         zTmQoOk3JFEpQv6nsvWz0Zk2JosswnReFJv/18R7nHOzi5qEPxzkyE06usST6eR75ytZ
         LjbrWSjZPlXIA4jMnmjsXfq7hk64MTG8sS1W6YLYQYomw/BuHlur1u5sE2amBdR0xHyT
         cwqwhH4TWwmILixEu2azw1IJLxk3ie0akprYBCv/XcSjEcaj4qPG5AXNQ1x5whcYN8cm
         DWJMiIXW8QTi7gCdJDO/tOKvid9HYPIwe7dkfjuD/ahqkGcnRQ5t5pTHoQAp9/uF9LSp
         QUuQ==
X-Forwarded-Encrypted: i=1; AJvYcCV4R/WWnd5z8G1CJz1Lj/m6S538r733b6Y2X/mZuobKkGi32Gh8t2m1qTMU26zGaI3W98+s0h2F@vger.kernel.org
X-Gm-Message-State: AOJu0YzOau5rI6E8hXOJaxtXNFZfuoFAbfEz6w9dgn4z7akp6TO9d5c2
	wcN3WgEz1wAoSnA9sYKb8rrnS2aMVnIfazeABxL9aIP4tWUCVYZvod+rNsbbSnY=
X-Gm-Gg: ASbGncsMza+L6ruEwug0+a/JI+bTAuK3YDr+S5kEEeYqPXpp4hHe31P+q7fs0QUp80b
	BLLYZJd4egR3F3zh+tQNcSkdhc8Xkly1YOCJUd+924WZBGeKwMfeVIxhO1YOBS3BXZxi6we2J+2
	yLs9EBG2keeWnDIRs20HpHqeGzkoVu6m+19HKTRU6VQbyNPWNUwXHUJbNtCLSbklV3y864aEzkx
	42rzSsLqGZ8rpwP96nhbgf3tTzISgsN06afhtq4pLPn7xAX1KtmsRoItp35ol99dhPYTQ==
X-Google-Smtp-Source: AGHT+IE9spkvUXDeN+P/2tZdetnqrX50fooWVBrN0b+rpEyRq475EPIXn/4wfVRuavFOn/XGTHxFbg==
X-Received: by 2002:a17:907:9715:b0:aac:619:e914 with SMTP id a640c23a62f3a-aac2ad88fcfmr5774830466b.16.1736155746300;
        Mon, 06 Jan 2025 01:29:06 -0800 (PST)
Received: from localhost (109-81-95-200.rct.o2.cz. [109.81.95.200])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aac0efe4c49sm2248227166b.128.2025.01.06.01.29.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jan 2025 01:29:05 -0800 (PST)
Date: Mon, 6 Jan 2025 10:29:04 +0100
From: Michal Hocko <mhocko@suse.com>
To: Chen Ridong <chenridong@huaweicloud.com>
Cc: akpm@linux-foundation.org, hannes@cmpxchg.org, yosryahmed@google.com,
	roman.gushchin@linux.dev, shakeel.butt@linux.dev,
	muchun.song@linux.dev, davidf@vimeo.com, vbabka@suse.cz,
	handai.szj@taobao.com, rientjes@google.com,
	kamezawa.hiroyu@jp.fujitsu.com, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
	chenridong@huawei.com, wangweiyang2@huawei.com
Subject: Re: [PATCH v3] memcg: fix soft lockup in the OOM process
Message-ID: <Z3uiYOnkB1aRowNy@tiehlicka>
References: <20241224025238.3768787-1-chenridong@huaweicloud.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241224025238.3768787-1-chenridong@huaweicloud.com>

On Tue 24-12-24 02:52:38, Chen Ridong wrote:
> From: Chen Ridong <chenridong@huawei.com>
> 
> A soft lockup issue was found in the product with about 56,000 tasks were
> in the OOM cgroup, it was traversing them when the soft lockup was
> triggered.
> 
> watchdog: BUG: soft lockup - CPU#2 stuck for 23s! [VM Thread:1503066]
> CPU: 2 PID: 1503066 Comm: VM Thread Kdump: loaded Tainted: G
> Hardware name: Huawei Cloud OpenStack Nova, BIOS
> RIP: 0010:console_unlock+0x343/0x540
> RSP: 0000:ffffb751447db9a0 EFLAGS: 00000247 ORIG_RAX: ffffffffffffff13
> RAX: 0000000000000001 RBX: 0000000000000000 RCX: 00000000ffffffff
> RDX: 0000000000000000 RSI: 0000000000000004 RDI: 0000000000000247
> RBP: ffffffffafc71f90 R08: 0000000000000000 R09: 0000000000000040
> R10: 0000000000000080 R11: 0000000000000000 R12: ffffffffafc74bd0
> R13: ffffffffaf60a220 R14: 0000000000000247 R15: 0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00007f2fe6ad91f0 CR3: 00000004b2076003 CR4: 0000000000360ee0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> Call Trace:
>  vprintk_emit+0x193/0x280
>  printk+0x52/0x6e
>  dump_task+0x114/0x130
>  mem_cgroup_scan_tasks+0x76/0x100
>  dump_header+0x1fe/0x210
>  oom_kill_process+0xd1/0x100
>  out_of_memory+0x125/0x570
>  mem_cgroup_out_of_memory+0xb5/0xd0
>  try_charge+0x720/0x770
>  mem_cgroup_try_charge+0x86/0x180
>  mem_cgroup_try_charge_delay+0x1c/0x40
>  do_anonymous_page+0xb5/0x390
>  handle_mm_fault+0xc4/0x1f0
> 
> This is because thousands of processes are in the OOM cgroup, it takes a
> long time to traverse all of them. As a result, this lead to soft lockup
> in the OOM process.
> 
> To fix this issue, call 'cond_resched' in the 'mem_cgroup_scan_tasks'
> function per 1000 iterations. For global OOM, call
> 'touch_softlockup_watchdog' per 1000 iterations to avoid this issue.
> 
> Fixes: 9cbb78bb3143 ("mm, memcg: introduce own oom handler to iterate only over its own threads")
> Signed-off-by: Chen Ridong <chenridong@huawei.com>

LGTM, I would really not overthink that much. PREEMPT_NONE and Soft
lockups will hopefully soon become a non-issue.

Acked-by: Michal Hocko <mhocko@suse.com>

-- 
Michal Hocko
SUSE Labs

