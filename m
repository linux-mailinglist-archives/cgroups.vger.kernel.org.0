Return-Path: <cgroups+bounces-3747-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C62EA93425E
	for <lists+cgroups@lfdr.de>; Wed, 17 Jul 2024 20:44:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 38BEB2838F3
	for <lists+cgroups@lfdr.de>; Wed, 17 Jul 2024 18:44:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB5691836CC;
	Wed, 17 Jul 2024 18:43:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dvIBS5ry"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3F111822CA
	for <cgroups@vger.kernel.org>; Wed, 17 Jul 2024 18:43:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721241839; cv=none; b=Ad9von3z5c32bXP4/lILfhFZtujREAyc3mVvSni5K59Wdr/NTkZksNJGf3LDMLIoemh2iN9Ujayck4x9zIez4HidBvEvwQp7n4LkaTjnzKVUbkRKfU6ONkpzkNbhmKD4s/eg8GORbI94/hyrRVxZvP5umN3SW2UjIxmPphIH+xM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721241839; c=relaxed/simple;
	bh=K4IFnmEXsaTDJkNINgh/bn2QU1W1CN8bTFfUBICjeXQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZLvW9jb7AO9zJoVazoPqKIi48r5BB+urT0Kb8TZ/SWkuhBjybdmXasJEQX18xAh8+PwhOtF4LWyYrQEJp47gZT19m3jpjHc0LEicKNfj/lh9nhUXWHVWUasNTiC49UV+JlLbFsbr7395F8oEtg90wy7vzxsvahGvJ0ptYbJDFHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dvIBS5ry; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-5a108354819so862267a12.0
        for <cgroups@vger.kernel.org>; Wed, 17 Jul 2024 11:43:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1721241836; x=1721846636; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ZrLop0WXR5l6C8CwplY6UuCHzt6tM7NAzgoyEdBYBm8=;
        b=dvIBS5ryc43WhECjXSiqIgw+1v29zukjH3hmZuhplTyoF36ex7usWuepKPUChWqpWz
         +iQHXReQOsOUspYLvVRXZVI/MapTDcSKZDLFhiEeO06JjCEVRhcnqqs5JPXwipOazzGh
         k7HkhNTthgKyuWFB8VdQ1FeSwF7s8TwbCCZGMM5gzKvH8nzxzbP0yQ0PgErHkz4poWyu
         cSrnnqPw6zzscU8Zzt/T+q2oDtw/ySKr8fldanD8oLZZYPOaisvKEcm7w93G/H16kwBF
         0YjkNiaNKt82eUY272kERH0wl0byeESeuL9vG6mEt6So/+kKH2DWuQtcxROb3bW07fvt
         YN8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721241836; x=1721846636;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZrLop0WXR5l6C8CwplY6UuCHzt6tM7NAzgoyEdBYBm8=;
        b=Ctaj8V0k/RIYV7b9/5OkxLLRAP+Z0gm7sVnoKrkICjw80UwoYOHSFJSJawgzj8YNtl
         waOqDCbJ0H+Qj7oL1oE/l9fHrN4ps1Y0ejtTevN9+Zjcqem4OrFE+gqMaHLkGB8mlff1
         qlCRpnCrE5bHg9iLNttM7MlwHCeR06xr+Kw4P4MWVx+ELZymKfrBTcrs4+IjugBja7Co
         fGblKjZ9t+ZnuEzqu8EbAmL3v9f5OvRvhwdCGDHz72201FImnG9pJO+P8+/cGQlnXnsC
         KOsaa+7ftYDZN5zdWSAnS8xhitPSWIgGsaf0hkJ1C1LlSmSi0QLwIg++p46FwDEfQQlZ
         UFbA==
X-Forwarded-Encrypted: i=1; AJvYcCWK6vh6D75OwrFxjfR3Ze99DzrNVs7xlUxm7OZ3074tC6zFf2A+A9dic4P7agsIg0KNIazBPCunXlxNDEcNWiioqIIEWvhSmQ==
X-Gm-Message-State: AOJu0YwY6+yvPln00gEyL4nku53yUvlWEAyjjE5lLDRk9OJMyKx9BqfK
	Ku8qug091Zkdx9f27uo28J9jQD0nQ5E5ZCLSs8lyedoPIOlh0oFm0WcKSGChPYcdWmW6KUIZWbM
	kk55cXNupQpI9wAO0W5MG/vPvAU1NLdXolZ8b
X-Google-Smtp-Source: AGHT+IF8RdKoDfVtGRrva1w5brn8g7mEl2nXivUh40LMHs36jzVVAz3m0gkm067oLrutSxcYTkEZdggGOrahc9xfi4E=
X-Received: by 2002:a17:906:384c:b0:a6f:e75b:2b39 with SMTP id
 a640c23a62f3a-a7a011d333amr149443066b.42.1721241835572; Wed, 17 Jul 2024
 11:43:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <172070450139.2992819.13210624094367257881.stgit@firesoul>
 <CAJD7tkYFwz_=kxCk-Tp4QfwKgK0C26+QzZQvbVxkAx8m9CLSFg@mail.gmail.com>
 <8c123882-a5c5-409a-938b-cb5aec9b9ab5@kernel.org> <CAJD7tkbFPt-eTHkqtLxuOoV59eaqauodz008btEECT--x3VcBA@mail.gmail.com>
 <de05ebf2-2baa-493e-a6a8-acf43702824b@kernel.org>
