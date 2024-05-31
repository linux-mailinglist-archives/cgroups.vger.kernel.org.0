Return-Path: <cgroups+bounces-3063-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 93A1C8D6C9C
	for <lists+cgroups@lfdr.de>; Sat,  1 Jun 2024 00:51:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C23AD1C229ED
	for <lists+cgroups@lfdr.de>; Fri, 31 May 2024 22:51:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02AC88248D;
	Fri, 31 May 2024 22:51:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="MZy9Bep6"
X-Original-To: cgroups@vger.kernel.org
Received: from out-173.mta1.migadu.com (out-173.mta1.migadu.com [95.215.58.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 891C43207
	for <cgroups@vger.kernel.org>; Fri, 31 May 2024 22:51:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717195898; cv=none; b=HjGiW4SUgfkEQ3QBHJjOcMaSOgZAjVIawxe767mKaPjLJLSStuv/DtDCjZynd8woC9MDV9hBh/dFcDVM/M4i6lEtvjQ1Cx5UWBYXam7veO8jtgtmMVbCLVMnt3h/btwz04/kfNOnwX9KVTKwXdVwoK5yuA84suj8EZYdxCG9uzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717195898; c=relaxed/simple;
	bh=WNT206vn2ZblImFAEhEwdMHu1V++Uq1UEO11g5LdPuc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hPUmCduqjJosDF6i9lvaSmZ/Cc/yU2SbK0fBfr5WIOHr82Hoj0JCOavW44/xp6kf7lQcH0rZXxKkwJ4ZeoLyR0snstR1DHOZCJ8QFg2+GbPLD5tUSOA0iYGjvEvuzHINXDA88SoGu8QDXmgo/Hl75+M7JG2sIpFkAf4HbDES7II=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=MZy9Bep6; arc=none smtp.client-ip=95.215.58.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: willy@infradead.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1717195894;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=yvNYXDzk//IU7YejWZtIAkTEAkRe2EZsR+gbKgk03H0=;
	b=MZy9Bep6QM2jJVR5AyZVt7Dox3dmsj0RxbqGiKQjDbX7GD5amZx9zoykD/CdatCNuaZx+K
	Ecwezjdcst347tKHqiiWbq1qSTBHRRpN2tgbPAusMs1NHctLc5/9AB3BTvxqm/U79ltEF/
	Y+pkNIcepkaU5VvTyH43TWT9O19vMl0=
X-Envelope-To: wangkefeng.wang@huawei.com
X-Envelope-To: akpm@linux-foundation.org
X-Envelope-To: hannes@cmpxchg.org
X-Envelope-To: mhocko@kernel.org
X-Envelope-To: roman.gushchin@linux.dev
X-Envelope-To: muchun.song@linux.dev
X-Envelope-To: linux-mm@kvack.org
X-Envelope-To: cgroups@vger.kernel.org
X-Envelope-To: urezki@gmail.com
X-Envelope-To: hch@infradead.org
X-Envelope-To: lstoakes@gmail.com
Date: Fri, 31 May 2024 15:51:28 -0700
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Matthew Wilcox <willy@infradead.org>
Cc: Kefeng Wang <wangkefeng.wang@huawei.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Johannes Weiner <hannes@cmpxchg.org>, 
	Michal Hocko <mhocko@kernel.org>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Muchun Song <muchun.song@linux.dev>, linux-mm@kvack.org, cgroups@vger.kernel.org, 
	Uladzislau Rezki <urezki@gmail.com>, Christoph Hellwig <hch@infradead.org>, 
	Lorenzo Stoakes <lstoakes@gmail.com>
Subject: Re: [PATCH] mm: memcontrol: remove page_memcg()
Message-ID: <vhlyq222gwywi4fchrb4uobxroa5g6gtv25wxub7l4fsl5dq6o@ko6bd5og2wyc>
References: <20240521131556.142176-1-wangkefeng.wang@huawei.com>
 <ZkyzRVe31WLaepSt@casper.infradead.org>
 <tcdr5cm3djarfeiwar6q7qvxjdgkb7r5pcb7j6pzqejnbslsgz@2pnnlbwmfzdu>
 <Zk9FGQUdcs8tqCbi@casper.infradead.org>
 <z6t4afo4h2oybrgtpeghohxamnaapcjhi54dexvzyflv4mpk56@xjkjq4jodtve>
 <Zk9wEybsnyo9dvYu@casper.infradead.org>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zk9wEybsnyo9dvYu@casper.infradead.org>
X-Migadu-Flow: FLOW_OUT

On Thu, May 23, 2024 at 05:34:27PM GMT, Matthew Wilcox wrote:
> On Thu, May 23, 2024 at 08:41:25AM -0700, Shakeel Butt wrote:
> > On Thu, May 23, 2024 at 02:31:05PM +0100, Matthew Wilcox wrote:
> > > On Tue, May 21, 2024 at 12:29:39PM -0700, Shakeel Butt wrote:
> > > > On Tue, May 21, 2024 at 03:44:21PM +0100, Matthew Wilcox wrote:
> > > > > The memcg should not be attached to the individual pages that make up a
> > > > > vmalloc allocation.  Rather, it should be managed by the vmalloc
> > > > > allocation itself.  I don't have the knowledge to poke around inside
> > > > > vmalloc right now, but maybe somebody else could take that on.
> > > > 
> > > > Are you concerned about accessing just memcg or any field of the
> > > > sub-page? There are drivers accessing fields of pages allocated through
> > > > vmalloc. Some details at 3b8000ae185c ("mm/vmalloc: huge vmalloc backing
> > > > pages should be split rather than compound").
> > > 
> > > Thanks for the pointer, and fb_deferred_io_fault() is already on my
> > > hitlist for abusing struct page.
> > > 
> > > My primary concern is that we should track the entire allocation as a
> > > single object rather than tracking each page individually.  That means
> > > assigning the vmalloc allocation to a memcg rather than assigning each
> > > page to a memcg.  It's a lot less overhead to increment the counter once
> > > per allocation rather than once per page in the allocation!
> > > 
> > > But secondarily, yes, pages allocated by vmalloc probably don't need
> > > any per-page state, other than tracking the vmalloc allocation they're
> > > assigned to.  We'll see how that theory turns out.
> > 
> > I think the tricky part would be vmalloc having pages spanning multiple
> > nodes which is not an issue for MEMCG_VMALLOC stat but the vmap based
> > kernel stack (CONFIG_VMAP_STACK) metric NR_KERNEL_STACK_KB cares about
> > that information.
> 
> Yes, we'll have to handle mod_lruvec_page_state() differently since that
> stat is tracked per node.  Or we could stop tracking that stat per node.
> Is it useful to track it per node?  Why is it useful to track kernel
> stacks per node, but not track vmalloc allocations per node?

This is a good question and other than that there are user visible APIs
(per numa meminfo & memory.numa_stat), I don't have a good answer.

