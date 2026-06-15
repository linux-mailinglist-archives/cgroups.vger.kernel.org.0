Return-Path: <cgroups+bounces-16942-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id iI99MTHIL2pVGQUAu9opvQ
	(envelope-from <cgroups+bounces-16942-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Mon, 15 Jun 2026 11:38:57 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5233D6851DA
	for <lists+cgroups@lfdr.de>; Mon, 15 Jun 2026 11:38:57 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gourry.net header.s=google header.b=cMw1C28+;
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-16942-lists+cgroups=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="cgroups+bounces-16942-lists+cgroups=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 31F67302E93D
	for <lists+cgroups@lfdr.de>; Mon, 15 Jun 2026 09:38:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 016813DB30C;
	Mon, 15 Jun 2026 09:38:47 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 846833DA5B7
	for <cgroups@vger.kernel.org>; Mon, 15 Jun 2026 09:38:44 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781516326; cv=none; b=g+ZmZb9GtmIyvSxmCF+HBWvZn/VyvxOWEVF6a3s5unxc04poKBqqIWKKpQTzXUXd1+dDIrlPGTe78xsb7stB24olxcywKJUdsTQwg0FaxJ/opQMlqNsrb4npnPsRDyE079PiIxgjCNd5a00EKtUt6E64VPnw9GINtZTX6Bu9gcE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781516326; c=relaxed/simple;
	bh=5W9S4pgDg4/wNgsNm7pUUV0vbqnLkdd/LqkUgfe2UH8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WdSEjEVaphkLbLO/VDkFXb21T78wn3kXRXIP+NaeEAuFKJ5wBMtqQYFDnnS1V97KMriq1RWNSjjwPujRjVyAimkaIOgL1idV85zhi5bHaLezniTOuOz4UzxX4uRclyWaeH/RQI2C5olUZ2fgj/QhQdLLWKK8o7YJzFhGddmxxLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=cMw1C28+; arc=none smtp.client-ip=209.85.219.44
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-8ccef25789fso23793646d6.3
        for <cgroups@vger.kernel.org>; Mon, 15 Jun 2026 02:38:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1781516323; x=1782121123; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=oamN5hjWi+TCb5PPsVj9eSoiuDSUof3U7OYNH2/rvIc=;
        b=cMw1C28+9tJYOQ7hVT3DvNUY4YjCbCe2Ok9i4q/E05Sur6rmTz9O2dcb3COWbmXt/i
         a0vynKs0BbsB90oTaKZ8uvD1N8mde9+hkviXYyugr7IApL7yiNOadkidIRZoZ2Cm39uB
         5JLaETSbJ+soFLeS1g9CNT6yAX4/6tbO/oskVDeWFOC6J6KEux9/yF3aNbSaXwF86rkh
         r8Xt49c87Hl1BEuRmhVsYwEs+kyN7FG3lnGUzTqqW73HeMKb9h5E91yzGvCw+OhwiCeo
         1eo9t3zZC0Fd7dPA0Q8ARRYLPxbNitfRNOcr3ao143B8K2T+mqJpeGr5cOoH0w2Wc13s
         w/IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781516323; x=1782121123;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oamN5hjWi+TCb5PPsVj9eSoiuDSUof3U7OYNH2/rvIc=;
        b=UgD/0AW8Iezuxd1Z7KFKrgAia+vgd7L9NQlJ3IVJ/wgMa1NF29kinJxN+XCOq7/42S
         2Lyv/soqpSlOM+zhh/8Lgh/RXOs/KH7zYgjLJ4Or89+Vt1+OuriZ1G7ANn4eOVfymgOE
         LLguLYTWvW0D7RYoEGkwUlXLKMmnSlhxNST9M90Mk1vPZ9lMc0k1M8zVqTdV1KkstPJg
         0PpJ139p3bBompLw8+U8L4sCeQdMCuoOz05ckioVRl2CkFSwemUNzWWHUBuz+0TCzxSP
         VssDwg1aeLYKAmLJxy8voYGDlDqtlVTOT/kVAj7WH8acIbQ1vEfzVgyPMATUdN4+vdqM
         VCZw==
X-Forwarded-Encrypted: i=1; AFNElJ+l5/UjBI7IkQE0Jlbrbqfda+N+sc4gDjVOFox77HzvVREmQrRqSJBjgTbfdjAlczNTLhZ56eVC@vger.kernel.org
X-Gm-Message-State: AOJu0YyUBMf4NzEUpY98lBU/NZ1G82J6ofP+0IBaH6BmiOHBJdScscTG
	XgRsWRBirvxRTRK21QlrWzkPdH/D/MgrrXxYN6xUtfVRRWF7zSNl9nePcNe3EQVpH3M=
X-Gm-Gg: Acq92OEYnzkuOfqwQEJ0uJAi9ExoRaMkP1GA4khvvQ/fr4/kKav0KDdOjPN0y69rR77
	PcNlAPwhQ+hOGjv2mIaIWB003htKDr5FLmz+fX/smGfMHQy9xcF6ctBVX5tqsWWTyjBYPWYzj6U
	0Sa8rKotzsHDzPHBBHhYHDKNBZEV2ENPhuYPyBodZXFdnsbdv7qgipErNtVLJsgygPaXa900vHT
	VADfgBDzuFSTlvjpN7EfdsmeFukjs1tdDtJ34QCxl9FwHUi8JKFoaEWjvRDb4DbekYsMr+VIm3g
	J4PEXbI/XkcUNg3mgC9iHI5BIYL3ooCCiY1MCchyelqPdqUJwXWc0DYA4+0scKRcv/AREv6bp6Q
	Z0dMwqzDvxuDVIhbgfgDqZpGe7Y4nNYeSiCrUnwNwA+roUGpiWzPzvR45OLlSHr4DziM3KkM9D8
	/7WUuqcxLGHJybX92+iphXGFeLgZazm2BAGCd8ewx/bVyBt7Hil7t5hM71ZXucHz3LU+i2iYgII
	3rrC8Cy9TI37TU=
X-Received: by 2002:a05:6214:5907:b0:8cb:e63e:2a45 with SMTP id 6a1803df08f44-8d32c4eb32emr217014056d6.18.1781516323361;
        Mon, 15 Jun 2026 02:38:43 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (158-94-182-130.mclarenap.oninferno.net. [158.94.182.130])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8d301c237e8sm108166456d6.17.2026.06.15.02.38.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jun 2026 02:38:42 -0700 (PDT)
Date: Mon, 15 Jun 2026 05:38:38 -0400
From: Gregory Price <gourry@gourry.net>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: Farhad Alemi <farhad.alemi@berkeley.edu>,
	Andrew Morton <akpm@linux-foundation.org>,
	Waiman Long <longman@redhat.com>, Farhad Alemi <falemi@asu.edu>,
	Yury Norov <ynorov@nvidia.com>,
	Joshua Hahn <joshua.hahnjy@gmail.com>, Zi Yan <ziy@nvidia.com>,
	Matthew Brost <matthew.brost@intel.com>,
	Rakie Kim <rakie.kim@sk.com>, Byungchul Park <byungchul@sk.com>,
	Ying Huang <ying.huang@linux.alibaba.com>,
	Alistair Popple <apopple@nvidia.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v2] cgroup/cpuset: rebind mm mempolicy to effective_mems,
 not mems_allowed
