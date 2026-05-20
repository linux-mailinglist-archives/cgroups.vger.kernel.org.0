Return-Path: <cgroups+bounces-16104-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cJ0dL+Y0DWrLuQUAu9opvQ
	(envelope-from <cgroups+bounces-16104-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Wed, 20 May 2026 06:13:26 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 17CBF587748
	for <lists+cgroups@lfdr.de>; Wed, 20 May 2026 06:13:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8E2D5300A111
	for <lists+cgroups@lfdr.de>; Wed, 20 May 2026 04:13:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DFC83546D0;
	Wed, 20 May 2026 04:13:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ZkXJ2H0M"
X-Original-To: cgroups@vger.kernel.org
Received: from out-186.mta0.migadu.com (out-186.mta0.migadu.com [91.218.175.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A96E2DCF46
	for <cgroups@vger.kernel.org>; Wed, 20 May 2026 04:13:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779250396; cv=none; b=lfsvtWWwmf/qJmeZlcPgxkjV2aMnFXn3Zfq3SSKECuyz/sIVixw5bI4/KCHeSpq0eexvpkK9m5CTfT6O7KDMefQy5OTfJQBZGISUJUvzypPGc0FIhGw0lscxcOMod6ltSu7Ca81mp9hd6O+OpOPDKLRPN4kBaNT/kVOcQ2d1jqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779250396; c=relaxed/simple;
	bh=WJXZqTNMY27INgWD6j+riBNe7GOb+s885XyqJKWLuZs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aswJHG9a4a3fTaRZRFKmtPzzKybJZkD4XMUlNHheRfMqnt/E7+QUPGJ9AdQNY+Lys04IcOcQWP7x8xt37LO4Id6UrS3B0TWxnPAVNanStgrWjDmegSttW+L4EhYuhRCavI0IoOY3i+Xs+RA40iWfXgg1s+wc+JE4i87oW/sBNus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ZkXJ2H0M; arc=none smtp.client-ip=91.218.175.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Tue, 19 May 2026 21:12:54 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1779250382;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=oRxIk/rNMXwMe3aqIZ0sV2FoVFm9Hl2o3laEA+4gbk4=;
	b=ZkXJ2H0M1A8TbPE1BHyMrulOOmOHN3ljMZyTYcupbvGr+jR3MTuHpg5QkH7p69lQt2Ypuk
	s2iZE7b/MXQA4NvBuQZQ+NFxO3Fz9dJW/Ya1bKPSztN8l9KYJaWEjc+TQdJCNz3n4EncDG
	NQrSDSZa7akXzHm3+g5ueA8eM0PaV7E=
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
Message-ID: <ag00nBP_zNa9RWxm@linux.dev>
References: <93b7c3f206f158e7387cbb5f0bf5845b59b93053@linux.dev>
 <19693be6-7132-446e-b3fc-b7e9f56e5949@linux.dev>
 <agdS5rIhcjIBVSog@linux.dev>
 <agm61hMv08XnV8sI@xsang-OptiPlex-9020>
 <agoYp1zW9afZ6uQz@linux.dev>
 <agtATZG9mIlYzMUl@linux.dev>
 <agtPMpQK2jXdQAY4@linux.dev>
 <agvvRNJTAtNkCVZc@xsang-OptiPlex-9020>
 <agxxuHOfNLX-32kI@linux.dev>
 <ag0fyi8GjHHf8bdC@xsang-OptiPlex-9020>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ag0fyi8GjHHf8bdC@xsang-OptiPlex-9020>
X-Migadu-Flow: FLOW_OUT
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-16104-lists,cgroups=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[linux.dev,lists.linux.dev,intel.com,vger.kernel.org,linux-foundation.org,gmail.com,linux.microsoft.com,google.com,redhat.com,huawei.com,kernel.org,oracle.com,cmpxchg.org,suse.com,bytedance.com,nvidia.com,kvack.org];
	RCPT_COUNT_TWELVE(0.00)[39];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[shakeel.butt@linux.dev,cgroups@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.dev:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[cgroups];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,linux.dev:mid,linux.dev:dkim,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 17CBF587748
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, May 20, 2026 at 10:43:22AM +0800, Oliver Sang wrote:
> hi, Shakeel,
> 
> On Tue, May 19, 2026 at 07:22:52AM -0700, Shakeel Butt wrote:
> > Hi Oliver,
> > 
> 
> [...]
> 
> > 
> > > > > 
> > > > > Also I am rethinking the approach, so I will send a prototype in response on
> > > > > this email for which I will need your help in testing.
> > > > 
> > > > Hi Oliver, can you please test the following patch?
> > > 
> > > got it. will change to test following patch. and this looks quite different
> > > with v2 or v3, so if you still want us to test v3, please let me know. thanks!
> > > 
> > 
> > No need to test v3 as it is similar to v2. Please test the following patch as it
> > is a direction I want to pursue and wanted an early signal if this is the right
> > direction.
> 
> FYI. in our tests, the following patch also recovers the regresion.
> 
> Tested-by: kernel test robot <oliver.sang@intel.com>

Thanks a lot. I will send out the formal patch with your tested-by tag.

