Return-Path: <cgroups+bounces-13144-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 013BAD18963
	for <lists+cgroups@lfdr.de>; Tue, 13 Jan 2026 12:53:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 7608B30022F6
	for <lists+cgroups@lfdr.de>; Tue, 13 Jan 2026 11:53:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61FAE38E13F;
	Tue, 13 Jan 2026 11:53:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="PAzpakrb"
X-Original-To: cgroups@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C871735B12B;
	Tue, 13 Jan 2026 11:53:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768305203; cv=none; b=ACkJGrHTyHaaLWafIFTstWFshfO3sxdDbT3zNHN5vKltmog/kzPjn3/M3mlAJHazt95Og5O4hhcu9Bw/W4JSX8q8XI3PfmK75nZl/Hj5YAV4pXxQei3+L3uXTP7dgD7UcnEPFzkAAwShcYkFFuaYWl8/XG91ZUvcRM+EZ7Al6Po=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768305203; c=relaxed/simple;
	bh=4iNbjDBs2icCIgq6xK30jbASGeYpwp9oMXBudnn31kA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b+yGuZaq9FeHHnOuywNzPg3MzNW+9pIxo6ou9fQSi1bZ13O8agEawy5PFADCiCVGVU1v8+4HN0YpbNvMX3qJ8ExWSXQQymU7WmhNpMrghankPj4tyDjWYAvkAWAnY4sfJVaHumy8ltqcDpT/edaBKtT/Q0AalEBXtLa4xNr7TL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=PAzpakrb; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=4iNbjDBs2icCIgq6xK30jbASGeYpwp9oMXBudnn31kA=; b=PAzpakrb+ARyBna4KP4ogfC85F
	6/e5cRV5Hj59QFSFTeReed0hlz1Vxb28l0PD2Jtx8862usNrkmh6RdFlbJq97UfEHj/wyQq3M6asV
	PuxrLFbMt3EGFHpGBWS0nCIDjthexHgKE3kJz1eE9klylixdfQydrbpBG9XwQZYEm/imtSwIKM/rs
	1xgZfkEcv3Gai8IO9WrAh+FhR9lMF4qDxjN7ZWC8t0ZmtWu/taMwfsNX7vi/lAjYa14aJCmedQ9HS
	XRECVpd6IelQARf4NBRV6cPslIyMmFFZRwq9pmrJBSa8x8SgvmgpzkSGRaBre7UaIzqkEDaWytO8X
	tdch/FFw==;
Received: from 2001-1c00-8d85-5700-266e-96ff-fe07-7dcc.cable.dynamic.v6.ziggo.nl ([2001:1c00:8d85:5700:266e:96ff:fe07:7dcc] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vfcxS-00000004fJh-3TrU;
	Tue, 13 Jan 2026 11:53:10 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id AF50C30049A; Tue, 13 Jan 2026 12:53:09 +0100 (CET)
Date: Tue, 13 Jan 2026 12:53:09 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: K Prateek Nayak <kprateek.nayak@amd.com>
Cc: Pierre Gondois <pierre.gondois@arm.com>, tj@kernel.org,
	linux-kernel@vger.kernel.org, mingo@kernel.org,
	juri.lelli@redhat.com, vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
	mgorman@suse.de, vschneid@redhat.com, longman@redhat.com,
	hannes@cmpxchg.org, mkoutny@suse.com, void@manifault.com,
	arighi@nvidia.com, changwoo@igalia.com, cgroups@vger.kernel.org,
	sched-ext@lists.linux.dev, liuwenfang@honor.com, tglx@linutronix.de,
	Christian Loehle <christian.loehle@arm.com>
Subject: Re: [PATCH 05/12] sched: Move sched_class::prio_changed() into the
 change pattern
Message-ID: <20260113115309.GB831050@noisy.programming.kicks-ass.net>
References: <20251006104402.946760805@infradead.org>
 <20251006104527.083607521@infradead.org>
 <ab9b37c9-e826-44db-a6b8-a789fcc1582d@arm.com>
 <caa2329c-d985-4a7c-b83a-c4f96d5f154a@amd.com>
 <717a0743-6d8f-4e35-8f2f-70a158b31147@arm.com>
 <ef8d8e46-06eb-46c1-9402-d292c2eb51f9@amd.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ef8d8e46-06eb-46c1-9402-d292c2eb51f9@amd.com>

On Tue, Jan 13, 2026 at 04:35:02PM +0530, K Prateek Nayak wrote:

> Does enabling WARN_DOUBLE_CLOCK warn of a double clock update before
> hitting this warning?

setup_new_dl_entity() -> update_rq_clock() seems like it will trip that
in this case.

