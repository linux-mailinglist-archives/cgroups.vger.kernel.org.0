Return-Path: <cgroups+bounces-16235-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id Pd/vBO2tE2pKEwcAu9opvQ
	(envelope-from <cgroups+bounces-16235-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Mon, 25 May 2026 04:03:25 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 950295C5506
	for <lists+cgroups@lfdr.de>; Mon, 25 May 2026 04:03:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 43FD73001D5E
	for <lists+cgroups@lfdr.de>; Mon, 25 May 2026 02:03:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3768C54723;
	Mon, 25 May 2026 02:03:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="L4VqK2BM"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6026126AF4
	for <cgroups@vger.kernel.org>; Mon, 25 May 2026 02:03:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779674600; cv=none; b=QoZxmWqUE0GvZDYgmU1EdktAPOI0dyvP8Pmf0oMV6N3F4L1UVF9hOPhUw67xNkWVenWLIyeGNdUfUg4ZTJaXKD8geEYiMWoAZPvPvp5tl5uZ9PtQNeA0nP8amOGw1Vd/k9g/c0ZJY1z1bh+zVM88Ai+sFMRwJH/UPNSfhmr4Dkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779674600; c=relaxed/simple;
	bh=tvbe4seE81VJXCS/sV64iAFa1bGbqBGMfj6eA3O0mQM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Bgu53ohwlxlzfJgPNgzPxMn9oj1lsyeVEjdEQhVPkVdMXbB0MxdeWUwGkKh33ejnI8xiBQjK0QR/rAyH5bgybS5pGyUxxG3RUAh9kt6NaVBXxoi9xWnhfYXicc661t6EZgMykKnOGeujjpd8Qu1TshKHhqGmFdNVBVCgNLBIDAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=L4VqK2BM; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-914bbfc2464so201834285a.1
        for <cgroups@vger.kernel.org>; Sun, 24 May 2026 19:03:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1779674597; x=1780279397; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=a1dR+qUQ11esis+j6Iq3N8urMnTyCI4LYg4f+Ph15u8=;
        b=L4VqK2BMZjPaHALdciJSto99TlqA406nZSA0HxJiam/tbt6XUHJtszc+dEn/FdEMl5
         f7rXTkY30+7rMsqwcEVCifanjHU/QhyDqzAbFaukFAqAMPdP78OTBUX6DQ9holIYAmpK
         pSOxRATA/uSOpooB3BE2Nk9izHjxZ+LZcwP6EjkxF4oQ5BwnvKkFaLMjPOIGXxq+bCWa
         spUSybEE+rsMIrccbB66CgxfkLHC4ZmLni5uwft6Dt7cqi6AobOyJ3cOX5OLqcbo9A6N
         4ebRgzFMnf8cyNUa3HSMJ9A5yIIlnsZjwie19Yk/FU2ZxP0PQCTyayxyd2y7unfUDAOX
         13qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779674597; x=1780279397;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=a1dR+qUQ11esis+j6Iq3N8urMnTyCI4LYg4f+Ph15u8=;
        b=e1akNsf2UB1FNckjhHvaZ8NTCPvu0jQtFKs7iFXTyioRrFGYKWHLoGsSkCbYCR/hmh
         mfMb6toWupPIs5Zu/4HuKbD8fIsIoBDkr+afgH4B9M0T5fSl6M2VewnPSxu4Uzx7jI2r
         WkWaClbkuCnbrDoe57zqTjj5JYrIEkVSrO9GZbEeqXuPqKJRHWnOUtB+S1IWi1qbYt7B
         eI6KVHIby6V/04PWaFzrE+y9nAU5CnX0g6V5QuqXdMuFn7gTmFnaK8+WPIiStTt9vT1V
         5/jJgEsQUKGCpipMWiDrQEMoKjfBGnk0BsvESsX2a0fSIy36yI0Uf0LUm8kbfC6VBOtN
         c2RA==
X-Forwarded-Encrypted: i=1; AFNElJ8khBJjp7obbQ6hhUfe3b4T5zYWl6AfwrKKm8pE0neVmLW04de6N0HHLaefImJhjwED5FMQej/P@vger.kernel.org
X-Gm-Message-State: AOJu0Yzzuo9irZowc0ZYuX1GoSGqUlVxua9NbU21kVhAIvoBMQRwGtWK
	MZ9XQIAZbqRZJFqjEpjZvfEkGIswlwe46ywVNBKRstXtnj2/ttbDHxPNe8+b2z7cm7w=
X-Gm-Gg: Acq92OHhI+Kqc9qc6JRh2xETgiaZiF/JdbiDJ14TYTuNH8wlyHuPf9Dbr6xmMF261+J
	k4QeUY8lXLBxQntYXcHGIIXRwj5nLQ1bVJ4gbDod2cPZnm12XS747XXRiW1VWXpqc5VWw2bf8/t
	GDfXCr5zQxV5isSPKJH/WMxmz/jyCZ8Pvp25MUpUd+qArRw6e8x15w/vshDu3i3Y0HzhGwtluJw
	nCYgnsdoufKIeVP5mD7cWoLh9qtobk3B9a7CTB+S6a6S0ihHX7qYLv9pz/29xTrT4IYsbY72+P/
	3TyboA5fzbluJ6liJWWQJE/fMYmTYmJKJCkDEIoLnKDUofIQQG3+b2kRjAFs/R57OaHLqBrLrL4
	XUMvBuVV0B6pahCQwlZuJWLJYsZpiXsLJK8G8TbQfEC6rGvjZHr2QPv8ODyRQgA8rAE2MTfDGCC
	yU8ki4u0XYeszxJDYMQTcShpgG9yuFzEXcMPBGVV37938Qw6AGltz0Wl/IzJ2ALjbziqH7DpRw7
	MzfwIQFHP3K
X-Received: by 2002:a05:620a:372a:b0:914:c100:6a0f with SMTP id af79cd13be357-914c10072a4mr1391916385a.23.1779674597141;
        Sun, 24 May 2026 19:03:17 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (pool-100-36-248-188.washdc.fios.verizon.net. [100.36.248.188])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-914bb8c8034sm892777285a.7.2026.05.24.19.03.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 May 2026 19:03:16 -0700 (PDT)
Date: Sun, 24 May 2026 22:03:13 -0400
From: Gregory Price <gourry@gourry.net>
To: Arun George/Arun George <arun.george@samsung.com>
Cc: lsf-pc@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
	linux-cxl@vger.kernel.org, cgroups@vger.kernel.org,
	linux-mm@kvack.org, linux-trace-kernel@vger.kernel.org,
	damon@lists.linux.dev, kernel-team@meta.com,
	gregkh@linuxfoundation.org, rafael@kernel.org, dakr@kernel.org,
	dave@stgolabs.net, dave.jiang@intel.com, alison.schofield@intel.com,
	vishal.l.verma@intel.com, ira.weiny@intel.com, longman@redhat.com,
	akpm@linux-foundation.org, david@kernel.org,
	lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com, vbabka@suse.cz,
	rppt@kernel.org, surenb@google.com, mhocko@suse.com,
	osalvador@suse.de, ziy@nvidia.com, matthew.brost@intel.com,
	joshua.hahnjy@gmail.com, rakie.kim@sk.com, byungchul@sk.com,
	ying.huang@linux.alibaba.com, apopple@nvidia.com,
	axelrasmussen@google.com, yuanchu@google.com, weixugc@google.com,
	yury.norov@gmail.com, linux@rasmusvillemoes.dk, mhiramat@kernel.org,
	mathieu.desnoyers@efficios.com, tj@kernel.org, hannes@cmpxchg.org,
	mkoutny@suse.com, jackmanb@google.com, sj@kernel.org,
	baolin.wang@linux.alibaba.com, npache@redhat.com,
	ryan.roberts@arm.com, dev.jain@arm.com, baohua@kernel.org,
	lance.yang@linux.dev, muchun.song@linux.dev, xu.xin16@zte.com.cn,
	chengming.zhou@linux.dev, jannh@google.com, linmiaohe@huawei.com,
	nao.horiguchi@gmail.com, pfalcato@suse.de, rientjes@google.com,
	shakeel.butt@linux.dev, riel@surriel.com, harry.yoo@oracle.com,
	cl@gentwo.org, roman.gushchin@linux.dev, chrisl@kernel.org,
	kasong@tencent.com, shikemeng@huaweicloud.com, nphamcs@gmail.com,
	bhe@redhat.com, zhengqi.arch@bytedance.com, terry.bowman@amd.com,
	gost.dev@samsung.com, arungeorge05@gmail.com, cpgs@samsung.com
Subject: Re: [LSF/MM/BPF TOPIC][RFC PATCH v4 00/27] Private Memory Nodes (w/
 Compressed RAM)
Message-ID: <ahOt4Zw66ukww2On@gourry-fedora-PF4VCD3F>
References: <20260222084842.1824063-1-gourry@gourry.net>
 <CGME20260427123800epcas5p1e1a2fed257091b31e2e6c3a7d1b0c2b0@epcas5p1.samsung.com>
 <1983025922.01777297382206.JavaMail.epsvc@epcpadp2new>
 <ae_i9IlIndumJWN3@gourry-fedora-PF4VCD3F>
 <1891546521.01777455002601.JavaMail.epsvc@epcpadp1new>
 <afIKxG5mJZE6QgpR@gourry-fedora-PF4VCD3F>
 <1891546521.01777901881625.JavaMail.epsvc@epcpadp2new>
 <afmgJcFUjQLYxkb5@gourry-fedora-PF4VCD3F>
 <1891546521.01779449881859.JavaMail.epsvc@epcpadp2new>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1891546521.01779449881859.JavaMail.epsvc@epcpadp2new>
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[gourry.net:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[lists.linux-foundation.org,vger.kernel.org,kvack.org,lists.linux.dev,meta.com,linuxfoundation.org,kernel.org,stgolabs.net,intel.com,redhat.com,linux-foundation.org,oracle.com,suse.cz,google.com,suse.com,suse.de,nvidia.com,gmail.com,sk.com,linux.alibaba.com,rasmusvillemoes.dk,efficios.com,cmpxchg.org,arm.com,linux.dev,zte.com.cn,huawei.com,surriel.com,gentwo.org,tencent.com,huaweicloud.com,bytedance.com,amd.com,samsung.com];
	TAGGED_FROM(0.00)[bounces-16235-lists,cgroups=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gourry.net:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[gourry.net];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gourry@gourry.net,cgroups@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_GT_50(0.00)[75];
	TAGGED_RCPT(0.00)[cgroups];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 950295C5506
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, May 22, 2026 at 02:10:34PM +0530, Arun George/Arun George wrote:
> Thanks.
> 
> On 05-05-2026 01:15 pm, Gregory Price wrote:
> > In the scenario i'm talking about, a "write budget" is defined as a
> > number of pages that are allows to be mapped writable in the page
> > tables at any given time.
> > Agree. I was also in the same context.
> 
> I am trying to bring the device perspective here, and would like to 
> discuss a few corner cases and possible solutions.
> 
> As I see, solving the compressed memory problem statement has these 
> aspects mainly:
> 
> 1) Allocation control: private/managed memory concept.
> 2) Write control: write-protected PTEs, write-controlled use cases like 
> ZSWAP
> 3) Proactive reclaims: optional methods to ease back-pressure using 
> memory shrinkers, ballooning, kswapd, promotion etc. These methods will 
> be triggered based on notifications/interrupts from the device.
> 
> May be they are not enough to cover some corner cases for cram!
> 
>   I believe that this thin-provisioned memory infra is susceptible to 

