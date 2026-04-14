Return-Path: <cgroups+bounces-15289-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ML2+CETy3WmMlQkAu9opvQ
	(envelope-from <cgroups+bounces-15289-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Tue, 14 Apr 2026 09:52:36 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 158863F6C1D
	for <lists+cgroups@lfdr.de>; Tue, 14 Apr 2026 09:52:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 20BC23010802
	for <lists+cgroups@lfdr.de>; Tue, 14 Apr 2026 07:52:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57B2A383C94;
	Tue, 14 Apr 2026 07:52:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="XsS8wses"
X-Original-To: cgroups@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ADEC3346B4;
	Tue, 14 Apr 2026 07:52:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776153148; cv=none; b=J6BN+/BhO1Wb+OPZCJl9/cA0MYlj0whvZCwsQFOfQSDOZawK5rcJNAHwjCtCjp0ZOIbADq+dbeigWuunXTHOk1zZ77lgXz4NnKCpHfvQsu2hbYLQXf85gk6ntY+0ViA41QrRb/DRDhNDYwy4+333yM1Spx+wZ47yclCo6Utl5xs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776153148; c=relaxed/simple;
	bh=Kr1LMwhdJOWLQWlocTKROvlTOl/ZC6wCJghvd+MVtFs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h58w5g4HMyVYwGNqXP9DA+YPdTLeLfk2SjH8xozUEIkoySC8uKvaAeKoyCeiwusPOj0kDLdy5gw6dJut7FA9eKmguNmkfnX2RbJ9GfusRp3FYUn6SdyUjVuqeGc439LWDAurXAM3ROgUYGNKyrOBhtX9X+F61E/+vpV7MavwMCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=XsS8wses; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=NTxaoTWsYIT6XinpmC611FM9scC20rVnNKMI/IZpFxY=; b=XsS8wsesxfQHJeuybXI9UlK1MH
	5Sksd8i1n8hsFjUjYeaSfkUHe0jE0+SqlsoUnoCGG8SErY8odbMf4TBWHD/CRawf0WlGVvTsbUt05
	l1xMx1w3D64214rmihWMGYe96OMd6PH7aZ5YcU9my2HHe/6AOtWlOF80RhZAEbPKm8m2ycaYZ+ukS
	d/OeQL8oHUpIdN9nIG54unA+EgsAkO8gihqjQKT6cQiC90JSgEhCRanOlc80xOFH5vLcnq70PrRWl
	PSgoPGw9CrKwYYK2Cmo6bbyRVDEx3mihLAWDPGHf2bpAMXou+5xrT9GLNEPXeq4m8g/VfWzeWnq/0
	zCmqhsLQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wCYZ4-0000000GvSy-0kII;
	Tue, 14 Apr 2026 07:52:06 +0000
Date: Tue, 14 Apr 2026 00:52:06 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Nhat Pham <nphamcs@gmail.com>
Cc: YoungJun Park <youngjun.park@lge.com>, kasong@tencent.com,
	Liam.Howlett@oracle.com, akpm@linux-foundation.org,
	apopple@nvidia.com, axelrasmussen@google.com, baohua@kernel.org,
	baolin.wang@linux.alibaba.com, bhe@redhat.com, byungchul@sk.com,
	cgroups@vger.kernel.org, chengming.zhou@linux.dev,
	chrisl@kernel.org, corbet@lwn.net, david@kernel.org,
	dev.jain@arm.com, gourry@gourry.net, hannes@cmpxchg.org,
	hughd@google.com, jannh@google.com, joshua.hahnjy@gmail.com,
	lance.yang@linux.dev, lenb@kernel.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	linux-pm@vger.kernel.org, lorenzo.stoakes@oracle.com,
	matthew.brost@intel.com, mhocko@suse.com, muchun.song@linux.dev,
	npache@redhat.com, pavel@kernel.org, peterx@redhat.com,
	peterz@infradead.org, pfalcato@suse.de, rafael@kernel.org,
	rakie.kim@sk.com, roman.gushchin@linux.dev, rppt@kernel.org,
	ryan.roberts@arm.com, shakeel.butt@linux.dev,
	shikemeng@huaweicloud.com, surenb@google.com, tglx@kernel.org,
	vbabka@suse.cz, weixugc@google.com, ying.huang@linux.alibaba.com,
	yosry.ahmed@linux.dev, yuanchu@google.com,
	zhengqi.arch@bytedance.com, ziy@nvidia.com, kernel-team@meta.com,
	riel@surriel.com
Subject: Re: [PATCH v5 00/21] Virtual Swap Space
Message-ID: <ad3yJiHuxT_-quHG@infradead.org>
References: <20260320192735.748051-1-nphamcs@gmail.com>
 <acQrQYHJgqof0yx4@yjaykim-PowerEdge-T330>
 <CAKEwX=NnHxpQKp9qBg2=r_euyjgxw2nHXjbgof3MymHTgJmRAQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKEwX=NnHxpQKp9qBg2=r_euyjgxw2nHXjbgof3MymHTgJmRAQ@mail.gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[infradead.org,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[infradead.org:s=bombadil.20210309];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[lge.com,tencent.com,oracle.com,linux-foundation.org,nvidia.com,google.com,kernel.org,linux.alibaba.com,redhat.com,sk.com,vger.kernel.org,linux.dev,lwn.net,arm.com,gourry.net,cmpxchg.org,gmail.com,kvack.org,intel.com,suse.com,infradead.org,suse.de,huaweicloud.com,suse.cz,bytedance.com,meta.com,surriel.com];
	TAGGED_FROM(0.00)[bounces-15289-lists,cgroups=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	DKIM_TRACE(0.00)[infradead.org:+];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_GT_50(0.00)[55];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hch@infradead.org,cgroups@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[cgroups];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 158863F6C1D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sat, Apr 11, 2026 at 06:40:44PM -0700, Nhat Pham wrote:
> > However, if the modularization from point 1 is achieved and
> > vswap acts as a swap device itself, then we can cleanly
> > establish a:
> >
> >   virtual -> physical
> 
> I read that thread sometimes ago. Some remarks:
> 
> 1. I think Christoph has a point. Seems like some of your ideas ( are
> broadly applicable to swap in general. Maybe fixing swap infra
> generally would make a lot of sense?

I think a first step would be a dump of that code, even if it is against
an old kernel so that everyone knows what we are talking about.

> 2. Why do we need to do two virtual layers here? For example, If you
> want to buffer multiple swap outs and turn them into a sequential
> request, you can:
> 
> a. Allocate virtual swap space for them as you wish. They don't even
> need to be sequential.
> 
> b. At swap_writeout() time, don't allocate physical swap space for
> them right away. Instead, accumulate them into a buffer. You can add a
> new virtual swap entry type to flag it if necessary.
> 
> c. Once that buffer reaches a certain size, you can now allocate
> contiguous physical swap space for them. Then flush etc. You can flush
> at swap_writeout() time, or use a dedicated threads etc.

That matches what file systems do with delalloc, where space 2 just
adjust an in-memory counter for space reservations.

> Deduplication sounds like something that should live at a lower layer
> - I was thinking about it for zswap/zsmalloc back then. I mean, I
> assume you don't want content sharing across different swap media? :)
> Something along the line of:

Does dedup in swap really make much sense?  If you want to dedup you
also want to do that in-memory, i.e. using ksm.


