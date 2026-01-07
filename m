Return-Path: <cgroups+bounces-12940-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D152ECFD82B
	for <lists+cgroups@lfdr.de>; Wed, 07 Jan 2026 12:57:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4236930146C1
	for <lists+cgroups@lfdr.de>; Wed,  7 Jan 2026 11:57:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D160130DD2C;
	Wed,  7 Jan 2026 11:57:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LeOVqk9+"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F2C7238166;
	Wed,  7 Jan 2026 11:57:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767787023; cv=none; b=eImndedoxtpdBeEKAbFojQdvPfOo1JJr0qWpY2Ulp4xJOJovB6gnSSJZIeDa45deCIxmtQQLyOFMdScfuCCxsAj6xVSv32bhhU4cIXlqw8Jnbv0cGDglmWrNw+5wvIGeafJEMX1FOQrtpuz6pMR7oyKWh+Ajk9rznKCnXgOv21s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767787023; c=relaxed/simple;
	bh=mNpHcF+MwpeYkX9EkT3dgyo2t+tch8FndQ1ofJbAPRQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Lib/rEo2TrXGAw+PwoEEnmtV50OFHN2E6F4GrqAT+AFvXbCPDYi94svYY6vv8LQbQ5WLrW2OlLuKOsxW1JsMBKQSDjELNCqMO2KZ2DW1fn/romiRl0LMmSmjxI0RMQtPMDLdLxwMzcboqKBzUsdnDvAxuvRSx7hgpxBlLAoFMGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LeOVqk9+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7530C2BC86;
	Wed,  7 Jan 2026 11:56:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767787023;
	bh=mNpHcF+MwpeYkX9EkT3dgyo2t+tch8FndQ1ofJbAPRQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LeOVqk9+TU5kCP+FDRa6whXFCQVaVEbDllyqM6h//SAX5uiVAXQ8VG7Am0rvJsC1H
	 GqoHmEPSiac74Rt53FFrHdVYKM4/rFVqh30AdgVeV6vLWbAjvELEI1HTUOnJqZhRcl
	 WUKTPSBfeNtl/h9hRKM1nu0OKjKz29OOH9dTct1GoghBZrfukj/3dyGolifM9h+2bh
	 wbVLW2c8CGbXntqacDOCLSp8UU61M7HCX59PbmrBJjXYcCtF5Cx56s4+CUuypQTiMs
	 aUdEwgtI6C7dlhy4lPby3E841CBfyCwkeyWL2UmPv7fe8h0pBCK+OfBWitaUqoPHxs
	 uX/nyikfJSLNw==
Date: Wed, 7 Jan 2026 11:56:53 +0000
From: Simon Horman <horms@kernel.org>
To: Frederic Weisbecker <frederic@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
	Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>,
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
	Shakeel Butt <shakeel.butt@linux.dev>, Tejun Heo <tj@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Vlastimil Babka <vbabka@suse.cz>, Waiman Long <longman@redhat.com>,
	Will Deacon <will@kernel.org>, cgroups@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-block@vger.kernel.org,
	linux-mm@kvack.org, linux-pci@vger.kernel.org,
	netdev@vger.kernel.org
Subject: Re: [PATCH 13/33] sched/isolation: Convert housekeeping cpumasks to
 rcu pointers
Message-ID: <20260107115653.GA196631@kernel.org>
References: <20260101221359.22298-1-frederic@kernel.org>
 <20260101221359.22298-14-frederic@kernel.org>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260101221359.22298-14-frederic@kernel.org>

On Thu, Jan 01, 2026 at 11:13:38PM +0100, Frederic Weisbecker wrote:
> HK_TYPE_DOMAIN's cpumask will soon be made modifiable by cpuset.
> A synchronization mechanism is then needed to synchronize the updates
> with the housekeeping cpumask readers.
> 
> Turn the housekeeping cpumasks into RCU pointers. Once a housekeeping
> cpumask will be modified, the update side will wait for an RCU grace
> period and propagate the change to interested subsystem when deemed
> necessary.
> 
> Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
> ---
>  kernel/sched/isolation.c | 58 +++++++++++++++++++++++++---------------
>  kernel/sched/sched.h     |  1 +
>  2 files changed, 37 insertions(+), 22 deletions(-)
> 
> diff --git a/kernel/sched/isolation.c b/kernel/sched/isolation.c
> index 11a623fa6320..83be49ec2b06 100644
> --- a/kernel/sched/isolation.c
> +++ b/kernel/sched/isolation.c
> @@ -21,7 +21,7 @@ DEFINE_STATIC_KEY_FALSE(housekeeping_overridden);
>  EXPORT_SYMBOL_GPL(housekeeping_overridden);
>  
>  struct housekeeping {
> -	cpumask_var_t cpumasks[HK_TYPE_MAX];
> +	struct cpumask __rcu *cpumasks[HK_TYPE_MAX];
>  	unsigned long flags;
>  };
>  
> @@ -33,17 +33,28 @@ bool housekeeping_enabled(enum hk_type type)
>  }
>  EXPORT_SYMBOL_GPL(housekeeping_enabled);
>  
> +const struct cpumask *housekeeping_cpumask(enum hk_type type)
> +{
> +	if (static_branch_unlikely(&housekeeping_overridden)) {
> +		if (housekeeping.flags & BIT(type)) {
> +			return rcu_dereference_check(housekeeping.cpumasks[type], 1);
> +		}
> +	}
> +	return cpu_possible_mask;
> +}
> +EXPORT_SYMBOL_GPL(housekeeping_cpumask);
> +

Hi Frederic,

I think this patch should also update the access to housekeeping.cpumasks
in housekeeping_setup(), on line 200, to use housekeeping_cpumask().

As is, sparse flags __rcu a annotation miss match there.

  kernel/sched/isolation.c:200:80: warning: incorrect type in argument 3 (different address spaces)
  kernel/sched/isolation.c:200:80:    expected struct cpumask const *srcp3
  kernel/sched/isolation.c:200:80:    got struct cpumask [noderef] __rcu *

...

