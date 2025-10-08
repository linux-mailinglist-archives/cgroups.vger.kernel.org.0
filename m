Return-Path: <cgroups+bounces-10607-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AF017BC56FA
	for <lists+cgroups@lfdr.de>; Wed, 08 Oct 2025 16:32:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7513C3C2E2B
	for <lists+cgroups@lfdr.de>; Wed,  8 Oct 2025 14:32:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85D1A2EAB9F;
	Wed,  8 Oct 2025 14:32:38 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from relay.hostedemail.com (smtprelay0013.hostedemail.com [216.40.44.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CE3E285C91;
	Wed,  8 Oct 2025 14:32:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759933958; cv=none; b=Isg6ZoTG4aAXTMFqE27nYwscAt5qvkXGVgrZ+kS/B9Qb/EkpMN/seYfU0u52rQ4b/JnoWV1c6q3Bo7fu1B1Pk4VqjdBhAaLwUy0cZn5htK0BHqrYwuJCIGYm/LiDY/4hyq2oX68RXAtwwN6sX758ugKFNYIz1/MrintVsN5b42w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759933958; c=relaxed/simple;
	bh=bB2GY1p9i6Et5/DYb+voLea94rf8Su1E0TtKQKVgfIM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=vFYNTUFqVzkQoKvha7et39uZtaf4aHxa7BHPK0xPtMqukPFQ+jG4r7pAHBQpy64kCz4441IFqXs+ju2cMXxLvAVxKEiZt+f90TpDtaOXbpfXwIwkqXz9pG0tA9idD85/TOAtzMwzAMMwpcWUp72jGcB1bsCBIjwoJzvUDbEh72k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf18.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay10.hostedemail.com (Postfix) with ESMTP id 275F6C0402;
	Wed,  8 Oct 2025 14:32:33 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf18.hostedemail.com (Postfix) with ESMTPA id E4FA92E;
	Wed,  8 Oct 2025 14:32:28 +0000 (UTC)
Date: Wed, 8 Oct 2025 10:34:22 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Juri Lelli <juri.lelli@redhat.com>, Peter Zijlstra
 <peterz@infradead.org>, tj@kernel.org, linux-kernel@vger.kernel.org,
 mingo@kernel.org, vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
 bsegall@google.com, mgorman@suse.de, vschneid@redhat.com,
 longman@redhat.com, hannes@cmpxchg.org, mkoutny@suse.com,
 void@manifault.com, arighi@nvidia.com, changwoo@igalia.com,
 cgroups@vger.kernel.org, sched-ext@lists.linux.dev, liuwenfang@honor.com,
 tglx@linutronix.de
Subject: Re: [PATCH 10/12] sched: Add locking comments to sched_class
 methods
Message-ID: <20251008103422.030756d3@gandalf.local.home>
In-Reply-To: <2025100838-undermine-zit-83b6@gregkh>
References: <20251006104402.946760805@infradead.org>
	<20251006104527.694841522@infradead.org>
	<aOTjSla1Yr3kz7op@jlelli-thinkpadt14gen4.remote.csb>
	<20251008070419.GR4067720@noisy.programming.kicks-ass.net>
	<2025100822-drained-foe-2426@gregkh>
	<aOYyOYrzoKDLCl7F@jlelli-thinkpadt14gen4.remote.csb>
	<2025100838-undermine-zit-83b6@gregkh>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: E4FA92E
X-Stat-Signature: ex6t73qw67kn4itbf7aws4rryykpr1ba
X-Rspamd-Server: rspamout02
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX18eyYKG2i5h4+nTHEgGSR5FxTO9ucKkG00=
X-HE-Tag: 1759933948-698019
X-HE-Meta: U2FsdGVkX19PYnlTLf9h5QpVxK49NxZzOAbOahTE88ot8JsSOzE9V4FiU93go8FUqsx9qnE1fxykgmLP69yUztsioxFqmL2LZlct/S7d3i0YJOoKpAq1Ppnwp9V+Tr8HQT5ay9m2fMHF3D40kkRCG0xU5jV0WGItZDJl8VOmsg0UmbqBUIsbLghKS9kelGho0vtyPLk9Xb8bN0huoXdU8JHzT7OJlWY1zryUwhdwxCP8zhtOVzE8f17/ulw8iWPxjuH9Ky3GJst4e8vtIAS2srbF4UG+1hTNJ9PpqutIxZ9Jmu9A9r5dSfIWRrmw5TT646rIQl7LLnv1GR6GXvPBBIAEjWFhZ7Y/bbidqwYUWmhCbaGc9gJSBxTtCtHB3PgU

On Wed, 8 Oct 2025 12:06:56 +0200
Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:

> The general answer is "you better know the copyright ownership
> information of the output of the tool you use" before you do anything
> with any of these tools.  Be careful about this, because adding your
> signed-off-by to a patch like makes it your responsibility :)

And there are a lot of copyright battles going on in courts wrt AI right
now. It's best to see how that plays out too.

> 
> After that, treat it like any other tool that you use to generate a
> patch, document what you used and why/how, and you should be fine.  You
> have to do this today if you were to use any type of tool, so in that
> way, "AI" is no different, with the exception of the ownership of the
> output result (again, consult the terms of the tool used.)
> 
> Hopefully documentation updates to our process documents will reflect
> this in the near future.

Yeah, I need to help Dave on that too.

Thanks for the reminder,

-- Steve

