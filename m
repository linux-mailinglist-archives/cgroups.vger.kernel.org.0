Return-Path: <cgroups+bounces-16829-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id XZ9SLM6UKWo3aAMAu9opvQ
	(envelope-from <cgroups+bounces-16829-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Wed, 10 Jun 2026 18:46:06 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 16B1566BA24
	for <lists+cgroups@lfdr.de>; Wed, 10 Jun 2026 18:46:06 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gourry.net header.s=google header.b=Si08fxas;
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-16829-lists+cgroups=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="cgroups+bounces-16829-lists+cgroups=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 924693001BF3
	for <lists+cgroups@lfdr.de>; Wed, 10 Jun 2026 16:37:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEB89340411;
	Wed, 10 Jun 2026 16:37:40 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0D1B3438A0
	for <cgroups@vger.kernel.org>; Wed, 10 Jun 2026 16:37:38 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781109460; cv=none; b=Zkh+AdDDT3qTDTt76uiN6rmeDrYNY2p/HH5ooegx6ret7hNvUR/dnNVCwytNDFq7Xvi3jF5vEl3fiKm+uFuMMlFTzpZdSdzgwV6Xou2peREc/hiS6TpY0eNga3wpoTpMmgCEC+Hp22iAZv1h7QBhF1X0zS6VFETXQ1RSrM122FQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781109460; c=relaxed/simple;
	bh=ubW61os22iPHl+RFlnY1FEaETS2knsxVWz5JYXskkiE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QGW3ss0byKRqh8DD4ah9DKZDzIIQ0VqpsT5poBN2twJTtzpgMwJqTbv8DmNcBrBmMj6vcYzF/nL7YPW4h4cheFBzxs9P6OE02L0Ddnxo0SmeAkh3CTPtdQzA8JG0uEA2eko6FahyVPB4a7EWprjMs6ZlDF6D2blf9W3ADgpD0fo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=Si08fxas; arc=none smtp.client-ip=209.85.160.171
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-51761d27612so81020261cf.3
        for <cgroups@vger.kernel.org>; Wed, 10 Jun 2026 09:37:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1781109458; x=1781714258; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=SYADJHUyTsZxeNPAhkpfIZ+IyBSWkrAmnBG2JAxdu0A=;
        b=Si08fxasUsSKrIUNrhXMH6CXbHcoEFhktudC6oZ0240dyaMqZNv0FW0WX2g8yhx8TB
         UEsOhYwS8LuiLzQ1izZdNmWXwEeRL9u55IkBjfAgswpjmN2jFpob/KChuBai95agFYT4
         YEiBeGRaV/P4SRIilkeE6ZfgUAcZbF50523Fsfq4Q6ulsWmJV+yulTqDS/VoQgnlbTfw
         kuwptdqvvTdVJd/2qpACBxtenfHQnrDhzMWw+aTWlLlO+CdXtmV7pRLMY0ZImj3P9IRk
         xPuKZQ/VAG1jXHR0LQ0xHYYoerwxQjt2oNGLXqR1tx64rB5Q9/diFuG6zNJJMyyuywfH
         lxnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781109458; x=1781714258;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SYADJHUyTsZxeNPAhkpfIZ+IyBSWkrAmnBG2JAxdu0A=;
        b=QorYpJn/E0Ly9WIiOrPz+bN7VRewi2Bk44XG8kXDkFaYwZArusDM9al06afImBgg2X
         CAy+nBNOi8sO2Y4VwcvUen00YVyh3O30pxwPIZnGLWEhynAsefmXag4d61NIB8QVFghP
         r4ZXaxa0ouX0D4YhV2v9zlALbWwcfC8mRjZejfhMEK6BYrJ/rGTxKKrW+Kr/PjntEz9z
         4qEB4jj4lomdLcvGg+BQm7Rvegkv+rrdAQ6pNO8aBMzWO6t/Y8K/pnq9dzBztADm0zFt
         IBej/53mJ8i68Kr4LEhbGVZk+Edi3Pgr0FgsWL925fscCRN4qeRpW0EjvqlFI3lwE1VE
         FoGA==
X-Forwarded-Encrypted: i=1; AFNElJ8cRqrFEsv3kl8u9xiiRnWxV8/KkEd/Mrjz8qX1E+DiHNylkoYH4MGi0/XBIbPi1QV4iaqB+24T@vger.kernel.org
X-Gm-Message-State: AOJu0YwG0+znx2Eq7HbnFrUnn1PZY5FHXlaArvl11j9id3ahSMvuhepz
	WQdz8YsKxlg3Rs7um5lqPZMbGZT+TCR3tYT1J93BNrZC8smp0P/80rZsL3+A57uFzUc=
X-Gm-Gg: Acq92OEeXkyL55XJshx6r6iBkCvocNXI73fpp67aHmg/qEKg9sYsKumMUgSg2bMNhkN
	J6CKaS9VmBzCZ2PNSJROsSOaEzTleznk8C/szGK30dsu5hLVFXYwHBshaBwlGF4JL33HpTOTT0d
	Gr8VzA1zuhvXsiV5Fdr+dyChafCt03OGYg0Feo1JkEx/nw9jGEst+WKUwLh4YtDDG8wNzK5uJw6
	2UjnGKRGcvgkNRBl4Yb4IbpKpcLMZ6VbSFs8m6HfAMqxqCDrHAtKxYU+mPDZ2xc5Ruq5DS9cg4j
	bP5dV2gayCPPUWoeVc9Iu9IbeS4dxumZZJ92FVGUcqTTotbNmv12kqnY+AwQbKSHREKXKvjeeBi
	fCpMCKK5QbrY9pLecfjsoxb7RyEG/EcOcjIid5jxVLdCbfCrjHGjr2md9OGIQq14MUO52QJhHZc
	KshUqtKVARBNWq2i5wAoI14ZB0JUmxKzAQm3qST6ADNquNxVB3Rh1deqL9tXA7Y8NWadTxDlnWp
	FzUrsdHZ2Ei7yj92Q==
X-Received: by 2002:a05:622a:6205:b0:517:85e1:38a2 with SMTP id d75a77b69052e-51795c22a42mr365134121cf.31.1781109457374;
        Wed, 10 Jun 2026 09:37:37 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (pool-173-79-60-52.washdc.fios.verizon.net. [173.79.60.52])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8cecd06b701sm233484876d6.34.2026.06.10.09.37.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jun 2026 09:37:36 -0700 (PDT)
Date: Wed, 10 Jun 2026 12:37:34 -0400
From: Gregory Price <gourry@gourry.net>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: Balbir Singh <balbirs@nvidia.com>, lsf-pc@lists.linux-foundation.org,
	linux-kernel@vger.kernel.org, linux-cxl@vger.kernel.org,
	cgroups@vger.kernel.org, linux-mm@kvack.org,
	linux-trace-kernel@vger.kernel.org, damon@lists.linux.dev,
	kernel-team@meta.com, gregkh@linuxfoundation.org, rafael@kernel.org,
	dakr@kernel.org, dave@stgolabs.net, jonathan.cameron@huawei.com,
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
	bhe@redhat.com, zhengqi.arch@bytedance.com, terry.bowman@amd.com
Subject: Re: [LSF/MM/BPF TOPIC][RFC PATCH v4 00/27] Private Memory Nodes (w/
 Compressed RAM)
Message-ID: <aimSzvoJDrpeQsmM@gourry-fedora-PF4VCD3F>
References: <20260222084842.1824063-1-gourry@gourry.net>
 <ag6XyvxR-NU5rGn-@parvat>
 <ahOqzpzAua96HVkn@gourry-fedora-PF4VCD3F>
 <ah47NNhuiClgGCdn@parvat>
 <ah6bDNxlB1zBUnzN@gourry-fedora-PF4VCD3F>
 <ah-0CyZurn5D1ezY@parvat>
 <aik_ddHymus2DJ6D@gourry-fedora-PF4VCD3F>
 <c1b66e7a-bb95-4295-8193-55ceadaaa578@kernel.org>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c1b66e7a-bb95-4295-8193-55ceadaaa578@kernel.org>
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
	TAGGED_FROM(0.00)[bounces-16829-lists,cgroups=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:david@kernel.org,m:balbirs@nvidia.com,m:lsf-pc@lists.linux-foundation.org,m:linux-kernel@vger.kernel.org,m:linux-cxl@vger.kernel.org,m:cgroups@vger.kernel.org,m:linux-mm@kvack.org,m:linux-trace-kernel@vger.kernel.org,m:damon@lists.linux.dev,m:kernel-team@meta.com,m:gregkh@linuxfoundation.org,m:rafael@kernel.org,m:dakr@kernel.org,m:dave@stgolabs.net,m:jonathan.cameron@huawei.com,m:dave.jiang@intel.com,m:alison.schofield@intel.com,m:vishal.l.verma@intel.com,m:ira.weiny@intel.com,m:dan.j.williams@intel.com,m:longman@redhat.com,m:akpm@linux-foundation.org,m:lorenzo.stoakes@oracle.com,m:Liam.Howlett@oracle.com,m:vbabka@suse.cz,m:rppt@kernel.org,m:surenb@google.com,m:mhocko@suse.com,m:osalvador@suse.de,m:ziy@nvidia.com,m:matthew.brost@intel.com,m:joshua.hahnjy@gmail.com,m:rakie.kim@sk.com,m:byungchul@sk.com,m:ying.huang@linux.alibaba.com,m:apopple@nvidia.com,m:axelrasmussen@google.com,m:yuanchu@google.com,m:weixugc@google.com,m:yury.norov@gmail.com,m:linux@rasmus
 villemoes.dk,m:mhiramat@kernel.org,m:mathieu.desnoyers@efficios.com,m:tj@kernel.org,m:hannes@cmpxchg.org,m:mkoutny@suse.com,m:jackmanb@google.com,m:sj@kernel.org,m:baolin.wang@linux.alibaba.com,m:npache@redhat.com,m:ryan.roberts@arm.com,m:dev.jain@arm.com,m:baohua@kernel.org,m:lance.yang@linux.dev,m:muchun.song@linux.dev,m:xu.xin16@zte.com.cn,m:chengming.zhou@linux.dev,m:jannh@google.com,m:linmiaohe@huawei.com,m:nao.horiguchi@gmail.com,m:pfalcato@suse.de,m:rientjes@google.com,m:shakeel.butt@linux.dev,m:riel@surriel.com,m:harry.yoo@oracle.com,m:cl@gentwo.org,m:roman.gushchin@linux.dev,m:chrisl@kernel.org,m:kasong@tencent.com,m:shikemeng@huaweicloud.com,m:nphamcs@gmail.com,m:bhe@redhat.com,m:zhengqi.arch@bytedance.com,m:terry.bowman@amd.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[nvidia.com,lists.linux-foundation.org,vger.kernel.org,kvack.org,lists.linux.dev,meta.com,linuxfoundation.org,kernel.org,stgolabs.net,huawei.com,intel.com,redhat.com,linux-foundation.org,oracle.com,suse.cz,google.com,suse.com,suse.de,gmail.com,sk.com,linux.alibaba.com,rasmusvillemoes.dk,efficios.com,cmpxchg.org,arm.com,linux.dev,zte.com.cn,surriel.com,gentwo.org,tencent.com,huaweicloud.com,bytedance.com,amd.com];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,gourry.net:dkim,gourry.net:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 16B1566BA24

On Wed, Jun 10, 2026 at 05:00:33PM +0200, David Hildenbrand (Arm) wrote:
> On 6/10/26 12:41, Gregory Price wrote:
> > On Wed, Jun 03, 2026 at 03:00:01PM +1000, Balbir Singh wrote:
> > 
> > Notably: slub.c injects __GFP_THISNODE internally on behalf of kmalloc,
> > which causes spillage into private nodes because slub allows private
> > nodes in its mask.  I think this is fixable.
> > 
> > I have to inspect some other __GFP_THISNODE users (hugetlb, some arch
> > code, etc), but it seems like fully dropping the FALLBACK entries and
> > requiring __GFP_THISNODE might be sufficient.
> 
> Sorry, I haven't been able to follow up so far, and not sure if that's what you
> are discussing here ...
> 
> After the LSF/MM session, I was wondering, whether if we focus on allowing only
> folios allocations to end up on private memory nodes for now: could the
> __GFP_THISNODE approach work there?
> 
> Essentially, disallow any allocations on non-folio paths, and allow folio
> allocation only with __GFP_THISNODE set.
> 
> I have to find time to read the other mails in this thread, on my todo list.
> 
> So sorry if that is precisely what is being discussed here.
> 

So, I remember this being asked, and I didn't fully grok the request.

I'm still not sure I fully understand the question, so apologies if I'm
answer the wrong things here.

I understand this question in two ways:

  1) Can we disallow PAGE allocation and limit this to FOLIO allocation
  2) Can we disallow [Feature] (i.e. slab) allocation targeting the node.


