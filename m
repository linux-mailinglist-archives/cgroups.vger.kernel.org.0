Return-Path: <cgroups+bounces-13111-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 993D9D15FC3
	for <lists+cgroups@lfdr.de>; Tue, 13 Jan 2026 01:27:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B8739303DD12
	for <lists+cgroups@lfdr.de>; Tue, 13 Jan 2026 00:23:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD53D21FF5B;
	Tue, 13 Jan 2026 00:23:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="BFyTCu9/"
X-Original-To: cgroups@vger.kernel.org
Received: from out-183.mta0.migadu.com (out-183.mta0.migadu.com [91.218.175.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10FF221CC5C
	for <cgroups@vger.kernel.org>; Tue, 13 Jan 2026 00:23:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768263807; cv=none; b=OQYMooqaBJKnpXIawqckHgl9PzmmLDouZ4Ofclr+tbGlOLUACO3vbrefDhgu4QzP1vgdeRAFmW9ljuu6M7CjtTcQIObun/T2LH/oR1caN8Y+fzR9uuDvU/oBElhuxrwtervc56KFbB/lw5eLvXS2/iSW07DPZVzFAtzz595Qr4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768263807; c=relaxed/simple;
	bh=dDqj+3o1GwOA7Ts5boUOHm3elRAMwOwI1Ebqof49pGY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TJvZwTHcBI/3reXK+ntwutbckQJ/XhrVIC3nI4awmuZDRoD/R23olg4D+CA0FnUafp0Vk0AN/+P1V/ZR1pMlVccmIcNn4h+tnA20+zA47c9EpLSIt+xphYkm9ANYwaCXzQMxeDwlvqM8CEGcWAcj3lF2/aJBTiQutgw6quXxdu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=BFyTCu9/; arc=none smtp.client-ip=91.218.175.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Mon, 12 Jan 2026 16:23:19 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1768263804;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JniOifvm0Vzj6b4Lw5mELotZ+645Lbbt+efHkzvLxps=;
	b=BFyTCu9/dziGMM32LOcrDBcuPgHKuuM2p77Bv8VDrwgAr5KvXtq38cnD8LDJEVosDVorfh
	Vbsk8Q6kpRoB+W/58rQAFCJCv7jLhu0chTkZgu6+y7ohVODlQHHU5TSDvNHbabijAFR7VN
	D9ah+6bw5qFnYvsFBDmL/twdwTiCcZo=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Jianyue Wu <wujianyue000@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org, 
	cgroups@vger.kernel.org, hannes@cmpxchg.org, mhocko@kernel.org, roman.gushchin@linux.dev, 
	muchun.song@linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] mm: optimize stat output for 11% sys time reduce
Message-ID: <uvmqfu2ms7itmfl2bk47yxtbafccscc2hlsw56uq2qy3q6fri3@sl56sf33fvyj>
References: <CAJxJ_jioPFeTL3og-5qO+Xu4UE7ohcGUSQuodNSfYuX32Xj=EQ@mail.gmail.com>
 <20260110042249.31960-1-jianyuew@nvidia.com>
 <20260110153342.7e689e794ce43a0a39c699fc@linux-foundation.org>
 <7210e5e0-2a93-4d3b-a564-85c0fe117ef5@gmail.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7210e5e0-2a93-4d3b-a564-85c0fe117ef5@gmail.com>
X-Migadu-Flow: FLOW_OUT

On Sun, Jan 11, 2026 at 12:37:45PM +0800, Jianyue Wu wrote:
> On 1/11/2026 7:33 AM, Andrew Morton wrote:
> > On Sat, 10 Jan 2026 12:22:49 +0800 Jianyue Wu <wujianyue000@gmail.com> wrote:
> > 
> > > Replace seq_printf/seq_buf_printf with lightweight helpers to avoid
> > > printf parsing in memcg stats output.
> > > 
> > I don't understand - your previous email led me to believe that the new
> > BPF interface can be used to address this issue?
> 
> Yes, previously I think can directly use BPF interface to speedup. Later I
> think maybe this is still needed, as some platform didn't have BPF installed
> might still use these sysfs files.
> 

It seems like this patch adds measurable improvement for the traditional
stat readers. The high performance ones can be switched to the bpf based
interface. So, I see no harm in taking this patch in.

