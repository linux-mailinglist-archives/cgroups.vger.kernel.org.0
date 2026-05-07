Return-Path: <cgroups+bounces-15664-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eL8IH5Wq/GkNSgAAu9opvQ
	(envelope-from <cgroups+bounces-15664-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Thu, 07 May 2026 17:07:01 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 722BE4EAC8A
	for <lists+cgroups@lfdr.de>; Thu, 07 May 2026 17:06:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9751130164A5
	for <lists+cgroups@lfdr.de>; Thu,  7 May 2026 15:05:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EE773EFD10;
	Thu,  7 May 2026 15:05:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="u51376P+"
X-Original-To: cgroups@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDD6E36C9C5;
	Thu,  7 May 2026 15:05:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778166340; cv=none; b=GDIMS5PqpwTmFFd5DLet5xlSBk+gXlCkjPTRhtBdl0jB/P45kpK5jtcvuZdNNiOtfxmKWgiZIa5haiSnkfoJ58OF7I+pP4yxfwSLz6U5plCWbG4Qq36fvdDCfA38eTmnllZhwdbSbMrjEy2jynzKspBdrst8GzO4yKEP8BJTvGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778166340; c=relaxed/simple;
	bh=qkBoHozc44HpTN5tQJk7T0vNUWZeZcpWs6M+yn1gR6A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A/xWe/OT+aoOVSSIbLyT/NdRsp6bpQqq8kxZPO0j6Hny6ac4ATZY1VNsd0uE4hYKswGYnMH8dAY7688/IDsLnNJr/++tA3HK1X2HJgiB0j13qZEc/qhUgo5OM7Hy7tmLRJbLc9fHtIIe8lhdwh7kmXsChJ69J78FueHkQky6GoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=u51376P+; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=39VxFpEAHecfGYlDccRjCltpyqp6gGuw8hPN61KeTfg=; b=u51376P+FL/YzSuAHw8mHhm5k0
	iU7tO+f1FcOZ9FIHMhNFsIJBvN62+GPFFXzz6iPxJgC8siHE2bQ4/+kZwbukuFhm4K/IryVslGCSu
	3sJ/k9V36FX9padXcvrm0FYYwL8pIr68bIKQIz/mvf1ux2SohZF0kJKFCOjEfX3W8f1nn//oueI86
	1K61jspPD6dHmYK0boihOaD2LkiDj3LqvPnLjAvVQh7pElUE9Udt8WrKtDf3XQnlA2TI7VFuBXts9
	n392EliBJNFFkiMplU3SqE6ancjk2+431lo09TnwR53amW32foQ4pgxqTnFjmchic8Fg04RaT9GtZ
	LJLA058w==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wL0I3-00000002ye4-3fEh;
	Thu, 07 May 2026 15:05:28 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id C3C75301261; Thu, 07 May 2026 17:05:26 +0200 (CEST)
Date: Thu, 7 May 2026 17:05:26 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Juri Lelli <juri.lelli@redhat.com>
Cc: Tejun Heo <tj@kernel.org>, Yuri Andriaccio <yurand2000@gmail.com>,
	Ingo Molnar <mingo@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	linux-kernel@vger.kernel.org,
	Luca Abeni <luca.abeni@santannapisa.it>,
	Yuri Andriaccio <yuri.andriaccio@santannapisa.it>,
	hannes@cmpxchg.org, mkoutny@suse.com, cgroups@vger.kernel.org
Subject: Re: [RFC PATCH v5 20/29] sched/deadline: Allow deeper hierarchies of
 RT cgroups
Message-ID: <20260507150526.GL3126523@noisy.programming.kicks-ass.net>
References: <20260430213835.62217-1-yurand2000@gmail.com>
 <20260430213835.62217-21-yurand2000@gmail.com>
 <20260505151523.GF3102624@noisy.programming.kicks-ass.net>
 <afpLir8tD0Ycb3D8@slm.duckdns.org>
 <20260507105331.GQ1026330@noisy.programming.kicks-ass.net>
 <afypzfyH0M7Rcge2@jlelli-thinkpadt14gen4.remote.csb>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <afypzfyH0M7Rcge2@jlelli-thinkpadt14gen4.remote.csb>
X-Rspamd-Queue-Id: 722BE4EAC8A
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[infradead.org,none];
	R_DKIM_ALLOW(-0.20)[infradead.org:s=casper.20170209];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-15664-lists,cgroups=lfdr.de];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,redhat.com,linaro.org,arm.com,goodmis.org,google.com,suse.de,vger.kernel.org,santannapisa.it,cmpxchg.org,suse.com];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[infradead.org:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[peterz@infradead.org,cgroups@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[noisy.programming.kicks-ass.net:mid,infradead.org:dkim]
X-Rspamd-Action: no action

On Thu, May 07, 2026 at 05:03:41PM +0200, Juri Lelli wrote:
> On 07/05/26 12:53, Peter Zijlstra wrote:
> > On Tue, May 05, 2026 at 09:56:58AM -1000, Tejun Heo wrote:
> 
> ...
> 
> > > - However, the cpu controller is a threaded controller which means that it
> > >   can have threaded sub-hierarchy where the no-internal-process rule doesn't
> > >   apply. This was created explicitly for cpu controller. The proposed change
> > >   blocks it effectively forcing cpu controller into regular domain
> > >   controller behavior subject to no-internal-process rule. Note these are
> > >   enforced at controller granularity and this means that users who use the
> > >   threaded mode will be forced to pick between the two.
> > 
> > Right... this then means we need two controls, one to do hierarchical
> > bandwidth distribution, and one to assign bandwidth to the internal
> > group -- which is then subject to its own bandwidth distribution
> > constraint.
> > 
> > This might be a little confusing, but there is no way around that
> > AFAICT.
> 
> Just to check if I'm following, you are thinking something like below?
> 
> groupA/
>   cpu.rt.max = "50 50 100"       <- 0.5 from root
>   cpu.rt.internal = "20 20 100"  <- 0.2 from groupA for threads at this
>                                         level
>   + threadA                               <
>   + threadB                               <
>   +- group1/
>        cpu.rt.max = "30 30 100"  <- 0.3 from groupA
>        + threadC
> 
> And we still keep it flat, so 2 dl-entities (per CPU), one handles
> threads at groupA level and the other threads inside group1?

Exactly!

