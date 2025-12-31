Return-Path: <cgroups+bounces-12836-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FAFACEC082
	for <lists+cgroups@lfdr.de>; Wed, 31 Dec 2025 14:45:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 86A2D300E466
	for <lists+cgroups@lfdr.de>; Wed, 31 Dec 2025 13:45:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F3B13164B6;
	Wed, 31 Dec 2025 13:45:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Vx1P2FfS"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E09F405F7;
	Wed, 31 Dec 2025 13:45:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767188734; cv=none; b=XrIkTdety54Ng/HtVV9t11igEptJVTx84JCsiM3cZAOjTYPJpzfgJZAK8X68ymMyJ0dsW0mOvt6FXjpyFVn+3xsDcoKMoi2d/5WKoFHKY3vOUxHuv8nNGb2eKBkd00av9KYgYGUdadZuZI1xRYtvf9xzAW+kXuFJavyaA/6h5yQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767188734; c=relaxed/simple;
	bh=Y5lTmiVqic6uOses6/RBPW3lvTquV7zqhHPq8aQw34M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MRPNo5DfqSw/oTMqRA3Jcxkdxob/fY0RDEnL4YABPEzw8fPVOSx0fbPYoiFZJ7oNtLD0aa6HYwveVpHuT2/ulHlG7nhFxrTaBFl3Aj+Pez9v//NDj+3R4JJ014eVCl6aW9LY+RbP3qoIOldtFLbYhmZwD14cOa+OBIhWZYckuLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Vx1P2FfS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 438F4C113D0;
	Wed, 31 Dec 2025 13:45:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767188732;
	bh=Y5lTmiVqic6uOses6/RBPW3lvTquV7zqhHPq8aQw34M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Vx1P2FfSkiM9kppodGYA35GpPxHALVz4tqlXMJw7IRuRoyhQc3Qx9tILc+uax6TC7
	 E9oNlkBRd2Rs1GjCPqIEDj2UtwboDm+nyiXhVS4cpKvGjduLnDZUAkhmBouab0kgAE
	 9iFHz545GjGqBURbPFBcct+xIbjqRKoEQGe2nWxgG+6p4IO8R8Au9Jm7Y9Krmwprxc
	 HS8s1ug8q6nJc7bHQCVkjEoCysFcYtunXpn0pt+/iwuaDQ6zXF+kyUJavHNXJgl7UT
	 Y4URPh1rDmzsjeYecL3DpbBHbSEjLZfzNZGbTbp/0Hdxg9F9Won6RzlhHNOiKEJBL1
	 sy0xjelFd82aw==
Date: Wed, 31 Dec 2025 14:45:29 +0100
From: Frederic Weisbecker <frederic@kernel.org>
To: Waiman Long <llong@redhat.com>
Cc: LKML <linux-kernel@vger.kernel.org>,
	Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Chen Ridong <chenridong@huawei.com>,
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
	Vlastimil Babka <vbabka@suse.cz>, Will Deacon <will@kernel.org>,
	cgroups@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-block@vger.kernel.org, linux-mm@kvack.org,
	linux-pci@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH 05/33] sched/isolation: Save boot defined domain flags
Message-ID: <aVUo-csI1gqZL89O@localhost.localdomain>
References: <20251224134520.33231-1-frederic@kernel.org>
 <20251224134520.33231-6-frederic@kernel.org>
 <04708b57-7ffe-4a97-925f-926d577061a6@redhat.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <04708b57-7ffe-4a97-925f-926d577061a6@redhat.com>

Le Thu, Dec 25, 2025 at 05:27:54PM -0500, Waiman Long a écrit :
> On 12/24/25 8:44 AM, Frederic Weisbecker wrote:
> > HK_TYPE_DOMAIN will soon integrate not only boot defined isolcpus= CPUs
> > but also cpuset isolated partitions.
> > 
> > Housekeeping still needs a way to record what was initially passed
> > to isolcpus= in order to keep these CPUs isolated after a cpuset
> > isolated partition is modified or destroyed while containing some of
> > them.
> > 
> > Create a new HK_TYPE_DOMAIN_BOOT to keep track of those.
> > 
> > Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
> > Reviewed-by: Phil Auld <pauld@redhat.com>
> > ---
> >   include/linux/sched/isolation.h | 4 ++++
> >   kernel/sched/isolation.c        | 5 +++--
> >   2 files changed, 7 insertions(+), 2 deletions(-)
> > 
> > diff --git a/include/linux/sched/isolation.h b/include/linux/sched/isolation.h
> > index d8501f4709b5..109a2149e21a 100644
> > --- a/include/linux/sched/isolation.h
> > +++ b/include/linux/sched/isolation.h
> > @@ -7,8 +7,12 @@
> >   #include <linux/tick.h>
> >   enum hk_type {
> > +	/* Revert of boot-time isolcpus= argument */
> > +	HK_TYPE_DOMAIN_BOOT,
> >   	HK_TYPE_DOMAIN,
> > +	/* Revert of boot-time isolcpus=managed_irq argument */
> >   	HK_TYPE_MANAGED_IRQ,
> > +	/* Revert of boot-time nohz_full= or isolcpus=nohz arguments */
> >   	HK_TYPE_KERNEL_NOISE,
> >   	HK_TYPE_MAX,
> 
> "Revert" is a verb. The term "Revert of" sound strange to me. I think using
> "Inverse of" will sound better.

Somehow I thought it could be a noun as well. At least I wouldn't mind if
it ever turns that way.

Fixing that, thanks.

> 
> Cheers,
> Longman
> 

-- 
Frederic Weisbecker
SUSE Labs

