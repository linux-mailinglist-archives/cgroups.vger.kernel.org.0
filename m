Return-Path: <cgroups+bounces-16975-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id QLikKzMhMGowOgUAu9opvQ
	(envelope-from <cgroups+bounces-16975-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Mon, 15 Jun 2026 17:58:43 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2223F687FFB
	for <lists+cgroups@lfdr.de>; Mon, 15 Jun 2026 17:58:43 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=AJnFbIKx;
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-16975-lists+cgroups=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="cgroups+bounces-16975-lists+cgroups=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 61DF030A20AD
	for <lists+cgroups@lfdr.de>; Mon, 15 Jun 2026 15:50:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02762408639;
	Mon, 15 Jun 2026 15:49:37 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com [209.85.210.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F6333AB27D
	for <cgroups@vger.kernel.org>; Mon, 15 Jun 2026 15:49:35 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781538576; cv=none; b=dAmjlx4BG8ayXMAkfClie+rlYAVBqgfy2PCrGJZxaaEmij9Zzs42P5ztg4UJVH7xVLGSQOThsprxMrJYRzhlZGE4qUjOIcouclcBlfCccOzOHjKEaWC3GjWmOarpjifwm84L9LkeQhc6FufsYn3ax3HBgJ4dxfVgL+qBIyW77+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781538576; c=relaxed/simple;
	bh=KFKCs1EbAVFNbQGjzuPE2K8eZReAhob/Cx5uFNdpI3o=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=aBj9lv30NxrgV/H0W5PicGehdWprjAWECT9mhE1pLUSFy869VTPcl8onAT4ynaExuDUHkv46EI0B5HGmmVj/88tPrZKkM94U7QOHJgsKRyHS/4By56LuF0JLPSHoKs1mXSWSu1lYh5wQfsMv/c5W8pDuroxwQklOiqgMiR4UX4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AJnFbIKx; arc=none smtp.client-ip=209.85.210.49
Received: by mail-ot1-f49.google.com with SMTP id 46e09a7af769-7e6e21c47e6so1797420a34.1
        for <cgroups@vger.kernel.org>; Mon, 15 Jun 2026 08:49:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781538574; x=1782143374; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KFKCs1EbAVFNbQGjzuPE2K8eZReAhob/Cx5uFNdpI3o=;
        b=AJnFbIKxs8kVWDY7xV3fuiwF+wCb/9XIICrwa7SFtjw3k/hBj4ncO42hEZrfFi16Mc
         +CO6xhx1FhXZj77/f85YNmPVqdt+zNVJcT/gltO+khyadbwT+8hhMxRJPwfZveQuDLqv
         GJwMBCqoLXLwDX1oq86gFq6Atgkdptrv5eHoMElz5kBtgetHiyp7+vNVhQ+3+0v+aNaQ
         H4yNkCY6axhjHtkQ5Q13A/c0hYOcTSlK6ZH90Xx8jbhcJWQn0YWPjkQBadXkk7iRTYYD
         cayf8XBuYqH9QM2tdUcncH2Ltm0THlVTVCKDDtOiVtG3IH40Jj+UD9mqJq3g618VpsrJ
         Rl0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781538574; x=1782143374;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KFKCs1EbAVFNbQGjzuPE2K8eZReAhob/Cx5uFNdpI3o=;
        b=j7u6iPZAZGI+i37X5Qnkmx4PjWoOlN8nKZAoKjwRPijRi+BRKZR91n3wXlvNOBy76w
         sPTvYdZ6jipVLe5MJwzgBymsizV4c6R0IPsOSM5Pl7fkQCqMnaSW+Vc4Y4eubGG17qk6
         0o/N6NiI6GKo4hFilKuiZxA918aPYxluCmRFXSk0FkSgm1+22vgxXPFkG7deVSx8g1Uy
         vCODOXYUzmQLuhCSa8MyECpVUVNI17b6k1GxQXbTYOO4lOtE7JK0UxrDQEv6bupLF3Id
         wT5EcMxarwdiwB2SrToTwLFFkADO7wg6izD/VOLV4NeUKnDUXHvOtDFatFhbJZGhobMF
         TppQ==
X-Forwarded-Encrypted: i=1; AFNElJ9VE9IjhFWE0JSzUnUDRwk+WqzF11arAzX63rAw9DTkLtTeWha8lxjBQd8/vyDftXu5PKfrBGve@vger.kernel.org
X-Gm-Message-State: AOJu0YzfuPqSwQPbP1skEvhBGUwofYXFZm/qkkjCX/ZKCNyzSgPkS454
	MY6tF0XlF0QxsiIvHC1steSenq0awHoDAKuWbCnpXU5nGoys8X01z35n
X-Gm-Gg: Acq92OFhbehUtpXY6zNYQAz1xNqEhNqIWG+ybETt69S59hEDWsy4pvOf2Nk+QXOR+6e
	CJcbf11yiwU/INjzjUz/ZFVkj73TZxbxi8mA0jp4gEAw7EmqEuq1ijh0tZ4oiKjTao1WPQq06oe
	r1zz/vDyf6NdZ0Rx4VCkrziR4r9Mu4VBP3Xx4CkHJv4lk/dwFWzqTMVUC88YrdNCRNhhBt/shqd
	aZNBxKfRqK64AFQGy0wp1RzIc7zRgbsIPsZbAevLdvfDu2Lnl6+xOLRGYbZEKI/gXNclgJJRKn/
	YuGyKVVcgTTK5/Nt0X6cRqCDGUNUz/hfQEr0gm+lqYhjR1nPcMXidXXw+U8vezFKIjGNIxWP3EQ
	kP+9sAWMbPOT3d2WNXMG5zWSItsi9r4/df/Pjk2/cpopWtew3AEk1rB/8P7AykEVG7LHUwe+r8n
	xYU0fvL/Dn5AX8n0Nxr/IF9DSF0Iz+AbfN/dl1dMC3NxjLgUJPokMLR/nRuifngAZ8Dg5WPgnuw
	mpZj+Lmz3RJ6Uj06w==
X-Received: by 2002:a05:6808:c146:b0:485:43ed:bd4d with SMTP id 5614622812f47-48741b97bdfmr8360469b6e.33.1781538574387;
        Mon, 15 Jun 2026 08:49:34 -0700 (PDT)
Received: from localhost ([2a03:2880:10ff:5c::])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7e79f6b7e6csm4153341a34.17.2026.06.15.08.49.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Jun 2026 08:49:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 15 Jun 2026 08:49:32 -0700
Message-Id: <DJ9QPTO2WXNB.10E88ZHWRDHB0@gmail.com>
Cc: "Hao Li" <hao.li@linux.dev>, "Harry Yoo" <harry@kernel.org>, "Christoph
 Lameter" <cl@gentwo.org>, "David Rientjes" <rientjes@google.com>, "Roman
 Gushchin" <roman.gushchin@linux.dev>, "Alexei Starovoitov"
 <ast@kernel.org>, "Andrew Morton" <akpm@linux-foundation.org>, "Johannes
 Weiner" <hannes@cmpxchg.org>, "Michal Hocko" <mhocko@kernel.org>, "Shakeel
 Butt" <shakeel.butt@linux.dev>, "Alexander Potapenko" <glider@google.com>,
 "Marco Elver" <elver@google.com>, "Dmitry Vyukov" <dvyukov@google.com>,
 "kasan-dev" <kasan-dev@googlegroups.com>, "linux-mm" <linux-mm@kvack.org>,
 "LKML" <linux-kernel@vger.kernel.org>, "open list:CONTROL GROUP (CGROUP)"
 <cgroups@vger.kernel.org>
Subject: Re: [PATCH v2 05/16] mm/slab: introduce alloc_flags and
 SLAB_ALLOC_TRYLOCK
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Vlastimil Babka (SUSE)" <vbabka@kernel.org>, "Suren Baghdasaryan"
 <surenb@google.com>
X-Mailer: aerc
References: <20260610-slab_alloc_flags-v2-0-7190909db118@kernel.org>
 <20260610-slab_alloc_flags-v2-5-7190909db118@kernel.org>
 <aiuBoDbQc0N-l7e-@fedora>
 <CAJuCfpGSHfNUvL9AzbftSg=uGRW4cJLbO6iB15keyN6A_eSWEw@mail.gmail.com>
 <CAADnVQJPETYAOd9R9Bg2JuuF1q7grg8VtEnvdvr0fDFhxb9O6A@mail.gmail.com>
 <f927f1b4-3f60-471e-b42b-8d098c1ce5dd@kernel.org>
In-Reply-To: <f927f1b4-3f60-471e-b42b-8d098c1ce5dd@kernel.org>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.65 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[19];
	TO_DN_ALL(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	TAGGED_FROM(0.00)[bounces-16975-lists,cgroups=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:hao.li@linux.dev,m:harry@kernel.org,m:cl@gentwo.org,m:rientjes@google.com,m:roman.gushchin@linux.dev,m:ast@kernel.org,m:akpm@linux-foundation.org,m:hannes@cmpxchg.org,m:mhocko@kernel.org,m:shakeel.butt@linux.dev,m:glider@google.com,m:elver@google.com,m:dvyukov@google.com,m:kasan-dev@googlegroups.com,m:linux-mm@kvack.org,m:linux-kernel@vger.kernel.org,m:cgroups@vger.kernel.org,m:vbabka@kernel.org,m:surenb@google.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[alexeistarovoitov@gmail.com,cgroups@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alexeistarovoitov@gmail.com,cgroups@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,linux.dev:email,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 2223F687FFB

On Mon Jun 15, 2026 at 2:02 AM PDT, Vlastimil Babka (SUSE) wrote:
> On 6/15/26 04:16, Alexei Starovoitov wrote:
>> On Sun, Jun 14, 2026 at 7:01=E2=80=AFPM Suren Baghdasaryan <surenb@googl=
e.com> wrote:
>>>
>>> On Thu, Jun 11, 2026 at 8:50=E2=80=AFPM Hao Li <hao.li@linux.dev> wrote=
:
>>> >
>>> > On Wed, Jun 10, 2026 at 05:40:07PM +0200, Vlastimil Babka (SUSE) wrot=
e:
>>> > > Similarly to the page allocators, introduce slab-allocator specific
>>> > > alloc flags that internally control allocation behavior in addition=
 to
>>> > > gfp_flags, without occupying the limited gfp flags space.
>>> > >
>>> > > Introduce the first flag SLAB_ALLOC_TRYLOCK that behaves similarly =
to
>>> > > page allocator's ALLOC_TRYLOCK and will be used to reimplement
>>> > > kmalloc_nolock()'s "!allow_spin" behavior. That currently relies on
>>> > > gfpflags_allow_spinning() and thus the lack of both __GFP_RECLAIM f=
lags,
>>> > > importantly __GFP_KSWAPD_RECLAIM. This can give false-positive resu=
lts
>>> > > e.g. in early boot with a restricted gfp_allowed_mask.
>>> > >
>>> > > Also introduce alloc_flags_allow_spinning() to replace the usage of
>>> > > gfpflags_allow_spinning().
>>> > >
>>> > > Start using alloc_flags and the new check first in alloc_from_pcs()=
 and
>>> > > __pcs_replace_empty_main(). This means some slab allocations that w=
ere
>>> > > falsely treated as kmalloc_nolock() due to their gfp flags will now=
 have
>>> > > higher chances of succeed, and this will further increase with foll=
owup
>>>
>>> nit: I think it should be either "higher chances of succeess" or
>>> "higher chances to succeed".
>
> success it is
>
>>>
>>> > > changes.
>>> > >
>>> > > Remove a WARN_ON_ONCE() from refill_objects() as it's now legitimat=
e to
>>> > > reach it from a slab allocation that's not _nolock() and yet lacks
>>> > > __GFP_KSWAPD_RECLAIM for other reasons.
>>> > >
>>> > > Signed-off-by: Vlastimil Babka (SUSE) <vbabka@kernel.org>
>>> > > ---
>>> >
>>> > Reviewed-by: Hao Li <hao.li@linux.dev>
>>>
>>> I would call SLAB_ALLOC_TRYLOCK something like SLAB_ALLOC_NOSPIN or
>>> SLAB_ALLOC_NOLOCK but naming is hard and I don't claim myself to be
>>> good at it. So, feel free to adopt my suggestion if you like it or
>>> ignore it otherwise.
>>>
>>> Reviewed-by: Suren Baghdasaryan <surenb@google.com>
>>=20
>> Just noticed "trylock" in the #define SLAB_ALLOC_TRYLOCK
>>=20
>> Please call it SLAB_ALLOC_NOLOCK.
>>=20
>> Initial api was using 'trylock' name and it was a mistake,
>> since people assumed normal spin_trylock() like semantics.
>> "trylock" implies that it fails under contention
>> and retry is a normal next step. It's not the case.
>> No one should be retrying. That's why the final api was kmalloc_nolock()=
.
>> So please keep this important distinction in the name.
>> SLAB_ALLOC_NOLOCK should mean that spinning locks
>> should not be taken. It should not mean "just go to trylock everywhere".
>
> Eh, ok then, will change to SLAB_ALLOC_NOLOCK. Even though it's mostly in=
ternal.
>
> So next thing we change page allocator's ALLOC_TRYLOCK to ALLOC_NOLOCK to=
o?

yeah. Would be good to align as well.


