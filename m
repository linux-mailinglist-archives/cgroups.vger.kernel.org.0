Return-Path: <cgroups+bounces-16637-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id T8nmDo87IWo7BgEAu9opvQ
	(envelope-from <cgroups+bounces-16637-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Thu, 04 Jun 2026 10:47:11 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2702263E206
	for <lists+cgroups@lfdr.de>; Thu, 04 Jun 2026 10:47:10 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gourry.net header.s=google header.b="IkH0C/4z";
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-16637-lists+cgroups=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="cgroups+bounces-16637-lists+cgroups=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C7CB23011597
	for <lists+cgroups@lfdr.de>; Thu,  4 Jun 2026 08:36:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 938183E0242;
	Thu,  4 Jun 2026 08:36:38 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 220883D1AB5
	for <cgroups@vger.kernel.org>; Thu,  4 Jun 2026 08:36:34 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780562198; cv=none; b=oid/pxlFE34i9/TT8BRvr39VUmsW20piM775YAtNR5d3OYkjEyQRqDXXQKzhLcjTuY3wDIpcSnV1IoxybZmFm/h6nSXg6ajt5K4brzylTKCJ0htrEdwTUjeCWcB+xOIIvL051UAcT+gN4FcKa1DoFwbC9klVKluStU0UUb5U/AE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780562198; c=relaxed/simple;
	bh=Y+OOrVjaPDaCY8wbBYPbbEO/xIu0Sw/Crs4VhELjjn0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S7a+T0ck9CD7ihMOwfc6o9cdU200IVejwywONU/Hqrzdc2mt3e0mSr1LOH1gDvjNT76DFxsof9CevsHui789AwVVZQWQ0xNJJ5f4bQDDCgyuk+qJBOvWpCQm+DEIX9hi4p6OwlgIOQ+wiWThFWsp+wmgKfwhhTYKx8MlfnFT7C8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=IkH0C/4z; arc=none smtp.client-ip=209.85.221.54
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-45ef41adbc1so347510f8f.0
        for <cgroups@vger.kernel.org>; Thu, 04 Jun 2026 01:36:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1780562193; x=1781166993; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=GOxxBGCqGPcmxW8c5748w9UZojPmDniQUCAc18TCQK8=;
        b=IkH0C/4zGN7OB3CWOxEcz1QwaVhUZd/QNO3Ud6O4sJGNsyijW12j9Z8Dt6s2iiFyGQ
         j3bLoAMneD10bYvliHdxyLntCqtXC6jFl62vUqYDhe/8pTj4VCL5c1ku5Y5ow8mPMjSs
         DC/F3rB3TAy5iEI/+pJ3bF7JqYaDj9n7LrNV6b8U8cUE1Q+WdMeydfNVVCpzBLEnyvuf
         mcVSilgjlpMVwgjGlwI3eHVnqOqqVWB8miOIiZJ15PjP1xl/lDECY9ZUPYpvqAMwxMTz
         8PqcpbmvGea0EJhF14muH9um4hITWMx9lgRC44E7zPgKHTfIBuG85UcdZHkoN2EsrDNk
         gCFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780562193; x=1781166993;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GOxxBGCqGPcmxW8c5748w9UZojPmDniQUCAc18TCQK8=;
        b=OVHddyHIKabNuML8jRc4FK09lLPK+fZQpPCp7Pa4lBvDsIV7vdkHUr0bNLjMDa5Mt+
         lBEwmWyCGMj35uf2Iu6tDmCcW2KFsYTd5fiMDA3Kq6XNr/gTvcu761ElmLKtqO/HWOWc
         9srRm++xrTEJckKM9fsaac65Jcd4oB8Zt5yASpkkLB5cjnFcefQ3SSDcicqn15lABQZj
         LA/sb6Bn0wK3THl1ZSLtWD7cxG7+RFXJjMCVohx422KZam61dAOe/JzvAmI1DAwbUBBi
         VOUMDB2iHDggVVF53GbdXz9jfkjlxNRIZIvbSxwOqbr9WfPuefjH3aO5zJ2iE4pMDSs5
         cSGw==
X-Forwarded-Encrypted: i=1; AFNElJ/qmAbn1NDJaQajZoZsgMQl60rLWJw90vYewpFD8fKmZF9z5KMM0R61OK3PI39rt9LpX45NwIuu@vger.kernel.org
X-Gm-Message-State: AOJu0YxViROOTaOAz+Q7osTi/ewEMzgYmlCBRIe8bK9vtF57KHQsZAYv
	qoI7lx55bHZQCNsG59IK3KVZdb1MQ8CfkY9M8EKYO4/sAdbb86F3+igspL3wYUriXgg=
X-Gm-Gg: Acq92OFYKNMbThwQ50mfIqqIKVWJcOc8BTztRVRrB/HlmmtQVLOgpD5xkgT1Q7gXNVY
	gVqc1hHEs3B1Ew7EC7Hz1aUGo3aSMIHQzH7/pn8elE3UbX8HntIyHHIuhhpSYRJFIg7nM/gWOom
	5i/m6CES9mHFQhQW/EFUziA2+c0w5OuddEtXiremqCvZJTKfG6iL71j7+8Fs3VxC5nChQdoACGX
	YCfzhif4W743MKGP4DMbeXC3W6Cb5AnzPgDU+eny5JZeHSSM0TMta8dK8Hy2CI1HqApgqnlH99Y
	OoJbglIFi1dMGyaYpNRUdjlxpdIdSSuWpF3KzAiOFe3W5ZXu3SnFmqiBtQsfVhRj+KpZIFxb0zV
	iIjWNXMIxxMFQXODe0lBtLvmi5GVYLUsCK9lh94vqE+OQloMod44KrqI+AEGIwlpiXClblKXdmQ
	UtcnXjVD3POl6s1RutsbOc3NJqIAf3xXJHKDk5xpojqA==
X-Received: by 2002:a05:6000:4a02:b0:43d:50c:6f33 with SMTP id ffacd0b85a97d-4602194fc19mr9571400f8f.26.1780562192938;
        Thu, 04 Jun 2026 01:36:32 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F ([2620:10d:c092:500::7:a76c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4602cda363bsm1765818f8f.31.2026.06.04.01.36.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jun 2026 01:36:32 -0700 (PDT)
Date: Thu, 4 Jun 2026 09:36:29 +0100
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
Message-ID: <aiE5DZC8Io4SNI3H@gourry-fedora-PF4VCD3F>
References: <20260222084842.1824063-1-gourry@gourry.net>
 <ag6XyvxR-NU5rGn-@parvat>
 <ahOqzpzAua96HVkn@gourry-fedora-PF4VCD3F>
 <ah47NNhuiClgGCdn@parvat>
 <ah6bDNxlB1zBUnzN@gourry-fedora-PF4VCD3F>
 <ah-0CyZurn5D1ezY@parvat>
 <ah_RcTU8SpQG7hab@gourry-fedora-PF4VCD3F>
 <aiDVMgu0viTIml8H@parvat>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aiDVMgu0viTIml8H@parvat>
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
	TAGGED_FROM(0.00)[bounces-16637-lists,cgroups=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,gourry.net:from_mime,gourry.net:dkim,gourry-fedora-PF4VCD3F:mid,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 2702263E206

On Thu, Jun 04, 2026 at 11:43:14AM +1000, Balbir Singh wrote:
> On Wed, Jun 03, 2026 at 08:02:09AM +0100, Gregory Price wrote:
> > 
> > Here is how the page allocator fallback lists and nodemasks interact:
> > 
> >    Fallbacks A:  A B 
> >    Fallbacks B:  B A
> >    Fallbacks C:  C A B   (Private)
> >    Fallbacks D:  D B A   (Private)
> > 
> 
> Do we want regular memory (N_MEMORY) in the fallback list of device private nodes?
> The assumption is that we have ATS translation enabled? Assumiung A and
> B are N_MEMORY here or am I misreading your illustraion?
>

If we don't have __GFP_PRIVATE, then probably not.  This is a holdover
from the current __GFP_PRIVATE branch so that if the preferred_nid=
value is a private node (which is a hint, but not a hard control),
there's a way for that allocation to land *somewhere*.

__GFP_PRIVATE would say "Only allow access to private nodes if this
flag is provided - otherwise treat that as unreachable and fall back".

(__GFP_PRIVATE | __GFP_THISNODE) then does exactly what you expect (only
allocate from specifically this private node and don't fall back).

This has the added benefit of not causing OOM on allocation failure.

Some would consider such a request a bug (i.e. that caller has a bad
mask), but I find the premise of that statement to be flawwed if only
because we do not have good controls over what ends up in a nodemask due
to the existence of things like possible_nodes.


> > If we wanted to change this behavior, realistically we'd be looking for
> > a way to add specific nodes to certain fallback lists - rather than
> > modify the nodemask interaction in some way.
> 
> Yes, that is what we did with CDM, control the fallback for
> N_MEMORY_PRIVATE, but there is a design decision to be made here.
>

Agreed, but also one which can be deferred and played with since it's
all kernel-internal.  None of this should have UAPI implications, and we
need need to accept that we're going to get it wrong on the first try.

> > 2) full mempolicy support doesn't really make sense
> > 
> >    task mempolicy PROBABLY should never really touch private nodes,
> >    while VMA policy certainly can.  Assuming we're able to support
> >    multi-private-node masks, none of the non-bind mempolicies even
> >    make sense for most private nodes (interleave? weighted interleave?)
> > 
> 
> Yes, mostly, but is that baked into the design? If so, why?
>

"Baked in" in this case would mean:

  set_mempolicy(..., private_node) -> -EINVAL
  mbind(..., private_node)         -> Success

With appropriate documentation.

This can be changed later if a reasonable design was agreed upon.

> > 4) File VMA interactions don't entirely make sense with mbind
> > 
> >    In theory you might want:
> > 
> >    fd = open("somefile", ...);
> >    mem = mmap(fd, ...);
> >    mbind(mem, ..., private_node);
> >    for page in mem:
> >       mem[page_off] /* fault file into private memory */
> > 
> >    In reality: This does not work the way you want.
> 
> Why not? Just curious about what you found?
> 

Because pagecache pages are associated with potentially many VMAs.

The fault can be a soft fault or a hard fault.  On soft fault - the page
was already present, and will simply fault into VMA without being
migrated.

You can imagine the following

Process A:
    fd = open("somefile", ...);
    mem = mmap(fd, ...);
    mbind(mem, ..., private_node_A);
    for page in mem:
       mem[page_off] /* fault file into private memory */

Process B:
    fd = open("somefile", ...);
    mem = mmap(fd, ...);
    mbind(mem, ..., private_node_B);
    for page in mem:
       mem[page_off] /* fault file into private memory */

If process A runs first, and assuming VMA mempolicy is respected for
file backed allocation (note: it's not, see below) - then the second
process will think the memory now lives on node B when it's already
living on node A (pages are not migrated on fault).

filemap page cache means file-backed pages are global resources.

Re file-backed VMAs - see filemap_alloc_folio_noprof in mm/filemap.c

struct folio *filemap_alloc_folio_noprof(gfp_t gfp, unsigned int order)
{
        int n;
        struct folio *folio;

        if (cpuset_do_page_mem_spread()) {
                unsigned int cpuset_mems_cookie;
                do {
                        cpuset_mems_cookie = read_mems_allowed_begin();
                        n = cpuset_mem_spread_node();
                        folio = __folio_alloc_node_noprof(gfp, order, n);
                } while (!folio && read_mems_allowed_retry(cpuset_mems_cookie));

                return folio;
        }
        return folio_alloc_noprof(gfp, order);
}

We'd have to hang a mempolicy off of the file and use fctl or something
like this if we want a file to have a node preference.

> > 
> >    I went digging and we need a few mild extensions to allow
> >    migration on mbind to work for pagecache pages, and the fault
> >    path does not necessarily respect the vma mempolicy always.
> > 
> >    You also start getting into the question of "what happens when
> >    the node is out of memory and you don't have reclaim support?".
> 
> Yes, we should discuss reclaim support, I think we should allow for
> reclaim. It allows you to overcommit private memory the way we can
> with regular memory.
> 

Reclaim support is feasible, but again - crawl, walk, run.

If we get the base private node infrastructure in place, we can break
things like mempolicy and reclaim support into different work streams
to enable support for these features.

Different private node users will be interested in different
combinations of mm/ service support.

For example:  compressed memory as a swap backend DOES NOT want explicit
reclaim support - it will need to manage its own shrinker.  This comes
from requirements associated with that specific use case (which I do not
want to get into here).

That is why this series introduced the concept of NP_OPS_* - so that the
owner (driver) of a private node (such as a CXL-enabled accelerator
driver) can tell mm/ what services it should enable for that node.

> > 
> > For all these reasons, I think the be mbind/mempolicy support with
> > private nodes needs to be brought in with follow up work - not
> > introduced as part of the baseline set.
> > 
> 
> I am not opposed to the follow up work, but I feel mbind() should
> be the fundamental work and user space API.
>

This is informed by a single use case / device.

There are users / devices that don't want any UAPI for their memory,
but simply wish to re-utilize some subsection of mm/ (page_alloc,
reclaim, etc).

> > 
> > I am arguing for #1 - the community has argued for #2 and "fixing
> > existing nodemask users".  I think we can ship #2 and pivot to #1 if we
> > find fixing existing users is infeasible or too much of a maintenance
> > burden.
> 
> Again happy to discuss this, I'd like to make sure we agree on the
> design. I am wondering if there is any experimental data to choose
> between 1 and 2.
> 

I am trying to test whether, lacking __GFP_PRIVATE, any normal runtime
operations access private nodes removed from fallback lists are reached
via something like the possible / online nodemask.

I remember, maybe a year ago, there were per-node allocations happening
during hotplug and that's why I originally proposed __GFP_PRIVATE, but
I'm trying to re-collect that data now.

~Gregory

