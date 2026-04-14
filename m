Return-Path: <cgroups+bounces-15284-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0EpoE4a03WkZiAkAu9opvQ
	(envelope-from <cgroups+bounces-15284-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Tue, 14 Apr 2026 05:29:10 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B496F3F542A
	for <lists+cgroups@lfdr.de>; Tue, 14 Apr 2026 05:29:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D798430470CD
	for <lists+cgroups@lfdr.de>; Tue, 14 Apr 2026 03:27:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B89732F1FE3;
	Tue, 14 Apr 2026 03:27:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZTMJuDx1"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12FAF2D3A69
	for <cgroups@vger.kernel.org>; Tue, 14 Apr 2026 03:27:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776137249; cv=pass; b=PZDMWpWcCiu5zEv6UKusjuFY33pfRTgJE6/8f7w31ICH+n7x8btFj39jwJoeTrUtLx+j39YgkQmUmOu5f2uGnG66N/NVeqhjX+bWvTfTyTkrxYp+vnva5C6kNl5Fw/8nruorXrukEzq7E/DFeyLJnupEQdhb+cyq6KxsFjZOFjg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776137249; c=relaxed/simple;
	bh=V4vxAkP59gN+SGiN4wu3EWxyT+DD3dx5sNcnwFfhnGA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=d1qeaz7eusBa6ZKIcYOoEzEB6RyXDm669wLEVWv5kz37Z7XpkwdJ36YyOpz8X39s5oDu7BTjx/8W0PsslKVkc5zC+iQFhLpUWaUhgKHD26vEbwgTsXRtjlqt8+zJObLHS003a6Ny3foJsVUucXDuflyAoZZRBjyxl87qwYw/tVk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZTMJuDx1; arc=pass smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-671c4d08dc2so609719a12.3
        for <cgroups@vger.kernel.org>; Mon, 13 Apr 2026 20:27:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776137246; cv=none;
        d=google.com; s=arc-20240605;
        b=Vdg7WiBb/Ell91QGN1C7gTebr3FCFBCi5pkUu8OYiSN4+1rOl5n667eolJ+j6h2uVC
         YHNc1dcWayz6Vt9V+nBtG/fmx1uAWZI+H6ChJWoUeLwz7LMrmVn+L8GgprCOQjBFkBB9
         LDBgWyYDMwGRdq3wG7DIGnlhB+TvLEQhh8BAdAC62h+YPyRTgwCchRguEtCDqcF0wZvm
         1cncWZpAD8rHtRxwshQauv3bYt834Nlenf+NFHoWycJG1PRBOuz7JCTv6vNCjRJB8OJe
         c+c2yQLNf2zG8mCeqN0W4XjSqUNTASJTI9P0Ohgsrq8hdMQ1nV/3Eot07BW945mu680b
         ZACQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=pOnRFYTB9oKY4AxXu1Op5pVF1RPrbIg8+CUKW94/JvQ=;
        fh=l1Ov4LYGkD8L005zQnqFPEXzVYTth6GwJV8ErKnnGtY=;
        b=To5jpG0gq8s1GaglUv0wuRaGZK5htFZqgtI21RXGw7B5IPbRWp6Ppp7u7tOXzt75on
         ZnnJEpRf54euGFhyJMylqh1uX7nawBkS7qoXuqww5eJjG7FGaqWo06qjCVLKW61IOMd9
         SgNTNp8tZbniWpkWThNcMGi17F3uLOvDNHfh3OOJN9LnqLqxcnHRSfxFuAtweVkEvBK8
         KeBwv73Jns6Z9Yg+VMtcIlNmP1d6ORHe7YZtLEIKn9hxJISXnr1u6ybZoIfBECIV8epY
         G9yW+H9gB16fmQDy7YDNpzRuM4ootP6S85Bv6dZvFbEBHSFfEOYUcb4JQtD6briYYiN+
         5B8Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776137246; x=1776742046; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pOnRFYTB9oKY4AxXu1Op5pVF1RPrbIg8+CUKW94/JvQ=;
        b=ZTMJuDx1uorvKQJQMGmu2idUx23V7n9NQ61MRoEJSRgqSSjOaVhFa8PSjWdC5scb9y
         1gHl5CSC4+Y1MDxeXyha4bMFgAzjF8prpd6AQrimVubUY8894AIjQ4n+6BkrFgMw1oWu
         /REPL6lXw0359ASx8v4X/tVP0pjRsvL4pt8dhxwPNzr+/KNGEzlSMcR9NJXvJqr7NdyK
         LAluIFVX0wpkmfcWqiTe+eT5Ov5F/bwSCN78wcOKgX/V0YJ7wi7xMwULF6aw3AMtcC/R
         kgsh9/tqzhzbUJjDdQPsbxHUuQZvo7RvkIURox5Evkb85L5YG0MJgSLCvbHbSzPPxzzB
         rQHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776137246; x=1776742046;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=pOnRFYTB9oKY4AxXu1Op5pVF1RPrbIg8+CUKW94/JvQ=;
        b=YLvMQHccqLGaLO65EZhcFcabuvnAjCIfDpqeGnNJeTuyw7Lzrj4Ive2qH+8IosXYCF
         Dr5W9KCKXe/y8BJtq6TqhfbD1h6i7MN5cxEwRnm4eyg6156PzX02NLrhAIkwlJg4dFPs
         MZ/HkayejES5otQKCXPMkWeRv6oFWZlabIJSXTQtkeov6aZqNF1NVsjk/yIb9Xoa3TJD
         c8q7BZbxEpLdi75J0uqGlZtp7McU2OyaPLX9mjTJe9GHzH7CLhw/RN88MwO1Ze+FHnNu
         vRZoUL9ThOchx1wPwjc12mlo2P+9qPZ3m0ZSxgnge1qlEaxo2lUeMXddFw3hPbsJGM2C
         O4uQ==
X-Forwarded-Encrypted: i=1; AFNElJ/05+21oW5te7KhhFMEV6xYFo/3OXUvn/hWLzhjaclCWjQIYJQAItgd1xz+VaDOGTGvTcvGr9pA@vger.kernel.org
X-Gm-Message-State: AOJu0Yxjs+HnymvsB+1B6ld+jugeVVP/NFeshuHMBx2GnUrpqNfQi68u
	IFpKdYVIPAb7H0OZnzoyhsTRociL+W08f3LE+57X4e9tEp6zlitNcrQRvmIIjcfZUlpMgU+BrrD
	HOt8jJToeF/D1FeOsdD2tRGgM1Ob5gfI=
X-Gm-Gg: AeBDievJhK0OLJqJVggpdkL50uLhX4NS7+i3KuZS9v4fF2ruxbQqzIllFEWqvrXCxOh
	S5p8PxecQLkIbRCWEXZFzHQGim7vw/dCiUumZktQudimSC6NelJHwswlA9FdKcIn8hQ7EL5MQx4
	YAMwLgm+3OZ/PK3Pyw2wSw2IwgUVfyPFhbNQlt4ZFGEzhqxDSJmAjc5eNMBLM5q3kvzolJSqxmE
	jWQPRGRgyHlKnc2jv4eWdb1AANzEH0ddEE+HLGb1XmXiCUT8S20knB8ZLUc/cjc5RPXknHFXXY7
	7VKoZWIhy/bi5uh/Dx9T0t+eDX1pV2V3CI/VUxXH
X-Received: by 2002:a05:6402:2116:b0:671:a6e2:97b0 with SMTP id
 4fb4d7f45d1cf-671a6e2994fmr2262250a12.0.1776137245805; Mon, 13 Apr 2026
 20:27:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260407-swap-memcg-fix-v1-0-a473ce2e5bb8@tencent.com> <adycRemx6QmSOX8n@yjaykim-PowerEdge-T330>
In-Reply-To: <adycRemx6QmSOX8n@yjaykim-PowerEdge-T330>
From: Kairui Song <ryncsn@gmail.com>
Date: Tue, 14 Apr 2026 11:26:49 +0800
X-Gm-Features: AQROBzCyZoZKqmWRCentpJTVxu-E7g1IvgKn93O8Ud6MPqO0q94XIMEqzEqSiZw
Message-ID: <CAMgjq7CEY+4JqUcnqbEsr7XET9oD7o+Dra=8dn_BRouu39TkSA@mail.gmail.com>
Subject: Re: [PATCH RFC 0/2] mm, swap: fix swapin race that causes inaccurate
 memcg accounting
To: YoungJun Park <youngjun.park@lge.com>
Cc: linux-mm@kvack.org, Michal Hocko <mhocko@kernel.org>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Shakeel Butt <shakeel.butt@linux.dev>, 
	Muchun Song <muchun.song@linux.dev>, Andrew Morton <akpm@linux-foundation.org>, 
	Chris Li <chrisl@kernel.org>, Kemeng Shi <shikemeng@huaweicloud.com>, 
	Nhat Pham <nphamcs@gmail.com>, Baoquan He <bhe@redhat.com>, Barry Song <baohua@kernel.org>, 
	Johannes Weiner <hannes@cmpxchg.org>, Alexandre Ghiti <alex@ghiti.fr>, David Hildenbrand <david@kernel.org>, 
	Lorenzo Stoakes <ljs@kernel.org>, "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Vlastimil Babka <vbabka@kernel.org>, Mike Rapoport <rppt@kernel.org>, 
	Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, Hugh Dickins <hughd@google.com>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, Chuanhua Han <hanchuanhua@oppo.com>, 
	linux-kernel@vger.kernel.org, cgroups@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-15284-lists,cgroups=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[kvack.org,kernel.org,linux.dev,linux-foundation.org,huaweicloud.com,gmail.com,redhat.com,cmpxchg.org,ghiti.fr,oracle.com,google.com,suse.com,linux.alibaba.com,oppo.com,vger.kernel.org];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[26];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ryncsn@gmail.com,cgroups@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[cgroups];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid,lge.com:email]
