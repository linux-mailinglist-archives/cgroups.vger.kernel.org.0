Return-Path: <cgroups+bounces-2838-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DAA38C1343
	for <lists+cgroups@lfdr.de>; Thu,  9 May 2024 18:54:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 518EB28287B
	for <lists+cgroups@lfdr.de>; Thu,  9 May 2024 16:53:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5521BA50;
	Thu,  9 May 2024 16:53:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="o2RUXFJX"
X-Original-To: cgroups@vger.kernel.org
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B44D6FD0;
	Thu,  9 May 2024 16:53:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715273630; cv=none; b=D9IQpcJiL/XYWcHUbzFsxOT816zu1ndCLPWC98zjBKTpNPEjP3MtL/HcWM/f/50ptfPeHKKMgnxWGzoiQzCg9WVLkqPDup6mW8+Q9poAVw6KGhgU43/M8Q8AKHsvFKTSagT6EeciJyniBfW/RUoNAtHxnIn7np7WGO1sobz2rO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715273630; c=relaxed/simple;
	bh=WrrxmjCdbSQrx82x24gxrtpbnXLGGWA/COa+oD/wCDw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=hoOVep3w8+LZUDoSwphBxvRSrknuTssnpboki1PBOKX9F+NRmPxgnpLjsKXjFMo/oRLElIHm3U6+NPAPnmzzX1LtxEaDyplvGq5y6vRRSHm6NjaWUetiHX+DxNad3qBkwy4T99Eb0MOzTle7TLzlX9+bDNIIrs6iMJdSPU03nuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=o2RUXFJX; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 5334B47C39
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1715273628; bh=Swp5U3+6z/DT5it4gIm6NL5VrQp9grZhimL+5b+AEoI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=o2RUXFJXTbO1fcWArXD2TKUDbl5Rzz9sWzwhPRACq8FLmSQJ7VTYr6H0I/p6w4qiq
	 RDGoOv4y2jMMPcoqIwT+IFGKTOfAG8Ff5FvoSWDEAnEQKWq+KhDOYw8hUINSvGDOzI
	 YGD2dsMkAFceDEVno9UUF/M7U0w9lfe+Q43KbcAltk6ejXye6BU5H6D8X9LvkmJFtA
	 gL7BxLRF9osD0xACMIjS7tLzCPyK4nKpRJ7yQTB1ezAXGcs4+BeX/bJP0wARd8j2Hd
	 eI3GYddIt7wBdhnxVm1ip7OYPtaBe0I6VNceJQjbHCjYYBgk+inSrtQgxt7wF6LaS3
	 nxHsQhJsshvCw==
Received: from localhost (mdns.lwn.net [45.79.72.68])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id 5334B47C39;
	Thu,  9 May 2024 16:53:48 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Usama Arif <usamaarif642@gmail.com>, hannes@cmpxchg.org, tj@kernel.org,
 lizefan.x@bytedance.com, nphamcs@gmail.com
Cc: linux-mm@kvack.org, cgroups@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, kernel-team@meta.com, Usama Arif
 <usamaarif642@gmail.com>
Subject: Re: [PATCH v2 1/1] cgroup: Add documentation for missing zswap
 memory.stat
In-Reply-To: <20240502185307.3942173-2-usamaarif642@gmail.com>
References: <20240502185307.3942173-1-usamaarif642@gmail.com>
 <20240502185307.3942173-2-usamaarif642@gmail.com>
Date: Thu, 09 May 2024 10:53:47 -0600
Message-ID: <87jzk3apus.fsf@meer.lwn.net>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Usama Arif <usamaarif642@gmail.com> writes:

> This includes zswpin, zswpout and zswpwb.
>
> Signed-off-by: Usama Arif <usamaarif642@gmail.com>
> ---
>  Documentation/admin-guide/cgroup-v2.rst | 9 +++++++++
>  1 file changed, 9 insertions(+)
>
> diff --git a/Documentation/admin-guide/cgroup-v2.rst b/Documentation/admin-guide/cgroup-v2.rst
> index 17e6e9565156..eaf9e66e472a 100644
> --- a/Documentation/admin-guide/cgroup-v2.rst
> +++ b/Documentation/admin-guide/cgroup-v2.rst
> @@ -1572,6 +1572,15 @@ PAGE_SIZE multiple when read back.
>  	  pglazyfreed (npn)
>  		Amount of reclaimed lazyfree pages
>  
> +	  zswpin
> +		Number of pages moved in to memory from zswap.
> +
> +	  zswpout
> +		Number of pages moved out of memory to zswap.
> +
> +	  zswpwb
> +		Number of pages written from zswap to swap.
> +

Applied, thanks.

jon

