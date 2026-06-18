Return-Path: <cgroups+bounces-17075-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id CMGcHG/UM2rZGwYAu9opvQ
	(envelope-from <cgroups+bounces-17075-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Thu, 18 Jun 2026 13:20:15 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DD44A69FB55
	for <lists+cgroups@lfdr.de>; Thu, 18 Jun 2026 13:20:14 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gourry.net header.s=google header.b=qVrxGkqI;
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-17075-lists+cgroups=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="cgroups+bounces-17075-lists+cgroups=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AE10B30AA7F7
	for <lists+cgroups@lfdr.de>; Thu, 18 Jun 2026 11:13:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D75CF3F1ABD;
	Thu, 18 Jun 2026 11:13:40 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1480A3F1655
	for <cgroups@vger.kernel.org>; Thu, 18 Jun 2026 11:13:38 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781781220; cv=none; b=BqISVqO3IL5RjXxN1Q6mFnE05vh5LVtEpgGnnvzO7VtNrVinKYmqSDmceZpN8ZeeAOzFmRZxs4/ci4Scw9+5Ly+vXCCSRwGlcS0SFjErP7l/y0kh4I+hib9N/zP7RixwCc1Atn6UaN3BVpPCcdVlEHF/z/LhiqC/iutv10GzkzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781781220; c=relaxed/simple;
	bh=/ZthRalEH02k4ojVZ3SnfwbHBRAbkzip3FcZk3ai2ZU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ie01AaP5q31r2XYNFmbx6GekXX0l1f3wlSudExqUNd367SDeVZawPjzfN8F+vs/dF4WtFdJkF5zcOYDnn3YGLbcvMeWJ9HpEYKrR1s0vnHWHTJo3b46ZzaLwrrueIKXNlqJiDaIj3KVTxg/of8kkEjHktDkLwXd2eriGXW1IqvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=qVrxGkqI; arc=none smtp.client-ip=209.85.222.172
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-9157b949fc7so94285485a.3
        for <cgroups@vger.kernel.org>; Thu, 18 Jun 2026 04:13:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1781781218; x=1782386018; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=VDILEybOTlA7pWxB3ZppyNLc60d4wQCyVXPTTIKX4iY=;
        b=qVrxGkqIgKRti1WdVreLtmgf5H9xnscQMSlcHeNRFiazkoarSOS3zLeXdkKdcTIniP
         ATcFvMqXt0WGc+7TlStzXdIJiTnU8q9n4tgWn3Zf3lMozrjevDF73oskW7Xs6nLa0aUN
         ecd+GM+2qPz+cgR5G0bhOXCMtVNfgUWcIsusbiRPApzED7zq3vy43q1g4rCRwogII/iB
         U+N4KIN5EDmo7ZhWKVGsBnOmCYFd3oNS/t6xGJYbs1YBCU1ly1GfU4ESiS16bFVs/eiz
         Hkafrryp7uubgbW+0o+DQvJfzE+RTXpfAy5itxodFC9higJfgldWt+SRH9JkE1VeOGZu
         ZbFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781781218; x=1782386018;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VDILEybOTlA7pWxB3ZppyNLc60d4wQCyVXPTTIKX4iY=;
        b=VovNn4S9CTWQWkjY1ggBO/dk+vyZdHqFAlQjkaolSs3TdHYPInsMXH1D/cOC/gwlS7
         mZzEpXvBQksGmlEANwJKJhnxUTktaknQgaG64dnSmBTV0tdRRiKTiGHx02q+N6csrpcj
         MDo/hIlCoz8vBH5AccT+scjWI6py/Sjgcf+Epi0IqOLSd/bQpBZo4wdREHfi3QXi+jz3
         a9WYH/Gk9SEbgH0CNp+7d+5HhB1CEpHzyS+QO+v5HNsDOtrmM8ehSB5TOhg1AJNxaPWt
         4545o0Sn0ac3y4miTRXtq+t3k6IWk9znGt0TbtYMJp78h7CY6Hr/yclqj6IqvN5nRG/o
         9fMw==
X-Forwarded-Encrypted: i=1; AFNElJ+bYrYO3xrHoIBDz8tnqOBDtkhqNlCJiSKmu26G8xIxGoCTz1iJJ6ZVKhGO8UXCDsP68ad0mOCK@vger.kernel.org
X-Gm-Message-State: AOJu0YzD8ZETDS9HHUYnFy6MCPANnXp/CujZzQdu1K9xfOaHemfUuhI8
	5BQ2nm5X1nMHKBZjN7HWkJQxJIq+sC28d8XBR4d81b80U1sLbhdgAv8eetlvd3B9BEg=
X-Gm-Gg: Acq92OHoBMQBH0XhSOTK4T4m5Mo+z9ACG6A7f7uUxG2XP0SJ9UVLHIW0YkpTCZDRld2
	9ymlg6I6mwrsSgWhUYJCb8dH9nFYvFrJ0cwNUPkSxrSGgc3vtuK8nA0m8Z63Z4Vr6+afldA2Raa
	aXulMjMx5vSrCTqR3YtdjRwbblT01IgPVt7D5N7NzFy1Nb23lLdp+u/V+7+698P4VZqwiKhfn2T
	nUwquGxKvzT/Yq49iZ7lA92mVJsgxCNaJe/nZUreuG2NF1Lc8f9Uf9ZB7Y9tlNpi1M28Vx9G43+
	Db8ub+ReZ1aTJ08ONi24xdcQ1fkfVGKaLoifZ0VD4Z+xViD8q2LXGFkKqfi+yDaWla/MA76oOAL
	BgRa4EhQ9VE//94k2TWOrtvKQf/nQpTwxkJj8ROzqBtk7qgg/H1Yc5RPB4P1Oe0ECgglW8pfgwX
	kvVoohNEPYBtTpe8HOeGnOhuSixMNB/tHB1YoijRV27FGwQ1/ML80XtHnl6DfP83q/j1m5
X-Received: by 2002:a05:620a:278a:b0:915:9fba:878f with SMTP id af79cd13be357-91f8ba807ffmr224910185a.5.1781781217669;
        Thu, 18 Jun 2026 04:13:37 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (pool-173-79-60-52.washdc.fios.verizon.net. [173.79.60.52])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-91619ed7215sm1951269085a.7.2026.06.18.04.13.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jun 2026 04:13:37 -0700 (PDT)
Date: Thu, 18 Jun 2026 07:13:32 -0400
From: Gregory Price <gourry@gourry.net>
To: "Vlastimil Babka (SUSE)" <vbabka@kernel.org>
Cc: "David Hildenbrand (Arm)" <david@kernel.org>,
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
Message-ID: <ajPS3AKrZEbZbXBw@gourry-fedora-PF4VCD3F>
References: <aik_ddHymus2DJ6D@gourry-fedora-PF4VCD3F>
 <c1b66e7a-bb95-4295-8193-55ceadaaa578@kernel.org>
 <aimSzvoJDrpeQsmM@gourry-fedora-PF4VCD3F>
 <d01fb1ed-2418-42ee-aea2-37f9a5c5729c@kernel.org>
 <ainFROZ3WrGioyuY@gourry-fedora-PF4VCD3F>
 <aiwl4kCG814dpX7L@gourry-fedora-PF4VCD3F>
 <9f1815b0-896b-44ab-9e6d-9316d8f11033@kernel.org>
 <fdbdc9f7-d142-4880-b429-065d5056cabb@kernel.org>
 <ajAcIwBAnqgEEWSD@gourry-fedora-PF4VCD3F>
 <90418cd3-751f-439d-83ed-a0c33517c3bd@kernel.org>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <90418cd3-751f-439d-83ed-a0c33517c3bd@kernel.org>
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
	TAGGED_FROM(0.00)[bounces-17075-lists,cgroups=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:vbabka@kernel.org,m:david@kernel.org,m:balbirs@nvidia.com,m:lsf-pc@lists.linux-foundation.org,m:linux-kernel@vger.kernel.org,m:linux-cxl@vger.kernel.org,m:cgroups@vger.kernel.org,m:linux-mm@kvack.org,m:linux-trace-kernel@vger.kernel.org,m:damon@lists.linux.dev,m:kernel-team@meta.com,m:gregkh@linuxfoundation.org,m:rafael@kernel.org,m:dakr@kernel.org,m:dave@stgolabs.net,m:jonathan.cameron@huawei.com,m:dave.jiang@intel.com,m:alison.schofield@intel.com,m:vishal.l.verma@intel.com,m:ira.weiny@intel.com,m:dan.j.williams@intel.com,m:longman@redhat.com,m:akpm@linux-foundation.org,m:lorenzo.stoakes@oracle.com,m:Liam.Howlett@oracle.com,m:vbabka@suse.cz,m:rppt@kernel.org,m:surenb@google.com,m:mhocko@suse.com,m:osalvador@suse.de,m:ziy@nvidia.com,m:matthew.brost@intel.com,m:joshua.hahnjy@gmail.com,m:rakie.kim@sk.com,m:byungchul@sk.com,m:ying.huang@linux.alibaba.com,m:apopple@nvidia.com,m:axelrasmussen@google.com,m:yuanchu@google.com,m:weixugc@google.com,m:yury.norov@gmai
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,gourry.net:dkim,gourry.net:from_mime,gourry-fedora-PF4VCD3F:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: DD44A69FB55

On Thu, Jun 18, 2026 at 10:21:30AM +0200, Vlastimil Babka (SUSE) wrote:
> On 6/15/26 17:37, Gregory Price wrote:
> > 
> > One thought would be a way to switch what fallback list is used, and
> > then have specific fallback lists for certain contexts.
> > 
> > Right now there is a single example of this: __GFP_THISNODE
> >   |= __GFP_THISNODE   =>  NOFALLBACK
> >   &= ~__GFP_THISNODE  =>  FALLBACK
> > 
> > We could add an interface with the desired fallback list based as an
> > argument, and let get_page_from_freelist to prefer that over the default
> > global lists.
> 
> Does it mean a new argument in a number of functions in the page allocator,
> or can it be mapped to alloc_flags (at least internally?), because the
> number of possible fallback lists is small enough?
>

What I ended up with was adding a single page_alloc.c external interface
that allows you define the zonelist via an enum, and then an internal
selector resolution in prepare_alloc_pages() stored in alloc_context

eg:

static inline bool prepare_alloc_pages(gfp_t gfp_mask, unsigned int order,
                int preferred_nid, nodemask_t *nodemask,
                struct alloc_context *ac, gfp_t *alloc_gfp,
                unsigned int *alloc_flags)
{       
        ac->highest_zoneidx = gfp_zone(gfp_mask);
        ac->zonelist = select_zonelist(preferred_nid, gfp_mask, ac->zlsel);
	... snip ...
}

struct folio *__folio_alloc_zonelist_noprof(gfp_t gfp, unsigned int order,
                int preferred_nid, nodemask_t *nodemask,
                enum alloc_zonelist zlsel);


The original __folio_alloc* functions just add a DEFAULT - which tells
select_zonelist() to base the decision on __GFP_THISNODE.


struct folio *__folio_alloc_noprof(gfp_t gfp, unsigned int order, int preferred_nid,
                nodemask_t *nodemask)
{
        return __folio_alloc_core(gfp, order, preferred_nid, nodemask,
                                  ALLOC_ZONELIST_DEFAULT);
}
EXPORT_SYMBOL(__folio_alloc_noprof);


This does a few things
  - The isolation is structural, there is no way to accidentally
    allocate private memory without passing ALLOC_ZONELIST_PRIVATE

  - The isolation forces folios - there are no non-folio interfaces
    which allow zonelist selection

  - The zonelist selection is confined to this allocation context,
    so no inheritence is possible.



I tried to avoid using an ALLOC_ flag so we can avoid yet another flag
crunch, but there certainly are few enough zonelists that we could
encode it there and expose it.  I know Brendan was looking at plumbing
alloc flags out to an interface, so i'm open to that.

Externally the way I determine what zonelist to use is a lookup based on
reason - letting the node filter.  This is really only needed in a
couple spots:

mm/khugepaged.c:  enum alloc_zonelist zlsel = alloc_zonelist_for_node(node, NODE_ALLOC_RECLAIM);
mm/vmscan.c:      mtc->zlsel = alloc_zonelist_for_nodemask(mtc->nmask, NODE_ALLOC_TIERING);
mm/migrate.c:     .zlsel = alloc_zonelist_for_node(node, NODE_ALLOC_USER_MIGRATE),

static inline enum alloc_zonelist
alloc_zonelist_for_node(int nid, enum node_alloc_reason reason)
{
        bool ok;

        if (!node_state(nid, N_MEMORY_PRIVATE))
                return ALLOC_ZONELIST_DEFAULT;
        switch (reason) {
        case NODE_ALLOC_RECLAIM:
                ok = node_is_reclaimable(nid);
                break;
        case NODE_ALLOC_TIERING:
                ok = node_allows_tiering(nid);
                break;
        case NODE_ALLOC_USER_MIGRATE:
                ok = node_allows_user_migrate(nid);
                break;
        default:
                ok = false;
        }
        return ok ? ALLOC_ZONELIST_PRIVATE : ALLOC_ZONELIST_DEFAULT;
}

Otherwise... everything is now a mempolicy w/ MPOL_F_BIND and all the
handling goes through the normal fault-paths :]

static struct page *__alloc_pages_mpol(gfp_t gfp, unsigned int order,
                struct mempolicy *pol, pgoff_t ilx, int nid)
{
        nodemask_t *nodemask;
        struct page *page;
        enum alloc_zonelist zlsel = (pol->flags & MPOL_F_PRIVATE) ?
                ALLOC_ZONELIST_PRIVATE : ALLOC_ZONELIST_DEFAULT;
...
        if (pol->mode == MPOL_PREFERRED_MANY)
                return alloc_pages_preferred_many(gfp, order, nid, nodemask,
                                                  zlsel);
...
}


Switching to an alloc_flag would probably be trivially if that's really
wanted

~Gregory

