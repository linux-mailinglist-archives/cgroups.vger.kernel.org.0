Return-Path: <cgroups+bounces-6314-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 60B3AA1C03A
	for <lists+cgroups@lfdr.de>; Sat, 25 Jan 2025 02:28:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B3C00167176
	for <lists+cgroups@lfdr.de>; Sat, 25 Jan 2025 01:27:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5172A1E9917;
	Sat, 25 Jan 2025 01:27:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="chUnKeUT"
X-Original-To: cgroups@vger.kernel.org
Received: from out-178.mta1.migadu.com (out-178.mta1.migadu.com [95.215.58.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 728511DE4EA
	for <cgroups@vger.kernel.org>; Sat, 25 Jan 2025 01:27:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737768477; cv=none; b=jciHMu2RvNP7eO7SvoneAxk2g1og89XqjcCN0yg1PWrKNnpx4rMQGbcoO3pk0tg/lhsfYTH/eZ0VoitmEYfHSi498xBzwjmTEWotp+PcT9J8fMtpJbGN3Sxdt0hmYiwZu52RNYyp7TsQru2C6vLTQW5rqSZaauUQJ8LYMXUH1O4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737768477; c=relaxed/simple;
	bh=0jmFD9RkuGGQmtju3JpW9w2K7mbstf2sVrLqek+QjiQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EW/RPmz2JFy3jNOLN0Ap307dxWExYlivQbOAN7mKRrNahW5bxinB47ESrawPmAyA3iCq6Ggi08oMqgOmPE7XOMxEv6vN9kJl53bSGHx9VybFbF/YfnOn7WBz8oTxSDgpUgOanjYQgwojliFfm6xKtzUFfTUH+BibYNMiZoBuRu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=chUnKeUT; arc=none smtp.client-ip=95.215.58.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Sat, 25 Jan 2025 01:27:29 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1737768473;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=uTaLvtkaoH3T6jQueiGi7bj75ddZrR7XUx+IBHhXZkE=;
	b=chUnKeUTG6tWlXdATJ83MpqazS9SqlYKB0WpWFWPXA80pklsojFPWCY4/yfF97B56f0NS8
	keYU7fmgDYQU/zeU5zLiOedUABEbm+W5aFZ/rGq9/Xb+e7edIjpS9ri6DNlTKgdvLGnrB6
	p/nuNqfcuI4XLqduxAjnQUw9we2bvDQ=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Roman Gushchin <roman.gushchin@linux.dev>
To: Johannes Weiner <hannes@cmpxchg.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Michal Hocko <mhocko@suse.com>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Muchun Song <muchun.song@linux.dev>, linux-mm@kvack.org,
	cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] mm: memcontrol: unshare v2-only charge API bits again
Message-ID: <Z5Q-AZX_CEO14exE@google.com>
References: <20250124043859.18808-1-hannes@cmpxchg.org>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250124043859.18808-1-hannes@cmpxchg.org>
X-Migadu-Flow: FLOW_OUT

On Thu, Jan 23, 2025 at 11:38:58PM -0500, Johannes Weiner wrote:
> 6b611388b626 ("memcg-v1: remove charge move code") removed the
> remaining v1 callers.
> 
> Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>

Acked-by: Roman Gushchin <roman.gushchin@linux.dev>

Thanks

