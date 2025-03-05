Return-Path: <cgroups+bounces-6849-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D455A50A17
	for <lists+cgroups@lfdr.de>; Wed,  5 Mar 2025 19:39:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 507F416D408
	for <lists+cgroups@lfdr.de>; Wed,  5 Mar 2025 18:39:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4AAA2512D8;
	Wed,  5 Mar 2025 18:39:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cg4zcSQg"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ACED198822;
	Wed,  5 Mar 2025 18:39:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741199991; cv=none; b=TgIjDxlnkDq84zVWYre5nB32JV1JCoyrvZlqOl80G+UZN524tHEW7MgvDyoQM4eOx+3fSSArJ0gehts+xLWCtyw9VXS5wm1QEda8UWvO/h4xQseNJrnv1RsR61Sjv+YX/OZbVASVm3LLcVkE0RYjcnhgJNiP4Oyt2GEjGGVrKsg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741199991; c=relaxed/simple;
	bh=uVQk+c/QggQHiv+8/A6v7lNI9M/N5W1t0Fiz38TfaPE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AoSozuNMpU/bn808lTQJgp54s11fgc9j5uzO735Drft0LNQEZS0ORAEXgopaar4CIlj6gvDDDr5oZ23giVRepKlyCSbwuk+6DYV2pX/xrrfIEdMB5TOker23gFUcEgwuVHQcGbTO/lgpW040LvwH8Yo9hAcwNAyJyYWmue95H3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cg4zcSQg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E624CC4CED1;
	Wed,  5 Mar 2025 18:39:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741199991;
	bh=uVQk+c/QggQHiv+8/A6v7lNI9M/N5W1t0Fiz38TfaPE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cg4zcSQgXN9/t4en54R8HTqIJc1/5/MWossef0e09IOAaJjTbGlXSHgaK5dBUrC1I
	 Pla/ZAQpL07S3v62KDzDzk63gu+4OC7xc7o67i31bo8tFI99i47+JkuiaKHIJrwdqP
	 rRafrpc1NiptV1fZY3JUid7CX2sOWiVdT3fEj60tGrN8lklXD3f17Fi2m4ZVAMs9Fe
	 cWiVHKRwDLueE9s7Zrbiwaf47bfpUBJ8J8M8hV0o18hsrJDTiCG64QDTwz8vsnGo3S
	 AXy5+E6LsA7pieEd2nv2xlx28JqiJKaIAbW6CbmfCv8gzp957i4dKyet8VsXEXgTSi
	 zMs6pnug1p7hQ==
Date: Wed, 5 Mar 2025 08:39:49 -1000
From: Tejun Heo <tj@kernel.org>
To: Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>
Cc: Waiman Long <llong@redhat.com>, cgroups@vger.kernel.org,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	Josef Bacik <josef@toxicpanda.com>, Jens Axboe <axboe@kernel.dk>,
	Johannes Weiner <hannes@cmpxchg.org>
Subject: Re: [PATCH 1/9] cgroup/cpuset-v1: Add deprecation warnings to
 sched_load_balance and memory_pressure_enabled
Message-ID: <Z8iadfcPxgamx9CC@slm.duckdns.org>
References: <20250304153801.597907-1-mkoutny@suse.com>
 <20250304153801.597907-2-mkoutny@suse.com>
 <8b8f0f99-6d42-4c6f-9c43-d0224bdedf9e@redhat.com>
 <Z8cv2akQ_RY4uKQa@slm.duckdns.org>
 <n2ygi7m53y5y4dx5tjxhqgzqtgs5sisdi27sk7x2xjngpxenod@7behfsvlzhxi>
 <123839ed-f607-4374-800a-4411e87ef845@redhat.com>
 <Z8dAlvRnE28WyOGP@slm.duckdns.org>
 <5bw7yc6bacojk2i2ikhlmf2skfiix6t3ipchbnvyfttmyh644j@iyquxeuyapd7>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5bw7yc6bacojk2i2ikhlmf2skfiix6t3ipchbnvyfttmyh644j@iyquxeuyapd7>

Hello,

On Wed, Mar 05, 2025 at 11:12:21AM +0100, Michal Koutný wrote:
> On Tue, Mar 04, 2025 at 08:04:06AM -1000, Tejun Heo <tj@kernel.org> wrote:
> > I'm apprehensive about adding warning messages which may be triggered
> > consistently without anything end users can do about them.
> 
> That means you'd distinguish RE (replacement exists) vs DN (dropped as
> non-ideal) categories?

I don't think I am. I'm just concerned about emitting warn messages on every
boot without users being able to do anything about them.

> > I think that deprecation messages, unless such deprecation is
> > immediate and would have direct consequences on how the system can be
> > used, should be informational.
> 
> I could subscribe to that if there weren't so many other places to
> evaluate:
>   $ git grep -i "pr_warn.*deprec" torvalds/master --  | wc -l
>   62
>   $ git grep -i "pr_info.*deprec" torvalds/master --  | wc -l
>   2
> 
> So is the disctinction worth the hassle?

Well, not all deprecations are the same. If users are stuck on cgroup1, they
can be really stuck - there can be a tall stack of software with
dependencies that users can't do much about, at least not immediately. We
will deprecate cgroup1 but this is going to be a long stretched out process
at the end of which we should be fairly comfortable in stating that there
aren't major users left which are stuck on cgroup1.

It's almost certain that that future won't arrive in, say, three years. Five
years may be too ambitious too but let's say that at that point we are
relatively sure that most platforms have moved on (but there may still be
users on older versions of those platforms). Maybe it'd make sense to
increase the deprecation warning temperature by then to warn and drain
existing users and maybe after a few years we'd actually be able to drop
cgroup1 support.

So, I don't want to be emitting warnings on every boot for the good part of
a decade on every boot for those users. Doing so feels silly and annoying to
me. Let's inform that it's coming down the pipeline but I personally don't
want to be warned by something that's close to a decade out.

Thanks.

-- 
tejun

