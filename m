Return-Path: <cgroups+bounces-2475-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 24D228A405F
	for <lists+cgroups@lfdr.de>; Sun, 14 Apr 2024 06:58:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5090F1C20C5A
	for <lists+cgroups@lfdr.de>; Sun, 14 Apr 2024 04:58:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC7701A702;
	Sun, 14 Apr 2024 04:58:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="QtAFfyn0"
X-Original-To: cgroups@vger.kernel.org
Received: from out-181.mta0.migadu.com (out-181.mta0.migadu.com [91.218.175.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2353C18659
	for <cgroups@vger.kernel.org>; Sun, 14 Apr 2024 04:57:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713070680; cv=none; b=togQB90NYqzbYa0wvv81dGYzyoL6ydH2XWldhs9FIJviTbD0ycElGtNnPwny6EnsRYOigdP7WISAXSM+mZDA0jLf4YNtkIgyIQBcEiCKtaoxuhFrOAfjJwfZvvGTqZ3sVs2r+RoaTzBOxuYr9D5jTNJoWjN/JD0syTqk6XZWJck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713070680; c=relaxed/simple;
	bh=KEWXPQZKMKAZI5UGG+KEr9SgfSlaUFXgtmhVYtAjo5U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LEUFyqOsTzC0lWO0w3oHCuaNfcNKocgRfTa4m/WXso1DESNqaYJVQ9I/nqEWhlz722CRAexo/AjzQBobBM8hXsjQo3qRstezKC9nMA6HmHMapcYqp+iV6xPh71i9ShvQklYzt+kiaQ59j2lXg5w4mzPBI2dRF3Ka3qaPSIDmKgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=QtAFfyn0; arc=none smtp.client-ip=91.218.175.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Sat, 13 Apr 2024 21:57:50 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1713070676;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ZA5aE3j3lTWxM9WMGZSCrXNcLpZkWfP1rN5XDhrTFYg=;
	b=QtAFfyn0DU6DX7p0vHWdOXK+ihaVNuodpMdIhGtBvpUEsDR0RaF4wREOEPDALySzXhWQ19
	Xqon6q7mFTvSbHeog01EYdTWf53b0pE6Eg9DO0camN1FNwCz5A7SUir7IdKarfjlCP8bRL
	qZzML8WeqEsztT4SsIcfPqOsvyKjmiM=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, 
	Josh Poimboeuf <jpoimboe@kernel.org>, Jeff Layton <jlayton@kernel.org>, 
	Chuck Lever <chuck.lever@oracle.com>, Kees Cook <kees@kernel.org>, Christoph Lameter <cl@linux.com>, 
	Pekka Enberg <penberg@kernel.org>, David Rientjes <rientjes@google.com>, 
	Joonsoo Kim <iamjoonsoo.kim@lge.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Hyeonggon Yoo <42.hyeyoo@gmail.com>, 
	Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>, 
	Muchun Song <muchun.song@linux.dev>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, cgroups@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] mm, slab: move slab_memcg hooks to mm/memcontrol.c
Message-ID: <nobhrwke5wctxz73jj72xtw6ovbxduocyw2lpdx65mcwznlgx3@wlzwakkrlp2z>
References: <20240325-slab-memcg-v2-0-900a458233a6@suse.cz>
 <20240325-slab-memcg-v2-2-900a458233a6@suse.cz>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240325-slab-memcg-v2-2-900a458233a6@suse.cz>
X-Migadu-Flow: FLOW_OUT

On Mon, Mar 25, 2024 at 09:20:33AM +0100, Vlastimil Babka wrote:
> The hooks make multiple calls to functions in mm/memcontrol.c, including
> to th current_obj_cgroup() marked __always_inline. It might be faster to
> make a single call to the hook in mm/memcontrol.c instead. The hooks
> also don't use almost anything from mm/slub.c. obj_full_size() can move
> with the hooks and cache_vmstat_idx() to the internal mm/slab.h
> 
> Reviewed-by: Roman Gushchin <roman.gushchin@linux.dev>
> Signed-off-by: Vlastimil Babka <vbabka@suse.cz>

Acked-by: Shakeel Butt <shakeel.butt@linux.dev>

