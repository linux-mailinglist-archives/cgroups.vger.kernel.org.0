Return-Path: <cgroups+bounces-7102-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 972D1A65BE3
	for <lists+cgroups@lfdr.de>; Mon, 17 Mar 2025 19:06:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0165317C5BE
	for <lists+cgroups@lfdr.de>; Mon, 17 Mar 2025 18:06:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5D881ACEDE;
	Mon, 17 Mar 2025 18:06:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W+dYsHh9"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EBADA47;
	Mon, 17 Mar 2025 18:06:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742234797; cv=none; b=lMsVOVt0pxxHYeuCsTJv3NsUxJpsGDpR5FiUXb80ahGR3XpwNcKmjgkoJRyaAEIyBKxa3RoX4/AHvzMZWKJWiNHc4SRhwp0ibB4b2Y1AZvqSyW05cY/vqVnn0bPu5HU4WaaGfI3CTJIK7nzZnVMtwUASY/KBJ+Znjjdn732ybPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742234797; c=relaxed/simple;
	bh=3FLdo26mXFwYCtlVIqVJamLtyOrQ6/YoNDApinu0c5o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PGRm5h0GHPdV6y8uVV8BnY0SG/KIDgrrML/8YZTkS9QzyCjYTe3e5otwlr8NR26JiORtMrx4fdVzjU1ay6b5+e4T8QtNFUjScdPYN3ElY3DKkw2weY/0Q29n4G+KU8wlMHYxL4AAx2j6534UjIy9Omimw9QkuZq0RweFhiOSU6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W+dYsHh9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF80AC4CEE3;
	Mon, 17 Mar 2025 18:06:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742234796;
	bh=3FLdo26mXFwYCtlVIqVJamLtyOrQ6/YoNDApinu0c5o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=W+dYsHh9wo7womLXuX6t5hh0KPPV9T4Z57nDlJ8971VF7ZWq6Y1BAv/Joo7yxVi5e
	 CwozsDgyYIJGEpAExb7JdjQglb6SJPJg1/i5+ZyjiLJrNHvX4R3az1MH/jrneSR2qu
	 IgBY3GaB2U39GlIwSs8xKdFKimtXCk8G1nB203sa8RSkMN0bIMwdYNAR6UqgoARXnO
	 TQ0D9uju+8vsfIpNAhmhqiSgL1L60lu89IU5GWvL8QuUCY/Zw3AEsrKeu/hoa+krT5
	 ERjZXqBNPFaOtAewvCNuS2NejUzdXgJZr8EEiN7c9Xo/ixhT3ApnSs9ZEzknSxBhpL
	 DB3bb5/qJLkGA==
Date: Mon, 17 Mar 2025 08:06:35 -1000
From: Tejun Heo <tj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Johannes Weiner <hannes@cmpxchg.org>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	"T.J. Mercier" <tjmercier@google.com>,
	Michal Hocko <mhocko@kernel.org>,
	Muchun Song <muchun.song@linux.dev>, linux-mm@kvack.org,
	cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
	Meta kernel team <kernel-team@meta.com>
Subject: Re: [PATCH] memcg: add hierarchical effective limits for v2
Message-ID: <Z9hkq7pet9m-WrZY@slm.duckdns.org>
References: <mshcu3puv5zjsnendao73nxnvb2yiprml7aqgndc37d7k4f2em@vqq2l6dj7pxh>
 <ctuqkowzqhxvpgij762dcuf24i57exuhjjhuh243qhngxi5ymg@lazsczjvy4yd>
 <5jwdklebrnbym6c7ynd5y53t3wq453lg2iup6rj4yux5i72own@ay52cqthg3hy>
 <20250210225234.GB2484@cmpxchg.org>
 <Z6rYReNBVNyYq-Sg@google.com>
 <bg5bq2jakwamok6phasdzyn7uckq6cno2asm3mgwxwbes6odae@vu3ngtcibqpo>
 <t574eyvdp5ypg5enpnvfusnjjbu3ug7mevo5wmqtnx7vgt66qu@sblnf7trrpxs>
 <rpwhn5zwemr63x4tafcheekdmqullcjvvabdgrm3jgtbtfwgki@6sxglgvtgzof>
 <20250227035155.GA110982@cmpxchg.org>
 <20250316181214.704966dd41abccab249e11dc@linux-foundation.org>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250316181214.704966dd41abccab249e11dc@linux-foundation.org>

Hello,

On Sun, Mar 16, 2025 at 06:12:14PM -0700, Andrew Morton wrote:
> On Wed, 26 Feb 2025 22:51:55 -0500 Johannes Weiner <hannes@cmpxchg.org> wrote:
> 
> > > > start only with memory.max as
> > > > that has some usecases).
> > > 
> > > Yes, I can link [2] with more info added to the commit message.
> > > 
> > > Johannes, do you want effective interface for low and min as well or for
> > > now just keep the current targeted interfaces?
> > 
> > I think it would make sense to do min, low, high, max for memory in
> > one go, as a complete new feature, rather than doing them one by one.
> > 
> > Tejun, what's your take on this, considering other controllers as
> > well? Does that seem like a reasonable solution to address the "I'm in
> > a namespace and can't see my configuration" problem?
> 
> I guess Tejun missed this.
> 
> It seems that more think time is needed on this patch?

Oh yes, I did. My apologies and thanks for the poking.

I'm a bit doubtful that simply compounding the configured values and
presenting them to the nested cgroup would be a good solution here. It does
add more information but given that the same values can indicate multiple
widely differing situations, I'm unsure how much value they would provide.
Wouldn't it be just providing more numbers to be confused about?

My intuition is that most applications would want a single number to base
sizing decisions on and I don't know how they could handle the gap between
e.g. low and max without further information on configuration intent.

If someone has to provide the configuration intent anyway, why not just let
them provide the single number that the application would care about - the
intended memory amount for that application or container? We can provide a
dedicated cgroup file for it or admin can just set an xattr on the cgroup
directory. Maybe the xattr perm checks can be improved so that it aligns
better with subtree delegations for the latter.

ie. I feel like .effective's are us trying to do *something* even if that
thing doesn't actually solve the problem. I'm not hard set on this opinion
tho and would really appreciate counter arguments.

Thanks.

-- 
tejun

