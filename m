Return-Path: <cgroups+bounces-6517-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 50F8DA32196
	for <lists+cgroups@lfdr.de>; Wed, 12 Feb 2025 09:57:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0A311160193
	for <lists+cgroups@lfdr.de>; Wed, 12 Feb 2025 08:57:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7134E205ACE;
	Wed, 12 Feb 2025 08:57:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="aEzxNjKi"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38A23271828
	for <cgroups@vger.kernel.org>; Wed, 12 Feb 2025 08:57:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739350665; cv=none; b=m2XI4i1v0WfM3mGsgT4d9RX8cIA2oGif63Zz0P5St1qlZMOQODy01Kn/183oKyaNEOuwvcD7/3gKyEtJRpRpq2nsrosA3LY+dnplZf1FB7VagYHyp3sN30n70pt74M5GJMmdDLWFqhXHo4wk3Gr+EeqCTKlg5SDVMbNUm/gStSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739350665; c=relaxed/simple;
	bh=XV7IVblDWD8KDdpkj7qGjSLygK5e9tiLpzFQ3w2uR8E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AK+r0uyrh9Glc41HHkC7v3hx3ROUQUXmKvHSUCgMTCqLkwgob+SOF+sQA1U1D79wq1MY5rCwAV/gzmxbFqzxBIuwLYKxFKesqpSbEuUsn1FwbjfG2j6/Fxufdr0umXkvodsCp+tcWZWgQ/J2sLsT4qnCbeeth2jfy9MHkxb4Flk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=aEzxNjKi; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-5deb956aa5eso117192a12.2
        for <cgroups@vger.kernel.org>; Wed, 12 Feb 2025 00:57:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1739350660; x=1739955460; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+IuI5zXvDpkkZzSpr5OZmFLbRF4AuQK1DqlOW4Frc34=;
        b=aEzxNjKiWWkWPFAE/ZCN5+4EGzFkvwtClDt36n0pzEHo/fVTs0e/EE/+LoU7IsLshh
         pk9mlThKyEJoQ8weA2AtkF9gwG1IxsgF9Re3V/jasOWSlgqbyl6PtjeaWnRTtWjBc7GQ
         BpNenyNzUGdInTKzwGOimakpZEihofAys+93Qx4fYPOYGqWT0dYV9h2h2WTXikdipz8h
         u2k+jnedQ/qD9HBSWLECbxbtOoDDJ4sg7TLhWrR/09xEjVIO/trHcOkZ93zF5WB0zcIL
         i2rU8CQqe08avbdd8EcLtZNZSacvfvIk+vtMqIqteTh8P6/7U7WHcATztx9BmuwFMdQD
         JtYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739350660; x=1739955460;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+IuI5zXvDpkkZzSpr5OZmFLbRF4AuQK1DqlOW4Frc34=;
        b=Q6mI00FtiQacpMoq3bNA0WMCrP99gWWildUfhTH4Is0KaQLCEH+zms/04J3g/FDRfP
         X4iQbOPId03ljazLhDpr19T0r8phP5OuZSgp5sln0u8tIMXs/NE5naN88XWcYLIj+Cx1
         ObjNyQxpwQHjXIM+FHgODIBRxTgqSe2i3A4z/eLJ6re3KTsrhaE0vnx6n8E9uzlkf1K5
         +KzQmJkfZIu4LRIl30TmBPH/HjDmhhOtl/nQlVswealHP4bblZeCorEyc+TXCpEmNoZ7
         WZcS5sCR5Y5pe2M+zBA2rLMnRm/N2NVVyJe0HqmmVNo36SqaSOwPOx4CntxvdLT2mNmL
         xS0g==
X-Forwarded-Encrypted: i=1; AJvYcCXwaf1M9+qAuc+VhudEX7pfJF9sR4vP9Of8+MsLOmTgZXwvkLwrWS6DzzcIaR1MoKHvAW5rPX/O@vger.kernel.org
X-Gm-Message-State: AOJu0YykI5ln+WkiAJ9FIO9iWDWYVsVLyaVJeISTfTUIh0wbaFkbNAWH
	NUn/3p3OHf62mGZBquYPQ8f6M27zW3SJdCGKgwnU47fEL2Fg67oqGssahjPA9AM=
