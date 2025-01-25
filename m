Return-Path: <cgroups+bounces-6327-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 92941A1C525
	for <lists+cgroups@lfdr.de>; Sat, 25 Jan 2025 21:12:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E8F94166DC4
	for <lists+cgroups@lfdr.de>; Sat, 25 Jan 2025 20:12:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 699C918DF81;
	Sat, 25 Jan 2025 20:12:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ck5SkqRf"
X-Original-To: cgroups@vger.kernel.org
Received: from out-170.mta0.migadu.com (out-170.mta0.migadu.com [91.218.175.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2681F136326
	for <cgroups@vger.kernel.org>; Sat, 25 Jan 2025 20:12:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737835951; cv=none; b=Q+CI9BF5gMsZLCu+/TKXFfWtvmZ8Y8i3uXvFGw7hL75C0rX7DKKJu9nzLB1sajaM+56RcVFkVtnq9KoQEUKTWfKNFkxZK/7H2D2xGH2FpyqE89LfEh9pdtCcAqUu1Qrl2LfpL9YgVDeLNJ4wqC2K0LnsJu+Sz17SsvCBMmXgD0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737835951; c=relaxed/simple;
	bh=rgRw5ci0U4hM5hkTjnjBMM1buD7IBgfr4npMrZo8npc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MbSp66iWw8vTGMbNV0+Mo1pYlgoD03fIHplnDdIypTvS1HeqCTtF3o4ie0vKFbx6XqArjTo15nR/1SAonMO3dBGD6LHDxY20yUPjaCp0GGMdkEVXHtrjEB9I8+xadwtnvWCxVpJSR1nr0X2SvNga0yyxmPTzX8mZNMf+effWR+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ck5SkqRf; arc=none smtp.client-ip=91.218.175.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Sat, 25 Jan 2025 12:12:16 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1737835941;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ugTbdL5pTKVMUb1wQye/qlfEqnZ2oKuAblD/dhNvIQE=;
	b=ck5SkqRfbmPzfM3fBQ5f+e+mvyA9VZ5RLoC/IpkuaNAhpdVnlMmltPw8groJiN975WsVdG
	bpZjCw8/RX1qGDux2TN1ER9m7ppLma8d9BoL0nv/RJrmhdYXvKSdJrTiF5OSKZwqT/94I3
	jGT9IdB+FKjADPrpyXdJqsieM94BFLE=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Johannes Weiner <hannes@cmpxchg.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	Michal Hocko <mhocko@suse.com>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Muchun Song <muchun.song@linux.dev>, linux-mm@kvack.org, cgroups@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] mm: memcontrol: move stray ratelimit bits to v1
Message-ID: <mdmkkr3nch37jmcawgf6ggjc3aejbcxfwnqetjthpj7idfaiml@nbb6lq5kfrux>
References: <20250124043859.18808-1-hannes@cmpxchg.org>
 <20250124043859.18808-2-hannes@cmpxchg.org>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250124043859.18808-2-hannes@cmpxchg.org>
X-Migadu-Flow: FLOW_OUT

On Thu, Jan 23, 2025 at 11:38:59PM -0500, Johannes Weiner wrote:
> 41213dd0f816 ("memcg: move mem_cgroup_event_ratelimit to v1 code")
> left this one behind. There are no v2 references.
> 
> Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>

Acked-by: Shakeel Butt <shakeel.butt@linux.dev>

