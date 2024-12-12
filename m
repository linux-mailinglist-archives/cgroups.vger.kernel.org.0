Return-Path: <cgroups+bounces-5873-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AD1D49EFD99
	for <lists+cgroups@lfdr.de>; Thu, 12 Dec 2024 21:45:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D52DE188B071
	for <lists+cgroups@lfdr.de>; Thu, 12 Dec 2024 20:45:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 846091BC9F4;
	Thu, 12 Dec 2024 20:45:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b="Zeo3jD5f"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FFD61917D6
	for <cgroups@vger.kernel.org>; Thu, 12 Dec 2024 20:45:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734036326; cv=none; b=EBB3egDS/ma2INEhoYOFU2fD+vL5tdzyK1UB/TdfktRaBluPkIoirQRTSEw+l5rKj9Po8m+791STlo/0MtZ3gjFhAhH6HNTpV8IoqUxTdRgH/UvS2k8jzmSInlMDeOII+DXru1BTU5vzMadbO8zD+XjTgBcb0eeSZJlc4XFMEv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734036326; c=relaxed/simple;
	bh=nrj2pIbXa4KtNNUR/+3Perd5taMS9cdX0+a2FZqzY/Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hLnu/yQhFu6c6tMMs6X1BiMS32N0Z9uKL4CuizkSIFjPiIxZrrwzLL6l7VG5mndAwW5tP2bku0yR0DVwbhz0E1u9hNyIx9wSCs3UXXF4PgotC1yCDglDrHRawKcxwe2QNd6owcFr2FQ+a/YUK1gbZK24bg0a3bnvhRSPIhM00iY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b=Zeo3jD5f; arc=none smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-6d8918ec243so11741276d6.1
        for <cgroups@vger.kernel.org>; Thu, 12 Dec 2024 12:45:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20230601.gappssmtp.com; s=20230601; t=1734036318; x=1734641118; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=TyQT77h23X+xU78cV1YaX8EfQe1q/U0zcpXq7aqXgvk=;
        b=Zeo3jD5fkpghhzSQAxZVTI4cxuXOS05hFQ7N7NtScnfaWCUxRCoHStnQNXSooi/D6g
         Yjb5t4+INN6afrPn3sK/A9RvZD10BqrpA8fmtq0N0X7Y/YTKPfxCGecLM9iteEK/9GHC
         QiuNk7kzSyVBP02ov1rHNQ220Che6rnq4txSVkm+1UVD3FI2u8uee5EpGkkqu11gPOC+
         oX7N/QHcQtDBWJGFfmwG/WHw+gUhuGOeLWAow479x6MyuTR0hCNJC07G87P83dED8DlT
         J0MrNAfHnKcFF4SjSKxGTgXgHE9tz+Xsz54fMq/1BrOFmnRQyk/37jJXkBjP6/pLZDgS
         jgRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734036318; x=1734641118;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TyQT77h23X+xU78cV1YaX8EfQe1q/U0zcpXq7aqXgvk=;
        b=WMya2XrSWYcBpzLP6IYxT9u5QRKIubFsKdDdm85QphRtOyxswZmbZ/GACiu8ZdMD2M
         TaZV+0JqRUEp4FppTAZTpJLk9xMTpdYijqOZw4y+9aLB2hqN0Mrn3SHzl5wZniKmjCHl
         CycTL5L/EOOGocintn2Bh2GJqpf2soAewI+4Hg0ceiq/eOH+Uy71j0TpejURUl0Qej8i
         9MORNivTQCspzCAeu9jIwugeIMB3qB/xvx46qyfVyeS420Lio1dO0R71+3zKPAJumFlA
         lAtnGrIp+K8Y8mi0fFYcAHT0u4c8D5WApdVQcUn3iyvRCWgg0yCYyT3sHeGRpb21ynEz
         oQdQ==
X-Forwarded-Encrypted: i=1; AJvYcCVhfzmRIqo5Eip6A10BwYVGft8X+hdocwbuRb7GuaPmmJyLjOK+/RctBRruBP6QZpFf1NEIuMbW@vger.kernel.org
X-Gm-Message-State: AOJu0YxpFt3pqAP+s1Q+9jIZwJSqClf75gAG48QwhIQeTAEoSBAR4m/P
	igv84F5dIZ13dFz+4pJpqCF5XKOVP9XMrG2TuG1ui+TzuK1miLJ8boB4pUQdrU5mspggfeNkQRQ
	H
X-Gm-Gg: ASbGncvX07Brs+J4AI9YFNUsIHKoknvU4xv7oweUZ1LKMqGkoSPMuX4TeFdTrMnpeZ4
	Qv0MowaWq/fC0rLUGqY2+9YUn4QwlrzV8dCCpaMCbH3BPopgY9IkfBifzBBnAcjlVO6/H3J5Bcq
	NUSF3476p8INP0CI8ev89sGHVJNSmqJlWwtOTHdA6mAghFOSaL9UKS3NNFh+pXhl1uXCqVv26Yw
	O+MVyLQ0bCE13iG5Mzfn+ZMaI3nAbsJpFzRtd6kqn+1Uk/NEIBvrks=
