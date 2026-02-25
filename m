Return-Path: <cgroups+bounces-14401-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ePjLMeuMn2nYcgQAu9opvQ
	(envelope-from <cgroups+bounces-14401-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Thu, 26 Feb 2026 00:59:39 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BE5F19F398
	for <lists+cgroups@lfdr.de>; Thu, 26 Feb 2026 00:59:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 194C930238EA
	for <lists+cgroups@lfdr.de>; Wed, 25 Feb 2026 23:58:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5F59387360;
	Wed, 25 Feb 2026 23:58:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="nAahtgay"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B82F385535
	for <cgroups@vger.kernel.org>; Wed, 25 Feb 2026 23:58:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772063908; cv=none; b=cgAX8IaBiuNbKFbUY4Bn+vkCR2d9ViQcfqroryLc0BRBTNANUL6W8wsSIS7mnSKQDi66kDsS53gkhZOJuIQFrDDH1EcNbmLNpliysMquP6/L4mJVM29x94LjULLpSqxDiK+3lzzFzi/bTdPKn2F0xl8660SYQXGWV0iR5CAAGmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772063908; c=relaxed/simple;
	bh=vMJ146Y/EPWV062fRB1P7stJ5n4Sr6xxBlqgn9/6cfE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TJmbad2PNkehlTLaz3e9a3NpTgluzL1wYHJdvC2fJEvwEW5iT3GzjivdJdlvlemZY2epB5xwGrKTwFKgeGnLSNL4KrG6FPm1rFghnczn+vYg5VuzMKtI4QIhuw9z5h2ipMC4NjrYhJjxYPRDVfJvBsYyPqlROUmQ4hrwfExkZ/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=nAahtgay; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-505e2e4c35fso2804751cf.3
        for <cgroups@vger.kernel.org>; Wed, 25 Feb 2026 15:58:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1772063906; x=1772668706; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=QQWBXTWhdLgoq7OluVHAAR5bDFt9biBm7m+9/q6MXhA=;
        b=nAahtgayF3j+4rUcxkyd6fIXikcye73VtCWiZeC0ncuwR4D/vEldTS5w3azS7Z3oTb
         9c/jU3SWQUQ1cwHYuB+Pf+/0Qd+m4BhCYOfHTALlbeGNny6FUPINIjDZ1D8h+V1sEEWS
         RgzFvxo81bKYPB53bWH3LcPPF5Gso/9YhcWu6/JWdPL/WtTv0aFJzxJfTIWaCQcuzwwX
         SdspqyEryoBLok6sg8n8peZpCXZ9SwWM38pV9rljQojlr0AqkTYSisqwne93XNQHG+8r
         c+02wstHvUENYLBRDE1bGnV8YWsNSMuOu4/ctDNpAwz3d9YCmNN84eNtgnilFB/WNcO0
         deLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772063906; x=1772668706;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QQWBXTWhdLgoq7OluVHAAR5bDFt9biBm7m+9/q6MXhA=;
        b=jAUe287bGz5hTQySYGvzeF9Y8JGAMEwuz5qwD53pTX/c71bqxGdFxmW0ytcRdM31aZ
         sNx6Hm4rykZ4uKL6TUeZR4Gh3E21C/8jOWFafq18z9O24MZhGD/bYaslwyU2esDgIpvp
         +fNgxdZL6FpwDFm37f/3ADf41myQa8VTxu/aCB+Jl4uJoNuaBxzou7Vb6J3xT9uZis7d
         WLveGqn79amdmOIBtL9N3zbJY/gMHzhpF0dMFKaKnhpA7BOPLvxCpIUyhdPaSnxM6LXk
         +Roid6Ad7cWPYuGGMgiLGfoPRdjVi1P8b4I9CQtGXlTFNK3rApulyNmWVKi53LmpQGIJ
         bB3Q==
X-Forwarded-Encrypted: i=1; AJvYcCU+SBuCeX0Ls3utxXW5naJ51OPjXPNz1cTHPhdUChg8ZeCpsy/w2Ngl7m9x4z3L7zkp4q0WcYq+@vger.kernel.org
X-Gm-Message-State: AOJu0Yzh0H1jKwTEKY52lDlgNK1D99UiI6v6S3UynBjCpSbgDyNet9Zq
	kYwv2f2jqDLdiNXu3ioKgknVymXxfRYjHOibuXBZnjhPtNNNgzevSyocFg+tLRD+JKA=
X-Gm-Gg: ATEYQzy+nypXGHShnpQ8kILJkxzEm4yHSijm9kqb3Ifx32/NkyIAmRZ9+eZ/cViAU4y
	g4oUr/RNjcCG4riGOI2XMw8WFtGGt5t/AZCsIckifXKPAIdHTdG0NMIWlZKPVLsgK316rrlshwl
	2u/4II07Vm9+Wuz/H5qCr+CS7mMC/StcaMStSAuozh7sFfKjISTDb9CrmP3jX8mVbAS1cINcohB
	8orphaR93Rq72YH+5iOOz5KBDWrS2WvYiiO8mZN0Km6217QWk/TaKpgtIvfQ4XnBwgZGAyUb6Y3
	NIVe84s+dpG8biz/EqWlrIhHvuCTpuYMp52OYs3Pv9kS1k8vTB4auauehbvl1h7Fj3qPiap5363
	LRCYEoaKYnA1wrgmJgmIKMyLa2pHV7ytMp3wtPKMahikfb+U0gQ0wy0YsKip8YyJMpxWOhlEYYw
	oaBtaz8cTwdFOqouCIXzwPoA/PfHIvsbElGZMKa9Q3iyIWn1aHwEGOJnedzWPxwrQVNFpqhrcTJ
	rnaSrnx8g==
X-Received: by 2002:a05:622a:314:b0:4ff:8da6:2289 with SMTP id d75a77b69052e-50745f165famr3302881cf.27.1772063905968;
        Wed, 25 Feb 2026 15:58:25 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F (pool-96-255-20-138.washdc.ftas.verizon.net. [96.255.20.138])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-50744ab3f52sm5660571cf.22.2026.02.25.15.58.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Feb 2026 15:58:25 -0800 (PST)
Date: Wed, 25 Feb 2026 18:58:21 -0500
From: Gregory Price <gourry@gourry.net>
To: Matthew Brost <matthew.brost@intel.com>
Cc: Alistair Popple <apopple@nvidia.com>, lsf-pc@lists.linux-foundation.org,
	linux-kernel@vger.kernel.org, linux-cxl@vger.kernel.org,
	cgroups@vger.kernel.org, linux-mm@kvack.org,
	linux-trace-kernel@vger.kernel.org, damon@lists.linux.dev,
	kernel-team@meta.com, gregkh@linuxfoundation.org, rafael@kernel.org,
	dakr@kernel.org, dave@stgolabs.net, jonathan.cameron@huawei.com,
	dave.jiang@intel.com, alison.schofield@intel.com,
	vishal.l.verma@intel.com, ira.weiny@intel.com,
	dan.j.williams@intel.com, longman@redhat.com,
	akpm@linux-foundation.org, david@kernel.org,
	lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com, vbabka@suse.cz,
	rppt@kernel.org, surenb@google.com, mhocko@suse.com,
	osalvador@suse.de, ziy@nvidia.com, joshua.hahnjy@gmail.com,
	rakie.kim@sk.com, byungchul@sk.com, ying.huang@linux.alibaba.com,
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
	bhe@redhat.com, zhengqi.arch@bytedance.com, terry.bowman@amd.com
Subject: Re: [LSF/MM/BPF TOPIC][RFC PATCH v4 00/27] Private Memory Nodes (w/
 Compressed RAM)
Message-ID: <aZ-MnVVNGG_cOvxE@gourry-fedora-PF4VCD3F>
References: <20260222084842.1824063-1-gourry@gourry.net>
 <fzy6f6dpv3oq3ksr2mkst7pz3daeb3buhuvdvcw4633pcl7h6u@mxjgiwpg5acv>
 <aZ3BEn_73Rk8Fn7L@gourry-fedora-PF4VCD3F>
 <aZ92AvAg5boiSVw1@lstrano-desk.jf.intel.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aZ92AvAg5boiSVw1@lstrano-desk.jf.intel.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[gourry.net:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[nvidia.com,lists.linux-foundation.org,vger.kernel.org,kvack.org,lists.linux.dev,meta.com,linuxfoundation.org,kernel.org,stgolabs.net,huawei.com,intel.com,redhat.com,linux-foundation.org,oracle.com,suse.cz,google.com,suse.com,suse.de,gmail.com,sk.com,linux.alibaba.com,rasmusvillemoes.dk,efficios.com,cmpxchg.org,arm.com,linux.dev,zte.com.cn,surriel.com,gentwo.org,tencent.com,huaweicloud.com,bytedance.com,amd.com];
	TAGGED_FROM(0.00)[bounces-14401-lists,cgroups=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gourry.net:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[gourry.net];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gourry@gourry.net,cgroups@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_GT_50(0.00)[73];
	TAGGED_RCPT(0.00)[cgroups];
	NEURAL_HAM(-0.00)[-0.997];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 2BE5F19F398
X-Rspamd-Action: no action

On Wed, Feb 25, 2026 at 02:21:54PM -0800, Matthew Brost wrote:
> On Tue, Feb 24, 2026 at 10:17:38AM -0500, Gregory Price wrote:
> > 
> > The idea that drm/ is going to switch to private nodes is outside the
> > realm of reality, but part of that is because of years of infrastructure
> > built on the assumption that re-using mm/ is infeasible.
> 
> I was about to chime in with essentially the same comment about DRM.
> Switching over to core-managed MM is a massive shift and is likely
> infeasible, or so extreme that we’d end up throwing away any the
> existing driver and starting from scratch. At least for Xe, our MM code
> is baked into all meaningful components of the driver. It’s also a
> unified driver that has to work on iGPU, dGPU over PCIe, dGPU over a
> coherent bus once we get there, devices with GPU pagefaults, and devices
> without GPU pagefaults. It also has to support both 3D and compute
> user-space stacks, etc. So requirements of what it needs to support is
> quite large.
>
> IIRC, Christian once mentioned that AMD was exploring using NUMA and
> udma-buf rather than DRM GEMs for MM on coherent-bus devices. I would
> think AMDGPU has nearly all the same requirements as Xe, aside from
> supporting both 3D and compute stacks, since AMDKFD currently handles
> compute. It might be worth getting Christian’s input on this RFC as he
> likely has better insight then myself on DRM's future here.
> 

I also think the usage patterns don't quite match (today).

GPUs seem to care very much about specific size allocations, contiguity,
how users get swapped in/out, how reclaim occurs, specific shutdown
procedures - etc.

A private node service just wants to be the arbiter of who can access
the memory, but it may not really care to have extremely deep control
over the actual management of said memory.

Maybe there is a world where GPUs trend in that direction, but it's
certainly not where they are today.

But trying to generalize DRM's infrastructure seems bad.  At best we
end up with two mm/ implementations - not good at all.


I do think this fundamentally changes how NUMA gets used by userspace,
but I think userspace should stop reasoning about nodes for memory
placement beyond simple cpu-socket-dram mappings </opinion>.

(using mm/mempolicy.c just makes your code less portable by design)

---

As a side note, This infrastructure is not just limited to devices,
and I probably should have pointed this out in the cover.

We could create service-dedicated memory pools directly from DRAM.

Something I was exploring this week:  Private-CMA

Hack off a chunk of DRAM at boot, hand it to a driver to hotplug as a
private node in ZONE_NORMAL with MIGRATE_CMA, and add that node as a
valid demotion target.

You get:

1) A node of general purpose memory full of (reasonably) cold data
2) Tracked by CMA
3) The CMA is dedicated to a single service
4) And the memory can be pinned for DMA

Right now CMA is somewhat of a free-for-all and if you have multiple CMA
users you can end up in situations where even CMA fragments.

Splitting up users might be nice - but you need some kind of delimiting
mechanism for that.  A node seems just about right.

~Gregory


