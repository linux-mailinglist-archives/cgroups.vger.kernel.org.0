Return-Path: <cgroups+bounces-6156-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BC37A1114C
	for <lists+cgroups@lfdr.de>; Tue, 14 Jan 2025 20:42:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 94B6C188A56D
	for <lists+cgroups@lfdr.de>; Tue, 14 Jan 2025 19:42:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 238112063C1;
	Tue, 14 Jan 2025 19:42:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="av5O9o+Z"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A76B01F9F66
	for <cgroups@vger.kernel.org>; Tue, 14 Jan 2025 19:42:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736883743; cv=none; b=s/kH6bzrUlWCA3F19VCLVfyqcyzfKSxAge7I0AvdwFCJmSkoxh6SOk4lgtYtCLzOPJ2RJmZHMngX5xqSN8M9iLZxsLd/vSnUpXMKF7iedum3MArCVeGe6bwWasg+KtjceS0LvdmLEFWrbi2RdEKSpaw7CQ4FgfdxhVbyAYeY9lM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736883743; c=relaxed/simple;
	bh=JTqkWMq/nqpxm+udupUzLoShwoP5j0GD/S8afXZ6Fvw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lHlvKgotB7X8+FbGjqBlXd3AMTajuGFuJU8e63NCb3cQOcZWPwpbbStWtPjlJWoVN8SpOEsHMY3hJ9vm29ujLmKI9hZ3V4GAgk3K6n9iPMaHaUCM6Y/xc8JwjiJogneGoGZPkYLhDT+B2eS8SKK2YH/8iJLVORiOmwnlMS/5OZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=av5O9o+Z; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-aaedd529ba1so829811466b.1
        for <cgroups@vger.kernel.org>; Tue, 14 Jan 2025 11:42:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1736883740; x=1737488540; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=URutu6iZhZLQvnv3Wg+eMF7yoZlTyVi2IgQurCtdros=;
        b=av5O9o+Zu2tvfdGceS8tiXIbxbs5IQ6HSdbHIUx/LJ3ltZNi06RgIqBtO7yP7d2rE+
         5OVTQN8hYXGc4PJUvKNWNdSL7qmEioO+l7WTEDsvxn8iEBU+dlYERVufMwRL2SPf2bNV
         nWlB+1WlOdY1Z1qvHvsK++Oloh4TVW7cXmiiBgCY3w3yazF4YOlNLufNJQg/v9SByGy8
         VvHNbA5Uk7q7ss/HbHyQHz8i4ugRgi1z+m/L6LJrla3vUJpsjL0w6J+i7ZzQtMd5X/nW
         neDQf63W1BPtKJa4DHLboiG+6JYTAXez37hroAB4gZrhFxSrjL75IAOFsdO0n7D7eWUs
         DU0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736883740; x=1737488540;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=URutu6iZhZLQvnv3Wg+eMF7yoZlTyVi2IgQurCtdros=;
        b=S0kw+TveVx9KhCbvyQicE0bGh/Acu6p83/n2Ox34YkJcvVrxAy3t5V58sPZ8QZvJDW
         daRUQmyg5e5883PwNw7ZotOPa+fqqbOnJ/67kOCwI081TlcvC6o7u9yUVknIMeZI3ts4
         t0229BpAYJegXdO8SsVW8dq76sEXHF7RY5iMBZqRl/ldYjMhPdFaZ8IyPf1Kgo8/C/5L
         3YuAR3Chi/8AEZAud4t/ehABxZPyP6DoLfiiM72Io27iqUu/gN6Mf6ltoPDu557y0p/w
         XUgXXu0t7ImyrZhCbS8nvFd5a941n5NAlzHldZbd1ZzSOXRJ18gJQaAxmKQYWw60EMHY
         C2tQ==
X-Forwarded-Encrypted: i=1; AJvYcCWUcbgyq5nDut3GE0Z4QxpCVcoj6zNkGDphTgvQ3C2iCaBqxOd81s4fXhenojes9SEnYJWNJTgA@vger.kernel.org
X-Gm-Message-State: AOJu0YyNpcw65zMOX8P1nBXE6clG97sUyhZ5pZZM/KfqcxDqP4cnmfRW
	q6JfIQYGGtqLcVOWKo/gYqx8EBao6UbLi5wlinKFFdzISunWA64VwVt7lurmeWs=
X-Gm-Gg: ASbGnct4eRp5JMKLbTtMECVuZ1UE4qKU9F7QBa16amRaKgLUe5fglVteTfclZp/KUDJ
	sBAxbpjqE5snONbcsyXHjnP1qlkdtArI5PGxJO7A1Hc8LFdCedaoytL+UY9NeJ3jPLkKCHys3Wf
	VXaZF7SZ+3OGpjmZavhYBkuPGD145VnqbM5/mrMwvfLBO143UWzlPbAPmgaCl+Jfwfqp31mlA+I
	Zyj08AwtfPiShwfzbfDtaZtci5XZyReGjI/xpUGpoDQvSPoAyDY9pTV5rbcG2g4r54zbg==
