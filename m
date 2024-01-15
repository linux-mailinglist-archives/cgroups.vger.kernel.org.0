Return-Path: <cgroups+bounces-1147-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2767282D4DA
	for <lists+cgroups@lfdr.de>; Mon, 15 Jan 2024 09:04:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A3E7DB209A3
	for <lists+cgroups@lfdr.de>; Mon, 15 Jan 2024 08:04:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57AC86FA6;
	Mon, 15 Jan 2024 08:04:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="WiQxGCzN"
X-Original-To: cgroups@vger.kernel.org
Received: from out-180.mta0.migadu.com (out-180.mta0.migadu.com [91.218.175.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38B9C6FA1
	for <cgroups@vger.kernel.org>; Mon, 15 Jan 2024 08:04:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Content-Type: text/plain;
	charset=us-ascii
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1705305840;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QnJRRtZ/PoGush4Hndog/3Wt84Ao78Pcw/n6BWyMsIs=;
	b=WiQxGCzNTnwiRRS0lE3uNApwhnUUEU7+3sftcj2K80ZCBKpdE+PNWajDtkKP3ldsUQokgS
	PlDC8afOFTqqF6v0fFmgoj3igMeQwB8VFmF+Fi0d3JYw/pgqg1aPQjIR1F/lpGwU9aqC1r
	1NopgrQt1PetzjAK4pxymB6usIC1GUo=
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Subject: Re: [PATCH 1/4] memcg: Convert mem_cgroup_move_charge_pte_range() to
 use a folio
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Muchun Song <muchun.song@linux.dev>
In-Reply-To: <20240111181219.3462852-2-willy@infradead.org>
Date: Mon, 15 Jan 2024 16:03:22 +0800
Cc: Andrew Morton <akpm@linux-foundation.org>,
 Johannes Weiner <hannes@cmpxchg.org>,
 Michal Hocko <mhocko@kernel.org>,
 Roman Gushchin <roman.gushchin@linux.dev>,
 Shakeel Butt <shakeelb@google.com>,
 cgroups@vger.kernel.org,
 Linux-MM <linux-mm@kvack.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <07B48A08-BFCC-4FD1-BAE9-3C6F1B4B9755@linux.dev>
References: <20240111181219.3462852-1-willy@infradead.org>
 <20240111181219.3462852-2-willy@infradead.org>
To: "Matthew Wilcox (Oracle)" <willy@infradead.org>
X-Migadu-Flow: FLOW_OUT



> On Jan 12, 2024, at 02:12, Matthew Wilcox (Oracle) =
<willy@infradead.org> wrote:
>=20
> Remove many calls to compound_head() by calling page_folio() once at
> the start of each stanza which receives a struct page from 'target'.
> There should be no change in behaviour here as all the called =
functions
> start out by converting the page to its folio.
>=20
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>

Reviewed-by: Muchun Song <muchun.song@linux.dev>

Thanks.


