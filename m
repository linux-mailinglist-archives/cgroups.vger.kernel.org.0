Return-Path: <cgroups+bounces-7402-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 55B21A7F026
	for <lists+cgroups@lfdr.de>; Tue,  8 Apr 2025 00:05:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 183F91890C11
	for <lists+cgroups@lfdr.de>; Mon,  7 Apr 2025 22:05:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF641223330;
	Mon,  7 Apr 2025 22:05:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K1I0fOaT"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69D4B207E1A;
	Mon,  7 Apr 2025 22:05:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744063542; cv=none; b=FZCgnOKzwuCiGQqPW4RJuQJh2T+LdU3Jm850Cw9dIizL3zo8yWnQivsGbCZdgkwOMqyrMmitadkPVhFd43VoIqE3dxYevbXAF/9e0dTRyc3fhgGWLP2+G+1rNaMBeVMaftkWVyGuTc2EFavWTf7ByVhxPl3gleIq1zgNj4D1bCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744063542; c=relaxed/simple;
	bh=EJgXkyupm1mNUkxIVixIgM+Qq8gXcFsupw+QiNg9kv8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PoucCX2NlDZuHUiXDG0CHkZz2UYTjjN8Q+JZjSGzxLQ1P8ZQOR5cECCWsSbgPQoeR3Zc09Ptya6FOwPuViQD3HVHwXrcbQLTT5AlU3JSKjOuCFmjXMZ250nDdvcaN7YaRG+3e+0C1lewl4lMZ22S0VXthj8MAw28VgXb9+K9Yg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K1I0fOaT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1089C4CEDD;
	Mon,  7 Apr 2025 22:05:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744063541;
	bh=EJgXkyupm1mNUkxIVixIgM+Qq8gXcFsupw+QiNg9kv8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=K1I0fOaTOO8W3RmNdoMtQ+q8pIvpNIa1G20TpqPG+lfExr9sYBws+ED1PqbZJrEqa
	 geEqkbNcYElgBQcnRrzg0e72t+Ukxb6GCBFpIzj5aieIR7nQ0sTWxEbtcdGHSKCt8V
	 qhwuT6GU8Dyeq2YtHErtAHgCwB6UUQFRnZMf87C1rsW8GBIZ6LJnWVTWTMYWyn/jmA
	 85Sv11qHZ7r8CIhc4nMzB5p76Dd7sXeJiqNlQK4Nb2uZEcsz6TLdUOS86H3oDL5anF
	 LB5AX1u1U5oM6XkcVh5/9Au7UudQuaWVMqUiEtJV5hvyMS3VgY7hpKZ3eGHrd4OVsv
	 gsdmx2/oj3RiQ==
Date: Mon, 7 Apr 2025 12:05:40 -1000
From: Tejun Heo <tj@kernel.org>
To: Waiman Long <longman@redhat.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>,
	Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
	cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] cgroup/cpuset: Miscellaneous cleanup patches
Message-ID: <Z_RMNHmZJfklsoYA@slm.duckdns.org>
References: <20250407212127.1534285-1-longman@redhat.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250407212127.1534285-1-longman@redhat.com>

On Mon, Apr 07, 2025 at 05:21:02PM -0400, Waiman Long wrote:
> This series contains a number of cpuset cleanup patches.
> 
> Waiman Long (3):
>   cgroup/cpuset: Always use cpu_active_mask
>   cgroup/cpuset: Fix obsolete comment in cpuset_css_offline()
>   cgroup/cpuset: Add warnings to catch inconsistency in exclusive CPUs

Applied 1-3 to cgroup/for-6.16.

Thanks.

-- 
tejun

