Return-Path: <cgroups+bounces-16968-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id aN9mLowOMGp1MgUAu9opvQ
	(envelope-from <cgroups+bounces-16968-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Mon, 15 Jun 2026 16:39:08 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5377E687403
	for <lists+cgroups@lfdr.de>; Mon, 15 Jun 2026 16:39:08 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b="Tpe1s7W/";
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-16968-lists+cgroups=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="cgroups+bounces-16968-lists+cgroups=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id D2526300EDA8
	for <lists+cgroups@lfdr.de>; Mon, 15 Jun 2026 14:39:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 343B53F8227;
	Mon, 15 Jun 2026 14:39:02 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF3DA2309AA;
	Mon, 15 Jun 2026 14:38:59 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781534341; cv=none; b=ESRpUJ38jGXLZTUKFQf2mgW0RKXStj5RKNQcjjUJLo4PvbdIHXxzKqVI89cDoDSFajmyYwHlOBJPKuR0ZOkvGtRkMLrAQXrYqPb/X3P4ZuIhhkvkxJyer7PxqRuty7HYwYW8RQtx9fGr+u92W57riJYWT0WzKeW+TrB1EBNK4IA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781534341; c=relaxed/simple;
	bh=2SyvoKljCiqDT7XAWLBQi18Nl5IGompSDj0xrvARkNU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jSIEsBjhmYvJeRQGFok6epv3WhCL2dPSKu3bmjvUOOFi/bFn5wcJRM8MFJwXAH2sFIycjSlHPRSXAYtTrb2gxxpkgyFCMTF20D2bN1Ts9Mi0DO+mw5exDyLvtZUtNVBywAgkwmaN8Ee4Q1wYiV2VJ/3MqNrUFzrHWFZxkCFeJtQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Tpe1s7W/; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE9FA1F000E9;
	Mon, 15 Jun 2026 14:38:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781534339;
	bh=NLJ1HyaUGHk9FC6sPoHgRQivjZ9rWHzGujDQIgijU0E=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=Tpe1s7W/FGNaFy4435tVtHAd9EY3oIvVA4mf4Fb3YDtRFfntZdHFaKKi4f9CCh34Q
	 N4xz+lIF98xwePPiI+ghawakdTdThDF5S3F8FV+xN0fCucATIu2Lx6YySlJwGbHNu+
	 2QBbGn2rIZUR9hjHSmq7MQJFg7R6sG3rczMZlJrTSWeubKk3zLT+pforXagFL+Ylvn
	 fpwfdemAo9uIZautm9dnwTWDKtjOgkD55tEAMcD9uHOTH9QQaMQFGigGXE9tDDkjfE
	 8O+X25HAcTiNhHhq8UDLz8uu0M0ZPrB8HafAzb9Z3yU7oGpTq13M0aCIUq+uHxmTAc
	 GX64SZo27dNAQ==
Message-ID: <9f1815b0-896b-44ab-9e6d-9316d8f11033@kernel.org>
Date: Mon, 15 Jun 2026 16:38:43 +0200
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
To: Gregory Price <gourry@gourry.net>,
 "David Hildenbrand (Arm)" <david@kernel.org>
Cc: Balbir Singh <balbirs@nvidia.com>, lsf-pc@lists.linux-foundation.org,
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
References: <ag6XyvxR-NU5rGn-@parvat>
 <ahOqzpzAua96HVkn@gourry-fedora-PF4VCD3F> <ah47NNhuiClgGCdn@parvat>
 <ah6bDNxlB1zBUnzN@gourry-fedora-PF4VCD3F> <ah-0CyZurn5D1ezY@parvat>
 <aik_ddHymus2DJ6D@gourry-fedora-PF4VCD3F>
 <c1b66e7a-bb95-4295-8193-55ceadaaa578@kernel.org>
 <aimSzvoJDrpeQsmM@gourry-fedora-PF4VCD3F>
 <d01fb1ed-2418-42ee-aea2-37f9a5c5729c@kernel.org>
 <ainFROZ3WrGioyuY@gourry-fedora-PF4VCD3F>
 <aiwl4kCG814dpX7L@gourry-fedora-PF4VCD3F>
From: "Vlastimil Babka (SUSE)" <vbabka@kernel.org>
Autocrypt: addr=vbabka@kernel.org; keydata=
 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
In-Reply-To: <aiwl4kCG814dpX7L@gourry-fedora-PF4VCD3F>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-16968-lists,cgroups=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_CC(0.00)[nvidia.com,lists.linux-foundation.org,vger.kernel.org,kvack.org,lists.linux.dev,meta.com,linuxfoundation.org,kernel.org,stgolabs.net,huawei.com,intel.com,redhat.com,linux-foundation.org,oracle.com,suse.cz,google.com,suse.com,suse.de,gmail.com,sk.com,linux.alibaba.com,rasmusvillemoes.dk,efficios.com,cmpxchg.org,arm.com,linux.dev,zte.com.cn,surriel.com,gentwo.org,tencent.com,huaweicloud.com,bytedance.com,amd.com,infradead.org];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,linuxfoundation.org:url,linux-foundation.org:email,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 5377E687403

On 6/12/26 17:29, Gregory Price wrote:
> On Wed, Jun 10, 2026 at 04:12:52PM -0400, Gregory Price wrote:
>> On Wed, Jun 10, 2026 at 08:59:59PM +0200, David Hildenbrand (Arm) wrote:
>> > > 
>> > > I understand this question in two ways:
>> > > 
>> > >   1) Can we disallow PAGE allocation and limit this to FOLIO allocation
>> > 
>> > Yes. Can we only allow folios to be allocated from private memory nodes. So let
>> > me reply to that one below.
>> > 
>> ... snip ...
>> > 
>> > At LSF/MM we talked about how GFP flags are bad and how deriving stuff from the
>> > context might be better. I think there was also talk about how the memalloc_*
>> > interface might be a better way forward. Maybe we would start giving the
>> > allocator more context ("we are allocating a folio").
>> > 
>> > The following is incomplete (esp. hugetlb stuff I assume), just as some idea:
>> >
>> 
>> I will still probably send the next RFC version tomorrow or friday,
>> as I want to get some eyes on the __GFP_PRIVATE-less pattern.
>> 
>> Also, I made a new `anondax` driver which enables userland testing
>> of this functionality without any specialty hardware.
>> 
> 
> (apologies for the length of this email: this will all be covered in
> the coming cover letter, but I just wanted to share a bit of a preview)
> 
> ===
> 
> Just another small update - I am planning to post the RFC today once i
> get some mild cleanup done.  It will be based on the dax atomic hotplug
> 
> https://lore.kernel.org/linux-mm/20260605211911.2160954-1-gourry@gourry.net/
> 
> But a couple specific details regarding the memalloc pieces that i've
> learned the past couple of days playing with it.
> 
> 1) memalloc_folio is required to ensure non-folio allocations don't land
>    on the private node, even if it happens within a memalloc_private
>    context.  Since memalloc_folio may be useful in contexts outside of
>    private nodes, I kept this as a separate flag.
> 
>    If we think there will *never* be additional users of memalloc_folio,
>    then we could fold _folio into _private to save the flag for now and
>    add it back when we actually need it.
> 
> 2) memalloc_private is needed to unlock private nodes, but in the
>    original NOFALLBACK-only design, you also needed __GFP_THISNODE.
> 
>    This is *highly* restrictive.  I found when playing with mbind that
>    MPOL_BIND + __GFP_THISNODE generates a WARN (valid WARN, it normally
>    implies a bug). 
> 
>    That leads me to #3

