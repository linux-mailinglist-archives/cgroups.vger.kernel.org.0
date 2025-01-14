Return-Path: <cgroups+bounces-6142-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 66B54A10CD3
	for <lists+cgroups@lfdr.de>; Tue, 14 Jan 2025 17:57:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1CDE83A92AC
	for <lists+cgroups@lfdr.de>; Tue, 14 Jan 2025 16:56:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 310601CAA7F;
	Tue, 14 Jan 2025 16:56:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="HeuG8adK"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F13F51C2324
	for <cgroups@vger.kernel.org>; Tue, 14 Jan 2025 16:56:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736873816; cv=none; b=T5Ydb+Aruc2tDCS1f7iLgNsnoys1VdcDiMypg0yO34cRMYlvKYK2Jo1zbdsdS90i3YM5R/TuMjiu1FpbqpYzHY2ZQiYuyB/fcb3EBny1a2mlFgW64cxHaznrcHCyhTTDm3UHVei8Vs61NpwNRMf5RV7nZRtTP8qJKMPTGoj4PGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736873816; c=relaxed/simple;
	bh=39D/Xi+vW60VERRJTbj1uNFzbyidxTF3OoZLKrTjLuE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oRmWGvzSg11N0zgRRXhP04wY7f+j+ZyCY4HuBUuR1NgCA/FwY8HS4s3y+a84HMCXZWz/jY/nZsfu3VVi2MwhAv0zZYOp61nSTi7mm3Q+zstFC1q7nezKlcee6xivL0Unq9gMmm9OAy+8bdf2T/Qp0Ao5Q6rc0ZJn8xZ9IqOakpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=HeuG8adK; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-aab925654d9so371426266b.2
        for <cgroups@vger.kernel.org>; Tue, 14 Jan 2025 08:56:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1736873812; x=1737478612; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=k+NCndVlSXNfCvU38YnHTIBhOsF9U+leIyffmLvzRwQ=;
        b=HeuG8adKtWA6+LMwnCOjyQJcOcWIBZ1vHlz8S0aty0TvWfrvPRwMolMM1QA8boQXpA
         zN0DzZZjatNSZt0qwZ54lf7obB0TGa5Ljijy+1Nyf2wnf2GJ1bFF7XZe0XfsI4ZYDxmM
         2j5iGEsCkUJZlkznWFQoohV95ukxUTytoQOYIHfDIWoFZezY76NHh0Hc4iT7R8nhdD7w
         3M1yAypkGSswCZYzLfuHSnCd06J2aYWNTq9iryiz2wQXNSdO+6UXGT4R6R1Qw2PDzrbC
         0fsS1OvX0E8YsZ5maUY7hc/tDFz2vTTe30ljZ29BZHy0e7C4ZPiKFSzWL+NBxSzlC9TH
         9pOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736873812; x=1737478612;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k+NCndVlSXNfCvU38YnHTIBhOsF9U+leIyffmLvzRwQ=;
        b=lXFGaUOAl/GzBC8yKmLuuo3iywIDESRtqMnN983CYrL7FjBevO0L4jj4UdanNuII7V
         jK7lIf/bZGDIKiEdKE5LOHGoMqpPk+Bm/0K5MlcWdAR6LpYSfIX1c9Y6KlgsriyMn67J
         1pL+xJB6W5aLc/1byQdtMBBXFnU4BCdWML5IlGWRW7X708gj2b0TQPY9BU6ZsA2Eg+ug
         M8SWxOMygziruUbgkYzDF1S3AXD8sU6/vY6fCpGzgyBT0IdM07p37fYXumAvs4Z9fRU1
         C2roVC8nP/PbRNdaV/HBWCr10yUpzzf6HM6ASnNX1Wwb+6sPz+WixNpd5y0nkudTgtwL
         GBvQ==
X-Forwarded-Encrypted: i=1; AJvYcCWt2rjtCqDCjzMcyeZ6y7Gt8dA9AhG+anBzrbamwIF0wHJjLkkc6Ve4rt9/KZfpOJP51H7HH529@vger.kernel.org
X-Gm-Message-State: AOJu0YyPj7FZ5q9f/3JyBJX7PWZtaYphYPPBY6BV+nn78I9CxXLBRqQf
	wyM3T1NbqKoMfkDo7UNXJqcukoDWqcSwPlV6DdqkSzlS5GuSzZdBWcI48QZI8q4=
X-Gm-Gg: ASbGncsTX9KwiL5h883Q24dgb56jDuAg4FFWnu/V6OQlAtkEK2lTHmFD+0ulRXHKfJG
	099C3l4Jf7rMov3IwibJ2/UCFgjBxglq12gTz+Es0g2mWNAn2VE4W8CmDrI1PTJZRb31rw55KID
	J0txinAXNrbW3JrLz4AP8VAzWNRJ6xmwYqg0JNa3Go13YfdFFGgjvaW6J0atSbw/TDQ9Sx8w7fj
	nWTRQAElxguGIL6UHfPYd8euLA5tiMkiPRcTdN7DX8AXTcl0Ylc2akfFwT4mPIACZ8ToA==
