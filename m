Return-Path: <cgroups+bounces-4830-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CB0597442C
	for <lists+cgroups@lfdr.de>; Tue, 10 Sep 2024 22:41:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CF4371C21839
	for <lists+cgroups@lfdr.de>; Tue, 10 Sep 2024 20:41:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25A6A1A76CB;
	Tue, 10 Sep 2024 20:40:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uh394ID6"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5D321A7074;
	Tue, 10 Sep 2024 20:40:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726000847; cv=none; b=WEZymri2mvBeI5TQcNFVHHSfuq9mNJ9p0M2zfh6Dz6keRt39+N8ZDrO0OIjjWlxI55inlH7F7StQUoZT9i3DOzIjdfv3Sb7uN5uLRgw36HtYy/8OURmLPhO3uXCTfQ2RIOkOQbu9P7GcbJPk9nuPyqq6vE81KRINqi1q/B3GlDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726000847; c=relaxed/simple;
	bh=IV+E/Nab4aUEnTT5sV8auZs9usgjz9R4Smx4eJ8YIxU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AUrb66zFTQGnJam0bUs+pVt2WjhzktS45nxBrkH58wvTIHl9oquhkv1hRC2JIXJ4i6ZALqngN/3v5VhNfhcpkz85TrAQTlevgun9bDaP3z1p2PveGAsUs5B7eK7fbeTFCY6vG0vMEv2Eyyr2dqVHzGjS2V8+1cmV9XC1T9Ap5wA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uh394ID6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 392C2C4CEC3;
	Tue, 10 Sep 2024 20:40:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726000847;
	bh=IV+E/Nab4aUEnTT5sV8auZs9usgjz9R4Smx4eJ8YIxU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uh394ID6AyTHCEER2cldwJG3XQligGj0xFT1q/gUAQJF41TjdwaGAwC6MmtJLlA1X
	 yJ+hFST9+u8e5BOKzPaG6M2EUF55lzXciR8PQEN8gj8ZmoMSpuvevg3B8dFgbWblgs
	 6T0z5pnvn5Z3DDZ09B1k+LdsP4yundereO7dNBK8u9DwEFiX4XnFyIgYMBAbx7bDXD
	 AGM6MflVkWxbuHeRbugG7E6L6korebN0FAlVaAM/a+wElJAEZ25XugajpYtK0YTrMj
	 Qai7kWemnBUOFUZLv+DWDv8fT0jwPgBglaCY4iZIeHliL3+cXsR1mOc44MMX/mgIdw
	 CuDlLzlguItuQ==
Date: Tue, 10 Sep 2024 10:40:46 -1000
From: Tejun Heo <tj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
	cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, Zefan Li <lizefan.x@bytedance.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Michal Hocko <mhocko@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Muchun Song <muchun.song@linux.dev>,
	Chen Ridong <chenridong@huawei.com>
Subject: Re: [PATCH 1/4] memcg: Cleanup with !CONFIG_MEMCG_V1
Message-ID: <ZuCuzmLh94r4hj7x@slm.duckdns.org>
References: <20240909163223.3693529-1-mkoutny@suse.com>
 <20240909163223.3693529-2-mkoutny@suse.com>
 <ZuCmpW2JFFAxmGvS@slm.duckdns.org>
 <20240910131900.65e40be84b7f70261c62e154@linux-foundation.org>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240910131900.65e40be84b7f70261c62e154@linux-foundation.org>

On Tue, Sep 10, 2024 at 01:19:00PM -0700, Andrew Morton wrote:
> On Tue, 10 Sep 2024 10:05:57 -1000 Tejun Heo <tj@kernel.org> wrote:
> 
> > On Mon, Sep 09, 2024 at 06:32:20PM +0200, Michal Koutný wrote:
> > > Extern declarations have no definitions with !CONFIG_MEMCG_V1 and no
> > > users, drop them altogether.
> > > 
> > > Signed-off-by: Michal Koutný <mkoutny@suse.com>
> > 
> > Acked-by: Tejun Heo <tj@kernel.org>
> > 
> > This one should go through -mm. If Andrew doesn't pick it up from this
> > thread, it might be better to repost it.
> > 
> 
> Yep, thanks, I grabbed all four patches.

Oh, I applied the latter three to the cgroup tree. Should be easy to figure
out later.

Thanks.

-- 
tejun

