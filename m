Return-Path: <cgroups+bounces-15114-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wOwUEUPDymmL/wUAu9opvQ
	(envelope-from <cgroups+bounces-15114-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Mon, 30 Mar 2026 20:38:59 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9952D35FCEB
	for <lists+cgroups@lfdr.de>; Mon, 30 Mar 2026 20:38:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B6BF23015CB0
	for <lists+cgroups@lfdr.de>; Mon, 30 Mar 2026 18:35:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0878237E2FE;
	Mon, 30 Mar 2026 18:35:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O94QhzLl"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEBCC393DD8
	for <cgroups@vger.kernel.org>; Mon, 30 Mar 2026 18:35:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774895751; cv=none; b=LjtelTyXbXWrhzAkgu349dXCErs2JDBASQnkH2OAy+/3xOrKML83kEslGdMcUpeYr4xdZxsjz8GBycYJzHjTYEwjaQuAOoV9sLyjhv7gRsByaC5ud+z0Gc4ZdZ3Tcc/PH2ZrkV3f4tqZ3sjhSkA04qTLlPEJdbqp+5x+B7DAZPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774895751; c=relaxed/simple;
	bh=ESqM96XkNcuOPEIpQKNFAlZgKh2C3ssPxIkldyFAy9Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=omyugNrYMKCnvren2kIAsKCj29qxAYyt+KQ8v/KndALzgTf8R9/2N5YBW6CXQhOb6MCJdGZRCTPeV/3cOXIQKGlAmWpXUHVqiHJSIQVTGZ6zBXvFuTr35nm+sOD0gqhB+BIvb9ZqJPb3k5MmIs2bkmQcUv9zFzqNeAQ2CnwnEZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O94QhzLl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75D21C2BCB9
	for <cgroups@vger.kernel.org>; Mon, 30 Mar 2026 18:35:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774895751;
	bh=ESqM96XkNcuOPEIpQKNFAlZgKh2C3ssPxIkldyFAy9Q=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=O94QhzLlNazi/AlIoMclKwT0f5THTKxeP8igZtqxnPUgj+uYi9DYtZ/OYvVtWBYYf
	 DX6BRDgaEv/p69Hw6H0Xm5vxxzr+Pif/QiFZ/h/efTGJ53tOUSuZRAkiRe9/R+jCwq
	 ULMcjgOWcY9ljN3Fcmclys5kOql0l2zpuPyuzXSyhUl7I5muBplHcJLzWYlPg9IKOI
	 +awyFsaXhvgUgggz9se/zOqgQvDqCpKVBVB8vQAGH6QlXvmgr2LDAvOVU22HX4ThEJ
	 nfLDDDeA0FbSBchF1kFCexacRXHuOJUjGzuvDdTXXPtuIBdGBXpHEVcVi1VkDeQXmd
	 9kMiPoYB8edBQ==
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-b97a9f4b4dcso619616666b.3
        for <cgroups@vger.kernel.org>; Mon, 30 Mar 2026 11:35:51 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUU5CA2vnPyMRsZ9Xsju6QfOFe0pnlq+FMse4dPvz+mSR1z2W3rTBu0MMKikzVcnmaDdiPstUCV@vger.kernel.org
X-Gm-Message-State: AOJu0YwhnPFy/FrGir2n0F28MC3Vl2a+WD2G+QF6pEOeUq+A4elxVG/l
	Dz7eke4NW07blwbLPjkjfgZ8e9gNfsBqstK+pJCSLngB+QhQeKCg+LMUHq4AX1r1XAzDM2MK+96
	xRu/2/tns6t8r8ugxb/j7gcTdKa21Es8=
X-Received: by 2002:a17:907:2d9f:b0:b88:5158:d10e with SMTP id
 a640c23a62f3a-b9b503a35femr907996166b.21.1774895750115; Mon, 30 Mar 2026
 11:35:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <acpmkY6_gWLdtJCB@tiehlicka> <20260330141010.3126996-1-joshua.hahnjy@gmail.com>
 <acqG2Mr5ekCn2HD0@tiehlicka>
In-Reply-To: <acqG2Mr5ekCn2HD0@tiehlicka>
From: Yosry Ahmed <yosry@kernel.org>
Date: Mon, 30 Mar 2026 11:35:38 -0700
X-Gmail-Original-Message-ID: <CAO9r8zOKaPocJYMKL=A=6=qpWgwCa=fMC8EZsSW+632M1q1sZg@mail.gmail.com>
X-Gm-Features: AQROBzBaAzAm2Me2kzCfvKE8aHVz1Ho01z18mV6apSHtbDPcXk8PmR1kLhDbgJs
Message-ID: <CAO9r8zOKaPocJYMKL=A=6=qpWgwCa=fMC8EZsSW+632M1q1sZg@mail.gmail.com>
Subject: Re: [PATCH] mm/percpu, memcontrol: Per-memcg-lruvec percpu accounting
To: Michal Hocko <mhocko@suse.com>
Cc: Joshua Hahn <joshua.hahnjy@gmail.com>, Johannes Weiner <hannes@cmpxchg.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Shakeel Butt <shakeel.butt@linux.dev>, Muchun Song <muchun.song@linux.dev>, 
	David Hildenbrand <david@kernel.org>, Lorenzo Stoakes <ljs@kernel.org>, Vlastimil Babka <vbabka@kernel.org>, 
	Dennis Zhou <dennis@kernel.org>, Tejun Heo <tj@kernel.org>, Christoph Lameter <cl@gentwo.org>, 
	cgroups@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-15114-lists,cgroups=lfdr.de];
	FREEMAIL_CC(0.00)[gmail.com,cmpxchg.org,linux-foundation.org,linux.dev,kernel.org,gentwo.org,vger.kernel.org,kvack.org,meta.com];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[yosry@kernel.org,cgroups@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.987];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 9952D35FCEB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, Mar 30, 2026 at 7:21=E2=80=AFAM Michal Hocko <mhocko@suse.com> wrot=
