Return-Path: <cgroups+bounces-5501-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 619769C2F8D
	for <lists+cgroups@lfdr.de>; Sat,  9 Nov 2024 21:52:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C38AA281F4B
	for <lists+cgroups@lfdr.de>; Sat,  9 Nov 2024 20:52:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 458A519E97C;
	Sat,  9 Nov 2024 20:52:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FahV0Uy0"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F26C11E4BE;
	Sat,  9 Nov 2024 20:52:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731185547; cv=none; b=GwcUrHCfqoV6dwxRH+8348bbahWYW5Z2vPNcxEbEusOhSMW29FzFW6SFLmoLq3uesU0ehIyeWKdg7cXSKQh7KomFw1Z3nAhxoF4ttOQYfpvGxTP9u592OS/4bY1XUSsOqIwtPQFBHpy6DGXM5l6Hm0eA7wt20Y40D/qN19JEeLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731185547; c=relaxed/simple;
	bh=zdOeCmaMe34oEAA+P0JfFajw5QPzRbbfNWxey4/9g3M=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qQ1S7YaBdyLvGymgmLnZfHTbwFxa9wRXQI7hqnaTIG2oewzq/nT59mmi73fX+avYCtRW+jlh3atTodlVWEiBnFjDwpVVWF0oYbFOStwFREYIfyWWJqrEp/g1BcTyHUVP4pBx302HjVFNQzO4Yzi4dsUWEI9GuZBIkRHzrGdG8+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FahV0Uy0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33A71C4CECE;
	Sat,  9 Nov 2024 20:52:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731185545;
	bh=zdOeCmaMe34oEAA+P0JfFajw5QPzRbbfNWxey4/9g3M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FahV0Uy09KaUAf7sz8RZAmtap8BL37OG8OSYKIzEz7begyzkm0PlyeGms+SpJ3JUe
	 EgYdPUqyEi2ztoXO/gy+onZdha/WJgKPLj52xnxRr6Surj1lob4OX8LcAYKxGoDUoJ
	 j1aJJteDjw4XeeEF56jRhRMI1hn7yioFIb/zhZDRfutEjYuC6M/U318+v4EEfInPOg
	 9rlbnUL93GSpC0wqulyFW8gc5aJA0YsCRjGzJrgZEa014O18dFxDZ4E23jOXuEpUgT
	 6vSCGVOzz077Lgek1MiVbNMp/hEX/KIAXSR3X64xxrdrZOcDmTZN27g+Um7LzxXRwx
	 g5UACP4WnbksA==
From: SeongJae Park <sj@kernel.org>
To: Joshua Hahn <joshua.hahnjy@gmail.com>
Cc: SeongJae Park <sj@kernel.org>,
	shakeel.butt@linux.dev,
	hannes@cmpxchg.org,
	mhocko@kernel.org,
	roman.gushchin@linux.dev,
	muchun.song@linux.dev,
	akpm@linux-foundation.org,
	cgroups@vger.kernel.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	kernel-team@meta.com
Subject: Re: [PATCH 2/3] memcg/hugetlb: Introduce mem_cgroup_charge_hugetlb
Date: Sat,  9 Nov 2024 12:52:22 -0800
Message-Id: <20241109205222.88428-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <CAN+CAwPEMNN_0HH-XvzenK4+k1a0cHdwTksrGTtjaEc2mvCjhA@mail.gmail.com>
References: 
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Sat, 9 Nov 2024 13:41:31 -0500 Joshua Hahn <joshua.hahnjy@gmail.com> wrote:

> Hello SJ, thank you for reviewing my patch!
> 
> On Fri, Nov 8, 2024 at 8:03 PM SeongJae Park <sj@kernel.org> wrote:
> >
> > Hi Joshua,
> >
> > On Fri, 8 Nov 2024 13:29:45 -0800 Joshua Hahn <joshua.hahnjy@gmail.com> wrote:
> >
> > > This patch introduces mem_cgroup_charge_hugetlb, which combines the
> > > logic of mem_cgroup{try,commit}_hugetlb. This reduces the footprint of
> >
> > Nit.  Seems the regular expression is not technically correct?
> 
> I see, I will change it expand it out to include both. What I meant to
> say is that it combines the functionality of both the functions, but
> I think there was a typo there. I will just expand it out so that it is
> more clear to readers!

Thank you :)

> 
> > > +int mem_cgroup_charge_hugetlb(struct folio *folio, gfp_t gfp)
> >
> > Can we add a kernel-doc comment for this function?  Maybe that for
> > mem_cgroup_hugetlb_try_charge() can be stolen with only small updates?
> 
> Yes, I can definitely add a kernel-doc for this function. Would
> you mind expanding on the "stolen only with small updates" part?
> Do you mean that instead of writing a completely new section
> in the kernel-doc, I can just change the name of the section
> and modify small parts of the description?

You're right.  I just thought that might save some of your time if that makes
sense.  I don't really mind about this, so do whatever as you prefer :)


Thanks,
SJ

[...]

