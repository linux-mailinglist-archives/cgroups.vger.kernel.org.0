Return-Path: <cgroups+bounces-10793-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 29771BE0B07
	for <lists+cgroups@lfdr.de>; Wed, 15 Oct 2025 22:48:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D77F4400768
	for <lists+cgroups@lfdr.de>; Wed, 15 Oct 2025 20:48:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 283F82C15A0;
	Wed, 15 Oct 2025 20:48:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="a6BsS5Fd"
X-Original-To: cgroups@vger.kernel.org
Received: from out-189.mta0.migadu.com (out-189.mta0.migadu.com [91.218.175.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58AEA21ABAA
	for <cgroups@vger.kernel.org>; Wed, 15 Oct 2025 20:48:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760561315; cv=none; b=Bqhw/xxu46Kt6cHR7avU7V7z92LQXofTcTvsZQQuzflwT1biGg8NrjXKQls9rD7d6vTnk2k1AGRVRgi6HBxe4kPcawjOI66BZnYLlhjpYhRW3q+b01l4JMRJe3m/BrqbmbpcoEdDU8tHxTn8YEq13osqPycnKSzP7wCKwgZJw6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760561315; c=relaxed/simple;
	bh=9VOSPvEqZgmNqevs/TDmGvxttaeP3/0ru7NgLRNuWIQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SBeslB4eim3WYjC3fDnFi8oJhlmO2+M7RHtb2vT8o6HKo98UYKeV4AzpZ2WmGbDfpDBMexWd2JiovmkS6Rn3cM+wVqDIFd/S9ygLVCn29VOsMDsxbzMjk2tcSywDBQ9h9gDhyIxAm4TV7DOb0Pv0iX3VATOPdWkAbQLwn/gMJ1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=a6BsS5Fd; arc=none smtp.client-ip=91.218.175.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Wed, 15 Oct 2025 13:48:27 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1760561311;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xTg3aQAK9KE0ay1Gvrf5jH48h+FMnrhgYNSbvhy7rOY=;
	b=a6BsS5FdHz6RDbryN+6dOyxrbx+19JpYAD2FU+Bz9hIV3U1mR9cUXZ+IUDxxmEIjE+zDE5
	UAwpBAQQRAnIOOV7ho4+lKTN8qTC9NdDDgWDxSPmVZ3ODYhxF/IpCutyEG2hemWcdfLTrK
	v3P1wrEgxYIrFFDPcIKVTO48g3VA2ZY=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: JP Kobryn <inwardvessel@gmail.com>
Cc: andrii@kernel.org, ast@kernel.org, mkoutny@suse.com, 
	yosryahmed@google.com, hannes@cmpxchg.org, tj@kernel.org, akpm@linux-foundation.org, 
	linux-kernel@vger.kernel.org, cgroups@vger.kernel.org, linux-mm@kvack.org, bpf@vger.kernel.org, 
	kernel-team@meta.com
Subject: Re: [PATCH v2 1/2] memcg: introduce kfuncs for fetching memcg stats
Message-ID: <sw2zbwvfadqxi7pvlwhyt4xlbfujonckowovvie53kejqzup5a@3w2dmlkblm3g>
References: <20251015190813.80163-1-inwardvessel@gmail.com>
 <20251015190813.80163-2-inwardvessel@gmail.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251015190813.80163-2-inwardvessel@gmail.com>
X-Migadu-Flow: FLOW_OUT

On Wed, Oct 15, 2025 at 12:08:12PM -0700, JP Kobryn wrote:
> Reading from the memory.stat file can be expensive because of the string
> encoding/decoding and text filtering involved. Introduce three kfuncs for
> fetching each type of memcg stat from a bpf program. This allows data to be
> transferred directly to userspace, eliminating the need for string
> encoding/decoding. It also removes the need for text filtering since it
> allows for fetching specific stats.
> 
> The patch also includes a kfunc for flushing stats in order to read the
> latest values. Note that this is not required for fetching stats, since the
> kernel periodically flushes memcg stats. It is left up to the programmer
> whether they want more recent stats or not.
> 
> Signed-off-by: JP Kobryn <inwardvessel@gmail.com>

Acked-by: Shakeel Butt <shakeel.butt@linux.dev>