X-Rspamd-Queue-Id: B496F3F542A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, Apr 13, 2026 at 3:54=E2=80=AFPM YoungJun Park <youngjun.park@lge.co=
m> wrote:
>
> On Tue, Apr 07, 2026 at 10:55:41PM +0800, Kairui Song via B4 Relay wrote:
> > While doing code inspection, I noticed there is a long-existing issue
> > THP swapin may got charged into the wrong memcg since commit
> > 242d12c981745 ("mm: support large folios swap-in for sync io devices").
> > And a recent fix made it a bit worse.
> >

...

> > SYNCHRONOUS_IO fix seems also good, but it changes the current fallback
> > logic. Instead of fallback to next order it will fallback to order 0
> > directly. That should be fine though. This issue can be fixed / cleaned
> > up in a better way with swap table P4 as demostrated previously by
> > allocating the folio in swap cache directly with proper fallback and a
> > more compat loop for error handling:
> >
> > https://lore.kernel.org/linux-mm/20260220-swap-table-p4-v1-4-104795d198=
15@tencent.com/
>
> Hello Kairui,
>
> Nice catch!
>
> I have reviewed the proposed patches, and LGTM :D
> (For 1/2, flattening the if-statement depth slightly could help readabili=
ty.
> However, since this is planned to be refactored as part of the P4 swap ta=
ble work,
> I think it is fine as is.)

