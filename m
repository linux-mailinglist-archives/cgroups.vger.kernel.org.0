Return-Path: <cgroups+bounces-8494-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EC6FAD625D
	for <lists+cgroups@lfdr.de>; Thu, 12 Jun 2025 00:33:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9B30317F3FF
	for <lists+cgroups@lfdr.de>; Wed, 11 Jun 2025 22:33:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD35F22ACFA;
	Wed, 11 Jun 2025 22:33:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="YHNKn7F9"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0926EDF49;
	Wed, 11 Jun 2025 22:33:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749681229; cv=none; b=jQ64Ot0cvZgGVD+x7FSw2eM/VABBRVTbY9YFrorUkRvqP2g1+G3GrHv8u0ZrNjUpvYNg2fOeJUm4vxnlcCUWLrO68g3Mhi2CFlVtcLm3Hcp6E8Ip+1i25Ro/8QUmmtYzQL5jq+vQ3LKL9QGeW/61onx/HcMWOVt9NO/XCu0Xq1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749681229; c=relaxed/simple;
	bh=5UEeqiOjSmvi1tWwRW73hCHk9IrJ+ZliNy+2Uj/YD44=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=HoblTcaQYYKxNQz0Anr2ElhWvgfpVgTw6m4808NcPH1VrBobEzymoUoPGgY4U3mKOxAvGMWoDlam+CoqXk4xCAIPt7SWXUBNwWcv4rkBeHWY2BT1mMDJGovi6V78LRjILnd7f5awG6uzA29obeyqIvB9YIX5uO4RYbd205TgO0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=YHNKn7F9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BABF9C4CEE3;
	Wed, 11 Jun 2025 22:33:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1749681228;
	bh=5UEeqiOjSmvi1tWwRW73hCHk9IrJ+ZliNy+2Uj/YD44=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=YHNKn7F9z2ZIRtxiNDxDltHkn4RbwhiaHn4fgKIsZ+x4sgolSwPSiETwYDPStlyoN
	 ssRmu5vJrw9zU2gPyg4wJ8v25YGYWIdFdX1JaN5WFzaCxX0ioKrG/jtEfS1WAGXWBD
	 mqzy863DzE9Y56wYen8iqYcAKH9nPRsFAedgRAgI=
Date: Wed, 11 Jun 2025 15:33:47 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Vlastimil Babka <vbabka@suse.cz>, Charlemagne Lasse
 <charlemagnelasse@gmail.com>, Johannes Weiner <hannes@cmpxchg.org>, Michal
 Hocko <mhocko@kernel.org>, Roman Gushchin <roman.gushchin@linux.dev>,
 Shakeel Butt <shakeel.butt@linux.dev>, Muchun Song <muchun.song@linux.dev>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Clark Williams
 <clrkwllms@kernel.org>, Steven Rostedt <rostedt@goodmis.org>, Alexei
 Starovoitov <ast@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Jakub
 Kicinski <kuba@kernel.org>, "Peter Zijlstra (Intel)"
 <peterz@infradead.org>, Davidlohr Bueso <dave@stgolabs.net>, LKML
 <linux-kernel@vger.kernel.org>, "open list:CONTROL GROUP (CGROUP)"
 <cgroups@vger.kernel.org>, linux-mm <linux-mm@kvack.org>,
 linux-rt-devel@lists.linux.dev
Subject: Re: locking/local_lock, mm: sparse warnings about shadowed variable
Message-Id: <20250611153347.779ae8c66be1aa806dbeb816@linux-foundation.org>
In-Reply-To: <CAADnVQK+wjvxmBM7WJOGNK=AqeJ7UHBO4tUZR3Gjc4kfgux1sw@mail.gmail.com>
References: <CAFGhKbwVyxCwYSNrPaQ-GkuP008+uvDg-wNA5syWLLzODCfpcA@mail.gmail.com>
	<68c0649d-d9b3-44f4-9a92-7f72c51a5013@suse.cz>
	<CAADnVQK+wjvxmBM7WJOGNK=AqeJ7UHBO4tUZR3Gjc4kfgux1sw@mail.gmail.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 11 Jun 2025 11:20:16 -0700 Alexei Starovoitov <alexei.starovoitov@gmail.com> wrote:

> > diff --git a/include/linux/local_lock_internal.h b/include/linux/local_lock_internal.h
> > index 8d5ac16a9b17..075338f270d0 100644
> > --- a/include/linux/local_lock_internal.h
> > +++ b/include/linux/local_lock_internal.h
> > @@ -97,17 +97,17 @@ do {                                                                \
> >  #define __local_lock_acquire(lock)                                     \
> >         do {                                                            \
> >                 local_trylock_t *tl;                                    \
> > -               local_lock_t *l;                                        \
> > +               local_lock_t *ll;                                       \
> 
> I wouldn't bother messing with the code because of sparse.
> Compilers don't warn here.

There's some value in not cluttering up the sparse output in this
fashion.  sparse does often find things which we choose to fix.

