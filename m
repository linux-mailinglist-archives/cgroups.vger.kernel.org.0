Return-Path: <cgroups+bounces-5869-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FF1B9EFAE9
	for <lists+cgroups@lfdr.de>; Thu, 12 Dec 2024 19:30:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DF3DE2898CA
	for <lists+cgroups@lfdr.de>; Thu, 12 Dec 2024 18:30:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CA3222332D;
	Thu, 12 Dec 2024 18:30:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b="JcMxufp+"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17392223316
	for <cgroups@vger.kernel.org>; Thu, 12 Dec 2024 18:30:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734028222; cv=none; b=Ba/5ymTIoF89axHPFJkgtmrnUuU2Bu7pLoZGgEMxSh48tRJXZhpCnc/INsecZdM5wkqkmWQ0/qEPQbVmAYPAB5Oa66S5m22N6+sTVh7Qtgusj5LhXg7e5a8/Bn8o7UurIV2a7D1LgSJovg1dfAElqaul8BcWTPAp6hjNSm/1R/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734028222; c=relaxed/simple;
	bh=KW2GUcJjjEQ/caRd6tYdueccDNsofrCjGydOTPeUN+c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bnf+lr3xvRLHVEyCObo2im9VdL5Q1GvRv4EJR+kmhhCohJmXo/QUhQimhhZZHG1E4rq0nHcIgEI06AD57uNo9oZqiK3vJFbDjzgRc6vRrMIUuo0DMy5W95vf2A8qPKeT2P/bT1ia7oRTZ94/PIvB2W68OW6Zo3FDnoS3YiSxFjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b=JcMxufp+; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-7b15467f383so87246385a.3
        for <cgroups@vger.kernel.org>; Thu, 12 Dec 2024 10:30:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20230601.gappssmtp.com; s=20230601; t=1734028218; x=1734633018; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=MmiY44ftef6O+ZMOcAuOGSJN7t6+XvI2HuwN5LfNTaQ=;
        b=JcMxufp+IwUOiCo0N7nB6AGbjDoNQwumEyJLnu+wWGXRcCPkupiYRK6fJJUDlCkEZJ
         Uor0TNANujrx9NEyzevkeD4YCDTDKtHwP13PEpNmibV8njpDN2juvECbUGajLMnkZ2Bb
         fznAyBiI7aDlonsYXmxq2CqW6UCoMBq/rM46mXb69UbnqM8cWD9xCuwu9M/NOXjWjFV0
         Gsz7QQq3EYJg9kU9QRLqsfGQtvvsDVH40lBUgv9ZONRvxDTVbydZ4gVOjnFN4ITuBV6l
         nVAIEfxwT8XqcozwqxZCzaAN2wJJnrC0hisAdus3ecxs7SZNE+/b4Lsa4V+FMwD3JwJw
         ZzLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734028218; x=1734633018;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MmiY44ftef6O+ZMOcAuOGSJN7t6+XvI2HuwN5LfNTaQ=;
        b=WDgS5PrVNvwfnBOm07on5inrpUgd7tOGwKciAMsgZZF+Mjb+nvxVQBuwLDgy0VGJI3
         h/mz/0iW94uEKLjSAk/QbhH2sxm404EkhyZoIRaMG6dY1XAkxWkZ9VHT+Uzl6JOGsTwD
         x3RYLSB8vvQLR6fljnN/K534+52KYIyDr5HwaNiT9Ft6JAMmGJ3ZdHXTYtK9rEftTdrU
         1JxRmEULYAKyefSiatkVXeWwiDxXzs6rpvo0+FwcMwcmDtInWQgyqf754k2yRgztqH9/
         b+1VXlBfAVaPOhNvV5zPb+Pu0SNwFEOEJrdS2NXQQK102nS58j9KsOsASMCfNAJ0sm0b
         hUgg==
X-Forwarded-Encrypted: i=1; AJvYcCUhC2ufxaYgjgzw24aSUZhDEpeEt7YvfKRxWiZwHkn3qm3xbyYV1U8QwzO0hthYbub0DfYXK8Ph@vger.kernel.org
X-Gm-Message-State: AOJu0YzRqBuIbGwqOgxNmfpyNgZluao4orrJMyI7xBQ0nU3dtUE+ENjz
	ROs+oaGKEMoFsWn3EiCqoxbbDB7jhZrZAdSqVWslyqLIWkxyMbVOtxARISrEanc=
X-Gm-Gg: ASbGncsqDgTlj87S3/wEvl1wEEXyYMaUg1eBpGEyO6OsC6dFJpLmsTWSDj97CZzoC1n
	ZkJ4k/3OEiXYauIXnS5gijc8Gukyg6OC7NkH+r9opYCcbx5632mH+Rd41ySFEooz9BVnrcswvvO
	3JPim/XDkHjlYGQGmPk57WvZIFBL/Sy5RVOPAdiI1wGIgroz2VYXHXG5Ia7FT7wN9u1FuZTVtwR
	qf5VY4tm3Nsa6aytgqZa0+T+rA7UOOLHnV2j43U782LjmOappSsXf0=
X-Google-Smtp-Source: AGHT+IG38MiE0nwEa6hQYO2vGYkkqMEfbHFTHod38nIta4Us7MLC6sgHlHqKAJsG3jnHQxWLOynmyg==
X-Received: by 2002:a05:620a:1909:b0:7b6:cb8a:3d54 with SMTP id af79cd13be357-7b6f89eef4dmr208194685a.51.1734028217762;
        Thu, 12 Dec 2024 10:30:17 -0800 (PST)
