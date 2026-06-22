Return-Path: <cgroups+bounces-17140-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id bBKBAVUrOWplnwcAu9opvQ
	(envelope-from <cgroups+bounces-17140-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Mon, 22 Jun 2026 14:32:21 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 607B06AF747
	for <lists+cgroups@lfdr.de>; Mon, 22 Jun 2026 14:32:20 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=Yq6Bpl9x;
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-17140-lists+cgroups=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="cgroups+bounces-17140-lists+cgroups=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 71E2D30347E4
	for <lists+cgroups@lfdr.de>; Mon, 22 Jun 2026 12:31:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B56443AA517;
	Mon, 22 Jun 2026 12:31:44 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BAAF3A9D9C;
	Mon, 22 Jun 2026 12:31:43 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782131504; cv=none; b=VXIuJe3mknMu8tAu6ZY8dv3OIhBXgQj+HpOX2/h/rPdQxxod2XXScb7pn5DPzOTKSlNb5lY6V5Cmn+lQ2mlRy16UUKUez5Om+HuNsCA048gy6thvVT6GUssdFQr3K/SOd/Tgq7gK7+Y0N/+tPz0+GFxJ5D9tPRyeu+9+u/2cAzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782131504; c=relaxed/simple;
	bh=cZea8u201/KNpcJN/7HBfbqx3/twPSpuO7D46mqtqY4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qKP7bP9bqPcgGoyyyYUbOf3ZA+aAwnqoujCVeeplpQolejITeK/6SAFLO8tBpZKLVBz7Khlq5OFHk+vTdwqY8emzbJhIdpM4aKSGhMFiYsRjldof3i1+QyX4EL0ts6IYVA7ERW0foXj63neTlUpdw4CgQkX+2zNbjNGOMMsAFbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Yq6Bpl9x; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E0ED1F000E9;
	Mon, 22 Jun 2026 12:31:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782131503;
	bh=mv1TDIjJmBLfFfHDh7TWc3Ec+yFIfWNb9f4z3gl0gSU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=Yq6Bpl9xNgG8eaRATgdPo0E6+dJzOGDQdCno3iqmf9KIjIyllG26382Fr+fu01Xf9
	 bUxEbSPKJ8PlEknLGKhUqgRA61PAmFzSJyc1PboFoovpAJAw/XooS3FS6ehllQovLR
	 lZjaUXJqM2NijaocEgvjjV0L0wYR640roDVz94qNQodlQ/fWv/DAdDjodvjLDklrZs
	 5/kg/o5GRcSCI3UnWdBn5hE0/Yxen3qdzKU4Pv1QmF/0aj1G+OQ+VuKGt8hcVDMbXm
	 6CrJEankWsCzYKYacNiCs0vkPokNkFSC7JFUDLoURnu1O0TSFTiyMNn3+RaT36bGsh
	 H6c0z304WZg0A==
Message-ID: <6b22698c-ac2e-4c71-9448-50f073b4efc6@kernel.org>
Date: Mon, 22 Jun 2026 14:31:24 +0200
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Lsf-pc] [LSF/MM/BPF TOPIC][RFC PATCH v4 00/27] Private Memory
 Nodes (w/ Compressed RAM)
Content-Language: en-US
To: Gregory Price <gourry@gourry.net>
Cc: "David Hildenbrand (Arm)" <david@kernel.org>,
 Balbir Singh <balbirs@nvidia.com>, lsf-pc@lists.linux-foundation.org,
 linux-kernel@vger.kernel.org, linux-cxl@vger.kernel.org,
 cgroups@vger.kernel.org, linux-mm@kvack.org,
 linux-trace-kernel@vger.kernel.org, damon@lists.linux.dev,
 kernel-team@meta.com, gregkh@linuxfoundation.org, rafael@kernel.org,
 dakr@kernel.org, dave@stgolabs.net, jonathan.cameron@huawei.com,
 dave.jiang@intel.com, alison.schofield@intel.com, vishal.l.verma@intel.com,
 ira.weiny@intel.com, dan.j.williams@intel.com, longman@redhat.com,
 akpm@linux-foundation.org, lorenzo.stoakes@oracle.com,
 Liam.Howlett@oracle.com, vbabka@suse.cz, rppt@kernel.org, surenb@google.com,
 mhocko@suse.com, osalvador@suse.de, ziy@nvidia.com, matthew.brost@intel.com,
 joshua.hahnjy@gmail.com, rakie.kim@sk.com, byungchul@sk.com,
 ying.huang@linux.alibaba.com, apopple@nvidia.com, axelrasmussen@google.com,
 yuanchu@google.com, weixugc@google.com, yury.norov@gmail.com,
 linux@rasmusvillemoes.dk, mhiramat@kernel.org,
 mathieu.desnoyers@efficios.com, tj@kernel.org, hannes@cmpxchg.org,
 mkoutny@suse.com, jackmanb@google.com, sj@kernel.org,
 baolin.wang@linux.alibaba.com, npache@redhat.com, ryan.roberts@arm.com,
 dev.jain@arm.com, baohua@kernel.org, lance.yang@linux.dev,
 muchun.song@linux.dev, xu.xin16@zte.com.cn, chengming.zhou@linux.dev,
 jannh@google.com, linmiaohe@huawei.com, nao.horiguchi@gmail.com,
 pfalcato@suse.de, rientjes@google.com, shakeel.butt@linux.dev,
 riel@surriel.com, harry.yoo@oracle.com, cl@gentwo.org,
 roman.gushchin@linux.dev, chrisl@kernel.org, kasong@tencent.com,
 shikemeng@huaweicloud.com, nphamcs@gmail.com, bhe@redhat.com,
 zhengqi.arch@bytedance.com, terry.bowman@amd.com,
 Matthew Wilcox <willy@infradead.org>
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
 <ajPS3AKrZEbZbXBw@gourry-fedora-PF4VCD3F>
