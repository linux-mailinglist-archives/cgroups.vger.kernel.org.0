Return-Path: <cgroups+bounces-16998-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id axLhJoA6MWrveQUAu9opvQ
	(envelope-from <cgroups+bounces-16998-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Tue, 16 Jun 2026 13:58:56 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AA2268F06D
	for <lists+cgroups@lfdr.de>; Tue, 16 Jun 2026 13:58:55 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linux.dev header.s=key1 header.b=d19EmUrp;
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-16998-lists+cgroups=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="cgroups+bounces-16998-lists+cgroups=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linux.dev;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 7045A300611D
	for <lists+cgroups@lfdr.de>; Tue, 16 Jun 2026 11:58:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6F6643CEC2;
	Tue, 16 Jun 2026 11:58:14 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from out-182.mta0.migadu.com (out-182.mta0.migadu.com [91.218.175.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F09A53B7750;
	Tue, 16 Jun 2026 11:58:12 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781611094; cv=none; b=I0049QxSeBR/dMBAP6y47NYNegZqbo1w8uKRgGqY0euMW6BSthletAibhAiHdTjNDcysRBZIn7k+ffEDNUkjM3heSzKKHXy0N+IB3D/qHHKFKsOQEchJFAMW0X9aJpGqqW+hIr6qjWzKNDPQeOb2GRCugTqzBcZ2hfWQFU30WHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781611094; c=relaxed/simple;
	bh=CTi4G0hnEufO03WtfWriNSEeYzXA3FYOKUM0aKDFwyg=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=V1qJiNib1bbmIkQ+OjBPZvVtYYaTvzTXOAuO4aUo6nh/QqaVy2txORyRc3XkiiwHLlTQkbINNf0cMP6wZfhMqdreF6Lr25aAsL+9ZTo8l82EW3zjUqevTzuHENqYW6zqECUP4/AhmMIbgAHR0gf5XGmkGoANNCC97PNESN3sIWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=d19EmUrp; arc=none smtp.client-ip=91.218.175.182
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1781611079;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Cj0OqIIza8TZpzIi89NPwfYz5Lr8KtiNgulM6qKZaEc=;
	b=d19EmUrpyHfnY1cDkWr5Pgy+k+d7eFilIhNo+y4UIIjqndySCSOaazg/G8TshBKTyTYnND
	XCyUVJJyDOLK/bkGHAJuXNKw+fdkrix2cFn368PgpUQyupyTl+Ld5Z1eUzw/MhgsQEQYZO
	0Fwe6r3tB/j/kPtZNQWXjtsg7SB8wEw=
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 16 Jun 2026 11:57:42 +0000
Message-Id: <DJAGEUY8S09F.3V3HF570G85OF@linux.dev>
Cc: "Balbir Singh" <balbirs@nvidia.com>,
 <lsf-pc@lists.linux-foundation.org>, <linux-kernel@vger.kernel.org>,
 <linux-cxl@vger.kernel.org>, <cgroups@vger.kernel.org>,
 <linux-mm@kvack.org>, <linux-trace-kernel@vger.kernel.org>,
 <damon@lists.linux.dev>, <kernel-team@meta.com>,
 <gregkh@linuxfoundation.org>, <rafael@kernel.org>, <dakr@kernel.org>,
 <dave@stgolabs.net>, <jonathan.cameron@huawei.com>, <dave.jiang@intel.com>,
 <alison.schofield@intel.com>, <vishal.l.verma@intel.com>,
 <ira.weiny@intel.com>, <dan.j.williams@intel.com>, <longman@redhat.com>,
 <akpm@linux-foundation.org>, <lorenzo.stoakes@oracle.com>,
 <Liam.Howlett@oracle.com>, <vbabka@suse.cz>, <rppt@kernel.org>,
 <surenb@google.com>, <mhocko@suse.com>, <osalvador@suse.de>,
 <ziy@nvidia.com>, <matthew.brost@intel.com>, <joshua.hahnjy@gmail.com>,
 <rakie.kim@sk.com>, <byungchul@sk.com>, <ying.huang@linux.alibaba.com>,
 <apopple@nvidia.com>, <axelrasmussen@google.com>, <yuanchu@google.com>,
 <weixugc@google.com>, <yury.norov@gmail.com>, <linux@rasmusvillemoes.dk>,
 <mhiramat@kernel.org>, <mathieu.desnoyers@efficios.com>, <tj@kernel.org>,
 <hannes@cmpxchg.org>, <mkoutny@suse.com>, <jackmanb@google.com>,
 <sj@kernel.org>, <baolin.wang@linux.alibaba.com>, <npache@redhat.com>,
 <ryan.roberts@arm.com>, <dev.jain@arm.com>, <baohua@kernel.org>,
 <lance.yang@linux.dev>, <muchun.song@linux.dev>, <xu.xin16@zte.com.cn>,
 <chengming.zhou@linux.dev>, <jannh@google.com>, <linmiaohe@huawei.com>,
 <nao.horiguchi@gmail.com>, <pfalcato@suse.de>, <rientjes@google.com>,
 <shakeel.butt@linux.dev>, <riel@surriel.com>, <harry.yoo@oracle.com>,
 <cl@gentwo.org>, <roman.gushchin@linux.dev>, <chrisl@kernel.org>,
 <kasong@tencent.com>, <shikemeng@huaweicloud.com>, <nphamcs@gmail.com>,
 <bhe@redhat.com>, <zhengqi.arch@bytedance.com>, <terry.bowman@amd.com>,
 "Matthew Wilcox" <willy@infradead.org>
Subject: Re: [Lsf-pc] [LSF/MM/BPF TOPIC][RFC PATCH v4 00/27] Private Memory
 Nodes (w/ Compressed RAM)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "Brendan Jackman" <brendan.jackman@linux.dev>
To: "Vlastimil Babka (SUSE)" <vbabka@kernel.org>, "Gregory Price"
 <gourry@gourry.net>, "David Hildenbrand (Arm)" <david@kernel.org>
References: <ag6XyvxR-NU5rGn-@parvat>
 <ahOqzpzAua96HVkn@gourry-fedora-PF4VCD3F> <ah47NNhuiClgGCdn@parvat>
 <ah6bDNxlB1zBUnzN@gourry-fedora-PF4VCD3F> <ah-0CyZurn5D1ezY@parvat>
 <aik_ddHymus2DJ6D@gourry-fedora-PF4VCD3F>
 <c1b66e7a-bb95-4295-8193-55ceadaaa578@kernel.org>
 <aimSzvoJDrpeQsmM@gourry-fedora-PF4VCD3F>
 <d01fb1ed-2418-42ee-aea2-37f9a5c5729c@kernel.org>
 <ainFROZ3WrGioyuY@gourry-fedora-PF4VCD3F>
 <aiwl4kCG814dpX7L@gourry-fedora-PF4VCD3F>
 <9f1815b0-896b-44ab-9e6d-9316d8f11033@kernel.org>
In-Reply-To: <9f1815b0-896b-44ab-9e6d-9316d8f11033@kernel.org>
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	MV_CASE(0.50)[];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[3];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-16998-lists,cgroups=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[nvidia.com,lists.linux-foundation.org,vger.kernel.org,kvack.org,lists.linux.dev,meta.com,linuxfoundation.org,kernel.org,stgolabs.net,huawei.com,intel.com,redhat.com,linux-foundation.org,oracle.com,suse.cz,google.com,suse.com,suse.de,gmail.com,sk.com,linux.alibaba.com,rasmusvillemoes.dk,efficios.com,cmpxchg.org,arm.com,linux.dev,zte.com.cn,surriel.com,gentwo.org,tencent.com,huaweicloud.com,bytedance.com,amd.com,infradead.org];
	FORGED_RECIPIENTS(0.00)[m:balbirs@nvidia.com,m:lsf-pc@lists.linux-foundation.org,m:linux-kernel@vger.kernel.org,m:linux-cxl@vger.kernel.org,m:cgroups@vger.kernel.org,m:linux-mm@kvack.org,m:linux-trace-kernel@vger.kernel.org,m:damon@lists.linux.dev,m:kernel-team@meta.com,m:gregkh@linuxfoundation.org,m:rafael@kernel.org,m:dakr@kernel.org,m:dave@stgolabs.net,m:jonathan.cameron@huawei.com,m:dave.jiang@intel.com,m:alison.schofield@intel.com,m:vishal.l.verma@intel.com,m:ira.weiny@intel.com,m:dan.j.williams@intel.com,m:longman@redhat.com,m:akpm@linux-foundation.org,m:lorenzo.stoakes@oracle.com,m:Liam.Howlett@oracle.com,m:vbabka@suse.cz,m:rppt@kernel.org,m:surenb@google.com,m:mhocko@suse.com,m:osalvador@suse.de,m:ziy@nvidia.com,m:matthew.brost@intel.com,m:joshua.hahnjy@gmail.com,m:rakie.kim@sk.com,m:byungchul@sk.com,m:ying.huang@linux.alibaba.com,m:apopple@nvidia.com,m:axelrasmussen@google.com,m:yuanchu@google.com,m:weixugc@google.com,m:yury.norov@gmail.com,m:linux@rasmusvillemoes.dk,m:mhir
 amat@kernel.org,m:mathieu.desnoyers@efficios.com,m:tj@kernel.org,m:hannes@cmpxchg.org,m:mkoutny@suse.com,m:jackmanb@google.com,m:sj@kernel.org,m:baolin.wang@linux.alibaba.com,m:npache@redhat.com,m:ryan.roberts@arm.com,m:dev.jain@arm.com,m:baohua@kernel.org,m:lance.yang@linux.dev,m:muchun.song@linux.dev,m:xu.xin16@zte.com.cn,m:chengming.zhou@linux.dev,m:jannh@google.com,m:linmiaohe@huawei.com,m:nao.horiguchi@gmail.com,m:pfalcato@suse.de,m:rientjes@google.com,m:shakeel.butt@linux.dev,m:riel@surriel.com,m:harry.yoo@oracle.com,m:cl@gentwo.org,m:roman.gushchin@linux.dev,m:chrisl@kernel.org,m:kasong@tencent.com,m:shikemeng@huaweicloud.com,m:nphamcs@gmail.com,m:bhe@redhat.com,m:zhengqi.arch@bytedance.com,m:terry.bowman@amd.com,m:willy@infradead.org,m:vbabka@kernel.org,m:gourry@gourry.net,m:david@kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[brendan.jackman@linux.dev,cgroups@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCPT_COUNT_GT_50(0.00)[77];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[brendan.jackman@linux.dev,cgroups@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.dev:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[cgroups];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,vger.kernel.org:from_smtp,linux.dev:dkim,linux.dev:mid,linux.dev:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 7AA2268F06D

On Mon Jun 15, 2026 at 2:38 PM UTC, Vlastimil Babka (SUSE) wrote:
> On 6/12/26 17:29, Gregory Price wrote:
>> On Wed, Jun 10, 2026 at 04:12:52PM -0400, Gregory Price wrote:
>>> On Wed, Jun 10, 2026 at 08:59:59PM +0200, David Hildenbrand (Arm) wrote=
:
>>> > >=20
>>> > > I understand this question in two ways:
>>> > >=20
>>> > >   1) Can we disallow PAGE allocation and limit this to FOLIO alloca=
tion
>>> >=20
>>> > Yes. Can we only allow folios to be allocated from private memory nod=
es. So let
>>> > me reply to that one below.
>>> >=20
>>> ... snip ...
>>> >=20
>>> > At LSF/MM we talked about how GFP flags are bad and how deriving stuf=
f from the
>>> > context might be better. I think there was also talk about how the me=
malloc_*
>>> > interface might be a better way forward. Maybe we would start giving =
the
>>> > allocator more context ("we are allocating a folio").
>>> >=20
>>> > The following is incomplete (esp. hugetlb stuff I assume), just as so=
me idea:
>>> >
>>>=20
>>> I will still probably send the next RFC version tomorrow or friday,
>>> as I want to get some eyes on the __GFP_PRIVATE-less pattern.
>>>=20
>>> Also, I made a new `anondax` driver which enables userland testing
>>> of this functionality without any specialty hardware.
>>>=20
>>=20
>> (apologies for the length of this email: this will all be covered in
>> the coming cover letter, but I just wanted to share a bit of a preview)
>>=20
>> =3D=3D=3D
>>=20
>> Just another small update - I am planning to post the RFC today once i
>> get some mild cleanup done.  It will be based on the dax atomic hotplug
>>=20
>> https://lore.kernel.org/linux-mm/20260605211911.2160954-1-gourry@gourry.=
net/
>>=20
>> But a couple specific details regarding the memalloc pieces that i've
>> learned the past couple of days playing with it.
>>=20
>> 1) memalloc_folio is required to ensure non-folio allocations don't land
>>    on the private node, even if it happens within a memalloc_private
>>    context.  Since memalloc_folio may be useful in contexts outside of
>>    private nodes, I kept this as a separate flag.
>>=20
>>    If we think there will *never* be additional users of memalloc_folio,
>>    then we could fold _folio into _private to save the flag for now and
>>    add it back when we actually need it.
>>=20
>> 2) memalloc_private is needed to unlock private nodes, but in the
>>    original NOFALLBACK-only design, you also needed __GFP_THISNODE.
>>=20
>>    This is *highly* restrictive.  I found when playing with mbind that
>>    MPOL_BIND + __GFP_THISNODE generates a WARN (valid WARN, it normally
>>    implies a bug).=20
>>=20
>>    That leads me to #3
>
> I think the memalloc approach is dangerous due to unexpected nesting. The=
re
> might be nested page allocations in page allocation itself (due to some
> debugging option). But also interrupts do not change what "current" point=
s
> to. Suddenly those could start requesting folios and/or private nodes and=
 be
> surprised, I'm afraid.

Minor side-note: couldn't we just define it such that the allocator
ignores the context when not in_task() (and warn if you try to enter the
context while not currently in_task())?

(Don't think this would change the conclusion very much, e.g. doesn't
help with the nesting issues. Mostly curious in case I'm missing a
detail here).

> The memalloc scopes only work well when they restrict the context wrt
> reclaim, and allocations in IRQ have to be already restricted heavily
> (atomic) so further memalloc restrictions don't do anything in practice. =
But
> to make them change other aspects of the allocations like this won't work=
.