X-Google-Smtp-Source: AGHT+IH1ZgJew7m6NRAJoySqboWQ70RFJl30LWnHsy4ktkPD5nv9TCgRb5tHdsOAoWY46J8BU7kQWA==
X-Received: by 2002:a17:907:7da5:b0:aae:83c6:c679 with SMTP id a640c23a62f3a-ab2ab748f2cmr2569261666b.32.1736873812276;
        Tue, 14 Jan 2025 08:56:52 -0800 (PST)
Received: from localhost (109-81-90-202.rct.o2.cz. [109.81.90.202])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ab2c9562519sm653091866b.132.2025.01.14.08.56.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jan 2025 08:56:52 -0800 (PST)
Date: Tue, 14 Jan 2025 17:56:51 +0100
From: Michal Hocko <mhocko@suse.com>
To: Johannes Weiner <hannes@cmpxchg.org>
Cc: Yosry Ahmed <yosryahmed@google.com>, Rik van Riel <riel@surriel.com>,
	Balbir Singh <balbirs@nvidia.com>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	hakeel Butt <shakeel.butt@linux.dev>,
	Muchun Song <muchun.song@linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>, cgroups@vger.kernel.org,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	kernel-team@meta.com, Nhat Pham <nphamcs@gmail.com>
Subject: Re: [PATCH v2] memcg: allow exiting tasks to write back data to swap
Message-ID: <Z4aXU-piAytmZpbs@tiehlicka>
References: <20241212115754.38f798b3@fangorn>
 <CAJD7tkY=bHv0obOpRiOg4aLMYNkbEjfOtpVSSzNJgVSwkzaNpA@mail.gmail.com>
 <20241212183012.GB1026@cmpxchg.org>
 <Z2BJoDsMeKi4LQGe@tiehlicka>
 <20250114160955.GA1115056@cmpxchg.org>
 <Z4aU7dn_TKeeTmP_@tiehlicka>
 <Z4aWuD_-BkcEjvj7@tiehlicka>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z4aWuD_-BkcEjvj7@tiehlicka>

On Tue 14-01-25 17:54:17, Michal Hocko wrote:
> On Tue 14-01-25 17:46:39, Michal Hocko wrote:
> > On Tue 14-01-25 11:09:55, Johannes Weiner wrote:
> > > Hi,
> > > 
> > > On Mon, Dec 16, 2024 at 04:39:12PM +0100, Michal Hocko wrote:
> > > > On Thu 12-12-24 13:30:12, Johannes Weiner wrote:
> > [...]
> > > > > If we return -ENOMEM to an OOM victim in a fault, the fault handler
> > > > > will re-trigger OOM, which will find the existing OOM victim and do
> > > > > nothing, then restart the fault.
> > > > 
> > > > IIRC the task will handle the pending SIGKILL if the #PF fails. If the
> > > > charge happens from the exit path then we rely on ENOMEM returned from
> > > > gup as a signal to back off. Do we have any caller that keeps retrying
> > > > on ENOMEM?
> > > 
> > > We managed to extract a stack trace of the livelocked task:
> > > 
> > > obj_cgroup_may_swap
> > > zswap_store
> > > swap_writepage
> > > shrink_folio_list
> > > shrink_lruvec
> > > shrink_node
> > > do_try_to_free_pages
> > > try_to_free_mem_cgroup_pages
> > 
> > OK, so this is the reclaim path and it fails due to reasons you mention
> > below. This will retry several times until it hits mem_cgroup_oom which
> > will bail in mem_cgroup_out_of_memory because of task_is_dying (returns
> > true) and retry the charge + reclaim (as the oom killer hasn't done
> > anything) with passed_oom = true this time and eventually got to nomem
> > path and returns ENOMEM.  SUSE Labs
> 
> Btw. is there any actual reason why we cannot go nomem without going
> to the oom killer (just to bail out) and go through the whole cycle
> again? That seems arbitrary and simply burning a lot of cycle without
> much chances to make any better outcome
> 
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index 7b3503d12aaf..eb45eaf0acfc 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -2268,8 +2268,7 @@ int try_charge_memcg(struct mem_cgroup *memcg, gfp_t gfp_mask,
>  	if (gfp_mask & __GFP_RETRY_MAYFAIL)
>  		goto nomem;
>  
> -	/* Avoid endless loop for tasks bypassed by the oom killer */
> -	if (passed_oom && task_is_dying())
> +	if (task_is_dying())
>  		goto nomem;
>  
>  	/*

Just to clarify, only if we have strong reasons to keep bail out in the
oom killer path. If we go with the change proposed in the other email,
this doesn't make sense.
-- 
Michal Hocko
SUSE Labs

