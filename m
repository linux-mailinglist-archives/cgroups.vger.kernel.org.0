Return-Path: <cgroups+bounces-13514-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sPQhEQtke2l2EQIAu9opvQ
	(envelope-from <cgroups+bounces-13514-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Thu, 29 Jan 2026 14:43:39 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A4857B0816
	for <lists+cgroups@lfdr.de>; Thu, 29 Jan 2026 14:43:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 17B1130209C3
	for <lists+cgroups@lfdr.de>; Thu, 29 Jan 2026 13:42:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 742C030DEC0;
	Thu, 29 Jan 2026 13:42:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="bMTWVosz"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83F882FE589
	for <cgroups@vger.kernel.org>; Thu, 29 Jan 2026 13:42:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769694169; cv=none; b=ai3ofGp/rb0sAbi4BHyRD+4N2PWp5t9pra+t7JjFdTmWVz0SX6mW5gHX+uQ99ZeZhOe5r9IUdG81VBaoa6MMQ0n3bd1b5V3r4APpWL1dC2PAn07uDs1lThIYNypwKPKhDimTEgZWbw3+w5V/Ek4uHxkc8I3D34wb6EbvBr16EDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769694169; c=relaxed/simple;
	bh=YBVpWb/wKpo5te9DXuKTTTurBJ7eElV5O2X8q6nV584=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CplRZDBjhPXOUjUF20RHYmqU+Vx+13MCg0DzDWQBc/AT/sR2yhZe5lLPemQdy44prKN22sYJFwGxi9oAgE601F7QHsIzMPtJhf9H1RJx+Ws71koi40EjiYqMveytxNAnVbWsb3A68EfAv3xIH9uaKC4jqMi3gdNV8DufbeUCwZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=bMTWVosz; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-503347dea84so11129111cf.3
        for <cgroups@vger.kernel.org>; Thu, 29 Jan 2026 05:42:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1769694166; x=1770298966; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=GDzgMbZmK6TIECiS2445LXqg7oI2wOpfTfzYF6w3p+0=;
        b=bMTWVoszFlR7I632RUufRMqVojdaC+/4lJM+18oYWO2OEIvo+Fz3NXgLHTK2xOoRpv
         3Ok3eNEsuKSipD7jdgqRjlAqSB0cNyBjjYxpfWaJ0kO/OESfoKuEJxqioDOVOdVqzquW
         Ij8/KMc7p0hL5q6bQLHfDs0croHM2hS5qI9aHbn09GGG1cRUGt64Y3M3pAME9myasaSr
         o5Tvj8xDiqgwpMKvoQwBMukFa1Tt1hE8bJJ2xuq1T1r58WRV9/7iy6tiN6eAX4LsEVa8
         ul7lvO/7R2GTOhrIcc1r4spgOc+EMqGpMw/d3gsVefCFcnLxXPhlecRX2DvHuxeyPSgc
         6DZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769694166; x=1770298966;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GDzgMbZmK6TIECiS2445LXqg7oI2wOpfTfzYF6w3p+0=;
        b=sWoMR00nd8+8kZUddlhG7ZLi1YwbrojKAv+RJm4uyPDOv7HTSqppMO0I2WsPgujz75
         fvRLfNIhuetZyVt/UxN766mpSJJVohVM/+UQHAIpLbm/71t7Qpw1lfYvYF9zPyjnOuEV
         nLbo3AcpWItfwwnxchwEkrrSKY78gTZ1GM0EpJfouywUKkAvtpLeUKZEOrFrE+G5UgLk
         mfmBFfVyVXub7nGzO6pDj60LDIA82wouqSApx63qXIQzq6osFSzaTDgzRL0OOvfohZck
         y+prdmIcHjsy8cpqapJWJ5YDP6HYxu8VKwWkC2dMvteKx+iaGf2C5IKw+YgflzKT6ujA
         6eOg==
X-Forwarded-Encrypted: i=1; AJvYcCWzS/zMEI3wpN8BPG84NZ6jkY/uRsQk6fQPSgbAL+bZoKnu4eQtC7Iu9ivhcCQnMTpti+6rnbaq@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8WqVy3Iz/J5CALgrsPK/B2fUEozLyMnpl4XcltWUzRTd4K0xO
	4allWrKBmIsANg7KWjrtmhh+QAGKqLC5TrIV/naETp6fxhYpz1PhYJR7wNwZdog5o84=
X-Gm-Gg: AZuq6aJXG21GAwLRkGskYBOgDcYdtZCiOQ0qcew32ZSOmBhPmG93uv3dcxi8imIU5vc
	e1f6feHDfZR07IcZnD4X4DmiPtHH6pcTtwb8SAFnxBdXsCPXMlW4ISJ43sEg8qFwvafFLPjqRnU
	ucDKBsd8i1kTf+bEV2KSuIMmgdPk9Ls9EFPRBGX4GsBaNjJ/MuKvFGaYl7PN6mZVjzMcIKhXLKm
	88oNrHQ0bbv3gL/sS2GjCjp2KHraj5z1L50waIJKsG5ooK9o8dwRtD0TY8K3lGC7z/qCw+OeS/U
	qyYWlwF1zEOvW85LuLIXzrzR8O0GDuQMFMNgxSaBwqxvC+J/8PGdruiyGKoJmfruW6JPt3PE/5P
	iPMSFr1B/4QI8AGiz0xtJYjJzMLmq7zGtfZov1MvhPclfStvCNMGuxqQwN+Pa2s8TYNh/ZqV8MV
	1KqrPkKDsfJY7wGhBtPZRjG2DUFRZBRXdmaC3OQtdNRtM32lXkHbHk+x7gqUdeJs+72/E=
X-Received: by 2002:a05:622a:15c6:b0:4ee:1563:2829 with SMTP id d75a77b69052e-5032fa1cc0fmr108491201cf.72.1769694166378;
        Thu, 29 Jan 2026 05:42:46 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-162-112-119.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.112.119])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-894d3764eb6sm37167556d6.49.2026.01.29.05.42.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Jan 2026 05:42:45 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1vlSIH-00000009jxt-1Mph;
	Thu, 29 Jan 2026 09:42:45 -0400