Hi YoungJun

>
> I mostly agree with your rationale.
>
> > memcg0 is not completely irrelevant as it's true that it is now
> > memcg1 faulting this folio. Shmem may have similar issue.
>
> That said, I would like to leave one small comment.
>
> My understanding is that if we account based on the folio that was
> allocated while running in memcg0 (on CPU 0), then having
> set_pte_at() install it with memcg0 already charged may still be
> considered acceptable from a acceptable coarse-grained synchronization pe=
rspective.
> (cuz folio is alloced at the time of "memcg 1 epoch")

Right... which is also why I sent it as an RFC, I wasn't completely
sure that if I missed anything. Charging into memcg0 is not really
that wrong, so this might be a negligible problem.

>
> Let's think of the situation below
>
>   CPU 0 (memcg0)                 CPU 1
>   ---------------------------    -----------------------------
>   charge folio to memcg0
>   allocate / prepare folio
>                                    task migrates to memcg1
>   ...
>   set_pte_at() installs PTE
>   (folio is already charged to memcg0)
>
> In this flow, the charge follows the allocation context (memcg0),
> even though the actual PTE installation happens after migration
> to memcg1.
>
> I understand that we cannot strictly guarantee correctness without
> fully synchronized migration, so this region inherently has some
> ambiguity. In that sense, the patch is addressing a corner of that
> problem space.
>
> But, I largely agree with your argument (the rationale is sound,
> and the change is not intrusive).
>
> I would have no further concerns if the following hold:
>
> - There is a tangible benefit to modifying this patch.

I can't really say that. The effect might be hardly observable, the
time window is really short and a few pages of inaccuracy (and in this
case, it's not completely inaccurate, just ambiguous) of the memcg
counter is hard to detect too.

> - There is no meaningful behavioral difference between charging
>   earlier (current behavior) and charging later (proposed change),
>   (e.g especially when memcg limits are hit.)

This part should be fine. Charge after swap cache might help to avoid thras=
hing.

> If those assumptions are correct, I am fully on board.

Thanks! It seems the benefit of this RFC is indeed trivial. I also ran
some performance tests later and didn't observe anything meaningful so
far.

Maybe we can then just go with the swap table p4 series directly, I
might overthinked about the potential issues, it would be solved
cleaner if we skip this here.

