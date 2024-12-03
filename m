Return-Path: <cgroups+bounces-5736-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 70C0C9E11F4
	for <lists+cgroups@lfdr.de>; Tue,  3 Dec 2024 04:40:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 424241625E5
	for <lists+cgroups@lfdr.de>; Tue,  3 Dec 2024 03:40:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D677168C3F;
	Tue,  3 Dec 2024 03:40:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="DgrsME63"
X-Original-To: cgroups@vger.kernel.org
Received: from out-182.mta0.migadu.com (out-182.mta0.migadu.com [91.218.175.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D978C2905
	for <cgroups@vger.kernel.org>; Tue,  3 Dec 2024 03:40:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733197247; cv=none; b=ZtdWFzgcfATINZTdZPk1UYIGnyDVGhfPH6TxRGpRf7ZUjYZ9XR+yfWHzieKCd/gd6gr+ULan4SY5DJjrpwGdSiQBCW1oP4wYBgqkNukrKoAuNEF7VWL1TuEkuroLvMR2zGBwUmViEoSnwmAG6WS9PJmORWeeA/y5PwPQhbFuF74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733197247; c=relaxed/simple;
	bh=3/vCR7hd1mkbqmOVXnd6771zf9LhdqojFLaqdaLjkG8=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=XA0XwvoTzb1wr2y/kfiljo5uP9or6zCqVy5TFU8ESdyAjZ0vaW6bBAMi7yde0JaEYugvL/nZLVopQCKDTBbFsWsL2xhbdcCekJcrYZlscsAKv8PbSLWmS2gMTg6tlbCZPAnAhQsvR1B/r5biY4VSdtaF+5UIEDr6NSvGRcRUKwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=DgrsME63; arc=none smtp.client-ip=91.218.175.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Content-Type: text/plain;
	charset=us-ascii
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1733197242;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pB9N0oTEw/DnxiAWtntc/2kC5CGpi8RLUNimhvYmgPE=;
	b=DgrsME63hX8GcbOf0vPYiRsr6pIvtwNfAJ9uXv2jfBkPzXNOmVvxOHgk65PhIMPNT9nfPc
	e3mtSF52/kxs+kCvc3cxJ9B59o7AY6d2UDL2RHa0rmGbFy2GH0Vezen4klxTEk+kxuGosz
	qWoTTHDZtSdb5DCHF25hEmXxNnX/9js=
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.200.121\))
Subject: Re: [PATCH v2] list_lru: expand list_lru_add() docs with info about
 sublists
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Muchun Song <muchun.song@linux.dev>
In-Reply-To: <20241129-list_lru_memcg_docs-v2-1-e285ff1c481b@google.com>
Date: Tue, 3 Dec 2024 11:40:19 +0800
Cc: Dave Chinner <david@fromorbit.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Matthew Wilcox <willy@infradead.org>,
 Johannes Weiner <hannes@cmpxchg.org>,
 Nhat Pham <nphamcs@gmail.com>,
 Qi Zheng <zhengqi.arch@bytedance.com>,
 Roman Gushchin <roman.gushchin@linux.dev>,
 Michal Hocko <mhocko@kernel.org>,
 Shakeel Butt <shakeel.butt@linux.dev>,
 linux-mm@kvack.org,
 cgroups@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 Dave Chinner <dchinner@redhat.com>
Content-Transfer-Encoding: 7bit
Message-Id: <E28CA72B-109F-4457-9234-7FF6C6C29C47@linux.dev>
References: <20241129-list_lru_memcg_docs-v2-1-e285ff1c481b@google.com>
To: Alice Ryhl <aliceryhl@google.com>
X-Migadu-Flow: FLOW_OUT



> On Nov 29, 2024, at 22:58, Alice Ryhl <aliceryhl@google.com> wrote:
> 
> The documentation for list_lru_add() and list_lru_del() has not been
> updated since lru lists were originally introduced by commit
> a38e40824844 ("list: add a new LRU list type"). Back then, list_lru
> stored all of the items in a single list, but the implementation has
> since been expanded to use many sublists internally.
> 
> Thus, update the docs to mention that the requirements about not using
> the item with several lists at the same time also applies not using
> different sublists. Also mention that list_lru items are reparented when
> the memcg is deleted as discussed on the LKML [1].
> 
> Also fix incorrect use of 'Return value:' which should be 'Return:'.
> 
> Link: https://lore.kernel.org/all/Z0eXrllVhRI9Ag5b@dread.disaster.area/ [1]
> Reviewed-by: Dave Chinner <dchinner@redhat.com>
> Signed-off-by: Alice Ryhl <aliceryhl@google.com>

Acked-by: Muchun Song <muchun.song@linux.dev>

Thanks.


