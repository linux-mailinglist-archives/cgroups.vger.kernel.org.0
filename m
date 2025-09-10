Return-Path: <cgroups+bounces-9964-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 416E5B5219D
	for <lists+cgroups@lfdr.de>; Wed, 10 Sep 2025 22:11:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8FB281C25571
	for <lists+cgroups@lfdr.de>; Wed, 10 Sep 2025 20:11:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23D152EC0AF;
	Wed, 10 Sep 2025 20:11:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="wYzwEVRQ"
X-Original-To: cgroups@vger.kernel.org
Received: from out-178.mta0.migadu.com (out-178.mta0.migadu.com [91.218.175.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C4A02DFA2B
	for <cgroups@vger.kernel.org>; Wed, 10 Sep 2025 20:10:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757535062; cv=none; b=H8FfFQQIjoVHkr77KTEwM/7FheD1+73hSn84aVdrInSPqAgB51Ji77n3wRg1opCYvkTuRggp1hx0lgTwS2kGdVaUGa5eRTCXqEanqT+duADdrN3Kzc8KOEY3OIIfeMLjqTipq/d33gSLIkqM06ZuuWwFvBWVWzrsY1U5yOPwIuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757535062; c=relaxed/simple;
	bh=ylKTcQHSRL5RMvOHqG8C6MhC6SqMyvQve4rvJ7Q9Xzc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FECPqA1f/U5oDe3m9FzUEXi4SF1YqvRJGSlhJzimkLHzVTnIFhWghb7QI7B4DTi4nFasg47cOsw7hpMKCO/gu0MC6olQ7wSWgMnRCeJQhWAzStxl1dRkFluNisDxv5Mbz+MDYOlv/pVD4/SDvCol1ENVZ/czGYMf04GXIWrQiJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=wYzwEVRQ; arc=none smtp.client-ip=91.218.175.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Wed, 10 Sep 2025 13:10:46 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1757535057;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hroFfDYim2M+I/skY/6mfFB67MLHNWA5J2KjItQQBug=;
	b=wYzwEVRQKupEK0mCQ9z8hXiGFJmQcdgWnSF2QejHrWUqwPc9FmKhqCW8nLgEiBdbTXahBI
	C0nyztrs4gxTVU0gdhZCitVEdqtLNht7iWU+G5fa/ysQ4BRBtKRFuCzKrwUamQKF9m7dKA
	Md7kHIiRsVdnyAQ0xIaDbBPdwTre8vk=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Suren Baghdasaryan <surenb@google.com>
Cc: Lei Liu <liulei.rjpt@vivo.com>, Michal Hocko <mhocko@suse.com>, 
	David Rientjes <rientjes@google.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Kemeng Shi <shikemeng@huaweicloud.com>, Kairui Song <kasong@tencent.com>, Nhat Pham <nphamcs@gmail.com>, 
	Baoquan He <bhe@redhat.com>, Barry Song <baohua@kernel.org>, Chris Li <chrisl@kernel.org>, 
	Johannes Weiner <hannes@cmpxchg.org>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Muchun Song <muchun.song@linux.dev>, David Hildenbrand <david@redhat.com>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>, 
	Brendan Jackman <jackmanb@google.com>, Zi Yan <ziy@nvidia.com>, 
	"Peter Zijlstra (Intel)" <peterz@infradead.org>, Chen Yu <yu.c.chen@intel.com>, Hao Jia <jiahao1@lixiang.com>, 
	"Kirill A. Shutemov" <kas@kernel.org>, Usama Arif <usamaarif642@gmail.com>, 
	Oleg Nesterov <oleg@redhat.com>, Christian Brauner <brauner@kernel.org>, 
	Mateusz Guzik <mjguzik@gmail.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Al Viro <viro@zeniv.linux.org.uk>, 
	Fushuai Wang <wangfushuai@baidu.com>, "open list:MEMORY MANAGEMENT - OOM KILLER" <linux-mm@kvack.org>, 
	open list <linux-kernel@vger.kernel.org>, 
	"open list:CONTROL GROUP - MEMORY RESOURCE CONTROLLER (MEMCG)" <cgroups@vger.kernel.org>
Subject: Re: [PATCH v0 0/2] mm: swap: Gather swap entries and batch async
 release
Message-ID: <qisfqncqgkgxh2nj5axafunlfjen6oiciobcrmpus6l3xwrbyj@blxv73pbhzez>
References: <20250909065349.574894-1-liulei.rjpt@vivo.com>
 <fszpgct7ywqy6qq3qnjflol3theovmgnau2wgdqqdxin4q7ezm@zumgw533hxon>
 <CAJuCfpFaTj8PsXkoYRQKQ0sOu+mKikUAE8Wbcx+YpZXZ4M7cMA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJuCfpFaTj8PsXkoYRQKQ0sOu+mKikUAE8Wbcx+YpZXZ4M7cMA@mail.gmail.com>
X-Migadu-Flow: FLOW_OUT

On Tue, Sep 09, 2025 at 12:48:02PM -0700, Suren Baghdasaryan wrote:
> On Tue, Sep 9, 2025 at 12:21 PM Shakeel Butt <shakeel.butt@linux.dev> wrote:
> >
> > On Tue, Sep 09, 2025 at 02:53:39PM +0800, Lei Liu wrote:
> > > 1. Problem Scenario
> > > On systems with ZRAM and swap enabled, simultaneous process exits create
> > > contention. The primary bottleneck occurs during swap entry release
> > > operations, causing exiting processes to monopolize CPU resources. This
> > > leads to scheduling delays for high-priority processes.
> > >
> > > 2. Android Use Case
> > > During camera launch, LMKD terminates background processes to free memory.
> >
> > How does LMKD trigger the kills? SIGKILL or cgroup.kill?
> 
> SIGKILL
> 
> >
> > > Exiting processes compete for CPU cycles, delaying the camera preview
> > > thread and causing visible stuttering - directly impacting user
> > > experience.
> >
> > Since the exit/kill is due to low memory situation, punting the memory
> > freeing to a low priority async mechanism will help in improving user
> > experience. Most probably the application (camera preview here) will get
> > into global reclaim and will compete for CPU with the async memory
> > freeing.
> >
> > What we really need is faster memory freeing and we should explore all
> > possible ways. As others suggested fix/improve the bottleneck in the
> > memory freeing path. In addition I think we should explore parallelizing
> > this as well.
> >
> > On Android, I suppose most of the memory is associated with single or
> > small set of processes and parallelizing memory freeing would be
> > challenging. BTW is LMKD using process_mrelease() to release the killed
> > process memory?
> 
> Yes, LMKD has a reaper thread which wakes up and calls
> process_mrelease() after the main LMKD thread issued SIGKILL.
> 

Thanks Suren. I remember Android is planning to use Apps in cgroup. Is
that still the plan? I am actually looking into cgroup.kill, beside
sending SIGKILL, putting the processes of the target cgroup in the oom
reaper list. In addition, making oom reaper able to reap processes in
parallel. I am hoping that functionality to be useful to Android as
well.
> >

