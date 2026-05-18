Return-Path: <cgroups+bounces-16038-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WJvGE7pAC2p5FAUAu9opvQ
	(envelope-from <cgroups+bounces-16038-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Mon, 18 May 2026 18:39:22 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 942CB5710B4
	for <lists+cgroups@lfdr.de>; Mon, 18 May 2026 18:39:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 4B9273007B84
	for <lists+cgroups@lfdr.de>; Mon, 18 May 2026 16:39:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E60723090DE;
	Mon, 18 May 2026 16:39:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="DNddHhbv"
X-Original-To: cgroups@vger.kernel.org
Received: from out-173.mta0.migadu.com (out-173.mta0.migadu.com [91.218.175.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6A7648B37F
	for <cgroups@vger.kernel.org>; Mon, 18 May 2026 16:39:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779122359; cv=none; b=CRhtiK58w9IN7CWQuZBUpL3FINcBYsyuPz8VWuqAOiljcca6dmk145cfJmSByK+lhID01KzOG38WzOd6GrzhueRys8nHxaMhktTItPoyzybAuwV4OdDyCU77ttWvWJcgUTn4jlrLm+29UJCEtmY4PGTT4WMx66G7W38LjjI4g9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779122359; c=relaxed/simple;
	bh=Z5w9VXbDHWwaa8GVmJp3zwsvqS01hbJy9WgyvIuVziI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rlzdMH+Q+du3Ss1UDsp1qhH/zGYrI5IqJrg8P5Nzfitng3a1XJue93av8fwJMwRyuV232qGJAuZK0RMB6ctC1uEY3WV0hed2rY00u/D7YxqQy/KM1/2USHJ7+Ac/mqE3BDAhq0zGRa4LTFYn00RcF70zidXmgF7uA+UTz0EodyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=DNddHhbv; arc=none smtp.client-ip=91.218.175.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Mon, 18 May 2026 09:39:00 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1779122354;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0nZ63ixZmpqUJEA5mKwrCc5eEpjyHEZj+MQ/sAMlFNc=;
	b=DNddHhbvcHQnPyEBvcPR9NtOSklLhywR8EirOQ96GAmA+rzZiYis8KgdOh8x1VAI9yoEy2
	dQjevyx1qO5hKUKowEGy0TSwsu5TQUnrM/+/41zgvP6qWIj1gn7+I6f+JyVifHW5vBhTsP
	SDEfwZbGPAPLwQR2n6ulKWf1Jwj9/5k=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Oliver Sang <oliver.sang@intel.com>
Cc: Qi Zheng <qi.zheng@linux.dev>, oe-lkp@lists.linux.dev, lkp@intel.com, 
	linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, 
	David Carlier <devnexen@gmail.com>, Allen Pais <apais@linux.microsoft.com>, 
	Axel Rasmussen <axelrasmussen@google.com>, Baoquan He <bhe@redhat.com>, 
	Chengming Zhou <chengming.zhou@linux.dev>, Chen Ridong <chenridong@huawei.com>, 
	David Hildenbrand <david@kernel.org>, Hamza Mahfooz <hamzamahfooz@linux.microsoft.com>, 
	Harry Yoo <harry.yoo@oracle.com>, Hugh Dickins <hughd@google.com>, 
	Imran Khan <imran.f.khan@oracle.com>, Johannes Weiner <hannes@cmpxchg.org>, 
	Kamalesh Babulal <kamalesh.babulal@oracle.com>, Lance Yang <lance.yang@linux.dev>, 
	Liam Howlett <Liam.Howlett@oracle.com>, Lorenzo Stoakes <ljs@kernel.org>, Michal Hocko <mhocko@suse.com>, 
	Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>, Mike Rapoport <rppt@kernel.org>, 
	Muchun Song <muchun.song@linux.dev>, Muchun Song <songmuchun@bytedance.com>, 
	Nhat Pham <nphamcs@gmail.com>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Suren Baghdasaryan <surenb@google.com>, Usama Arif <usamaarif642@gmail.com>, 
	Vlastimil Babka <vbabka@kernel.org>, Wei Xu <weixugc@google.com>, Yosry Ahmed <yosry@kernel.org>, 
	Yuanchu Xie <yuanchu@google.com>, Zi Yan <ziy@nvidia.com>, Usama Arif <usama.arif@linux.dev>, 
	cgroups@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [linus:master] [mm] 01b9da291c: stress-ng.switch.ops_per_sec
 67.7% regression
Message-ID: <agtATZG9mIlYzMUl@linux.dev>
References: <agNO8G8tPnPuVrGq@linux.dev>
 <0e1b8994-944d-4dda-8966-3cd43661796d@linux.dev>
 <agSAT4ldp3dzKWPl@linux.dev>
 <agSJ4ulNDZ17ah8H@linux.dev>
 <46e9f5cf-34cb-466d-a53a-5778768af4d9@linux.dev>
 <93b7c3f206f158e7387cbb5f0bf5845b59b93053@linux.dev>
 <19693be6-7132-446e-b3fc-b7e9f56e5949@linux.dev>
 <agdS5rIhcjIBVSog@linux.dev>
 <agm61hMv08XnV8sI@xsang-OptiPlex-9020>
 <agoYp1zW9afZ6uQz@linux.dev>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <agoYp1zW9afZ6uQz@linux.dev>
X-Migadu-Flow: FLOW_OUT
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-16038-lists,cgroups=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[linux.dev,lists.linux.dev,intel.com,vger.kernel.org,linux-foundation.org,gmail.com,linux.microsoft.com,google.com,redhat.com,huawei.com,kernel.org,oracle.com,cmpxchg.org,suse.com,bytedance.com,nvidia.com,kvack.org];
	RCPT_COUNT_TWELVE(0.00)[39];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[shakeel.butt@linux.dev,cgroups@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.dev:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[cgroups];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,linux.dev:mid,linux.dev:dkim]
X-Rspamd-Queue-Id: 942CB5710B4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sun, May 17, 2026 at 12:38:48PM -0700, Shakeel Butt wrote:
> On Sun, May 17, 2026 at 08:55:50PM +0800, Oliver Sang wrote:
> > hi, Shakeel, hi, Qi,
> > 
> > #2: when we test above patch, we found the server easy to crash while running
> > tests. we try to run up to 20 times, only 2 of them run successfully (above
> > 37739220 is just the average data from these 2 runs, since the data is stable,
> > we think maybe it's ok to report to you with this data).
> > we also noticed for [1] there is a [syzbot ci] report in [2]. since we don't
> > have serial output for our test server in this report which is for performance
> > tests, we cannot say if other 18 runs failed due to similar reason. just FYI.
> > 
> 
> The syzbot report is simply a rcu warning which will be fixed in v2. Do you
> have more details on the crash you are seeing? Is it page counter underflow
> warning?
> 
> Thanks again for the help.

Hi Oliver, it seems like sashiko found another issue with v2, so, if you have
not yet started the test, you can skip it.

Also I am rethinking the approach, so I will send a prototype in response on
this email for which I will need your help in testing.

