Return-Path: <cgroups+bounces-9994-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 76A41B534BF
	for <lists+cgroups@lfdr.de>; Thu, 11 Sep 2025 16:00:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 68A0D7A5FBF
	for <lists+cgroups@lfdr.de>; Thu, 11 Sep 2025 13:59:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98A6F3314CB;
	Thu, 11 Sep 2025 14:00:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="CEoAUwYL"
X-Original-To: cgroups@vger.kernel.org
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06DE41DDC2A;
	Thu, 11 Sep 2025 14:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757599233; cv=none; b=tc5K96kUH/E2JqQv5dYlwYF+KlzXiYwtn03ty+1s293bSQjYqrIHrC9wAPpfVV5zddy1uFL1y22fXGpeCvt85NkCVk2iYglazc2wzxIkdBXzi4OUtwFhkpIF00qodWoMAUgwKJUm5I7hNU8CU6Tj4A7WULWYswK43VNAEeZweL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757599233; c=relaxed/simple;
	bh=55zpazCCMP2oFH25Rqs2CNOCEeUKaRY0T3UNFZs9Zeo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lQcfLUDz9KHZV9nQtPda7C2vvDPzkZ1yctJ+zbiIbQMKXYgA8uO283DdhAIJT8S5cXownoD8vJxqu56Kgz3cvcGx2JCnbYS5rkKO4YOb18m42HK3qfph9h4fUlxfxDHmNJRYjZdh6PxcPgRaE3/yShLmFL5zZ97mO1mqZgx5LPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=CEoAUwYL; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=+lPlOJZkhxv3+mEYGk4dl29iQABbroVsY9HmEsd9duw=; b=CEoAUwYLN8Qen8sLT8D+l4Cc8x
	ABgubo7fBj/ch+9Ic5/gpegVOK112RyN0U/4QPYBeqgGNZTBYX7kJuNdvsnetcmO8y6vCO5z/xcUt
	c7ARxyrV6QZrmqiDufg7UBqys9FV43iH1SrTt6nPBr5TRjVJhMJwn7FmFSGFIsWdO19QmSIn0gwyg
	YjvnWtoke/BqIHyQmsOALTOSNHGkDw8somAgdWAiq/xmF898D6YC+pIKpq9r9eXpbw9pLKWC/Y343
	Fo/eKyGhT/ANuYCXirQ0zyXEz0/L8+i7zXJMzVgCei0UedNKGfXaTW23OH6sUbhy2YCKJbb5+qTx4
	5ojqLuEw==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uwhqY-00000006616-34V1;
	Thu, 11 Sep 2025 14:00:23 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 494CA300579; Thu, 11 Sep 2025 16:00:22 +0200 (CEST)
Date: Thu, 11 Sep 2025 16:00:22 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Andrea Righi <arighi@nvidia.com>
Cc: tj@kernel.org, linux-kernel@vger.kernel.org, mingo@redhat.com,
	juri.lelli@redhat.com, vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
	mgorman@suse.de, vschneid@redhat.com, longman@redhat.com,
	hannes@cmpxchg.org, mkoutny@suse.com, void@manifault.com,
	changwoo@igalia.com, cgroups@vger.kernel.org,
	sched-ext@lists.linux.dev, liuwenfang@honor.com, tglx@linutronix.de
Subject: Re: [PATCH 00/14] sched: Support shared runqueue locking
Message-ID: <20250911140022.GP4067720@noisy.programming.kicks-ass.net>
References: <20250910154409.446470175@infradead.org>
 <aMG2HAWhgAYBdh6Q@gpd4>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aMG2HAWhgAYBdh6Q@gpd4>

On Wed, Sep 10, 2025 at 07:32:12PM +0200, Andrea Righi wrote:

> Reproducer:
> 
>  $ cd tools/sched_ext
>  $ make scx_simple

FWIW, I only have one machine where this works. Most of my machines this
results in an endless stream of build fail; same for the selftest stuff.

No clues given, just endless build fail :-(