X-Google-Smtp-Source: AGHT+IFOLo1qW5rYvlQMb9BVGyYA7xOiMNbLd35SK/ZwdxiRQHpN+3OFqqXCWMQMrYJZ8PDm6T7V9g==
X-Received: by 2002:a05:6214:248d:b0:6d8:b3a7:75ba with SMTP id 6a1803df08f44-6db0f827d9dmr29607546d6.45.1734036318577;
        Thu, 12 Dec 2024 12:45:18 -0800 (PST)
Received: from localhost ([2603:7000:c01:2716:97cf:7b55:44af:acd6])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6d8da6b651asm85285236d6.69.2024.12.12.12.45.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Dec 2024 12:45:17 -0800 (PST)
Date: Thu, 12 Dec 2024 12:45:13 -0800
From: Johannes Weiner <hannes@cmpxchg.org>
To: Michal Hocko <mhocko@suse.com>
Cc: Rik van Riel <riel@surriel.com>, kernel-team@meta.com,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Muchun Song <muchun.song@linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>, cgroups@vger.kernel.org
Subject: Re: [PATCH] mm: allow exiting processes to exceed the memory.max
 limit
Message-ID: <20241212204513.GA50370@cmpxchg.org>
References: <20241209124233.3543f237@fangorn>
 <Z1cyExTkg3OoaJy5@tiehlicka>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z1cyExTkg3OoaJy5@tiehlicka>

On Mon, Dec 09, 2024 at 07:08:19PM +0100, Michal Hocko wrote:
> On Mon 09-12-24 12:42:33, Rik van Riel wrote:
> > It is possible for programs to get stuck in exit, when their
> > memcg is at or above the memory.max limit, and things like
> > the do_futex() call from mm_release() need to page memory in.
> > 
> > This can hang forever, but it really doesn't have to.
> 
> Are you sure this is really happening?
> 
> > 
> > The amount of memory that the exit path will page into memory
> > should be relatively small, and letting exit proceed faster
> > will free up memory faster.
> > 
> > Allow PF_EXITING tasks to bypass the cgroup memory.max limit
> > the same way PF_MEMALLOC already does.
> > 
> > Signed-off-by: Rik van Riel <riel@surriel.com>
> > ---
> >  mm/memcontrol.c | 9 +++++----
> >  1 file changed, 5 insertions(+), 4 deletions(-)
> > 
> > diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> > index 7b3503d12aaf..d1abef1138ff 100644
> > --- a/mm/memcontrol.c
> > +++ b/mm/memcontrol.c
> > @@ -2218,11 +2218,12 @@ int try_charge_memcg(struct mem_cgroup *memcg, gfp_t gfp_mask,
> >  
> >  	/*
> >  	 * Prevent unbounded recursion when reclaim operations need to
> > -	 * allocate memory. This might exceed the limits temporarily,
> > -	 * but we prefer facilitating memory reclaim and getting back
> > -	 * under the limit over triggering OOM kills in these cases.
> > +	 * allocate memory, or the process is exiting. This might exceed
> > +	 * the limits temporarily, but we prefer facilitating memory reclaim
> > +	 * and getting back under the limit over triggering OOM kills in
> > +	 * these cases.
> >  	 */
> > -	if (unlikely(current->flags & PF_MEMALLOC))
> > +	if (unlikely(current->flags & (PF_MEMALLOC | PF_EXITING)))
> >  		goto force;
> 
> We already have task_is_dying() bail out. Why is that insufficient?

Note that the current one goes to nomem, which causes the fault to
simply retry. It doesn't actually make forward progress.

> It is currently hitting when the oom situation is triggered while your
> patch is triggering this much earlier. We used to do that in the past
> but this got changed by a4ebf1b6ca1e ("memcg: prohibit unconditional
> exceeding the limit of dying tasks"). I believe the situation in vmalloc
> has changed since then but I suspect the fundamental problem that the
> amount of memory dying tasks could allocate a lot of memory stays.

Before that patch, *every* exiting task was allowed to bypass. That
doesn't seem right, either. But IMO this patch then tossed the baby
out with the bathwater; at least the OOM vic needs to make progress.

> There is still this
> :     It has been observed that it is not really hard to trigger these
> :     bypasses and cause global OOM situation.
> that really needs to be re-evaluated.

This is quite vague, yeah. And not clear if a single task was doing
this, or a large number of concurrently exiting tasks all being
allowed to bypass without even trying. I'm guessing the latter, simply
because OOM victims *are* allowed to tap into the page_alloc reserves;
we'd have seen deadlocks if a single task's exit path vmallocing could
blow the lid on these.

I sent a patch in the other thread, we should discuss over there. I
just wanted to address those two points made here.