Received: from localhost ([2603:7000:c01:2716:da5e:d3ff:fee7:26e7])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-467a140f7b2sm2942531cf.79.2024.12.12.10.30.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Dec 2024 10:30:16 -0800 (PST)
Date: Thu, 12 Dec 2024 13:30:12 -0500
From: Johannes Weiner <hannes@cmpxchg.org>
To: Yosry Ahmed <yosryahmed@google.com>
Cc: Rik van Riel <riel@surriel.com>, Balbir Singh <balbirs@nvidia.com>,
	Michal Hocko <mhocko@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	hakeel Butt <shakeel.butt@linux.dev>,
	Muchun Song <muchun.song@linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>, cgroups@vger.kernel.org,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	kernel-team@meta.com, Nhat Pham <nphamcs@gmail.com>
Subject: Re: [PATCH v2] memcg: allow exiting tasks to write back data to swap
Message-ID: <20241212183012.GB1026@cmpxchg.org>
References: <20241212115754.38f798b3@fangorn>
 <CAJD7tkY=bHv0obOpRiOg4aLMYNkbEjfOtpVSSzNJgVSwkzaNpA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJD7tkY=bHv0obOpRiOg4aLMYNkbEjfOtpVSSzNJgVSwkzaNpA@mail.gmail.com>

On Thu, Dec 12, 2024 at 09:06:25AM -0800, Yosry Ahmed wrote:
> On Thu, Dec 12, 2024 at 8:58 AM Rik van Riel <riel@surriel.com> wrote:
> >
> > A task already in exit can get stuck trying to allocate pages, if its
> > cgroup is at the memory.max limit, the cgroup is using zswap, but
> > zswap writeback is enabled, and the remaining memory in the cgroup is
> > not compressible.
> >
> > This seems like an unlikely confluence of events, but it can happen
> > quite easily if a cgroup is OOM killed due to exceeding its memory.max
> > limit, and all the tasks in the cgroup are trying to exit simultaneously.
> >
> > When this happens, it can sometimes take hours for tasks to exit,
> > as they are all trying to squeeze things into zswap to bring the group's
> > memory consumption below memory.max.
> >
> > Allowing these exiting programs to push some memory from their own
> > cgroup into swap allows them to quickly bring the cgroup's memory
> > consumption below memory.max, and exit in seconds rather than hours.
> >
> > Signed-off-by: Rik van Riel <riel@surriel.com>
> 
> Thanks for sending a v2.
> 
> I still think maybe this needs to be fixed on the memcg side, at least
> by not making exiting tasks try really hard to reclaim memory to the
> point where this becomes a problem. IIUC there could be other reasons
> why reclaim may take too long, but maybe not as pathological as this
> case to be fair. I will let the memcg maintainers chime in for this.
> 
> If there's a fundamental reason why this cannot be fixed on the memcg
> side, I don't object to this change.
> 
> Nhat, any objections on your end? I think your fleet workloads were
> the first users of this interface. Does this break their expectations?

Yes, I don't think we can do this, unfortunately :( There can be a
variety of reasons for why a user might want to prohibit disk swap for
a certain cgroup, and we can't assume it's okay to make exceptions.

There might also not *be* any disk swap to overflow into after Nhat's
virtual swap patches. Presumably zram would still have the issue too.

So I'm also inclined to think this needs a reclaim/memcg-side fix. We
have a somewhat tumultous history of policy in that space:

commit 7775face207922ea62a4e96b9cd45abfdc7b9840
Author: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Date:   Tue Mar 5 15:46:47 2019 -0800

    memcg: killed threads should not invoke memcg OOM killer

allowed dying tasks to simply force all charges and move on. This
turned out to be too aggressive; there were instances of exiting,
uncontained memcg tasks causing global OOMs. This lead to that:

commit a4ebf1b6ca1e011289677239a2a361fde4a88076
Author: Vasily Averin <vasily.averin@linux.dev>
Date:   Fri Nov 5 13:38:09 2021 -0700

    memcg: prohibit unconditional exceeding the limit of dying tasks

which reverted the bypass rather thoroughly. Now NO dying tasks, *not
even OOM victims*, can force charges. I am not sure this is correct,
either:

If we return -ENOMEM to an OOM victim in a fault, the fault handler
will re-trigger OOM, which will find the existing OOM victim and do
nothing, then restart the fault. This is a memory deadlock. The page
allocator gives OOM victims access to reserves for that reason.

Actually, it looks even worse. For some reason we're not triggering
OOM from dying tasks:

        ret = task_is_dying() || out_of_memory(&oc);

Even though dying tasks are in no way privileged or allowed to exit
expediently. Why shouldn't they trigger the OOM killer like anybody
else trying to allocate memory?

As it stands, it seems we have dying tasks getting trapped in an
endless fault->reclaim cycle; with no access to the OOM killer and no
access to reserves. Presumably this is what's going on here?

I think we want something like this:

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 53db98d2c4a1..be6b6e72bde5 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -1596,11 +1596,7 @@ static bool mem_cgroup_out_of_memory(struct mem_cgroup *memcg, gfp_t gfp_mask,
 	if (mem_cgroup_margin(memcg) >= (1 << order))
 		goto unlock;
 
-	/*
-	 * A few threads which were not waiting at mutex_lock_killable() can
-	 * fail to bail out. Therefore, check again after holding oom_lock.
-	 */
-	ret = task_is_dying() || out_of_memory(&oc);
+	ret = out_of_memory(&oc);
 
 unlock:
 	mutex_unlock(&oom_lock);
@@ -2198,6 +2194,9 @@ int try_charge_memcg(struct mem_cgroup *memcg, gfp_t gfp_mask,
 	if (unlikely(current->flags & PF_MEMALLOC))
 		goto force;
 
+	if (unlikely(tsk_is_oom_victim(current)))
+		goto force;
+
 	if (unlikely(task_in_memcg_oom(current)))
 		goto nomem;
 

