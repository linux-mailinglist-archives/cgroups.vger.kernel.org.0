Return-Path: <cgroups+bounces-17196-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id qjOqOSrMOmryHAgAu9opvQ
	(envelope-from <cgroups+bounces-17196-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Tue, 23 Jun 2026 20:10:50 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 503EA6B9604
	for <lists+cgroups@lfdr.de>; Tue, 23 Jun 2026 20:10:50 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=X1nRv515;
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-17196-lists+cgroups=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="cgroups+bounces-17196-lists+cgroups=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id B766730443F1
	for <lists+cgroups@lfdr.de>; Tue, 23 Jun 2026 18:10:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32586391E58;
	Tue, 23 Jun 2026 18:10:46 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F29A8390239
	for <cgroups@vger.kernel.org>; Tue, 23 Jun 2026 18:10:44 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782238246; cv=none; b=Pa++pnsHXW4pOVYeweWKEN6vwXJY9ejua/WYjPpP1zd7b/0eqjEUYLVYWOd5Gm1VezYkIBR0XygugCcPrOd7oEETSSef8+a3NNJRvvmAkHlCwUeeRZYYmsHxZ5UydRBThnaRQ4Y7OicfqV0lqvEWQAtRh0oBGi9NhialcTZeXOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782238246; c=relaxed/simple;
	bh=tq05N2NyBqQ5JGKENo2Kp7YwhqEkQubdotmf3YJrnZA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BWx4cadiKixIze+P35dM4d9iqYZghEtTbFOzaVyQIYVapZIm7v99lUD/f6S5byDmEpLzAp+3V27oLfRQleAL/EGql4XTEo88kVQ3aVAnaGv/ZH3Dxw7xBaAqkLUrA/rsPUaFabBXWYhQV2h7/VaoKivtE5sWbqG7sNW8L9x31bg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X1nRv515; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9CFDF1F0155A
	for <cgroups@vger.kernel.org>; Tue, 23 Jun 2026 18:10:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782238244;
	bh=tq05N2NyBqQ5JGKENo2Kp7YwhqEkQubdotmf3YJrnZA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=X1nRv515Stl6t4+NoB6Qix0fteA6CssGL7EH+pwMSccY3Ak5P6yAKM3Rb1l7XfVdy
	 v+rjOF+lidhUlZzT/l/FcWlaf5yW+kdLDq2udjVAy7ShamhhQi8M+hnKRKc26pU2J6
	 POo+qIaI234y7ErtLkXgInDdKbOMmMjHb4yqEnu7fuo6SYwct2Zt9egfwfKQ24+0pS
	 kfZ8LOVHfXwTpumpK6tm0tr6F+CxnSzaFL6C7cPG/O25/MAm49C2grq0mitD8CL6Xh
	 denrmS3s46mguFUWhQ6E9jlCirsGKXLiGX9co3tIUNMYuVIzJDNON+/IpaB4oYMaUL
	 +X16byTeHjz0A==
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-697dc263e5fso158215a12.2
        for <cgroups@vger.kernel.org>; Tue, 23 Jun 2026 11:10:44 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ86pZCmzwIrUFydAiatBOpVB/iOzhNe5KcoOF6yGv/1GVd6AQoIEbJpI6vZB6kaOUZ+Y6D1T1P3@vger.kernel.org
X-Gm-Message-State: AOJu0YweVk16fuu2jWVZgUIZnE8YLHX/kJ0P+bDwNAeq2YqEtegFcjze
	xVDCOE5rsw+7BY6qbCs5z2eHHfmSTzpVQmzrKYoVJbwgfVgBRHdirrmLjTFNhv4IkfdF1yvhjIh
	DixigXxNT0bkFLfqQcIycECsLLOJ01Jk=
X-Received: by 2002:a17:906:9f8a:b0:c0e:4007:8d94 with SMTP id
 a640c23a62f3a-c108ecfa2b1mr236060766b.43.1782238243526; Tue, 23 Jun 2026
 11:10:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ajnIasdb6j6yDUdy@google.com> <20260623004018.1864121-1-joshua.hahnjy@gmail.com>
In-Reply-To: <20260623004018.1864121-1-joshua.hahnjy@gmail.com>
From: Yosry Ahmed <yosry@kernel.org>
Date: Tue, 23 Jun 2026 11:10:32 -0700
X-Gmail-Original-Message-ID: <CAO9r8zOQQwDxmHGsRw_9k2eu6r=HU_HiXxbB4cbpwhc1GGgHOw@mail.gmail.com>
X-Gm-Features: AVVi8CeHkJg-OCEUnLamzkS0g71Y0U9F0-dgswBYdQt5v8lrD2Rr2s34MhEXIG4
Message-ID: <CAO9r8zOQQwDxmHGsRw_9k2eu6r=HU_HiXxbB4cbpwhc1GGgHOw@mail.gmail.com>
Subject: Re: [PATCH v9 3/6] mm: memcontrol: add interface for swap tier selection
To: Joshua Hahn <joshua.hahnjy@gmail.com>
Cc: Youngjun Park <her0gyugyu@gmail.com>, Shakeel Butt <shakeel.butt@linux.dev>, 
	akpm@linux-foundation.org, chrisl@kernel.org, youngjun.park@lge.com, 
	linux-mm@kvack.org, cgroups@vger.kernel.org, linux-kernel@vger.kernel.org, 
	kasong@tencent.com, hannes@cmpxchg.org, mhocko@kernel.org, 
	roman.gushchin@linux.dev, muchun.song@linux.dev, shikemeng@huaweicloud.com, 
	nphamcs@gmail.com, baoquan.he@linux.dev, baohua@kernel.org, gunho.lee@lge.com, 
	taejoon.song@lge.com, hyungjun.cho@lge.com, mkoutny@suse.com, 
	baver.bae@lge.com, matia.kim@lge.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-17196-lists,cgroups=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:joshua.hahnjy@gmail.com,m:her0gyugyu@gmail.com,m:shakeel.butt@linux.dev,m:akpm@linux-foundation.org,m:chrisl@kernel.org,m:youngjun.park@lge.com,m:linux-mm@kvack.org,m:cgroups@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:kasong@tencent.com,m:hannes@cmpxchg.org,m:mhocko@kernel.org,m:roman.gushchin@linux.dev,m:muchun.song@linux.dev,m:shikemeng@huaweicloud.com,m:nphamcs@gmail.com,m:baoquan.he@linux.dev,m:baohua@kernel.org,m:gunho.lee@lge.com,m:taejoon.song@lge.com,m:hyungjun.cho@lge.com,m:mkoutny@suse.com,m:baver.bae@lge.com,m:matia.kim@lge.com,m:joshuahahnjy@gmail.com,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[yosry@kernel.org,cgroups@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[24];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[gmail.com,linux.dev,linux-foundation.org,kernel.org,lge.com,kvack.org,vger.kernel.org,tencent.com,cmpxchg.org,huaweicloud.com,suse.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[yosry@kernel.org,cgroups@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,vger.kernel.org:from_smtp,mail.gmail.com:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 503EA6B9604

On Mon, Jun 22, 2026 at 5:40=E2=80=AFPM Joshua Hahn <joshua.hahnjy@gmail.co=
m> wrote:
>
> On Mon, 22 Jun 2026 23:46:31 +0000 Yosry Ahmed <yosry@kernel.org> wrote:
>
> > > > > If that is the case, I think auto-scaling makes sense but can be =
a bit
> > > > > tricky, since there is no universal tiered ratio; each workload w=
ill
> > > > > have different tiers it can swap to, so they will all have to cal=
culate
> > > > > their own ratios. Tiered memory limits escapes this difficulty si=
nce we
> > > > > assume all memory can be placed on all tiers, so we have a system=
-wide
> > > > > ratio : -)
> > > >
> > > > Hmm I don't follow. It's also possible (maybe not initially) that a
> > > > memcg cannot use specific memory tiers, right? I am not sure what t=
he
> > > > difference is.
> > >
> > > You're right, I was speaking more to the current state of memory tier=
s.
> > > The majority of the feedack I received was that we already have too
> > > many memcg knobs, so I just opted to make tiered memcg limits a
> > > cgroup mount, with no ability for individual memcgs to tune their
> > > limits or opt-in/out.
> >
> > Right, I think this is similar to the approach taken here. We have a
> > single interface for per-tier limits. The main difference is that we're
> > allowing 0/max values to disable/enable different swap tiers per-memcg,
> > as there's a use case for that.
> >
> > Seems like for memory tiering there's no use case for that yet.
>
> Yes, I would agree with that.
>
> > > What do you think Yosry? Would it make sense for us to be able to
> > > tune these values? Personally I think it makes sense but just wanted =
to
> > > make the basic features merged before I went to push for making those
> > > knobs tunable.
> >
> > Right now we're not proposing to allow tuning swap tier limits either,
> > just enable or disable a tier. My main question is about the default
> > values.
> >
> > IIUC, for memory tiering, if you set memory.max, then the limits for
> > tiers are auto-scaled. I think it makes sense to do the same for swap
> > tiers for cosnsitency. Or am I wrong about the memory tiering limits
> > behavior?
>
> No, you're right about that. Sorry for steering the thread to my
> series ; -)
>
> To get back to the question of how the auto-tuning should work, the
> main question is to which ratio we scale the swap limits to.
> Do we set the swap limits proportional to how much swap is present
> in the system, or how much swap is available to the cgroup?
>
> So if we have 3 swap tiers A, B, C, with 50G, 30G, and 20G capacity
> respectively, how much should a cgroup with swap.max =3D 10G have if
> it is limited to tiers A and B?
>
> This is what I was getting at earlier when I said we have to calculate
> different ratios for different cgroups, based on what tiers they have
> access to.

That's a good question. I think the case that is particularly
interesting is whether or not the limits of other tiers should change
when another tier is disabled/enabled.

So basically in your example, assuming everything starts as "max",
when swap.max is set to 10G, the autoscaled limits would be: (tier A,
5G), (tier B, 3G), (tier C, 2G). Now the question becomes, if
userspace sets the limit of tier C to 0, should the limits for tiers A
and B change?

On one hand, it's simpler to just keep the autoscaled limits unchanged
in this case. However, this means that the effective swap limit is now
8G, which is not great :/

The alternative is to recalculate all the limits when one of them
changes, in which case the limits of A and B would change to 6.25G and
3.75G. But I don't know if this will work well if we allow custom
limits. What happens if the limit of tier C is written as 1 (or 4096)
instead of 0? It's effectively the same scenario, but the tier is
technically allowed.

The more I think about it, the more I realize it may be best to drop
the autoscaling thing. I imagine memory tiering might run into similar
issues too :/