In-Reply-To: <de05ebf2-2baa-493e-a6a8-acf43702824b@kernel.org>
From: Yosry Ahmed <yosryahmed@google.com>
Date: Wed, 17 Jul 2024 11:43:17 -0700
Message-ID: <CAJD7tkaxQeGbTckq-9Oepp=n56i-871SmCBjgjz2VBMOU1L7DA@mail.gmail.com>
Subject: Re: [PATCH V7 1/2] cgroup/rstat: Avoid thundering herd problem by
 kswapd across NUMA nodes
To: Jesper Dangaard Brouer <hawk@kernel.org>
Cc: tj@kernel.org, cgroups@vger.kernel.org, shakeel.butt@linux.dev, 
	hannes@cmpxchg.org, lizefan.x@bytedance.com, longman@redhat.com, 
	kernel-team@cloudflare.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

[..]
> > What I think we should be doing is either supporting multiple
> > ongoing_flushers (by replacing the global variable with a per-cgroup
> > flag, perhaps), or biting the bullet and start using a mutex to drop
> > lock yielding. If there aren't any concerns beyond priority inversion
> > (raised by Shakeel), maybe adding a mutex_lock_timeout() variant as I
> > suggested could fix this issue (and also put a bound on the flushing
> > latency in general)?
> >
>
> The mutex_lock_timeout is an interesting idea, but not a primitive we
> have available today, right?

We don't, but Waiman said it shouldn't be difficult to add:
https://lore.kernel.org/lkml/623e62c5-3045-4dca-9f2c-ed15b8d3bad8@redhat.com/

>
> p.s. I have 5 prod machines running with mutex change, and I've not
> gotten any SRE complaints.

That's nice!

>
>
> > (I suppose the latter is preferrable)
> >
> >>
> >> IMHO we should go back to only doing ongoing_flusher for root-cgroup.
> >> There is really low chance of sub-trees flushes being concurrent enough
> >> to benefit from this, and it cause issues and needs (ugly) race handling.
> >>
> >> Further more sub-tree flushing doesn't take as long time as level 0
> >> flushing, which further lower the chance of concurrent flushes.
> >
> > I agree that the race handling is not pretty, and we can try to
> > improve the implementation or handle the race in other ways. However,
> > I think that skipping flushes for subtrees is valuable. I am not sure
> > about the cgroup arrangement in your use case, but we do have cgroups
> > with a lot of tasks in them (and/or child cgroups). If there is memory
> > pressure (or hit the cgroup limit), they all may go into direct
> > reclaim concurrently, so skipping flushes could really be beneficial.
> >
> > Of course, if the difference in complexity is not justified, we can go
> > back to only supporting root cgroups for ongoing_flusher for now. But
> > as I mentioned in the v4 email thread, some of the complexity may
> > still remain anyway as we have multiple root cgroups in v1.
> >
>
> Having an incremental step with "only supporting root cgroups for
> ongoing_flusher for now" is a good step forward IMHO.
> As you could see in grafana plot, this would be a significant production
> improvement on its own, as it avoids wasting CPU resources spinning on
> the lock.

I am not opposed to this at all. All I am saying is, if we need to
handle most complexity anyway due to multiple root cgroups in v1, then
might as well support subtrees too.

>
> Being able to have multiple root cgroups, due to in v1, does pose an
> implementation problem.  Only having a single root, would allow to have
> a race-free cmpxchg scheme.
> Would it be reasonable to only support v2?

The rstat code has so far been v1/v2 agnostic AFAICT, and Google is
still using cgroup v1, so I naturally prefer we keep supporting both
v1 and v2 going forward.

> If so, how can I match on this?

cgroup_on_dfl() is basically testing if a cgroup is on v2, but I
really want to keep v1 included if possible :/

>
> >>
> >> Let's get some quick data on flush times from production, to support my
> >> claim:
> >
> > Thanks for the data. I agree that in general root flushes will be a
> > lot more expensive than subtree flushes, but keep in mind that the
> > data may look really different depends on the cgroup setup. As I
> > mentioned, I think we should still support subtree flushes unless the
> > difference in complexity is not justified.
> >
>
> It would be really valuable if you could provide production data on the
> lock-hold times, just like I did with below bpftrace script...
> Is that possible, please?

Unfortunately, we don't have the infrastructure to do this :/

But again, I am not objecting to only supporting root cgroups as
ongoing flushers for now if there is a justifiable complexity
difference. So this shouldn't be a blocker.

