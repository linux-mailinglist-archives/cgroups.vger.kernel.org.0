Return-Path: <cgroups+bounces-3417-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AF13991AF3D
	for <lists+cgroups@lfdr.de>; Thu, 27 Jun 2024 20:45:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6922F287AD4
	for <lists+cgroups@lfdr.de>; Thu, 27 Jun 2024 18:45:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E4DD2869B;
	Thu, 27 Jun 2024 18:45:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="et2V3hO5"
X-Original-To: cgroups@vger.kernel.org
Received: from out-175.mta0.migadu.com (out-175.mta0.migadu.com [91.218.175.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C5DC18054
	for <cgroups@vger.kernel.org>; Thu, 27 Jun 2024 18:45:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719513926; cv=none; b=nMzbwuPUtaM8tpDDLz7IuyOaegIcFH9628xArG7YTDfvvTF3xTeviWcbD30MNXn5+hbmCEDgV7yzo01cmmfnAdk0qbN9NWYpgn5a/ioj0NYBD7kjVQtmix86QTdR792sotFxfPttQPgwF7+RjncOaqFN3uo8S973p/v293Hq2oY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719513926; c=relaxed/simple;
	bh=Dsa8mn/EgpKUWQxIt8mRJdK3pZ2l0YPsiLsi+ebTsDk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pMADO+yeUYQU+TgGY5bB0wzhU5NwWZH8ZfiubQMQzWiH9D1g9ojodXPszbqbHPoYyINzqHvPkmWCygFowVhx5lH1fXNfohP5taOdBzPYTGD92cN2i3W23WtqTPvz53gIDHbSu0cI+P3PJ7+h5pv338MolEPBhL9OnhtxFXCXoa4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=et2V3hO5; arc=none smtp.client-ip=91.218.175.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: yosryahmed@google.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1719513922;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dgmx3yNno1fsFcSCb4lnzQMpdWaPdOGLHAqvKqTAmUQ=;
	b=et2V3hO5MdtXYQFgY/laYemN0Gwn3cG/qxWzxlDrlShaeVGMQPv7ynMBQdDUx47z+b95mg
	FocWpUYAd0a1mEp6asE1oU2klKTNDPj7cVfSn99M24bnUSjxMufA6HrgXhRr9qXTe3UAwD
	ymYIJAb5Qfv/BhbuBhvGkSVRzEqhsyw=
X-Envelope-To: hawk@kernel.org
X-Envelope-To: tj@kernel.org
X-Envelope-To: cgroups@vger.kernel.org
X-Envelope-To: hannes@cmpxchg.org
X-Envelope-To: lizefan.x@bytedance.com
X-Envelope-To: longman@redhat.com
X-Envelope-To: kernel-team@cloudflare.com
X-Envelope-To: linux-mm@kvack.org
X-Envelope-To: linux-kernel@vger.kernel.org
Date: Thu, 27 Jun 2024 11:45:17 -0700
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Yosry Ahmed <yosryahmed@google.com>
Cc: Jesper Dangaard Brouer <hawk@kernel.org>, tj@kernel.org, 
	cgroups@vger.kernel.org, hannes@cmpxchg.org, lizefan.x@bytedance.com, longman@redhat.com, 
	kernel-team@cloudflare.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V3 2/2] cgroup/rstat: Avoid thundering herd problem by
 kswapd across NUMA nodes
Message-ID: <f4hbugpz5fudmiooxe73dbcbmi4stufm3msu4j37atv2feqhc6@ywai42srcwto>
References: <171943667611.1638606.4158229160024621051.stgit@firesoul>
 <171943668946.1638606.1320095353103578332.stgit@firesoul>
 <CAJD7tkbBpPqFW5fhmhcwDAfrze+aj8xFCF+3S4egBfipA4zKgQ@mail.gmail.com>
 <CAJD7tkYFKTA7aLcBE=X0jA1vKG_V+6Z-HstJRnnNrvMnjnLzHw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJD7tkYFKTA7aLcBE=X0jA1vKG_V+6Z-HstJRnnNrvMnjnLzHw@mail.gmail.com>
X-Migadu-Flow: FLOW_OUT

On Thu, Jun 27, 2024 at 04:32:03AM GMT, Yosry Ahmed wrote:
> On Thu, Jun 27, 2024 at 3:33 AM Yosry Ahmed <yosryahmed@google.com> wrote:
[...]
> >
> > The reason why I suggested that the completion live in struct cgroup
> > is because there is a chance here that the flush completes and another
> > irrelevant flush starts between reading cgrp_rstat_ongoing_flusher and
> > calling wait_for_completion_interruptible_timeout().

Yes this can happen if flusher for irrelevant cgroup calls
reinit_completion() while the initial flusher was just about to call
wait_for_completion_interruptible_timeout().

> >
> > This will cause the caller to wait for an irrelevant flush, which may
> > be fine because today the caller would wait for the lock anyway. Just
> > mentioning this in case you think this may happen enough to be a
> > problem.
> 
> Actually, I think this can happen beyond the window I described above.
> I think it's possible that a thread waits for the flush, then gets
> woken up when complete_all() is called, but another flusher calls
> reinit_completion() immediately. The woken up thread will observe
> completion->done == 0 and go to sleep again.

I don't think it will go to sleep again as there is no retry.

> 
> I think most of these cases can be avoided if we make the completion
> per cgroup. It is still possible to wait for more flushes than
> necessary, but only if they are for the same cgroup.

Yeah, per-cgroup completion would avoid the problem of waiting for
irrelevant flush.

