Return-Path: <cgroups+bounces-13497-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EOCgN4a2emma9QEAu9opvQ
	(envelope-from <cgroups+bounces-13497-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Thu, 29 Jan 2026 02:23:18 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D3B8AAA82
	for <lists+cgroups@lfdr.de>; Thu, 29 Jan 2026 02:23:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 19809306DFE7
	for <lists+cgroups@lfdr.de>; Thu, 29 Jan 2026 01:18:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBD7D33D6D8;
	Thu, 29 Jan 2026 01:16:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="JimtEvw/"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 588EC33E35F
	for <cgroups@vger.kernel.org>; Thu, 29 Jan 2026 01:16:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769649383; cv=none; b=g1aMO6i+JsGERTgzh7NoyPK6shwslj4po+tbdlOV+p8qZuLWXxxP42QdnRhMqA33PjVmtZbl9nuAgigUor6gng0JoEInbTt6GsZej8fJK8tTqXk3ztYE4Z0C5czD0ksq+YI08T9J9TpOF3Wus46BA2DC5orOwJ1ScYZCOAZ9TIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769649383; c=relaxed/simple;
	bh=nHJ7z1F0QJ+ff3YYPLezHicV71ohVDGuIQUyQzSTkzQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NbnrojcSQMMWolc5G4jDX6UwcJ14ondqRD/gGaNiCFRKeSSIM/vtdg67s8GXYBHYN3lRhWeHEOpjUZ8sevOoM0ENHn9VagrhdI8ttHVYHlk4mWZiiJuOP5N0jPqHKokouUQNt3tyKcfXG2gjupAp1nqwO/r9Wc4OWl1PI03dxpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=JimtEvw/; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-8c717f2b654so71054185a.0
        for <cgroups@vger.kernel.org>; Wed, 28 Jan 2026 17:16:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1769649380; x=1770254180; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=WReYS7VDfIh+dvxdrk0biwhaBbpxlirvLLAI4b8c7GA=;
        b=JimtEvw/M9s1zQiNQoK5XBOJVKAPBC0ZPH+Ww+nhg7HM120zXzPPDFQ66dxw3qVIkh
         41KFAv5+ldYueku3BLZMrAHudLNNK/pjzR325IvCVYgAjfezrdFp+Ypjnmcs8Z2WWpms
         Hnkz7ru3rUgn6MmQTBlVKZp0y6quJVwOYGhjcKcvZIbHB6f3VZF4HrJ7ENAeKE+2Ukuy
         zFMq8IZPJX1HkYQk1TQQorMGWwZZ6+bCDV3o+M0HD2kYBy6jefimyqAQy7F5U5BqRVtD
         kUo6mdW+EKWp7Wa5NI1ztftQRXc17I8/6KEDYfze9hhVxHgoa/rcyB0qcWZAHLRDjYK9
         vixQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769649380; x=1770254180;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WReYS7VDfIh+dvxdrk0biwhaBbpxlirvLLAI4b8c7GA=;
        b=NgZTu2cMcQWG9ZabWAlDdmceVQO8FVFzYejhPgo23bi20UlOaltSx4giROPDdu1u22
         cTHOGm7ARnIChWBC4tcU3+g9OEQD2X2nLNpd50zuDlZz0Vu6CIC4OayvjNK/gBaZUufo
         SbjeqlHJquYI6A+IrEXPXOE+lFU+eROjVqjDSpsiW+RgGUvMbIU4WnyWUupmkTPOBuIj
         gQ5i604l7J2rQF0wTVorpyLZfoEA1Or37pHbVXJCRYUT/CQJQNdrEOq6IFn1dGTwq/Mo
         eqiFJdpk3EdCp8OCkaWbquE0ZovXPqjGBdUr0bLlin85AyM0g18N9iWRzDogKeX09J+d
         JOXw==
X-Forwarded-Encrypted: i=1; AJvYcCUufjPqopsv8ak5hLykVNe6ON4XAnqR9BSdx1m7L6GWv9InVA4FnoWfHOnYoxe1GVJ0BvmCJxlu@vger.kernel.org
X-Gm-Message-State: AOJu0YwnD1zlZtZYPDVxymeYrQbbwR3aIOR9+w9TRcI53NUoLoDUtgr9
	HYlZlYYtY3oV+Gx1Al/3gYQuy8Oaj/Ir5XGhVNYS99thTt06YhxCJsceaddnrHkN0i4=
X-Gm-Gg: AZuq6aKLacP+l/PajiWama4IKv6+7kmqdoxnY7jyngGF0H9bpJZF8vjIVCCFmeiyVki
	lKIWsYnF9wR5cuyauoZSzTXVCsfZVMLz+CyldDPXTRg2h67BTPvF2l+PTup3D93Fv7FkiMNPYip
	6yYPNYjBEOnRd7wMxmMrarZQd9PVXDOQOrxWxtZ/V2rF0EmGWa7DlS2VG7JVpABJUBlcY5B1gcv
	nvZ4bCciV8ph/i4CS47UKpnZahQ8qjGXKvtjREELDpWUy8Swm0T9FOqf17kjPbMFcsjNjPR9hgh
	ZHi5GwiZUYGXHIjuuKPeCpDF5P8vDJtFINspDK2SXb7KlfK0iPXjpsLwBtlR9HuE+ZjDSjQRmOy
	Uj9ZlMyoU0X1di6IjXCS8oHnbQaK3tTSvrk/tRYgt8mmrEaB3EUhlwpM0+1W/qL8F19VtjXx3nU
	J3a5klGV72nEuKYBJ6FdjkxPFd81qd6cqlzUlBkq5Mn8FhCJKvAVxVjP+4SU+QGGdOvkQ=
X-Received: by 2002:a05:620a:d88:b0:8c5:2ce6:dca with SMTP id af79cd13be357-8c70b841159mr939733985a.6.1769649380018;
        Wed, 28 Jan 2026 17:16:20 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-162-112-119.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.112.119])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8c711d2ab04sm283038485a.25.2026.01.28.17.16.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jan 2026 17:16:19 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1vlGdu-00000009gKo-3mMh;
	Wed, 28 Jan 2026 21:16:18 -0400
