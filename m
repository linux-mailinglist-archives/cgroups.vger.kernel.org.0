Return-Path: <cgroups+bounces-16234-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8G7HLtiqE2q8EgcAu9opvQ
	(envelope-from <cgroups+bounces-16234-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Mon, 25 May 2026 03:50:16 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 362BA5C5478
	for <lists+cgroups@lfdr.de>; Mon, 25 May 2026 03:50:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A2CD63007973
	for <lists+cgroups@lfdr.de>; Mon, 25 May 2026 01:50:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7032721A447;
	Mon, 25 May 2026 01:50:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="S8rhOAxu"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E225B23D7FF
	for <cgroups@vger.kernel.org>; Mon, 25 May 2026 01:50:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779673813; cv=none; b=dSnQsa1AM34JohUvme5EuUb0L7vML1+nSUn3RLb238lyiSb6R2FQf5lMv3/QLxItRQ9Pp2Uc9FDVsMO2BL4SioeasKjDblYggDQ/cs/1gYO8ZtkBSFGOFE60FxdBooIZlMgb8lJW+i8DBT+sc21LqaLXoUlvh+ub0F8FQJJkhYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779673813; c=relaxed/simple;
	bh=WItw+Ef2NecqHrR2z8eKezrYOTV9vVAproVcjHSpa8s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HVBeKoF7GslG+VkndsYRJWKF13ZUWHdW8Ijw2Mifrb1ewy52Fs8RDijboqKUA2OJRTX+30btryKTaIrw4oMax/kmn1oqJ9r+vtUTrBh28Bfp2jrx1hKS/C63eAvtK0XTkLfAQQL8P4P19YRnR8zAEJ9fzwncu7kmjU+Xli+vL74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=S8rhOAxu; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-51306c9f2a8so109929801cf.1
        for <cgroups@vger.kernel.org>; Sun, 24 May 2026 18:50:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1779673810; x=1780278610; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=HaMGwylp+AdTKGZZEDuVzWMLLa2CVFaFeY7VVe9bsb0=;
        b=S8rhOAxuUxvInQfgUiQ2mvxTf0rogF94vTf/QgcmXGhoA24Ha5G/S4dCF3bHuL7NV4
         ee8v7mwuRY6OD9yULJejS3qA3b5l4fsk+zLXBqLX00Y2mj97CyWZ6aAny/UfcpBAXi8W
         yAZI+dLYcP1cj2Tk+ngTgcEIy6neYCfIuki/MDttJsUTZ7szC0yJxi5lobNjvKq6ToPU
         XiiFKwQ+OhpcYufR+H26LzTP9W1+hGT2ym2ujh9qG5fUcS0so/h6KolHx4acaW5aUGsT
         HRqdBQm6HksZCzFY8aFkXofaHMnu+NOCzRys/xWdNmc3qkf8Ze1BBmq8OOwwxi/Cs/nR
         Iwng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779673810; x=1780278610;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HaMGwylp+AdTKGZZEDuVzWMLLa2CVFaFeY7VVe9bsb0=;
        b=lVft7UvzcUYXy6Kq1cmAUk4/+nvcgKxLpDsd67Xlf6zpyuQ+UfSGz/whKfCLPK1unc
         MX5qnjmqxUjh/RXk2xM/aih2KAY7ZAZZjHHR7bLqYiKAiOkfHp29hu/iEcRk2bSC1vgh
         CAq6UvCXXQsaU5TBhxtecEOT1/Z6z1rVCNLaeXrKxetwt4lAzmf2vXHnTfmTB9fhK/VS
         iSOOZO/yF8MUqOC5GrSlEBNEDAqlvqWOwdczd5hF3gxSWQ3vulqAnLbLiUqnaXAjAH27
         7/+6Qf/hAGeC4sFJviU8WpS8aCFwEPCH/yUO5vEvYe1QCfJLwGnyaYfZBXL0egZ5dSwS
         ZaIg==
X-Forwarded-Encrypted: i=1; AFNElJ9v/VCTo0vM3R7A1pI4qFuuXfe6IY6lou6gemhNMo9A7vfbmxMKN3vMyt9IDXD2tR3zrFA5WhcK@vger.kernel.org
X-Gm-Message-State: AOJu0YxlYQKS1SrG9acTg5edgK71H2DWCKkHT+5diKGYuG1T1MVoUw6k
	7R5X8kSdxsCI3sHMIVBgD5gxWoMwtq/tou7Y4FURkfmMrqs5oP+2fXvqaRh43LWGviQ=
X-Gm-Gg: Acq92OHfBLw9Fe0dOe6dvd7LkmRoCqtbMRv2cbHz8N8dUUnHV7AnzMfsMM05JPi8o1G
	QyL2jXTtGfCMmDSLhQrhLOvlvwLkuY4Y+CHaIqRwVRgZBviR7mBVJ4k2EH4eUYUPLFieCoRiyPH
	VW0IMEBEuCuj3K0heC9O33Gg8YbSg0btRGpKWGH4QVa+6z+hBo1eJlGybCNZKH+7OrhzCMVzytF
	KmkcU7ACEmljwCYH8/Xm6+9KMMZyyjC/+nu/YrwcQTBH9I0gUMzCj+AlAdVulB5jp5MxT0bdGDi
	qHEuNOEO4GZzXRktcKsxtzyKjmB3PG6Segddvjfl3i+JAYNJFChs58Pa3Mm+uOvAG+I3fLejHgL
	Iencx4DsdRtrqObCvdyRe9YojvOYkw4GdJIMYrVjeY4V6snlbtCXUMIm5f8xTfBt320GYB8TDwo
	xwzEbbOfHFlEYyhQ6ZwTScW4tb3Xl2W2yqOsgEiZ59i4IbFUtg/DJh5uXzwIsisnpW4kQY9yWto
	dRDJDwh5Vzl
X-Received: by 2002:a05:622a:480a:b0:516:e7d0:73ab with SMTP id d75a77b69052e-516e7d079c5mr94541371cf.40.1779673810351;
        Sun, 24 May 2026 18:50:10 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (pool-100-36-248-188.washdc.fios.verizon.net. [100.36.248.188])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-516d8cb9f11sm88159681cf.23.2026.05.24.18.50.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 May 2026 18:50:09 -0700 (PDT)
Date: Sun, 24 May 2026 21:50:06 -0400
From: Gregory Price <gourry@gourry.net>
To: Balbir Singh <balbirs@nvidia.com>
Cc: lsf-pc@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
	linux-cxl@vger.kernel.org, cgroups@vger.kernel.org,
	linux-mm@kvack.org, linux-trace-kernel@vger.kernel.org,
	damon@lists.linux.dev, kernel-team@meta.com,
	gregkh@linuxfoundation.org, rafael@kernel.org, dakr@kernel.org,
	dave@stgolabs.net, jonathan.cameron@huawei.com,
	dave.jiang@intel.com, alison.schofield@intel.com,
	vishal.l.verma@intel.com, ira.weiny@intel.com,
	dan.j.williams@intel.com, longman@redhat.com,
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
	bhe@redhat.com, zhengqi.arch@bytedance.com, terry.bowman@amd.com
Subject: Re: [LSF/MM/BPF TOPIC][RFC PATCH v4 00/27] Private Memory Nodes (w/
 Compressed RAM)
Message-ID: <ahOqzpzAua96HVkn@gourry-fedora-PF4VCD3F>
References: <20260222084842.1824063-1-gourry@gourry.net>
 <ag6XyvxR-NU5rGn-@parvat>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ag6XyvxR-NU5rGn-@parvat>
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[gourry.net:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-16234-lists,cgroups=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[gourry.net];
	FREEMAIL_CC(0.00)[lists.linux-foundation.org,vger.kernel.org,kvack.org,lists.linux.dev,meta.com,linuxfoundation.org,kernel.org,stgolabs.net,huawei.com,intel.com,redhat.com,linux-foundation.org,oracle.com,suse.cz,google.com,suse.com,suse.de,nvidia.com,gmail.com,sk.com,linux.alibaba.com,rasmusvillemoes.dk,efficios.com,cmpxchg.org,arm.com,linux.dev,zte.com.cn,surriel.com,gentwo.org,tencent.com,huaweicloud.com,bytedance.com,amd.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gourry.net:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gourry@gourry.net,cgroups@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_GT_50(0.00)[74];
	TAGGED_RCPT(0.00)[cgroups];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,gourry.net:email,gourry.net:dkim]
X-Rspamd-Queue-Id: 362BA5C5478
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, May 21, 2026 at 04:23:28PM +1000, Balbir Singh wrote:
> On Sun, Feb 22, 2026 at 03:48:15AM -0500, Gregory Price wrote:
> > Topic type: MM
> > 
> > Presenter: Gregory Price <gourry@gourry.net>
> > 
> > This series introduces N_MEMORY_PRIVATE, a NUMA node state for memory
> > managed by the buddy allocator but excluded from normal allocations.
> > 
> > I present it with an end-to-end Compressed RAM service (mm/cram.c)
> > that would otherwise not be possible (or would be considerably more
> > difficult, be device-specific, and add to the ZONE_DEVICE boondoggle).
> > 
> 
> Do we have updates/notes from the meeting?
> 

I have been on leave since LSF, but I do have some notes posted:

https://lore.kernel.org/linux-mm/af9i7dkNvGGxPHzu@gourry-fedora-PF4VCD3F/
https://lore.kernel.org/linux-mm/agYJcRgOHho8upVv@gourry-fedora-PF4VCD3F/

I will be trying to post an updated set stripped down without the GFP
flag as a first pass w/o RFC tags and no UAPI implications so that
device folks can play with this upstream.

I'm debating on whether to include OPS_MEMPOLICY in the initial version
if only because it's not intuitive how it interacts with pagecache. That
needs more time to bake.

> > 
> > page = alloc_pages_node(nid, __GFP_PRIVATE, 0);
> 
> Do we want to provide kernel level control over allocation of private
> pages, I assumed that only user space applications? I would assume
> node affinity would be the way to do so, unless we have multiple
> 

alloc_pages_node() is the kernel interface

> > 
> > /* Ok but I want to do something useful with it */
> > static const struct node_private_ops ops = {
> >         .migrate_to     = my_migrate_to,
> >         .folio_migrate  = my_folio_migrate,
> >         .flags = NP_OPS_MIGRATION | NP_OPS_MEMPOLICY,
> > };
> > node_private_set_ops(nid, &ops);
> >
> 
> Could you explain this further? Why does OPS_MIGRATION
> and OPS_MEMPOLICY needs to be set explictly?
>

Both of these have been removed from the upcoming version, but in this
RFC version i was testing OPS_MIGRATION as an explicit flag that meant
"migrate.c can touch the folios" while OPS_MEMPOLICY meant "mempolicy.c
can touch the folios".

As it turns out, OPS_MIGRATION is not a useful filter, as it doesn't
actually filter anything (anything using OPS_MIGRATION would also need
its own filter flag, so better to just drop it and do per-server
opt-ins).

~Gregory

