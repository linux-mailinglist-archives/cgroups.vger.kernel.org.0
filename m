Return-Path: <cgroups+bounces-11776-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7389CC4B3A5
	for <lists+cgroups@lfdr.de>; Tue, 11 Nov 2025 03:40:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 44974189012E
	for <lists+cgroups@lfdr.de>; Tue, 11 Nov 2025 02:40:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28C4C34846A;
	Tue, 11 Nov 2025 02:40:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="fO8JImOw"
X-Original-To: cgroups@vger.kernel.org
Received: from out-188.mta0.migadu.com (out-188.mta0.migadu.com [91.218.175.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2965E348460
	for <cgroups@vger.kernel.org>; Tue, 11 Nov 2025 02:40:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762828809; cv=none; b=QaRjhpqfOjA9YyjutmsEyZr98d97AbAmRar0ZALDlzYD7a/y67OoVPcbpFdmECC0wudfUssMXxp6ExkoA7MFSZBaAaBFaSqb2MDE28fPzEMHd/4BIYGyoZr+rWmUbmTFDA6WTCzKRP+PgpbdSEhORLJQ26Qrlyz4pUl3Rije3M8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762828809; c=relaxed/simple;
	bh=+6vSINe2/vWnfG9Yym+i+7kLeLoCyDaSHENlYnD9kUM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RKCW+C+n4Ng8eo/xzHFFxhxw6458FJ96V7EW6qL+bYkKhGk+J+46/V4fjyGJIaFyNxG3NDkQOrk0MGBXF7sFSLY1lRMAP4H//e4fsJhZ25GYuTSSUlSa300uyK2zNsyQeVYXSjnI3R3V8DmnECtxKXyxrUZDBnN43rqldCrSjSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=fO8JImOw; arc=none smtp.client-ip=91.218.175.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Mon, 10 Nov 2025 18:39:57 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1762828802;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xSYbGmkOLF0vBeTr/9wqYidF3L9zQmGvCy8e3mct3rU=;
	b=fO8JImOw2Fpc9qau/X9P8HeEr6rVexPfWTom4x3QUUYiTSGb0SZlbRJCFcQkfBPt7HnyQl
	detdX0w26+D2kqf7jhpwxFNQcoZqXSuXxJ4/aDfmWZPA9wpCwhSd3w6b+MenkiBDSDhoZL
	3emc2QN6Ju3/dLKeippexg4lLGwLMgM=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Qi Zheng <qi.zheng@linux.dev>
Cc: Harry Yoo <harry.yoo@oracle.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Johannes Weiner <hannes@cmpxchg.org>, 
	Michal Hocko <mhocko@kernel.org>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Muchun Song <muchun.song@linux.dev>, Vlastimil Babka <vbabka@suse.cz>, linux-mm@kvack.org, 
	cgroups@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Meta kernel team <kernel-team@meta.com>
Subject: Re: [PATCH 0/4] memcg: cleanup the memcg stats interfaces
Message-ID: <gsew67sciieqxbcczp5mzx4lj6pvvclfrxn6or3pzjqmj7eeic@7bxuwqgnqaum>
References: <20251110232008.1352063-1-shakeel.butt@linux.dev>
 <aRKKfdN3B68wxFvN@hyeyoo>
 <24969292-7543-456f-8b80-09c4521507e2@linux.dev>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <24969292-7543-456f-8b80-09c4521507e2@linux.dev>
X-Migadu-Flow: FLOW_OUT

On Tue, Nov 11, 2025 at 10:23:15AM +0800, Qi Zheng wrote:
> Hi,
> 
[...]
> > 
> > Are you or Qi planning a follow-up that converts spin_lock_irq() to
> > spin_lock() in places where they disabled IRQs was just to update vmstat?
> 
> Perhaps this change could be implemented together in [PATCH 1/4]?
> 
> Of course, it's also reasonable to make it a separate patch. If we
> choose this method, I’m fine with either me or Shakeel doing it.
> 

Let's do it separately as I wanted to keep the memcg related changes
self-contained.

Qi, can you please take a stab at that?

> > 
> > Qi's zombie memcg series will depends on that work I guess..
> 
> Yes, and there are other places that also need to be converted, such as
> __folio_migrate_mapping().

I see __mod_zone_page_state() usage in __folio_migrate_mapping() and
using the same reasoning we can convert it to use mod_zone_page_state().
Where else do you need to do these conversions (other than
__folio_migrate_mapping)?

