Return-Path: <cgroups+bounces-5948-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C29989F5605
	for <lists+cgroups@lfdr.de>; Tue, 17 Dec 2024 19:23:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0D85316E41C
	for <lists+cgroups@lfdr.de>; Tue, 17 Dec 2024 18:23:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECE1C1F8903;
	Tue, 17 Dec 2024 18:23:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Zg0NbAka"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA7868F5A;
	Tue, 17 Dec 2024 18:23:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734459820; cv=none; b=mHifmSkTO8/UFN71/GJjwIu2tQ5VN1zTh6q3CEFTFFH2HUTnvSH/1iONyMDL+Z8sZDfXAi9fxeK604X0ftcCU+E2nFWMUEkNFyrQU27UUhKTAFK00IZRe6Ie95d7fWuS0KRwQEUGaIRKenxiW4/u9S3uOGHNnkMkbj5BRAdMdC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734459820; c=relaxed/simple;
	bh=seqaTS+B/Yvq2Zz8QYWQ8AUjQjPku14beCw+oXyf0fQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qLkOHbVyrXImm1qh3mSoXKZQRtHNvEEzdKYPkzPgPRk8k3y7IvupSeZpMCVdi0rV8pyZ6ZOWUfgWVZFt1x/6j0Kot+ntjN8ze0ROAj5LE5SLSRP5R920B/6618eG4CaPPVtKqIf3eDGvMl502rwpJWQcQ+lXC+6JDbn+ld+asHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Zg0NbAka; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34677C4CED7;
	Tue, 17 Dec 2024 18:23:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734459820;
	bh=seqaTS+B/Yvq2Zz8QYWQ8AUjQjPku14beCw+oXyf0fQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Zg0NbAkaqSVYJo0rwXVva0ubr0lourBVfpN5/mBCzcihaP16z1+uAcYh0LbyDrFln
	 Md/oP7CkhdJFp9WbOVo7eM0G+lPytUIGF67xhK4SNsEF9UWj9KbIHZ/hICcv1kJGt2
	 UhUD7hSPeexLUVUQHJsdc5Qx8rsltHK7GeTh6E2Je+ij7y4wez6HezL5SY5IG2jCtn
	 HcQiup0NgN1nFtJ2rmvf4J2FC2PPQTUA6t//MU8lheUmDfnP87YHeoWcqrB/eIFNbd
	 z5DML9mKi6cVhMQnNPv11p80I0hzzNFKnWXFcUlYO9Ao3B/Eud7NCn823itluC6I+s
	 T+7VvSo4+2IRQ==
Date: Tue, 17 Dec 2024 08:23:38 -1000
From: Tejun Heo <tj@kernel.org>
To: Maarten Lankhorst <dev@lankhorst.se>
Cc: Maxime Ripard <mripard@kernel.org>, linux-kernel@vger.kernel.org,
	intel-xe@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
	Zefan Li <lizefan.x@bytedance.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Friedrich Vock <friedrich.vock@gmx.de>, cgroups@vger.kernel.org,
	linux-mm@kvack.org,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Subject: Re: [PATCH v2 0/7] kernel/cgroups: Add "dmem" memory accounting
 cgroup.
Message-ID: <Z2HBqtKDSTkd1lST@slm.duckdns.org>
References: <20241204134410.1161769-1-dev@lankhorst.se>
 <20241213-proud-kind-uakari-df3a70@houat>
 <80c49a80-d49c-4ca5-9568-9f7950618275@lankhorst.se>
 <20241213-gentle-glittering-salamander-22addf@houat>
 <5a50a992-9286-4179-8031-ffb514bca34f@lankhorst.se>
 <20241217-meek-bullfinch-of-luck-2c3468@houat>
 <a69a3500-be17-4899-bdb9-c6a63bf8dc81@lankhorst.se>
 <Z2GwpOQDVshpv-ml@slm.duckdns.org>
 <c0a539e7-0f1b-496a-9848-73a7ada66bfb@lankhorst.se>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c0a539e7-0f1b-496a-9848-73a7ada66bfb@lankhorst.se>

Hello,

On Tue, Dec 17, 2024 at 06:37:22PM +0100, Maarten Lankhorst wrote:
> Den 2024-12-17 kl. 18:11, skrev Tejun Heo:
> > On Tue, Dec 17, 2024 at 03:28:50PM +0100, Maarten Lankhorst wrote:
> > > Now that all patches look good, what is needed to merge the series? Without
> > > patch 6/7 as it is a hack for testing.
> > 
> > There were some questions raised about device naming. One thing we want to
> > get right from the beginning is the basic interface.
> > 
> > Thanks.
> > 
> I believe it was solved. The conclusion appears to be that we go with how we
> defined it in this series. drm/$pciid/$regionname. With the only regions
> defined now being VRAM. Main memory will be a followup, but requires some
> discussions on hwo to be prevent double accounting, and what to do with the
> limited amount of mappable memory.

Provided Johannes is okay with the series, how do you want to route the
series? If you want to route it through drm, that's fine by me and please
feel free to add:

 Acked-by: Tejun Heo <tj@kernel.org>

Thanks.

-- 
tejun

