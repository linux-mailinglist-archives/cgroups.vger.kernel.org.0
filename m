Return-Path: <cgroups+bounces-17655-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 4NIfGus5UWogBAMAu9opvQ
	(envelope-from <cgroups+bounces-17655-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Fri, 10 Jul 2026 20:28:59 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C11373D5DD
	for <lists+cgroups@lfdr.de>; Fri, 10 Jul 2026 20:28:59 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b="kK/1O+W3";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-17655-lists+cgroups=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="cgroups+bounces-17655-lists+cgroups=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 724D03041A2C
	for <lists+cgroups@lfdr.de>; Fri, 10 Jul 2026 18:25:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0F4C37B409;
	Fri, 10 Jul 2026 18:25:15 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F2D737702C
	for <cgroups@vger.kernel.org>; Fri, 10 Jul 2026 18:25:14 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783707915; cv=none; b=CRQp/LDQlQcKGlaaAZE645DZJ40+1FGq5yVsnLpsHevn/3eNJ/uzp7XjBjezOTmLEb5mmRk733lfYxCBQWJpLz4X8U2syKAW9rs0FQGLq86cQfq1nY2FtHWl/8ous4QqSu1CgomZsH0N5GipdcAjJ3lJrLlmrztfO24NpVoxeJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783707915; c=relaxed/simple;
	bh=ZZekBbFA9NhngbLYIVC+8htxKlJKsz67NZnwnFVfRBM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gVldqJELEgK8uaS/cMUK3CW9znsESdAbC514xym7aluwH3Kb2GIxUBkGsaLQATYoeJXfgv7EFVzaUAxRLTTgGy9/iYE3A/KkWAIvbJOqQd4pS6BzrNJID3NmEZ4JSg6XowZZpIdeIK7rTUSdbgF7Yl3tGH0xmtiZVopgyhRrbks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kK/1O+W3; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E9CB1F00A3A
	for <cgroups@vger.kernel.org>; Fri, 10 Jul 2026 18:25:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783707914;
	bh=ZZekBbFA9NhngbLYIVC+8htxKlJKsz67NZnwnFVfRBM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=kK/1O+W3osF9lgM9cCR2fSLVCuFSKquZMb8a81GQnUuMXdBkPWJLYf3vkFk2v9aOx
	 Rq5g37N3VKaT96KU0NhGdys6TP1Zmwo24/ML6c3wsJXjRNZ6mPZTJI8PcUcf+INeR/
	 oRkxx3luKCThwCDDcc/+HGxyaUYQP3QcZ/OIesIm+aUSkP3CkLha7AVUQQ/q0CBGTF
	 f6k3SVvuGRznyd6r3MaQG4xDKKa82O92etN9/H3UJux64t2wexnmSRle2dioIGtXiK
	 6mQ4VXDL1PsditNjwJwTrO4in52ocoOunKlX966sM1PVKUDeWB9OGB5hVdB0EBTMs4
	 BV2VdAHMRH1CA==
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-698b6c87884so2024445a12.2
        for <cgroups@vger.kernel.org>; Fri, 10 Jul 2026 11:25:14 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RpTdcbpClEg12WMq6fCQN8Cecy1BEnoeHrzRr/M8wrpvM+YyUmgIL4qtT2i+COidQYZTG3jxlgw@vger.kernel.org
X-Gm-Message-State: AOJu0YxbKH5YLU3bU253HbrIGnuD/NvKjeBqb4eFQZGTGL1fGdpFKOsG
	PNAq5FW/PqgJ+H8uhLNnY5HAjlmXPNObhanKUJIWlWXGbbzUeOXSxDkxorNXV9J8trNe1OcjcIQ
	hRxjvj80+1NSm+36egoUOCUd51RoiQKM=
X-Received: by 2002:a17:907:26c8:b0:c12:6cdf:6071 with SMTP id
 a640c23a62f3a-c15cdecfa6amr810724166b.4.1783707913208; Fri, 10 Jul 2026
 11:25:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <c0970cee-42c2-4844-b88e-229853f08e90@linux.dev>
 <CAO9r8zNJh65SZzdW8Cc8_8N5Wr+ORuRtU3kuaAX_DhLaESFYTA@mail.gmail.com>
 <CAKEwX=MMXdq7KTzcEgXfNt2L-eTmAVa+nijdyiujVOAhXQsHSg@mail.gmail.com>
 <CAO9r8zO-nAys0PJfXVRwLgAzwJLa9KxpMXKQKXJR7cnYKgmhRQ@mail.gmail.com>
 <CAKEwX=M7axSs2FJDq0KF3GBDpd6G0J=gP_2boUJraNf8M2n3Bw@mail.gmail.com>
 <CAO9r8zM8qk9g6+B6GiCV3oytjViMTEhbr0KjrccU+bF4+PMfTA@mail.gmail.com>
 <ak6c2TaOlcGxZ2Ih@localhost.localdomain> <CAO9r8zPiOyri2wVxRvB0bwEXf9bCKoPsQmRzOpj01XozA8hqUw@mail.gmail.com>
 <CAKEwX=PLauANTu8nDLbDmViQ6u9gvh7HbKffUAzUXuBa6Jes=g@mail.gmail.com>
In-Reply-To: <CAKEwX=PLauANTu8nDLbDmViQ6u9gvh7HbKffUAzUXuBa6Jes=g@mail.gmail.com>
From: Yosry Ahmed <yosry@kernel.org>
Date: Fri, 10 Jul 2026 11:25:00 -0700
X-Gmail-Original-Message-ID: <CAO9r8zPiK44=LA4bzyS=WA1irGFL-YCKmz7u70v-ddEVj5-zSw@mail.gmail.com>
X-Gm-Features: AVVi8Cclh0zv6h_QCsnP6fSkY8HFOsG8hOvjUqUDiHIONAoQflK4FdYIabyurfE
Message-ID: <CAO9r8zPiK44=LA4bzyS=WA1irGFL-YCKmz7u70v-ddEVj5-zSw@mail.gmail.com>
Subject: Re: cgroup/test_zswap failed with "zswpout does not increase after
 test program"
To: Nhat Pham <nphamcs@gmail.com>
Cc: =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>, 
	Zenghui Yu <zenghui.yu@linux.dev>, linux-mm@kvack.org, cgroups@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
	hannes@cmpxchg.org, chengming.zhou@linux.dev, tj@kernel.org, 
	Shuah Khan <shuah@kernel.org>, mhocko@kernel.org, 
	Roman Gushchin <roman.gushchin@linux.dev>, Shakeel Butt <shakeel.butt@linux.dev>, 
	Muchun Song <muchun.song@linux.dev>, Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:nphamcs@gmail.com,m:mkoutny@suse.com,m:zenghui.yu@linux.dev,m:linux-mm@kvack.org,m:cgroups@vger.kernel.org,m:linux-kselftest@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:hannes@cmpxchg.org,m:chengming.zhou@linux.dev,m:tj@kernel.org,m:shuah@kernel.org,m:mhocko@kernel.org,m:roman.gushchin@linux.dev,m:shakeel.butt@linux.dev,m:muchun.song@linux.dev,m:akpm@linux-foundation.org,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[16];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER(0.00)[yosry@kernel.org,cgroups@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-17655-lists,cgroups=lfdr.de];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[yosry@kernel.org,cgroups@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 0C11373D5DD

On Fri, Jul 10, 2026 at 10:30=E2=80=AFAM Nhat Pham <nphamcs@gmail.com> wrot=
e:
>
> On Wed, Jul 8, 2026 at 12:08=E2=80=AFPM Yosry Ahmed <yosry@kernel.org> wr=
ote:
> >
> > On Wed, Jul 8, 2026 at 12:00=E2=80=AFPM Michal Koutn=C3=BD <mkoutny@sus=
e.com> wrote:
> > >
> > > On Tue, Jul 07, 2026 at 02:49:56PM -0700, Yosry Ahmed <yosry@kernel.o=
rg> wrote:
> > > > I would honestly rather use more memory. I think there might be cas=
es
> > > > where the flusher is delayed. The flush being slightly delayed is n=
ot
> > > > technically a bug that we want to see a failure for, but if a large
> > > > stats change is not visible that's a user-noticeable behavior that =
we
> > > > want a failure for.
> > > >
> > > > WDYT?
> > >
> > > There's already the (recent) page size-based scaling, so the idea wit=
h
> > > nr_cpus scaling could make the selftest useful on wider range of setu=
ps
> > > (even page size can be considered as a slight implementation detail
> > > leak, thus the justification of nr_cpus dependency).
> > >
> > > Also, I still think that internally the threshold should be changed t=
o
> > > the "harmonic" formula [1] but the selftest can go with the linear
> > > dependency for more pronounced effects.
> >
> > Yeah I agree the threshold formula can be improved, but we need to
> > make sure performance doesn't regress.
>
> Yeah that's a separate discussion indeed. For now I'm fine with fixing
> the selftests by using more memory.
>
> Is there a good generic formula for this? I understand there will be
> hardcode values, but at least making it scalable (by how much memory
> we have, page size, # of cpus) if possible? :)

The rstat formula depends on the number of CPUs and a constant factor
(see memcg_vmstats_needs_flush()), but this formula is for the number
of updates (e.g. number of pages reclaimed), and that value will
decrease as the page size increases. So I think we want to scale with
both the page size and the number of CPUs. The amount of memory in the
system is not a factor for now.

