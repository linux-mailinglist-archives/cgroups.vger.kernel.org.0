Return-Path: <cgroups+bounces-6204-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D1FCBA141EF
	for <lists+cgroups@lfdr.de>; Thu, 16 Jan 2025 20:03:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 071EA16A8B6
	for <lists+cgroups@lfdr.de>; Thu, 16 Jan 2025 19:03:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D12C222BAC8;
	Thu, 16 Jan 2025 19:03:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="TTVKiLzu"
X-Original-To: cgroups@vger.kernel.org
Received: from out-179.mta0.migadu.com (out-179.mta0.migadu.com [91.218.175.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0F891547E2
	for <cgroups@vger.kernel.org>; Thu, 16 Jan 2025 19:03:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737054198; cv=none; b=BIvugWnbBK3YwBFUMPA/u6KrBscDXFAcwJkcJ9JkdCq1eKrUSYpGOjZvu+NRIMFqTKUVbi9JKnzN17o0naqkNDcqT2yoISVt5WVMOwaDbhICkI1BleoqRTaoCChmrCNXT07U5uZlofQpD+Zx++Rh2s45iLCh/zH/XpfH3z5wJ3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737054198; c=relaxed/simple;
	bh=zoSOYX06rR/Ik6aIGiw1FA3cLgUwY/yyhp9z75AwAbk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V3VQKZRyY+eWxhJ27TUM1jpguDHh3lkpr2PdEq50e7gb/BgNsvgM0u2oEnW3aZToUZ3Fy69oQ4YnsHtx6rf58riIvhjUCy4vOsexy+qCJFRuGRZg4XZMbgqMUn/5poe3SBWCdsu4XSKeexDrq5pgjA+h3a04ce6MM51SZoGQXg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=TTVKiLzu; arc=none smtp.client-ip=91.218.175.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Thu, 16 Jan 2025 11:03:04 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1737054188;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PriwJ4U020CFEGM07Fm7VVqZv09ITbevlvcsDPyM08U=;
	b=TTVKiLzuzJuqjkY34Apdyf8KngJ61KEZTAW10B+lDiWgtTHkaPSrsIv3iS9KkS08t00mMx
	ggY4eaPsai5kMHbow6g4TOWvHJvPJ4T8/A7cp6ytsgZYYCQwh8gGxekyc17SjrkJ1ajRW8
	hYx5AMgaDkvqdpxxQAiif59kKf2NBY8=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
Cc: JP Kobryn <inwardvessel@gmail.com>, hannes@cmpxchg.org, 
	yosryahmed@google.com, akpm@linux-foundation.org, linux-mm@kvack.org, 
	cgroups@vger.kernel.org, Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH 0/9 RFC] cgroup: separate rstat trees
Message-ID: <p3auznfl34gg3f3igbohewpk5rjyge7oy5q6byiow7y64plgzu@wrp3wk6yvfut>
References: <20241224011402.134009-1-inwardvessel@gmail.com>
 <cenwdwpggezxk6hko6z6je7cuxg3irk4wehlzpj5otxbxrmztp@xcit4h7cjxon>
 <3wew3ngaqq7cjqphpqltbq77de5rmqviolyqphneer4pfzu5h5@4ucytmd6rpfa>
 <gn5itb2kpffyuqzqwlu6e2qtkhsvbo2bif7d6pcryrplq25t3r@ytndeykgtkf3>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <gn5itb2kpffyuqzqwlu6e2qtkhsvbo2bif7d6pcryrplq25t3r@ytndeykgtkf3>
X-Migadu-Flow: FLOW_OUT

Hi Michal,

On Thu, Jan 16, 2025 at 04:19:07PM +0100, Michal Koutný wrote:
> Hello.
> 
> On Mon, Jan 13, 2025 at 10:25:34AM -0800, Shakeel Butt <shakeel.butt@linux.dev> wrote:
> > > and flushing efffectiveness depends on how individual readers are
> > > correlated, 
> > 
> > Sorry I am confused by the above statement, can you please expand on
> > what you meant by it?
> > 
> > > OTOH writer correlation affects
> > > updaters when extending the update tree.
> > 
> > Here I am confused about the difference between writer and updater.
> 
> reader -- a call site that'd need to call cgroup_rstat_flush() to
> 	calculate aggregated stats
> writer (or updater) -- a call site that calls cgroup_rstat_updated()
> 	when it modifies whatever datum
>

Ah so writer and updater are same.

> By correlated readers I meant that stats for multiple controllers are
> read close to each other (time-wise). First such a reader does the heavy
> lifting, consequent readers enjoy quick access.
> (With per-controller flushing, each reader would need to do the flush
> and I'm suspecting the total time non-linear wrt parts.)

This is a good point and actually in prod we are observing machines with
very active workloads, the close readers of different stats are flushing
all the subsystems even when reads are very close-by time-wise. In
addition there are users who are only reading non-memory stats and still
paying the cost of memory flushing. Please note that memory stats
flushing is the most expensive one at the moment and it does not make
sense to do flush memory stats for above two cases.

> 
> Similarly for writers, if multiple controller's data change in short
> window, only the first one has to construct the rstat tree from top down
> to self, the other are updating the same tree.

Another good point. From my observation, the cost of rstat tree
insertion is very cheap and the cost get amortized i.e. a lot of updates
within flushes such that the insertion cost is not noticeable at all, at
least in the perf traces.

> 
> > In-kernel memcg stats readers will be unaffected most of the time with
> > this change. The only difference will be when they flush, they will only
> > flush memcg stats.
> 
> That "most of the time" is what depends on how other controller's
> readers are active.
> 
> > Here I am assuming you meant measurements in terms of cpu cost or do you
> > have something else in mind?
> 
> I have in mind something like Tejun's point 2:
> | 2. It has noticeable benefits in the targeted use cases.
> 
> The cover letter mentions some old problems (which may not be problems
> nowadays with memcg flushing reworks) and it's not clear how the
> separation into per-controller trees impacts (today's) problems.
> 
> (I can imagine if the problem is stated like: io.stat readers are
> unnecessarily waiting for memory.stat flushing, the benefit can be shown
> (unless io.stat readers could benefit from flushing triggered by e.g.
> memory).  But I didn't get if _that_ is the problem.)
> 

The cover letter of v2 has more information on the motivation. The
main motivation is the same I descrived above i.e. many applications
(stat monitors) has to flush all the subsystem even when they are
reading different subsystem stats close-by and then there are
applications who are reading just stats of cpu or io and still have to
pay for memcg stat flushing. This series is targeting these two very
common scenarios.

Thanks Michal for your time and comments.

Shakeel


