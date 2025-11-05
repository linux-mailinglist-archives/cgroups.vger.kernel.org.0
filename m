Return-Path: <cgroups+bounces-11595-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 42976C366CE
	for <lists+cgroups@lfdr.de>; Wed, 05 Nov 2025 16:44:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 803B6642A7C
	for <lists+cgroups@lfdr.de>; Wed,  5 Nov 2025 15:27:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 579C725EF87;
	Wed,  5 Nov 2025 15:23:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fI54FeAi"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 018AC214812;
	Wed,  5 Nov 2025 15:23:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762356184; cv=none; b=gVdJ3zCzAn/kvoWEuxLzgohdApoKM+0vevvpTX5piYXFyho5cI90vrgCY9BCNnsiLnqy/TOdhVA9ENVvrOkditB9NklhoLPZ0N+t3FY8+Zxb7c1CDhO8ZPfASvP93dDDYi8pD3a07OxbJqHsKnaCmhcwCHt0eW6IYI8jfSNNCzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762356184; c=relaxed/simple;
	bh=fusB0gibvJKJQXePl8CXgegfMzOrPm+adEItFF8rn4g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=htytefE4YnDrCTZsTOMuTQmyODYqZ9jrBR2hKhuETlRa1iqQrnGG0y4YPZq8Yi+CKriz1k0+uDMyoJBEcHowa7HMHRNwdCCarkoGsmPBVQ/yJheU3ba2F0r6+l3iZiZR3c8fDh12rBDym/d18gYPSGYtKwkUf0x7o1hqeyH4EZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fI54FeAi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5CEDBC4CEF5;
	Wed,  5 Nov 2025 15:23:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762356183;
	bh=fusB0gibvJKJQXePl8CXgegfMzOrPm+adEItFF8rn4g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fI54FeAijnMRfBlbxLG2+Iek1ya9gdrVicMOy6ppH48QNJY1JwCA0YIcMTsGcAyyZ
	 KuEb2RQHhUEh749M7gs858+NV46mLYZbGP/8Mp4QmoJ81PcA4BX5I+j9kHoraKETyY
	 5/xsZ+pDWMBJe6yrYwpFs/GuyQIvd/XVyzYLrl689vn8XudarKTwU0ZOlC8B+b3wxA
	 4M04j8KUlHVMArmw92JUAxOG0ooE93fYnwL/Ap60WXkOAbqG1sxhteuwbYCz02ush8
	 Nel4ht9ZvEnSBScs7Jx0YygYSCSf5Dvon/HzaCuHFaOaiCZMR0DrRHFWElXp1YaKVm
	 4kzXv9mqOHBdg==
Date: Wed, 5 Nov 2025 16:23:01 +0100
From: Frederic Weisbecker <frederic@kernel.org>
To: Waiman Long <llong@redhat.com>
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
	Vlastimil Babka <vbabka@suse.cz>, Will Deacon <will@kernel.org>,
	cgroups@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-block@vger.kernel.org, linux-mm@kvack.org,
	linux-pci@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH 12/33] sched/isolation: Convert housekeeping cpumasks to
 rcu pointers
Message-ID: <aQtr1VM9k5-uJbfu@localhost.localdomain>
References: <20251013203146.10162-1-frederic@kernel.org>
 <20251013203146.10162-13-frederic@kernel.org>
 <083388fb-3240-4329-ad49-b81cd89acffd@redhat.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <083388fb-3240-4329-ad49-b81cd89acffd@redhat.com>

Le Mon, Oct 20, 2025 at 11:49:53PM -0400, Waiman Long a écrit :
> >   bool housekeeping_test_cpu(int cpu, enum hk_type type)
> >   {
> > -	if (static_branch_unlikely(&housekeeping_overridden))
> > -		if (housekeeping.flags & BIT(type))
> > -			return cpumask_test_cpu(cpu, housekeeping.cpumasks[type]);
> > +	if (housekeeping.flags & BIT(type))
> > +		return cpumask_test_cpu(cpu, housekeeping_cpumask(type));
> >   	return true;
> >   }
> 
> The housekeeping_overridden static key check is kept in other places except
> this one. Should we keep it for consistency?

Indeed!

Thanks.

-- 
Frederic Weisbecker
SUSE Labs

