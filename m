Return-Path: <cgroups+bounces-17737-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id lIO2ICAbVWoLkAAAu9opvQ
	(envelope-from <cgroups+bounces-17737-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Mon, 13 Jul 2026 19:06:40 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D248174DDC4
	for <lists+cgroups@lfdr.de>; Mon, 13 Jul 2026 19:06:39 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=AYCp8QaH;
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-17737-lists+cgroups=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="cgroups+bounces-17737-lists+cgroups=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3E4F6308962F
	for <lists+cgroups@lfdr.de>; Mon, 13 Jul 2026 17:03:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03F3D31B828;
	Mon, 13 Jul 2026 17:03:11 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72931327BFB
	for <cgroups@vger.kernel.org>; Mon, 13 Jul 2026 17:03:09 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783962190; cv=none; b=VyzmreFEV97ng9E2BGoWhU9bokpiwpituMUJg50JVTSFBGit2rgb6eMZpz88qYYfMosDB11CVNyDd6ezChrs03AtPICWEU6+g+oKaJnQyUBHWhgUXp6maTNKVTRuGoHU3WnJ3tyQnwe5WVwsBybz5g1K/RfVEvEYeIzF9E7WiJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783962190; c=relaxed/simple;
	bh=b1Fet5nEZQV4MMt5es7fTqGCTp56uk9Hiy8cY68X9Rw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dIPYw7VQF+HqDOirYyL8I6VIBBjHQlzeEwFj+IfPdnn9CtFsbb5OTy9W/to7rLvgoO7IETfQVxIeHOwJu5FaCyg5QNS4Cb/WinjKcV2HFg7eTrq/iiXf85wOawg8ry8g+fNbz0/bEhd1HIgD/1OVhzU+XBcx6hHW0pHKJ9iONJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AYCp8QaH; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31F571F0155D
	for <cgroups@vger.kernel.org>; Mon, 13 Jul 2026 17:03:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783962189;
	bh=b1Fet5nEZQV4MMt5es7fTqGCTp56uk9Hiy8cY68X9Rw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=AYCp8QaHGQp4HpDW9tcdGQ/O2AXHYUzGChVx26and5GjAlRRHJZcg7TKm912W7Hwg
	 XNEOhE7YKIq39WGfj2kauuHEKY/8b4XAPz/otPi6rhDCYYzp43BvMArpN1gZUdvhyK
	 xxaktNKL04Do4l4dFitcSfmnHigokjgJ9PO7o1A4piIBMJxUDQ8CDOXcLnbMblBeDS
	 yColU5Sk31bHrN5ewUCpyq43OyEjB9ZP24GONX/q2KXGwO6tqW8LUoSKWUyDnJLm/c
	 zhlRFbm4E2DLmJa39omopyFjhvOEGwQG9qo+zpQr993guhbZiVZifl7e/9P8cuje/u
	 Vu/Ppdyg9ryWw==
Received: by mail-yx1-f46.google.com with SMTP id 956f58d0204a3-667f1390f58so1224108d50.1
        for <cgroups@vger.kernel.org>; Mon, 13 Jul 2026 10:03:09 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RpthL5LOSCa9i17pdOSt+NFhcEgyX6Y/9hglEVOo9wpaST32VoQyZAvUwHzNgmG0OKL0FELMi0+@vger.kernel.org
X-Gm-Message-State: AOJu0YxE5eoPAh2iJAEkELyJmQZNjGiRnPBkkEnk54rEgaPnt2oICpY5
	jcQSn0ppS1k0JmV79czLlLtV/LVe9fSkPeKdaI/2hVJWStaxubFGQ+b4QqxhS3uuYFuetV43lFv
	wzD1frNZN/OcKbWutRxfhJwDJjQgm4H3YHPA5NqZTPg==
X-Received: by 2002:a05:690e:d48:b0:660:db62:a47e with SMTP id
 956f58d0204a3-667d7c541f7mr6018869d50.65.1783962188491; Mon, 13 Jul 2026
 10:03:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260713025644.170839-1-youngjun.park@lge.com>
 <CAO9r8zNJfhirbzvJzDWRaBQOM7XZcf_Jk0Bz=Y4dB4QK4W-MwQ@mail.gmail.com>
 <alUK8DWRy4LPxTpY@yjaykim-PowerEdge-T330> <CAO9r8zPvWKgQ8+ABxSnVnC452-enyMqCjBTA4pfNDVxsoJr25g@mail.gmail.com>
In-Reply-To: <CAO9r8zPvWKgQ8+ABxSnVnC452-enyMqCjBTA4pfNDVxsoJr25g@mail.gmail.com>
From: Chris Li <chrisl@kernel.org>
Date: Mon, 13 Jul 2026 10:02:56 -0700
X-Gmail-Original-Message-ID: <CACePvbX1U3pLRqCP-k9x9bvbn+sXCexnbqXjwXcdvwbH+qD6sA@mail.gmail.com>
X-Gm-Features: AVVi8Ccfpc_dSAJTfLvWvMA3EJHfo11-b7EEEJwmjvmTr2Ua17H4FE4meVFn4TE
Message-ID: <CACePvbX1U3pLRqCP-k9x9bvbn+sXCexnbqXjwXcdvwbH+qD6sA@mail.gmail.com>
Subject: Re: [PATCH v10 0/6] mm/swap, memcg: Introduce swap tiers for cgroup
 based swap control
To: Yosry Ahmed <yosry@kernel.org>
Cc: Youngjun Park <youngjun.park@lge.com>, akpm@linux-foundation.org, linux-mm@kvack.org, 
	cgroups@vger.kernel.org, linux-kernel@vger.kernel.org, kasong@tencent.com, 
	hannes@cmpxchg.org, mhocko@kernel.org, roman.gushchin@linux.dev, 
	shakeel.butt@linux.dev, muchun.song@linux.dev, shikemeng@huaweicloud.com, 
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[21];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-17737-lists,cgroups=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:yosry@kernel.org,m:youngjun.park@lge.com,m:akpm@linux-foundation.org,m:linux-mm@kvack.org,m:cgroups@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:kasong@tencent.com,m:hannes@cmpxchg.org,m:mhocko@kernel.org,m:roman.gushchin@linux.dev,m:shakeel.butt@linux.dev,m:muchun.song@linux.dev,m:shikemeng@huaweicloud.com,m:baoquan.he@linux.dev,m:baohua@kernel.org,m:joshua.hahnjy@gmail.com,m:gunho.lee@lge.com,m:taejoon.song@lge.com,m:hyungjun.cho@lge.com,m:baver.bae@lge.com,m:her0gyugyu@gmail.com,m:joshuahahnjy@gmail.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[chrisl@kernel.org,cgroups@vger.kernel.org];
	FREEMAIL_CC(0.00)[lge.com,linux-foundation.org,kvack.org,vger.kernel.org,tencent.com,cmpxchg.org,kernel.org,linux.dev,huaweicloud.com,gmail.com];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[chrisl@kernel.org,cgroups@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: D248174DDC4

On Mon, Jul 13, 2026 at 9:01=E2=80=AFAM Yosry Ahmed <yosry@kernel.org> wrot=
e:
> > My plan is to land the swap tier infrastructure together with the
> > first use case (cgroup-based swap control) first, and then follow
> > up with zswap tier support in a subsequent series, continuing the
> > discussions we've had above.
> > (I mentioned on cover letter, right above the overview section)
> >
> > Does that approach sound reasonable to you?
>
> How does swap tiering work with zswap in the current series? I assume
> zswap is just enabled for all devices in all tiers? I wonder if

Zswap is not part of the tiers exactly because it sits in front of all
swap devices (tiers) and uses a different control to enable or disable
it.
Let's not combine these two; let zswap use its own existing cgroup
control interface.

> introducing zswap as a tier after the fact changes user-visible
> behavior. I guess if zswap will be introduced with a default "max"
> value it will more-or-less be the same behavior, but I would check all
> user-visible behaviors related to zswap (e.g. interaction with other
> zswap interfaces) to make sure nothing breaks or changes in a
> meaningful way when zswap is introduced as a tier later.

Zswap will not be introduced as a tier. The existing user interface
makes zswap not exactly compatible with the tier ordering because it
sits in front of every swapfile. If we change that, we break the user
interface. I suggest we keep zswap working as it is now.

Chris

