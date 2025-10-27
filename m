Return-Path: <cgroups+bounces-11198-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 50598C0F3E3
	for <lists+cgroups@lfdr.de>; Mon, 27 Oct 2025 17:24:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7D6A4565747
	for <lists+cgroups@lfdr.de>; Mon, 27 Oct 2025 16:07:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 172D730FC24;
	Mon, 27 Oct 2025 16:06:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BtLEgncf"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC0AE30EF84;
	Mon, 27 Oct 2025 16:06:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761581210; cv=none; b=mq/PtHIGd36ePvuqcPz3Yl0EJXMa1pq0REqizw0yV18JQjuAvBisvsFwuNFw4ALf5HBU2nRAOec+FkzcQsHy1Oks68oP28p6HTMSNXvEvZTdg7ELnWqcAfQ1UL5BshK12eQM/nesbvQugmyXWPCehCQCctnWhc5M61axl8jZzZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761581210; c=relaxed/simple;
	bh=lgYGdJqJLSXnsekhf4n7haNtiB25n4IV3mTGIwEdIt0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XBnODvn+VofiHhFXvU31zomc1ZHWEQeCPjzxqktyS7IYy97kx3BIdF0aTL6nqKG2pDIN08mFwDJHCdkZ9M1E4lMUODC8hoAK0V0a8XfMBpKTw1pRKQlo4IWF+I0SVHhz55I87s1tZBMP8Dehmak9MZWaJo0795j+44XvLo+0/4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BtLEgncf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23D84C4CEF1;
	Mon, 27 Oct 2025 16:06:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761581210;
	bh=lgYGdJqJLSXnsekhf4n7haNtiB25n4IV3mTGIwEdIt0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BtLEgncf3+Nx2+/q5LePpZKjn73XUJB/FjnjW8HOPme7rRrIUzbkPoZ9yLit4Xdd6
	 1th/Izvrun+V9r9cyFF2FlcbICtJKaG7RzQ4ySXdiKJ0f+BrpN9c0DmY0cFNsethnt
	 cdyTZ4OMaCzePVC69gtUtKBPD12NlwU2AB/Xoy51tq8Il91BP9lhqFAok/9W2zvVWJ
	 NZ4g22e8RDxsHWMXBgWXmPN6PT9kHcGH9sNxc443NtmfgHkcK5kK/BwM3lywrlVfzC
	 dR1hJ6hqKugOAnPoiTvkuXKy6Xx2ZYi4tCp7OGoNfX+KysZvHF1SvCGQlKhMyvcFdd
	 M1GxuWkiW9oxw==
Date: Mon, 27 Oct 2025 06:06:49 -1000
From: Tejun Heo <tj@kernel.org>
To: jinji zhong <jinji.z.zhong@gmail.com>
Cc: minchan@kernel.org, senozhatsky@chromium.org,
	philipp.reisner@linbit.com, lars.ellenberg@linbit.com,
	christoph.boehmwalder@linbit.com, corbet@lwn.net,
	hannes@cmpxchg.org, mkoutny@suse.com, axboe@kernel.dk,
	mhocko@kernel.org, roman.gushchin@linux.dev, shakeel.butt@linux.dev,
	akpm@linux-foundation.org, terrelln@fb.com, dsterba@suse.com,
	muchun.song@linux.dev, linux-kernel@vger.kernel.org,
	drbd-dev@lists.linbit.com, linux-doc@vger.kernel.org,
	cgroups@vger.kernel.org, linux-block@vger.kernel.org,
	linux-mm@kvack.org, zhongjinji@honor.com, liulu.liu@honor.com,
	feng.han@honor.com
Subject: Re: [RFC PATCH 0/3] Introduce per-cgroup compression priority
Message-ID: <aP-Ymcsoyls04jov@slm.duckdns.org>
References: <cover.1761439133.git.jinji.z.zhong@gmail.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1761439133.git.jinji.z.zhong@gmail.com>

Hello,

On Sun, Oct 26, 2025 at 01:05:07AM +0000, jinji zhong wrote:
> This patch introduces a per-cgroup compression priority mechanism,
> where different compression priorities map to different algorithms.
> This allows administrators to select appropriate compression
> algorithms on a per-cgroup basis.

I don't think it makes sense to tie this to cgroups. Is there something
preventing this from following the process hierarchy?

Thanks.

-- 
tejun