1) Can we disallow page allocation and limit this to folios?

No, I don't think so.

Folio allocations are written in terms of page allocations, we would
have to rewrite folio allocation interfaces and introduce a bunch of
boilerplate for the sake of this.

struct page *__alloc_pages_noprof(gfp_t gfp, unsigned int order,
                int preferred_nid, nodemask_t *nodemask)
{
        struct page *page;

        page = __alloc_frozen_pages_noprof(gfp, order, preferred_nid, nodemask);
        if (page)
                set_page_refcounted(page);
        return page;
}

struct folio *__folio_alloc_noprof(gfp_t gfp, unsigned int order, int preferred_nid,
                nodemask_t *nodemask)
{
        struct page *page = __alloc_pages_noprof(gfp | __GFP_COMP, order,
                                        preferred_nid, nodemask);
	return page_rmappable_folio(page);
}

At the end of the day, this all reduces to `get_pages_from_freelist`,
and at that level we don't really care about folio vs page.

__GFP_COMP is insufficient to differentiate between a non-folio compound
page and a folio, and __GFP_COMP is passed into __alloc_pages_*
interfaces all over the kernel.

Trying to detach these paths things seems like a horrible rats nest /
not feasible / will create a lot of boilerplate for little value.

(I did not fully understand this request when it was asked, I do
 not fully understand this request not, please let me know if I
 have misunderstood what you were asking).



