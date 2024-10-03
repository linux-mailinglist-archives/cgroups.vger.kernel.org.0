Return-Path: <cgroups+bounces-5031-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1189198F82B
	for <lists+cgroups@lfdr.de>; Thu,  3 Oct 2024 22:40:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 96358282F6E
	for <lists+cgroups@lfdr.de>; Thu,  3 Oct 2024 20:40:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A73C1B0137;
	Thu,  3 Oct 2024 20:40:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="vCwbHIpc"
X-Original-To: cgroups@vger.kernel.org
Received: from out-187.mta0.migadu.com (out-187.mta0.migadu.com [91.218.175.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D24F7224D1
	for <cgroups@vger.kernel.org>; Thu,  3 Oct 2024 20:39:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727988000; cv=none; b=H4ZnyiGbbcQHrBazwxovbCzqK9OTOUiu6RMGl2yQjZ1lG4/6pHKdbglPgPRQpDnBStczIlpjeZixpDJZgByWHg9JK6uTxXdj7++G1wnWTwHA0+DDyj2fjqMZPOPxnoux+oXH8GO5aUmbDLE4e5mZRphtCQ3Ogvp6+J6lpbieInY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727988000; c=relaxed/simple;
	bh=bf1uSlh0iYawSTfaFxuVmNO3Z2JpX2O8jCmiu7CWPKk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B/KBxCrtYGv+aLcuYMO3S4HYBvq3YSIexkPIHp54AoJUxQwZm/QwnAvU7Iv2rRm3XnLKSENFpwoa+HEI+AXtDqJfZ+5srKGp5DxRxJieoZxO4eVtVchtZFW2R3vYYKxNGVd6pVlcyR1dL1V5KtCfid0chplINP7m+9VLWSyI8no=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=vCwbHIpc; arc=none smtp.client-ip=91.218.175.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Thu, 3 Oct 2024 13:39:48 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1727987995;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1GXP4MsEFjVh6723D6q9r7Kp5xVj4bm6p/OLLkYcAE4=;
	b=vCwbHIpcJ5WVzm0mX2BFL4VqWdtE/KYv9oL9Jv+f15FRlFuVIyhz54SI5zWFU7QqKPZWcf
	rAju3c5oHSkQaCKq1UpYCffUKyK1Da+wUgePHNIzzhdr4XwlVZVW7s6m0hgwzSGWXqmTti
	vJQn48OCIE1wts0wsKtQkCAtNZttgas=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Michal Hocko <mhocko@suse.com>
Cc: Christoph Hellwig <hch@infradead.org>, 
	Qu Wenruo <quwenruo.btrfs@gmx.com>, Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org, 
	hannes@cmpxchg.org, roman.gushchin@linux.dev, muchun.song@linux.dev, 
	akpm@linux-foundation.org, cgroups@vger.kernel.org, linux-mm@kvack.org, 
	"Vlastimil Babka (SUSE)" <vbabka@kernel.org>
Subject: Re: [PATCH] btrfs: root memcgroup for metadata filemap_add_folio()
Message-ID: <6fnaifzq7iufgqbj67v6e5runho74lfmjnleltc5upu33gtruc@utjdg2zuksby>
References: <b5fef5372ae454a7b6da4f2f75c427aeab6a07d6.1727498749.git.wqu@suse.com>
 <Zvu-n6NFL8wo4cOA@infradead.org>
 <5d3f4dca-f7f3-4228-8645-ad92c7a1e5ac@gmx.com>
 <Zvz5KfmB8J90TLmO@infradead.org>
 <Zv5Qxfz4sSwiKqm7@tiehlicka>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zv5Qxfz4sSwiKqm7@tiehlicka>
X-Migadu-Flow: FLOW_OUT

On Thu, Oct 03, 2024 at 10:07:33AM GMT, Michal Hocko wrote:
> On Wed 02-10-24 00:41:29, Christoph Hellwig wrote:
> [...]
> > What I'd propose is something like the patch below, plus proper
> > documentation.  Note that this now does the uncharge on the unlocked
> > folio in the error case.  From a quick look that should be fine, but
> > someone who actually knows the code needs to confirm that.
> 
> yes, this is a much cleaner solution. filemap_add_folio_nocharge would
> need documentation explaining when this is supposed to be used.
> 

I feel like we should not make bypassing cgroup accounting easier but
rather make it more awkward :P, so folks give much more thought before
opting to do so. Though I agree filemap_add_folio_nocharge() is easy to
grep. 

