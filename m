Return-Path: <cgroups+bounces-943-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D3719811951
	for <lists+cgroups@lfdr.de>; Wed, 13 Dec 2023 17:27:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4124B281618
	for <lists+cgroups@lfdr.de>; Wed, 13 Dec 2023 16:27:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52B1C33CFE;
	Wed, 13 Dec 2023 16:27:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="qnOv5Qv3"
X-Original-To: cgroups@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D238B9
	for <cgroups@vger.kernel.org>; Wed, 13 Dec 2023 08:27:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=Us7YTN6WMg1UsHkPpL8fh2VaKDzONXOhFAqiscEUm28=; b=qnOv5Qv3PAnpQs4tDaviiVpKUd
	91cZhJzNtcgCwhpE/7MDv9V8tb0GAJ+/usEJbK4zAMOQV36ZnrtS2Jo/MH2DI0lAQx7hp28lunp3N
	AbuIx0v3mvEJLXBHfChNhI0ppeaGjjwMJbZKk3JcwrXZgNaz7nbrycJLIltGW8RF9ERbJ8GAHywPd
	O7S5YyX4d0WyQIlAY8qmkhzrTl0azgLTAEBd533yvtjK7act3OtA90QoN3Woh8IvTgauG6k0HjLep
	9MXZs964JzkVakpJO/eXyEKr5NZ7tbx4Td+xbUGJHs8OXQoeB2e1u8kejbwutt/jNPNEqKdRT4qDM
	l/5E50Dg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
	id 1rDS4s-002Bed-2R; Wed, 13 Dec 2023 16:27:18 +0000
Date: Wed, 13 Dec 2023 16:27:18 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Yosry Ahmed <yosryahmed@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Michal Hocko <mhocko@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Shakeel Butt <shakeelb@google.com>,
	Muchun Song <muchun.song@linux.dev>, cgroups@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: [PATCH] mm: memcg: remove direct use of
 __memcg_kmem_uncharge_page
Message-ID: <ZXnbZlrOmrapIpb4@casper.infradead.org>
References: <20231213130414.353244-1-yosryahmed@google.com>
 <ZXnHSPuaVW913iVZ@casper.infradead.org>
 <CAJD7tkbuyyGNjhLcZfzBYBX+BSUCvBbMpUPyzgHcRPTM4jL9Gg@mail.gmail.com>
 <ZXnQCaficsZC2bN4@casper.infradead.org>
 <CAJD7tkY8xxfYFuP=4vFm7A+p7LqUEzdcFdPjhogccGPTjqsSKg@mail.gmail.com>
 <ZXnabMOjwASD+RO9@casper.infradead.org>
 <CAJD7tkaUGw9mo88xSiTNhVC6EKkzvaJOh=nOwY6WYcG+skQynQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJD7tkaUGw9mo88xSiTNhVC6EKkzvaJOh=nOwY6WYcG+skQynQ@mail.gmail.com>

On Wed, Dec 13, 2023 at 08:24:04AM -0800, Yosry Ahmed wrote:
> I doubt an extra compound_head() will matter in that path, but if you
> feel strongly about it that's okay. It's a nice cleanup that's all.

i don't even understand why you think it's a nice cleanup.

