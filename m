Return-Path: <cgroups+bounces-6110-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B9FAA0BF2B
	for <lists+cgroups@lfdr.de>; Mon, 13 Jan 2025 18:49:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1FFA53A1601
	for <lists+cgroups@lfdr.de>; Mon, 13 Jan 2025 17:49:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1EE81BD50C;
	Mon, 13 Jan 2025 17:49:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="pAShgS1W"
X-Original-To: cgroups@vger.kernel.org
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27BCB24022F;
	Mon, 13 Jan 2025 17:49:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736790583; cv=none; b=kst/DewYd92sTBC3E23zEIVupv36wJEC9u51ICtaVsaqgqfgNmnbDxcT3B6mBN/sth16zaVhGami4vYDFLz1stydz9rZ/9e11ZH3Bg8kC/wusPQ+Cmwb1JpVUMOFU1q2HjAqEubTdXCxfY+qsDwk4EDxPMYQd3IFZCXlK5YRPbs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736790583; c=relaxed/simple;
	bh=syxR3d91rGK32jPVBjjK4XsbCKfLAhrwmx1hcm6W1cU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=EMmWOApDoKcLpCgUrPxzSnAKhEys2rvE4CjXuaGCAFRssnUMz/5jPNXVdSdwqFXuDgCqvs7646sEZcHwFmk0rSVm7zULYoFhgOYpamA2DRPsiA5avHjDdrIX3PEM+Gymou5NnfIRC6B5LyXItuImJpkNkM+Kbtw0L576KaZVTCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=pAShgS1W; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 545C9404F5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1736790581; bh=YFV52yk/D5CvXBpds7DH4HDAfMkeNRMix/bPQdwx0R8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=pAShgS1WzlMEFZsliCMyZMx6CU9Bv1/K4gV6/09qZnOMBIFLPk/R4qyB9B08pUabz
	 UNssQ+XIJlXuxr4PTi7NHjYLHUGCHnYROit+I2lR5u6M7TsTr0u3GHZoqsp/E3Xkw8
	 TsRXENZepK1YbvzOX/e1Ue9QB0M8oWgSWfof9AKb/LoKvRPyujSJIOExp+1GHKGd5E
	 66wMbbjkUYaEfKr0jMnmT9Nep/fWnaE6SRZf5jJktAPw8cR+6qeZfKALc+HKu4nygE
	 aqmNV43ZCmwVDoT6K4Uv6OQMNPil+VU5jhklL8ilbaSwVrqmNVWH9b6JH4Xtp05agM
	 58W7dCBAcALbg==
Received: from localhost (unknown [IPv6:2601:280:5e00:625::1fe])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id 545C9404F5;
	Mon, 13 Jan 2025 17:49:41 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Li Zhijian <lizhijian@fujitsu.com>, linux-doc@vger.kernel.org
Cc: Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>,
 mkoutny@suse.com, cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
 Waiman Long <llong@redhat.com>, Li Zhijian <lizhijian@fujitsu.com>
Subject: Re: [PATCH v2] Documentation/cgroup-v2: Update
 memory.{stat,numa_stat} description to reflect possible units
In-Reply-To: <20250113010530.432396-1-lizhijian@fujitsu.com>
References: <20250110123019.423725-1-lizhijian@fujitsu.com>
 <20250113010530.432396-1-lizhijian@fujitsu.com>
Date: Mon, 13 Jan 2025 10:49:40 -0700
Message-ID: <871px6bo3v.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Li Zhijian <lizhijian@fujitsu.com> writes:

> The description of the memory.{stat,numa_stat} file has been updated to
> clarify that the output values can be in bytes or pages.
> This change ensures that users are aware that the unit of measurement for
> memory values can vary and should be verified by consulting the memory.stat
>
> It's known that
> workingset_*, pg* are counted in pages
>
> Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>a
> ---
> V2: updated the document as suggestion from Michal
>     updated subject and commit log
> ---
>  Documentation/admin-guide/cgroup-v2.rst | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
>
> diff --git a/Documentation/admin-guide/cgroup-v2.rst b/Documentation/admin-guide/cgroup-v2.rst
> index 315ede811c9d..0a43be0c32d1 100644
> --- a/Documentation/admin-guide/cgroup-v2.rst
> +++ b/Documentation/admin-guide/cgroup-v2.rst
> @@ -1427,7 +1427,7 @@ The following nested keys are defined.
>  	types of memory, type-specific details, and other information
>  	on the state and past events of the memory management system.
>  
> -	All memory amounts are in bytes.
> +	All memory amounts are in bytes unless said otherwise.
>  
>  	The entries are ordered to be human readable, and new entries
>  	can show up in the middle. Don't rely on items remaining in a
> @@ -1673,11 +1673,12 @@ The following nested keys are defined.
>  	application performance by combining this information with the
>  	application's CPU allocation.
>  
> -	All memory amounts are in bytes.
> -
>  	The output format of memory.numa_stat is::
>  
> -	  type N0=<bytes in node 0> N1=<bytes in node 1> ...
> +	  type N0=<value for node 0> N1=<value for node 1> ...
> +
> +        The 'value' can be in bytes or pages, depending on the specific
> +        type of memory. To determine the unit, refer to the memory.stat.

This seems like useful information - but can we really not give better
guidance to our readers on how to interpret this value?  What in "the
memory.stat" will tell them which units are in use?

(Even better, could we fix the code to always return the same units
without breaking something somewhere?)

Thanks,

jon

