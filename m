Return-Path: <cgroups+bounces-8328-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 101ABAC27EF
	for <lists+cgroups@lfdr.de>; Fri, 23 May 2025 18:51:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 39B707A55E8
	for <lists+cgroups@lfdr.de>; Fri, 23 May 2025 16:50:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF9A4296FDF;
	Fri, 23 May 2025 16:51:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZLLoq8gl"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 899C3296FCA;
	Fri, 23 May 2025 16:51:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748019107; cv=none; b=CUbOZ6TjBR+qGStd9KpDaZI1L0LUtFhOXGnY4Mbt7NsGtObmQl218qY4XPHbIGYwFgRtXcOdzIKEeY5zM9bCdXu5vffxf6TT656pPDsqEyWP1HUhbr111HLXGoefK9QGCEVWdKoYPh1F1MiDs2VNgTb8iUzBIWNopqwA+BZ8UCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748019107; c=relaxed/simple;
	bh=Wh0XqPUu+Lz68HLgF4GQPjuZRkkZz7XwGHcAlknA1F0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mam6klp0rymLOAO5ur6JTZ4/JCKSSGs1+MoXqmO60yJYGtfcb6X/SrOeVlBauN78ULxpSPDkg6ugNDxAB89gpUAAlW98PQoN6MYwSyHhCyR4oaezobNmYBhDk7j3k3r9Rah3Ro38hpfZlpPdh7hUABiVEWaxNoILXTytyjVWVY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZLLoq8gl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B2FCC4CEE9;
	Fri, 23 May 2025 16:51:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748019107;
	bh=Wh0XqPUu+Lz68HLgF4GQPjuZRkkZz7XwGHcAlknA1F0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZLLoq8glu63ddQX8GfGQABKc1/sthdqvrLqG/2Wkri12PhSEzJnLwlGfz7fP4w31w
	 cUS+VWCZsAtBU0AJ75DUXEUbtk6gOl9tWVZQQCLh0ovP5hYwL9yQ1KrZzJpnDrTPMo
	 04L0fVKSRJCi1kSFCr/JRzxu3VJTaH8dAgjO1+ZrB6Uj1ufjA3VABC9oFxtXtLG0/N
	 HG9GS07dMcXmIX9TBCrkldXiwzMGbXTZ3/SjDmX22KMDqrg5YK4P4ta2PflRafrJj0
	 mnffnxTljFDxgLZ55H+w4b9sIPoC93PCNYnIQskRd16BaJ0I/Yx8I20j6Bb81kSFJV
	 EK/rSBRZ6m2qg==
Date: Fri, 23 May 2025 06:51:41 -1000
From: Tejun Heo <tj@kernel.org>
To: Zhongkun He <hezhongkun.hzk@bytedance.com>
Cc: Waiman Long <llong@redhat.com>, hannes@cmpxchg.org,
	cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
	muchun.song@linux.dev
Subject: Re: [External] Re: [PATCH] cpuset: introduce non-blocking
 cpuset.mems setting option
Message-ID: <aDCnnd46qjAvoxZq@slm.duckdns.org>
References: <20250520031552.1931598-1-hezhongkun.hzk@bytedance.com>
 <8029d719-9dc2-4c7d-af71-4f6ae99fe256@redhat.com>
 <CACSyD1Mmt54dVRiBibcGsum_rRV=_SwP=dxioAxq=EDmPRnY2Q@mail.gmail.com>
 <aC4J9HDo2LKXYG6l@slm.duckdns.org>
 <CACSyD1MvwPT7i5_PnEp32seeb7X_svdCeFtN6neJ0=QPY1hDsw@mail.gmail.com>
 <aC90-jGtD_tJiP5K@slm.duckdns.org>
 <CACSyD1P+wuSP2jhMsLHBAXDxGoBkWzK54S5BRzh63yby4g0OHw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACSyD1P+wuSP2jhMsLHBAXDxGoBkWzK54S5BRzh63yby4g0OHw@mail.gmail.com>

Hello,

On Fri, May 23, 2025 at 11:35:57PM +0800, Zhongkun He wrote:
> > Is this something you want on the whole machine? If so, would global cgroup
> > mount option work?
> 
> It doesn't apply to the whole machine. It is only relevant to the pod with
> huge pages, where the service will be unavailable for over ten seconds if
> modify the cpuset.mems. Therefore, it would be ideal if there were an
> option to disable the migration for this special case.

I suppose we can add back an interface similar to cgroup1 but can you detail
the use case a bit? If you relocate threads without relocating memory, you'd
be paying on-going cost for memory access. It'd be great if you can
elaborate why such mode of operation is desirable.

Thanks.

-- 
tejun

