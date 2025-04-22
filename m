Return-Path: <cgroups+bounces-7710-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A9FD3A96504
	for <lists+cgroups@lfdr.de>; Tue, 22 Apr 2025 11:48:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1AC837A15EE
	for <lists+cgroups@lfdr.de>; Tue, 22 Apr 2025 09:47:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49B8D202990;
	Tue, 22 Apr 2025 09:48:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Us9FFHOQ"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 005411F0E2D;
	Tue, 22 Apr 2025 09:48:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745315309; cv=none; b=pXoXPyN3kpGo0tp/gU5Yl8fIGp0jeYLwNteT6B5GWk+Kh2RMCJOJYPkkO8M+mbuAPMuRVOOVmH2HwBYDsJkhauFZXYYkQHpEpWrhyiv4yfkz16lSxJzDw6aMUGAPbT4mB9G8gFetBT+YQEoKxjrguhuch80CP1d/u3jN4A/FYS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745315309; c=relaxed/simple;
	bh=F/z8c26wHkzHaROXkny7shU6M6OS0DqFGLKEbifOWY8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ER0oXFi7sAijsxy+xvJyNpTJPx31or/udw9ftwN43q+2kbesivHM1SaRvqqM/uCP8XXDe/y3eSLqegc2hRCI14MOldx8BGgk+TivSeipseYKDXsnTbImdjM1LW7+QYk3SXiokr1hgfi8c3HkArJGxHKcOqoCI95zOuc5yhN0zH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Us9FFHOQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 558CBC4CEE9;
	Tue, 22 Apr 2025 09:48:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745315308;
	bh=F/z8c26wHkzHaROXkny7shU6M6OS0DqFGLKEbifOWY8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Us9FFHOQmjkpBlN5cn6xPNP+Qjsi1tmLPi/jlEzyQChYIvmiOaPHdtzBV7eFfWFr/
	 +DMMbfAunIkFbDyqite2Q8uyHo6cE8FPt0jMpG9DpbJ6IM10UbpDqZEKBjqo7S9X05
	 vxvCc35NNem4wJrB3JllSLj+1e8zuYP0vMNQ9KXF8wRqdnkgbUX+9R3GZxzLKjZuWP
	 CRajPI9VHh+OEwC/FCbWOqldTphYl5rRUoBQCXkzx2rqKAr6aJz7haxDh30UpW8Pck
	 lew8DA4NzX6AYIHDkOg+0COZacePRaH183p7oG2KHxN8nc652OLFJJdiWP6aKN448v
	 8j6i8lk80aZkg==
Date: Tue, 22 Apr 2025 11:48:23 +0200
From: Christian Brauner <brauner@kernel.org>
To: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
Cc: Shakeel Butt <shakeel.butt@linux.dev>, 
	Andrew Morton <akpm@linux-foundation.org>, Johannes Weiner <hannes@cmpxchg.org>, 
	Michal Hocko <mhocko@kernel.org>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Muchun Song <muchun.song@linux.dev>, Yosry Ahmed <yosry.ahmed@linux.dev>, Tejun Heo <tj@kernel.org>, 
	Greg Thelen <gthelen@google.com>, linux-mm@kvack.org, cgroups@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Meta kernel team <kernel-team@meta.com>
Subject: Re: [PATCH v2] memcg: introduce non-blocking limit setting option
Message-ID: <20250422-synergie-bauabschnitt-5f724f1d9866@brauner>
References: <20250419183545.1982187-1-shakeel.butt@linux.dev>
 <20250422-daumen-ozonbelastung-93d90ca81dfa@brauner>
 <jqlq7y3bco4r3jpth23ymf7ghrtxbvc2kthvbqjahlkzsl4mik@euvvqaygeafd>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <jqlq7y3bco4r3jpth23ymf7ghrtxbvc2kthvbqjahlkzsl4mik@euvvqaygeafd>

On Tue, Apr 22, 2025 at 11:31:23AM +0200, Michal Koutný wrote:
> On Tue, Apr 22, 2025 at 11:23:17AM +0200, Christian Brauner <brauner@kernel.org> wrote:
> > As written this isn't restricted to admin processes though, no? So any
> > unprivileged container can open that file O_NONBLOCK and avoid
> > synchronous reclaim?
> > 
> > Which might be fine I have no idea but it's something to explicitly
> > point out 
> 
> It occurred to me as well but I think this is fine -- changing the
> limits of a container is (should be) a privileged operation already
> (ensured by file permissions at opening).
> IOW, this doesn't allow bypassing the limits to anyone who couldn't have
> been able to change them already.

Hm, can you explain what you mean by a privileged operation here? If I
have nested containers with user namespaces with delegated cgroup tress,
i.e., chowned to them and then some PID 1 or privileged container
_within the user namespace_ lowers the limit and uses O_NONBLOCK then it
won't trigger synchronous reclaim. Again, this might all be fine I'm
just trying to understand.

