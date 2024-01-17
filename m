Return-Path: <cgroups+bounces-1165-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ADDE6830D56
	for <lists+cgroups@lfdr.de>; Wed, 17 Jan 2024 20:39:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4A924281F58
	for <lists+cgroups@lfdr.de>; Wed, 17 Jan 2024 19:39:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BFF4249F3;
	Wed, 17 Jan 2024 19:39:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="orRxnePz"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 064D1249EE;
	Wed, 17 Jan 2024 19:39:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705520358; cv=none; b=pd2vhZP8rxuGdA+C2mFoTJZhgr6V2xEE26+FCAtnIuJyadOppmR82rj8ECoNsr3A08jRdxPd1EMaeW2TrFKDooOZPDqnsGpsO7gsznYDuUNaWmyLlFme1cubixKjvIF2rf94L0pE9tWEW24OwZEWVT4WcIYFRA0qJ3syVogczPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705520358; c=relaxed/simple;
	bh=qqBJ5vug6dV0ozKgqcaIGBYDgv7KtCxfYMh7ZJ6Q26I=;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To; b=d9O6aY98py+MFcMJvI96EppTKw8a/g8wsnjmCnkMLj3VJ6vbxDZ4PJlfCNBIlHgtyfZCGSnpaNdXeKcDXmAn1QZHUe/MzeZRUUq4YA4mRlC+cPaDvVTyTcgzOicxeSj3pM13SnpsR4+nnUaNrDiS1ZPqhRaY5OnDUnmnAKTaS+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=orRxnePz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E773BC43394;
	Wed, 17 Jan 2024 19:39:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705520357;
	bh=qqBJ5vug6dV0ozKgqcaIGBYDgv7KtCxfYMh7ZJ6Q26I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=orRxnePz8lKyXr+Shhml4pKgH35Jq98oR0yKMRCVSvRdPt89dqd8YD1EAaHH1FYAo
	 b1YS475T+RiWVkm65+l4ip+ukCfn8tdioNl9nx7fpInQeLqC9Nrzwn/lM2rZy8WKPj
	 nq8961EIaresqnhqe0wVGapP70T1nfuuMAZIjubxrsRn/dKoqMlDmIr0LdZh6q8lIK
	 8w7wMv9952y1yVGe8dIIeBKka/8Yag8C+MpbiU/3ksYdDz2CYgVJ0/eBB9qT4Y/DYl
	 Y2q71urfRZ3QKbHNM/0VzD/dSKy1cYDJv7gqZzC16eNsvtbxduiSLAEEbcEhbHg7A5
	 hBWLDtV0WGlzQ==
Date: Wed, 17 Jan 2024 11:39:15 -0800
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: Jeff Layton <jlayton@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	Shakeel Butt <shakeelb@google.com>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Michal Hocko <mhocko@kernel.org>, linux-kernel@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>, Tejun Heo <tj@kernel.org>,
	Vasily Averin <vasily.averin@linux.dev>,
	Michal Koutny <mkoutny@suse.com>, Waiman Long <longman@redhat.com>,
	Muchun Song <muchun.song@linux.dev>, Jiri Kosina <jikos@kernel.org>,
	cgroups@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH RFC 1/4] fs/locks: Fix file lock cache accounting, again
Message-ID: <20240117193915.urwueineol7p4hg7@treble>
References: <cover.1705507931.git.jpoimboe@kernel.org>
 <ac84a832feba5418e1b58d1c7f3fe6cc7bc1de58.1705507931.git.jpoimboe@kernel.org>
 <6667b799702e1815bd4e4f7744eddbc0bd042bb7.camel@kernel.org>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <6667b799702e1815bd4e4f7744eddbc0bd042bb7.camel@kernel.org>

On Wed, Jan 17, 2024 at 02:00:55PM -0500, Jeff Layton wrote:
> I'm really not a fan of tunables or different kconfig options,
> especially for something niche like this.
> 
> I also question whether this accounting will show up under any real-
> world workloads, and whether it was just wrong to revert those patches
> back in 2021.
> 
> File locking is an activity where we inherently expect to block. Ideally
> we don't if the lock is uncontended of course, but it's always a
> possibility.
> 
> The benchmark that prompted the regression basically just tries to
> create and release a bunch of file locks as quickly as possible.
> Legitimate applications that do a lot of very rapid locking like this
> benchmark are basically non-existent. Usually the pattern is:
> 
>     acquire lock
>     do some (relatively slow) I/O
>     release lock
> 
> In that sort of scenario, is this memcg accounting more than just line
> noise? I wonder whether we should just bite the bullet and see whether
> there are any real workloads that suffer due to SLAB_ACCOUNT being
> enabled on these caches?

That's a good point.  If the microbenchmark isn't likely to be even
remotely realistic, maybe we should just revert the revert until if/when
somebody shows a real world impact.

Linus, any objections to that?

-- 
Josh