Date: Thu, 29 Jan 2026 09:42:45 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Quentin Perret <qperret@google.com>
Cc: Sean Christopherson <seanjc@google.com>,
	Ackerley Tng <ackerleytng@google.com>,
	Alexey Kardashevskiy <aik@amd.com>, cgroups@vger.kernel.org,
	kvm@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org, linux-mm@kvack.org,
	linux-trace-kernel@vger.kernel.org, x86@kernel.org,
	akpm@linux-foundation.org, binbin.wu@linux.intel.com, bp@alien8.de,
	brauner@kernel.org, chao.p.peng@intel.com, chenhuacai@kernel.org,
	corbet@lwn.net, dave.hansen@intel.com, dave.hansen@linux.intel.com,
	david@redhat.com, dmatlack@google.com, erdemaktas@google.com,
	fan.du@intel.com, fvdl@google.com, haibo1.xu@intel.com,
	hannes@cmpxchg.org, hch@infradead.org, hpa@zytor.com,
	hughd@google.com, ira.weiny@intel.com, isaku.yamahata@intel.com,
	jack@suse.cz, james.morse@arm.com, jarkko@kernel.org,
	jgowans@amazon.com, jhubbard@nvidia.com, jroedel@suse.de,
	jthoughton@google.com, jun.miao@intel.com, kai.huang@intel.com,
	keirf@google.com, kent.overstreet@linux.dev,
	liam.merwick@oracle.com, maciej.wieczor-retman@intel.com,
	mail@maciej.szmigiero.name, maobibo@loongson.cn,
	mathieu.desnoyers@efficios.com, maz@kernel.org, mhiramat@kernel.org,
	mhocko@kernel.org, mic@digikod.net, michael.roth@amd.com,
	mingo@redhat.com, mlevitsk@redhat.com, mpe@ellerman.id.au,
	muchun.song@linux.dev, nikunj@amd.com, nsaenz@amazon.es,
	oliver.upton@linux.dev, palmer@dabbelt.com, pankaj.gupta@amd.com,
	paul.walmsley@sifive.com, pbonzini@redhat.com, peterx@redhat.com,
	pgonda@google.com, prsampat@amd.com, pvorel@suse.cz,
	richard.weiyang@gmail.com, rick.p.edgecombe@intel.com,
	rientjes@google.com, rostedt@goodmis.org, roypat@amazon.co.uk,
	rppt@kernel.org, shakeel.butt@linux.dev, shuah@kernel.org,
	steven.price@arm.com, steven.sistare@oracle.com,
	suzuki.poulose@arm.com, tabba@google.com, tglx@linutronix.de,
	thomas.lendacky@amd.com, vannapurve@google.com, vbabka@suse.cz,
	viro@zeniv.linux.org.uk, vkuznets@redhat.com, wei.w.wang@intel.com,
	will@kernel.org, willy@infradead.org, wyihan@google.com,
	xiaoyao.li@intel.com, yan.y.zhao@intel.com, yilun.xu@intel.com,
	yuzenghui@huawei.com, zhiquan1.li@intel.com
