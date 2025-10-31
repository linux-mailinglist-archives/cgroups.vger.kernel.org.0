Return-Path: <cgroups+bounces-11464-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A9DECC26258
	for <lists+cgroups@lfdr.de>; Fri, 31 Oct 2025 17:37:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 73CB8580326
	for <lists+cgroups@lfdr.de>; Fri, 31 Oct 2025 16:14:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4607B2ECE84;
	Fri, 31 Oct 2025 16:08:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lNm3q3Fx"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D879D34F46C;
	Fri, 31 Oct 2025 16:08:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761926893; cv=none; b=p+yYkcKVqoV8FNRNoUrm167b133MfLytUbu+JacqnA9h94m5jyuxAxnRe+Tb5Jf5gpcXjzF9hY9L+Cq98LdvsPJe+VOgkydK4MwwJRgaxw6SSfSAFTfeNGOyVQvWyy3wCREhOKHSSnh7Ge7eUHqzdR41i3vf9RfLJs79RhFWq4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761926893; c=relaxed/simple;
	bh=DBnRWCc9yOikTyJAePQMQXl8JnrzRu+fPN1hD2Ld8qU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eIRAAy3Cv3mCN0owTp9W7KpkNHE4M9QWuKYpJsfjNNGLN/mxGC507nhKV7iHJADgz4jVdALLlBQtcVc9etJPLt6xC015TAx9uehTdnNOSGcAinmRUswvAKQ0hcIR84Br7oi0H8yA+D137fPjosoTfDDNGsX4HEv5H2ErYtMrT7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lNm3q3Fx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CDA40C4CEE7;
	Fri, 31 Oct 2025 16:08:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761926892;
	bh=DBnRWCc9yOikTyJAePQMQXl8JnrzRu+fPN1hD2Ld8qU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lNm3q3FxkqsL5QWMXLypsadCbVDHoS7srbuL3umgOILAgP2CmodbUjbmVgoYLqLve
	 gqW5tz1EPBizlAZk5MqElD4DQfIHAxzmtN19JFglozpQKcQGBxYMl7yLPgL06f0Alc
	 Wmr5T7iw805pUJEirQ0gG/+y+Tb8PrWnxbGm6rEfbp7xc7L8cnr1zQFwXjAnhR1hBH
	 leAVv9GH6W28+5E2FEe+8vxpWiPWLa7dvgRWsbm9oHb0ZrOKO2qaDT1p5UMDci9pYi
	 2qfoSEzL1lmFVYHaphzP0WGPUKmYmpipLpz2ALLuOYx0tXFwTP1Ngxt7pTzWQPBIkK
	 d4ltC1wGy9Gzg==
Date: Fri, 31 Oct 2025 17:08:09 +0100
From: Frederic Weisbecker <frederic@kernel.org>
To: Chen Ridong <chenridong@huaweicloud.com>
Cc: LKML <linux-kernel@vger.kernel.org>,
	Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Danilo Krummrich <dakr@kernel.org>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Gabriele Monaco <gmonaco@redhat.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Ingo Molnar <mingo@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
	Jens Axboe <axboe@kernel.dk>, Johannes Weiner <hannes@cmpxchg.org>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Marco Crivellari <marco.crivellari@suse.com>,
	Michal Hocko <mhocko@suse.com>, Muchun Song <muchun.song@linux.dev>,
	Paolo Abeni <pabeni@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>, Phil Auld <pauld@redhat.com>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Simon Horman <horms@kernel.org>, Tejun Heo <tj@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Vlastimil Babka <vbabka@suse.cz>, Waiman Long <longman@redhat.com>,
	Will Deacon <will@kernel.org>, cgroups@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-block@vger.kernel.org,
	linux-mm@kvack.org, linux-pci@vger.kernel.org,
	netdev@vger.kernel.org
Subject: Re: [PATCH 11/33] cpuset: Provide lockdep check for cpuset lock held
Message-ID: <aQTe6X5XXSp8_3z5@localhost.localdomain>
References: <20251013203146.10162-1-frederic@kernel.org>
 <20251013203146.10162-12-frederic@kernel.org>
 <b94f6159-a280-4890-a02a-f19ff808de5b@huaweicloud.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b94f6159-a280-4890-a02a-f19ff808de5b@huaweicloud.com>

Le Tue, Oct 14, 2025 at 09:29:25PM +0800, Chen Ridong a écrit :
> 
> 
> On 2025/10/14 4:31, Frederic Weisbecker wrote:
> > cpuset modifies partitions, including isolated, while holding the cpuset
> > mutex.
> > 
> > This means that holding the cpuset mutex is safe to synchronize against
> > housekeeping cpumask changes.
> > 
> > Provide a lockdep check to validate that.
> > 
> > Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
> > ---
> >  include/linux/cpuset.h | 2 ++
> >  kernel/cgroup/cpuset.c | 7 +++++++
> >  2 files changed, 9 insertions(+)
> > 
> > diff --git a/include/linux/cpuset.h b/include/linux/cpuset.h
> > index 2ddb256187b5..051d36fec578 100644
> > --- a/include/linux/cpuset.h
> > +++ b/include/linux/cpuset.h
> > @@ -18,6 +18,8 @@
> >  #include <linux/mmu_context.h>
> >  #include <linux/jump_label.h>
> >  
> > +extern bool lockdep_is_cpuset_held(void);
> > +
> >  #ifdef CONFIG_CPUSETS
> >  
> >  /*
> > diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
> > index 8595f1eadf23..aa1ac7bcf2ea 100644
> > --- a/kernel/cgroup/cpuset.c
> > +++ b/kernel/cgroup/cpuset.c
> > @@ -279,6 +279,13 @@ void cpuset_full_unlock(void)
> >  	cpus_read_unlock();
> >  }
> >  
> > +#ifdef CONFIG_LOCKDEP
> > +bool lockdep_is_cpuset_held(void)
> > +{
> > +	return lockdep_is_held(&cpuset_mutex);
> > +}
> > +#endif
> > +
> >  static DEFINE_SPINLOCK(callback_lock);
> >  
> >  void cpuset_callback_lock_irq(void)
> 
> Is the lockdep_is_cpuset_held function actually being used?
> If CONFIG_LOCKDEP is disabled, compilation would fail with an "undefined reference to
> lockdep_is_cpuset_held" error.

Although counter-intuitive, this is how the lockdep_is_held() functions family
do work.

This allows this kind of trick:

if (IS_ENABLED(CONFIG_LOCKDEP))
   WARN_ON_ONCE(!lockdep_is_held(&some_lock))

This works during the compilation because the prototype of lockdep_is_held()
is declared. And since the IS_ENABLED() is resolved during compilation as well,
the conditional code is wiped out and therefore not linked. As a result the
linker doesn't even look for the definition of lockdep_is_held() and we don't
need to define an off case that would return a wrong assumption.

Thanks.

-- 
Frederic Weisbecker
SUSE Labs

