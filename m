Return-Path: <cgroups+bounces-5619-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 18AF19D166E
	for <lists+cgroups@lfdr.de>; Mon, 18 Nov 2024 17:57:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BF4B4B27FEB
	for <lists+cgroups@lfdr.de>; Mon, 18 Nov 2024 16:57:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C42F1BE852;
	Mon, 18 Nov 2024 16:56:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="XAa5sqiS"
X-Original-To: cgroups@vger.kernel.org
Received: from out-181.mta1.migadu.com (out-181.mta1.migadu.com [95.215.58.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8505E1B5EA4
	for <cgroups@vger.kernel.org>; Mon, 18 Nov 2024 16:56:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731949000; cv=none; b=HIwrnfcoaZ/TUganF9x/2vX8rI8Pgat+jN+j3ILTdWsVAeuoH6zCPBQvDdBjfsmLdohM8QJfbbcuwYTm7Ft4fXP+EtS9X2khC93MIJQ0hdr/yryPhKbt0zWUvKOO/c87GSBYgpWEY9Te81ViC0rbPiQIawndvLhNOLcVw9rCNQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731949000; c=relaxed/simple;
	bh=m4HVZ3+6RXsvVWE65C+L+Ujbbo6+dMR0YMemergLGyk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BnXdlFZkw+kM0E84AfpXC8mHtwMROQykrZiB10WSn7Nl3KF4zVPeetXlnpXOt45I7vWLYdRoM8haUXC/7qa1gs0cIcZbCsG8HEZm1OW7gkS63BmSKTGF4UTeYITiaouY7+QSI/WYfgRD+aZ5kRLjkY4wrU+cW0T3vLsjBqb+/+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=XAa5sqiS; arc=none smtp.client-ip=95.215.58.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Mon, 18 Nov 2024 16:56:31 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1731948996;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=59zS/1A05nM4M6tWzQtKALV91pOAZt9Z4V177dGFIA4=;
	b=XAa5sqiSA09ONIFQdTjTyerzgYSOFcQHoT32a0p2NLv3tpiBjMSfZwJ6W6St+SW7dMXSOV
	wzDOpyS2hU71eVWoIhWLa1gA6nvq+lvfxxBdOzicUd8TBCTb0n1IJ3af6Qv8Bl8jSqRK/c
	NcjQ+xtGFxNUs/8M0AwzOm5jwQF8Tkc=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Roman Gushchin <roman.gushchin@linux.dev>
To: Keren Sun <kerensun@google.com>
Cc: akpm@linux-foundation.org, hannes@cmpxchg.org, mhocko@kernel.org,
	shakeel.butt@linux.dev, muchun.song@linux.dev,
	cgroups@vger.kernel.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] mm: remove the non-useful else after a break in a if
 statement
Message-ID: <Zztxv0OAq5DmNhgl@google.com>
References: <20241115235744.1419580-1-kerensun@google.com>
 <20241115235744.1419580-4-kerensun@google.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241115235744.1419580-4-kerensun@google.com>
X-Migadu-Flow: FLOW_OUT

On Fri, Nov 15, 2024 at 03:57:44PM -0800, Keren Sun wrote:
> Remove the else block since there is already a break in the statement of
> if (iter->oom_lock), just set iter->oom_lock true after the if block
> ends.
> 
> Signed-off-by: Keren Sun <kerensun@google.com>

Reviewed-by: Roman Gushchin <roman.gushchin@linux.dev>

Thanks!

