Return-Path: <cgroups+bounces-11938-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id DC468C59D22
	for <lists+cgroups@lfdr.de>; Thu, 13 Nov 2025 20:44:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 092DE353092
	for <lists+cgroups@lfdr.de>; Thu, 13 Nov 2025 19:43:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D84131DDA9;
	Thu, 13 Nov 2025 19:42:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Syi10JMh"
X-Original-To: cgroups@vger.kernel.org
Received: from out-184.mta0.migadu.com (out-184.mta0.migadu.com [91.218.175.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3EF831C587
	for <cgroups@vger.kernel.org>; Thu, 13 Nov 2025 19:42:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763062941; cv=none; b=ZAz8fhpw9yyydwU5uNqut+J7qN7a1Ej1TznQWeGLYOltR4bpQ/NzAXSBBhzNniUzWfifgL3dc3vy8ZFDsJE7PAAsuczqTzBwg8jwLFljuLOgynY4SHUliat8eXlvb1WoIHkU5BgVCOzYGuKHHZCmPf2fdhpZsAuXX/XegTmqULg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763062941; c=relaxed/simple;
	bh=KacQeloJ5OEAmFXcnqvTaiNz947IeebOrzMoZupZ6Ik=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qpoTvODJJK+r0D1xB1WfCrqATffaEWQYC6jKOnwPwzECo+Vt8qlzM6lMUFhdHA+5Ue95i1vrrKCQ47YY6b08tizopFWgbZtGzoFwlWah8XBNDcsWdYY0iTkLrT0yCrV7tEUSZIYDeNJUK6f6hTQ8DcSW4BpMsWUJ7o3M7OPN0NI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Syi10JMh; arc=none smtp.client-ip=91.218.175.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Thu, 13 Nov 2025 11:42:01 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1763062926;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=sr+mE/g9A7nLUx9cy3iGddinYybt/5wEHuhrAkq86kM=;
	b=Syi10JMh/3pP9J2K8fisk3iwRdinsLLiZtkCbfgUsEu2LDgYB5sTFbxcKYmw7xS7oDpEuy
	5i9qHRz0S+E2gRTnqHtNhSWgythBX5oHLj5hiE6cQ30w2Si/LMHIAatTVb8uo6C2s5H1ld
	TcjPghaJzzR0/cGEifyoEMpcZ0VDwko=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Johannes Weiner <hannes@cmpxchg.org>, 
	"Matthew Wilcox (Oracle)" <willy@infradead.org>, Andrew Morton <akpm@linux-foundation.org>, 
	Christoph Lameter <cl@gentwo.org>, David Rientjes <rientjes@google.com>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Harry Yoo <harry.yoo@oracle.com>, linux-mm@kvack.org, 
	Michal Hocko <mhocko@kernel.org>, Muchun Song <muchun.song@linux.dev>, cgroups@vger.kernel.org
Subject: Re: [PATCH v4 14/16] memcg: Convert mem_cgroup_from_obj_folio() to
 mem_cgroup_from_obj_slab()
Message-ID: <offnmou66hzgrlbb7owyya6n4onn2g5iuv7matbqfvsigg6wv3@3hlu55yai42z>
References: <20251113000932.1589073-1-willy@infradead.org>
 <20251113000932.1589073-15-willy@infradead.org>
 <20251113161424.GB3465062@cmpxchg.org>
 <45ea66a3-bf8b-4c12-89cd-d15ba26763fa@suse.cz>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <45ea66a3-bf8b-4c12-89cd-d15ba26763fa@suse.cz>
X-Migadu-Flow: FLOW_OUT

On Thu, Nov 13, 2025 at 05:28:59PM +0100, Vlastimil Babka wrote:
> > E.g. !vmap kernel stack pages -> mod_lruvec_kmem_state -> mem_cgroup_from_obj_slab
> > 
> > How about:
> > 
> > 	if ((slab = virt_to_slap(p)))
> > 		return mem_cgroup_from_obj_slab(slab, p);
> > 	return folio_memcg_check(virt_to_folio(p), p);
> 
> page_memcg_check() maybe instead? we shouldn't get a tail page here, no?

Do you mean page_memcg_check(virt_to_page(p), p)? But virt_to_page(p)
can return tail page, right?

