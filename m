Return-Path: <cgroups+bounces-11975-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 17BDEC5F51C
	for <lists+cgroups@lfdr.de>; Fri, 14 Nov 2025 22:11:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id B3F3235C920
	for <lists+cgroups@lfdr.de>; Fri, 14 Nov 2025 21:11:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 661B22FDC3F;
	Fri, 14 Nov 2025 21:11:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O33RyYWG"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CBCD1E1A3D;
	Fri, 14 Nov 2025 21:11:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763154688; cv=none; b=tSfrglwXe+Bgzc9dd8p+uj+oUSRndajt+fu266wYCZZzHCksj+7kPsx8Q+2NtwDc/GVcDnH+K3c4qfRGeeisgLY/zqxFYugIAhh3/ad86UcHPtAq0L9LwCG9WHsY6/tUAFwLOd+RmNz6ruPWX1LxhrSr+oSCq3+O7LWZ6Rwl3Zw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763154688; c=relaxed/simple;
	bh=7AUZ2qMbVGNlnVWU3OOoHOhP0pZer04KISPztcjt8S8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cpwBdxHNtVYE8BO9Rh87cTKu/vH/e9y98OfSLf0Lmiq9LVlbs/5o5fTBk5n9Nq7lO/EfH3bPQJ6g9cyIWuMfc0iYXsgr6/CSi/8LX9ZXzR/d7+7pc3H8TgC5fwwCrMGHubTSu7LVC60Gv3wRPzEoh2ghR3V4D3IC2FtkVAHMBSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O33RyYWG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D278C113D0;
	Fri, 14 Nov 2025 21:11:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763154687;
	bh=7AUZ2qMbVGNlnVWU3OOoHOhP0pZer04KISPztcjt8S8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=O33RyYWGKXDohGHEJtAM2maj1QXbHB4Ea5eUROXVCjkKaeEGVJF/iNkF5dwPlNOLt
	 DGnJK4huxQkkXl9X1AtHTnYawU9Yh1eY0U7GOG4qYFKNuJZHQ8QSC0RIL1L7MoEsys
	 88WhhDwxqeG7dqu6tecHnFUxnwneGCbN4XjZ//zE4PGErZNiff75FnsTqy3sx6cSZa
	 f5LsRplwNhr35umWBS7QH1Lv7y8pAZvDjumyxhcGDcXcZqP3Srp3UPjKTWdV7S+WtP
	 x2XiJYMqIUjiy8hVnravF1Ik3N4s2C0Kwt4Fy/ilEoEKucZVheSL+QUlS73LGC7r+C
	 hP9BVs+JS1+MQ==
Date: Fri, 14 Nov 2025 11:11:26 -1000
From: Tejun Heo <tj@kernel.org>
To: Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>
Cc: Jonathan Corbet <corbet@lwn.net>, cgroups@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	Natalie Vock <natalie.vock@gmx.de>,
	Maarten Lankhorst <dev@lankhorst.se>,
	Johannes Weiner <hannes@cmpxchg.org>
Subject: Re: [PATCH RESEND 1/3] docs: cgroup: Explain reclaim protection
 target
Message-ID: <aRea_mDhhsUn24K-@slm.duckdns.org>
References: <20251110193638.623208-1-mkoutny@suse.com>
 <20251110193638.623208-2-mkoutny@suse.com>
 <87wm3xwtcm.fsf@trenco.lwn.net>
 <qhywsiwlbrpe4el3pcprtnpwdyifmfxesmsdgxuze6ho3d4wqe@mweffv3yoxlt>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <qhywsiwlbrpe4el3pcprtnpwdyifmfxesmsdgxuze6ho3d4wqe@mweffv3yoxlt>

On Fri, Nov 14, 2025 at 07:29:28PM +0100, Michal Koutný wrote:
> On Mon, Nov 10, 2025 at 01:00:41PM -0700, Jonathan Corbet <corbet@lwn.net> wrote:
> > > @@ -53,7 +53,8 @@ v1 is available under :ref:`Documentation/admin-guide/cgroup-v1/index.rst <cgrou
> > >       5-2. Memory
> > >         5-2-1. Memory Interface Files
> > >         5-2-2. Usage Guidelines
> > > -       5-2-3. Memory Ownership
> > > +       5-2-3. Reclaim Protection
> > > +       5-2-4. Memory Ownership
> > 
> > I always have to ask...do we really need the manually maintained TOC
> > here? 
> 
> Tejun [1] (and maybe some others) like it.

I'm not married to it but I think a lot of people including me just read the
source docs without ever formatting them. It is kinda nice to have ToC for
them. Maybe section numbers are too error-prone, I don't know.

Thanks.

-- 
tejun

