Return-Path: <cgroups+bounces-5307-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6935A9B41CD
	for <lists+cgroups@lfdr.de>; Tue, 29 Oct 2024 06:26:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 17EAD1F22BE7
	for <lists+cgroups@lfdr.de>; Tue, 29 Oct 2024 05:26:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3B0B200C8C;
	Tue, 29 Oct 2024 05:26:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="sqg5mRSb"
X-Original-To: cgroups@vger.kernel.org
Received: from out-181.mta0.migadu.com (out-181.mta0.migadu.com [91.218.175.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 472F11DE885
	for <cgroups@vger.kernel.org>; Tue, 29 Oct 2024 05:25:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730179563; cv=none; b=J/ENPumDaXsGI6+h8SdJMCpCaHiJpS9Vxfwt+Gho8QimbfNSDLVFdEqssjiJtFkiWNp7R1rP1BqBYi5+13moOa7DVUH4LmPOHKhp2fYh7VKu/AfzhNkyhgKZjm+unJnWmaEu2WKpMqArbGPK9jNTWFuhVqPQQd/Pmy5a0WW7Rt8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730179563; c=relaxed/simple;
	bh=6TUhlhMYLExKjDwQ59dS2Gh0NeBWXv+bfTze4QDe1TA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pgAvB3ouPrQw30irmgbcf24C8F5PHeKCED4LLNqrCt02tHZehmiwoF2+eRuxURWT9NJGY/NCOFgQe9iedwRNTll7834dlCJHM1AdVdK8+0vDhmJ+YmVDGoCLFdGWxMBVFxE1SfcdZvr7nryeCD3jKwsyvVp1RTzeNCII28+Q3eY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=sqg5mRSb; arc=none smtp.client-ip=91.218.175.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Mon, 28 Oct 2024 22:25:49 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1730179556;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=cczi4B464f+4dMcCOiT1XTzY1LQrx0bbF4AUX4Jkwis=;
	b=sqg5mRSbCqk3sNnUSHmKmDyMlPwyH5r2Lm5uwwBDPmoFeW+RJWw6mOHzGkM7J0DpR+XBCI
	C+vAOFxEip78HBwCYpN2C3iUAChCaXw1QDK8FTCNFSCXe9CXBh9GUByEzWwwuCBLwKIa9f
	zo3mE1UJoHQ0OmpWWZ4bF1IRwIAximQ=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: JP Kobryn <inwardvessel@gmail.com>
Cc: hannes@cmpxchg.org, yosryahmed@google.com, akpm@linux-foundation.org, 
	rostedt@goodmis.org, linux-mm@kvack.org, cgroups@vger.kernel.org
Subject: Re: [PATCH 1/2 v3] memcg: rename do_flush_stats and add force flag
Message-ID: <kc2ojptuyp4sla26j2fffzjtxmr4bfarer2vtdroneujnvct6h@h6rgxvzgn7ya>
References: <20241029021106.25587-1-inwardvessel@gmail.com>
 <20241029021106.25587-2-inwardvessel@gmail.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241029021106.25587-2-inwardvessel@gmail.com>
X-Migadu-Flow: FLOW_OUT

On Mon, Oct 28, 2024 at 07:11:05PM GMT, JP Kobryn wrote:
> Change the name to something more consistent with others in the file and
> use double unders to signify it is associated with the
> mem_cgroup_flush_stats() API call. Additionally include a new flag that
> call sites use to indicate a forced flush; skipping checks and flushing
> unconditionally. There are no changes in functionality.
> 
> Signed-off-by: JP Kobryn <inwardvessel@gmail.com>

Acked-by: Shakeel Butt <shakeel.butt@linux.dev>

