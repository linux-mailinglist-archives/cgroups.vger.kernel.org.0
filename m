Return-Path: <cgroups+bounces-8188-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7078AAB71DD
	for <lists+cgroups@lfdr.de>; Wed, 14 May 2025 18:46:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EEF7E3A67D0
	for <lists+cgroups@lfdr.de>; Wed, 14 May 2025 16:46:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11BDC27C844;
	Wed, 14 May 2025 16:46:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="xQQnPdcJ"
X-Original-To: cgroups@vger.kernel.org
Received: from out-180.mta1.migadu.com (out-180.mta1.migadu.com [95.215.58.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 980F51B6CF1
	for <cgroups@vger.kernel.org>; Wed, 14 May 2025 16:46:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747241181; cv=none; b=ndiPN8jGRMGnfUYYegzJMcQK69Dm0qAThz/hFPPDNEcDzVRCAv10Hq6g8Ux8njUW56az6dz5+D8IRrO1FXE0IVDKRqZF6RhT8iwnia+kwuF+wLcBcMIZrxvMeLlg5TorHTwWC4XhDCGjJ0pe9Iutt/c1nswnnk2VSOBRt7AlxCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747241181; c=relaxed/simple;
	bh=ldPAeDLrOCi8Y0e/bUD2PZnqdJtmnYqiVmV27CFcAZ0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bbWCvKJ+co6iLmqXGt2kYtnS0RsncxaazTTmO1hbF+LGy5VN3L+HdxEYDyRaLjBOCxrsI+s08josF4rgpxEydv64U6GG5bbgYg/RKmcTufvhnMaR/TKoZnPaddkiCr7M9jSb1II0S8KqtAda0GwTPo+sY7r42v6zehyj2ix/QAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=xQQnPdcJ; arc=none smtp.client-ip=95.215.58.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Wed, 14 May 2025 09:46:12 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1747241177;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=97EX9VKYbW9uArLbHVrLKrGh49PbRe9B/FYp29idK8c=;
	b=xQQnPdcJcBuVIlzx6fvaXoCeI5vmaHyd5mgIvDgr3cTI1nz4+K8i5lf2jc3yF85bqjjbFf
	Hmyfsf+eN+PvW3EGtx01bmOJmFEGQwEN7DH8TpGOTtfyDXc+xg/8X4q3VFl+aDWhk+yRzy
	ej3quNlw9SDXYBLahahLdLR3pVya2Vs=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Muchun Song <muchun.song@linux.dev>, 
	Vlastimil Babka <vbabka@suse.cz>, Alexei Starovoitov <ast@kernel.org>, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, bpf <bpf@vger.kernel.org>, linux-mm <linux-mm@kvack.org>, 
	"open list:CONTROL GROUP (CGROUP)" <cgroups@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	Meta kernel team <kernel-team@meta.com>
Subject: Re: [PATCH 4/4] memcg: make objcg charging nmi safe
Message-ID: <wfctzryrpbwshed37nytzmuz6fuz7ofrmllhq5t3kpoqtbjc75@2zttf6hpsoib>
References: <20250509232859.657525-1-shakeel.butt@linux.dev>
 <20250509232859.657525-5-shakeel.butt@linux.dev>
 <CAADnVQ+8w7huzJFqqm40KVetnQC-SoFKSMjq2uJHEHuAkCR7YA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAADnVQ+8w7huzJFqqm40KVetnQC-SoFKSMjq2uJHEHuAkCR7YA@mail.gmail.com>
X-Migadu-Flow: FLOW_OUT

On Tue, May 13, 2025 at 03:25:31PM -0700, Alexei Starovoitov wrote:
> On Fri, May 9, 2025 at 4:29 PM Shakeel Butt <shakeel.butt@linux.dev> wrote:
> >
> > To enable memcg charged kernel memory allocations from nmi context,
> > consume_obj_stock() and refill_obj_stock() needs to be nmi safe. With
> > the simple in_nmi() check, take the slow path of the objcg charging
> > which handles the charging and memcg stats updates correctly for the nmi
> > context.
> >
> > Signed-off-by: Shakeel Butt <shakeel.butt@linux.dev>
> > ---
> >  mm/memcontrol.c | 14 +++++++++++++-
> >  1 file changed, 13 insertions(+), 1 deletion(-)
> >
> > diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> > index bba549c1f18c..6cfa3550f300 100644
> > --- a/mm/memcontrol.c
> > +++ b/mm/memcontrol.c
> > @@ -2965,6 +2965,9 @@ static bool consume_obj_stock(struct obj_cgroup *objcg, unsigned int nr_bytes,
> >         unsigned long flags;
> >         bool ret = false;
> >
> > +       if (unlikely(in_nmi()))
> > +               return ret;
> > +
> >         local_lock_irqsave(&obj_stock.lock, flags);
> >
> >         stock = this_cpu_ptr(&obj_stock);
> > @@ -3068,6 +3071,15 @@ static void refill_obj_stock(struct obj_cgroup *objcg, unsigned int nr_bytes,
> >         unsigned long flags;
> >         unsigned int nr_pages = 0;
> >
> > +       if (unlikely(in_nmi())) {
> > +               if (pgdat)
> > +                       __mod_objcg_mlstate(objcg, pgdat, idx, nr_bytes);
> > +               nr_pages = nr_bytes >> PAGE_SHIFT;
> > +               nr_bytes = nr_bytes & (PAGE_SIZE - 1);
> > +               atomic_add(nr_bytes, &objcg->nr_charged_bytes);
> > +               goto out;
> > +       }
> 
> 
> Now I see what I did incorrectly in my series and how this patch 4
> combined with patch 3 is doing accounting properly.
> 
> The only issue here and in other patches is that in_nmi() is
> an incomplete condition to check for.
> The reentrance is possible through kprobe or tracepoint.
> In PREEMP_RT we will be fully preemptible, but
> obj_stock.lock will be already taken by the current task.
> To fix it you need to use local_lock_is_locked(&obj_stock.lock)
> instead of in_nmi() or use local_trylock_irqsave(&obj_stock.lock).
> 
> local_trylock_irqsave() is cleaner and works today,
> while local_lock_is_locked() hasn't landed yet, but if we go
> is_locked route we can decouple reentrant obj_stock operation vs normal.
> Like the if (!local_lock_is_locked(&obj_stock.lock))
> can be done much higher up the stack from
> __memcg_slab_post_alloc_hook() the way I did in my series,
> and if locked it can do atomic_add()-style charging.
> So refill_obj_stock() and friends won't need to change.

Thanks Alexei for taking a look. For now I am going with the trylock
path and later will check if your suggested is_locked() makes things
better.