X-Google-Smtp-Source: AGHT+IHX58DCazbPKYkixhcaH+ova41IeImuJ3K429IoKdaLrXLzYh2PmVvFh17MJ8hWqpFaLBoDxg==
X-Received: by 2002:a05:6402:321a:b0:5d3:cff5:635e with SMTP id 4fb4d7f45d1cf-5d972e63d86mr60948294a12.26.1736883740019;
        Tue, 14 Jan 2025 11:42:20 -0800 (PST)
Received: from localhost (109-81-90-202.rct.o2.cz. [109.81.90.202])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ab2c90d5c9asm662108266b.45.2025.01.14.11.42.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jan 2025 11:42:19 -0800 (PST)
Date: Tue, 14 Jan 2025 20:42:18 +0100
From: Michal Hocko <mhocko@suse.com>
To: Johannes Weiner <hannes@cmpxchg.org>
Cc: Rik van Riel <riel@surriel.com>, Yosry Ahmed <yosryahmed@google.com>,
	Balbir Singh <balbirs@nvidia.com>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	hakeel Butt <shakeel.butt@linux.dev>,
	Muchun Song <muchun.song@linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>, cgroups@vger.kernel.org,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	kernel-team@meta.com, Nhat Pham <nphamcs@gmail.com>
Subject: Re: [PATCH v2] memcg: allow exiting tasks to write back data to swap
Message-ID: <Z4a-GllRm7KABAu7@tiehlicka>
References: <CAJD7tkY=bHv0obOpRiOg4aLMYNkbEjfOtpVSSzNJgVSwkzaNpA@mail.gmail.com>
 <20241212183012.GB1026@cmpxchg.org>
 <Z2BJoDsMeKi4LQGe@tiehlicka>
 <20250114160955.GA1115056@cmpxchg.org>
 <Z4aU7dn_TKeeTmP_@tiehlicka>
 <af6b1cb66253ad045c9af7c954c94ad91230e449.camel@surriel.com>
 <Z4aYSdEamukBGAZi@tiehlicka>
 <193d98b0d5d2b14da1b96953fcb5d91b2a35bf21.camel@surriel.com>
 <Z4apM9lbuptQBA5Z@tiehlicka>
 <20250114192322.GB1115056@cmpxchg.org>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250114192322.GB1115056@cmpxchg.org>

On Tue 14-01-25 14:23:22, Johannes Weiner wrote:
> On Tue, Jan 14, 2025 at 07:13:07PM +0100, Michal Hocko wrote:
> > Anyway, have you tried to reproduce with 
> > diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> > index 7b3503d12aaf..9c30c442e3b0 100644
> > --- a/mm/memcontrol.c
> > +++ b/mm/memcontrol.c
> > @@ -1627,7 +1627,7 @@ static bool mem_cgroup_out_of_memory(struct mem_cgroup *memcg, gfp_t gfp_mask,
> >  	 * A few threads which were not waiting at mutex_lock_killable() can
> >  	 * fail to bail out. Therefore, check again after holding oom_lock.
> >  	 */
> > -	ret = task_is_dying() || out_of_memory(&oc);
> > +	ret = out_of_memory(&oc);
> >  
> >  unlock:
> >  	mutex_unlock(&oom_lock);
> > 
> > proposed by Johannes earlier? This should help to trigger the oom reaper
> > to free up some memory.
> 
> Yes, I was wondering about that too.
> 
> If the OOM reaper can be our reliable way of forward progress, we
> don't need any reserve or headroom beyond memory.max.
> 
> IIRC it can fail if somebody is holding mmap_sem for writing. The exit
> path at some point takes that, but also around the time it frees up
> all its memory voluntarily, so that should be fine. Are you aware of
> other scenarios where it can fail?

Setting MMF_OOM_SKIP is the final moment when oom reaper can act. This
is after exit_mm_release which releases futex. Also get_user callers
shouldn't be holding exclusive mmap_lock as that would deadlock when PF
path takes the read lock, right?

> What if everything has been swapped out already and there is nothing
> to reap? IOW, only unreclaimable/kernel memory remaining in the group.

Yes, this is possible. It is also possible the the oom victim depletes
oom reserves globally and fail the allocation resulting in the same
problem. Reserves do buy some time but do not solve the underlying
issue.

> It still seems to me that allowing the OOM victim (and only the OOM
> victim) to bypass memory.max is the only guarantee to progress.
> 
> I'm not really concerned about side effects. Any runaway allocation in
> the exit path (like the vmalloc one you referenced before) is a much
> bigger concern for exceeding the physical OOM reserves in the page
> allocator. What's a containment failure for cgroups would be a memory
> deadlock at the system level. It's a class of kernel bug that needs
> fixing, not something we can really work around in the cgroup code.

I do agreee that a memory deadlock is not really proper way to deal with
the issue. I have to admit that my understanding was based on ENOMEM
being properly propagated out of in kernel user page faults. It seems I
was wrong about that. On the other hand wouldn't that be a proper way to
deal with the issue? Relying on allocations never failing is quite
fragile.

-- 
Michal Hocko
SUSE Labs

