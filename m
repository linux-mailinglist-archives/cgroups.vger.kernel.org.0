Return-Path: <cgroups+bounces-5436-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B82049BC206
	for <lists+cgroups@lfdr.de>; Tue,  5 Nov 2024 01:31:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7DF262828A2
	for <lists+cgroups@lfdr.de>; Tue,  5 Nov 2024 00:31:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05EE2BA53;
	Tue,  5 Nov 2024 00:31:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="JjKPNDOJ"
X-Original-To: cgroups@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6405B667;
	Tue,  5 Nov 2024 00:31:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730766703; cv=none; b=fzKRRCGm0BM9s125OZBSCPrSmG6m9DpqF1c8b7Nt2Vdl5T9A340fQgqDtUFKESe58lyg0hf5sxMQqUYQQJjyAA7/NGjkG/k4j7nTO6lt17hOPRzhfIZkdB9+iPVeATVJD6EzNhWoUL3CDxYZEChqe1il26lrRh0YTA8rQBGleow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730766703; c=relaxed/simple;
	bh=HzAl/JPU25UwzwTupjSxWucniSCa+0gmfS32vUCwSVE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dM2uI13t1BVQZSqDbCmVZfrCPeP1hitdRtd0I7rSH9PqrdtinV3Smhm8K1daNx+ubL0xhpTeZqa+2rSetIDtslO7JFI6QwxXI4LVheSJBUhsu8/T6ROFtSFQ7EwVZ7Ww4jT0ixSlIHijCEvNDVOeYGw72GBXtJfrOEAsZlCDHQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=JjKPNDOJ; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=UOyKBCJv4kPFZCEVQ/auD/OQoVNuo1XVVxJkxEPstRY=; b=JjKPNDOJAYX42o6fCiUC1s37st
	Ivz867pa2fqAYQt/xUGGtOsjcx6Y/MonTopIt9QKRgy5ObVdUPxCvYR4ZkHKHghbsp3ZutbZeKOET
	6rk0hQkBbZt0Xo+cobz+O8mi3Z7zPJ+zBUmG9bjwyj/TQ4FqCv1oMZstPvboQ1X0POdnWXIfL8com
	mpLdOrp6fUu/oQXp9pAnMEZPh5S5JoOm4c1qddFzSkd2erQYYdJ+UepC89TCubus6GkyBVPpXAIrl
	54kpvMbm4eUV6ZRzCqcygZiNQgDkABH36NFWPTkGPtzejpnekKlXhScxkwJpwlQUqIwuRUJ67GBu6
	jpSMlksQ==;
Received: from willy by casper.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1t87Tt-00000001jhZ-07St;
	Tue, 05 Nov 2024 00:31:37 +0000
Date: Tue, 5 Nov 2024 00:31:36 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Keren Sun <kerensun@google.com>
Cc: akpm@linux-foundation.org, roman.gushchin@linux.dev, hannes@cmpxchg.org,
	mhocko@kernel.org, shakeel.butt@linux.dev, muchun.song@linux.dev,
	cgroups@vger.kernel.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/4] mm: fix checkpatch.pl warnings in memcg v1 code
Message-ID: <ZylnaFbRZMDYR_Hw@casper.infradead.org>
References: <20241104222737.298130-1-kerensun@google.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241104222737.298130-1-kerensun@google.com>

On Mon, Nov 04, 2024 at 02:27:33PM -0800, Keren Sun wrote:
> The patch series fixes 1 error and 27 warnings found by checkpatch.pl in the
> memcg1 code.

Please do not do this.  Fixing checkpatch messages in existing code
is counterproductive.  Only run checkpatch on new code, and even then
take its suggestions with a grain of salt.

