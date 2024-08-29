Return-Path: <cgroups+bounces-4564-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C0FC896437B
	for <lists+cgroups@lfdr.de>; Thu, 29 Aug 2024 13:50:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 736572826E9
	for <lists+cgroups@lfdr.de>; Thu, 29 Aug 2024 11:50:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1051B1922E8;
	Thu, 29 Aug 2024 11:50:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="NEbT+z78"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C35C918CC10
	for <cgroups@vger.kernel.org>; Thu, 29 Aug 2024 11:50:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724932252; cv=none; b=sJjG6tlx+0+TPw2vAdMri6obEPOQIMaVfgXvVej0xsuxI0IeGIBInOd29XnsHL+rcwGdlkS4CMfGt8W8QQ5S5ZIaCXoFdLz7eJq9VZ/5BeIToTXH4fDxXSS8AYlgNcLC3b650RNh6roK3fhPUqsnoDZvEiCe2KYObWsYE1jXmms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724932252; c=relaxed/simple;
	bh=ucQRYpAs/iuundAbzq8GmfWweMsIUzDVz8dEo1q63/4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nT0MfjBzXyQ0E6dZRPArKrWc9goDqJBkYfKm6G7pytCQ2mH/GcKzIZpN7kukxKA1pb944i4DRa94gNl1khgWwIVbNlXDvdLnJCy4Fg50x5Ya93/abRLBelZLl4LNlOP3K1pNWpai1MD7hZtIUo1BcX/X3VUqTdFj8+eY73142ww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=NEbT+z78; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-42812945633so5085075e9.0
        for <cgroups@vger.kernel.org>; Thu, 29 Aug 2024 04:50:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1724932249; x=1725537049; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=DIO5qiw4yauFIXiZ7VjLTOR2SQbB7twhVj/N0jkHHp0=;
        b=NEbT+z78FJ79qKhmAiGBKlEL6X02cyjjqNBWYDxmgCrHxer1GxfAcbrmmArdmnJtCS
         /G9+YKKf7MD3saqkxmTAgVaUF5cqMAqxgoBafZ5EHly9ffo8PhEWBExzI2sT7eK7RPjs
         N4lPHTzmRIA2adpT17aoErbEpU9mC1YLA7Bc2TUTaZ1j8vK/Ax7wk13YyOBREFmu41j/
         MF+32dF4lUvRqgZh60F2WhfMxZNHO4wkIoCSCxDCMVEz4LqmJtjtr2T+jTmDS3Db/HsP
         yXedrlAmmICl2L1L7AycFapRNtf477/iyS/oB7sU9qEIXTO1jaq07zM4omBo1QP/Qc9Y
         K3RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724932249; x=1725537049;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DIO5qiw4yauFIXiZ7VjLTOR2SQbB7twhVj/N0jkHHp0=;
        b=S2xLHxm/EJZ6Vklhh7qk7Olcapu1MCPWfDXGfvKuIkPhsbRqKiPKbxnhbp9D35tQcR
         Ed+uNi+DFrPIihF/jH5A+w0gGtGDB8tKTGi9fGZn+VHHSUJPfPi+m+PTUczOwZFyFpOc
         rB++mDZLqM2hx6hL2uKKte4gbYBGOdW+bsPboiKA40MRCc6IdfcgkfSb58hOxp9rl7E+
         u38+WL6dG0CPPPOvLsg26diKzr478H7F+G3HPojK5q7YIl7Z7ngC7OlMvhed959MW3qz
         cq/BgImyy/OyCiQXsCJTwhQHTB1aY7OYBAFEgcR/jxY4v2GSAPcGDz3KtKwT1Dnb5VvO
         dTjw==
X-Forwarded-Encrypted: i=1; AJvYcCUt9mjjhEZ4fCFK1BbJSUU/qn33JCradNNEa8FVRrMDOXXcti3F5nuGvQfSp+VwMC9cADLIUaWk@vger.kernel.org
X-Gm-Message-State: AOJu0YwkrCenDKykZmvOtVTeUxRcc4Cqky6l2GtSkLtpLqIaqPWqYPF7
	Tsu81FVVckVlZXMTYq8T9akKC01JaNb9pcAN/Fbc9e7rT7WTulr7u0kTq+owz8Q=
