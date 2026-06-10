Return-Path: <cgroups+bounces-16801-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id vrA7DWZDKWrcTAMAu9opvQ
	(envelope-from <cgroups+bounces-16801-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Wed, 10 Jun 2026 12:58:46 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 99BBB6687FC
	for <lists+cgroups@lfdr.de>; Wed, 10 Jun 2026 12:58:45 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gourry.net header.s=google header.b=gpUTAXO7;
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-16801-lists+cgroups=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="cgroups+bounces-16801-lists+cgroups=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C208F31DD959
	for <lists+cgroups@lfdr.de>; Wed, 10 Jun 2026 10:45:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 667733F6C46;
	Wed, 10 Jun 2026 10:42:10 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FF8C3F8EDE
	for <cgroups@vger.kernel.org>; Wed, 10 Jun 2026 10:42:02 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781088129; cv=none; b=rDUqv31iUrfY40EhG8/yP6gmFY9Cv5sLA+tT2rT3AZkEgRfoFMYnE4fUpjxXGYdVNTqxdSi4KtckVRFIx7d9CpyQCk5NwEQxyPfsCyMNPdyw/9eVxF3S30CTkhwu/srHuDAzdAiMiF8eQV/jtFUpOor69et1fvUhOrLisqLegRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781088129; c=relaxed/simple;
	bh=rLAKx7oZEBl4l8VQ6/vsIVEV/nqRO6+w6w+1NuugFRI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sIz9OG+NQpQ8bxTmEdPJTXgmQdvqhAtQQ4tTnSxrIgRVkZN1KgPBGKLjv5dsm8XTaS2YFvGhFBIaAPzJggDMYOC36Jtb02jO1QKppxlqOOm1MKg4szLeDugOtJNH8kBJYRc17HI4HR5qKMiTtupffoXDA3OhlNF3jZdyXOUBWXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=gpUTAXO7; arc=none smtp.client-ip=209.85.219.47
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-8cd45d4b7e2so74890786d6.2
        for <cgroups@vger.kernel.org>; Wed, 10 Jun 2026 03:42:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1781088121; x=1781692921; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=pgx1xgYrFcSjqIUoyhFqGxYUzhtvYzBpQalCqkbKQaU=;
        b=gpUTAXO7LYj55vqZytrIq49IGLWTJvLT+xAvLnjZFi7gjoGYGbTGjCIel1PHtM67TK
         fKtSbxARYH8l3bdsI1eQaDqaPVFqfZgLqYp2Hdz3Q8F9NJfn1/AGnBpOnXQl8Xp6HqVM
         fnpXPMJnuDMbGNyVvoklwWlIeAEsE40/bq+oK7DemyY/a4CJkZnYYCXzsxU6HbjjFEmF
         yzdeFiW+XXjOVaS62j0zEFozPv75geuKQhBJ/bx6qUvXD7YWWOSsFxDd+UVh+le0AZBv
         CIwPnI/Y91RzF+4pup0vWYBvUqDzBYJFSLPYs+DWujHYLHVfYs0K/EJP/e5pF7mytowE
         sOXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781088121; x=1781692921;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pgx1xgYrFcSjqIUoyhFqGxYUzhtvYzBpQalCqkbKQaU=;
        b=bIM0Gf6UImDTVoeEC3cRIG4eymURw1RoconnCU6csR2rfYLULBKB+fYvHbUnjzwsZK
         4UDauibe6oHWpQOstf7ESyonXOwaNvvHIGLowZgFGskTg3qIbIFsjXpJ5p4HB0UchTF1
         jajQuDmI5SWcM5jr927lYmVzzEEJLM9QPqoIW3gMgUfbK4jv+ynNzB1lLnSYQsDvd47D
         5gjS7tPqDwRlgIT1dPLX9n9NFauqdv+93n8O8LKcOgMCHSsfnEbAZ85QoNpSCSw6lHDG
         hQCuvKe1dguhJ/uAXHYzS/GvIuG5vXUEvm7oXg/sxFETJJzEkuv3aa3z+hMcib5vj0OD
         c8rg==
X-Forwarded-Encrypted: i=1; AFNElJ/No4G8mXMHJhGglF3AY7ETNqRU2i1f89hSL4MGxQHcu38CLlSBAWV2mPdS07FYRQh0dYHdfTOl@vger.kernel.org
X-Gm-Message-State: AOJu0YwQ7ZBFQbChKHtedXrn+GpXFsdhEpYxabcZ+AS9kaq+ezO+S2iT
	kEfvSTbYdlHtQvXuFAXu0Nh/7hrPxaglnl5T2RWjNprcUW2MD8itXXtnVE8XBAybvhE=
X-Gm-Gg: Acq92OGdFwb1kRxWsfAzUAA0qAFbxoJmguRUGUuqjU8mCXUuy4Bw66j2Lcn3x0s2fEl
	PVkVQOmiN5EtDI3jwzrvnOiPg+j+AQ/toBBy1518pmiZdbmQFi/Tq4yKc+WgmP+ei5vL2CvZCKJ
	s7VeVfFdu6FWS64ASOh5Aa86ulz9YIcXpO6GuFNQXzK+CQp5qUWrc48LN7AkoaUkCpR6FNDKez+
	xnNINFmm0q+CPoNFTCibo7ctE3158iWG5zoYntrVkG7gtSXQu6afI9ohcZ3qvesPffxMQlvBy2N
	MYLm9mI2eOA2MgO7D8wrQ+YVrWdmR1M2d7bO8L8hLDnKDCr3aaSgBJz85qKDTbDSv34Z/+eIDpa
	kQm/Riaty5BvwOe954e/VRKm4Wd1wzFx8ZtJAoYFjPVJ8KJxi4cR7OBib+fr1/HiMyIN4Y9lZRN
	9/uhkZoFVLW8pJWE4tcVpC+GELmv+MeuCjFzpEPirdW7F0VrZpiIdlDwoTytyM8GC0fBHBXiIZC
	+tG6tFEYxC5i6THDA==
X-Received: by 2002:a05:6214:c68:b0:8b5:6654:7556 with SMTP id 6a1803df08f44-8cee63e377emr394580386d6.42.1781088120984;
        Wed, 10 Jun 2026 03:42:00 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (pool-173-79-60-52.washdc.fios.verizon.net. [173.79.60.52])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8cecd06e4d6sm231860136d6.36.2026.06.10.03.41.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jun 2026 03:41:59 -0700 (PDT)
Date: Wed, 10 Jun 2026 06:41:57 -0400
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
Message-ID: <aik_ddHymus2DJ6D@gourry-fedora-PF4VCD3F>
References: <20260222084842.1824063-1-gourry@gourry.net>
 <ag6XyvxR-NU5rGn-@parvat>
 <ahOqzpzAua96HVkn@gourry-fedora-PF4VCD3F>
 <ah47NNhuiClgGCdn@parvat>
 <ah6bDNxlB1zBUnzN@gourry-fedora-PF4VCD3F>
 <ah-0CyZurn5D1ezY@parvat>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ah-0CyZurn5D1ezY@parvat>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[gourry.net:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-16801-lists,cgroups=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:balbirs@nvidia.com,m:lsf-pc@lists.linux-foundation.org,m:linux-kernel@vger.kernel.org,m:linux-cxl@vger.kernel.org,m:cgroups@vger.kernel.org,m:linux-mm@kvack.org,m:linux-trace-kernel@vger.kernel.org,m:damon@lists.linux.dev,m:kernel-team@meta.com,m:gregkh@linuxfoundation.org,m:rafael@kernel.org,m:dakr@kernel.org,m:dave@stgolabs.net,m:jonathan.cameron@huawei.com,m:dave.jiang@intel.com,m:alison.schofield@intel.com,m:vishal.l.verma@intel.com,m:ira.weiny@intel.com,m:dan.j.williams@intel.com,m:longman@redhat.com,m:akpm@linux-foundation.org,m:david@kernel.org,m:lorenzo.stoakes@oracle.com,m:Liam.Howlett@oracle.com,m:vbabka@suse.cz,m:rppt@kernel.org,m:surenb@google.com,m:mhocko@suse.com,m:osalvador@suse.de,m:ziy@nvidia.com,m:matthew.brost@intel.com,m:joshua.hahnjy@gmail.com,m:rakie.kim@sk.com,m:byungchul@sk.com,m:ying.huang@linux.alibaba.com,m:apopple@nvidia.com,m:axelrasmussen@google.com,m:yuanchu@google.com,m:weixugc@google.com,m:yury.norov@gmail.com,m:linux@rasmus
 villemoes.dk,m:mhiramat@kernel.org,m:mathieu.desnoyers@efficios.com,m:tj@kernel.org,m:hannes@cmpxchg.org,m:mkoutny@suse.com,m:jackmanb@google.com,m:sj@kernel.org,m:baolin.wang@linux.alibaba.com,m:npache@redhat.com,m:ryan.roberts@arm.com,m:dev.jain@arm.com,m:baohua@kernel.org,m:lance.yang@linux.dev,m:muchun.song@linux.dev,m:xu.xin16@zte.com.cn,m:chengming.zhou@linux.dev,m:jannh@google.com,m:linmiaohe@huawei.com,m:nao.horiguchi@gmail.com,m:pfalcato@suse.de,m:rientjes@google.com,m:shakeel.butt@linux.dev,m:riel@surriel.com,m:harry.yoo@oracle.com,m:cl@gentwo.org,m:roman.gushchin@linux.dev,m:chrisl@kernel.org,m:kasong@tencent.com,m:shikemeng@huaweicloud.com,m:nphamcs@gmail.com,m:bhe@redhat.com,m:zhengqi.arch@bytedance.com,m:terry.bowman@amd.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[lists.linux-foundation.org,vger.kernel.org,kvack.org,lists.linux.dev,meta.com,linuxfoundation.org,kernel.org,stgolabs.net,huawei.com,intel.com,redhat.com,linux-foundation.org,oracle.com,suse.cz,google.com,suse.com,suse.de,nvidia.com,gmail.com,sk.com,linux.alibaba.com,rasmusvillemoes.dk,efficios.com,cmpxchg.org,arm.com,linux.dev,zte.com.cn,surriel.com,gentwo.org,tencent.com,huaweicloud.com,bytedance.com,amd.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[gourry.net];
	FORGED_SENDER(0.00)[gourry@gourry.net,cgroups@vger.kernel.org];
	DKIM_TRACE(0.00)[gourry.net:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gourry@gourry.net,cgroups@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_GT_50(0.00)[74];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp,gourry-fedora-PF4VCD3F:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 99BBB6687FC

On Wed, Jun 03, 2026 at 03:00:01PM +1000, Balbir Singh wrote:
> > 
> >    __GFP_THISNODE cannot be overloaded to do anything useful here.
> 
> Let me clarify, I meant to say, let's use a nodemask for allocation
> and __GFP_THISNODE gets us to the node we desire, if that is the only
> node. My earlier comment might not have been clear.
> 

I've been tested an stripped back patch set where I drop all FALLBACK
entries for private nodes (including for itself) and only keep the
NOFALLBACK entry for private nodes.

This effectively isolates the nodes for any allocation without
__GFP_THISNODE.

This also precludes these nodes from ever using non-mbind mempolicies,
which I think is a completely reasonable compromise and something I was
already expecting we would do.

Notably: slub.c injects __GFP_THISNODE internally on behalf of kmalloc,
which causes spillage into private nodes because slub allows private
nodes in its mask.  I think this is fixable.

I have to inspect some other __GFP_THISNODE users (hugetlb, some arch
code, etc), but it seems like fully dropping the FALLBACK entries and
requiring __GFP_THISNODE might be sufficient.

~Gregory