e:
>
> On Mon 30-03-26 07:10:10, Joshua Hahn wrote:
> > On Mon, 30 Mar 2026 14:03:29 +0200 Michal Hocko <mhocko@suse.com> wrote=
:
> >
> > > On Fri 27-03-26 12:19:35, Joshua Hahn wrote:
> > > > Convert MEMCG_PERCPU_B from a memcg_stat_item to a memcg_node_stat_=
item
> > > > to give visibility into per-node breakdowns for percpu allocations =
and
> > > > turn it into NR_PERCPU_B.
> > >
> > > Why do we need/want this?
> >
> > Hello Michal,
> >
> > Thank you for reviewing my patch! I hope you are doing well.
> >
> > You're right, I could have done a better job of motivating the patch.
> > My intent with this patch is to give some more visibility into where
> > memory is physically, once you know which memcg it is in.
>
> Please keep in mind that WHY is very often much more important than HOW
> in the patch so you should always start with the intention and
> justification.
>
> > Percpu memory could probably be seen as "trivial" when it comes to figu=
ring
> > out what node it is on, but I'm hoping to make similar transitions to t=
he
> > rest of enum memcg_stat_item as well (you can see my work for the zswap
> > stats in [1]).
> >
> > When all of the memory is moved from being tracked per-memcg to per-lru=
vec,
> > then the final vision would be able to attribute node placement within
> > each memcg, which can help with diagnosing things like asymmetric node
> > pressure within a memcg, which is currently only partially accurate.
> >
> > Getting per-node breakdowns of percpu memory orthogonal to memcgs also
> > seems like a win to me. While unlikely, I think that we can benefit fro=
m
> > some amount of visibility into whether percpu allocations are happening
> > equally across all CPUs.
> >
> > What do you think? Thank you again, I hope you have a great day!
>
> I think that you should have started with this intended outcome first
> rather than slicing it in pieces. Why do we want to shift to per-node
> stats for other/all counters? What is the cost associated comparing to th=
e
> existing accounting (if any)? Please go into details on how do you plan
> to use the data before we commit into a lot of code churn.
>
> TBH I do not see any fundamental reasons why this would be impossible
> but I am not really sure this is worth the work and I also do not see
> potential subtle issues that we might stumble over when getting there.
> So I would appreciate if you could have a look into that deeper and
> provide us with evaluation on how do you want to achieve your end goal
> and what can we expect on the way. It is, of course, impossible to see
> all potential problems without starting implementing the thing but a
> high level evaluation would be really helpful.

You should probably also speak to extra memory overhead to move all
these stats from per-memcg to per-lruvec.

