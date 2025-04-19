Return-Path: <cgroups+bounces-7650-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E171A94157
	for <lists+cgroups@lfdr.de>; Sat, 19 Apr 2025 05:15:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C19DA17E551
	for <lists+cgroups@lfdr.de>; Sat, 19 Apr 2025 03:15:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A48016BFC0;
	Sat, 19 Apr 2025 03:15:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ty61VKBm"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F4B44C85;
	Sat, 19 Apr 2025 03:15:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745032540; cv=none; b=HYWFy4s35wx1KYRB06wkSCYhVNS0Ka+XjL26qKlwf2gb+yuxhLrYF9CozkFbG+yTA8f2CJKt5kSjFfBUR/tpypN90g+FbEbc2/3Ppg5bBH5wQW8JNosO+RqAMihtIeFmW9djRZ5cbUubb2T7XCkGengHKxY4XqiCPut2JdvhBdQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745032540; c=relaxed/simple;
	bh=eazRX1W/kRkdNzPO2tsVgLONNIGKabIR0gdt1JL1p6c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HbemCvplJpkhW26cSD9qCFH2uiQmt4LEylyzgnyjFxuJRibrfX/DV45+jB6EY0ubgRn2cK1IAFfM7JZKjbkwwH17pWPXOFVzzUGrMmv5eWAKic6sf1tnVJ7S/b5GlfSzTZRpD+AT/HzDcEeTxAjChoj2y18NuYspAaBxenLiuMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ty61VKBm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97861C4CEE2;
	Sat, 19 Apr 2025 03:15:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745032539;
	bh=eazRX1W/kRkdNzPO2tsVgLONNIGKabIR0gdt1JL1p6c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ty61VKBmUY0hOYKN4hirm07bCE6Z0Sed5eQBBqaG5lqJCjNdNRgftunrH+Hatl5uK
	 MT+CHN2FSYMUd0BlmOy8U1f3ou5e8Fr+YE1Fc9mzWJt/58fluixn9LjnKR9FoYv9Pe
	 9EcK3OytLDUUWoJu/5NWlZmqACE+FQ82UHOyqY0TR9XerLs13Bl49a2/X4Qk6oy1Bn
	 d9Kmv35DAlltqZQUN0QTL/UHC4VsBZqQ+ImVp5p0L07z8OWzdhFasXWXNZt3/keST9
	 up3Im0LoTkIrYm7H8nYCW/QjuaHezjHrInuFmn5ITRUqyuH6/GhlsuF8bME45GehZG
	 L0w42LApcgciw==
Date: Fri, 18 Apr 2025 17:15:38 -1000
From: Tejun Heo <tj@kernel.org>
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: Roman Gushchin <roman.gushchin@linux.dev>,
	Greg Thelen <gthelen@google.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Michal Hocko <mhocko@kernel.org>,
	Muchun Song <muchun.song@linux.dev>,
	Yosry Ahmed <yosry.ahmed@linux.dev>,
	Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
	linux-mm@kvack.org, cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Meta kernel team <kernel-team@meta.com>
Subject: Re: [PATCH] memcg: introduce non-blocking limit setting interfaces
Message-ID: <aAMVWsFbht3MdMEk@slm.duckdns.org>
References: <20250418195956.64824-1-shakeel.butt@linux.dev>
 <CAHH2K0as=b+EhxG=8yS9T9oP40U2dEtU0NA=wCJSb6ii9_DGaw@mail.gmail.com>
 <ohrgrdyy36us7q3ytjm3pewsnkh3xwrtz4xdixxxa6hbzsj2ki@sn275kch6zkh>
 <aALNIVa3zxl9HFK5@google.com>
 <nmdwfhfdboccgtymfhhcavjqe4pcvkxb3b2p2wfxbfqzybfpue@kgvwkjjagqho>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <nmdwfhfdboccgtymfhhcavjqe4pcvkxb3b2p2wfxbfqzybfpue@kgvwkjjagqho>

On Fri, Apr 18, 2025 at 04:08:42PM -0700, Shakeel Butt wrote:
> Any reasons to prefer one over the other? To me having separate
> files/interfaces seem more clean and are more script friendly. Also
> let's see what others have to say or prefer.

I kinda like O_NONBLOCK. The subtlety level of the interface seems to match
that of the implemented behavior.

Thanks.

-- 
tejun

