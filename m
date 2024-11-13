Return-Path: <cgroups+bounces-5547-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id ED6419C7E59
	for <lists+cgroups@lfdr.de>; Wed, 13 Nov 2024 23:42:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8E92A1F225BC
	for <lists+cgroups@lfdr.de>; Wed, 13 Nov 2024 22:42:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8798A18C01A;
	Wed, 13 Nov 2024 22:42:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="r0BRTHVH"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAE5118BBAB
	for <cgroups@vger.kernel.org>; Wed, 13 Nov 2024 22:42:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731537752; cv=none; b=t2ZoRvDSL6/bGAcEMNVpHRKoI/q1ydkkU10aVULRnDxoNMVWXqc4/+B2JGg3H/lxn/y2Gi84C0wRT3j0SYADR2PrIkXypAQAPshCfvd+BmZRVbN9tq+SXNG1AogRgoi5+SyDzApqIFvBPMSUQdR9az43uyObiwHVdr6Fk0k25w0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731537752; c=relaxed/simple;
	bh=9pNOROf7TWR2JtIXPLrhkgnISjLpTD0sYz1c27sb9UA=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=qUABcjZhwYcUV719HVXqbLK5FtsfI39mLkPbRspN77+QPWSqDCVRxYFC8b+POPE/E6gyihRM228J7MaG4vI658N2YoCpurfpsph0cZZHnkp9xP1YNV9JOhU6LbVfkWS+87btuEtREgc/443GwjCTd7G0cqazR9yo/NQd9tpYJ/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=r0BRTHVH; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-20c8ac50b79so42825ad.0
        for <cgroups@vger.kernel.org>; Wed, 13 Nov 2024 14:42:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1731537750; x=1732142550; darn=vger.kernel.org;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Ieehf+E6LMEA4ReJKxyD53FpolrCogZOFJkea/91AC4=;
        b=r0BRTHVHu02TqFQJqMnM+Lp6+CmD4WMpnWf53BBgInVK8eT6ZTYA8dHAKEJcwn9d1O
         BvacqPRgFhppIAfv2aZIe2DAoQ382H2d5b3sIwRlNLWETbBxM39WVaaboCv7VUJtrYor
         EPawi+T6kqzzT3Dhl8kmOj6Hu1AJArMcyV+mq04lxuyPnF+7Q6yyALN7QEIEq3N121yP
         Ukip6eVMO2+OjQUduGztBiPTSja4wHqbs95vAKrMRVcl5f+mFAvc4twFNwenKPNedg+Y
         ZDptKrHOTvCAJcMYb70X1LwOAlymme5zz3L0LUNBv20FRZL7+41Po7bHNstY6EFnwpmG
         3XTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731537750; x=1732142550;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ieehf+E6LMEA4ReJKxyD53FpolrCogZOFJkea/91AC4=;
        b=JY1a0CiNxXj2IhRrkzh/Bz3g5wD1gUvoNyF4L3sWayCDflIoYDpqABeUu7RWBgKTxa
         EhtUOsYY8foHPdk2ZXKQXu1pwOb5Hwx4tL1AAGYv8EsR9xcr2Okei4MhqALt38Gd98O/
         jThhyQYWJzodWewvLxLd6h8F5Fm2b7kFxjVrLRHF2YKeSc8eJ1lJKApdJLJ3RlpPHrHm
         Zj/l+YiyR+s25ZG0rm3gOeFuSLpg6/KVxMy/xZbFd+lkxkdNnM6IvTDlId+rah74ROfQ
         yDIr481350h3SwCmRY/rauLseEDNDYhYjRYY7mSjr5WKggI/2wNiT29FvMqjx3o1yC21
         8kFQ==
X-Forwarded-Encrypted: i=1; AJvYcCXov2NNDfY9tfrOWSWnZglZHGUuyGOJjmgBsbs7drGux+Qo0HHwjwhQrj4fWjk+M6XRyrp4Laxu@vger.kernel.org
X-Gm-Message-State: AOJu0YxWoHoIbkZQxdfQGwMbq/7u4qdubvw/QeVNrctj71XuQIZ+MFQh
	Km0s5kqvQl3/JQEKaAw9Qg+HQhdqw2ZqQF9tnHGwFmhXAMpEkyOgVaX3KJvbgQ==
