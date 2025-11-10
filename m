Return-Path: <cgroups+bounces-11755-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CC97C47C1A
	for <lists+cgroups@lfdr.de>; Mon, 10 Nov 2025 17:04:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id BB6BB349BDE
	for <lists+cgroups@lfdr.de>; Mon, 10 Nov 2025 16:04:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2B54274B35;
	Mon, 10 Nov 2025 16:04:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J+snn06h"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96BB2248F7C;
	Mon, 10 Nov 2025 16:04:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762790672; cv=none; b=RaemEZLKQMJli/b/yRJMgckd+0pIlzAB3rdJatWWT7UuWlNZDNKPnfhsVH69cbBPlXjWPVEyglpmO57HCelBXqU6/zTl2XUL4/gQLCQ4JS3D5eqsOjyxo0u8EnsRkGBt5KmjY6sBRprMGaAYjyurXNw6qUIxQeDQYth3x+mhWrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762790672; c=relaxed/simple;
	bh=LZ0mMsF76kmnDhMfcojZG4ktxujqq7jQuwle0KZTEXQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R9G1c6hyqUpPpFr/YweOFVRtciyKXL1MRWHtG7O//FisCSlguR2aO7pnYUAqGjxVYFB/AxCntPG8M5kix9RCUvyjwDv0PgDwmO+osNEabgxSeMbKh5BzH3tLb+mG6awvZsO7qhTmBpRCCK+d3jSFlEavVBdiHk81jErJsHKkffc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J+snn06h; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 087B0C4CEFB;
	Mon, 10 Nov 2025 16:04:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762790672;
	bh=LZ0mMsF76kmnDhMfcojZG4ktxujqq7jQuwle0KZTEXQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=J+snn06h+IYhepopRmbvt8zlgXQzsk6ymnBqQttXNsd2cAGH3KYMr8zVUQcNDD3jN
	 YM5zjB1ENrcxFa7Dqk6Wx3PVrpQxby+frFaLCEQhyY844KTRzFe3cH1bzE4S939zG9
	 BRsNxIlJdrRa+2ma2pfRfVTmWf0EW0ElZsxsen+ENsWYBCsImW1J5qDg3a1WCK3EUS
	 0gkrEzn+7zUIY5wxIZOro6siQoFX3EbehnqyyovCVg1VtrEibxGFtngGvt8jO6jrNE
	 6P+B9Bn9y1WKSAuSfN0n71SqtCZEZoQFwsKzA5DzDSPZpPS6MuFlDHu0a/58r3lPYY
	 oAS9LMgXZYuHA==
Date: Mon, 10 Nov 2025 06:04:30 -1000
From: Tejun Heo <tj@kernel.org>
To: Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>
Cc: Leon Huang Fu <leon.huangfu@shopee.com>, linux-mm@kvack.org,
	hannes@cmpxchg.org, mhocko@kernel.org, roman.gushchin@linux.dev,
	shakeel.butt@linux.dev, muchun.song@linux.dev,
	akpm@linux-foundation.org, joel.granados@kernel.org, jack@suse.cz,
	laoar.shao@gmail.com, mclapinski@google.com, kyle.meyer@hpe.com,
	corbet@lwn.net, lance.yang@linux.dev, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, cgroups@vger.kernel.org
Subject: Re: [PATCH mm-new v3] mm/memcontrol: Add memory.stat_refresh for
 on-demand stats flushing
Message-ID: <aRINDrnnI1HVvU1p@slm.duckdns.org>
References: <20251110101948.19277-1-leon.huangfu@shopee.com>
 <ewcsz3553cd6ooslgzwbubnbaxwmpd23d2k7pw5s4ckfvbb7sp@dffffjvohz5b>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ewcsz3553cd6ooslgzwbubnbaxwmpd23d2k7pw5s4ckfvbb7sp@dffffjvohz5b>

Hello,

On Mon, Nov 10, 2025 at 02:50:11PM +0100, Michal Koutný wrote:
> All in all, I'd like to have more backing data on insufficiency of (all
> the) rstat optimizations before opening explicit flushes like this
> (especially when it's meant to be exposed by BPF already).

+1. If the current behavior introduces errors too significant to ignore, I'd
much rather see it fixed from the implementation side rather than exposing
internal operation details like this.

Thanks.

-- 
tejun

