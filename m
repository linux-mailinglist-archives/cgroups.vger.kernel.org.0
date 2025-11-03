Return-Path: <cgroups+bounces-11543-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A375C2E0C5
	for <lists+cgroups@lfdr.de>; Mon, 03 Nov 2025 21:38:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 313933AF661
	for <lists+cgroups@lfdr.de>; Mon,  3 Nov 2025 20:38:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8257E2C026A;
	Mon,  3 Nov 2025 20:38:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="SA4SnDMc"
X-Original-To: cgroups@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 215DF2BEC55;
	Mon,  3 Nov 2025 20:38:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762202290; cv=none; b=usT61abZNRk4NBrj3iEAFQaLmQ0AzgmTzeunnRzJsrVpBttsUrO05iqUYP009LswuFOdYwq8j/vs+qcWORbNsxBqHxz89drZXocWAM09CPuBc/Ukqk+HpsTjkeS+P79WKMsZcrQSMQMTdUEZE37PteZ2tQjLMkizOd5D7qiVTzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762202290; c=relaxed/simple;
	bh=d8F8UsdnvnUaoWsHfsOrnVhY0t5k0fgj3679PdZsIgw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fF5VCqwtYS+as0EDC2EYRDbKLNYau4mQn2JK7uzK/xzkG+yxsOtIIpoy9s4nNzB+BPU8KIAqb21E9YDQRMkmQALlc5Qv5dReXng8WRcLWgiGCCqYDaUno9T5mzcrpGpgk/CMtZGj4MjQkXxEBDeplhAIeMkMaCvGMc7C4ccmsYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=SA4SnDMc; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=HgugKP+2Af+SGnfyPg20MYT0WaZn1lZL22X8t1CwrtA=; b=SA4SnDMcf9d9Gy8fXmB6zQqsi0
	Kk9GK9ozxMCRr8OJPra4qeiXvL7IfOiR1mgZdp3LXzq36Kt7yzoRNZxFE+c8VApcB11LfM6nafl3K
	8v4U6c8kVfPFq4L9jkC5DAXl6GFuwvrLktEYAVHlFdsJ0NzAAsC6jhibbRi9buvSFeanqU5xa4NX9
	LDzylYByveQH+hiXHCTC6yW+t7h+ImDtEUE7OvDHVZhAbyGXPzPzBbNIsvuPuAL4VBPmaJ4ICxT8T
	35pTokqifFp3g7O+24qFKZOLlsixKuAkCs+lbCbkGDtX50RMrxH69Sq9zuWwWMEo/x28Fobfwp4IX
	leKFSl8A==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vG1JU-00000000AjS-2ENs;
	Mon, 03 Nov 2025 20:38:05 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 3D66D300230; Mon, 03 Nov 2025 21:38:05 +0100 (CET)
Date: Mon, 3 Nov 2025 21:38:05 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Tejun Heo <tj@kernel.org>
Cc: David Vernet <void@manifault.com>, Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>,
	Dan Schatzberg <dschatzberg@meta.com>, linux-kernel@vger.kernel.org,
	cgroups@vger.kernel.org, sched-ext@lists.linux.dev
Subject: Re: [PATCH v2 4/4] sched_ext: Fix cgroup exit ordering by moving
 sched_ext_free() to finish_task_switch()
Message-ID: <20251103203805.GH3245006@noisy.programming.kicks-ass.net>
References: <20251029061918.4179554-1-tj@kernel.org>
 <20251029061918.4179554-5-tj@kernel.org>
 <aQkPqUSMr5L0spd8@slm.duckdns.org>
 <20251103202843.GF3245006@noisy.programming.kicks-ass.net>
 <aQkRKC15ta5Wo-lU@slm.duckdns.org>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aQkRKC15ta5Wo-lU@slm.duckdns.org>

On Mon, Nov 03, 2025 at 10:31:36AM -1000, Tejun Heo wrote:
> Hello,
> 
> On Mon, Nov 03, 2025 at 09:28:43PM +0100, Peter Zijlstra wrote:
> > > @@ -5222,6 +5222,12 @@ static struct rq *finish_task_switch(str
> > >  		if (prev->sched_class->task_dead)
> > >  			prev->sched_class->task_dead(prev);
> > 
> > ^^^ can you not use task_dead_scx() ?
> 
> Unfortunately not. Because sched class switches are atomic infallible
> operations, all tasks in the system must be prepped on scheduler attach &
> fork regardless of their current sched class and thus have to be cleaned up
> in the same way on detach & exit.

Ah, I see scx_post_fork() and sched_ext_free^H^H^H^Hdead() effectively
duplicate the tasklist.

Oh well.

