Return-Path: <cgroups+bounces-9965-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F42CB521A5
	for <lists+cgroups@lfdr.de>; Wed, 10 Sep 2025 22:12:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CF546168A9C
	for <lists+cgroups@lfdr.de>; Wed, 10 Sep 2025 20:12:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95DA22E0907;
	Wed, 10 Sep 2025 20:12:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="RiMLFgPL"
X-Original-To: cgroups@vger.kernel.org
Received: from out-179.mta1.migadu.com (out-179.mta1.migadu.com [95.215.58.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 887E53BBF0
	for <cgroups@vger.kernel.org>; Wed, 10 Sep 2025 20:12:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757535148; cv=none; b=SpbJ/bIf0W8ptefKaT7DJ1HuaQkUC9T0LPNxa3l1Qsf/Uhy4jHjviTDMKfYypKYSpZuDov55PS6yj9+LM6sL3QnHQPr30zkxXMJBcmW8OsEcaimbCndqM/F2m+NrALUgAnNQrzDKAw8xOcVHZB9HWHudY8ViPZkhwFKJvJcSHos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757535148; c=relaxed/simple;
	bh=Cvj8xivdSMy3PaQcLvH8a/pOHucCui5YpgUwp3+nqCE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MyLcGhi5/6yPxDe8sB6EBV020GyvIFQaEqx72oz8lYn6YixVcFvEdTvYXjEUJg9xJLr6JO8cnTPi2bk8xgaLWKlgP67cgUgQ/aSwpZLU2q2HBL1zqkZ6NofpoS+ohxagbOZbEhUPQsoFHXeHkbyNV8ie1LBQmXGFJehEibnIBbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=RiMLFgPL; arc=none smtp.client-ip=95.215.58.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Wed, 10 Sep 2025 13:12:00 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1757535134;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gR5yuuzaP05+dnCBzQFX9tuMWKZshj48LMZ7zdf2Gm0=;
	b=RiMLFgPL2eLugE3IfLCZDeAqKTtRLfUqMUjt0lINJzqe3IK5Hy+nwR33Xz4+ABuS3RzqR8
	GdhQ2MZQm0CbXP7aQOJLvOd/mIm7InoprUnNwSnFMbkOjO6IC9TvzAyKmDM0A21EjLA8so
	kmmOUhrW17f9pHzyHX7FLHPot7il8Oo=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Lei Liu <liulei.rjpt@vivo.com>
Cc: Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, 
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
Message-ID: <uwqrobr5xqtvav73srbe6v2nccgtoy2456vpgzemwex26lwsq7@2g74vl5oomfx>
References: <20250909065349.574894-1-liulei.rjpt@vivo.com>
 <fszpgct7ywqy6qq3qnjflol3theovmgnau2wgdqqdxin4q7ezm@zumgw533hxon>
 <CAJuCfpFaTj8PsXkoYRQKQ0sOu+mKikUAE8Wbcx+YpZXZ4M7cMA@mail.gmail.com>
 <b74b1e28-8479-4b14-9210-5b4334d3ce22@vivo.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b74b1e28-8479-4b14-9210-5b4334d3ce22@vivo.com>
X-Migadu-Flow: FLOW_OUT

On Wed, Sep 10, 2025 at 10:14:04PM +0800, Lei Liu wrote:
> 
> On 2025/9/10 3:48, Suren Baghdasaryan wrote:
> > On Tue, Sep 9, 2025 at 12:21 PM Shakeel Butt <shakeel.butt@linux.dev> wrote:
> > > On Tue, Sep 09, 2025 at 02:53:39PM +0800, Lei Liu wrote:
> > > > 1. Problem Scenario
> > > > On systems with ZRAM and swap enabled, simultaneous process exits create
> > > > contention. The primary bottleneck occurs during swap entry release
> > > > operations, causing exiting processes to monopolize CPU resources. This
> > > > leads to scheduling delays for high-priority processes.
> > > > 
> > > > 2. Android Use Case
> > > > During camera launch, LMKD terminates background processes to free memory.
> > > How does LMKD trigger the kills? SIGKILL or cgroup.kill?
> > SIGKILL
> > 
> > > > Exiting processes compete for CPU cycles, delaying the camera preview
> > > > thread and causing visible stuttering - directly impacting user
> > > > experience.
> > > Since the exit/kill is due to low memory situation, punting the memory
> > > freeing to a low priority async mechanism will help in improving user
> > > experience. Most probably the application (camera preview here) will get
> > > into global reclaim and will compete for CPU with the async memory
> > > freeing.
> > > 
> > > What we really need is faster memory freeing and we should explore all
> > > possible ways. As others suggested fix/improve the bottleneck in the
> > > memory freeing path. In addition I think we should explore parallelizing
> > > this as well.
> > > 
> > > On Android, I suppose most of the memory is associated with single or
> > > small set of processes and parallelizing memory freeing would be
> > > challenging. BTW is LMKD using process_mrelease() to release the killed
> > > process memory?
> > Yes, LMKD has a reaper thread which wakes up and calls
> > process_mrelease() after the main LMKD thread issued SIGKILL.
> 
> Hi Suren
> 
> our current issue is that after lmkd kills a process,|exit_mm|takes
> considerable time. The interface you provided might help quickly free
> memory, potentially allowing us to release some memory from processes before
> lmkd kills them. This could be a good idea.
> 
> We will take your suggestion into consideration.

But LMKD already does the process_mrelease(). Is that not happening on
your setup?

