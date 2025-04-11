Return-Path: <cgroups+bounces-7493-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E866A8697A
	for <lists+cgroups@lfdr.de>; Sat, 12 Apr 2025 01:49:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C02991BA1F3F
	for <lists+cgroups@lfdr.de>; Fri, 11 Apr 2025 23:49:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B57E2BD58C;
	Fri, 11 Apr 2025 23:49:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="FV+n3qVX"
X-Original-To: cgroups@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90A421401C;
	Fri, 11 Apr 2025 23:49:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744415373; cv=none; b=B44NMxsLqbLWCfRW9YyG6NDSM1949bjL0WQLnXSqYchV29LX//Oz2yFJgyC9mQulKb/DuGjMDiiegP60nC4Lu2TRh2kN45GCz2BemLX/jQF/j8iDJxdExvxqnv+LMj3dbXtMmOwP+QE/EK8YABbOzpM5bqxyyMI1RGDSvwhxJDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744415373; c=relaxed/simple;
	bh=OCXGPuh9aMAT1R3pg7E4S3sdO8/krNi5GzQX+XDxKrE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n0jvJCiFQfBNc4p5FZt3iyTYfGIomcdyCm6hpMppzB83SzETk0W891zzy6BOGSI8U51VLdCHjBLJNAhh6JXNUOpHVXGooFORGK4fEjq2msK9N6OyPl3uEZLDgddPZZw7Yw1fLkhKrBWc6Zbtv2SKFWnpterjy5W5NT93PMS2s4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=FV+n3qVX; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=adyTZHD/GKDZrHKRH0yui3+8pMUpePl7kMgnizA2joU=; b=FV+n3qVXRvUCkPwSbL5hKCFmy8
	aWcE59RmOBLtobPq/fkSlASwPV+d1F11xuUZoNuZ0SbXYXIPTKPL6uj31+67qMTtCMD78ssh08S4X
	R4L0EOqtM4XeP7qD4bkwS31+qhmb2cWLKS6XrDM5bgynZgOJDvHuRozwoh8eg9tjoW8/VI53pL15P
	IJO9sJCVbWRj4+/d03kjrczGs3L0+SyLr31RjjOWNrPWhbsvWHpMkVFwH0uSXZR/njcn9QfNee+wR
	mkmTYY+u1zqNudlZdauFWbLSvStj2qjsTjZ8cKelBoNOD3Za4JHK9KZZ6OApHeBvPtIG9Xm4pMH3v
	n/Q90dyQ==;
Received: from willy by casper.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u3O7a-00000004zsr-3zhg;
	Fri, 11 Apr 2025 23:49:19 +0000
Date: Sat, 12 Apr 2025 00:49:18 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Gregory Price <gourry@gourry.net>
Cc: linux-mm@kvack.org, cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel-team@meta.com,
	akpm@linux-foundation.org, mingo@redhat.com, peterz@infradead.org,
	juri.lelli@redhat.com, vincent.guittot@linaro.org,
	hannes@cmpxchg.org, mhocko@kernel.org, roman.gushchin@linux.dev,
	shakeel.butt@linux.dev, donettom@linux.ibm.com,
	Huang Ying <ying.huang@linux.alibaba.com>,
	Keith Busch <kbusch@meta.com>, Feng Tang <feng.tang@intel.com>,
	Neha Gholkar <nehagholkar@meta.com>
Subject: Re: [RFC PATCH v4 0/6] Promotion of Unmapped Page Cache Folios.
Message-ID: <Z_mqfpfs--Ak8giA@casper.infradead.org>
References: <20250411221111.493193-1-gourry@gourry.net>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250411221111.493193-1-gourry@gourry.net>

On Fri, Apr 11, 2025 at 06:11:05PM -0400, Gregory Price wrote:
> Unmapped page cache pages can be demoted to low-tier memory, but

No.  Page cache should never be demoted to low-tier memory.
NACK this patchset.

