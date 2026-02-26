Return-Path: <cgroups+bounces-14426-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CKIuBIxOoGnvhwQAu9opvQ
	(envelope-from <cgroups+bounces-14426-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Thu, 26 Feb 2026 14:45:48 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E1041A6E0D
	for <lists+cgroups@lfdr.de>; Thu, 26 Feb 2026 14:45:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 114883190661
	for <lists+cgroups@lfdr.de>; Thu, 26 Feb 2026 13:39:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E108428489B;
	Thu, 26 Feb 2026 13:39:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="LAijfW77"
X-Original-To: cgroups@vger.kernel.org
Received: from out-174.mta0.migadu.com (out-174.mta0.migadu.com [91.218.175.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6123B223DC9
	for <cgroups@vger.kernel.org>; Thu, 26 Feb 2026 13:39:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772113159; cv=none; b=jCFzGxs5bNL9m9YZqlvzfGD/Io3ayHTkeGp+DShyaWWyU+oZeo2wYJdlTo8e1W6z0c2+9zZv0T4wp4wcleLF68mLgcgHVzmp7+SAT1zRhphiNA3poFPLUFVH9C1w24qgaf8mzCE1JYq8nEa+N8tmRO/BK1R0GZ62WJly8Z69an4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772113159; c=relaxed/simple;
	bh=jR5uv885HDHBxmpRoseRMzHbHsp7+BQHhZndtKyuCCk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OSXfIDeQDejWuiIdmSUeJHpRXlKRrginvdrydKbGvMfzQK6KeeAcACMNSBTQnxp1SvcKinyYJz7P6xcqrRF+3P4A8+PDff19sJyF4U6PuRaU1eAVu/ujXvw0R7T3QYCc5mEi3fJz0akjtlG7ZWNUhj8sR3AsG+vVnlDpc/oIT4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=LAijfW77; arc=none smtp.client-ip=91.218.175.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Thu, 26 Feb 2026 05:39:00 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1772113146;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=86+mXi9L/gLCLWNcu/Z+GG/qwyq3WnOhFFQzn1lQbCg=;
	b=LAijfW77YpuG22Udq9aazERjZ8rTXISFn3fH5kBDmQyvSHGoPNpQ+xcI7gfApl3um0jHeE
	xM6Gn1o1IeCYWqFgomAd8+WnhYKXcBO25ybeGr87DGNuujH5q0F77ZPmn1rMQ3Z4eBIaxZ
	QImFVIzvMNhaGFpSh9Vmf3kWUBxbJjo=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Hao Li <hao.li@linux.dev>
Cc: hannes@cmpxchg.org, mhocko@kernel.org, roman.gushchin@linux.dev, 
	vbabka@suse.cz, harry.yoo@oracle.com, muchun.song@linux.dev, 
	akpm@linux-foundation.org, cgroups@vger.kernel.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] memcg: fix slab accounting in refill_obj_stock() trylock
 path
Message-ID: <aaBM0fN8fqER7Avf@linux.dev>
References: <20260226115145.62903-1-hao.li@linux.dev>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260226115145.62903-1-hao.li@linux.dev>
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-14426-lists,cgroups=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	DKIM_TRACE(0.00)[linux.dev:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[shakeel.butt@linux.dev,cgroups@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[cgroups];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:mid,linux.dev:dkim,linux.dev:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 5E1041A6E0D
X-Rspamd-Action: no action

On Thu, Feb 26, 2026 at 07:51:37PM +0800, Hao Li wrote:
> In the trylock path of refill_obj_stock(), mod_objcg_mlstate() should
> use the real alloc/free bytes (i.e., nr_acct) for accounting, rather
> than nr_bytes.
> 
> Fixes: 200577f69f29 ("memcg: objcg stock trylock without irq disabling")
> Cc: stable@vger.kernel.org
> Signed-off-by: Hao Li <hao.li@linux.dev>

Thanks for the fix.

Acked-by: Shakeel Butt <shakeel.butt@linux.dev>

