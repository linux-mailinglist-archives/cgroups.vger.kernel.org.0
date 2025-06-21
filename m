Return-Path: <cgroups+bounces-8621-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D96B6AE2724
	for <lists+cgroups@lfdr.de>; Sat, 21 Jun 2025 04:52:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 281081897AE0
	for <lists+cgroups@lfdr.de>; Sat, 21 Jun 2025 02:52:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99D814F5E0;
	Sat, 21 Jun 2025 02:52:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dpXz8PpZ"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53C1710E5;
	Sat, 21 Jun 2025 02:52:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750474325; cv=none; b=Ws6AtcLQ0OAeI86+xq6mnDtoUcU85EVaZsLvj2FHaXDHkA65hMpvs5GR935F9hDvYEHx+KQ8C3lW7rizW3xV6UrmAmWGxniJkjG7k5/53X8tVF02se5Fm5FAQGJoEzjhNNp9f8V4/5ySStWanIRDJkI5BOTv+oHNPD3XMBKL+IU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750474325; c=relaxed/simple;
	bh=rigipJFO4fTCXBuzkJ4bZAdNssvi68SvkL7+nqkrGYA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c3IRdTTnmlASSVMw0C/jpJpPjXzFVeeNTINAiR8LouvFzqOVdIwezwXWADHCZO6EjxD8YqncJaaC0OB8s0eZGHVIznq7cr+nJ4Bwh49owEBPjSz6vgECY7/bKJXmzRgKIg1e/sQPd2eWk0MKJxSAQMlFm4R3/KJHKncB+XJzpQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dpXz8PpZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC1B1C4CEE3;
	Sat, 21 Jun 2025 02:52:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750474324;
	bh=rigipJFO4fTCXBuzkJ4bZAdNssvi68SvkL7+nqkrGYA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dpXz8PpZbh7UT4t/RXlTufAV83FiacKUYs++r4l4eHj7R7x8v38Q+5NsG+cgDWBV1
	 4UPhmrN2/0RfDhqoBtm7JyeObOPDYF6vvQPZQfp1/MEbOj/1vZQDxe0Ay0oIAGN/TW
	 WZO/uRmCJWm+qVVhwmI6018QhDFya/betV8u7fWlpfgk4zxKG2SBaJaNFYkQlyKia1
	 EMuzRnBviyy8O5dpGLXtB4owz5Yuv0L/a9gtm46MDFmfmSZOMa7PjV9o/Bion4Kvkf
	 Pvi8OSNJBF0wcXkK49prbDFU49Bq/y8nIxOMcwGWem1pHYNqyDiW030eF0c8uw16oJ
	 aYnIUt22i0t6A==
Date: Fri, 20 Jun 2025 16:52:03 -1000
From: Tejun Heo <tj@kernel.org>
To: Jemmy Wong <jemmywong512@gmail.com>
Cc: Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>, hannes@cmpxchg.org,
	Waiman Long <longman@redhat.com>, cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 0/3] cgroup: Add lock guard support
Message-ID: <aFYeU_dL0VOvyeYs@slm.duckdns.org>
References: <20250606161841.44354-1-jemmywong512@gmail.com>
 <2dd7rwkxuirjqpxzdvplt26vgfydomu56j3dkmr37765zk67pd@aou7jw4d6wtq>
 <9BDD726A-2EAE-46C3-9D00-004E051B8F5B@gmail.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9BDD726A-2EAE-46C3-9D00-004E051B8F5B@gmail.com>

On Fri, Jun 20, 2025 at 06:45:54PM +0800, Jemmy Wong wrote:
...
> > Tejun:
> >> There are no practical benefits to converting the code base at this point.
> > 
> > I'd expect future backports (into such code) to be more robust wrt
> > pairing errors.
> > At the same time this is also my biggest concern about this change, the
> > wide-spread diff would make current backporting more difficult.  (But
> > I'd counter argue that one should think forward here.)

Well, I'm not necessarily against it but I generally dislike wholesale
cleanups which create big patch application boundaries. If there are enough
practical benefits, sure, we should do it, but when it's things like this -
maybe possibly it's a bit better in the long term - the calculus isn't clear
cut. People can argue these things to high heavens on abstract grounds, but
if you break it down to practical gains vs. costs, it's not a huge
difference.

But, again, I'm not against it. Johannes, any second thoughts?

Thanks.

-- 
tejun

