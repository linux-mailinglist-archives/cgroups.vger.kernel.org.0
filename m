Return-Path: <cgroups+bounces-12233-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id E974CC92289
	for <lists+cgroups@lfdr.de>; Fri, 28 Nov 2025 14:40:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 74C8B34B343
	for <lists+cgroups@lfdr.de>; Fri, 28 Nov 2025 13:40:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA67A329E70;
	Fri, 28 Nov 2025 13:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="bp7E+5v4"
X-Original-To: cgroups@vger.kernel.org
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB7A1269D18;
	Fri, 28 Nov 2025 13:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764337232; cv=none; b=D5va4AUMGcx7kvPTHMdwDRyBiafbtISs/A+qbwma08XrU2jaXFzFK4C4NCfYG7k3zf6sEcShQKyYY3V0IlRXzn5Avw2Nc3SzA62SmO1MnTttY/tqTSp++2lbrJfKBTUdcCODO73WDMf+gYFCV2SaldkbgB9tqDACjWrPQQ2ZCbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764337232; c=relaxed/simple;
	bh=7oiRwdyCiQhwatgwdIYBAegsUsXyboXGEslYC632oGw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t1WhS2Fwt5ry+D3XtnDGZnaEwOJLANym5YrkPe5yYg5A5X1wx6JkNQzoj9UYyqr3VzXZURIWWXX/iUwcyUYyqWtNfVF4jv1BWbcXjFNjOYMX2m3MyxGl+OOT93JCRxklW00UJVH1grwS8QDCwJK0jYZWE4c1qKkCE3XfkpzLP38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=bp7E+5v4; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=NiSrZjpRPnOkVzJCaCOCfd+bSpL80h9UhEQJSOYXF1Q=; b=bp7E+5v489oUAvATA7u6yHLZ2g
	hI0ioYXw1ipjAFar26/PBIyFcRCzxAOIh3jdehIAtsqOc7J1qmyua8VrojvvlsvI7tMY9nOH9ND3Z
	G3Z+7Q2f4Ix68oOJWK1eTRe4wiIOG/TLFLV3+N/cgENKb6PNMdgnY+O1z5N35/uUnrNWl2methmeF
	AdIT/GUsir5A6l2e2L8tdqnpNn3ufWeNLCZOQRWA0qgK/55vzUHyoab7LRIyYwIZCMSICaRfmrK3e
	p4YF1ZNZAnXaDyrzIE+x10eWdF0sghDAwIzrTrSxl9sZJA5vRwTSeyrbOBaInNhymW41D0iR8GPup
	WswhKjrQ==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vOxqJ-0000000Bz2a-2tOw;
	Fri, 28 Nov 2025 12:44:56 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 0AC773002E3; Fri, 28 Nov 2025 14:40:17 +0100 (CET)
Date: Fri, 28 Nov 2025 14:40:17 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Aaron Lu <ziqianlu@bytedance.com>
Cc: xupengbo <xupengbo1029@163.com>, Ingo Molnar <mingo@redhat.com>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	David Vernet <void@manifault.com>, linux-kernel@vger.kernel.org,
	cgroups@vger.kernel.org
Subject: Re: [PATCH v5] sched/fair: Fix unfairness caused by stalled
 tg_load_avg_contrib when the last task migrates out.
Message-ID: <20251128134017.GL3245006@noisy.programming.kicks-ass.net>
References: <20250827022208.14487-1-xupengbo@oppo.com>
 <20251128115445.GA1526246@bytedance.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251128115445.GA1526246@bytedance.com>

On Fri, Nov 28, 2025 at 07:54:45PM +0800, Aaron Lu wrote:
> Hello,
> 
> On Wed, Aug 27, 2025 at 10:22:07AM +0800, xupengbo wrote:
> > When a task is migrated out, there is a probability that the tg->load_avg
> > value will become abnormal. The reason is as follows.
> > 
> > 1. Due to the 1ms update period limitation in update_tg_load_avg(), there
> > is a possibility that the reduced load_avg is not updated to tg->load_avg
> > when a task migrates out.
> > 2. Even though __update_blocked_fair() traverses the leaf_cfs_rq_list and
> > calls update_tg_load_avg() for cfs_rqs that are not fully decayed, the key
> > function cfs_rq_is_decayed() does not check whether
> > cfs->tg_load_avg_contrib is null. Consequently, in some cases,
> > __update_blocked_fair() removes cfs_rqs whose avg.load_avg has not been
> > updated to tg->load_avg.
> > 
> > Add a check of cfs_rq->tg_load_avg_contrib in cfs_rq_is_decayed(),
> > which fixes the case (2.) mentioned above.
> > 
> > Fixes: 1528c661c24b ("sched/fair: Ratelimit update to tg->load_avg")
> > Tested-by: Aaron Lu <ziqianlu@bytedance.com>
> > Reviewed-by: Aaron Lu <ziqianlu@bytedance.com>
> > Reviewed-by: Vincent Guittot <vincent.guittot@linaro.org>
> > Signed-off-by: xupengbo <xupengbo@oppo.com>
> 
> I wonder if there are any more concerns about this patch? If no, I hope
> this fix can be merged. It's a rare case but it does happen for some
> specific setup.
> 
> Sorry if this is a bad timing, but I just hit an oncall where this exact
> problem occurred so I suppose it's worth a ping :)

Totally missed it. Seems okay, let me go queue the thing.