2) Can we disallow SLAB allocation.

Yeah, but I think a better question is whether there's a difference
between alloc_pages_node() and kmalloc_node() when it all just sinks
to the same fundamental code in mm/page_alloc.c

Maybe there's an argument for something like NP_OPT_KMALLOC (allow slab
allocations on the private node w/ __GFP_THISNODE)

On my current set, I don't implement any explicit filtering at all in
mm/page_alloc.c - the filtering is a function of the nodes not being
present in the FALLBACK list and only having a NOFALLBACK list.

What __GFP_THISNODE actually does under the hood is just switch
which zone list (FALLBACK vs NOFALLBACK) is used for the target node.

For isolation w/o __GFP_PRIVATE, we're removing N_MEMORY_PRIVATE nodes
from *their own FALLBACK* list and only adding them to their NOFALLBACK
list.  That means to reach a private node you MUST use __GFP_THISNODE.

I realize this is confusing, but essentially we don't have to modify
mm/page_alloc.c to get the __GFP_THISNODE filtering, we get this from
the fallback/nofallback list construction.


Ok, so how does this flush out in practice - and why do I call this
filtering mechanism fragile?

consider kmalloc_node() and __slab_alloc():

kmalloc_node(...)
  └─ ___slab_alloc()     mm/slub.c:4406   pc.flags |= __GFP_THISNODE
      └─ new_slab(s, pc.flags, node)
          └─ allocate_slab(s, flags, node)
              └─ alloc_slab_page(flags, node, oo, …)
                  └─ __alloc_frozen_pages(flags, order, node, NULL);

