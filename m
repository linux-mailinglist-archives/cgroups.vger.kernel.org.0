Return-Path: <cgroups+bounces-4828-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AC189743E0
	for <lists+cgroups@lfdr.de>; Tue, 10 Sep 2024 22:06:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D01A328BE8D
	for <lists+cgroups@lfdr.de>; Tue, 10 Sep 2024 20:06:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29D3D1A4B74;
	Tue, 10 Sep 2024 20:05:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ms4abbrs"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC6C717DFE1;
	Tue, 10 Sep 2024 20:05:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725998759; cv=none; b=YjPlPGWzGZiA0t8stS6Loy3v5qnUrJgev4jkJiJj3QRGBX/NyH1dBj50cbMim/Eism9GABjcBIq51FDEhIGqdWllT4uRbC8PW7f4z25GzFkluhqd/cPeaIWISzBnwV+ly0W9AdkKLrLPJEHuk2BzpgqBps55+XmXrvbo58gClds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725998759; c=relaxed/simple;
	bh=0CjcsdJHSRmucubjhpt/OuKI2KFinC6m8PlvTHOWjZM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cEZmWAPnPfz7jXZ93XON57NZidByneUZfpT/M5708aYhK7A4NdJwTEGkWwWA1nQGKszefHGtrJdGBN2GWUlx9FTskTZ7HGHemohIWlq0oUX9pN/2MZkHzLjo0iy8dh9P58NMjVDEnhy7JiIv0KXnx3+P+o59RXvsn9ZKXGjpygY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ms4abbrs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D799C4CEC3;
	Tue, 10 Sep 2024 20:05:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725998758;
	bh=0CjcsdJHSRmucubjhpt/OuKI2KFinC6m8PlvTHOWjZM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Ms4abbrs+GDqyGleVqWZ0+K14PW+W6t784VA5JKj1dcywA40bx/XVRllI4hLSgFmQ
	 JcDIJlU+F+Lm5C7C1zN/EYsm6aHFlMHkBpzy7k4xOH2PK+P1fAilZhzCC8z5K0rRTG
	 xsF9KT8M8/K0YKMZVox0s/c9Q5KfPHi3QYyQzB4HqiXkd2nCShJN7Ui+M8+004AcLT
	 +PWY7Khpdm+BomwJJfrww3jbeGFaF3xNLgjNm8FT8sg0gUv9ZW1nd0iV2/GEPIwz3s
	 P4EH2Jrb3rHco/xmEvXo1qmQ8L2yR70bD2SxzZWbaPrIs9U7gbT78a/xMxdV1j4InT
	 mJWmRkJA+BsGg==
Date: Tue, 10 Sep 2024 10:05:57 -1000
From: Tejun Heo <tj@kernel.org>
To: Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>
Cc: cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, Zefan Li <lizefan.x@bytedance.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Michal Hocko <mhocko@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Muchun Song <muchun.song@linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>,
	Chen Ridong <chenridong@huawei.com>
Subject: Re: [PATCH 1/4] memcg: Cleanup with !CONFIG_MEMCG_V1
Message-ID: <ZuCmpW2JFFAxmGvS@slm.duckdns.org>
References: <20240909163223.3693529-1-mkoutny@suse.com>
 <20240909163223.3693529-2-mkoutny@suse.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240909163223.3693529-2-mkoutny@suse.com>

On Mon, Sep 09, 2024 at 06:32:20PM +0200, Michal Koutný wrote:
> Extern declarations have no definitions with !CONFIG_MEMCG_V1 and no
> users, drop them altogether.
> 
> Signed-off-by: Michal Koutný <mkoutny@suse.com>

Acked-by: Tejun Heo <tj@kernel.org>

This one should go through -mm. If Andrew doesn't pick it up from this
thread, it might be better to repost it.

Thanks.

-- 
tejun

