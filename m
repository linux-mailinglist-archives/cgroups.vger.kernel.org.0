Return-Path: <cgroups+bounces-14756-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IH1sBfodsWmOqwIAu9opvQ
	(envelope-from <cgroups+bounces-14756-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Wed, 11 Mar 2026 08:47:06 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B534925E297
	for <lists+cgroups@lfdr.de>; Wed, 11 Mar 2026 08:47:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7AC89325E52C
	for <lists+cgroups@lfdr.de>; Wed, 11 Mar 2026 07:38:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3458F3B2FE2;
	Wed, 11 Mar 2026 07:38:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ap2sqBiO"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64EB13B0ACA;
	Wed, 11 Mar 2026 07:38:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773214711; cv=none; b=duNGdmPjxoGMVWd54EKqoGLllwBT7uMDHHvZMHlarkm/uHBF4BPW4iZ6DO0RxLg9rMJtiaxgkAKJXT25vE1m7zLtj1P9DgM+ykJLIEbTt3oIzawuiDCrWpBLLhKEbhQQeaboD29ayQUyWuKGWRzOGNXJFl2WYP4Q52Rkj42pyB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773214711; c=relaxed/simple;
	bh=YwwQxlaXwMMbqagxRfolcXWYqSrMPA5QKuGMRbcPECo=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=eKmo3v5CI/mb7oNrzvRv7DmUqe+215FhsAChcZbXok3+Esbg+Th96ySrIv/S5Hf6hdBuWUFVjqlpw6ehEHM818SXZPiBQPUdooxuG0Z7aziLvM7uA8LdncRa5eEqvJ2LWQ7yceszHUGOnK9Q4Sur+7rmZgQYmYLZ1j7GvwDRJiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ap2sqBiO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE298C4CEF7;
	Wed, 11 Mar 2026 07:38:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773214710;
	bh=YwwQxlaXwMMbqagxRfolcXWYqSrMPA5QKuGMRbcPECo=;
	h=Date:From:Subject:To:Cc:References:In-Reply-To:From;
	b=ap2sqBiOyzNEg5d9WoWmhZjrYXZKC7JT2oPedkW5M1KgX6ee0qONqMx2Dylwh9xRG
	 wWYD+NG4lLN8GsAC7SCUic669xXeIO/lo3u4OyQWc7zP73Pt9uxAQN8GJWbqAcrjoc
	 LQ59Q0Y0Hh47txaeYLCuvXLNyk/Bflt4G8HFMj8dpnfNZRWXPt1OF6FLbriAu7k1px
	 wN4cDDNb1Sw1JvfNfRDPiuvO85CSG2EEhQi9VaPccss3mXRD0/FbLkWZKSB/1SMLbo
	 i5ecanrLK0dblbNLrCwiwZGWhGA6FUwN1T1YMcSs86zqODxcjv3NbyX59VgsdfY4SU
	 v7i8ntllz1UNA==
Message-ID: <e7ccb3b0-791e-4e01-86c3-65b613e3cc5a@kernel.org>
Date: Wed, 11 Mar 2026 08:38:25 +0100
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: vbabka@kernel.org
Subject: Re: [PATCH 0/2] fix kmem over-charging for embedded obj_exts array
To: Hao Li <hao.li@linux.dev>, Harry Yoo <harry.yoo@oracle.com>
Cc: ranxiaokai627@163.com, hannes@cmpxchg.org, mhocko@kernel.org,
 roman.gushchin@linux.dev, shakeel.butt@linux.dev, muchun.song@linux.dev,
 akpm@linux-foundation.org, cl@gentwo.org, rientjes@google.com,
 cgroups@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 ran.xiaokai@zte.com.cn
References: <20260310113804.245647-1-ranxiaokai627@163.com>
 <abDPvjUld-2BTpRa@hyeyoo>
 <exe5r2q526ym5qcypup73yltv3jqnplwhybr3zwxgcs5vfgoin@t6yj2ntfs7jk>
Content-Language: en-US
In-Reply-To: <exe5r2q526ym5qcypup73yltv3jqnplwhybr3zwxgcs5vfgoin@t6yj2ntfs7jk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: B534925E297
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-14756-lists,cgroups=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[163.com,cmpxchg.org,kernel.org,linux.dev,linux-foundation.org,gentwo.org,google.com,vger.kernel.org,kvack.org,zte.com.cn];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[vbabka@kernel.org,cgroups@vger.kernel.org];
	FROM_NO_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.996];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[cgroups];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[zte.com.cn:email]
X-Rspamd-Action: no action

On 3/11/26 04:06, Hao Li wrote:
> On Wed, Mar 11, 2026 at 11:13:18AM +0900, Harry Yoo wrote:
>> On Tue, Mar 10, 2026 at 11:38:02AM +0000, ranxiaokai627@163.com wrote:
>> > From: Ran Xiaokai <ran.xiaokai@zte.com.cn>
>> > 
>> > Since commit a77d6d338685 ("mm/slab: place slabobj_ext metadata
>> > in unused space within s->size"), the struct slabobj_ext array can
>> > use slab leftover space or be embedded into the slub object to save
>> > memory. In these cases, no extra kmalloc space is allocated for the
>> > obj_exts array.
>> > 
>> > However, obj_full_size() always returns extra sizeof(struct obj_cgroup *)
>> > bytes for every object, which leads to over-charging for slabs with
>> > embedded obj_exts.
>> > 
>> > This series optimizes obj_full_size() to check whether obj_exts uses
>> > slab leftover space or is embedded in the object. If so, only the object
>> > size is charged. Otherwise, the extra obj_cgroup pointer space is also
>> > charged.
>> 
>> Hi Ran,
>> 
>> At first look, I'm not sure if it's a good idea - although it's
>> allocated from wasted space, it's still memory that's needed to
>> charge objects.
> 
> Yes, I've been thinking about this as well.
> 
> For slabobj_ext that lives at the end of the whole slab, it seems reasonable to
> charge it to the cgroup.
> 
>> 
>> But for "embedded into the slub object" case, yeah,
>> the metadata is charged twice, as it's already included in s->size.
> 
> While reading patch 2, I was also thinking about whether it would make sense to
> call obj_exts_in_slab() on every object allocation and free for this case...
> 
> I wonder if we could use objext_flags to carry a bit of information about where
> slabobj_ext is located.

Uh maybe let's not complicate it and just drop obj_full_size() altogether
and just charge s->size? Just accept that allocating slab objects has some
overhead, we're not accounting all of it fully anyway. It shouldn't cause a
big difference in practice.

