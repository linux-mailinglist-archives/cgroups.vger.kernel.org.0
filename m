Return-Path: <cgroups+bounces-3337-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 37BC1915C52
	for <lists+cgroups@lfdr.de>; Tue, 25 Jun 2024 04:36:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A64DF1F2274E
	for <lists+cgroups@lfdr.de>; Tue, 25 Jun 2024 02:36:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 118C945012;
	Tue, 25 Jun 2024 02:36:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="S6Of6d5J"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86D9A1BC57
	for <cgroups@vger.kernel.org>; Tue, 25 Jun 2024 02:36:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719282996; cv=none; b=fSb8sZ3vq6BK8gZm3XhZSrN7LhHR58S8L9OeVGacCJZwqNvcV1lU0k0mLso2nU0ChrzMk6bimyojwrTiPT/k+x+4uR9Kr05+7LDdeX1Si981BR8T9myeTjEyHgsnkSUwxiuT5z4bK8NoXB39ULRXFsIcN8IeQqEhrwFLHg/TpjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719282996; c=relaxed/simple;
	bh=E3dRV3THCRl8+7F7g/EIdSW3iGC+lN12chAsAfvgans=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type:Content-Disposition; b=j9mQI59BaC1J4qj+kGjihyMsC0ByQ3opQyOunfypdRzy4HsAd/m4EOJeBWmjefuXiZujimWb4WkanhIDtngOtQJJKzCs3FBFdVqfQnHtNC5uiqZierY+y0I3jp9l0vO9AxLHvnlJhXXe+W8JOJeueWp+ASi6DxQj+4ZOlb6BpeM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=S6Of6d5J; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1719282992;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lgjh/ZqyuyNc2ziwefd5jIC6p/c9Pbm133iPEufxgFk=;
	b=S6Of6d5Jdw3yiPYHikH1KxuxNbJ2CbLTzI9FKc7ihXnOGKlc9zFTqZIGZxxQzvkz0Tvb7i
	Fwe6I/H4hy4MHtriKQW4O8xBYTxu1NIByWsFxB17UV8aEk/LcU22ZseM7A4hWq6kgJeD5H
	nVAwqOQFDr1e0Oig3y+n6hj/gEIeUj8=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-37-HA7UuiOeO9qmN_8WdztCrA-1; Mon, 24 Jun 2024 22:36:31 -0400
X-MC-Unique: HA7UuiOeO9qmN_8WdztCrA-1
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-2c7c3069f37so6267722a91.0
        for <cgroups@vger.kernel.org>; Mon, 24 Jun 2024 19:36:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719282990; x=1719887790;
        h=content-transfer-encoding:content-disposition:mime-version
         :references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lgjh/ZqyuyNc2ziwefd5jIC6p/c9Pbm133iPEufxgFk=;
        b=Bsa+yzxKjRjYuC0Nlzg/ai25vYk/UHVXml6XVrAJVFG1yJvLwrWDV0x7U1czdmMUXj
         Epof8gE0G4fnNBVLWlKKtvujhJKKzDqqafKbQ54gwAER19KBIW95H5rErej5PImb68/H
         oZalIbP7D9zaq0oczGwC/BJKoOpYeRUaqrkopjipvLadJM3NKbnLMY7MnNJfePN+Zz1J
         sK6S7DJxdJoEKoZIoaMP4BOIhTKXTN6o9cyKHySciuZNS+a4F9utzdjiUrO0YaaUApre
         IEOMuBfjapUmu6IcMAwQ6dv4c54/slEwwQaeYcdTRZtXSNGPlWk3RPkUjEiyDAr6N+YD
         scdg==
X-Forwarded-Encrypted: i=1; AJvYcCU7wz5aaBBkEJ3V4WWicbt3IyC7TbfH25Qk7/LsDoFe0NTZ7PQUxfSRRbn++WfvllD2sgzpPpWUPI3zA8r+aL6YBFZBSnG5Zw==
X-Gm-Message-State: AOJu0YzGPqO9v/nMY+iolPmCrVrHzsW5dkpfzQWnBSQ5eh6kbTYLE4OC
	rtVUMvCZkilso6pTphg3yISL1XoNIc0hjqZcLjUAk9Z3Uyxyfhussv5NaXC7tYJbyzAfmY1ehHJ
	n86QiiEyO588+yfG0ZMu6krRlqmePeNtMRWw+pvIehkX1O3duoFT3kGs=
X-Received: by 2002:a17:902:f54c:b0:1f9:ddea:451d with SMTP id d9443c01a7336-1fa23bdf3b8mr64915025ad.3.1719282990058;
        Mon, 24 Jun 2024 19:36:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE4WMoko6gcC4VFyy3g03y2NymCh8kug4N9kCWpYbiJNlDLdPwV2S623AMwW20um4Llrvh4oA==
X-Received: by 2002:a17:902:f54c:b0:1f9:ddea:451d with SMTP id d9443c01a7336-1fa23bdf3b8mr64914795ad.3.1719282989651;
        Mon, 24 Jun 2024 19:36:29 -0700 (PDT)
