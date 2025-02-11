Return-Path: <cgroups+bounces-6499-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0947AA30693
	for <lists+cgroups@lfdr.de>; Tue, 11 Feb 2025 10:02:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 23A97188468F
	for <lists+cgroups@lfdr.de>; Tue, 11 Feb 2025 09:03:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC9921EF0BB;
	Tue, 11 Feb 2025 09:02:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="aXMI1PXI"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5749726BDA6
	for <cgroups@vger.kernel.org>; Tue, 11 Feb 2025 09:02:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739264573; cv=none; b=e/59I1bAtD3O3vb4p0EcywY6RV8pSbYZY2PSFrluukyugPE4llvQnnbI2+p5QYRU02VtFd8lTrfCem6RcVzEPcwVYKv5AeGKvm+LM5exKvtPgNEG1GDp/kRlQNMxdEAVGIvht/2Wr5W42dKDWGeQfgdobgB+Ve8u8fd4bEu/mno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739264573; c=relaxed/simple;
	bh=BdRh917jP9pkcKVarbSB7GYmPZFJRYMqTBZ5edCrPec=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lJLjmdR4P9H491B/3bizoRkw/id3nsMi/UmDKsFnf/wPTuhTcMG4qdZ23AVFltUXc6S4PakqPmCu2Qy+gDmG6R/5afgN+4V1AWA3JDK/0zsRtdof+28t5hylWMnrWXsIh7Cn4Di3eWLR50kQgKwgyenfAYNSFGsgZP1jBrKqQxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=aXMI1PXI; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-ab7b80326cdso370309666b.3
        for <cgroups@vger.kernel.org>; Tue, 11 Feb 2025 01:02:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1739264569; x=1739869369; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=a/vcWSwoaK4yZZjIRRGK2GqLaY/dehgjARDfk7E0I8c=;
        b=aXMI1PXI/NhA7v/jtd/QVBECe3s1zlnzlCpe2ZqbQfdPQdgyKriUqB+M/uOnVZZ1A7
         6FRm70Cefiq872PQ1ZloYNBr7G4zqTSvr+trhfrJAKMPOLlNOI9fBWsHCRjZaHk8jqMW
         B/ZzU4G66EBODPTXIGzEt6yQW9dvQrhDhVgO5eGYcUG6ItOxu4lQE+Xsa2P/K2ZMaZDy
         6RGmpalAfxXh0tFtgee4mR9sixzBfkN1Spfjg/uCLDHRXwcCCugutGUgHVEc6g7g8Aom
         6vo43YrSve2t36FR/8pycH4qJU4R6geoVLCiieQgteIxDjUSsCe1Jl2QflxmjJqls7ab
         D5CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739264569; x=1739869369;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a/vcWSwoaK4yZZjIRRGK2GqLaY/dehgjARDfk7E0I8c=;
        b=CCYva/xAQbOG+xyYFRbGSbvZPELpK/bWnbSi4qdP0z/jjWGYJFdIkA5Z573RBlwdaA
         2EuJ/VWCFbf0rAYk6vUctkXWVeZGnXGZfQdtFmAdH9Dx66hJ9bX6waabGCk7a21wmW3/
         /WunQJ26V0n2KEJgRYZCk+yRhxachPyNsLakGx6XYCLan/QFaY38swMn7qWUXb38SJc8
         05xYGBrRlQjNGQNvOt06v7G766p+Luehdn+Rmrm3idMEV6wEBmslg6liwgW1WOSxBEao
         0MLxFTiE2RlkiObRtIqFNFGlwp0CICfFL9lybW3h1Nft3ykn5BgW6FdfDEf8enEqWHNJ
         A73g==
X-Forwarded-Encrypted: i=1; AJvYcCUobPFCZCp4IaID8XXVhurEdUNfY4W3Vf1w172ibajdM9QmyB2uL0aUyxgoE0ZyeLWFjLITYCNM@vger.kernel.org
X-Gm-Message-State: AOJu0Yxo8sycgjd40Y27i5JmG6bwL0sy8ylUpqNE07e87fdq0lDqbuSz
	KTdktDwpQ7CW2qGaWckE+aMUbUBWJtlK6iGA66oNB25WEbw+p2aIAEq4u75sxqA=
X-Gm-Gg: ASbGncujlUPXV9OnZhuf5Go16Xm71aH4lSJUlpgdhMpHgdHcHmb0V8W5FdDVVFtPkxw
	JBZruhddSTAwz+15UT4/mfpUC+a8XeDLwW2gVa93gfc8H0I5PfJak7Dp4Yzh4JNzBFmp6n//WCV
	eTNmL0/xQ+xNnkhn/3Bh30chBktwMCMhtElLy0vF+3omsSSBb/r2lycUimQxoM31TeYhoAzO9Zo
	8FMq5D9Szufqjcpa/VEoWbUPaR/pa0S2PK4T5Emn+jS4zgMSYoo98U+07oGYiao65Y+oIXRWGJS
	PisNd2bYXoUNJEbpvHikAvkXE8O1
X-Google-Smtp-Source: AGHT+IHGiJT3lxoSX40Aod01sSIdr1IyEhGNC4ww2vOluNg3CLMKYJKm4clhF7IDwG5sMxFtt1ZuyA==
X-Received: by 2002:a17:907:968b:b0:ab7:d801:86a7 with SMTP id a640c23a62f3a-ab7d80187cemr283211766b.3.1739264569562;
        Tue, 11 Feb 2025 01:02:49 -0800 (PST)
Received: from localhost (109-81-84-135.rct.o2.cz. [109.81.84.135])
        by smtp.gmail.com with UTF8SMTPSA id a640c23a62f3a-ab7c8b5a784sm294568966b.75.2025.02.11.01.02.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Feb 2025 01:02:49 -0800 (PST)
