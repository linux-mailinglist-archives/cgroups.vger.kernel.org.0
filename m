Return-Path: <cgroups+bounces-12609-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 24E1FCD9BE8
	for <lists+cgroups@lfdr.de>; Tue, 23 Dec 2025 16:16:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6A7833023A03
	for <lists+cgroups@lfdr.de>; Tue, 23 Dec 2025 15:16:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62953227BA4;
	Tue, 23 Dec 2025 15:16:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GNmmWNv5"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B0378460;
	Tue, 23 Dec 2025 15:16:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766502993; cv=none; b=BWJD/qyZIFIPnkOsv3VbWTH2lk2rNmOzNpZuQS4XbncEJpsqE5Gr5UffY54HYq+f+H8YhzHwElGY9XMSKRVW4sOmFFx9HVwrgZKu6a+AAUkQW+GKKDEkm8CpUug5sr/2dpq+OzZspib3N5OB5p0Q/VxXLeiqpO+FlGaMqePODsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766502993; c=relaxed/simple;
	bh=MX0UEBGbGjeyT7I+fhRvt8AzC7Kbdy82QaHX7EWOjB4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AIEhlbK/vQP53zOQZmuo1cI5z1RyIXA6jpZMZdrHF0emLQX6qEfJc1uPIXoTw2V31Az2p9HvDNRRgCw+woZ9BNlpOc6Ue2vYpRI7R1wGdSAYXVOj8fwFXc0+mEgkk4JhPCVEZpiarqdXivkNlMSosgj4HNszFaXd5dBHusNb1Gg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GNmmWNv5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00827C113D0;
	Tue, 23 Dec 2025 15:16:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766502992;
	bh=MX0UEBGbGjeyT7I+fhRvt8AzC7Kbdy82QaHX7EWOjB4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GNmmWNv5axguqpzzF5TE4K9OHVqQuwUPYn7m9Xy4O5zQEcBhdYuWYACcupNC3GUbK
	 oW2+cfENHoMcqbRbby7jWn2BmUXrd1fauW3pFEup7BKEk47nyIqle6LD9w6eOTMd9J
	 MAZqcMh2EGy49IdXJUbrDxuE/UiNrY1dxeXDWBoB4oPhLs9w0s/VtwK9L1yAqkvUhU
	 shf41UdhHRQXcM2m+TWEW/Amg+72ajreOtvYGVs4EFEnbxlGuB9fq0Yu/V+s3AuQkW
	 bEj1psfGTsi3frtp7vlRosrykLLEo7oh/Z2lOA3Qv6uVrDq80/wGYWOfg0mzPNyeo+
	 4OWUjWsJreuuw==
Date: Tue, 23 Dec 2025 16:16:29 +0100
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
Subject: Re: [PATCH 13/31] cpuset: Update HK_TYPE_DOMAIN cpumask from cpuset
Message-ID: <aUqyTUm2NipItcVu@localhost.localdomain>
References: <20251105210348.35256-1-frederic@kernel.org>
 <20251105210348.35256-14-frederic@kernel.org>
 <e0c0f8b7-112f-40d7-b211-89065e9003b2@huaweicloud.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e0c0f8b7-112f-40d7-b211-89065e9003b2@huaweicloud.com>

Le Sat, Nov 08, 2025 at 05:05:10PM +0800, Chen Ridong a écrit :
> > +int housekeeping_update(struct cpumask *mask, enum hk_type type)
> > +{
> > +	struct cpumask *trial, *old = NULL;
> > +
> > +	if (type != HK_TYPE_DOMAIN)
> > +		return -ENOTSUPP;
> > +
> > +	trial = kmalloc(cpumask_size(), GFP_KERNEL);
> > +	if (!trial)
> > +		return -ENOMEM;
> > +
> > +	cpumask_andnot(trial, housekeeping_cpumask(HK_TYPE_DOMAIN_BOOT), mask);
> 
> Since there's no comment for the 'mask' parameter, would it be better to name it 'isol_mask'? This
> would make it clearer that this is the isolation mask input and what is doing
> here.

Good point! I made the change.

Thanks.

-- 
Frederic Weisbecker
SUSE Labs

