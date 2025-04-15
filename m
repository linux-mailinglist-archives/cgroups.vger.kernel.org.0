Return-Path: <cgroups+bounces-7542-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B82DA8905A
	for <lists+cgroups@lfdr.de>; Tue, 15 Apr 2025 02:12:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4A84517B7CB
	for <lists+cgroups@lfdr.de>; Tue, 15 Apr 2025 00:12:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DA294C98;
	Tue, 15 Apr 2025 00:12:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PFfNHWLZ"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47B671361;
	Tue, 15 Apr 2025 00:12:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744675951; cv=none; b=P30LkkXywBFORI2HuhYh+xT3fQZlGebIuTvJSrA1nSbNGm5kc8dFFE1cUouC5wenvl6ZfGDK3gHcunm8gJ2wJeVWa5nAw4vS44BG4OAxRXY9IoF1ycZ9d6fo/Hy0o9S/FOz1bMKImrDzeb936r5x+Ttjc5SYVCdOV02WO5IdomE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744675951; c=relaxed/simple;
	bh=lLHJknmMDrd657zbVsXqHKzj3VV+nPBAXxPnLx4i2J8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=mHc/oE7NWtwbjY46LZsT0MAiS4TBSe/BMcSZI6bW+zud29LMdtA0VvVA/NB92jSCDx5Xukvzy/EY4raJrttp1zxC3Ys5kRcAABQ9XbFCBSefdLNOad7tYkwFnrw0l1gWj/wsDdRPu3poM22XQMHWGEeplDHUPpr/x6RUT7ZW8Os=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PFfNHWLZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D191DC4CEE2;
	Tue, 15 Apr 2025 00:12:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744675951;
	bh=lLHJknmMDrd657zbVsXqHKzj3VV+nPBAXxPnLx4i2J8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PFfNHWLZvF6uiK+MSsrWlqgynhi0GMWdB3/lXZVJMEiBYKj5EFuDz8fqu42Tzr3iz
	 jAcqK66bEK4W4RKpgD5NwElzEtvtOsd66B/GsE0UCRwa1QFMXaJgY4EoX7HMg8gPIE
	 UQZOcUlHUk1AfcU7AMD/umrJQqM1mUXtLOVHFePAF3kHrrHO0U/lKrBLLihGyQOoNY
	 L/IWtgNYrbHDOfQatDmNPYkY0027RSNicvK9ff9URXmS6XX1YRYEp6sX2MohgFUygI
	 HUWsfnWShqc/7LzvewBXO+pF4NxSIsDUef//Ui48WvYx/CFFt8VY3/y8VyQFH5K3yM
	 qK5Rf+kaawlwA==
From: SeongJae Park <sj@kernel.org>
To: Gregory Price <gourry@gourry.net>
Cc: SeongJae Park <sj@kernel.org>,
	linux-mm@kvack.org,
	cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	akpm@linux-foundation.org,
	mingo@redhat.com,
	peterz@infradead.org,
	juri.lelli@redhat.com,
	vincent.guittot@linaro.org,
	hannes@cmpxchg.org,
	mhocko@kernel.org,
	roman.gushchin@linux.dev,
	shakeel.butt@linux.dev,
	donettom@linux.ibm.com
Subject: Re: [RFC PATCH v4 1/6] migrate: Allow migrate_misplaced_folio_prepare() to accept a NULL VMA.
Date: Mon, 14 Apr 2025 17:12:28 -0700
Message-Id: <20250415001228.120684-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250411221111.493193-2-gourry@gourry.net>
References: 
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Fri, 11 Apr 2025 18:11:06 -0400 Gregory Price <gourry@gourry.net> wrote:

> migrate_misplaced_folio_prepare() may be called on a folio without
> a VMA, and so it must be made to accept a NULL VMA.

The comment of the function says "Must be called with the PTL still held".  I
understand it is not needed for NULL VMA case because it is for unmapped
folios?  If I'm understanding correctly, could you please also clarify such
details including when NULL VMA case happens and if locking requirement is
changed, on the comment?


Thanks,
SJ

[...]

