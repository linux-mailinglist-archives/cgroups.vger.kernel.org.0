Return-Path: <cgroups+bounces-8541-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E932ADB897
	for <lists+cgroups@lfdr.de>; Mon, 16 Jun 2025 20:15:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 53F5B3ADB10
	for <lists+cgroups@lfdr.de>; Mon, 16 Jun 2025 18:15:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCF23217F56;
	Mon, 16 Jun 2025 18:15:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OP2hkkbH"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ECB31922D3;
	Mon, 16 Jun 2025 18:15:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750097719; cv=none; b=X/LB5oRGODkdeBMI3NX2tpwfMCQPz6MTwufsbCqkU534cwFI9ba+lK8Fjc5fujmTHRXdSTMsfLPYVoClqtk5D5X4ld+eypoWk6BoDQL0032YZokhalDF6c99v3O0aftq5Yg9PIou9YI2A9hzmsiwOrFbpc1qyOKHFfLl/QXTT10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750097719; c=relaxed/simple;
	bh=yA7nQY6EB3++WTiYEV3GhWn+708ii7DZS9WFb6/7CHU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G83sY7LcVscC5thGD52wVi4Y8H1d5TE3Mp7ndcWDscNGKh28nOq8tMMv9dknXYCAYTxeB44uN7DwqMtIwGQZ4hTf9R6wd3fv2kI7bUZHOr34QYp/6hTLXWMcHkmDY8fPyIbpwMd1H3TzWZQKngYUe70B8Tdntwl+YUjUsVQOEoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OP2hkkbH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF5CAC4CEF1;
	Mon, 16 Jun 2025 18:15:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750097718;
	bh=yA7nQY6EB3++WTiYEV3GhWn+708ii7DZS9WFb6/7CHU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OP2hkkbH8ofhfta0N/V3Cd6gPLQX7bBJtzWLbXa6/z12V/OKP+hrdGdyL0OVh0Bbl
	 0iDhqKqww7fOB6i6ybbv+R5ZKx9TJJP6OB8xVO5ip9SWlDfpSCZ6v05dTYyUqFVC4y
	 DoQJPoCn2xAGql4W/aDC/vktQtbm1DGDz0d0ne6yb2t8aHNiafPQYhDUeNL9txbsGV
	 /SsUF9NiZAxMU1PuUiURQe6QrO02J1GurlZf43Aez1IZIfF0gtIWiuhWjHnb1+9Qj4
	 0OJwVkYDi6MLVY6YM2w68jS9SEtKuOLI45uaml0aH/bovsFIU2bzu69YuAphARxJFR
	 NpwhVu6tJBUpw==
Date: Mon, 16 Jun 2025 08:15:17 -1000
From: Tejun Heo <tj@kernel.org>
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	JP Kobryn <inwardvessel@gmail.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Michal Hocko <mhocko@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Muchun Song <muchun.song@linux.dev>,
	Vlastimil Babka <vbabka@suse.cz>,
	Alexei Starovoitov <ast@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
	Harry Yoo <harry.yoo@oracle.com>,
	Yosry Ahmed <yosry.ahmed@linux.dev>, bpf@vger.kernel.org,
	linux-mm@kvack.org, cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Meta kernel team <kernel-team@meta.com>
Subject: Re: [PATCH v2 0/4] cgroup: nmi safe css_rstat_updated
Message-ID: <aFBfNRVAyE1FU9aQ@slm.duckdns.org>
References: <20250611221532.2513772-1-shakeel.butt@linux.dev>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250611221532.2513772-1-shakeel.butt@linux.dev>

Hello,

On Wed, Jun 11, 2025 at 03:15:28PM -0700, Shakeel Butt wrote:
> Shakeel Butt (4):
>   cgroup: support to enable nmi-safe css_rstat_updated
>   cgroup: make css_rstat_updated nmi safe
>   cgroup: remove per-cpu per-subsystem locks
>   memcg: cgroup: call css_rstat_updated irrespective of in_nmi()

The patches look good to me. How should it be routed? Should I take all
four, just the first three or would it better to route all through -mm?

Thanks.

-- 
tejun

