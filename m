Return-Path: <cgroups+bounces-3310-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 53DB2915575
	for <lists+cgroups@lfdr.de>; Mon, 24 Jun 2024 19:33:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0EE44287728
	for <lists+cgroups@lfdr.de>; Mon, 24 Jun 2024 17:33:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACE7F19F461;
	Mon, 24 Jun 2024 17:32:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="MjEOPGr+"
X-Original-To: cgroups@vger.kernel.org
Received: from out-172.mta0.migadu.com (out-172.mta0.migadu.com [91.218.175.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B049719EEDF
	for <cgroups@vger.kernel.org>; Mon, 24 Jun 2024 17:32:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719250379; cv=none; b=l5dw34ef0w42b9HVUTtQZB3hcG+dsNQby6xJ1o6LFpJAndm+N4jFQNHJPIQQp5EQrQaA4DAx+ruM04MXBzwlpvFKCwr+7KLi73G/0962OY3D6x296lKocOOe7utJfbT/w4JkxfLlg6Urc3f/QtZkhJ0mM7GSmZejLhBFRP6NqV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719250379; c=relaxed/simple;
	bh=xhyQZXooAJEX7J62ozBmF/lv2YmYMvAhCgTBD8SnxcQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J1SLkLsjV9TmH2h56FE7t1nqcA7Q5o6vFgHt+yYux6WE0E0V13XrsRICkwLA+8o2U01NIq9VGG2IvLlTCKlkXkFajJYva0HoEsnzzX/ghJuuJNwmDnKHf+BclTuP25pCHOSRjSERUQasJtoKRX2M582VciY6V8Om22fYL6DNnZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=MjEOPGr+; arc=none smtp.client-ip=91.218.175.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: yosryahmed@google.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1719250375;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qBtGnhkgSmOG529IQPloUgvMKxbYourH7LyKKUJBK0E=;
	b=MjEOPGr++lnCIcGfZw73gaSpAHuny4FEV82lD7HnQCficdgny0vyBaNFA53FDiCGORW98X
	YaOHHthGwtqeTp+ugPnBFG6VfXj+lEu/S1ZRv+Quc1jK+YqjmVnTr5h9gndERrxjtbQvvt
	DEIl2+lmR+23/LiysNJWd8hbx5lB220=
X-Envelope-To: hawk@kernel.org
X-Envelope-To: tj@kernel.org
X-Envelope-To: cgroups@vger.kernel.org
X-Envelope-To: hannes@cmpxchg.org
X-Envelope-To: lizefan.x@bytedance.com
X-Envelope-To: longman@redhat.com
X-Envelope-To: kernel-team@cloudflare.com
X-Envelope-To: linux-mm@kvack.org
X-Envelope-To: linux-kernel@vger.kernel.org
Date: Mon, 24 Jun 2024 10:32:50 -0700
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Yosry Ahmed <yosryahmed@google.com>
Cc: Jesper Dangaard Brouer <hawk@kernel.org>, tj@kernel.org, 
	cgroups@vger.kernel.org, hannes@cmpxchg.org, lizefan.x@bytedance.com, longman@redhat.com, 
	kernel-team@cloudflare.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2] cgroup/rstat: Avoid thundering herd problem by kswapd
 across NUMA nodes
Message-ID: <tl25itxuzvjxlzliqsvghaa3auzzze6ap26pjdxt6spvhf5oqz@fvc36ntdeg4r>
References: <171923011608.1500238.3591002573732683639.stgit@firesoul>
 <CAJD7tkbHNvQoPO=8Nubrd5an7_9kSWM=5Wh5H1ZV22WD=oFVMg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJD7tkbHNvQoPO=8Nubrd5an7_9kSWM=5Wh5H1ZV22WD=oFVMg@mail.gmail.com>
X-Migadu-Flow: FLOW_OUT

On Mon, Jun 24, 2024 at 05:46:05AM GMT, Yosry Ahmed wrote:
> On Mon, Jun 24, 2024 at 4:55 AM Jesper Dangaard Brouer <hawk@kernel.org> wrote:
> 
[...]
> I am assuming this supersedes your other patch titled "[PATCH RFC]
> cgroup/rstat: avoid thundering herd problem on root cgrp", so I will
> only respond here.
> 
> I have two comments:
> - There is no reason why this should be limited to the root cgroup. We
> can keep track of the cgroup being flushed, and use
> cgroup_is_descendant() to find out if the cgroup we want to flush is a
> descendant of it. We can use a pointer and cmpxchg primitives instead
> of the atomic here IIUC.
> 
> - More importantly, I am not a fan of skipping the flush if there is
> an ongoing one. For all we know, the ongoing flush could have just
> started and the stats have not been flushed yet. This is another
> example of non deterministic behavior that could be difficult to
> debug.

Even with the flush, there will almost always per-cpu updates which will
be missed. This can not be fixed unless we block the stats updaters as
well (which is not going to happen). So, we are already ok with this
level of non-determinism. Why skipping flushing would be worse? One may
argue 'time window is smaller' but this still does not cap the amount of
updates. So, unless there is concrete data that this skipping flushing
is detrimental to the users of stats, I don't see an issue in the
presense of periodic flusher.

> 
> I tried a similar approach before where we sleep and wait for the
> ongoing flush to complete instead, without contending on the lock,
> using completions [1]. Although that patch has a lot of complexity,

We can definitely add complexity but only if there are no simple good
enough mitigations.


