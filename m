Return-Path: <cgroups+bounces-4841-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B21D2974B1B
	for <lists+cgroups@lfdr.de>; Wed, 11 Sep 2024 09:19:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D6F911C24838
	for <lists+cgroups@lfdr.de>; Wed, 11 Sep 2024 07:19:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DDBF824BD;
	Wed, 11 Sep 2024 07:19:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="T4JBm2uh"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B64D478685
	for <cgroups@vger.kernel.org>; Wed, 11 Sep 2024 07:19:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726039145; cv=none; b=Ahx3yJ3zjmkacWLga0tPRP8PhBmvVqPJ82U1b7z/05VFHSfKCtni1W9PVrUi/zZTcc8iYui0JDQ/ppYy5TjFtZUVGkdaqBKSSXFGph+J/MNpRwbhhDhzrcNUTgnFo4v6rdybJBFP0P+YP/650BBlkbKRVa2sxMdKG/lJKmKGVhk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726039145; c=relaxed/simple;
	bh=vJ8/VVSP7FSiF+01wOzw6BdOMh0sWzFQyjzunfZuPbo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type:Content-Disposition; b=nYh+wRk0ytLzI05UHwo9qntPQVtHT/Wv57jkak9o8poQLEZgGgQL21opa+aUsqDHHX+86iUJqYdbmG9D5k2ohemBj6/2GOLjZo/NnQUZ5CX4+XyfePWHvIaxcLpPY23h+srR92e30RA8OZdubH/f0/5ukVINhavurgMopq59mqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=T4JBm2uh; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1726039142;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WExmWVFUVT+GeIi/yPIGow20ZicextOrMJ+vbOaBSZo=;
	b=T4JBm2uh0PRqA3P8TsHzb5VIzlOt/05UGww+uobu1N8WMemFQpuX5Hg68GnaKNMgm8yLBS
	J5j8cQ1uqpbadIioo7B/wK7dC2+K0Fi+XxuJg47PTsrFgn7r+PedxtBF22FOvoOW2jG1Ps
	Vb7r1BNlSPfAoffYfs7vbWnpXwYq+es=
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com
 [209.85.210.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-102-XAr_yQ9WOYyWtlgMuTYPEw-1; Wed, 11 Sep 2024 03:19:01 -0400
X-MC-Unique: XAr_yQ9WOYyWtlgMuTYPEw-1
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-718e82769aeso2691988b3a.0
        for <cgroups@vger.kernel.org>; Wed, 11 Sep 2024 00:19:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726039140; x=1726643940;
        h=content-transfer-encoding:content-disposition:mime-version
         :references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WExmWVFUVT+GeIi/yPIGow20ZicextOrMJ+vbOaBSZo=;
        b=MdgV1Uv225XTY8RLUhXj1t6M1WBvZW56MwynMGhMvaU2PoTAtusXglL0RiUlK0g9XA
         z2SCWYbLJwy5XXfsxknzH20mIUDZQrH+ytjhkpOpYBt2GAZh510dfvAow0wfbAWR9rkX
         iiV/lD8F6Z42k7TQmMgvQbk629+If9lnQaHPvrMVcBK5e5MT8J+dpN33Nr7ObyvArlSG
         kuu3rFL3uiba3ChbHWMDKBnhn6lL74KCq7F8xcTQ/6/Oor98yalHEk/kxHX5+M6LDFpC
         27GCFW9faa0W2ELk59lw1qW9O6sSRVpqMbXxmqjW98vOefYX6RY1b9f7wBdMBEt738mM
         ElUQ==
X-Forwarded-Encrypted: i=1; AJvYcCUFYJZTjInlL1YKfWZiZOGR5XeUQU1JIkGBflkuYv6GgOTqIum2ae+LZikiqSHlY5BqEaKctx6D@vger.kernel.org
X-Gm-Message-State: AOJu0YwEzWLGUh5xwjZ0+yzvztPJAYai+0dNNwrzA/FJREc4B2mljFif
	XkcgCUsMT6EBBSBk7aCrYdT05mEYgulCe3G6ml6qbi2CvWG0GEfejyEZ1joyVv1EJd71VjI1d81
	1xyvNzTo4VeyErEpiKpA6xy5189dX6pMPTQJu3Eb08G3LBAnn74wB1xI=
X-Received: by 2002:a05:6a00:66c8:b0:70a:f576:beeb with SMTP id d2e1a72fcca58-71916df6fdfmr2660106b3a.15.1726039140083;
        Wed, 11 Sep 2024 00:19:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGc3lptb75oVWaJldXqEJfWwtFJcwuDY5ronghp6vVOfZyKrsvLvrHkcR+YcX3R+mxuPDiR2Q==
X-Received: by 2002:a05:6a00:66c8:b0:70a:f576:beeb with SMTP id d2e1a72fcca58-71916df6fdfmr2660082b3a.15.1726039139608;
        Wed, 11 Sep 2024 00:18:59 -0700 (PDT)
Received: from localhost.localdomain ([2804:1b3:a800:3c59:c8f1:7d33:571a:fde2])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71908fc8febsm2466665b3a.19.2024.09.11.00.18.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Sep 2024 00:18:59 -0700 (PDT)
From: Leonardo Bras <leobras@redhat.com>
To: Waiman Long <longman@redhat.com>
Cc: Leonardo Bras <leobras@redhat.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Michal Hocko <mhocko@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Muchun Song <muchun.song@linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>,
	Christoph Lameter <cl@linux.com>,
	Pekka Enberg <penberg@kernel.org>,
	David Rientjes <rientjes@google.com>,
	Joonsoo Kim <iamjoonsoo.kim@lge.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Hyeonggon Yoo <42.hyeyoo@gmail.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Marcelo Tosatti <mtosatti@redhat.com>,
	linux-kernel@vger.kernel.org,
	cgroups@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: [RFC PATCH v1 1/4] Introducing qpw_lock() and per-cpu queue & flush work
Date: Wed, 11 Sep 2024 04:18:42 -0300
Message-ID: <ZuFEUk2jsRRWNG1I@LeoBras>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <a9fdcd85-633c-4e88-9e1f-db0b9d3b745c@redhat.com>
References: <20240622035815.569665-1-leobras@redhat.com> <20240622035815.569665-2-leobras@redhat.com> <f69793ab-41c3-4ae2-a8b1-355e629ffd0b@redhat.com> <a9fdcd85-633c-4e88-9e1f-db0b9d3b745c@redhat.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Wed, Sep 04, 2024 at 08:08:12PM -0400, Waiman Long wrote:
> On 9/4/24 17:39, Waiman Long wrote:
> > On 6/21/24 23:58, Leonardo Bras wrote:
> > > Some places in the kernel implement a parallel programming strategy
> > > consisting on local_locks() for most of the work, and some rare remote
> > > operations are scheduled on target cpu. This keeps cache bouncing
> > > low since
> > > cacheline tends to be mostly local, and avoids the cost of locks in
> > > non-RT
> > > kernels, even though the very few remote operations will be
> > > expensive due
> > > to scheduling overhead.
> > > 
> > > On the other hand, for RT workloads this can represent a problem:
> > > getting
> > > an important workload scheduled out to deal with some unrelated task is
> > > sure to introduce unexpected deadline misses.
> > > 
> > > It's interesting, though, that local_lock()s in RT kernels become
> > > spinlock(). We can make use of those to avoid scheduling work on a
> > > remote
> > > cpu by directly updating another cpu's per_cpu structure, while holding
> > > it's spinlock().
> > > 
> > > In order to do that, it's necessary to introduce a new set of
> > > functions to
> > > make it possible to get another cpu's per-cpu "local" lock
> > > (qpw_{un,}lock*)
> > > and also the corresponding queue_percpu_work_on() and
> > > flush_percpu_work()
> > > helpers to run the remote work.
> > > 
> > > On non-RT kernels, no changes are expected, as every one of the
> > > introduced
> > > helpers work the exactly same as the current implementation:
> > > qpw_{un,}lock*()        ->  local_{un,}lock*() (ignores cpu parameter)
> > > queue_percpu_work_on()  ->  queue_work_on()
> > > flush_percpu_work()     ->  flush_work()
> > > 
> > > For RT kernels, though, qpw_{un,}lock*() will use the extra cpu
> > > parameter
> > > to select the correct per-cpu structure to work on, and acquire the
> > > spinlock for that cpu.
> > > 
> > > queue_percpu_work_on() will just call the requested function in the
> > > current
> > > cpu, which will operate in another cpu's per-cpu object. Since the
> > > local_locks() become spinlock()s in PREEMPT_RT, we are safe doing that.
> > > 
> > > flush_percpu_work() then becomes a no-op since no work is actually
> > > scheduled on a remote cpu.
> > > 
> > > Some minimal code rework is needed in order to make this mechanism work:
> > > The calls for local_{un,}lock*() on the functions that are currently
> > > scheduled on remote cpus need to be replaced by qpw_{un,}lock_n*(),
> > > so in
> > > RT kernels they can reference a different cpu. It's also necessary
> > > to use a
> > > qpw_struct instead of a work_struct, but it just contains a work struct
> > > and, in PREEMPT_RT, the target cpu.
> > > 
> > > This should have almost no impact on non-RT kernels: few this_cpu_ptr()
> > > will become per_cpu_ptr(,smp_processor_id()).
> > > 
> > > On RT kernels, this should improve performance and reduce latency by
> > > removing scheduling noise.
> > > 
> > > Signed-off-by: Leonardo Bras <leobras@redhat.com>
> > > ---
> > >   include/linux/qpw.h | 88 +++++++++++++++++++++++++++++++++++++++++++++
> > >   1 file changed, 88 insertions(+)
> > >   create mode 100644 include/linux/qpw.h
> > > 
> > > diff --git a/include/linux/qpw.h b/include/linux/qpw.h
> > > new file mode 100644
> > > index 000000000000..ea2686a01e5e
> > > --- /dev/null
> > > +++ b/include/linux/qpw.h
> > > @@ -0,0 +1,88 @@
> > > +/* SPDX-License-Identifier: GPL-2.0 */
> > > +#ifndef _LINUX_QPW_H
> > > +#define _LINUX_QPW_H
> 
> I would suggest adding a comment with a brief description of what
> qpw_lock/unlock() are for and their use cases. The "qpw" prefix itself isn't
> intuitive enough for a casual reader to understand what they are for.

Agree, I am also open to discuss a more intuitive naming for these.

> 
> Cheers,
> Longman
> 

Thanks!
Leo


