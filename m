Return-Path: <cgroups+bounces-8754-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 47BFFB092C8
	for <lists+cgroups@lfdr.de>; Thu, 17 Jul 2025 19:09:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2B79B1642AA
	for <lists+cgroups@lfdr.de>; Thu, 17 Jul 2025 17:09:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD3182FE39E;
	Thu, 17 Jul 2025 17:05:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jOIjZBB7"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94A9D2FE397;
	Thu, 17 Jul 2025 17:05:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752771917; cv=none; b=jGqwWuegviJLOgiyaquPd7Pu8FpGS7MnQSy5JyLU6b9Us9jLmufX0Qm08QhcqjrfoQyoPfzR3jslHlgQ+cIagbsLukJif82y9fnRa6ak2uejxumYfu4R5fzikMm0htAUbZ9/NbkafO467fszVdH2fBouURhw7+ZSmuYS3ZdFQKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752771917; c=relaxed/simple;
	bh=f4TBundVVp2x6JyWmytFqL4rDtzsnoQsuVW6B2mEUH4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k3c0sxSH0KMJ4YyIfz1gQPPhEWUislv6sHPjaFiUbSjGPsdevurvfiVDxP2e3uvZ+tXwyyimu2MqpmZaMR8TbLZSLVQ+dM3z88aS9ZlWHou7CRXC3SK0bpHtbnzsfIJotGsQGTOUCjYc1Gf7kquTnnJ8Z9u7xOocv78BnOQQ118=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jOIjZBB7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DFAC8C4CEF8;
	Thu, 17 Jul 2025 17:05:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752771916;
	bh=f4TBundVVp2x6JyWmytFqL4rDtzsnoQsuVW6B2mEUH4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jOIjZBB7nU8CwNhHDFRA80VBsXfOlimaTqZPoUiEVSQK2yXapmorp0V7HzIT5/a5p
	 0PfGhnsSg160RD1rQlErlJCl651qwBRqIgQHTld3BlWXHS9WTdWrfQ8KVAE+Nu9wYV
	 vB4K/g3iEn+glYyU7Q0T+UA9ZpwIYH03FQEYjc9UBM7zlqbNwSBUrZg+yCk6GR5QuW
	 X2yp7X3wu9FC09muDTNBc/kK0PxQ1bCrv9LGRjrzuG+aH/L7v8ztx31UqHbBup2j/M
	 1/xM2ivZisfItTo9XP8fOVDGF9LHKlDi4JlpXb3BTbJorKz6vzJoxOa+rVmiZ6/763
	 CyuntPEFZLUUA==
Date: Thu, 17 Jul 2025 07:05:14 -1000
From: Tejun Heo <tj@kernel.org>
To: Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>
Cc: Tiffany Yang <ynaffit@google.com>, linux-kernel@vger.kernel.org,
	John Stultz <jstultz@google.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Stephen Boyd <sboyd@kernel.org>,
	Anna-Maria Behnsen <anna-maria@linutronix.de>,
	Frederic Weisbecker <frederic@kernel.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Pavel Machek <pavel@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Chen Ridong <chenridong@huawei.com>, kernel-team@android.com,
	Jonathan Corbet <corbet@lwn.net>, cgroups@vger.kernel.org,
	linux-doc@vger.kernel.org
Subject: Re: [RFC PATCH v2] cgroup: Track time in cgroup v2 freezer
Message-ID: <aHktSgmh-9dyB7bz@slm.duckdns.org>
References: <20250714050008.2167786-2-ynaffit@google.com>
 <5rm53pnhpdeqljxqywh26gffh6vlyb5j5s6pzxhv52odhkl4fm@o6p7daoponsn>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5rm53pnhpdeqljxqywh26gffh6vlyb5j5s6pzxhv52odhkl4fm@o6p7daoponsn>

Hello,

On Thu, Jul 17, 2025 at 02:56:13PM +0200, Michal Koutný wrote:
...
> > +  cgroup.freeze.stat
> 
> With the given implementation (and use scenario), this'd better exposed
> in
>   cgroup.freeze.stat.local
> 
> I grok the hierarchical summing would make little sense and it'd make
> implementaion more complex. With that I'm thinking about formulation:
> 
> 	Cumulative time that cgroup has spent between freezing and
> 	thawing, regardless of whether by self or ancestor cgroups. NB
> 	(not) reaching "frozen" state is not accounted here.

I wonder what hierarchical summing would look like for this. It's absolute
time interval measurement and I'm not sure whether summing up the
descendants' durations is the best way to go about it. ie. Should it be the
total duration any of the descendants are freezing or should it be sum of
the freezing durations of all descendants?

Thanks.

-- 
tejun

