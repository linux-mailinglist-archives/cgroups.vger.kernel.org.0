Return-Path: <cgroups+bounces-5671-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B411D9D6BAA
	for <lists+cgroups@lfdr.de>; Sat, 23 Nov 2024 22:35:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4669C1618E4
	for <lists+cgroups@lfdr.de>; Sat, 23 Nov 2024 21:35:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56E49EADC;
	Sat, 23 Nov 2024 21:35:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="EDJg8xsV"
X-Original-To: cgroups@vger.kernel.org
Received: from out-170.mta1.migadu.com (out-170.mta1.migadu.com [95.215.58.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 704431A76B7
	for <cgroups@vger.kernel.org>; Sat, 23 Nov 2024 21:35:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732397738; cv=none; b=A11KmYhStOSM2dWD6heQorCRg3bVHFTRndOn9pp+q/bQUHp3wdeaaTrzNGuq25HA5kc2hYIXtt9q6YfB0UIEY0o77OYcGi9EHhtfLPiieKzOqAY7VzKrCOl8XcrfPJhxSWG4LKAN49JpKKelErjYVfClcn649K/VM7r3WbHbqEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732397738; c=relaxed/simple;
	bh=Z+uNhX53sVaYCcTI9owtqEs6w1MaEFmKys3h/NSoXpI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VmJ9OTnuzE1VjizYGUsblq8gd+bOizT9PQ02qHm8C61yA/mWcLz9p+rcyMMQ+7kFE6E/R+5JfiwaYEnDpWXt5TqD/uSk51xw4tBeAOiIXsJdY43cHXmSkBeqOQ7PJK3pDfxpxljFSpMVrbRiSnmEXLUMsTVIspJ7qWcHSXrI+nQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=EDJg8xsV; arc=none smtp.client-ip=95.215.58.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Sat, 23 Nov 2024 13:35:24 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1732397729;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=zKxGTUmS4dcKGQY0jjq321pdX2jaD19pGhWKPewS3bE=;
	b=EDJg8xsVJwYmr/wh/pu9cmlYQKYBUvtoJ+fitNPChNy4h0aMfZKTY+yQ4/nVDbBXOIDzDo
	G6gYk7Wvx+2PMYBhw9DtwJZCfoyeenad0lOg7pOg7zxyuisVFs9L5v8lCaThj1kj1A9QZm
	IAAz0wm/rUhTZU94ONkm9efwQLH8pzI=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Matthew Wilcox <willy@infradead.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Muchun Song <muchun.song@linux.dev>, 
	Vlastimil Babka <vbabka@suse.cz>, Axel Rasmussen <axelrasmussen@google.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Suren Baghdasaryan <surenb@google.com>, linux-mm@kvack.org, 
	cgroups@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Meta kernel team <kernel-team@meta.com>
Subject: Re: [PATCH] mm: mmap_lock: optimize mmap_lock tracepoints
Message-ID: <i3joc4vme76imq2etk7gjfntsy2z5l5niyqobeun5e7m6jh4yi@adwzrxbvuc6l>
References: <20241123060939.169978-1-shakeel.butt@linux.dev>
 <Z0IKhWfOr4ppnQem@casper.infradead.org>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z0IKhWfOr4ppnQem@casper.infradead.org>
X-Migadu-Flow: FLOW_OUT

On Sat, Nov 23, 2024 at 05:01:57PM +0000, Matthew Wilcox wrote:
> On Fri, Nov 22, 2024 at 10:09:39PM -0800, Shakeel Butt wrote:
> >  	TP_printk(
> > -		"mm=%p memcg_path=%s write=%s",
> > -		__entry->mm,
> > -		__get_str(memcg_path),
> > +		"mm=%p memcg_id=%llu write=%s",
> > +		__entry->mm, __entry->memcg_id,
> >  		__entry->write ? "true" : "false"
> 
> Is it actually useful to print out the (hashed) pointer of the mm?
> Wouldn't the PID be more useful so you could actually associate it with
> a task?
> 

For our usecase i.e. bpftrace, we don't really care about these prints
as we can directly access the arguments like mm in bpftrace. I wonder if
others are using this hased pointer in some other way. I don't mind
chaning it but I think that would be a separate patch.

