Return-Path: <cgroups+bounces-9840-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C85A0B50652
	for <lists+cgroups@lfdr.de>; Tue,  9 Sep 2025 21:21:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E86091BC8869
	for <lists+cgroups@lfdr.de>; Tue,  9 Sep 2025 19:22:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26EDE34DCE1;
	Tue,  9 Sep 2025 19:21:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="sjzUsVGa"
X-Original-To: cgroups@vger.kernel.org
Received: from out-186.mta1.migadu.com (out-186.mta1.migadu.com [95.215.58.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 967E029405
	for <cgroups@vger.kernel.org>; Tue,  9 Sep 2025 19:21:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757445704; cv=none; b=miRa3G+ePfNX1oYz53hbzv3G4v3EkaZFP1m3ZXbRwVZpIPgIVnhS2vWDf3a21aMSEy07qKkwZ+oxgsCFcaOYMHtdjQOMy7z8hN+WFGuI1MTKhEQdtc5yYLSY8y3U57w4B2WKAaJwCBpnDS+sZALFguby10P016pyTXvGkMtr1po=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757445704; c=relaxed/simple;
	bh=fjVbGT5+mmdI08QzcGTzfyG2j4oQQ62dkfCBLhBCX20=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Bcjj9Nl9NXaqTJp4mBWWOAawpoWTUP6yfhCOB/y4D5ysLBl0rHKxyJ0w4ljsAdDLA8NdF4dcVLK8kDOURa4HuKlB9fAT268zaoGyoLOH/rvQHS7lv+epPyx41VEZisKstSbrtf7z/PjHo5/Tkb8F5wsUtYSZEcduDKOnlAgjp5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=sjzUsVGa; arc=none smtp.client-ip=95.215.58.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Tue, 9 Sep 2025 12:21:21 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1757445700;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=EhDQjk6n0b5bB/spcc+8InBhRg7fkfv65TLASLNaXE4=;
	b=sjzUsVGa+0Di1xSEmIyz3313s89ajDdufhXMbunOadULSjuGrqlV1+dUTeKDCX0cEMdtg3
	mq2f5ijUy/Y1oS9jDCXjYtvQ2whw5Zh6dd+VIEnk5BPwyjuhfN7VxxPrY8YCBpOBjpNU8S
	TR20eItydveGrPGMF/97uWA74Xnm5tE=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Lei Liu <liulei.rjpt@vivo.com>
Cc: Michal Hocko <mhocko@suse.com>, David Rientjes <rientjes@google.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Kemeng Shi <shikemeng@huaweicloud.com>, 
	Kairui Song <kasong@tencent.com>, Nhat Pham <nphamcs@gmail.com>, Baoquan He <bhe@redhat.com>, 
	Barry Song <baohua@kernel.org>, Chris Li <chrisl@kernel.org>, 
	Johannes Weiner <hannes@cmpxchg.org>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Muchun Song <muchun.song@linux.dev>, David Hildenbrand <david@redhat.com>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>, 
	Suren Baghdasaryan <surenb@google.com>, Brendan Jackman <jackmanb@google.com>, Zi Yan <ziy@nvidia.com>, 
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
Message-ID: <fszpgct7ywqy6qq3qnjflol3theovmgnau2wgdqqdxin4q7ezm@zumgw533hxon>
References: <20250909065349.574894-1-liulei.rjpt@vivo.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250909065349.574894-1-liulei.rjpt@vivo.com>
X-Migadu-Flow: FLOW_OUT

On Tue, Sep 09, 2025 at 02:53:39PM +0800, Lei Liu wrote:
> 1. Problem Scenario
> On systems with ZRAM and swap enabled, simultaneous process exits create
> contention. The primary bottleneck occurs during swap entry release
> operations, causing exiting processes to monopolize CPU resources. This
> leads to scheduling delays for high-priority processes.
> 
> 2. Android Use Case
> During camera launch, LMKD terminates background processes to free memory.

How does LMKD trigger the kills? SIGKILL or cgroup.kill?

> Exiting processes compete for CPU cycles, delaying the camera preview
> thread and causing visible stuttering - directly impacting user
> experience.

Since the exit/kill is due to low memory situation, punting the memory
freeing to a low priority async mechanism will help in improving user
experience. Most probably the application (camera preview here) will get
into global reclaim and will compete for CPU with the async memory
freeing.

What we really need is faster memory freeing and we should explore all
possible ways. As others suggested fix/improve the bottleneck in the
memory freeing path. In addition I think we should explore parallelizing
this as well.

On Android, I suppose most of the memory is associated with single or
small set of processes and parallelizing memory freeing would be
challenging. BTW is LMKD using process_mrelease() to release the killed
process memory? 