X-Gm-Gg: ASbGncsqpfdK/FsunvCGyp3JXhvR+hwi4Y399tPFPaTVaMsLhub0QQEN2myURKr8qZH
	BCHpeIMEYRaG1gxCzgQogKFfQeR0gjjpTa931UdI0q+Uo8ZxkWewrQej/4HeZiyz3D8uxIJD9EN
	Tj9b++oCCmIV5WDWU+/hd/mfqwem3Mv3XiST7ycahHjoqXbbqJwIf6E2h0AeAMDb+AJT9ICxO9T
	EuctePo5zjovQBpNg3U85nvSLH4gJcBO64wYIVSlJ7q2+6pj2iQRz35g/O8FAbSbbMrrvITikfP
	x2MP2hk1xey+dgLqdxnC2duiDohj
X-Google-Smtp-Source: AGHT+IHAlI+h0f9gQ05Wk4VO5y5MPCyT960vP5L1X6nmRum7jNTTiYbDKSPELSyxpwXSfS409hjybw==
X-Received: by 2002:a05:6402:40c1:b0:5dc:ea7e:8c56 with SMTP id 4fb4d7f45d1cf-5deadddd4e6mr4918933a12.22.1739350660368;
        Wed, 12 Feb 2025 00:57:40 -0800 (PST)
Received: from localhost (109-81-84-135.rct.o2.cz. [109.81.84.135])
        by smtp.gmail.com with UTF8SMTPSA id a640c23a62f3a-ab7d062771csm422764866b.29.2025.02.12.00.57.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Feb 2025 00:57:40 -0800 (PST)
Date: Wed, 12 Feb 2025 09:57:39 +0100
From: Michal Hocko <mhocko@suse.com>
To: Chen Ridong <chenridong@huaweicloud.com>
Cc: akpm@linux-foundation.org, hannes@cmpxchg.org, yosryahmed@google.com,
	roman.gushchin@linux.dev, shakeel.butt@linux.dev,
	muchun.song@linux.dev, davidf@vimeo.com, vbabka@suse.cz,
	mkoutny@suse.com, paulmck@kernel.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
	chenridong@huawei.com, wangweiyang2@huawei.com
Subject: Re: [PATCH] mm/oom_kill: revert watchdog reset in global OOM process
Message-ID: <Z6xig5sLNpFVFU2T@tiehlicka>
References: <20250212025707.67009-1-chenridong@huaweicloud.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250212025707.67009-1-chenridong@huaweicloud.com>

On Wed 12-02-25 02:57:07, Chen Ridong wrote:
> From: Chen Ridong <chenridong@huawei.com>
> 
> Unlike memcg OOM, which is relatively common, global OOM events are rare
> and typically indicate that the entire system is under severe memory
> pressure. The commit ade81479c7dd ("memcg: fix soft lockup in the OOM
> process") added the touch_softlockup_watchdog in the global OOM handler to
> suppess the soft lockup issues. However, while this change can suppress
> soft lockup warnings, it does not address RCU stalls, which can still be
> detected and may cause unnecessary disturbances. Simply remove the
> modification from the global OOM handler.
> 
> Fixes: ade81479c7dd ("memcg: fix soft lockup in the OOM process")

But this is not really fixing anything, is it? While this doesn't
address a potential RCU stall it doesn't address any actual problem.
So why do we want to do this?

> Signed-off-by: Chen Ridong <chenridong@huawei.com>
> ---
>  mm/oom_kill.c | 8 +-------
>  1 file changed, 1 insertion(+), 7 deletions(-)
> 
> diff --git a/mm/oom_kill.c b/mm/oom_kill.c
> index 25923cfec9c6..2d8b27604ef8 100644
> --- a/mm/oom_kill.c
> +++ b/mm/oom_kill.c
> @@ -44,7 +44,6 @@
>  #include <linux/init.h>
>  #include <linux/mmu_notifier.h>
>  #include <linux/cred.h>
> -#include <linux/nmi.h>
>  
>  #include <asm/tlb.h>
>  #include "internal.h"
> @@ -431,15 +430,10 @@ static void dump_tasks(struct oom_control *oc)
>  		mem_cgroup_scan_tasks(oc->memcg, dump_task, oc);
>  	else {
>  		struct task_struct *p;
> -		int i = 0;
>  
>  		rcu_read_lock();
> -		for_each_process(p) {
> -			/* Avoid potential softlockup warning */
> -			if ((++i & 1023) == 0)
> -				touch_softlockup_watchdog();
> +		for_each_process(p)
>  			dump_task(p, oc);
> -		}
>  		rcu_read_unlock();
>  	}
>  }
> -- 
> 2.34.1

-- 
Michal Hocko
SUSE Labs