I think the memalloc approach is dangerous due to unexpected nesting. There
might be nested page allocations in page allocation itself (due to some
debugging option). But also interrupts do not change what "current" points
to. Suddenly those could start requesting folios and/or private nodes and be
surprised, I'm afraid.

The memalloc scopes only work well when they restrict the context wrt
reclaim, and allocations in IRQ have to be already restricted heavily
(atomic) so further memalloc restrictions don't do anything in practice. But
to make them change other aspects of the allocations like this won't work.

> 3) If a private node is opted into something like Demotion (the node is
>    a demotion target) or mbind(), such that normal kernel operation can
>    place memory there - it's *pseudo-private*, and should actually land
>    in it's own FALLBACK list (reachable without __GFP_THISNODE, but not
>    reachable as a normal fallback allocation target).
> 
> I'm still playing with this, but I think we can even omit the
> __GFP_THISNODE requirement (my initial feeling that __GFP_THISNODE
> didn't buy us anything in particular seems to have panned out).
> 
> At the end of the day, this makes the whole memalloc_private_save()
> pattern a heck of a lot cleaner than trying fiddle with GFP.
> 
> I think you will all enjoy how clean the code ends up, and how easily
> testable it is.
> 
> As a testbed I've implement an anondax (we can discuss naming) that
> adds some sample NODE_PRIVATE_OPT_* flags so you can do the following.
> 
> I'm including this in the next RFC - but we can hack the entire thing
> off (including the OPT flags) if we prefer to just get the base set in
> without a new driver as a start.
> 
> echo 1 > dax0.0/reclaim   # kswapd and reclaim run normally on this node
> echo 1 > dax0.0/demotion  # it is a demotion target
> echo 1 > dax0.0/mbind     # mbind() can target this node for anon-vma's
> echo 1 > dax0.0/madvise   # allow madvise() to operate on its folios
> echo 1 > dax0.0/numa_balance  # allow numa balancing for this node
> echo 1 > dax0.0/ltpin     # allow GUP longterm pin to operate normally
> echo * > dax0.0/adistance # set the adistance for hotplug time
> echo * > dax0.0/hotplug   # same as kmem/hotplug
> 
> This also means *existing hardware* can leverage private nodes if
> they're capable of generating a dax device.
> 
> I've even gotten it such that you can put a private node above dram in
> the adistance heirarchy - which means demotion flows downward from
> device to CPU, but allocations don't default or fallback there.
> 
> This seems *immediately* useful for a variety of use cases.
> 
> ~Gregory
> _______________________________________________
> Lsf-pc mailing list
> Lsf-pc@lists.linux-foundation.org
> https://lists.linuxfoundation.org/mailman/listinfo/lsf-pc