From: "Vlastimil Babka (SUSE)" <vbabka@kernel.org>
Autocrypt: addr=vbabka@kernel.org; keydata=
 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
In-Reply-To: <ajPS3AKrZEbZbXBw@gourry-fedora-PF4VCD3F>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-17140-lists,cgroups=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_CC(0.00)[kernel.org,nvidia.com,lists.linux-foundation.org,vger.kernel.org,kvack.org,lists.linux.dev,meta.com,linuxfoundation.org,stgolabs.net,huawei.com,intel.com,redhat.com,linux-foundation.org,oracle.com,suse.cz,google.com,suse.com,suse.de,gmail.com,sk.com,linux.alibaba.com,rasmusvillemoes.dk,efficios.com,cmpxchg.org,arm.com,linux.dev,zte.com.cn,surriel.com,gentwo.org,tencent.com,huaweicloud.com,bytedance.com,amd.com,infradead.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:gourry@gourry.net,m:david@kernel.org,m:balbirs@nvidia.com,m:lsf-pc@lists.linux-foundation.org,m:linux-kernel@vger.kernel.org,m:linux-cxl@vger.kernel.org,m:cgroups@vger.kernel.org,m:linux-mm@kvack.org,m:linux-trace-kernel@vger.kernel.org,m:damon@lists.linux.dev,m:kernel-team@meta.com,m:gregkh@linuxfoundation.org,m:rafael@kernel.org,m:dakr@kernel.org,m:dave@stgolabs.net,m:jonathan.cameron@huawei.com,m:dave.jiang@intel.com,m:alison.schofield@intel.com,m:vishal.l.verma@intel.com,m:ira.weiny@intel.com,m:dan.j.williams@intel.com,m:longman@redhat.com,m:akpm@linux-foundation.org,m:lorenzo.stoakes@oracle.com,m:Liam.Howlett@oracle.com,m:vbabka@suse.cz,m:rppt@kernel.org,m:surenb@google.com,m:mhocko@suse.com,m:osalvador@suse.de,m:ziy@nvidia.com,m:matthew.brost@intel.com,m:joshua.hahnjy@gmail.com,m:rakie.kim@sk.com,m:byungchul@sk.com,m:ying.huang@linux.alibaba.com,m:apopple@nvidia.com,m:axelrasmussen@google.com,m:yuanchu@google.com,m:weixugc@google.com,m:yury.norov@gmai
 l.com,m:linux@rasmusvillemoes.dk,m:mhiramat@kernel.org,m:mathieu.desnoyers@efficios.com,m:tj@kernel.org,m:hannes@cmpxchg.org,m:mkoutny@suse.com,m:jackmanb@google.com,m:sj@kernel.org,m:baolin.wang@linux.alibaba.com,m:npache@redhat.com,m:ryan.roberts@arm.com,m:dev.jain@arm.com,m:baohua@kernel.org,m:lance.yang@linux.dev,m:muchun.song@linux.dev,m:xu.xin16@zte.com.cn,m:chengming.zhou@linux.dev,m:jannh@google.com,m:linmiaohe@huawei.com,m:nao.horiguchi@gmail.com,m:pfalcato@suse.de,m:rientjes@google.com,m:shakeel.butt@linux.dev,m:riel@surriel.com,m:harry.yoo@oracle.com,m:cl@gentwo.org,m:roman.gushchin@linux.dev,m:chrisl@kernel.org,m:kasong@tencent.com,m:shikemeng@huaweicloud.com,m:nphamcs@gmail.com,m:bhe@redhat.com,m:zhengqi.arch@bytedance.com,m:terry.bowman@amd.com,m:willy@infradead.org,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[vbabka@kernel.org,cgroups@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCPT_COUNT_GT_50(0.00)[76];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vbabka@kernel.org,cgroups@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 607B06AF747

On 6/18/26 13:13, Gregory Price wrote:
> On Thu, Jun 18, 2026 at 10:21:30AM +0200, Vlastimil Babka (SUSE) wrote:
>> On 6/15/26 17:37, Gregory Price wrote:
>> > 
>> > One thought would be a way to switch what fallback list is used, and
>> > then have specific fallback lists for certain contexts.
>> > 
>> > Right now there is a single example of this: __GFP_THISNODE
>> >   |= __GFP_THISNODE   =>  NOFALLBACK
>> >   &= ~__GFP_THISNODE  =>  FALLBACK
>> > 
>> > We could add an interface with the desired fallback list based as an
>> > argument, and let get_page_from_freelist to prefer that over the default
>> > global lists.
>> 
>> Does it mean a new argument in a number of functions in the page allocator,
>> or can it be mapped to alloc_flags (at least internally?), because the
>> number of possible fallback lists is small enough?
>>
> 
> What I ended up with was adding a single page_alloc.c external interface
> that allows you define the zonelist via an enum, and then an internal
> selector resolution in prepare_alloc_pages() stored in alloc_context

OK. Since it's in alloc_context then there should be no parameter bloat
inside page allocator. And for the single external entry point it's better
to be explicit.

> 
> eg:
> 
> static inline bool prepare_alloc_pages(gfp_t gfp_mask, unsigned int order,
>                 int preferred_nid, nodemask_t *nodemask,
>                 struct alloc_context *ac, gfp_t *alloc_gfp,
>                 unsigned int *alloc_flags)
> {       
>         ac->highest_zoneidx = gfp_zone(gfp_mask);
>         ac->zonelist = select_zonelist(preferred_nid, gfp_mask, ac->zlsel);
> 	... snip ...
> }
> 
> struct folio *__folio_alloc_zonelist_noprof(gfp_t gfp, unsigned int order,
>                 int preferred_nid, nodemask_t *nodemask,
>                 enum alloc_zonelist zlsel);
> 
> 
> The original __folio_alloc* functions just add a DEFAULT - which tells
> select_zonelist() to base the decision on __GFP_THISNODE.
> 
> 
> struct folio *__folio_alloc_noprof(gfp_t gfp, unsigned int order, int preferred_nid,
>                 nodemask_t *nodemask)
> {
>         return __folio_alloc_core(gfp, order, preferred_nid, nodemask,
>                                   ALLOC_ZONELIST_DEFAULT);
> }
> EXPORT_SYMBOL(__folio_alloc_noprof);
> 
> 
> This does a few things
>   - The isolation is structural, there is no way to accidentally
>     allocate private memory without passing ALLOC_ZONELIST_PRIVATE
> 
>   - The isolation forces folios - there are no non-folio interfaces
>     which allow zonelist selection
> 
>   - The zonelist selection is confined to this allocation context,
>     so no inheritence is possible.
> 

Ack.

> 
> I tried to avoid using an ALLOC_ flag so we can avoid yet another flag
> crunch, but there certainly are few enough zonelists that we could
> encode it there and expose it.  I know Brendan was looking at plumbing
> alloc flags out to an interface, so i'm open to that.
> 
> Externally the way I determine what zonelist to use is a lookup based on
> reason - letting the node filter.  This is really only needed in a
> couple spots:
> 
> mm/khugepaged.c:  enum alloc_zonelist zlsel = alloc_zonelist_for_node(node, NODE_ALLOC_RECLAIM);
> mm/vmscan.c:      mtc->zlsel = alloc_zonelist_for_nodemask(mtc->nmask, NODE_ALLOC_TIERING);
> mm/migrate.c:     .zlsel = alloc_zonelist_for_node(node, NODE_ALLOC_USER_MIGRATE),
> 
> static inline enum alloc_zonelist
> alloc_zonelist_for_node(int nid, enum node_alloc_reason reason)
> {
>         bool ok;
> 
>         if (!node_state(nid, N_MEMORY_PRIVATE))
>                 return ALLOC_ZONELIST_DEFAULT;
>         switch (reason) {
>         case NODE_ALLOC_RECLAIM:
>                 ok = node_is_reclaimable(nid);
>                 break;
>         case NODE_ALLOC_TIERING:
>                 ok = node_allows_tiering(nid);
>                 break;
>         case NODE_ALLOC_USER_MIGRATE:
>                 ok = node_allows_user_migrate(nid);
>                 break;
>         default:
>                 ok = false;
>         }
>         return ok ? ALLOC_ZONELIST_PRIVATE : ALLOC_ZONELIST_DEFAULT;
> }
> 
> Otherwise... everything is now a mempolicy w/ MPOL_F_BIND and all the
> handling goes through the normal fault-paths :]
> 
> static struct page *__alloc_pages_mpol(gfp_t gfp, unsigned int order,
>                 struct mempolicy *pol, pgoff_t ilx, int nid)
> {
>         nodemask_t *nodemask;
>         struct page *page;
>         enum alloc_zonelist zlsel = (pol->flags & MPOL_F_PRIVATE) ?
>                 ALLOC_ZONELIST_PRIVATE : ALLOC_ZONELIST_DEFAULT;
> ...
>         if (pol->mode == MPOL_PREFERRED_MANY)
>                 return alloc_pages_preferred_many(gfp, order, nid, nodemask,
>                                                   zlsel);
> ...
> }
> 
> 
> Switching to an alloc_flag would probably be trivially if that's really
> wanted

I guess not. Thanks for the explanation!

> ~Gregory


