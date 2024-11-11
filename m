Return-Path: <cgroups+bounces-5512-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E503A9C43E9
	for <lists+cgroups@lfdr.de>; Mon, 11 Nov 2024 18:42:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A4D0A2816F8
	for <lists+cgroups@lfdr.de>; Mon, 11 Nov 2024 17:42:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C26A1A9B54;
	Mon, 11 Nov 2024 17:41:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Q1MnQIPV"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 666151A76B7
	for <cgroups@vger.kernel.org>; Mon, 11 Nov 2024 17:41:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731346871; cv=none; b=hMYiEUe+0dSYTvs7sbwl159CItPVaAmFExd0rRHqtY5wa3IO87AuySuLG4HbW6me8mV3nJwPkVWSAFwXhPl9NJebEst4QpibUuoX6wOtdDtYrdhayW1AZzj/yAUEJW5ZBEsMcw0RDX7mEORAmBOpBRcXYAvcE/ahU4ZMlFbB7Y8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731346871; c=relaxed/simple;
	bh=WE626Jhme0ym7/q8fggm9jaQXx4lOcP4ZRcFhn00/PU=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=Ld3IfWy0mAIuxJrR+oN7gV75JwmYpqalxkPU40cfXPjzLawvi3LUA3t+58aAMV0QqjsMCbPU+DfLS2IG7uUfLRw841ELwZjkgAUGgenl5dIr4p/ehxX0+t3wNO6Do8lnjQVYtbc3u99PbnoVg4IizIZXFEb4ZD28pBWrFgQoil4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Q1MnQIPV; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-20ca4877690so291735ad.1
        for <cgroups@vger.kernel.org>; Mon, 11 Nov 2024 09:41:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1731346870; x=1731951670; darn=vger.kernel.org;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=spB5wl1urQkI+7B+IPtWDDKj9S/WJUklG9CxIStging=;
        b=Q1MnQIPVS7F2oJA4F+M/9PKEYdh3yaA+H+cHuer6HOalSuZKrsURYy03ic8CEvwwGK
         DvJnIgEAnFAiqZVehHNuJ3OEe+4qnqeGpJPhb/eQ1G+7EfVLyXK52aooe+DqgaUnkhtn
         dmaNQLWFZ7Pmsf8jB2USj9mdu4LyYZoAm42VRYFFazT/tEvPsW6+6kg6zDTJt+NgKWS0
         wG5axKeZ1InEXeVTmxT5AcMMKJE2EdfFv6ZHUwKuj4AHahBRlPj53RzhLFL9CtLLuV/m
         FrYjnLcE9nY1jVEV4BlHHWYteIccUrKRTUSUu5i26ELmwtcuClivdNQE2cxALe8eCUwa
         +Qsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731346870; x=1731951670;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=spB5wl1urQkI+7B+IPtWDDKj9S/WJUklG9CxIStging=;
        b=cSxk0Cy0LSuEE5ScmpBq0FFwpw9MTz09GCbY6dRqJkSHZPLSU88bPYDxvPSD4Iin4j
         qT7kqQTbE1brOq9ls2NxbYyVTO9RNxesD6vvIxTnWZVt+8c/chRbUpi0Ia/JxGhCWSbD
         seuxIXIvqHYmTTdpdEpgA4jNS/bWiQU2OWPsKcJFB+vo/Kmd2kbrDlQPEEHNjuZ3+gI1
         Sxb/bLyruv/Laypxb8/3vn5eNENxzkf3oYzImOSAIW+EgkK0P2lYPZP79h3GYLHJSIk/
         kk88VaSn9gikYEwliddk8rOxu5SuiQ98VWtgW5cxEGjrxWSkQi+r60R3DXKgRTLJTwfE
         DxwA==
X-Forwarded-Encrypted: i=1; AJvYcCX4wkg6QJ1/4lgsQUb6Um6i2XQand6LGMFNhit64Is5drelgK93VHOLUkDDTKbpd79EwAwz6Tn5@vger.kernel.org
X-Gm-Message-State: AOJu0YxJ85h1985eVM00u0CsEky7YGAFT3RX+yUSBsl+vFn+ZzkhF4/l
	5OA+x2FGDHAvdbLEslxLCd/K6NDc0OZuXjfCwzBondCOKYqK4k12EpgiZLekeQ==
X-Gm-Gg: ASbGncuYxsH9DTApA2JdWl8Lo6QwZDWZeeg2smV7zM92KGQXKeorBEVZ0lQJdS1wVZG
	XtEMdn5Xyvj9IlpfJtEtpvWqXZPQ3XbfN27nMFTrUmIhL1RtunCvv2ymgUl+/FF45WSTNAeRNbD
	nJvLfI/isICwULBrgmtQvUthJ6E1PoDh2aXIcPQGb1G0+iNW9oDZkMV1OJNksrzAbxYGYJL381j
	M6NQ0frKvV7VaH1XV//OoZP/lNL2yE7q/DYtKyKWGPaidRdwuEpwuKRIBzXoPu1ZO3/eFR2rOjP
	S5zu