Slab silently upgrades the page allocator flags here to include
__GFP_THISNODE - even if the user didn't request that behavior.

This is exactly the kind of "spillage" I said was hard to police at LSF.

Without __GFP_PRIVATE, we have to keep an eye on what around the kernel
is using __GFP_THISNODE and how.

For mm/slub.c we can choose to do one of thwo things

  1) 100% refuse slab allocations on private nodes, i.e.:

     kmalloc_node(..., private_nid, __GFP_THISNODE)

     And will fail (return NULL).

  or

  2) Do not upgrade private-node slab requests w/ __GFP_THISNODE
     
     This allows kmalloc_node() to work the same as folio_alloc()
     or alloc_pages() interfaces (__GFP_THISNODE is the key), with
     the understanding that any __GFP_THISNODE user

We can opt these nodes into slab/kmalloc with a NP_OPT_SLAB
if the owner wants kmalloc_node(), with the understanding that any
caller using __GFP_THISNODE may get access.

That's the kind of fragility I was trying to avoid.


That said, in practice, I have found that basic kernel operations don't
generally target use kmalloc_node() w/ __GFP_THISNODE - there's just
nothing to prevent anyone from doing so.

So this seems promising...
And then theres arch/powerpc/platforms/powernv/memtrace.c

static u64 memtrace_alloc_node(u32 nid, u64 size)
{
	... snip ...
        page = alloc_contig_pages(nr_pages, GFP_KERNEL | __GFP_THISNODE |
                                  __GFP_NOWARN | __GFP_ZERO, nid, NULL);
	... snip ...
}

static int memtrace_init_regions_runtime(u64 size)
{
	... snip ...
        for_each_online_node(nid) {
                m = memtrace_alloc_node(nid, size);
	... snip ...
}

static int memtrace_enable_set(void *data, u64 val)
{
	... snip ...
        if (memtrace_init_regions_runtime(val))
                goto out_unlock;
	... snip ...
}

This is the *exact* pattern I said would be hard to police - and it
doesn't look like a bug, just not informed that private nodes exist.

This is why I'm concerned with trying to depend on __GFP_THISNODE as the
filtering function.

That said, the number of __GFP_THISNODE users is very limited
kernel-wide, so maybe that's an acceptable maintenance burden?

~Gregory

