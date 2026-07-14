Return-Path: <cgroups+bounces-17810-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id gL4bF1jCVmqcAwEAu9opvQ
	(envelope-from <cgroups+bounces-17810-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Wed, 15 Jul 2026 01:12:24 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id AA6AE7595A4
	for <lists+cgroups@lfdr.de>; Wed, 15 Jul 2026 01:12:23 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=hkF3lJ4I;
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-17810-lists+cgroups=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="cgroups+bounces-17810-lists+cgroups=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0700F316E65F
	for <lists+cgroups@lfdr.de>; Tue, 14 Jul 2026 23:09:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8166418A4A;
	Tue, 14 Jul 2026 23:09:31 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E7CC42BE91
	for <cgroups@vger.kernel.org>; Tue, 14 Jul 2026 23:09:26 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784070571; cv=none; b=IOkcWJIc9CL3opd/VsZf43OYbNRJqE2ElqFaiIezifBiSPCE5VZWU8tIoo0XJ/5TkaLiPB3dA9jVc4wifVDKt3kqHzsKaUSe4G71Ip+5rWqVKO6OM3ZwQV3bxrOn+SYIiNHTvSJrC7epZlsq/rGHmLOF8Z3kzw+QqjU9P+Y6IpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784070571; c=relaxed/simple;
	bh=zTCP9dQLXcTz9IAYWhPFQkdJa9zlY0cv+/0cwPrfvbM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LU3mVNdbxKJqNVNy79fVfkRm94ajAIzftJRcE9cTbClE5zTrkrysCErDlBAqO8jKiQ/XdG16HgotI7NGP1ECBoy03/AVzNC3B1RUthM9NGrcDIYQBO24WCPApB9bBI9m8Y9ubHX+MLCmN6esqU8JF3SK4XcN4R8BGi2zzP3IrFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hkF3lJ4I; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 841EA1F000E9
	for <cgroups@vger.kernel.org>; Tue, 14 Jul 2026 23:09:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784070566;
	bh=zTCP9dQLXcTz9IAYWhPFQkdJa9zlY0cv+/0cwPrfvbM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=hkF3lJ4I5+sD2Um3EnhTbYuA1XyIn6jlp2vBMdkj0JuLhaKwlAWYlMQDYWAQXcUr6
	 u6Jc6KglvgMK3wbEmm3zh1OFyngLNjgowaoMLr2qcfbTRQwWy5tmd9hsBUwCc+PsdW
	 FfRE+88yHXmZ1TxKVFgfnw35Tu9XNIQg4fnmdyBxzvglYAf7yi/d/oPrxaOaD7rv77
	 dMSEA30Dy24W6vNnQfkgbw3X9TL5Atd5kvhvYiz3fHNR4muYN265WU+3Qrr7yqRucn
	 zYIUzG1ZW1OPiAGGsN2PS2zDbNJU5loU96l4LZ70WGWeN2rLiRRwefJITYt4fX+7W9
	 N6JfjtsqObceQ==
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-698bf7a1a2dso7163554a12.0
        for <cgroups@vger.kernel.org>; Tue, 14 Jul 2026 16:09:26 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RqYrv3B1cjejVRNX1ruyvT17mF+X0eH2xLd9ZrYOaPSXZUCvAZRyBIQzmcCWSflRLH8TcNE4IIm@vger.kernel.org
X-Gm-Message-State: AOJu0YwnjSDXJx1hWlhZsqI+ufb6wsqzNDJNmnyZkQo10YKf65vZowKS
	7OQUPkwdwBIt96vdgLR8Zws2Fw+witX7hZXOXluJ01Im9hLH0oM03anT38t3LrpLVSfpjRoJe/y
	X4p59NcGjlOOt26RwC8SXnRUc0O43kdg=
X-Received: by 2002:a17:906:99d0:b0:c12:80f5:d841 with SMTP id
 a640c23a62f3a-c16794eaa6bmr42313866b.56.1784070565492; Tue, 14 Jul 2026
 16:09:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260713025644.170839-1-youngjun.park@lge.com>
 <CAO9r8zNJfhirbzvJzDWRaBQOM7XZcf_Jk0Bz=Y4dB4QK4W-MwQ@mail.gmail.com>
 <alUK8DWRy4LPxTpY@yjaykim-PowerEdge-T330> <CAO9r8zPvWKgQ8+ABxSnVnC452-enyMqCjBTA4pfNDVxsoJr25g@mail.gmail.com>
 <alUQ0ksPP00PVwew@yjaykim-PowerEdge-T330> <alae-LIRwEFUjgs1@linux.dev>
 <CAO9r8zNfp-T19cYyZxKHBY-FnmQ_9=fbP4JYPPFgYtUCo5fZyg@mail.gmail.com> <alawYov0c7a0Q6_l@linux.dev>
In-Reply-To: <alawYov0c7a0Q6_l@linux.dev>
From: Yosry Ahmed <yosry@kernel.org>
Date: Tue, 14 Jul 2026 16:09:13 -0700
X-Gmail-Original-Message-ID: <CAO9r8zO-jzWQhuhU2EW9i4XdXHJOb2O41d4Z78PVFpcOJrNVHw@mail.gmail.com>
X-Gm-Features: AUfX_mzvOgW9mqEBogtkiMVNyhRKUN_n3YFXsr1GXqZoCQ_8H3HQwA8JlG7e9w0
Message-ID: <CAO9r8zO-jzWQhuhU2EW9i4XdXHJOb2O41d4Z78PVFpcOJrNVHw@mail.gmail.com>
Subject: Re: [PATCH v10 0/6] mm/swap, memcg: Introduce swap tiers for cgroup
 based swap control
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: Youngjun Park <youngjun.park@lge.com>, akpm@linux-foundation.org, chrisl@kernel.org, 
	linux-mm@kvack.org, cgroups@vger.kernel.org, linux-kernel@vger.kernel.org, 
	kasong@tencent.com, hannes@cmpxchg.org, mhocko@kernel.org, 
	roman.gushchin@linux.dev, muchun.song@linux.dev, shikemeng@huaweicloud.com, 
	baoquan.he@linux.dev, baohua@kernel.org, joshua.hahnjy@gmail.com, 
	gunho.lee@lge.com, taejoon.song@lge.com, hyungjun.cho@lge.com, 
	baver.bae@lge.com, her0gyugyu@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[21];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-17810-lists,cgroups=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:shakeel.butt@linux.dev,m:youngjun.park@lge.com,m:akpm@linux-foundation.org,m:chrisl@kernel.org,m:linux-mm@kvack.org,m:cgroups@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:kasong@tencent.com,m:hannes@cmpxchg.org,m:mhocko@kernel.org,m:roman.gushchin@linux.dev,m:muchun.song@linux.dev,m:shikemeng@huaweicloud.com,m:baoquan.he@linux.dev,m:baohua@kernel.org,m:joshua.hahnjy@gmail.com,m:gunho.lee@lge.com,m:taejoon.song@lge.com,m:hyungjun.cho@lge.com,m:baver.bae@lge.com,m:her0gyugyu@gmail.com,m:joshuahahnjy@gmail.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[yosry@kernel.org,cgroups@vger.kernel.org];
	FREEMAIL_CC(0.00)[lge.com,linux-foundation.org,kernel.org,kvack.org,vger.kernel.org,tencent.com,cmpxchg.org,linux.dev,huaweicloud.com,gmail.com];
	FROM_HAS_DN(0.00)[];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp,mail.gmail.com:mid,linux.dev:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: AA6AE7595A4

On Tue, Jul 14, 2026 at 3:26=E2=80=AFPM Shakeel Butt <shakeel.butt@linux.de=
v> wrote:
>
> On Tue, Jul 14, 2026 at 01:52:14PM -0700, Yosry Ahmed wrote:
> [...]
> > >
> > > Yosry, what is needed to enable zswap as a swap tier? What will be th=
e minimum
> > > requirements for that?
> >
> > From zswap's perspective, we just need to skip zswap is zswap as a
> > tier is disallowed. Could just be a check in zswap_store() similar to
> > the check if zswap is enabled. I am assuming that if a swap tier is
> > disabled, nothing happens to the existing swapped out pages in this
> > tier, but new pages do not get swapped out to it. This is the same
> > behavior that happens if zswap is disabled at runtime.
> >
> > From the tiering perspective, we need to accept "zswap" as a possible
> > tier, or maybe creating it as a tier by default if zswap is configured
> > would be better to avoid handling the case where the user doesn't
> > create a tier for zswap.
>
> Default tier if zswap is configured makes sense. Should zswap be treated =
as
> having 32767 (or maybe 32768) as priority as it sits infront of all swap
> devices today? Also whichever swap tier has priority range containing 327=
67,
> will have zswap in it.
>
> > We also need to disallow zswap being the only
> > tier as that combination cannot work without vswap.
>
> Do we need to do anything explicitly for this? I am assuming in a kernel =
with
> swap tier support, there always exist a swap tier if there is even a sing=
le swap
> device configured i.e. a tier with the full priority range.

At least on the memcg side we need to disallow writing 0 for all tiers
except zswap. Not sure about the global tier configurations.

