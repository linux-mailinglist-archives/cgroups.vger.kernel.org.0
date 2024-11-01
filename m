Return-Path: <cgroups+bounces-5385-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 65E219B991B
	for <lists+cgroups@lfdr.de>; Fri,  1 Nov 2024 21:02:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1CDF21F2225B
	for <lists+cgroups@lfdr.de>; Fri,  1 Nov 2024 20:02:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28EDF1CEE9D;
	Fri,  1 Nov 2024 20:02:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="ZwetropD"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADDE0168DA;
	Fri,  1 Nov 2024 20:02:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730491370; cv=none; b=U1VlrF5dM/huJYiJJ4edFIQPJiGBwQHnzaUPq1rCsW5d/pCm1EMm2pMIIm194aQUyVVWc22S1cDNjTbEEP4RWu00Sg/cCuVwR2GqFeBQvM0HxyBL4AmPMnN3xXmOrxJhCYT3llh4mbC2YayLTAyX8XFu/25iZsm5aMgC0C936iU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730491370; c=relaxed/simple;
	bh=f3nsllbCQdhYtJ0TOpk5TkpNqh6JamHPbpnqCkZMV3A=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=dV4LliR4z52Kzs4r02/52i98yy6g2/5Q0C90kIP2oqral1hPgz9+S0BftjYHldElj9cubuxxB6BBoOhoLh2/gvlrRoFcOAJuyvideGuu6lDRdO0LT7ymdixlUYnF5kyc2DAiZsVKgsq6EulAxs/MQxw4dH4AfSqOXae6r7AXGkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=ZwetropD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC1F8C4CECD;
	Fri,  1 Nov 2024 20:02:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1730491370;
	bh=f3nsllbCQdhYtJ0TOpk5TkpNqh6JamHPbpnqCkZMV3A=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ZwetropDKQEu/NJU4bfSC09XFs6ym0AuwfPTWaXT9NWadUD19fcqSOk5zgDkABm8F
	 6YxRAJgEzt+oJ/FIJYTYqdDO+Gg7ep9PEYBr4aAoFCvC+vXFvekcvisxI1MnuXIpcb
	 ZItApmFJ3Yk+4j4EyA51KnMHhM/exKLZ2aFsQaTU=
Date: Fri, 1 Nov 2024 13:02:49 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Joshua Hahn <joshua.hahnjy@gmail.com>
Cc: Michal Hocko <mhocko@suse.com>, Johannes Weiner <hannes@cmpxchg.org>,
 nphamcs@gmail.com, shakeel.butt@linux.dev, roman.gushchin@linux.dev,
 muchun.song@linux.dev, tj@kernel.org, lizefan.x@bytedance.com,
 mkoutny@suse.com, corbet@lwn.net, lnyng@meta.com, cgroups@vger.kernel.org,
 linux-mm@kvack.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, kernel-team@meta.com
Subject: Re: [PATCH v3 1/1] memcg/hugetlb: Adding hugeTLB counters to memcg
Message-Id: <20241101130249.c065324ab9927ac3a61ffcb0@linux-foundation.org>
In-Reply-To: <CAN+CAwORE8+P7Td9yebkb0TVT92SZv8oasrypewCspf5om1fYQ@mail.gmail.com>
References: <20241028210505.1950884-1-joshua.hahnjy@gmail.com>
	<ZyIZ_Sq9D_v5v43l@tiehlicka>
	<20241030150102.GA706616@cmpxchg.org>
	<ZyJQaXAZSMKkFVQ2@tiehlicka>
	<20241030183044.GA706387@cmpxchg.org>
	<CAN+CAwM1FJCaGrdBMarD2YthX8jcBEKx9Sd07yj-ZcpDxinURQ@mail.gmail.com>
	<ZyM7_i1HFnFfUmIR@tiehlicka>
	<CAN+CAwMioguv6itTSYVUO9__kQVv6HZO2-i0NWt10-x7f6JVSQ@mail.gmail.com>
	<20241031183413.bb0bc34e8354cc14cdfc3c29@linux-foundation.org>
	<CAN+CAwORE8+P7Td9yebkb0TVT92SZv8oasrypewCspf5om1fYQ@mail.gmail.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 1 Nov 2024 14:33:36 -0400 Joshua Hahn <joshua.hahnjy@gmail.com> wrote:

> Thank you for your help as always. I apologize for not being clear in my
> original request -- the "With this said, there are 2 problems:" paragraph is
> part of the 2nd section (2. We already have a hugeTLB controller...) So the
> outline will be:

I think it would be best if you were to send a new version of the patch :)

And while there, please make the title "memcg/hugetlb: Add ...".

