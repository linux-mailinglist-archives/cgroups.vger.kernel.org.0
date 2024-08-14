Return-Path: <cgroups+bounces-4285-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BABD995264E
	for <lists+cgroups@lfdr.de>; Thu, 15 Aug 2024 01:47:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 53A13B217D8
	for <lists+cgroups@lfdr.de>; Wed, 14 Aug 2024 23:47:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C5D614A61E;
	Wed, 14 Aug 2024 23:47:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="vYvHjkeI"
X-Original-To: cgroups@vger.kernel.org
Received: from out-188.mta1.migadu.com (out-188.mta1.migadu.com [95.215.58.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DA8D39FE5
	for <cgroups@vger.kernel.org>; Wed, 14 Aug 2024 23:47:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723679239; cv=none; b=VNEBFW01uY1vXlZYS7s/O5PO7fqnDqefaN3K0dRkERy0qqxFonfTWKUbIwqPtTlql3ckqE2a2RtklrV1UdBv68kp3obHBghSTazRj/WjoNZZeEh3tS/9tOi6k9C+iyk8FEyMyICUM/45SPj9BpX0uIgq2d4KcKy8NdaIhjBIkBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723679239; c=relaxed/simple;
	bh=akyWnb8XtSM+K4RMyiYNItd+nb1RFuJVXeBA6Yz/2FY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C076OHsENBnSbPrgAyCt39pO9xRRWHE0cp7tIArDS8mKU2nPla/lxsRaC9oRjBljKdSezHz1I/qN6Yu51syUSE5u/V4MjKO9QG8i7ZaXePHe/IBVsFzoZYhGeGEId865spk1pMuTzTKugJec/iqs4Xp/lX9id28FIHu2X5sk4ng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=vYvHjkeI; arc=none smtp.client-ip=95.215.58.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Wed, 14 Aug 2024 16:47:10 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1723679234;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Jg+s4mYzcdav/XM5wUxFRJ/VTK1SLADq2GMhI8NVFig=;
	b=vYvHjkeIzOd9u2FtJot7z+v8W/8RcvA86Zm0RxrNUdZvYUMV6N+0cBiqXzQLKb7mncY91h
	LvDOX7VhoIWN+CMT+8V5xpxeW1J37rZ8PLOcBOtZd1YQ/HJGgrQ12Tcjj9rd2MYBjBiry7
	LLYDXxaRXlqSm/28keYycwFmST7uLC8=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: "T.J. Mercier" <tjmercier@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Muchun Song <muchun.song@linux.dev>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, Meta kernel team <kernel-team@meta.com>, cgroups@vger.kernel.org
Subject: Re: [PATCH v2 3/4] memcg: initiate deprecation of oom_control
Message-ID: <ed3r5qqldjzhpvt2jmygaly6zdhksz4hpknd3v2avufyi5fpep@e7dzdumnczzv>
References: <20240814220021.3208384-1-shakeel.butt@linux.dev>
 <20240814220021.3208384-4-shakeel.butt@linux.dev>
 <CABdmKX3cqsFBe3dA2P3MrNjFbwg4zH9wLuE=W0FrzuT0cOiY7A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CABdmKX3cqsFBe3dA2P3MrNjFbwg4zH9wLuE=W0FrzuT0cOiY7A@mail.gmail.com>
X-Migadu-Flow: FLOW_OUT

On Wed, Aug 14, 2024 at 03:58:03PM GMT, T.J. Mercier wrote:
> On Wed, Aug 14, 2024 at 3:00 PM Shakeel Butt <shakeel.butt@linux.dev> wrote:
> >
> > The oom_control provides functionality to disable memcg oom-killer,
> > notifications on oom-kill and reading the stats regarding oom-kills.
> > This interface was mainly introduced to provide functionality for
> > userspace oom-killers. However it is not robust enough and only supports
> > OOM handling in the page fault path.
> >
> > For v2, the users can use the combination of memory.events notifications
> > and memory.high interface to provide userspace OOM-killing functionality.
> 
> Might be worth it to mention PSI here too for userspace OOM-killing?
> (It's what LMKD does for Android.)

I think Andrew will fix the commit messages for others, let me request
to replace the first sentence of this paragraph with the following text.

"For v2, the users can use the combination of memory.events
notifications, memory.high and PSI to provide userspace OOM-killing
functionality. Actually LMKD in Android and OOMd in systemd and Meta
infrastructure already uses PSI with combination of other stats to
implement userspace OOM-killing."

> 
> > Let's start the deprecation process for v1 and gather the info on how
> > the current users are using this interface and work on providing a more
> > robust functionality in v2.
> >
> > Signed-off-by: Shakeel Butt <shakeel.butt@linux.dev>
> 
> Reviewed-by: T.J. Mercier <tjmercier@google.com>

Thanks


