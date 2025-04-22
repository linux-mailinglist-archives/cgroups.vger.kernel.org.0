Return-Path: <cgroups+bounces-7725-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A7118A97163
	for <lists+cgroups@lfdr.de>; Tue, 22 Apr 2025 17:41:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2AAEF16E2D2
	for <lists+cgroups@lfdr.de>; Tue, 22 Apr 2025 15:40:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D21028FFC7;
	Tue, 22 Apr 2025 15:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="G0+EygSy"
X-Original-To: cgroups@vger.kernel.org
Received: from out-186.mta0.migadu.com (out-186.mta0.migadu.com [91.218.175.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5B3128CF4D
	for <cgroups@vger.kernel.org>; Tue, 22 Apr 2025 15:40:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745336424; cv=none; b=VFrdcDRkV8f0H9PZPPjjhfPEPv+V7ZdvVvUsdYEB0vgDQGj+30wPm3iwTA8eJ4S2FUnaoDRRzmr2MRRtWCYA5bcRPdlCq8OTloVqyDLnCRRhQAuc0z2Qjdxjg1XWJchpi3AAamZU6of7KR0MUjN+JO6nSa0H2BXCoEtnSHC1UHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745336424; c=relaxed/simple;
	bh=PbDfsooWdFXkU7zHfiYQ+cHc963EyHKQ0wmg+QDHF6E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WEFGjOxddgpbOHmWvxv8pxpU7N1CHzD9oKPz9uj0gzNawhaYWEdMBuKF5FlYLdHR+lIlgQQNS45zOOyIDYvX1o6c1eU03Z4v1Qvts0s3xQ/OwjJ0csUi5lXlsZIXrN0hkLWLQZkvhQd9kxcDzJMNGf5YuHNHe7hd0aT9pX0O4YQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=G0+EygSy; arc=none smtp.client-ip=91.218.175.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Tue, 22 Apr 2025 08:40:14 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1745336419;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bsy5PJS41mGhoO54IOukmg7Bo8GKSd/BSVXvRDM5VnM=;
	b=G0+EygSywRwQUvJGbgX4OaUmUPOV5m9AyREzpvvQmABa7jQmA7ybaYemI9lWJYsdSiq6vm
	M6RsrgW+BeXi/rkjR9sarP/fQdFHgcj+rwDbKA2shRRPqB+y9QNibNa2RdQ3nGpiA0NjFw
	MCLOonU8x4YaRJAck7T5pP/xExUiK7M=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Christian Brauner <brauner@kernel.org>
Cc: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Johannes Weiner <hannes@cmpxchg.org>, 
	Michal Hocko <mhocko@kernel.org>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Muchun Song <muchun.song@linux.dev>, Yosry Ahmed <yosry.ahmed@linux.dev>, Tejun Heo <tj@kernel.org>, 
	Greg Thelen <gthelen@google.com>, linux-mm@kvack.org, cgroups@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Meta kernel team <kernel-team@meta.com>
Subject: Re: [PATCH v2] memcg: introduce non-blocking limit setting option
Message-ID: <rha4tmnnrhncn2ryoml2hbu5hxt3qnbg2rurl6tkssnegrc5wn@isui3jn3cu4h>
References: <20250419183545.1982187-1-shakeel.butt@linux.dev>
 <20250422-daumen-ozonbelastung-93d90ca81dfa@brauner>
 <jqlq7y3bco4r3jpth23ymf7ghrtxbvc2kthvbqjahlkzsl4mik@euvvqaygeafd>
 <20250422-synergie-bauabschnitt-5f724f1d9866@brauner>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250422-synergie-bauabschnitt-5f724f1d9866@brauner>
X-Migadu-Flow: FLOW_OUT

On Tue, Apr 22, 2025 at 11:48:23AM +0200, Christian Brauner wrote:
> On Tue, Apr 22, 2025 at 11:31:23AM +0200, Michal Koutný wrote:
> > On Tue, Apr 22, 2025 at 11:23:17AM +0200, Christian Brauner <brauner@kernel.org> wrote:
> > > As written this isn't restricted to admin processes though, no? So any
> > > unprivileged container can open that file O_NONBLOCK and avoid
> > > synchronous reclaim?
> > > 
> > > Which might be fine I have no idea but it's something to explicitly
> > > point out 
> > 
> > It occurred to me as well but I think this is fine -- changing the
> > limits of a container is (should be) a privileged operation already
> > (ensured by file permissions at opening).
> > IOW, this doesn't allow bypassing the limits to anyone who couldn't have
> > been able to change them already.
> 
> Hm, can you explain what you mean by a privileged operation here? If I
> have nested containers with user namespaces with delegated cgroup tress,
> i.e., chowned to them and then some PID 1 or privileged container
> _within the user namespace_ lowers the limit and uses O_NONBLOCK then it
> won't trigger synchronous reclaim. Again, this might all be fine I'm
> just trying to understand.

I think Michal's point is (which I agree with) that if a process has the
privilege to change the limit of a cgroup then it is ok for that process
to use O_NONBLOCK to avoid sync reclaim. This new functionality is not
enabling anyone to bypass their limits.

In your example of PID 1 or privileged container, yes with O_NONBLOCK
the limit updater will not trigger sync reclaim but whoever is running
in that cgroup will eventually hit the sync reclaim in their next charge
request.

