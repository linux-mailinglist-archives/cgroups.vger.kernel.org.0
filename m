Return-Path: <cgroups+bounces-4483-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F13B95FDA2
	for <lists+cgroups@lfdr.de>; Tue, 27 Aug 2024 01:00:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0A9E32825D5
	for <lists+cgroups@lfdr.de>; Mon, 26 Aug 2024 23:00:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E797149E0B;
	Mon, 26 Aug 2024 23:00:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ojpe3vpL"
X-Original-To: cgroups@vger.kernel.org
Received: from out-183.mta0.migadu.com (out-183.mta0.migadu.com [91.218.175.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB53E487A5;
	Mon, 26 Aug 2024 23:00:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724713238; cv=none; b=CdI32MM6OfiipFlHlluyq1e/9dUxr/lrBrHEBk7eaw9JN8VYJhySlE+5Cqd2KCoQ+c07IoBUGNzelfSUb48fhG/cotwB01w/GbYafeUno9sTSiotAz+tGOwtQsUBG1q5MAmPL9oaKp9olfclc0CcGygNv66V7pFT3WX2byRxZac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724713238; c=relaxed/simple;
	bh=GBQfNNusRQ+Ir08/pcoEWEV9Rp8JDYyo1YCtFM69myk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QFO1OVMYSGKNimCMqfjKkBoIf+5UoxHOO3anT8cV4GDjZRRnKY8PFPjuxfV6XavRjJOqh648Bi0uCdc9nXP76KSjB7FbBxnvgKV7T4vZFmRqjRcdO5LIaA6gBZEzzy6Qlx37+08FrD82RMZpX63vDkGvD+n4WmBaw53jJ1gW4Ic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ojpe3vpL; arc=none smtp.client-ip=91.218.175.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Mon, 26 Aug 2024 16:00:18 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1724713233;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=iA2UMr+7g/QYeYrRgjcH0CSQVKvv9HIhEL6aqI71c28=;
	b=ojpe3vpLF+Hc+cgOCB0XtkD+gnk7toho3gjTYic646AgkiwHN7tB4UuVR3waOIxY6VN3yV
	ZE7qB1H4Gmm2ZWy1W4jfcqWvnFD7Kjo79wpD9EXsnVmhyyD1yjQxFqLv6gtNxTPWEZWe6R
	Dx7DkDYzPHFYtxgmXGmaI747pdAYNao=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Muchun Song <muchun.song@linux.dev>, 
	Vlastimil Babka <vbabka@suse.cz>, David Rientjes <rientjes@google.com>, 
	Hyeonggon Yoo <42.hyeyoo@gmail.com>, Eric Dumazet <edumazet@google.com>, 
	"David S . Miller" <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, Meta kernel team <kernel-team@meta.com>, cgroups@vger.kernel.org, 
	netdev@vger.kernel.org
Subject: Re: [RFC PATCH] memcg: add charging of already allocated slab objects
Message-ID: <mi6yknblpgfl2rujwooqbz5qd4wbv6foibrczji62lntp6scgo@5wfjawkrfvfy>
References: <20240824010139.1293051-1-shakeel.butt@linux.dev>
 <20240826144600.20cc15ad@kernel.org>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240826144600.20cc15ad@kernel.org>
X-Migadu-Flow: FLOW_OUT

On Mon, Aug 26, 2024 at 02:46:00PM GMT, Jakub Kicinski wrote:
> On Fri, 23 Aug 2024 18:01:39 -0700 Shakeel Butt wrote:
> > +EXPORT_SYMBOL(kmem_cache_post_charge);
> 
> FWIW ipv4 can't be a module, but perhaps you're just following local
> customs

Yup just following the local customs of that file.