Date: Tue, 11 Feb 2025 10:02:48 +0100
From: Michal Hocko <mhocko@suse.com>
To: Chen Ridong <chenridong@huaweicloud.com>
Cc: hannes@cmpxchg.org, roman.gushchin@linux.dev, shakeel.butt@linux.dev,
	muchun.song@linux.dev, akpm@linux-foundation.org,
	cgroups@vger.kernel.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, chenridong@huawei.com,
	wangweiyang2@huawei.com
Subject: Re: [PATCH] memcg: avoid dead loop when setting memory.max
Message-ID: <Z6sSOC0YWWZLMhtO@tiehlicka>
References: <20250211081819.33307-1-chenridong@huaweicloud.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250211081819.33307-1-chenridong@huaweicloud.com>

On Tue 11-02-25 08:18:19, Chen Ridong wrote:
> From: Chen Ridong <chenridong@huawei.com>
> 
> A softlockup issue was found with stress test:
>  watchdog: BUG: soft lockup - CPU#27 stuck for 26s! [migration/27:181]
>  CPU: 27 UID: 0 PID: 181 Comm: migration/27 6.14.0-rc2-next-20250210 #1
>  Stopper: multi_cpu_stop <- stop_machine_from_inactive_cpu
>  RIP: 0010:stop_machine_yield+0x2/0x10
>  RSP: 0000:ff4a0dcecd19be48 EFLAGS: 00000246
>  RAX: ffffffff89c0108f RBX: ff4a0dcec03afe44 RCX: 0000000000000000
>  RDX: ff1cdaaf6eba5808 RSI: 0000000000000282 RDI: ff1cda80c1775a40
>  RBP: 0000000000000001 R08: 00000011620096c6 R09: 7fffffffffffffff
>  R10: 0000000000000001 R11: 0000000000000100 R12: ff1cda80c1775a40
>  R13: 0000000000000000 R14: 0000000000000001 R15: ff4a0dcec03afe20
>  FS:  0000000000000000(0000) GS:ff1cdaaf6eb80000(0000)
>  CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>  CR2: 0000000000000000 CR3: 00000025e2c2a001 CR4: 0000000000773ef0
>  DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
>  DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
>  PKRU: 55555554
>  Call Trace:
>   multi_cpu_stop+0x8f/0x100
>   cpu_stopper_thread+0x90/0x140
>   smpboot_thread_fn+0xad/0x150
>   kthread+0xc2/0x100
>   ret_from_fork+0x2d/0x50
> 
> The stress test involves CPU hotplug operations and memory control group
> (memcg) operations. The scenario can be described as follows:
> 
>  echo xx > memory.max 	cache_ap_online			oom_reaper
>  (CPU23)						(CPU50)
>  xx < usage		stop_machine_from_inactive_cpu
>  for(;;)			// all active cpus
>  trigger OOM		queue_stop_cpus_work
>  // waiting oom_reaper
>  			multi_cpu_stop(migration/xx)
>  			// sync all active cpus ack
>  			// waiting cpu23 ack
>  			// CPU50 loops in multi_cpu_stop
>  							waiting cpu50
> 
> Detailed explanation:
> 1. When the usage is larger than xx, an OOM may be triggered. If the
>    process does not handle with ths kill signal immediately, it will loop
>    in the memory_max_write.

Do I get it right that the issue is that mem_cgroup_out_of_memory which
doesn't have any cond_resched so it cannot yield to stopped kthread?
oom itself cannot make any progress because the oom victim is blocked as
per 3).

> 2. When cache_ap_online is triggered, the multi_cpu_stop is queued to the
>    active cpus. Within the multi_cpu_stop function,  it attempts to
>    synchronize the CPU states. However, the CPU23 didn't acknowledge
>    because it is stuck in a loop within the for(;;).
> 3. The oom_reaper process is blocked because CPU50 is in a loop, waiting
>    for CPU23 to acknowledge the synchronization request.
> 4. Finally, it formed cyclic dependency and lead to softlockup and dead
>    loop.
> 
> To fix this issue, add cond_resched() in the memory_max_write, so that
> it will not block migration task.

My first question was why this is not a problem in other
allocation/charge paths but this one is different because it doesn't
ever try to reclaim after MAX_RECLAIM_RETRIES reclaim rounds.
We do have scheduling points in the reclaim path which are no longer
triggered after we hit oom situation in this case.

I was thinking about having a guranteed cond_resched when oom killer
fails to find a victim but it seems the simplest fix for this particular
corner case is to add cond_resched as you did here. Hopefully we will
get rid of it very soon when !PREEMPT is removed.

Btw. this could be a problem on a single CPU machine even without CPU
hotplug as the oom repear won't run until memory_max_write yields the
cpu.

> Fixes: b6e6edcfa405 ("mm: memcontrol: reclaim and OOM kill when shrinking memory.max below usage")
> Signed-off-by: Chen Ridong <chenridong@huawei.com>

Acked-by: Michal Hocko <mhocko@suse.com>

> ---
>  mm/memcontrol.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index 8d21c1a44220..16f3bdbd37d8 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -4213,6 +4213,7 @@ static ssize_t memory_max_write(struct kernfs_open_file *of,
>  		memcg_memory_event(memcg, MEMCG_OOM);
>  		if (!mem_cgroup_out_of_memory(memcg, GFP_KERNEL, 0))
>  			break;
> +		cond_resched();
>  	}
>  
>  	memcg_wb_domain_size_changed(memcg);
> -- 
> 2.34.1

-- 
Michal Hocko
SUSE Labs

