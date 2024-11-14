Return-Path: <cgroups+bounces-5563-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CD34A9C90A2
	for <lists+cgroups@lfdr.de>; Thu, 14 Nov 2024 18:17:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4D857B341FB
	for <lists+cgroups@lfdr.de>; Thu, 14 Nov 2024 16:43:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61EF6183CC9;
	Thu, 14 Nov 2024 16:42:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cqKAdBR6"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 976C91D540;
	Thu, 14 Nov 2024 16:42:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731602562; cv=none; b=VgiCXw6amcE4TrtNNq4KMAbYb9fy3C5MFWLnVLrvNQVnfH5WtbSgScYmfF2+zCBp7Vuc4xLf5/328WL/btJDI5dnA/dvBSOHfzTqRSb4FmdgSfFAMeFFcBL/1AqJoxis2gHU+KxcSJ/y0B4arQxTfFOogkaFuSev2RBLdyrHQsw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731602562; c=relaxed/simple;
	bh=EXWomfnT+ApZcO/IprwozV2gtI1HXz9uTXKD+QoSRIM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lAZrSldULIsF8T35B2/d/QGmoqOYBPUK/Yc0YxHeqfyc3Tcq4eVnF6Bg6PVcvyzMw9FIuKlzPIqRevn5arrKi+788lD+CCgpm1tt1SP9V6ue1YLgWB/U61wWhuuIyvE74xO38k0qoS7IxAJ1p6VTJz3TRiyGMmUOwy655W86N0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cqKAdBR6; arc=none smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-6ea5003deccso9669907b3.0;
        Thu, 14 Nov 2024 08:42:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731602559; x=1732207359; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ddOsfjQA/2oCKHO1HaWymRb5TSJ6GIPEt0qm/4J2cyE=;
        b=cqKAdBR63nRcCczvAnfSTW0Tjur9AhMdSFloD8lO5frzXnr5w7NwMQ6611L2ysM7UW
         UVsQpbRVoIYPY91o66tiPheMLK/AZX7LlYPaQ8clbfymFW7Lc8MI81ZrYPKedKAIt3j9
         rzglETBctFPjKeQWgXcbQwy8O4L3oP/Qpt1cqCrxJ+LyPt9HZ6oGNx/hNDm+aRERgvOd
         ippN8ziArPMjLSU6EbiIjY1Xt4rbsa7iLiCBCyGTGjWx/LmxgK2VQc51T9ZIubnPDFYX
         nfWPgOqd7QogGl82DKczPf7AplZ0PJdkMpEMQOV52OKPs9mBlaYjEy2rRF/hHjSWvFlJ
         9O8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731602559; x=1732207359;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ddOsfjQA/2oCKHO1HaWymRb5TSJ6GIPEt0qm/4J2cyE=;
        b=tFrybpPwXycIdGN41VXiaZHP9z3m8Dw7D/rvrdRnwuIC9y54bijOO2trSV/NtNhRR7
         Reo6Rhe9YZ5raPSUFasblzrNRnI2pa6Z/2F35xcOKXEVGNzMiv5pSSTy4bTKCtL40hzp
         V4QcVf7nOtERqIS/w6qCqucyCxJ+/kZRkeeslvC9LcHcAL77H90ctun4NAIwDWIOGUf/
         0YKYfiF99tIYqR5l6TUu2hP94QwRzMPb9csh7XDWJeoMzhsZRNuHzE/vL5ahfYcazIfW
         C7tNv0olJiisuslGOdudUscxO1Yu4YpUBpPAD9aH2A+cDQA9ZujRYa7fL1t+udZgqHa6
         uQLg==
X-Forwarded-Encrypted: i=1; AJvYcCUSR+p2jE0jHeS/SAMLTbAmVYEZHWne7dB/zTxxaqkclXVkEVQVQJYiFaaHekCFScZcQZC744Tc@vger.kernel.org, AJvYcCUYzssWfyFoUJDDzolwxU55uZwrIWWHP1cuZxBSdLDu57mABp0j6gj7ITtl31zhQfCJTsVvEUi5olN22hil@vger.kernel.org, AJvYcCWqE2IZnRzzZv/TgDhAVV+WGA7Jq2vIt7B9YLsRXiQspuuKoeuzE6il7MJoRXaXSqzdDB1nKOwvpJbA@vger.kernel.org
X-Gm-Message-State: AOJu0YzP4zg92I59IUQSAYp5JojC66nMS3MGYW4TK5E4elmVWIR87pKj
	sqJeB8VxlSKNa2SB++tE6nKXOurMFl1Gpn7S0sCpDhmT1gtjb6lg
