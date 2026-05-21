Return-Path: <cgroups+bounces-16143-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iFtxADiADmqp/AUAu9opvQ
	(envelope-from <cgroups+bounces-16143-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Thu, 21 May 2026 05:47:04 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 547F859E8BB
	for <lists+cgroups@lfdr.de>; Thu, 21 May 2026 05:47:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 74C07301A720
	for <lists+cgroups@lfdr.de>; Thu, 21 May 2026 03:46:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A33B92D5937;
	Thu, 21 May 2026 03:46:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B4g4Mxuu"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com [209.85.210.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03FFE16DC28
	for <cgroups@vger.kernel.org>; Thu, 21 May 2026 03:46:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779335169; cv=none; b=DzQ0BZRpKT+VkyUetVYH1cORVr/LEPYQrbwQPp1T6nDOrNO5/ZUnrwwGyxBxIM2b0NxDJHMA2H8wPEPnbzhZJqDr6bRfyr2n2unAluaSL4mXiQUNj/vyCNzgZPzjOPTySu0AX+/yQV9NWXkzSRmtBRCJj/5Mw52M0mqyp7hYVH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779335169; c=relaxed/simple;
	bh=bopuXWm9olVJHXpLu1DG1Qyl7MHDKEjinXkMh4Vre9g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nyK2KtPm+1zHw8cuHGLdtp2y5KARbps3YRkXi/3LIwGNC39r1OBKinpv/2DqwtXGhqjoAEDN65yCVypxwkOyGASETDQCgFdN34n0vbdoMbNPB2RuOjxopH1G51LVwh7XpfuxCzHREUac+sfVHb4K3Q+ULrQrckxgf2mQamOyUlo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B4g4Mxuu; arc=none smtp.client-ip=209.85.210.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f42.google.com with SMTP id 46e09a7af769-7dcdd1b492eso5709845a34.1
        for <cgroups@vger.kernel.org>; Wed, 20 May 2026 20:46:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779335167; x=1779939967; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zEBQggBlYt3BpKFY9Kg3q0PYXokZZ4ieOXENn/+MaCo=;
        b=B4g4Mxuuk5NY6oQG5OPetJ7rN985SsEfZSaMmagjS2eGXzN9Q2jtot1vGbUTR/OLnM
         A5PmHm4rCxFoOXRGuhTNwDeUT7nebohWLAdV1zPhKF0Y20t7ZLZS8z2P/SOhoYLchoQE
         INCcOmbT6D7zie9ukmxkCwH8wN2MeUO9OmXz/6xZwLMOBkLmpCeek8aH0Da6n1YfxkTQ
         45VV7wguGHzRXIzs96EZM1tWP3SFo2ORhgfpb/Cmkjn8E7wcyuOHccnGjr964sIaSxf3
         BtaM7YkiM5L85xYOFkFDbwdAjQKQBAnzBL+bbRwawI1cRUvDY1D+0g3QAeO5J616FUXp
         Qz7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779335167; x=1779939967;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=zEBQggBlYt3BpKFY9Kg3q0PYXokZZ4ieOXENn/+MaCo=;
        b=aGakGE0wPkRhs6eba1Wov2hyqThTT0znfM4fldCj9JaocEpzxyiJy1eu/0qFCa/d0q
         0RLeuPuqv6cbEKvkrov0YAIsvJA7I/OtMaEgO5/pmM1ddvycWyx6Nm4XD8kY9F3riTYA
         /Xp1BmKIs62ZW6XDjlx2oarmYGpnQ7g0dDeSU/HNNKw9P18v4gUmggDOe3xYlVwMJmyO
         ZM3Nfwy6VSmlRyM+qhJFq/f9xQD9hNt9Ug2PO84z+HflKXMvh4Jh7CJHTTOa6tkABVu6
         3dQNmkoPTeGdJ9V8WpS2agpFeGK6WsDd0kO5nxwjCI8btpuspoBED0L0iMLArN3LoYi/
         7WnQ==
X-Forwarded-Encrypted: i=1; AFNElJ9rrrfaR2KseczITof/KNM9EsuNAl3LX+lctllOKdcomqLVTTTizgacgdw61S3HrnYGjMgUrMRH@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2gR//ellRCEatyDP09sOSHsA287P5IGhR2E4zNW7d3G4ITJe8
	t3Ht1VqvjQ1aKG5F28RIw3eox79osAA+LJQcHHMv1mB117vvgQ79KS6p
X-Gm-Gg: Acq92OH1+PXJmqj1SGi/lxcXk/DYnZ69K1Se9lm+lIi5CrISz9tDGwWTM1EkEfVnJjW
	c4tVOgkquTGhQOPMxbjmX5yojs54q+6ZI+ab2KN9aEM4WTBV9mXBnoPJiqKUZ2bH0OQeoyKKS63
	3h3njNqGxpeyDMYniaANSdtgBhcWtaWtqvHNBIfTpC3rVyoM0D03UehRvPZCQo4O5eGdozeDQgb
	Y2ad/c/LJyb6uLw/jpXjtusR6eoXiYMk9GRfGh9l/LCU61jfiymkyUacnCtPRuss9Yhbz033MB0
	Vy0duaUOHldKTTx3Uhka0DyZOQ+3S0ZZvCnbwrhynDF1Mo2xShO7WnFyecRgkxb9YPuwCggn6ie
	gyuBdeyjuSP3IASTu7mH8faCK/Jg51J3+XZ7buId2yiV/wBhGp6H94C9wxcwQ3W4cjIqBhoMZVL
	SEKvmMukrHQaGlezcgcdP/NOqm5cF6sJSml4bIK+4FEkGXgO4j/o38GQ==
X-Received: by 2002:a05:6830:18fa:b0:7dc:e059:c25d with SMTP id 46e09a7af769-7e5ea0e7ddcmr512971a34.0.1779335166967;
        Wed, 20 May 2026 20:46:06 -0700 (PDT)
Received: from localhost ([2a03:2880:10ff:58::])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7e55bc4749esm14591959a34.23.2026.05.20.20.46.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 May 2026 20:46:06 -0700 (PDT)
From: Joshua Hahn <joshua.hahnjy@gmail.com>
To: Alexandre Ghiti <alex@ghiti.fr>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Michal Hocko <mhocko@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Muchun Song <muchun.song@linux.dev>,
	Dennis Zhou <dennis@kernel.org>,
	Tejun Heo <tj@kernel.org>,
	Christoph Lameter <cl@gentwo.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	Yosry Ahmed <yosry@kernel.org>,
	Nhat Pham <nphamcs@gmail.com>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Chengming Zhou <chengming.zhou@linux.dev>,
	Suren Baghdasaryan <surenb@google.com>,
	Qi Zheng <qi.zheng@linux.dev>,
	David Hildenbrand <david@kernel.org>,
	Lorenzo Stoakes <ljs@kernel.org>,
	Minchan Kim <minchan@kernel.org>,
	Mike Rapoport <rppt@kernel.org>,
	Axel Rasmussen <axelrasmussen@google.com>,
	Barry Song <baohua@kernel.org>,
	Kairui Song <kasong@tencent.com>,
	Wei Xu <weixugc@google.com>,
	Yuanchu Xie <yuanchu@google.com>,
	"Liam R . Howlett" <Liam.Howlett@oracle.com>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	cgroups@vger.kernel.org
Subject: Re: [PATCH 0/8] per-memcg-per-node kmem accounting
Date: Wed, 20 May 2026 20:46:03 -0700
Message-ID: <20260521034604.4126295-1-joshua.hahnjy@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <7e28d0c9-80f2-420b-87c4-55e571071059@ghiti.fr>
References: 
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[linux-foundation.org,kernel.org,linux.dev,gentwo.org,gmail.com,chromium.org,google.com,tencent.com,oracle.com,kvack.org,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-16143-lists,cgroups=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[29];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[joshuahahnjy@gmail.com,cgroups@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[cgroups];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 547F859E8BB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, 20 May 2026 10:39:59 +0200 Alexandre Ghiti <alex@ghiti.fr> wrote:

> Hi Joshua,
> 
> On 5/18/26 16:57, Joshua Hahn wrote:
> > On Mon, 11 May 2026 22:20:35 +0200 Alexandre Ghiti <alex@ghiti.fr> wrote:
> >
> >> This series pursues the work initiated by Joshua [1]. We need kernel
> >> memory to be accounted on a per-node basis in order to be able to
> >> know the memcg and physical memory association.
> >>    
> >> This series takes advantage of the recent introduction of per-node
> >> obj_cgroup [2] and makes those obj_cgroup tied to their numa node.
> >>    
> >> The bulk of the series is percpu per-node accounting: percpu
> >> "precharges" the memcg before we know the actual location of the pages
> >> it uses, so charging and accounting had to be split. All other kmem
> >> users (slab, zswap, __memcg_kmem_charge_page) are straightforward
> >> conversions (zswap support is limited in this series because Joshua
> >> is working on it in parallel [3]).
> >>   
> >> Thanks Joshua for your early feedbacks!
> > Hello Alex,
> >
> > Thank you for your work!
> >
> > Overall I think the direction makes sense to me. Pre-overcharging makes sense to
> > me as an approach, we would much rather overaccount than underaccount and
> > later have to breach limits.
> >
> > I do have some concerns on performance, though. Namely, I think there are
> > some expensive operations that I think would benefit from some performane
> > benchmarking with this patch added (maybe some simple microbenchmarks that
> > demonstrates kernel allocation overhead could be useful).
> >
> >  From what I can tell, there is some additional performance overhead that has
> > to do with iterating over num_possible_cpus() x pages_per_alloc, which
> > doesn't seem trivial to me.
> 
> Indeed, let me microbenchmark the overhead on a large system.

Hi Alex,

That sounds great with me : -) Looking forward to the numbers!

> > Another concern that I see is the stock credit system. Maybe we could be
> > bypassing the stock check leading to more time spent doing the atomic
> > operations.
> 
> I'm not following on this one, which atomic operations do you see that 
> could be bypassed?

So in my initial scan of the patch 7 I had a concern that if we have a nested
stock system (obj_cgroup stock and local credit "stock"), then we could
incur more work if these are out of sync; do extra work in the stock refill
path in obj_cgroup_precharge, and then do extra work on top in the loop
within the pcpu_memcg_post_alloc_hook (obj_cgroup_account_kmem does the
charging atomically I think).

So what I mean is, I'm not sure what the "size" is typically for
pcpu_memcg_post_alloc_hook. But it might be a worthwhile optimization to
do precharge all the pages, then for each cpu iterate over the pages to
figure out how many pages are used per nid (doing just math, not actually
doing the atomic adds), and then outside both of these loops just iterate
over every nid_objcg once to perform the atomic operation.

Maybe this is needed or not (depending on how big "size" typically is
and whether we go from doing O(1000) atomic adds --> O(10) or some
big reduction, but I just wanted to toss it out there as something that
could potentially be expensive.

> > obj_stock caches a single obj_cgroup, which means that if we split the objcg
> > to be per-node (in patch 6), then the obj_stock basically gets invalidated
> > every operation since we iterate over more objcgs (even though we are in
> > the same logical objcg). Maybe I'm missing something?
> 
> 
> The objcg split comes from commit 01b9da291c49 ("mm: memcontrol: convert 
> objcg to be per-memcg per-node type") and the problem you describe is 
> exactly what Shakeel is trying to fix [1].

Whoops O_o I completely missed that one. Sorry for flagging it again!

> But I remember trying a microbenchmark and noticed a +5% regression (on 
> top of the 67% then...), I'll rebase this series on top of Shakeel's and 
> re-run.

Sounds like a great idea! Thanks again Alex, have a great day! : -)
Joshua

