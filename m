Return-Path: <cgroups+bounces-6044-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AE5F9A01016
	for <lists+cgroups@lfdr.de>; Fri,  3 Jan 2025 23:08:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B81E21880623
	for <lists+cgroups@lfdr.de>; Fri,  3 Jan 2025 22:08:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB4E11BBBC8;
	Fri,  3 Jan 2025 22:08:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MVCXXo8q"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77EB81BD9C2
	for <cgroups@vger.kernel.org>; Fri,  3 Jan 2025 22:08:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735942121; cv=none; b=fBQNrj8JDL91EUqpG2P5Mi7ReQJScE3Or820SbHmQVkC/ylkHw5S6eonM2XOBKpco18+bDe0gM13OpEBinfyOiJv/PSEgRNly/sFe9nI1WkayfWGOp0FiEhjyXGRaTL74A7yZ1yGSGaOfC3PH4Qd8OKeXkfLXiZyeKGYPKXLkuw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735942121; c=relaxed/simple;
	bh=z0IUODBzNUCfkmaZkBEcaHInVsvsGewoZ9K9C+Qw58Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WTC4AJIZykjVg87WURGmLQdOo0PPG8a/5WzwKblI6ZIX+/Lh1cjv40gb+dL9zDtQRyoMH9pHocq4NvUYi5LHW48sp5psETowOeSc0PCTl1gxB/UcS6D+yKVVHmZsKNHm//Ap1fW/Z8U7bOnJIpo9D5EFUhv3Q1PPMGA1Am6HcSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MVCXXo8q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3B43C4CECE;
	Fri,  3 Jan 2025 22:08:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1735942120;
	bh=z0IUODBzNUCfkmaZkBEcaHInVsvsGewoZ9K9C+Qw58Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MVCXXo8qbijgMJiVJjdi+tOp7fKoZMjcNnpd/ZKA0NTQOTF0cIpopgNnS/WcLD/iH
	 Dx5AALPAKSLi+txuOy8+siut8dRp27+Sea26gpN1WB4mFiW1aUMe2tp/lsn4A/4MTp
	 tab9Rp4F5tZhRhfSTTa/+tMTj3ZJMTRVhXThRKwksvYqcQ51gUrHS4x/ZrGeW9s1tq
	 NP34DKw/z5hg1bb22Xw5k0/6RIaYgP9d7vjikZXyZtG6ikohGl7YgMtN5jODkiqqGn
	 HdqqHL45uRz9n9PxHm5fWNRLSqXggYEAVYipYC+Vdw6WjEgr9PGbHE9w157zhTlVC9
	 PIdijT129JaXQ==
Date: Fri, 3 Jan 2025 12:08:39 -1000
From: Tejun Heo <tj@kernel.org>
To: JP Kobryn <inwardvessel@gmail.com>
Cc: shakeel.butt@linux.dev, mhocko@kernel.org, hannes@cmpxchg.org,
	yosryahmed@google.com, akpm@linux-foundation.org,
	linux-mm@kvack.org, cgroups@vger.kernel.org
Subject: Re: [RFC PATCH 0/9 v2] cgroup: separate per-subsystem rstat trees
Message-ID: <Z3hf5wrRuw0KylTh@slm.duckdns.org>
References: <20250103015020.78547-1-inwardvessel@gmail.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250103015020.78547-1-inwardvessel@gmail.com>

Hello,

On Thu, Jan 02, 2025 at 05:50:11PM -0800, JP Kobryn wrote:
...
> I reached a point where this started to feel stable in my local testing, so I
> wanted to share and get feedback on this approach.

The rationale for using one tree to track all subsystems was that if one
subsys has been active (e.g. memory), it's likely that other subsyses have
been active too (e.g. cpu) and thus we might as well flush the whole thing
together. The approach can be useful for reducing the amount of work done
when e.g. there are a lot of cgroups which are only active periodically but
has drawbacks when one subsystem's stats are read a lot more actively than
others as you pointed out.

Intuitions go only so far and it's difficult to judge whether splitting the
trees would be a good idea without data. Can you please provide some
numbers along with rationales for the test setups?

Thanks.

-- 
tejun