Subject: Re: [RFC PATCH v1 05/37] KVM: guest_memfd: Wire up
 kvm_get_memory_attributes() to per-gmem attributes
Message-ID: <20260129134245.GD2307128@ziepe.ca>
References: <cover.1760731772.git.ackerleytng@google.com>
 <071a3c6603809186e914fe5fed939edee4e11988.1760731772.git.ackerleytng@google.com>
 <07836b1d-d0d8-40f2-8f7b-7805beca31d0@amd.com>
 <CAEvNRgEuez=JbArRf2SApLAL0usv5-Q6q=nBPOFMHrHGaKAtMw@mail.gmail.com>
 <20260129003753.GZ1641016@ziepe.ca>
 <aXqx3_eE0rNh6nP0@google.com>
 <20260129011618.GA2307128@ziepe.ca>
 <i22yykvttpc2e4expluuzucczqnetdnpee2wx2fzqwg7cnt45x@ovx7e7hok5iz>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <i22yykvttpc2e4expluuzucczqnetdnpee2wx2fzqwg7cnt45x@ovx7e7hok5iz>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[ziepe.ca:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[google.com,amd.com,vger.kernel.org,kvack.org,kernel.org,linux-foundation.org,linux.intel.com,alien8.de,intel.com,lwn.net,redhat.com,cmpxchg.org,infradead.org,zytor.com,suse.cz,arm.com,amazon.com,nvidia.com,suse.de,linux.dev,oracle.com,maciej.szmigiero.name,loongson.cn,efficios.com,digikod.net,ellerman.id.au,amazon.es,dabbelt.com,sifive.com,gmail.com,goodmis.org,amazon.co.uk,linutronix.de,zeniv.linux.org.uk,huawei.com];
	DKIM_TRACE(0.00)[ziepe.ca:+];
	MIME_TRACE(0.00)[0:+];
	DMARC_NA(0.00)[ziepe.ca];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-13514-lists,cgroups=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jgg@ziepe.ca,cgroups@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_GT_50(0.00)[97];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,ziepe.ca:mid,ziepe.ca:dkim]
X-Rspamd-Queue-Id: A4857B0816
X-Rspamd-Action: no action

On Thu, Jan 29, 2026 at 11:10:12AM +0000, Quentin Perret wrote:

> A not-fully-thought-through-and-possibly-ridiculous idea that crossed
> my mind some time ago was to make KVM itself a proper dmabuf
> importer. 

AFAIK this is already the plan. Since Intel cannot tolerate having the
private MMIO mapped into a VMA *at all* there is no other choice.

Since Intel has to build it it I figured everyone would want to use it
because it is probably going to be much faster than reading VMAs.

Especially in the modern world of MMIO BARs in the 512GB range.

> You'd essentially see a guest as a 'device' (probably with an
> actual struct dev representing it), and the stage-2 MMU in front of it
> as its IOMMU. That could potentially allow KVM to implement dma_map_ops
> for that guest 'device' by mapping/unmapping pages into its stage-2 and
> such. 

The plan isn't something so wild..

https://github.com/jgunthorpe/linux/commits/dmabuf_map_type/

The "Physical Address List" mapping type will let KVM just get a
normal phys_addr_t list and do its normal stuff with it. No need for
hacky DMA API things.

Probably what will be hard for KVM is that it gets the entire 512GB in
one shot and will have to chop it up to install the whole thing into
the PTE sizes available in the S2. I don't think it even has logic
like that right now??

> It gets really funny when a CoCo guest decides to share back a subset of
> that dmabuf with the host, and I'm still wrapping my head around how
> we'd make that work, but at this point I'm ready to be told how all the
> above already doesn't work and that I should go back to the peanut
> gallery :-)

Oh, I don't actually know how that ends up working but I suppose it
could be meaningfully done :\

Jason

