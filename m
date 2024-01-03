Return-Path: <cgroups+bounces-1058-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 25A6982305B
	for <lists+cgroups@lfdr.de>; Wed,  3 Jan 2024 16:19:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A0F93B235D3
	for <lists+cgroups@lfdr.de>; Wed,  3 Jan 2024 15:19:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8CB21C293;
	Wed,  3 Jan 2024 15:19:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fnPRijBf"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-oi1-f180.google.com (mail-oi1-f180.google.com [209.85.167.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F4BE1C28F;
	Wed,  3 Jan 2024 15:19:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f180.google.com with SMTP id 5614622812f47-3bbbc6bcc78so5634591b6e.1;
        Wed, 03 Jan 2024 07:19:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704295149; x=1704899949; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=mkbPs4444YRyYU4hJG9uetQFelUwLH+/+EH+jJ2Bxuw=;
        b=fnPRijBfpK7HedBZcA5ag1nfIHsob1ocGQDd/4XvNQoNdRUXDosii8CfSmYHm7/w48
         M7a0UYVe9WfnFMcxLZRcMqbArDAQgnpdpoWdyoiFWqYrJA9voGK1sEHgm/AbtWCdG7sI
         JByM9IV3e1M2bjEbKi6VQel24JfmA6XpFbwzRj+l30feOQpfusiBn2Mzigkcyngi9WFa
         RLadqHu6irLSIEHtduVe7lMDuIuRnRKp8J2LpM1Zm35x3BzBlyOMIR4b0r0kfKNI/g0A
         NAYtcpUJlJxo4UQnUd5YnZAVCZDUlFyhWDsqtKi/dtaunFVpz4C1SGQws6KMF6Y9QagV
         1YeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704295149; x=1704899949;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mkbPs4444YRyYU4hJG9uetQFelUwLH+/+EH+jJ2Bxuw=;
        b=TZ3WJJPMgnGOBxo5pULD9VZCxO5Ha40eoT7F2zXolfn5AjFECMSmaPe276GKlQHvsp
         Tya45F6yowaRLOtK5aIYVb3Fy3ah78Ou4hL2jVzoVPnhEl3foyfnv9IAei9j8H/sAQRC
         1pnXuXf0IIu4DQ0yjY6rghCvSrj2/3nEF0Mn+QoVuTZfbkVUzlKbFzPE+GbA3Uxn+Rts
         ydgyZNrca/RF7L0ecNgCt3Lz5Eu+Nid8XYd4dO/WMI9UnhDyHWvO8yWEcDHnv57h18JU
         Cvq8gVa7H+AjrsoqvBPmI3za19QM4nOY6rqqShRUYtrEaTjQM0tvTvb/11uYEZiF4Kqo
         5jIg==
X-Gm-Message-State: AOJu0YxLvjiG2AuugnDNx1EGbQ7UVnehpm320ZuTYjN0VF1mgk+kYM44
	HJ1VAms3h9cKTRPt/65+Us11pZkg4uNkOQ==
X-Google-Smtp-Source: AGHT+IE/4UtBydxpuImA+JNyF2+X+hT0PY7wZ9CUtkqSYxvv8ZWUgE2mBwuZmwOefEdh4F9Phtv51g==
X-Received: by 2002:a05:6808:7094:b0:3bb:9b28:96c9 with SMTP id ku20-20020a056808709400b003bb9b2896c9mr16454662oib.86.1704295149182;
        Wed, 03 Jan 2024 07:19:09 -0800 (PST)
Received: from dschatzberg-fedora-PC0Y6AEN ([2620:10d:c091:400::5:fcab])
        by smtp.gmail.com with ESMTPSA id i13-20020a0cfccd000000b0067ffcfb0b51sm8323789qvq.139.2024.01.03.07.19.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jan 2024 07:19:08 -0800 (PST)
Date: Wed, 3 Jan 2024 10:19:06 -0500
From: Dan Schatzberg <schatzberg.dan@gmail.com>
To: Yu Zhao <yuzhao@google.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Yosry Ahmed <yosryahmed@google.com>, Huan Yang <link@vivo.com>,
	linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
	linux-mm@kvack.org, Tejun Heo <tj@kernel.org>,
	Zefan Li <lizefan.x@bytedance.com>,
	Jonathan Corbet <corbet@lwn.net>, Michal Hocko <mhocko@kernel.org>,
	Shakeel Butt <shakeelb@google.com>,
	Muchun Song <muchun.song@linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>,
	Kefeng Wang <wangkefeng.wang@huawei.com>,
	SeongJae Park <sj@kernel.org>,
	"Vishal Moola (Oracle)" <vishal.moola@gmail.com>,
	Nhat Pham <nphamcs@gmail.com>, Yue Zhao <findns94@gmail.com>
Subject: Re: [PATCH v5 2/2] mm: add swapiness= arg to memory.reclaim
Message-ID: <ZZV66igbHQShq7-k@dschatzberg-fedora-PC0Y6AEN>
References: <20231220152653.3273778-1-schatzberg.dan@gmail.com>
 <20231220152653.3273778-3-schatzberg.dan@gmail.com>
 <CAOUHufYwPzZ7k=ecFkxaw+26hUkiTODEnmKM8b3=Lk=n+bm29w@mail.gmail.com>
 <ZZQqCHmocwUFvuTz@dschatzberg-fedora-PF3DHTBV>
 <CAOUHufaTDcLNipHQC3sJuoOVcCkKnmzHt=tiiZrOxmOg5EUVYA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOUHufaTDcLNipHQC3sJuoOVcCkKnmzHt=tiiZrOxmOg5EUVYA@mail.gmail.com>

On Tue, Jan 02, 2024 at 05:27:18PM -0700, Yu Zhao wrote:
[...]
> > Helper aside, I disagree with this point about coupling with the
> > proactive flag.
> 
> Sure. But I would like to hear a *concrete* counterexample.
> 
> > The fact that the only user currently is proactive
> > reclaim
> 
> Yes, that's a fact, and we should make the decision based on the
> current known facts.
> 
> > doesn't imply to me that the interface (in scan_control)
> > should be coupled to the use-case.
> 
> Future always has its uncertainty which I would not worry so much about.
> 
> > It's easier to reason about a
> > swappiness field that overrides swappiness for all scans that set it
> > regardless of the users.
> 
> For example? And how likely would that happen in the next few years?

My argument isn't that making the interface more generic will be
worthwhile due to some future use-case. Rather my argument is that
making the interface more generic makes the code simpler. All else
being equal, having sc->swappiness behave the same regardless of
sc->proactive makes vmscan.c and struct scan_control easier to follow.

That being said - I'm fine with conceding this point - particularly
since both you and Michal appear to feel similarly. I'll make the
corresponding change and send out a new version.

