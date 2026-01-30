Return-Path: <cgroups+bounces-13530-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sNCHAYIAfGlhJwIAu9opvQ
	(envelope-from <cgroups+bounces-13530-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Fri, 30 Jan 2026 01:51:14 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 71621B608C
	for <lists+cgroups@lfdr.de>; Fri, 30 Jan 2026 01:51:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4FA083013B7F
	for <lists+cgroups@lfdr.de>; Fri, 30 Jan 2026 00:51:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAA2F3043A2;
	Fri, 30 Jan 2026 00:51:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Z/FaQ/kg"
X-Original-To: cgroups@vger.kernel.org
Received: from out-179.mta0.migadu.com (out-179.mta0.migadu.com [91.218.175.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 680FD30E85E
	for <cgroups@vger.kernel.org>; Fri, 30 Jan 2026 00:51:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769734268; cv=none; b=NfnNLdDV3o3bBjOGDKlz3EwfIeDADuMs3pDTCtiNETuo0iIVzpwA6uhYdFS74rBJzQVaY0eJ4mnZ5TxAYK6MeQQjebMaDHL5tF+PJMFNuMavKL4mfcZG50qknm5qVgPStxIpeSDNWEdeYU4yREswTLuyn58a7ywQIE2dL42f3qM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769734268; c=relaxed/simple;
	bh=6YUrVNS2AcKSw9HSyU5YL7g03O3wVPFbJE99k3TJ5BE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=doZKFIwD3CAKOI5KdY3L4hAgP7GJKdulCDVthDTk6+XACaRBbvIm10Xu8wIGtAH6bJAtbIypTawsWDkUW/karcdkLuWJKFGX26fkmuoW722l1gb3/OAdWzmcdkthjJEr+rVylQb3h5jZu57KYCn+lnhIdFM3x0C/1tUDF9bO14o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Z/FaQ/kg; arc=none smtp.client-ip=91.218.175.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Thu, 29 Jan 2026 16:50:57 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1769734262;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3beR78siDEEmK2spAD/HgnCu/E4OotAxU6+k9E99kQg=;
	b=Z/FaQ/kgxOCkIdV9pj9isA31VgQFflC/MoNR38FryrcwIrK5Mas3RvcmCHNpwvvJWp4BSU
	u1jPf1N0mdSlIcRcEclZA5y4KSScu2Y3nwpAt87BQPqOY1spg5dQd3LjSS2HtQs5A6NZsX
	JDGHWhKyhKG9PMhWjxlqmTcvcshg0Ig=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Johannes Weiner <hannes@cmpxchg.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	Rik van Riel <riel@surriel.com>, Song Liu <songliubraving@fb.com>, 
	Kiryl Shutsemau <kas@kernel.org>, Usama Arif <usamaarif642@gmail.com>, 
	David Hildenbrand <david@kernel.org>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
	Zi Yan <ziy@nvidia.com>, Baolin Wang <baolin.wang@linux.alibaba.com>, 
	"Liam R . Howlett" <Liam.Howlett@oracle.com>, Nico Pache <npache@redhat.com>, 
	Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>, 
	Lance Yang <lance.yang@linux.dev>, Meta kernel team <kernel-team@meta.com>, linux-mm@kvack.org, 
	cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: khugepaged: fix NR_FILE_PAGES accounting in
 collapse_file()
Message-ID: <aXv_5Gl6L-1eXYQd@linux.dev>
References: <20260129184054.910897-1-shakeel.butt@linux.dev>
 <aXv8DjjJ3zqZEsgQ@cmpxchg.org>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aXv8DjjJ3zqZEsgQ@cmpxchg.org>
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-13530-lists,cgroups=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[linux-foundation.org,surriel.com,fb.com,kernel.org,gmail.com,oracle.com,nvidia.com,linux.alibaba.com,redhat.com,arm.com,linux.dev,meta.com,kvack.org,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[20];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[shakeel.butt@linux.dev,cgroups@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.dev:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[cgroups];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linux.dev:mid,linux.dev:dkim]
X-Rspamd-Queue-Id: 71621B608C
X-Rspamd-Action: no action

On Thu, Jan 29, 2026 at 07:32:14PM -0500, Johannes Weiner wrote:
> On Thu, Jan 29, 2026 at 10:40:54AM -0800, Shakeel Butt wrote:
> > @@ -2200,8 +2200,8 @@ static enum scan_result collapse_file(struct mm_struct *mm, unsigned long addr,
> >  	else
> >  		lruvec_stat_mod_folio(new_folio, NR_FILE_THPS, HPAGE_PMD_NR);
> >  
> > +	lruvec_stat_mod_folio(new_folio, NR_FILE_PAGES, HPAGE_PMD_NR);
> 
> The memcg breakage is more visible, but I think this has been broken
> for NUMA stats even longer. new_folio could also come from a different
> node than the subpages, after all.

Indeed you are right, so I should blame Kiryl instead of Song :P

> 
> >  	if (nr_none) {
> > -		lruvec_stat_mod_folio(new_folio, NR_FILE_PAGES, nr_none);
> >  		/* nr_none is always 0 for non-shmem. */
> >  		lruvec_stat_mod_folio(new_folio, NR_SHMEM, nr_none);
> 
> So AFAICT NR_SHMEM needs the same treatment.
> 
> It looks like that's been broken since f3f0e1d2150b ("khugepaged: add
> support of collapse for tmpfs/shmem pages").

Thanks, I will send v2 with correct handling of NR_SHMEM as well.

