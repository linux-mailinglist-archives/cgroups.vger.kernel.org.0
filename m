Return-Path: <cgroups+bounces-3158-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D9A88904527
	for <lists+cgroups@lfdr.de>; Tue, 11 Jun 2024 21:48:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5F4C5286794
	for <lists+cgroups@lfdr.de>; Tue, 11 Jun 2024 19:48:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E05184E18;
	Tue, 11 Jun 2024 19:48:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="oM7EO8gZ"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A8AA1CF90;
	Tue, 11 Jun 2024 19:48:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718135289; cv=none; b=BoD/fWIrXpgyXewzI+JAOZEnVxE8y0zI/N497wUeD48NlnRS67aLAARBloqCzpNq1lMipZeJlHu1g+c1pNxlj0Y+uoLzx9MEa+QFceeUgKRaR3pI0qjTsR1CxkGfeR3aaY7Uh9Cn4BikyNyCURYJMTGt76Bi4bYebHotp0+iL8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718135289; c=relaxed/simple;
	bh=L/YueKASRBrvMS6yV7mI4azJyOMWnw87aZ7Ap4SDt2Q=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=m9Ch+JZ5zXVxSG1kA1VjwUytQjqh23//rv+5Ah8/K1P2GXdjlWYkCs6za8fNBIpC2cwDoR1Q5vh5OBAyB6XRij5q8YFImijKCG3SdefowvV59Xof9VlKV18I2gj+j6MDcCZLnMhO9HhaR0I6ABjFyNJr0ILebJFDIDpuV22Sp7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=oM7EO8gZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3613C2BD10;
	Tue, 11 Jun 2024 19:48:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1718135288;
	bh=L/YueKASRBrvMS6yV7mI4azJyOMWnw87aZ7Ap4SDt2Q=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=oM7EO8gZrBSlYkoPUGcIjb3pkmxNQ45Tyl5aR4Fb1IwymO5Sz5FsvZcQbP5zLwvLg
	 3mpwkj8wZKcRPbUVfJep0qwXijcYb7B+N3Xfa4QNFrn26b2Ij5wM5ctZ+mb/SXnFSU
	 JAi9uCZ8Fd/npHQOr+zuLKcYcPxRp5BgUE8C5i3c=
Date: Tue, 11 Jun 2024 12:48:07 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: Yue Zhao <findns94@gmail.com>, linux-kernel@vger.kernel.org,
 cgroups@vger.kernel.org, linux-mm@kvack.org, Tejun Heo <tj@kernel.org>,
 Zefan Li <lizefan.x@bytedance.com>, Johannes Weiner <hannes@cmpxchg.org>,
 Jonathan Corbet <corbet@lwn.net>, Michal Hocko <mhocko@kernel.org>, Roman
 Gushchin <roman.gushchin@linux.dev>, Shakeel Butt <shakeelb@google.com>,
 Muchun Song <muchun.song@linux.dev>, David Hildenbrand <david@redhat.com>,
 Chris Li <chrisl@kernel.org>, Matthew Wilcox <willy@infradead.org>, Kefeng
 Wang <wangkefeng.wang@huawei.com>, Yosry Ahmed <yosryahmed@google.com>,
 Hugh Dickins <hughd@google.com>, Dan Schatzberg <schatzberg.dan@gmail.com>,
 Yu Zhao <yuzhao@google.com>
Subject: Re: [PATCH v6 0/2] Add swappiness argument to memory.reclaim
Message-Id: <20240611124807.aedaa473507150bd65e63426@linux-foundation.org>
In-Reply-To: <htpurelstaqpswf5nkhtttm3vtbvga7qazs2estwzf2srmg65x@banbo2c5ewzw>
References: <20240103164841.2800183-1-schatzberg.dan@gmail.com>
	<htpurelstaqpswf5nkhtttm3vtbvga7qazs2estwzf2srmg65x@banbo2c5ewzw>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 11 Jun 2024 12:25:24 -0700 Shakeel Butt <shakeel.butt@linux.dev> wrote:

> Hi folks,
> 
> This series has been in the mm-unstable for several months. Are there
> any remaining concerns here otherwise can we please put this in the
> mm-stable branch to be merged in the next Linux release?

The review didn't go terribly well so I parked the series awaiting more
clarity.  Although on rereading, it seems that Yu Zhao isn't seeing any
blocking issues?


