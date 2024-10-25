Return-Path: <cgroups+bounces-5246-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A6419AF68D
	for <lists+cgroups@lfdr.de>; Fri, 25 Oct 2024 03:16:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8C45C1C21271
	for <lists+cgroups@lfdr.de>; Fri, 25 Oct 2024 01:16:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41A23BA3D;
	Fri, 25 Oct 2024 01:16:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="qgNrtW3S"
X-Original-To: cgroups@vger.kernel.org
Received: from out-177.mta0.migadu.com (out-177.mta0.migadu.com [91.218.175.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26F23F4F1
	for <cgroups@vger.kernel.org>; Fri, 25 Oct 2024 01:16:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729818970; cv=none; b=j/tf0njC10uZdHDK6dHbHnEJB3UhcTNCjbyZXf6u/p5PMLnaDTU0LfGNqHMhhhQInuv+wfEGzuWj3FHVq8z2a62VAf3z7biwth33ocWVWYpK/1WqTDlzYrMaJEpsBQdsmBHIWzjM5p/26BAaKyVgdJ2xBkkc+4hNEgVmms51H0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729818970; c=relaxed/simple;
	bh=gr/Pxls69hQ/LlYqxrpWmB3yyFBYYMhJ0FWUhqClWIg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rI42KkWXhJgoK/+iMXKxF0k2G6qVhuLri/tnh1YtAPUF4L169egRLDyjTP7pGyExddMwBrKE6SvtLpv4FVlDo3YhWPulSB0m0/5dzfesJxmn+aHEBRInOWezENsKRMbd6PNay/+KupwPTyPIw//UlK6xBYxXPpKfgx0XipaHZeY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=qgNrtW3S; arc=none smtp.client-ip=91.218.175.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Thu, 24 Oct 2024 18:15:56 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1729818961;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nxGzqzSvBxam38nAAy8n3GTlcEwIEbCe+o8PfZM5Tuk=;
	b=qgNrtW3SxMsxkDnK0Izgk5oqlOwWMaaUt7JJnlNQz1EP9QjRMKl+21SWEMb1bvlxH7isY1
	qJvrYuLwSiltSgT+mE4Kq6YqSNWrvzKlJPopKIhMN3xEWabSTk3SgoQw+CO0Cm4+dFMPoN
	s8wYLUt5YBx7dpPXEMaS8GTH7Pwy+2Q=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Yosry Ahmed <yosryahmed@google.com>
Cc: JP Kobryn <inwardvessel@gmail.com>, hannes@cmpxchg.org, 
	akpm@linux-foundation.org, rostedt@goodmis.org, linux-mm@kvack.org, cgroups@vger.kernel.org
Subject: Re: [PATCH 2/2] memcg: use memcg flush tracepoint
Message-ID: <gujcp2vtzatyn73xmidsca25d24kmbtwa6cr52mjlsrxvm7cdf@vbgax2a67pwz>
References: <20241025002511.129899-1-inwardvessel@gmail.com>
 <20241025002511.129899-3-inwardvessel@gmail.com>
 <CAJD7tkZaMH04mBK649iHRhdTwRJh8teSOcc1mg=y8fRey2zHzA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJD7tkZaMH04mBK649iHRhdTwRJh8teSOcc1mg=y8fRey2zHzA@mail.gmail.com>
X-Migadu-Flow: FLOW_OUT

On Thu, Oct 24, 2024 at 05:57:25PM GMT, Yosry Ahmed wrote:
> On Thu, Oct 24, 2024 at 5:26 PM JP Kobryn <inwardvessel@gmail.com> wrote:
> >
> > Make use of the flush tracepoint within memcontrol.
> >
> > Signed-off-by: JP Kobryn <inwardvessel@gmail.com>
> 
> Is the intention to use tools like bpftrace to analyze where we flush
> the most? In this case, why can't we just attach to the fentry of
> do_flush_stats() and use the stack trace to find the path?
> 
> We can also attach to mem_cgroup_flush_stats(), and the difference in
> counts between the two will be the number of skipped flushes.
> 

All these functions can get inlined and then we can not really attach
easily. We can somehow find the offset in the inlined places and try to
use kprobe but it is prohibitive when have to do for multiple kernels
built with fdo/bolt.

Please note that tracepoints are not really API, so we can remove them
in future if we see no usage for them.

Thanks for the review,
Shakeel