X-Gm-Gg: ASbGnctERsFheKpCmsgTbnxCyEDrXKSZmh75OXb0UjJ1VVwRaLqEWO78QiQuWvOzFn1
	fAQid3ehGMDHCvexSR2YzWShItdUw9Zs6wilHLo6ZbpC0X9eA6i7Kwz4EklfJglZmL/qnHJ53ES
	b/GW7RS8j7DQnPBPtcBSb28Lm9lGya2vyAVYdIOmmgZIqtZtx82Q/3P97oTC3jtAyD6OwfcsaDI
	WNC3XKFq5WTzDyCg/C1WSc5Y2FrqDXJmZBydmDdJCm79r0hdUbZGIhYoTTQiy1d1g1SO0j5PcJZ
	Lu5L
X-Google-Smtp-Source: AGHT+IEEnqKMwGy+6M5UqJv9rrrpl3mUiwwjrWvoQVOQqROaho6ADPFiiCjrnLC1sQ4UdZv0xFkCzA==
X-Received: by 2002:a17:902:ea10:b0:20b:6c3c:d495 with SMTP id d9443c01a7336-211c369658amr254265ad.25.1731537750084;
        Wed, 13 Nov 2024 14:42:30 -0800 (PST)
Received: from [2620:0:1008:15:93ad:2d94:6e99:1a3c] ([2620:0:1008:15:93ad:2d94:6e99:1a3c])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72407a18f51sm13753218b3a.155.2024.11.13.14.42.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Nov 2024 14:42:29 -0800 (PST)
Date: Wed, 13 Nov 2024 14:42:29 -0800 (PST)
From: David Rientjes <rientjes@google.com>
To: Joshua Hahn <joshua.hahnjy@gmail.com>
cc: akpm@linux-foundation.org, hannes@cmpxchg.org, nphamcs@gmail.com, 
    shakeel.butt@linux.dev, roman.gushchin@linux.dev, muchun.song@linux.dev, 
    chris@chrisdown.name, tj@kernel.org, lizefan.x@bytedance.com, 
    mkoutny@suse.com, corbet@lwn.net, lnyng@meta.com, cgroups@vger.kernel.org, 
    linux-mm@kvack.org, linux-doc@vger.kernel.org, 
    linux-kernel@vger.kernel.org, kernel-team@meta.com
Subject: Re: [PATCH v4 1/1] memcg/hugetlb: Add hugeTLB counters to memcg
In-Reply-To: <eb4aada0-f519-02b5-c3c2-e6c26d468d7d@google.com>
Message-ID: <c41adcce-473d-c1a7-57a1-0c44ea572679@google.com>
References: <20241101204402.1885383-1-joshua.hahnjy@gmail.com> <72688d81-24db-70ba-e260-bd5c74066d27@google.com> <CAN+CAwPSCiAuyO2o7z20NmVUeAUHsNQacV1JvdoLeyNB4LADsw@mail.gmail.com> <eb4aada0-f519-02b5-c3c2-e6c26d468d7d@google.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Mon, 11 Nov 2024, David Rientjes wrote:

> > The reason that I opted not to include a breakdown of each hugetlb
> > size in memory.stat is only because I wanted to keep the addition that
> > this patch makes as minimal as possible, while still addressing
> > the goal of bridging the gap between memory.stat and memory.current.
> > Users who are curious about this breakdown can see how much memory
> > is used by each hugetlb size by enabling the hugetlb controller as well.
> > 
> 
> While the patch may be minimal, this is solidifying a kernel API that 
> users will start to count on.  Users who may be interested in their 
> hugetlb usage may not have control over the configuration of their kernel?
> 
> Does it make sense to provide a breakdown in memory.stat so that users can 
> differentiate between mapping one 1GB hugetlb page and 512 2MB hugetlb 
> pages, which are different global resources?
> 
> > It's true that this is the case as well for total hugeltb usage, but
> > I felt that not including hugetlb memory usage in memory.stat when it
> > is accounted by memory.current would cause confusion for the users
> > not being able to see that memory.current = sum of memory.stat. On the
> > other hand, seeing the breakdown of how much each hugetlb size felt more
> > like an optimization, and not a solution that bridges a confusion.
> > 
> 
> If broken down into hugetlb_2048kB and hugetlb_1048576kB on x86, for 
> example, users could still do sum of memory.stat, no?>
> 

Friendly ping on this, would there be any objections to splitting the 
memory.stat metrics out to be per hugepage size?

