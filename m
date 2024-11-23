Return-Path: <cgroups+bounces-5668-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BD3069D6A70
	for <lists+cgroups@lfdr.de>; Sat, 23 Nov 2024 18:02:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4E24EB21437
	for <lists+cgroups@lfdr.de>; Sat, 23 Nov 2024 17:02:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2160A70818;
	Sat, 23 Nov 2024 17:02:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="YbYJmpIk"
X-Original-To: cgroups@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E03D182C5;
	Sat, 23 Nov 2024 17:02:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732381331; cv=none; b=E+n9ALJXvyXggPrX6hnV3qIeml0KeenDfl2E5D3j9OviFCzDWpPLUHiM3l7iZOLKj8lTfY8WBqVUPJgH8SbCqH9s6irutHimEb2tFaQO8NgumUWxB9/4fa8SJ7Lnr+njfWiUe2z5Od7Z5YhqIWpDR0ljAlPtYXJ3EzGNM8l5pFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732381331; c=relaxed/simple;
	bh=GQgbaf28AOwMSwYhpGsNXO+ahGxYKmD0HxJgmtZWOn8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nsSLAl6xxhJvfgwXGG5rhYIz4mnn7FfKfQOFGICrT2NGS63rYEDABtMe2GjyhGAJralx3WxCm1dWh6SoO5WMu6IMG+bACgYgl9hsGtUKIuL0yfqf1F1YyWah1pmgVbfjY9O64XqawvPE+dWkVA2OXf+ZNPTO2zl4lRsbtplyP+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=YbYJmpIk; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=Q7pTiwXFRCHeq9RoohiLO/XjDHdz5wqm9X4ST4ceCus=; b=YbYJmpIk4LEruXT9q9jYZKENPl
	vA/5Ou99f2fM7lM4sJfgEuOF7jLcuRLlMdiG5s8xvj7Q/bAs2Qa+pFpXeMDcJm6TLlrCB5iAMyo6c
	lcpmlu8Td49O3Om6jeD3gpYn46VGBzhwCJalc6WAWvgc+T+7ItfcwHU2x9VTM2ISkaMRGnu7wx9sn
	X1jGmGw6da4vjnb1tsxfBO7mREvUEbI2z6YVqLWPfL7zX1k3qiJS4WzKq9NVlSmip7F4cS/6qTrPH
	zzNjCdMeujScYyNK0i7U00F6hdf2p5oiJH4rtSCdm6qBkCPud1Mee1HjblgkwnuwgfV6czl6AFlAx
	jz4uqvMQ==;
Received: from willy by casper.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tEtW9-00000009PKr-2Xb1;
	Sat, 23 Nov 2024 17:01:57 +0000
Date: Sat, 23 Nov 2024 17:01:57 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Michal Hocko <mhocko@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Muchun Song <muchun.song@linux.dev>,
	Vlastimil Babka <vbabka@suse.cz>,
	Axel Rasmussen <axelrasmussen@google.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Suren Baghdasaryan <surenb@google.com>, linux-mm@kvack.org,
	cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
	Meta kernel team <kernel-team@meta.com>
Subject: Re: [PATCH] mm: mmap_lock: optimize mmap_lock tracepoints
Message-ID: <Z0IKhWfOr4ppnQem@casper.infradead.org>
References: <20241123060939.169978-1-shakeel.butt@linux.dev>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241123060939.169978-1-shakeel.butt@linux.dev>

On Fri, Nov 22, 2024 at 10:09:39PM -0800, Shakeel Butt wrote:
>  	TP_printk(
> -		"mm=%p memcg_path=%s write=%s",
> -		__entry->mm,
> -		__get_str(memcg_path),
> +		"mm=%p memcg_id=%llu write=%s",
> +		__entry->mm, __entry->memcg_id,
>  		__entry->write ? "true" : "false"

Is it actually useful to print out the (hashed) pointer of the mm?
Wouldn't the PID be more useful so you could actually associate it with
a task?


