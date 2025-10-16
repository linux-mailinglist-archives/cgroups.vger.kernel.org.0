Return-Path: <cgroups+bounces-10797-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 27093BE1276
	for <lists+cgroups@lfdr.de>; Thu, 16 Oct 2025 03:11:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 13E0C4E78F2
	for <lists+cgroups@lfdr.de>; Thu, 16 Oct 2025 01:11:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2235C1FBE87;
	Thu, 16 Oct 2025 01:11:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="UjNeyfN1"
X-Original-To: cgroups@vger.kernel.org
Received: from out-185.mta0.migadu.com (out-185.mta0.migadu.com [91.218.175.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C53020322
	for <cgroups@vger.kernel.org>; Thu, 16 Oct 2025 01:11:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760577075; cv=none; b=JiDyGp/u57Kryoy6dIFMkVLZQczseP0NWtuXcZYsUb2Bi9KLFjOPlB1FnN3XJpMYAXYip3ZCQfxAlwlgXSkdLfsZG8WKNp5gQPCJBuvsri5qoQc3DNvbXczvLKvk2rREessfur6EqoxqSx/4Ol2hBqrmJJuP8nVNP14iBx4e7Ig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760577075; c=relaxed/simple;
	bh=9eWglOj1q+AvMecMj1okWvapeunhbN56i+AV+BTzGlg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=fnoEDnxQboXVqIjwBZgcWz0tuldB4NHLabvXabequoMVZ4NiERoNPCHkQ3QJ2OkOrJIEkNWAt7QDZqis2wjufjZJbTGKa0PIDISGKcqt1/cqSZO/pdVw0r/8bIKLgFgMAHglXpSkmnDi7kP9LungsCS41nTmiQEwdnxgzP1mhmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=UjNeyfN1; arc=none smtp.client-ip=91.218.175.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1760577060;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9eWglOj1q+AvMecMj1okWvapeunhbN56i+AV+BTzGlg=;
	b=UjNeyfN1lT1QbHQB+SBjn0crZxw3AICe3s9vXl69EmVdsbWMGRugblFUU+RtOSrApnbuYn
	qsCHcCG9o2C7orU+K/C7S5ix0iMllM0rqLx3c0zQqw3cXquoFBBCtvZMdJqdhRfToEAkVd
	8vY7AV0p6MJ6tuTF+BMvv/UuTc+Bd7M=
From: Roman Gushchin <roman.gushchin@linux.dev>
To: JP Kobryn <inwardvessel@gmail.com>
Cc: Shakeel Butt <shakeel.butt@linux.dev>,  andrii@kernel.org,
  ast@kernel.org,  mkoutny@suse.com,  yosryahmed@google.com,
  hannes@cmpxchg.org,  tj@kernel.org,  akpm@linux-foundation.org,
  linux-kernel@vger.kernel.org,  cgroups@vger.kernel.org,
  linux-mm@kvack.org,  bpf@vger.kernel.org,  kernel-team@meta.com,
  mhocko@kernel.org,  muchun.song@linux.dev
Subject: Re: [PATCH v2 0/2] memcg: reading memcg stats more efficiently
In-Reply-To: <e102f50a-efa5-49b9-927a-506b7353bac0@gmail.com> (JP Kobryn's
	message of "Wed, 15 Oct 2025 17:21:46 -0700")
References: <20251015190813.80163-1-inwardvessel@gmail.com>
	<uxpsukgoj5y4ex2sj57ujxxcnu7siez2hslf7ftoy6liifv6v5@jzehpby6h2ps>
	<e102f50a-efa5-49b9-927a-506b7353bac0@gmail.com>
Date: Wed, 15 Oct 2025 18:10:52 -0700
Message-ID: <87wm4v7isj.fsf@linux.dev>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Migadu-Flow: FLOW_OUT

JP Kobryn <inwardvessel@gmail.com> writes:

> On 10/15/25 1:46 PM, Shakeel Butt wrote:
>> Cc memcg maintainers.
>> On Wed, Oct 15, 2025 at 12:08:11PM -0700, JP Kobryn wrote:
>>> When reading cgroup memory.stat files there is significant kernel overhead
>>> in the formatting and encoding of numeric data into a string buffer. Beyond
>>> that, the given user mode program must decode this data and possibly
>>> perform filtering to obtain the desired stats. This process can be
>>> expensive for programs that periodically sample this data over a large
>>> enough fleet.
>>>
>>> As an alternative to reading memory.stat, introduce new kfuncs that allow
>>> fetching specific memcg stats from within cgroup iterator based bpf
>>> programs. This approach allows for numeric values to be transferred
>>> directly from the kernel to user mode via the mapped memory of the bpf
>>> program's elf data section. Reading stats this way effectively eliminates
>>> the numeric conversion work needed to be performed in both kernel and user
>>> mode. It also eliminates the need for filtering in a user mode program.
>>> i.e. where reading memory.stat returns all stats, this new approach allows
>>> returning only select stats.

It seems like I've most of these functions implemented as part of
bpfoom: https://lkml.org/lkml/2025/8/18/1403

So I definitely find them useful. Would be nice to merge our efforts.

Thanks!

