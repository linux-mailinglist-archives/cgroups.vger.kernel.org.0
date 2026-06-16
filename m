Return-Path: <cgroups+bounces-17007-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id j+k0DOqWMWpungUAu9opvQ
	(envelope-from <cgroups+bounces-17007-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Tue, 16 Jun 2026 20:33:14 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C3D736943C2
	for <lists+cgroups@lfdr.de>; Tue, 16 Jun 2026 20:33:13 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=b5pQ7Yyn;
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-17007-lists+cgroups=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="cgroups+bounces-17007-lists+cgroups=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C4420308B28D
	for <lists+cgroups@lfdr.de>; Tue, 16 Jun 2026 18:33:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED4D647799B;
	Tue, 16 Jun 2026 18:33:11 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64E983DC4D9
	for <cgroups@vger.kernel.org>; Tue, 16 Jun 2026 18:33:10 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781634791; cv=pass; b=pTVk7elYRehg2KI6WI6PUH+faidzqbv/d0+hZR+au0G9jWLChZrYNwgMwWJ96L0XjSxJxLfv+VT1H1oz3YsawMsUPfc1fXYoJvHYa9lK/ww0yQSM63MIFPo0J2J2t0woRXnYkiHDxp23NgT05ttsYLkoGncTQPfilo9pC2mOHek=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781634791; c=relaxed/simple;
	bh=NT2iUMwBE5Z85f4aG0bWlhqwSr2O2rCOPr2R/cDrbl8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BVGlu/qzKrbCU5gTzC5Dg99qhl+atCJb8zdf3CeVKsZ1UdAk4wVMYt0EAi7OfQwb8qvMHcGigCpl5vjqMSVygHw13IlU+wM8FeuzaBzXwrxpK0qgqpVQ/3qucSv0CO58MIAmW1E4UcO0WIAujBfUd5YCAvzfUckoxYDG7hLWxXI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b5pQ7Yyn; arc=pass smtp.client-ip=209.85.128.42
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4908b92904fso60284185e9.0
        for <cgroups@vger.kernel.org>; Tue, 16 Jun 2026 11:33:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781634789; cv=none;
        d=google.com; s=arc-20240605;
        b=Ul4CIJ0WcrX7rpJAwUwYEw+ZNvLnfrlz0nrueOBuM0fPhxk8eYw3LOJ1mGSUAiI1P5
         AJg4bryxSZZqOhZxTeK8YB1ma/zFlkH66+YW+Y8zR40og2FNbYKs5UaZsAbhED9rxODY
         3xFqNV+mJ8EFNqrDFa0NsKjxhpHLnou8ArV2CRe05h6VtgRwDSomTk8ZXvaynUOTHKTD
         2kj56+PfwHKT5dEtc7DiLHLxQ9QGkpFFT6ZdRwLWMnzuBLqVCQxqgpDK3um6kbYmH7HH
         VenIiEiVcxgvnye5wGTYRrSWm6v6lAbLYhNvUVPFTfDjUfAB7je50hF9vuHCio0Ds6Fe
         mhOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=lXf8nL1WjPPTXu/ygIqCbfgbzskizrSAlTvqvC5a74c=;
        fh=HDdsVC1Ar1bDg76jbygXMK0ntO1b2CO0fG7QqfQzuGE=;
        b=CGNgsVynPl/6DWsDYhsW+WIXaQp+IvBdf4c3u3Jwc6LpK72jyebEy/QslnnJM+tDFB
         XZiVgOmjqgz7321Pt+SzdevX16mGd5i/3tw9dr6j9YcTVP8yTz+Tf0xEblShAQ9PnU5X
         m5I50P9QVlxL5c9pDjtwb2Tb7VxbTyCVYvHZs0XBO/N9pgdKUiGHyr7c3HlB7IshCkzW
         a8OQi6IHgi+UqLQ9tG48GzPB+79uun16Oa0FJtC/FGiUNWQqUTW9RLhAPPbewoQE7Ds2
         Hb9j5GjNaBJOd4ZyRdmIPMp2lDRSEN1uj0q948a4H8PG+Q3BFhPyWMvaLjsxbLKwj6EX
         XUDw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781634789; x=1782239589; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lXf8nL1WjPPTXu/ygIqCbfgbzskizrSAlTvqvC5a74c=;
        b=b5pQ7YynKEslOsz9nnWT/snLvPkHgApnwQmOs6TF5yYLFPKnbKdDK8PhnrIn2Pf/zY
         2S28uGzVpInosd2i5Fgs9LkMkxUbBU8oDyEXzjubOrGuVWVyb9Oad6CDGkLk6snR9XOH
         V1bku3OvAScAhXbapIFHG9RajRrN/dE6mP4+i717QgIylZt+R57RTeGU1i+WvKWFD4/2
         3x7qVY71mfogGxGosIuR1GUvYchWVCG5I/IA3KGtblrr5sD7y5C8R91ituz6guTru9nc
         eelWulGfv6Fn0XjrKP89tAWg6CSWbKL7F/iiHIKXrkmO6zTUQrUXawyAF2xxyIjx2qYU
         pv8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781634789; x=1782239589;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=lXf8nL1WjPPTXu/ygIqCbfgbzskizrSAlTvqvC5a74c=;
        b=cid0PMEBW4Rl/+Tw/FrxJWU6zaMfrAxN2pYUnhHqOB6G/0WiMrm9cOOBVkJhR10D8a
         tuRavcUA0+pi3dFlUICKWF9sa5OGs8DKi/eO1sY+CsQx3bClGRzWS0UzAQ7qmBLZOtf5
         3wG4qUBnUs9pZR3qZeehpFEm04xbXDGNQ776byStMnn6ykI0xLVBwn5k8gDILhGxILb0
         xIB9W9yxn0yPwPPSTmaCa0JKDvUtiQt49v2cVAFnv9nIs10EC4chTLnq6z9AuOcHqUal
         yAb5Yb2LEO3Bt1+QGl4H5e8VduzlIJNUS8WmRvbULwbMAxbK/ZZg8LgcgxP+BCfu865U
         VivQ==
X-Forwarded-Encrypted: i=1; AFNElJ+8sBKMeKNnY3wHlnXVy4DjF9HWZuvx/dQjBEbYynXof2fHXydGdiF5yhPoITdmawNhFWQ9YwrL@vger.kernel.org
X-Gm-Message-State: AOJu0YwUhZuWWa0Z3MZAByGdqGWt9W26AmElovoztAD/z2i0YmTkudwr
	RBdNo83IpUP77E1CddJ1xJJErmsO0hnBr8O9E65j/Y5dMN61XoOztPMYEeNMl8BDIAfHtltIzaS
	LG9WPpxQh9ra1LCe32IM4eBgBLcXcllY=
X-Gm-Gg: Acq92OGafA8dIwcioXauZxGzkwtPLANOAWzKN609mctxWu6QzC6T33cFzQywZrw6bPN
	yvBh5F32yBDMXR0LGNDuHzGzCE/ZjZcV/DJJJwNnD/6tg6A/wh+e7ixvgCconAVnrddaLTP/k5+
	gUi2LEFANERAGxs5r/tU2+Pn0AC9PhTyhGNnsi3W99Xkw+eN8myUMD7U/Qtg9OZQorYJXas9Upc
	AC0c39/CLCzlb3f77AYL9X0AG2t64T2M/gmzM+1ZBp8+05FDlFvrnaPSNDbofMpfVEv9ZKj+IzO
	4IpGXkaWYUoZQGvi6RAmZZH8vMw+Bx4cf4jc6jazMVW1adVLS9JcNn4=
X-Received: by 2002:a05:600c:4e89:b0:492:1e36:bafd with SMTP id
 5b1f17b1804b1-492333df13emr10676665e9.37.1781634788536; Tue, 16 Jun 2026
 11:33:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <aictKA0XWMWbxFdN@linux.dev> <CAO9r8zPvCaCqvoUhPdAN5Oi_Sj0mK-t7DJhOOz3Xf1DT-Wrgcw@mail.gmail.com>
 <aieUQUBHI+E3uNPW@yjaykim-PowerEdge-T330> <airzE7jD9UtyR17J@google.com>
 <aisEWnb3pzmVC4dl@linux.dev> <aiu06fbV7rWqY0Bm@yjaykim-PowerEdge-T330>
 <aiw2p5ANjsQUCIHA@linux.dev> <ai5y923elCSZp41j@yjaykim-PowerEdge-T330>
 <CAO9r8zOVqbJEaBqTHw=r2bYw7Lm1tO0TU9QuG+eH1rfqcTAJJQ@mail.gmail.com>
 <ajCgzNIPLhjTRSXR@yjaykim-PowerEdge-T330> <ajC+FNpkVpI4pbBz@yjaykim-PowerEdge-T330>
 <CAO9r8zMimM8n54BL1viuX3pYzO=wzQU89LhCF1HW0bAv97ZQtg@mail.gmail.com>
In-Reply-To: <CAO9r8zMimM8n54BL1viuX3pYzO=wzQU89LhCF1HW0bAv97ZQtg@mail.gmail.com>
From: Nhat Pham <nphamcs@gmail.com>
Date: Tue, 16 Jun 2026 14:32:56 -0400
X-Gm-Features: AVVi8Cfr8CEOZKUUld5jFV5E_U7IZnrXsKXwb_Qx9BDKSv9h1SLfYRc_8OLu6YY
Message-ID: <CAKEwX=Nz9SWcEVQGQjHN8P8OANJY4BG0w+iQOzoNOWuteoVjAg@mail.gmail.com>
Subject: Re: [swap tier discussion] Re: [PATCH v3 2/4] mm/zswap: Implement
 proactive writeback
To: Yosry Ahmed <yosry@kernel.org>
Cc: YoungJun Park <youngjun.park@lge.com>, Shakeel Butt <shakeel.butt@linux.dev>, 
	Hao Jia <jiahao.kernel@gmail.com>, Johannes Weiner <hannes@cmpxchg.org>, mhocko@kernel.org, 
	tj@kernel.org, mkoutny@suse.com, roman.gushchin@linux.dev, 
	akpm@linux-foundation.org, chengming.zhou@linux.dev, muchun.song@linux.dev, 
	cgroups@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org, Hao Jia <jiahao1@lixiang.com>, chrisl@kernel.org, 
	kasong@tencent.com, baoquan.he@linux.dev, joshua.hahnjy@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:yosry@kernel.org,m:youngjun.park@lge.com,m:shakeel.butt@linux.dev,m:jiahao.kernel@gmail.com,m:hannes@cmpxchg.org,m:mhocko@kernel.org,m:tj@kernel.org,m:mkoutny@suse.com,m:roman.gushchin@linux.dev,m:akpm@linux-foundation.org,m:chengming.zhou@linux.dev,m:muchun.song@linux.dev,m:cgroups@vger.kernel.org,m:linux-mm@kvack.org,m:linux-kernel@vger.kernel.org,m:linux-doc@vger.kernel.org,m:jiahao1@lixiang.com,m:chrisl@kernel.org,m:kasong@tencent.com,m:baoquan.he@linux.dev,m:joshua.hahnjy@gmail.com,m:jiahaokernel@gmail.com,m:joshuahahnjy@gmail.com,s:lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-17007-lists,cgroups=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[nphamcs@gmail.com,cgroups@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[21];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nphamcs@gmail.com,cgroups@vger.kernel.org];
	FREEMAIL_CC(0.00)[lge.com,linux.dev,gmail.com,cmpxchg.org,kernel.org,suse.com,linux-foundation.org,vger.kernel.org,kvack.org,lixiang.com,tencent.com];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp,lge.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: C3D736943C2

On Tue, Jun 16, 2026 at 1:31=E2=80=AFPM Yosry Ahmed <yosry@kernel.org> wrot=
e:
>
> On Mon, Jun 15, 2026 at 8:08=E2=80=AFPM YoungJun Park <youngjun.park@lge.=
com> wrote:
> >
> > ...
> > > - "zswap tier only": Only zswap is allowed. Fallback to other swap is
> > >   blocked.
> > > - "zswap writeback disabled": zswap is allowed, but if zswap_store()
> > >   fails, pages can still fall back to other swap devices.
> >
> > Upon double-checking the code, my previous clarification was wrong.
> > You are right. Sorry for the confusion. "zswap tier only" is indeed
> > equivalent to "zswap writeback disabled".
> > (I'm not sure why I read the code that way...)
> >
> > As I initially thought, it might be possible to replace the zswap write=
back
> > control with the tiering mechanism.
> >
> > If we need to keep the existing interface, we can integrate or share th=
e
> > underlying logic (though the specific details need more thought anyway)=
.
> >
> > It can be summarized as follows:
> >
> > - "zswap tier only" + "zswap writeback disable" -> meaningless (noop)
> > - "zswap tier only" + "zswap writeback enable" -> meaningless (no writa=
bck backend exist)
> > - "zswap tier with other tiers" + "zswap writeback disable" -> uses onl=
y zswap
> >   (can be replaced by "zswap tier only". This code could be intergrated=
, modified or something.)
> > - "zswap tier with other tiers" + "zswap writeback enable" -> works as =
is

TBH, without vswap, we should not allow setting zswap as its own tier.
It's meaningless. Maybe makes it a no-op, and warn users what they're
setting is gibberish?


>
> Hmm we might want to somehow disable memory.zswap.writeback if tiering
> is enabled, to avoid having to deal with this. But I am not sure how
> possible this is.

With tiering and without vswap, you still need an interface to
prescribe that a cgroup can:

1. Allocate slots from a certain swap device.

2. Use zswap, backed by those slots.

3. But no IO is allowed to those slots (no writeback or fallback on
zswap failure).

So we still need memory.zswap.writeback, until we get rid of non-vswap
case for zswap.