X-Google-Smtp-Source: AGHT+IHOjUhiYk7Hb1BJ54uGaSVNyjUBIW5p9q05WgczyNwz6DZIXTBgRjjqTPGcZw4cE5k5Yrv9Qg==
X-Received: by 2002:a05:690c:4d4a:b0:6ea:5da9:34cc with SMTP id 00721157ae682-6ee4333d176mr30454287b3.7.1731602559639;
        Thu, 14 Nov 2024 08:42:39 -0800 (PST)
Received: from localhost (fwdproxy-frc-022.fbsv.net. [2a03:2880:21ff:16::face:b00c])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6ee4444783fsm3129317b3.104.2024.11.14.08.42.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Nov 2024 08:42:39 -0800 (PST)
From: Joshua Hahn <joshua.hahnjy@gmail.com>
To: David Rientjes <rientjes@google.com>
Cc: akpm@linux-foundation.org,
	hannes@cmpxchg.org,
	nphamcs@gmail.com,
	shakeel.butt@linux.dev,
	roman.gushchin@linux.dev,
	muchun.song@linux.dev,
	chris@chrisdown.name,
	tj@kernel.org,
	lizefan.x@bytedance.com,
	mkoutny@suse.com,
	corbet@lwn.net,
	lnyng@meta.com,
	cgroups@vger.kernel.org,
	linux-mm@kvack.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kernel-team@meta.com
Subject: Re: [PATCH v4 1/1] memcg/hugetlb: Add hugeTLB counters to memcg
Date: Thu, 14 Nov 2024 08:42:15 -0800
Message-ID: <20241114164236.1790279-1-joshua.hahnjy@gmail.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <c41adcce-473d-c1a7-57a1-0c44ea572679@google.com>
References: 
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Wed, 13 Nov 2024 14:42:29 -0800 (PST) David Rientjes <rientjes@google.com> wrote:

Hi David,

Sorry for the late response on this thread. To be completely transparent
with you, I am not someone who inspects hugetlb usage on a regular
basis, so I may not have the most relevant insights when it comes to
how much utility there would be from breaking down the usage by size.

With that said, I believe that over the past couple of days, there have
been some responses on this thread regarding how others use hugetlb. As you
know, I share Johannes's opinion that if there are people who would benefit
from splitting up the hugetlb usage across different page sizes, it should
happen in the hugetlb controller. 

> On Mon, 11 Nov 2024, David Rientjes wrote:
> > While the patch may be minimal, this is solidifying a kernel API that 
> > users will start to count on.  Users who may be interested in their 
> > hugetlb usage may not have control over the configuration of their kernel?

This is a good point. With that said, I believe that this is an instance
of a feature where both of our proposed ideas can co-exist; we can have the
total hugetlb usage reported in memcg for now, and if there is a consensus 
/ majority that would like to see the breakdown as well, we can introduce
it in a future patch without breaking the utility of this patch.

To quickly address a potential concern of bloating the already large memcg
stat: including both the total and breakdown wouldn't be the first time
a stat and its breakdown are both included: there is a precedent with this
in slab_(un)reclaimable and slab. 

> > Does it make sense to provide a breakdown in memory.stat so that users can 
> > differentiate between mapping one 1GB hugetlb page and 512 2MB hugetlb 
> > pages, which are different global resources?
> > 
> > > It's true that this is the case as well for total hugeltb usage, but
> > > I felt that not including hugetlb memory usage in memory.stat when it
> > > is accounted by memory.current would cause confusion for the users
> > > not being able to see that memory.current = sum of memory.stat. On the
> > > other hand, seeing the breakdown of how much each hugetlb size felt more
> > > like an optimization, and not a solution that bridges a confusion.
> > > 
> > 
> > If broken down into hugetlb_2048kB and hugetlb_1048576kB on x86, for 
> > example, users could still do sum of memory.stat, no?>

This is true! I still think it would be nice to include the total anyways,
since for a lot of people who use this statistic (Nhat's response in this
thread and Shakeel's response in the v3 of this patch), all they want is
a quick check to see how much memory is being used by hugetlb so they can
reason about memory dynamics. Again, I think that if we are to include
a breakdown in a future patch, it can coexist with this one.

> Friendly ping on this, would there be any objections to splitting the 
> memory.stat metrics out to be per hugepage size?

Sorry for the late reponse again. I think that if you had examples of use
cases where having the differnt page sizes, it would help me better
understand a motivation for including the breakdown (I would be happy
to write the patch for the breakdown as well if there is a consensus!)

Thank you for your thoughts, have a great day!
Joshua