Message-ID: <ai_IHvyptWPcTD0y@gourry-fedora-PF4VCD3F>
References: <CA+0ovCg05rUk1-3k2ysdxmbcER8aG-wVh9SSTrrbp6LPWpPHYA@mail.gmail.com>
 <CA+0ovCgfHJHv5d1mzapWWvF-LhjppzDX8NPPLvCPZxPKg8RiYw@mail.gmail.com>
 <8d3b4561-92cd-4ebc-8462-5fb0fd659e8a@kernel.org>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8d3b4561-92cd-4ebc-8462-5fb0fd659e8a@kernel.org>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gourry.net:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-16942-lists,cgroups=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[gourry.net];
	FORGED_SENDER(0.00)[gourry@gourry.net,cgroups@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[18];
	FORGED_RECIPIENTS(0.00)[m:david@kernel.org,m:farhad.alemi@berkeley.edu,m:akpm@linux-foundation.org,m:longman@redhat.com,m:falemi@asu.edu,m:ynorov@nvidia.com,m:joshua.hahnjy@gmail.com,m:ziy@nvidia.com,m:matthew.brost@intel.com,m:rakie.kim@sk.com,m:byungchul@sk.com,m:ying.huang@linux.alibaba.com,m:apopple@nvidia.com,m:linux@rasmusvillemoes.dk,m:linux-mm@kvack.org,m:linux-kernel@vger.kernel.org,m:cgroups@vger.kernel.org,m:stable@vger.kernel.org,m:joshuahahnjy@gmail.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[berkeley.edu,linux-foundation.org,redhat.com,asu.edu,nvidia.com,gmail.com,intel.com,sk.com,linux.alibaba.com,rasmusvillemoes.dk,kvack.org,vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gourry@gourry.net,cgroups@vger.kernel.org];
	DKIM_TRACE(0.00)[gourry.net:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,gourry.net:dkim,gourry.net:from_mime,gourry-fedora-PF4VCD3F:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 5233D6851DA

On Mon, Jun 15, 2026 at 10:08:51AM +0200, David Hildenbrand (Arm) wrote:
> On 6/14/26 15:25, Farhad Alemi wrote:
> > 
> > diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
> > --- a/kernel/cgroup/cpuset.c
> > +++ b/kernel/cgroup/cpuset.c
> > @@ -2649,7 +2649,7 @@ void cpuset_update_tasks_nodemask(struct cpuset *cs)
> > 
> >  		migrate = is_memory_migrate(cs);
> > 
> > -		mpol_rebind_mm(mm, &cs->mems_allowed);
> > +		mpol_rebind_mm(mm, &cs->effective_mems);
> 
> God this is confusing.
>

All interactions between mempolicy and cpuset are horrible and
confusing.  Much like Lorenzo's anon_vma work, I have to keep
notes on how this whole thing doesn't just spew SIGBUS constantly.

The short answer is: mempolicy is advisory and cpuset is strictly
followed - in a dispute cpuset wins... except for file backed memory,
then everyon loses and nothing is consistent.

> Naturally I wonder: Why are we not using "task->mems_allowed" (maybe cs vs. tsk
> was the original bug?), which is effectively just newmems?
>

Short answer: task->mems_allowed is protected by the task lock and we
don't hold the task lock for a foreign task (not-current) over mm
operations.

Long answer: Reasons and "Stop looking at the spaghetti, it's going to
break"

~Gregory

