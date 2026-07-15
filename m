Return-Path: <cgroups+bounces-17859-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id BfaxC/GPV2qBXAAAu9opvQ
	(envelope-from <cgroups+bounces-17859-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Wed, 15 Jul 2026 15:49:37 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id A71B175EF9E
	for <lists+cgroups@lfdr.de>; Wed, 15 Jul 2026 15:49:36 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linux.dev header.s=key1 header.b=M48vlwPc;
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-17859-lists+cgroups=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="cgroups+bounces-17859-lists+cgroups=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linux.dev;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4639630219A9
	for <lists+cgroups@lfdr.de>; Wed, 15 Jul 2026 13:48:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58F533043CE;
	Wed, 15 Jul 2026 13:48:49 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from out-184.mta0.migadu.com (out-184.mta0.migadu.com [91.218.175.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22FE2311969
	for <cgroups@vger.kernel.org>; Wed, 15 Jul 2026 13:48:45 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784123329; cv=none; b=pZ+4C0mAbP083rCnQ3s4LWUuFWEoRokIjPDYfU8JWq45pGA1hI0dzvqpyc3RgO6DCfVIGNfnEpJvjPuLHYlwIMuZWhgdialj/8jGy9lsHRqQVSZXqUiFle8eP96rCdE46ZhrTQDSwN1VrCS/PxVdoVO3SKqe2Eo7fK0k7VG1/h4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784123329; c=relaxed/simple;
	bh=umcLJCYTBtFPXJLtsE4FFgR8/N0hBn5eZpm9VW9J9Yg=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:From:To:Cc:
	 References:In-Reply-To; b=AQ9FdLDUO06jtVdHT80E4T9jgggBYkwOZGdgCftmDm+q+VInZpydc1ORu1KQt3cjb5w7JierB5JijgMnegfKzRGnpXDnjctrajY5mmLPNQbYN5kU8jvnRvz8+aef7alvYTrfagiK3ipsdO/BYLoPyO9FOspDniPRTVnQ4rLkQd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=M48vlwPc; arc=none smtp.client-ip=91.218.175.184
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1784123313;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UaowcxsEzNicEwV4Y0Sxvqio5A4MwiyG/h+HfRwv7JI=;
	b=M48vlwPcCewdYQqUp+SIFZY+lTwvLyqR4yw4SgCaQgqpM0KAPEI4pmr368jIllLjcp8cWc
	FbkD4ifKhLMxmbkn12KXP4zaUlfxWxEnUs73zv+zQ3dm37ciQAbmurSo/270yR1ZHTzoFN
	Yh31eGDAT+hYMUb0xQaVD0ZPffYk3bQ=
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 15 Jul 2026 13:48:28 +0000
Message-Id: <DJZ6XH7C3377.1D6EIFUEK2656@linux.dev>
Subject: Re: [PATCH v3 4/4] mm/page_alloc: remove a couple of VM_BUG_ON()st
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "Brendan Jackman" <brendan.jackman@linux.dev>
To: "Vlastimil Babka (SUSE)" <vbabka@kernel.org>, "Brendan Jackman"
 <jackmanb@google.com>, "Andrew Morton" <akpm@linux-foundation.org>, "Suren
 Baghdasaryan" <surenb@google.com>, "Michal Hocko" <mhocko@suse.com>,
 "Johannes Weiner" <hannes@cmpxchg.org>, "Zi Yan" <ziy@nvidia.com>,
 "Sebastian Andrzej Siewior" <bigeasy@linutronix.de>, "Clark Williams"
 <clrkwllms@kernel.org>, "Steven Rostedt" <rostedt@goodmis.org>, "Waiman
 Long" <longman@redhat.com>, "Ridong Chen" <ridong.chen@linux.dev>, "Tejun
 Heo" <tj@kernel.org>, =?utf-8?q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>,
 "David Hildenbrand" <david@kernel.org>, "Lorenzo Stoakes" <ljs@kernel.org>,
 "Liam R. Howlett" <liam@infradead.org>, "Mike Rapoport" <rppt@kernel.org>
Cc: <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
 <cgroups@vger.kernel.org>, <linux-rt-devel@lists.linux.dev>
References: <20260715-spin-trylock-followup-v3-0-fc4d246f705d@google.com>
 <20260715-spin-trylock-followup-v3-4-fc4d246f705d@google.com>
 <ed4572f4-0074-45c5-993d-7b6533eddc31@kernel.org>
In-Reply-To: <ed4572f4-0074-45c5-993d-7b6533eddc31@kernel.org>
X-Migadu-Flow: FLOW_OUT
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	MV_CASE(0.50)[];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[22];
	RCVD_TLS_LAST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER(0.00)[brendan.jackman@linux.dev,cgroups@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:vbabka@kernel.org,m:jackmanb@google.com,m:akpm@linux-foundation.org,m:surenb@google.com,m:mhocko@suse.com,m:hannes@cmpxchg.org,m:ziy@nvidia.com,m:bigeasy@linutronix.de,m:clrkwllms@kernel.org,m:rostedt@goodmis.org,m:longman@redhat.com,m:ridong.chen@linux.dev,m:tj@kernel.org,m:mkoutny@suse.com,m:david@kernel.org,m:ljs@kernel.org,m:liam@infradead.org,m:rppt@kernel.org,m:linux-mm@kvack.org,m:linux-kernel@vger.kernel.org,m:cgroups@vger.kernel.org,m:linux-rt-devel@lists.linux.dev,s:lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-17859-lists,cgroups=lfdr.de];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[brendan.jackman@linux.dev,cgroups@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.dev:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,vger.kernel.org:from_smtp,linux.dev:dkim,linux.dev:mid,linux.dev:from_mime,nvidia.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: A71B175EF9E
X-Rspamd-Action: no action

On Wed Jul 15, 2026 at 1:25 PM UTC, Vlastimil Babka (SUSE) wrote:
> Subject has stray 't' at the end?

Thanks - will fix if we do a v3 (otherwise Andrew, please can you amend
when you apply it?)

> On 7/15/26 13:03, Brendan Jackman wrote:
>> VM_BUG_ON() is out of favour and on the way to removal, since I recently
>> touched alloc_pages_node_noprof() I am removing that invocation, and
>> also removing the __folio_alloc_node_noprof() one for consistency. If
>> this precondition is violated, the system will soon crash anyway.
>>=20
>> Suggested-by: Zi Yan <ziy@nvidia.com>
>> Link: https://lore.kernel.org/all/7F866265-3F2E-4765-B9D4-9AB898A9C4AC@n=
vidia.com/
>> Acked-by: Zi Yan <ziy@nvidia.com>
>> Signed-off-by: Brendan Jackman <jackmanb@google.com>
>
> Reviewed-by: Vlastimil Babka (SUSE) <vbabka@kernel.org>
>
>> ---
>>  include/linux/gfp.h | 1 -
>>  mm/page_alloc.c     | 1 -
>>  2 files changed, 2 deletions(-)
>>=20
>> diff --git a/include/linux/gfp.h b/include/linux/gfp.h
>> index 4d57e9c0bf204..872bc53f32ec8 100644
>> --- a/include/linux/gfp.h
>> +++ b/include/linux/gfp.h
>> @@ -255,7 +255,6 @@ static inline void warn_if_node_offline(int this_nod=
e, gfp_t gfp_mask)
>>  static inline
>>  struct folio *__folio_alloc_node_noprof(gfp_t gfp, unsigned int order, =
int nid)
>>  {
>> -	VM_BUG_ON(nid < 0 || nid >=3D MAX_NUMNODES);
>>  	warn_if_node_offline(nid, gfp);
>> =20
>>  	return __folio_alloc_noprof(gfp, order, nid, NULL);
>
> Well if you want more cleanups, I can see in iommu_alloc_pages_node_sz():
>
>
>         /*
>          * __folio_alloc_node() does not handle NUMA_NO_NODE like
>          * alloc_pages_node() did.
>          */
>         if (nid =3D=3D NUMA_NO_NODE)
>                 nid =3D numa_mem_id();
>
>         folio =3D __folio_alloc_node(gfp | __GFP_ZERO, order, nid);
>
> Should we introduce folio_alloc_node() and make __folio_alloc_node()
> mm-internal, for consistency?

Ha, I literally just wrote that patch. I'm planning to do it as yet
another series as there's a little dance needed to get it all into
shape. But, also happy to just expand this one if you prefer.

Then I'm gonna add alloc_flags to the __ variant so filemap.c can set
ALLOC_UNMAPPED for AS_NO_DIRECT_MAP.