I'm not understanding the "thin provisioned" terminology you're using
here.  Can you help define what you mean by thin-provision in this case?

> 'writes-above-media-capacity corner cases' (because of not handling 
> device back-pressure notifications in time) whichever methods we use in 
> the kernel. Even if we use write-controlled methods like ZSWAP and 
> pro-active reclaims, there could be corner cases where the communication 
> with the device could be broken and the write path is not aware of it 
> immediately. Note that OCP spec [1] says the device should mark the 
> memory location as 'poisoned' in 'over-capacity' writes.
> 

The intent is to use the low-watermark to prevent new allocations from
occurring, and the write-controls prevent writing to the device without
interposition.

With a sufficient watermark such that the interrupt is delivered within
some number of microseconds, that should be perfectly fine to prevent
poison from ever occurring at all.

Since poison is only delivered *on read*, the system can go a long,
long time before poison is discovered. From the end-user perspective,
this poison is basically unacceptable.

So either we can prevent poison from always occurring, or the hardware
is not viable to support in a scaled production.  

If you think a sufficiently conservative watermark + write-protection is
insufficient to defend against poison, then please let me know why.

> So I have the following proposals / options for this scenario.
> 
>     Option 1: Poisoned data management - This is about accepting that 
> poisoning of memory locations can happen in much more regular frequency 
> here than regular memories and we need to figure out potential recovery 
> mechanisms in host (not recovery of data; but recovery from the poison 
> situation). But I guess folks will not be okay with it in general, and I 
> am not aware of any workloads where data poisoning is tolerated (may be 
> caching workloads?).
> 