X-Google-Smtp-Source: AGHT+IEmpkM9Gew6lNJX7xRAVX0JcsJ0hRG43Yp3mQUWq5l3vmuNVuzZ82AG7V3Prs/kjd7q1ANG1A==
X-Received: by 2002:a05:600c:4f07:b0:426:6138:34b3 with SMTP id 5b1f17b1804b1-42bb023cdeemr21431665e9.5.1724932248954;
        Thu, 29 Aug 2024 04:50:48 -0700 (PDT)
Received: from localhost (109-81-82-19.rct.o2.cz. [109.81.82.19])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42bb87f7fccsm7945595e9.46.2024.08.29.04.50.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Aug 2024 04:50:48 -0700 (PDT)
Date: Thu, 29 Aug 2024 13:50:47 +0200
From: Michal Hocko <mhocko@suse.com>
To: Zhongkun He <hezhongkun.hzk@bytedance.com>
Cc: akpm@linux-foundation.org, hannes@cmpxchg.org, roman.gushchin@linux.dev,
	shakeel.butt@linux.dev, muchun.song@linux.dev,
	lizefan.x@bytedance.com, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, cgroups@vger.kernel.org
Subject: Re: [External] Re: [RFC PATCH 0/2] Add disable_unmap_file arg to
 memory.reclaim
Message-ID: <ZtBglyqZz_uGDnOS@tiehlicka>
References: <20240829101918.3454840-1-hezhongkun.hzk@bytedance.com>
 <ZtBMO1owCU3XmagV@tiehlicka>
 <CACSyD1Ok62n-SF8fGrDQq_JC4SUSvFb-6QjgjnkD9=JacCJiYg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACSyD1Ok62n-SF8fGrDQq_JC4SUSvFb-6QjgjnkD9=JacCJiYg@mail.gmail.com>

On Thu 29-08-24 18:37:07, Zhongkun He wrote:
> On Thu, Aug 29, 2024 at 6:24 PM Michal Hocko <mhocko@suse.com> wrote:
> >
> > On Thu 29-08-24 18:19:16, Zhongkun He wrote:
> > > This patch proposes augmenting the memory.reclaim interface with a
> > > disable_unmap_file argument that will skip the mapped pages in
> > > that reclaim attempt.
> > >
> > > For example:
> > >
> > > echo "2M disable_unmap_file" > /sys/fs/cgroup/test/memory.reclaim
> > >
> > > will perform reclaim on the test cgroup with no mapped file page.
> > >
> > > The memory.reclaim is a useful interface. We can carry out proactive
> > > memory reclaim in the user space, which can increase the utilization
> > > rate of memory.
> > >
> > > In the actual usage scenarios, we found that when there are sufficient
> > > anonymous pages, mapped file pages with a relatively small proportion
> > > would still be reclaimed. This is likely to cause an increase in
> > > refaults and an increase in task delay, because mapped file pages
> > > usually include important executable codes, data, and shared libraries,
> > > etc. According to the verified situation, if we can skip this part of
> > > the memory, the task delay will be reduced.
> >
> > Do you have examples of workloads where this is demonstrably helps and
> > cannot be tuned via swappiness?
> 
> Sorry, I put the test workload in the second patch. Please have a look.

I have missed those as they are not threaded to the cover letter. You
can either use --in-reply-to when sending patches separately from the
cover letter or use can use --compose/--cover-leter when sending patches
through git-send-email

> Even if there are sufficient anonymous pages and a small number of
> page cache and mapped file pages, mapped file pages will still be reclaimed.
> Here is an example of anonymous pages being sufficient but mapped
> file pages still being reclaimed:
> Swappiness has been set to the maximum value.
> 
> cat memory.stat | grep -wE 'anon|file|file_mapped'
> anon 3406462976
> file 332967936
> file_mapped 300302336
> 
> echo 1g > memory.reclaim swappiness=200 > memory.reclaim
> cat memory.stat | grep -wE 'anon|file|file_mapped'
> anon 2613276672
> file 52523008
> file_mapped 30982144

This seems to be 73% (ano) vs 27% (file) balance. 90% of the 
file LRU seems to be mapped which matches 90% of file LRU reclaimed
memory to be mapped. So the reclaim is proportional there.

But I do understand that this is still unexpected when swappiness=200
should make reclaim anon oriented. Is this MGLRU or regular LRU
implementation?

Is this some artificial workload or something real world?


-- 
Michal Hocko
SUSE Labs