Date: Wed, 28 Jan 2026 21:16:18 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Sean Christopherson <seanjc@google.com>
Cc: Ackerley Tng <ackerleytng@google.com>,
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
	qperret@google.com, richard.weiyang@gmail.com,
	rick.p.edgecombe@intel.com, rientjes@google.com,
	rostedt@goodmis.org, roypat@amazon.co.uk, rppt@kernel.org,
	shakeel.butt@linux.dev, shuah@kernel.org, steven.price@arm.com,
	steven.sistare@oracle.com, suzuki.poulose@arm.com, tabba@google.com,
	tglx@linutronix.de, thomas.lendacky@amd.com, vannapurve@google.com,
	vbabka@suse.cz, viro@zeniv.linux.org.uk, vkuznets@redhat.com,
	wei.w.wang@intel.com, will@kernel.org, willy@infradead.org,
	wyihan@google.com, xiaoyao.li@intel.com, yan.y.zhao@intel.com,
	yilun.xu@intel.com, yuzenghui@huawei.com, zhiquan1.li@intel.com
Subject: Re: [RFC PATCH v1 05/37] KVM: guest_memfd: Wire up
 kvm_get_memory_attributes() to per-gmem attributes
Message-ID: <20260129011618.GA2307128@ziepe.ca>
References: <cover.1760731772.git.ackerleytng@google.com>
 <071a3c6603809186e914fe5fed939edee4e11988.1760731772.git.ackerleytng@google.com>
 <07836b1d-d0d8-40f2-8f7b-7805beca31d0@amd.com>
 <CAEvNRgEuez=JbArRf2SApLAL0usv5-Q6q=nBPOFMHrHGaKAtMw@mail.gmail.com>
 <20260129003753.GZ1641016@ziepe.ca>
 <aXqx3_eE0rNh6nP0@google.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aXqx3_eE0rNh6nP0@google.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
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
	TAGGED_FROM(0.00)[bounces-13497-lists,cgroups=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jgg@ziepe.ca,cgroups@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCPT_COUNT_GT_50(0.00)[97];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,ziepe.ca:mid,ziepe.ca:dkim]
X-Rspamd-Queue-Id: 5D3B8AAA82
X-Rspamd-Action: no action

On Wed, Jan 28, 2026 at 05:03:27PM -0800, Sean Christopherson wrote:

> For a dmabuf fd, the story is the same as guest_memfd.  Unless private vs. shared
> is all or nothing, and can never change, then the only entity that can track that
> info is the owner of the dmabuf.  And even if the private vs. shared attributes
> are constant, tracking it external to KVM makes sense, because then the provider
> can simply hardcode %true/%false.

Oh my I had not given that bit any thought. My remarks were just about
normal non-CC systems.

So MMIO starts out shared, and then converts to private when the guest
triggers it. It is not all or nothing, there are permanent shared
holes in the MMIO ranges too.

Beyond that I don't know what people are thinking.

Clearly VFIO has to revoke and disable the DMABUF once any of it
becomes private. VFIO will somehow have to know when it changes modes
from the TSM subsystem.

I guess we could have a special channel for KVM to learn the
shared/private page by page from VFIO as some kind of "aware of CC"
importer.

I suppose AMD needs to mangle the RMP when it changes, and KVM has to
do that.

I forget what ARM does, but I seem to recall there is a call to create
a vPCI function and that is what stuffs the S2? So maybe KVM isn't
even involved? (IIRC people were talking that something else would
call the vPCI function but I haven't seen patches)

No idea what x86 does beyond it has to unmap all the MMIO otherwise
the machine crashes :P

Oh man, what a horrible mess to even contemplate. I'm going to bed.

Jason