Given option 1, I would never put such a device into my production
environment.  The only reasonable action for handling poison is killing
the software, as the data is functionally corrupted.

>     Option 2 (preferred): Device assisted write budgeting - This is 
> about a device aware / assisted mechanism for the write-controlled 
> use-cases (Ex: ZSWAP) to know the 'safe number of  writes' that can be 
> performed to the device (Or allows to be mapped writable in the page 
> tables). This could be like a 'token bucket' algorithm, where the device 
> provides a 'budget / set of tokens' to the host. And it need to be 
> replenished periodically in the device communication code path; and if 
> the host does not find the token, writes cannot go ahead.
> 

When I say budgeting, I mean literally a budget of writable pages,
entirely controlled by software (mm/cram.c or zswap.c or whatever).

This has nothing to do with device operation / throttling / bandwidth
budgets etc.  It is simply a proposal of an optimization that allows the
user to say:  X out of Y possible pages may be mapped writable.

I don't think this would be part of an initial MVP for a compressed ram
service (regardless of it's cram.c or zswap.c)

> In short, the communication with the device has to be maintained to make 
> pages mapped writable. For MVP, this could be a simple constraint of 
> checking actual device capacity periodically to replenish write-budget 
> for CRAM. For other users of private nodes (GPU memory?), this 
> constraint may not be needed at all.
> 
> We are planning to send an RFC code which will fit into your CRAM infra 
> to discuss this poison management approach further.
> 

I'll try to get a new version out this or next week, apologies for the
lag on this series, I've had a number of disruptions and major movements
on the patch set since I last updated it in February.

~Gregory

