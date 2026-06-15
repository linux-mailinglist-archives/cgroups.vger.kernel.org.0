Return-Path: <cgroups+bounces-16973-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id AjJBOC8cMGpKNwUAu9opvQ
	(envelope-from <cgroups+bounces-16973-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Mon, 15 Jun 2026 17:37:19 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 61A99687C31
	for <lists+cgroups@lfdr.de>; Mon, 15 Jun 2026 17:37:19 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gourry.net header.s=google header.b=KLEg76Qg;
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-16973-lists+cgroups=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="cgroups+bounces-16973-lists+cgroups=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6A50230285F9
	for <lists+cgroups@lfdr.de>; Mon, 15 Jun 2026 15:37:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6120F4014AB;
	Mon, 15 Jun 2026 15:37:14 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E01AA403E93
	for <cgroups@vger.kernel.org>; Mon, 15 Jun 2026 15:37:12 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781537834; cv=none; b=pxo6DGTnKiEex7SCCfLWN4oYpQKqLFwvpnrvLBrhUiyTSiBxdq1AhxykgPJAgxYIUDH6fk1P0mw53g+IfwHecXNPCJNwg2lE+dLAcLjXGl2rc5PgyMk5nGszCDztfayWxnCqGRySi+SZr2vaXlB/UO+SDMw3e7VJRfZUkpCdQhU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781537834; c=relaxed/simple;
	bh=gDF7opo+wStJ7Wpr6WBsmAfccg6GFU4nXrKDloElyKI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CKOUqNdXgEubd+xm5YBk3XQEeUB9OneAmzeDXeyvwWgm5CnWerMoSuuBiWrKVUZi2/+fDXo/fRDwuv1P6KnhkIUd4L8pN3oNHrQjp/dnG3tvmkeKehzvwITRa/Bz/R5hJ7vqyMhDIPZtQnEbG2ZlrkFuf5z35wi5grR6ARa5nBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=KLEg76Qg; arc=none smtp.client-ip=209.85.160.177
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-517654b8e28so24310691cf.3
        for <cgroups@vger.kernel.org>; Mon, 15 Jun 2026 08:37:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1781537832; x=1782142632; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=FjNePvEWoA1YkOvHP4nURdQdbVRIT8G3obtM70Agu6M=;
        b=KLEg76QgKm1XsT/3ikRHUJTUomNPspeQoumebDnLyIHMKTdcmfdCwF4rec2qZ1/7TO
         WpLECXfeef0DV2W5J6wjxSdcbTaOsbcYwHWAVHXeqHCz/6+r7zlNw4NdM4p5F8JplLfw
         wWtt5j+M2zW+MEe+v4khMNW55ALBwLbjH25qBCUBlXnuFjIaxjAmGAjP5fe3zTF5LGAx
         z6jkokThv8uVC93rAOimmY7cUaCUyWDKfgosdAnwWA2BRzMFQbJO3siBRlVhIb7nA7S4
         1JpP6sMPN2GKB18x1K2Wj9bZZYARHZcNQtD95OUVHIVv+Rlxhi/89KwrrybRdnMVnDkV
         zzRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781537832; x=1782142632;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FjNePvEWoA1YkOvHP4nURdQdbVRIT8G3obtM70Agu6M=;
        b=gQywWCkYRrZT/E8gELA4uuQM+V8yV+Tl33wKJYz2N9jTfskQnKkJcxCngPIzwIviA4
         5UiRMe96yQNSlxc842I35OrTYFjqwVdxF1c7M3dATX5OHoUpPm1D1cpfxgfDkHaETaWR
         Js4of23afhjWEf5LKNItvbgIhzpKDtw4Hmd4ya5+wnKeaw32Xo2SADder9f/B9AYLlwP
         H5MQ18t9jRtbZjRyq9MZlVdab3WzS6oPObtZF/q0DVuUZ2rtY5j+YGj/uggTjLPQrhHb
         CD/VocNVcNnYyAj8zx4vjw0DnQ+0uQRTEZLPu2u2lZtFUTl7WWbUA2RqonCU0zYC00Qv
         63tg==
X-Forwarded-Encrypted: i=1; AFNElJ8fA8FxZBjnqJqOTQk7G1PXbqCRMetDgEB8wZp/LSPxYy/57qdzIRElUwworo/9tIX724VrBLZt@vger.kernel.org
X-Gm-Message-State: AOJu0YxGDcrgDS34EqoYDJpDk9MxrKpAWifOf0UyVdLyghJkb9cLPM12
	z2GAcrCG4oixHcOoFVi6nLW8Uu4PKisgJoB1fkfpQauo3ksUpU4HKQ7V3EGwNOa2Hp8=
X-Gm-Gg: Acq92OE20vPnHlEgQHqXEv3DyRS5v23OQz4Q4zoOQ2/+IB+q/S7t2qZ+Ii5y6xJTHfn
	pyAa19isyI6ZXU4QHadZPEMRm3svnB4bYJEn+xyeV1y1IlVIFvi1pchLUFr+U/XjVa67/dXE/ci
	dFQHbHVNg0Th1mpT0dRLW5rrncUH++mtemC94Di1lFsDq96eR2v9jPrn2wgeTcD/RPCw062TcPa
	63o2ZPPWmpRxYMVfxfvRcaC9IgjUNFBSI4ryFwlN2mPzVOrycaF9MsvkkvkaxyKn49xLE4yScKG
	YtBn3lkuGKHQk1oBT/ccvkNWhRKd27ReF+Fx9XKaob+aHG5B2i59SCgf+GVeKgKvJZmfbBmh1H+
	+yIrtQ44jTiPY81sIkDsdkjt7xOIuQnd0Kn09cb4MutpNpydv3BUkAN70vlsLBUF8IVZYdNdNlZ
	gr2vF5c/8PY1MMn+tBSA==
X-Received: by 2002:a05:622a:1191:b0:517:5b2c:6aae with SMTP id d75a77b69052e-517fe1de684mr210273141cf.13.1781537831809;
        Mon, 15 Jun 2026 08:37:11 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F ([2620:10d:c091:500::5f73])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-517fb815976sm110238541cf.25.2026.06.15.08.37.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jun 2026 08:37:11 -0700 (PDT)
Date: Mon, 15 Jun 2026 11:37:07 -0400
From: Gregory Price <gourry@gourry.net>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: "Vlastimil Babka (SUSE)" <vbabka@kernel.org>,
	Balbir Singh <balbirs@nvidia.com>,
	lsf-pc@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
	linux-cxl@vger.kernel.org, cgroups@vger.kernel.org,
	linux-mm@kvack.org, linux-trace-kernel@vger.kernel.org,
	damon@lists.linux.dev, kernel-team@meta.com,
	gregkh@linuxfoundation.org, rafael@kernel.org, dakr@kernel.org,
	dave@stgolabs.net, jonathan.cameron@huawei.com,
	dave.jiang@intel.com, alison.schofield@intel.com,
	vishal.l.verma@intel.com, ira.weiny@intel.com,
	dan.j.williams@intel.com, longman@redhat.com,
	akpm@linux-foundation.org, lorenzo.stoakes@oracle.com,
	Liam.Howlett@oracle.com, vbabka@suse.cz, rppt@kernel.org,
	surenb@google.com, mhocko@suse.com, osalvador@suse.de,
	ziy@nvidia.com, matthew.brost@intel.com, joshua.hahnjy@gmail.com,
	rakie.kim@sk.com, byungchul@sk.com, ying.huang@linux.alibaba.com,
	apopple@nvidia.com, axelrasmussen@google.com, yuanchu@google.com,
	weixugc@google.com, yury.norov@gmail.com, linux@rasmusvillemoes.dk,
	mhiramat@kernel.org, mathieu.desnoyers@efficios.com, tj@kernel.org,
	hannes@cmpxchg.org, mkoutny@suse.com, jackmanb@google.com,
	sj@kernel.org, baolin.wang@linux.alibaba.com, npache@redhat.com,
	ryan.roberts@arm.com, dev.jain@arm.com, baohua@kernel.org,
	lance.yang@linux.dev, muchun.song@linux.dev, xu.xin16@zte.com.cn,
	chengming.zhou@linux.dev, jannh@google.com, linmiaohe@huawei.com,
	nao.horiguchi@gmail.com, pfalcato@suse.de, rientjes@google.com,
	shakeel.butt@linux.dev, riel@surriel.com, harry.yoo@oracle.com,
	cl@gentwo.org, roman.gushchin@linux.dev, chrisl@kernel.org,
	kasong@tencent.com, shikemeng@huaweicloud.com, nphamcs@gmail.com,
	bhe@redhat.com, zhengqi.arch@bytedance.com, terry.bowman@amd.com,
	Matthew Wilcox <willy@infradead.org>
Subject: Re: [Lsf-pc] [LSF/MM/BPF TOPIC][RFC PATCH v4 00/27] Private Memory
 Nodes (w/ Compressed RAM)
Message-ID: <ajAcIwBAnqgEEWSD@gourry-fedora-PF4VCD3F>
References: <ah6bDNxlB1zBUnzN@gourry-fedora-PF4VCD3F>
 <ah-0CyZurn5D1ezY@parvat>
 <aik_ddHymus2DJ6D@gourry-fedora-PF4VCD3F>
 <c1b66e7a-bb95-4295-8193-55ceadaaa578@kernel.org>
 <aimSzvoJDrpeQsmM@gourry-fedora-PF4VCD3F>
 <d01fb1ed-2418-42ee-aea2-37f9a5c5729c@kernel.org>
 <ainFROZ3WrGioyuY@gourry-fedora-PF4VCD3F>
 <aiwl4kCG814dpX7L@gourry-fedora-PF4VCD3F>
 <9f1815b0-896b-44ab-9e6d-9316d8f11033@kernel.org>
 <fdbdc9f7-d142-4880-b429-065d5056cabb@kernel.org>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fdbdc9f7-d142-4880-b429-065d5056cabb@kernel.org>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[gourry.net:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-16973-lists,cgroups=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:david@kernel.org,m:vbabka@kernel.org,m:balbirs@nvidia.com,m:lsf-pc@lists.linux-foundation.org,m:linux-kernel@vger.kernel.org,m:linux-cxl@vger.kernel.org,m:cgroups@vger.kernel.org,m:linux-mm@kvack.org,m:linux-trace-kernel@vger.kernel.org,m:damon@lists.linux.dev,m:kernel-team@meta.com,m:gregkh@linuxfoundation.org,m:rafael@kernel.org,m:dakr@kernel.org,m:dave@stgolabs.net,m:jonathan.cameron@huawei.com,m:dave.jiang@intel.com,m:alison.schofield@intel.com,m:vishal.l.verma@intel.com,m:ira.weiny@intel.com,m:dan.j.williams@intel.com,m:longman@redhat.com,m:akpm@linux-foundation.org,m:lorenzo.stoakes@oracle.com,m:Liam.Howlett@oracle.com,m:vbabka@suse.cz,m:rppt@kernel.org,m:surenb@google.com,m:mhocko@suse.com,m:osalvador@suse.de,m:ziy@nvidia.com,m:matthew.brost@intel.com,m:joshua.hahnjy@gmail.com,m:rakie.kim@sk.com,m:byungchul@sk.com,m:ying.huang@linux.alibaba.com,m:apopple@nvidia.com,m:axelrasmussen@google.com,m:yuanchu@google.com,m:weixugc@google.com,m:yury.norov@gmai
 l.com,m:linux@rasmusvillemoes.dk,m:mhiramat@kernel.org,m:mathieu.desnoyers@efficios.com,m:tj@kernel.org,m:hannes@cmpxchg.org,m:mkoutny@suse.com,m:jackmanb@google.com,m:sj@kernel.org,m:baolin.wang@linux.alibaba.com,m:npache@redhat.com,m:ryan.roberts@arm.com,m:dev.jain@arm.com,m:baohua@kernel.org,m:lance.yang@linux.dev,m:muchun.song@linux.dev,m:xu.xin16@zte.com.cn,m:chengming.zhou@linux.dev,m:jannh@google.com,m:linmiaohe@huawei.com,m:nao.horiguchi@gmail.com,m:pfalcato@suse.de,m:rientjes@google.com,m:shakeel.butt@linux.dev,m:riel@surriel.com,m:harry.yoo@oracle.com,m:cl@gentwo.org,m:roman.gushchin@linux.dev,m:chrisl@kernel.org,m:kasong@tencent.com,m:shikemeng@huaweicloud.com,m:nphamcs@gmail.com,m:bhe@redhat.com,m:zhengqi.arch@bytedance.com,m:terry.bowman@amd.com,m:willy@infradead.org,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[kernel.org,nvidia.com,lists.linux-foundation.org,vger.kernel.org,kvack.org,lists.linux.dev,meta.com,linuxfoundation.org,stgolabs.net,huawei.com,intel.com,redhat.com,linux-foundation.org,oracle.com,suse.cz,google.com,suse.com,suse.de,gmail.com,sk.com,linux.alibaba.com,rasmusvillemoes.dk,efficios.com,cmpxchg.org,arm.com,linux.dev,zte.com.cn,surriel.com,gentwo.org,tencent.com,huaweicloud.com,bytedance.com,amd.com,infradead.org];
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
	RCPT_COUNT_GT_50(0.00)[76];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp,gourry-fedora-PF4VCD3F:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 61A99687C31

On Mon, Jun 15, 2026 at 05:18:55PM +0200, David Hildenbrand (Arm) wrote:
> On 6/15/26 16:38, Vlastimil Babka (SUSE) wrote:
> > 
> > I think the memalloc approach is dangerous due to unexpected nesting. There
> > might be nested page allocations in page allocation itself (due to some
> > debugging option). But also interrupts do not change what "current" points
> > to. Suddenly those could start requesting folios and/or private nodes and be
> > surprised, I'm afraid.
> 
> Yeah, we'd need some way to distinguish the main allocation from these other
> (nested) allocations.
>
> 
> > 
> > The memalloc scopes only work well when they restrict the context wrt
> > reclaim, and allocations in IRQ have to be already restricted heavily
> > (atomic) so further memalloc restrictions don't do anything in practice. But
> > to make them change other aspects of the allocations like this won't work.
> 
> I was assuming that memalloc_pin_save() would already violate that, but really
> it only restricts where movable allocations land, and that doesn't matter for
> other kernel allocations.
> 
> Do you see any other way to make something like an allocation context work, and
> avoid introducing more GFP flags?
>

One thought would be a way to switch what fallback list is used, and
then have specific fallback lists for certain contexts.

Right now there is a single example of this: __GFP_THISNODE
  |= __GFP_THISNODE   =>  NOFALLBACK
  &= ~__GFP_THISNODE  =>  FALLBACK

We could add an interface with the desired fallback list based as an
argument, and let get_page_from_freelist to prefer that over the default
global lists.

Omit all special nodes from FALLBACK/NOFALLBACK and make the special
contexts provide the fallback-base that should be used.

On my current branch i think that would include modifying, in totality:

   alloc_folio_mpol()
   alloc_demotion_folio()
   alloc_migration_target()

And i'm pretty sure that all just nests nicely.

We might not even need memalloc... hmmm

~Gregory