Received: from LeoBras.redhat.com ([2804:1b3:a801:fda9:d11e:3755:61da:97fd])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f9eb2f038asm69440895ad.52.2024.06.24.19.36.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jun 2024 19:36:29 -0700 (PDT)
From: Leonardo Bras <leobras@redhat.com>
To: Vlastimil Babka <vbabka@suse.cz>
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
	Hyeonggon Yoo <42.hyeyoo@gmail.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Marcelo Tosatti <mtosatti@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Will Deacon <will@kernel.org>,
	Waiman Long <longman@redhat.com>,
	Boqun Feng <boqun.feng@gmail.com>,
	linux-kernel@vger.kernel.org,
	cgroups@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: [RFC PATCH v1 0/4] Introduce QPW for per-cpu operations
Date: Mon, 24 Jun 2024 23:36:21 -0300
Message-ID: <ZnotJB-8YM562QsR@LeoBras>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <261612b9-e975-4c02-a493-7b83fa17c607@suse.cz>
References: <20240622035815.569665-1-leobras@redhat.com> <261612b9-e975-4c02-a493-7b83fa17c607@suse.cz>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Mon, Jun 24, 2024 at 09:31:51AM +0200, Vlastimil Babka wrote:
> Hi,
> 
> you've included tglx, which is great, but there's also LOCKING PRIMITIVES
> section in MAINTAINERS so I've added folks from there in my reply.
> Link to full series:
> https://lore.kernel.org/all/20240622035815.569665-1-leobras@redhat.com/

Thanks Vlastimil!

> 
> On 6/22/24 5:58 AM, Leonardo Bras wrote:
> > The problem:
> > Some places in the kernel implement a parallel programming strategy
> > consisting on local_locks() for most of the work, and some rare remote
> > operations are scheduled on target cpu. This keeps cache bouncing low since
> > cacheline tends to be mostly local, and avoids the cost of locks in non-RT
> > kernels, even though the very few remote operations will be expensive due
> > to scheduling overhead.
> > 
> > On the other hand, for RT workloads this can represent a problem: getting
> > an important workload scheduled out to deal with remote requests is
> > sure to introduce unexpected deadline misses.
> > 
> > The idea:
> > Currently with PREEMPT_RT=y, local_locks() become per-cpu spinlocks.
> > In this case, instead of scheduling work on a remote cpu, it should
> > be safe to grab that remote cpu's per-cpu spinlock and run the required
> > work locally. Tha major cost, which is un/locking in every local function,
> > already happens in PREEMPT_RT.
> 
> I've also noticed this a while ago (likely in the context of rewriting SLUB
> to use local_lock) and asked about it on IRC, and IIRC tglx wasn't fond of
> the idea. But I forgot the details about why, so I'll let the the locking
> experts reply...
> 
> > Also, there is no need to worry about extra cache bouncing:
> > The cacheline invalidation already happens due to schedule_work_on().
> > 
> > This will avoid schedule_work_on(), and thus avoid scheduling-out an 
> > RT workload. 
> > 
> > For patches 2, 3 & 4, I noticed just grabing the lock and executing
> > the function locally is much faster than just scheduling it on a
> > remote cpu.
> > 
> > Proposed solution:
> > A new interface called Queue PerCPU Work (QPW), which should replace
> > Work Queue in the above mentioned use case. 
> > 
> > If PREEMPT_RT=n, this interfaces just wraps the current 
> > local_locks + WorkQueue behavior, so no expected change in runtime.
> > 
> > If PREEMPT_RT=y, queue_percpu_work_on(cpu,...) will lock that cpu's
> > per-cpu structure and perform work on it locally. This is possible
> > because on functions that can be used for performing remote work on
> > remote per-cpu structures, the local_lock (which is already
> > a this_cpu spinlock()), will be replaced by a qpw_spinlock(), which
> > is able to get the per_cpu spinlock() for the cpu passed as parameter.
> > 
> > Patch 1 implements QPW interface, and patches 2, 3 & 4 replaces the
> > current local_lock + WorkQueue interface by the QPW interface in
> > swap, memcontrol & slub interface.
> > 
> > Please let me know what you think on that, and please suggest
> > improvements.
> > 
> > Thanks a lot!
> > Leo
> > 
> > Leonardo Bras (4):
> >   Introducing qpw_lock() and per-cpu queue & flush work
> >   swap: apply new queue_percpu_work_on() interface
> >   memcontrol: apply new queue_percpu_work_on() interface
> >   slub: apply new queue_percpu_work_on() interface
> > 
> >  include/linux/qpw.h | 88 +++++++++++++++++++++++++++++++++++++++++++++
> >  mm/memcontrol.c     | 20 ++++++-----
> >  mm/slub.c           | 26 ++++++++------
> >  mm/swap.c           | 26 +++++++-------
> >  4 files changed, 127 insertions(+), 33 deletions(-)
> >  create mode 100644 include/linux/qpw.h
> > 
> > 
> > base-commit: 50736169ecc8387247fe6a00932852ce7b057083
> 