X-Google-Smtp-Source: AGHT+IHi97GLH/TqT3OzZu+s1FpiP4ABTo0w4bQUtXQTxsCqbBljDo6Rmx3Z4cy0o9PUG5WKfE9Bkg==
X-Received: by 2002:a17:902:db0a:b0:20b:13a8:9f86 with SMTP id d9443c01a7336-2118df842dfmr4318285ad.28.1731346869501;
        Mon, 11 Nov 2024 09:41:09 -0800 (PST)
Received: from [2620:0:1008:15:ae3b:d774:6c29:d63c] ([2620:0:1008:15:ae3b:d774:6c29:d63c])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21177e4196asm78754925ad.162.2024.11.11.09.41.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Nov 2024 09:41:09 -0800 (PST)
Date: Mon, 11 Nov 2024 09:41:08 -0800 (PST)
From: David Rientjes <rientjes@google.com>
To: Joshua Hahn <joshua.hahnjy@gmail.com>
cc: akpm@linux-foundation.org, hannes@cmpxchg.org, nphamcs@gmail.com, 
    shakeel.butt@linux.dev, roman.gushchin@linux.dev, muchun.song@linux.dev, 
    chris@chrisdown.name, tj@kernel.org, lizefan.x@bytedance.com, 
    mkoutny@suse.com, corbet@lwn.net, lnyng@meta.com, cgroups@vger.kernel.org, 
    linux-mm@kvack.org, linux-doc@vger.kernel.org, 
    linux-kernel@vger.kernel.org, kernel-team@meta.com
Subject: Re: [PATCH v4 1/1] memcg/hugetlb: Add hugeTLB counters to memcg
In-Reply-To: <CAN+CAwPSCiAuyO2o7z20NmVUeAUHsNQacV1JvdoLeyNB4LADsw@mail.gmail.com>
Message-ID: <eb4aada0-f519-02b5-c3c2-e6c26d468d7d@google.com>
References: <20241101204402.1885383-1-joshua.hahnjy@gmail.com> <72688d81-24db-70ba-e260-bd5c74066d27@google.com> <CAN+CAwPSCiAuyO2o7z20NmVUeAUHsNQacV1JvdoLeyNB4LADsw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Mon, 11 Nov 2024, Joshua Hahn wrote:

> > > diff --git a/Documentation/admin-guide/cgroup-v2.rst b/Documentation/admin-guide/cgroup-v2.rst
> > > index 69af2173555f..bd7e81c2aa2b 100644
> > > --- a/Documentation/admin-guide/cgroup-v2.rst
> > > +++ b/Documentation/admin-guide/cgroup-v2.rst
> > > @@ -1646,6 +1646,11 @@ The following nested keys are defined.
> > >         pgdemote_khugepaged
> > >               Number of pages demoted by khugepaged.
> > >
> > > +       hugetlb
> > > +             Amount of memory used by hugetlb pages. This metric only shows
> > > +             up if hugetlb usage is accounted for in memory.current (i.e.
> > > +             cgroup is mounted with the memory_hugetlb_accounting option).
> > > +
> > >    memory.numa_stat
> > >       A read-only nested-keyed file which exists on non-root cgroups.
> > >
> >
> > Definitely makes sense to include this.
> >
> > Any reason to not account different hugetlb page sizes separately in this
> > stat, however?  IOW, should there be separate hugetlb_2048kB and
> > hugetlb_1048576kB stats on x86?
> 
> Hello David, Thank you for reviewing my patch!
> 
> The reason that I opted not to include a breakdown of each hugetlb
> size in memory.stat is only because I wanted to keep the addition that
> this patch makes as minimal as possible, while still addressing
> the goal of bridging the gap between memory.stat and memory.current.
> Users who are curious about this breakdown can see how much memory
> is used by each hugetlb size by enabling the hugetlb controller as well.
> 

While the patch may be minimal, this is solidifying a kernel API that 
users will start to count on.  Users who may be interested in their 
hugetlb usage may not have control over the configuration of their kernel?

Does it make sense to provide a breakdown in memory.stat so that users can 
differentiate between mapping one 1GB hugetlb page and 512 2MB hugetlb 
pages, which are different global resources?

> It's true that this is the case as well for total hugeltb usage, but
> I felt that not including hugetlb memory usage in memory.stat when it
> is accounted by memory.current would cause confusion for the users
> not being able to see that memory.current = sum of memory.stat. On the
> other hand, seeing the breakdown of how much each hugetlb size felt more
> like an optimization, and not a solution that bridges a confusion.
> 

If broken down into hugetlb_2048kB and hugetlb_1048576kB on x86, for 
example, users could still do sum of memory.stat, no?>

> I have not had a scenario where I had to look at the breakdown of the
> hugetlb sizes (without the hugetlb controller), or a scenario where not
> knowing this causes some sort of confusion. If others have had this
> problem, I would love to hear about it, and perhaps work on a solution
> that can address this point as well!
> 
> I hope you have a great day!

You too!

