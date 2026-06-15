Return-Path: <cgroups+bounces-16925-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 0fHeGXdgL2pw/QQAu9opvQ
	(envelope-from <cgroups+bounces-16925-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Mon, 15 Jun 2026 04:16:23 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 608D7682D47
	for <lists+cgroups@lfdr.de>; Mon, 15 Jun 2026 04:16:22 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=pLHneEDE;
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-16925-lists+cgroups=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="cgroups+bounces-16925-lists+cgroups=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 9C27030028F5
	for <lists+cgroups@lfdr.de>; Mon, 15 Jun 2026 02:16:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 647D8258EF3;
	Mon, 15 Jun 2026 02:16:15 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00E4C238C0A
	for <cgroups@vger.kernel.org>; Mon, 15 Jun 2026 02:16:13 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781489775; cv=pass; b=QfSOwS4XWOecmDYFkt7U1+yT9NFIfDbb7lN+f43t8+gXu5jNZL5pGBiKkmwglAxe0Eu+vWGLaRTuT1wpaPaJO5asE0UyCmfzbwTXaKbSOfH5Gk45CEaMjtEZa+e2wcO3rERnK2t41flt/nyOl+v8xjzDmECfrMU7iUqQMBZg+aA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781489775; c=relaxed/simple;
	bh=evnYbr31oq8hdGPu0I2FlzbaC2mIfZGo5ZpQXXksHAc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lFQAFuHDj+KL2GeSSpbTQAVAZS1PNKV8t2O7NbvW13WS1ekT/a5j6mbLUR1HJOHIXYrxqN10ufFVWEytt+ujA0dcvHE54MxnpKgZUrIUveXi5IbWJhx8/XwqUdptM0TveFhD5vqizNd4mahROA86klwl0eSoDN4et7h4r3AwAV4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pLHneEDE; arc=pass smtp.client-ip=209.85.210.173
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-8423f626a65so1229902b3a.2
        for <cgroups@vger.kernel.org>; Sun, 14 Jun 2026 19:16:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781489773; cv=none;
        d=google.com; s=arc-20240605;
        b=bCYfXgmzdRGu4UwId08H8n9aUJpAwyPJBrixjSsr5+SeDN0P2n6vvIdeV7a+VwtNvd
         OyFjumsY5fDvv/FPmHPtAtQYterFZqWOpk4p9FghnyFhdt2u5gE9y11Nlbu1MKSc07d2
         jmUlMcCL8k3jDomhE08vE4BUuCdu4Wba2KJkuviR4C+ZSPl4MTwmEZX8HwrNSlZHQo9f
         lzR4d3vajiY62m981OT+kCwwfMyZAw5G0PneD+cPoMX+1Bh9Oe5hw0cedrhXo6vKHwKN
         f3R35N78es46b5g9XnHW0Pxu++s9h4ZQXKxFfPhDTOiTy6CElfIBnhFl1+t/bqUm8dgF
         F5yg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=evnYbr31oq8hdGPu0I2FlzbaC2mIfZGo5ZpQXXksHAc=;
        fh=PjKnzgGLGksmb2xq3yuSkFVdk44TmoloDsU861KMErA=;
        b=QVJSkvqhDnqk+0yEBXh4Qt9+9CzV0uulcXRmNrZT3gl4lJE/yqJ0/p7Buqi9PSRvYi
         3wQRZ/kK8ZjF0JX66v1KVjkAiEToajkm2jfuf1w0P/c8Zu2it24qnTNk4qosAOtPjJHp
         01BwSULjZRc9A91KllYyOJjxP6qZe53yFiokvsJ3aCrSgmDdXV98sAdDXWcQw5hmdLbg
         lm4I8/VumrvgiEXJP+7s2iD0k0Bju9mNruegKL7CCJkZ+zyVJQD0XMKea76smFEKDlcV
         O/UpjyMEqJv5zl9zRl0kp/Ln0jaKSkEMlVJR8mc1GAj5iZ01jgrQaKNippdc1xO04GbY
         M3Bw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781489773; x=1782094573; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=evnYbr31oq8hdGPu0I2FlzbaC2mIfZGo5ZpQXXksHAc=;
        b=pLHneEDEUKrhYvjL0armL2pjJstPc5ZdPsvn93TNc4XYhyTKFG3j2ihoQH+ZnAGsy9
         rztrUPlnoUfCjsKH3eYD2On4crP604xX8/4XCiH8wDO50JNbEUtLNXLXzj1V8PFUd4YO
         um18pE+4RkD2VkkCFt1uddM65ZpgXlsC/Dx7FK7wiWzCF557CyjNwfmSTe2wgJz7zK3f
         x+jOtBV5OJVNHs/WeSu9bCukrjfvWf0rHxqUG7vBN7CX99egwPjzNnXPDGy5hLO0asrg
         njTxl5FW0WvalCdEaBiTfFtj+UN1MrlYkD+nsimhwy7cJWldMF6xRudQy/OmWdeE+QxD
         soJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781489773; x=1782094573;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=evnYbr31oq8hdGPu0I2FlzbaC2mIfZGo5ZpQXXksHAc=;
        b=EMp8kQKSi22bU02ebQjHcYYTSMjlJPTCgMab/ZwaSbzwvBGQJYnT44KgqOSFnXrh+T
         mYxkWVA2zkzp7YT9tgqaRW1ZEt965vqfVrDJodhY84h2EiLkAqiy7pQwcHCSLhY1FBmN
         tj1tMSZkgV3GR7ZolnE2DWe9eZc4+CC/+iMZCOrAiOmNhQdQSEkF7hAydUT2ZeNKEEfT
         62banUtH7sLhN7lN+JZJHHiiClrhWETvTbO4aXomN+wms0L7xNhyZZ2+9LLU7ZbQf8aK
         W51WYucPB4umLCK507WyUJIOU5J5uXCR7EJuVABWKhuB8fMRAtj13jFPiW8H5x2gSUcU
         mLHA==
X-Forwarded-Encrypted: i=1; AFNElJ9nnjFzBED5m+Gnl+l0zD5IkECgFJ7VZRMrckGo5qV0JLq8zEWCa/kJVseQHU4aAPRkx17KNATD@vger.kernel.org
X-Gm-Message-State: AOJu0YySTCB90g4obU0LjHAqhyDJzOBjrWvEmC5NmSG6Y4N6/UIsI69F
	vaRs0hTf+SDufykLshTZ86RR4SjtS8KVV1HLZo8cAuKxAyqlGI6WYUuej1BjajMD0F6rl9zXeaq
	YUPg3wpWF2aN/xwPVE7ZYYnoyRpWV5lI=
X-Gm-Gg: Acq92OEe8CgdZ3XK57rSt2clPfTOxSKkCBCNIy6DIf9a5x7dgwdf9+4MCJ5gQUQWJIf
	fisH/T/NNVAKno6o4fPnQ62cys1GmL1TcCVAV+i6af3yAPKTZStugrxTHvgwABbwzBLplwIyUco
	U5hoQi4l05k7BwvPsFMT475Im2e70qZNVv84wsReBUmuUWYRyuocEnI+kTZ7G/TVwDcwOD90Yp2
	ZTv0r6tlqAkV8GhZcRSGoBye/BzsPnoq/8xF9EQt9Uo6TLblKa6s1L17iZSI+WAuKmG92WI9Ljz
	WmnQENrCbM4AxwjioZK6dv+ylQHmFXa70/D3guFOoRvM7l39bccljQVyI+JVbvUb8GwBlYVxDBv
	coItdRg5pbyOdTGO49rHor7Jg
X-Received: by 2002:a05:6a00:3908:b0:842:732c:5687 with SMTP id
 d2e1a72fcca58-8434ce3f8famr12361190b3a.22.1781489773160; Sun, 14 Jun 2026
 19:16:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260610-slab_alloc_flags-v2-0-7190909db118@kernel.org>
 <20260610-slab_alloc_flags-v2-5-7190909db118@kernel.org> <aiuBoDbQc0N-l7e-@fedora>
 <CAJuCfpGSHfNUvL9AzbftSg=uGRW4cJLbO6iB15keyN6A_eSWEw@mail.gmail.com>
In-Reply-To: <CAJuCfpGSHfNUvL9AzbftSg=uGRW4cJLbO6iB15keyN6A_eSWEw@mail.gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Sun, 14 Jun 2026 19:16:02 -0700
X-Gm-Features: AVVi8Cd0IZA3UYw1GOqh858BtHcrz52-nGsn6-ywXz-Dz05xnWvs8Qh5w7kHwt4
Message-ID: <CAADnVQJPETYAOd9R9Bg2JuuF1q7grg8VtEnvdvr0fDFhxb9O6A@mail.gmail.com>
Subject: Re: [PATCH v2 05/16] mm/slab: introduce alloc_flags and SLAB_ALLOC_TRYLOCK
To: Suren Baghdasaryan <surenb@google.com>
Cc: Hao Li <hao.li@linux.dev>, "Vlastimil Babka (SUSE)" <vbabka@kernel.org>, Harry Yoo <harry@kernel.org>, 
	Christoph Lameter <cl@gentwo.org>, David Rientjes <rientjes@google.com>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Alexei Starovoitov <ast@kernel.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Johannes Weiner <hannes@cmpxchg.org>, 
	Michal Hocko <mhocko@kernel.org>, Shakeel Butt <shakeel.butt@linux.dev>, 
	Alexander Potapenko <glider@google.com>, Marco Elver <elver@google.com>, Dmitry Vyukov <dvyukov@google.com>, 
	kasan-dev <kasan-dev@googlegroups.com>, linux-mm <linux-mm@kvack.org>, 
	LKML <linux-kernel@vger.kernel.org>, 
	"open list:CONTROL GROUP (CGROUP)" <cgroups@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:surenb@google.com,m:hao.li@linux.dev,m:vbabka@kernel.org,m:harry@kernel.org,m:cl@gentwo.org,m:rientjes@google.com,m:roman.gushchin@linux.dev,m:ast@kernel.org,m:akpm@linux-foundation.org,m:hannes@cmpxchg.org,m:mhocko@kernel.org,m:shakeel.butt@linux.dev,m:glider@google.com,m:elver@google.com,m:dvyukov@google.com,m:kasan-dev@googlegroups.com,m:linux-mm@kvack.org,m:linux-kernel@vger.kernel.org,m:cgroups@vger.kernel.org,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_ALL(0.00)[];
	FORGED_SENDER(0.00)[alexeistarovoitov@gmail.com,cgroups@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-16925-lists,cgroups=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[19];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alexeistarovoitov@gmail.com,cgroups@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TAGGED_RCPT(0.00)[cgroups];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,mail.gmail.com:mid,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 608D7682D47

On Sun, Jun 14, 2026 at 7:01=E2=80=AFPM Suren Baghdasaryan <surenb@google.c=
om> wrote:
>
> On Thu, Jun 11, 2026 at 8:50=E2=80=AFPM Hao Li <hao.li@linux.dev> wrote:
> >
> > On Wed, Jun 10, 2026 at 05:40:07PM +0200, Vlastimil Babka (SUSE) wrote:
> > > Similarly to the page allocators, introduce slab-allocator specific
> > > alloc flags that internally control allocation behavior in addition t=
o
> > > gfp_flags, without occupying the limited gfp flags space.
> > >
> > > Introduce the first flag SLAB_ALLOC_TRYLOCK that behaves similarly to
> > > page allocator's ALLOC_TRYLOCK and will be used to reimplement
> > > kmalloc_nolock()'s "!allow_spin" behavior. That currently relies on
> > > gfpflags_allow_spinning() and thus the lack of both __GFP_RECLAIM fla=
gs,
> > > importantly __GFP_KSWAPD_RECLAIM. This can give false-positive result=
s
> > > e.g. in early boot with a restricted gfp_allowed_mask.
> > >
> > > Also introduce alloc_flags_allow_spinning() to replace the usage of
> > > gfpflags_allow_spinning().
> > >
> > > Start using alloc_flags and the new check first in alloc_from_pcs() a=
nd
> > > __pcs_replace_empty_main(). This means some slab allocations that wer=
e
> > > falsely treated as kmalloc_nolock() due to their gfp flags will now h=
ave
> > > higher chances of succeed, and this will further increase with follow=
up
>
> nit: I think it should be either "higher chances of succeess" or
> "higher chances to succeed".
>
> > > changes.
> > >
> > > Remove a WARN_ON_ONCE() from refill_objects() as it's now legitimate =
to
> > > reach it from a slab allocation that's not _nolock() and yet lacks
> > > __GFP_KSWAPD_RECLAIM for other reasons.
> > >
> > > Signed-off-by: Vlastimil Babka (SUSE) <vbabka@kernel.org>
> > > ---
> >
> > Reviewed-by: Hao Li <hao.li@linux.dev>
>
> I would call SLAB_ALLOC_TRYLOCK something like SLAB_ALLOC_NOSPIN or
> SLAB_ALLOC_NOLOCK but naming is hard and I don't claim myself to be
> good at it. So, feel free to adopt my suggestion if you like it or
> ignore it otherwise.
>
> Reviewed-by: Suren Baghdasaryan <surenb@google.com>

Just noticed "trylock" in the #define SLAB_ALLOC_TRYLOCK

Please call it SLAB_ALLOC_NOLOCK.

Initial api was using 'trylock' name and it was a mistake,
since people assumed normal spin_trylock() like semantics.
"trylock" implies that it fails under contention
and retry is a normal next step. It's not the case.
No one should be retrying. That's why the final api was kmalloc_nolock().
So please keep this important distinction in the name.
SLAB_ALLOC_NOLOCK should mean that spinning locks
should not be taken. It should not mean "just go to trylock everywhere".

