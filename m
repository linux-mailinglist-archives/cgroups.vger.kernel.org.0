Return-Path: <cgroups+bounces-10373-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D969B93A64
	for <lists+cgroups@lfdr.de>; Tue, 23 Sep 2025 01:55:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D67713A583C
	for <lists+cgroups@lfdr.de>; Mon, 22 Sep 2025 23:55:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A9D32FFDCA;
	Mon, 22 Sep 2025 23:55:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="QodwpJl8"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 277871D5178;
	Mon, 22 Sep 2025 23:55:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758585311; cv=none; b=edcrSC6OaL7xS9m6/GnPWUfFSTUAQLVus2O6KCH2rPeeiTA04SjHsY3JFN+Q18lBTB/X2MCZb0ug/rxZ033HOaBs5ATOaDc9+hYI2sJNMG8KKKKhbR3NrYn5pSVccxG+lRBy/+kl4w2p1z2gh647L0yB9mQ4oFG6PB0NyjWtgu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758585311; c=relaxed/simple;
	bh=GUUIv/PzkqvPIBWCrFcZLWsQWgOY8kSV/evTaZnYusU=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=JV4nLz1c15P6FDrhUcqmnPKlbtPJMV+t5SQFeLXUGMwiwmHe+7sPtvgD7JM3IJZr+ohdll+Svh/eSrv49YzLyoLYupBempRMPDdaWT1JOl99a2WtB5ap/Rgs77NQfVT+ViP5pG3xCT+svoA9YxVrpUMmwx8NBYPruUam70+hN0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=QodwpJl8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4220C4CEF0;
	Mon, 22 Sep 2025 23:55:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1758585310;
	bh=GUUIv/PzkqvPIBWCrFcZLWsQWgOY8kSV/evTaZnYusU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=QodwpJl8LgA0tAs/Ed4XU6lKjkVzRkPVTn1mvkR2m700vx+dg/C36CMq5EA430M8j
	 NFeO6/Xy2OpKGxh1br3FuHqcjlxhm4YjqqjYErMdYpUEcrYss0BHlgCklJoyJWmHV8
	 9ClCI0kaA6W4SSO1tML+maH2YGRDO4KUh/IlOcXE=
Date: Mon, 22 Sep 2025 16:55:09 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>, Michal
 Hocko <mhocko@kernel.org>, Roman Gushchin <roman.gushchin@linux.dev>,
 Muchun Song <muchun.song@linux.dev>, Alexei Starovoitov <ast@kernel.org>,
 Peilin Ye <yepeilin@google.com>, Kumar Kartikeya Dwivedi
 <memxor@gmail.com>, bpf@vger.kernel.org, linux-mm@kvack.org,
 cgroups@vger.kernel.org, linux-kernel@vger.kernel.org, Meta kernel team
 <kernel-team@meta.com>, Michal Hocko <mhocko@suse.com>
Subject: Re: [PATCH v2] memcg: skip cgroup_file_notify if spinning is not
 allowed
Message-Id: <20250922165509.3fe07892054bb9e149e7cc06@linux-foundation.org>
In-Reply-To: <552lz3qxc3z45r446rfndi7gx6nsht5iuhrhaszljofka2zrfs@odxfnm2blgdd>
References: <20250922220203.261714-1-shakeel.butt@linux.dev>
	<20250922160443.f48bb14e2d055e6e954cd874@linux-foundation.org>
	<552lz3qxc3z45r446rfndi7gx6nsht5iuhrhaszljofka2zrfs@odxfnm2blgdd>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 22 Sep 2025 16:39:53 -0700 Shakeel Butt <shakeel.butt@linux.dev> wrote:

> On Mon, Sep 22, 2025 at 04:04:43PM -0700, Andrew Morton wrote:
> > On Mon, 22 Sep 2025 15:02:03 -0700 Shakeel Butt <shakeel.butt@linux.dev> wrote:
> > 
> > > Generally memcg charging is allowed from all the contexts including NMI
> > > where even spinning on spinlock can cause locking issues. However one
> > > call chain was missed during the addition of memcg charging from any
> > > context support. That is try_charge_memcg() -> memcg_memory_event() ->
> > > cgroup_file_notify().
> > > 
> > > The possible function call tree under cgroup_file_notify() can acquire
> > > many different spin locks in spinning mode. Some of them are
> > > cgroup_file_kn_lock, kernfs_notify_lock, pool_workqeue's lock. So, let's
> > > just skip cgroup_file_notify() from memcg charging if the context does
> > > not allow spinning.
> > > 
> > > Alternative approach was also explored where instead of skipping
> > > cgroup_file_notify(), we defer the memcg event processing to irq_work
> > > [1]. However it adds complexity and it was decided to keep things simple
> > > until we need more memcg events with !allow_spinning requirement.
> > > 
> > > Link: https://lore.kernel.org/all/5qi2llyzf7gklncflo6gxoozljbm4h3tpnuv4u4ej4ztysvi6f@x44v7nz2wdzd/ [1]
> > > Signed-off-by: Shakeel Butt <shakeel.butt@linux.dev>
> > > Acked-by: Michal Hocko <mhocko@suse.com>
> > 
> > Fixes a possible kernel deadlock, yes?
> > 
> > Is a cc:stable appropriate and can we identify a Fixes: target?
> > 
> > Thanks.
> > 
> > (Did it ever generate lockdep warnings?)
> 
> The report is here:
> https://lore.kernel.org/all/20250905061919.439648-1-yepeilin@google.com/
> 
> I am not sure about the Fixes tag though or more like which one to put
> in the Fixes as we recently started supporting memcg charging for NMI
> context or allowing bpf programs to do memcg charged allocations in
> recursive context (see the above report for this recursive call chain).
> There is no single commit which can be blamed here.

I tend to view the Fixes: as us suggesting which kernel versions should
be patched.  I'm suspecting that's 6.16+, so using the final relevant
patch in that release as a Fixes: target would work.


