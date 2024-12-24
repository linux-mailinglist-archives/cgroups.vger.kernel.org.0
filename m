Return-Path: <cgroups+bounces-6019-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C754C9FC2C6
	for <lists+cgroups@lfdr.de>; Wed, 25 Dec 2024 00:07:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 612B9164B0D
	for <lists+cgroups@lfdr.de>; Tue, 24 Dec 2024 23:07:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3B731B87FF;
	Tue, 24 Dec 2024 23:06:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="U5mlvu8/"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B1A914831F
	for <cgroups@vger.kernel.org>; Tue, 24 Dec 2024 23:06:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735081615; cv=none; b=naYWeJWcWfb5fZZnVCtyLh/TXeXgVhYsjadWvdlDp9rn1iGApQuLWtOgljVpyYJDHWbG1w3PVtf6N9eS1D8NTF9L+iPI06Kc9hfA2Xh1dWUE71F/iZUZ1SZZwy4IpN3U1CoP9eDHGTNn/0MDyGt3loCNg09NzyVJz1zEJGGl14k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735081615; c=relaxed/simple;
	bh=yTMd3VPUTHg1b43Q7gaePPOyfmQKKl42Vqpk80+NhaQ=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=Fpl34DO6YK+zpz5c2R57wRedG2XObxxmXdhnSpLhT7w/6nfMEjtFT+e06BLaLyPnAnk5kyjLeBFBLOcNk0I+bNqzLqFe0rJ/JYKz934IA/d4RrAEuWfP+EXzoPqEj+WF5B0xuLt0wo10u6kDlv9X3oNhYw/WSggnp3uLZ4k5cx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=U5mlvu8/; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-215740b7fb8so590145ad.0
        for <cgroups@vger.kernel.org>; Tue, 24 Dec 2024 15:06:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1735081613; x=1735686413; darn=vger.kernel.org;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ak3ee7or6kKgRYECOqwoqGPVQoP0Zrj+7r83JVxR2dk=;
        b=U5mlvu8/lJJTM69CH8EhckkJlnBbMRWYZjl19owrSRGMl0fjkWeSh41Jqe76i984bd
         eJnvLUDl5LcCiQf8kZjB/DksQdXRQd10zdQ6rMqwK3U20XQd7mVyiH4LnIrEx6eRr3jP
         jwHkfvHTaXNvKwTd0z7KBJpKKmCzWn3jxoE4+fCO0004x4phPJ1vip1a7opkmhuWNdBL
         Vmel9p27DCjYNzepn3tVHQW1j8GHvQbXkE/iLmLHNiSpeuogOhWxx8H43oFem84QdXiP
         gRtXA76hSlbHI9VnVV/7TgXmeZI1znPo06VABbUgKewRwWLDd2ig6NH0WZVoWn4YlfMR
         WjsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735081613; x=1735686413;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ak3ee7or6kKgRYECOqwoqGPVQoP0Zrj+7r83JVxR2dk=;
        b=RQxWpVVH9pKY+CnnxlzBkN7Bl3iv3s2FrAdyM6uYvKLd4stzQyHNCLLI7ZpDSad5YK
         HIzgJHUrlewCsxCV7prKQzPJ5ionH5gPqVCAtaLaiZ5zvbSpk/eitBPtWUKb2ybSrLGt
         y1v8IIowW9tBhtTgcWGJrYCo4nuDIx/3fJ5m+0NU/lELxJ5CxTtARHyAMrjmGnaQaftb
         iM4T6sTXTwmhTGbz4/rXb2n8r0ns4KU2wtkOVW7HczbZqWHXZmbxBuKuwTsG4QNMzczp
         jrXstuqvNfEln4I02XVSySFLfS4VoibSlbzcyBHOcDDjx1CBXal85zrFS1IVHAzRS7+e
         ny/Q==
X-Forwarded-Encrypted: i=1; AJvYcCUDbEuh7gQ1K/I8PXn8y7B+JMT27xS9V716qUdTxPYhB70Hs6k6a2wow9rT6pLtS7O3aSNA2Rjd@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8GzSF8+K+XUvzjEKRVvL7732Wou9X7FiRxfd6XsmPxIR1N4Nw
	jBunjGaBkh3HBGgXvmDi2U1YrU8IGO/YsJ6HbvvRVV+29iCv+aa0P4+DZJCBkQ==
X-Gm-Gg: ASbGncvCBsXUrc1uOB1PbrOpg7ks2OxFv+/io48z/EcVHe7RyJuZn043tounfF7YHaE
	jts3HacXMxMAkzsNbZKQlsuoUmk74Yo2eiVP0TXQn1WMk+8IWj5jgYY5ZHtB11+3l4sBo3lFjIm
	xre1DRbmzFBgPOX5DLVsDP/gpEQjp4IrQFfu4Y3AcxCQp2z7NUVDysCCs7o4FrXNbeaCTr3dwfZ
	ljfYw70u3J4HHR8CNaaoYuNd6C8jUFDXF9Zbsye03DVWRwuut+s/7tdv/5vlmWuuyf9oJhi1iy/
	wPWYQkm6HIc=
X-Google-Smtp-Source: AGHT+IHNmnc4TcyjcS/dyfTNay6CvJR0QQupUFNVFLYTOakUBs5j+08Uhhl7AqaGCg9dls9Cud8pag==
X-Received: by 2002:a17:903:110c:b0:215:9d57:cf0c with SMTP id d9443c01a7336-219e76bd1e5mr8148105ad.5.1735081613027;
        Tue, 24 Dec 2024 15:06:53 -0800 (PST)
Received: from [2620:0:1008:15:cdf5:75d7:1c62:d741] ([2620:0:1008:15:cdf5:75d7:1c62:d741])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-219dc964e60sm95109615ad.16.2024.12.24.15.06.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Dec 2024 15:06:52 -0800 (PST)
Date: Tue, 24 Dec 2024 15:06:51 -0800 (PST)
From: David Rientjes <rientjes@google.com>
To: Chen Ridong <chenridong@huaweicloud.com>
cc: akpm@linux-foundation.org, mhocko@kernel.org, hannes@cmpxchg.org, 
    yosryahmed@google.com, roman.gushchin@linux.dev, shakeel.butt@linux.dev, 
    muchun.song@linux.dev, davidf@vimeo.com, vbabka@suse.cz, 
    handai.szj@taobao.com, kamezawa.hiroyu@jp.fujitsu.com, linux-mm@kvack.org, 
    linux-kernel@vger.kernel.org, cgroups@vger.kernel.org, 
    chenridong@huawei.com, wangweiyang2@huawei.com
Subject: Re: [PATCH v3] memcg: fix soft lockup in the OOM process
In-Reply-To: <20241224025238.3768787-1-chenridong@huaweicloud.com>
Message-ID: <8cf29751-7c71-52ff-5492-0019ca7b0e02@google.com>
References: <20241224025238.3768787-1-chenridong@huaweicloud.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Tue, 24 Dec 2024, Chen Ridong wrote:

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

Looks fine to me, although we do a lot of processes traversals for oom 
kill selection as well and this hasn't ever popped up as a significant 
concern.  We have cases far beyond 56k processes.  No objection to the 
approach, however.

