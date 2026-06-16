Return-Path: <cgroups+bounces-17006-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Q8VUJ8CJMWofmAUAu9opvQ
	(envelope-from <cgroups+bounces-17006-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Tue, 16 Jun 2026 19:37:04 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id A94C8693504
	for <lists+cgroups@lfdr.de>; Tue, 16 Jun 2026 19:37:03 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=X3w7nHsy;
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-17006-lists+cgroups=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="cgroups+bounces-17006-lists+cgroups=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 427F63008086
	for <lists+cgroups@lfdr.de>; Tue, 16 Jun 2026 17:31:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A95447CC65;
	Tue, 16 Jun 2026 17:31:14 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFB2547CC70
	for <cgroups@vger.kernel.org>; Tue, 16 Jun 2026 17:31:12 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781631074; cv=none; b=r0W6KCus2fr0t8d9y/uaK87q6FMVw/Y1trrQsq/OWdOdSlYyquIGcnLvLWUHEBMYOBOGh5gyAlWMwre+b7AFUQ03EX4ry51YeAlyJr8XQRSNbLnXy2yCg5FE1ojFooPoBkNG2m36N0CabaJlSw3S1paBLdBeaxskuMikgwCCzMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781631074; c=relaxed/simple;
	bh=mt02T4z9f7+XK5ajTyVeoT4jFvKdSNSRb9us67dAKwo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=a7jM+XOh1T2HaFN1lbKtdqpTjuypQSFdKeDKW/r3oYLmVXLV2JtmOfDb6Fki/Sw/6wSvwf+eXJISSzntCWz2ndSxy2BNxl8kmyQPHBRMEU3A7L6ujPju+jvWdNa1QvVwzZfe5QEGAd29raYOpOxvZZ+FyvAEt09XG0x1utZq+bk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X3w7nHsy; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D752B1F00ACF
	for <cgroups@vger.kernel.org>; Tue, 16 Jun 2026 17:31:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781631072;
	bh=WVV5qnuazsXM93UQJWpV+Y+mNZmy8LyDox+BmjJrU+s=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=X3w7nHsydopsmdHj7nw/UjEnhvA8C3Ys92eDGlhDu56KnfPGiKAbcDzMVjXVqenRa
	 M9+Dykl9JYHalHKhzgcSs1DxvUNs1jHlLudUM7yfd4kBJCM5cQmibGJ1aevI3nefOc
	 BK4CDHfvJt2hSsRez+hKODMSxteaZU4AxKTqdf/Wg2km31eyZLwFjHLITy76tfQGKc
	 VAy6cnS+V4QHSQnQjxghRjHvXhiDwbl+kEhNjGg9Jzi1OgttdCPhQsBXGyggxXMoBh
	 NuhYd+woC/Pgbzax5ckIZxKRnqNnIQz30GP9HzzX6B/x4RR5RBo/cwwRjwZIk3ZCbS
	 jyZ05mURd8GmQ==
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-bebac79fff8so604303166b.0
        for <cgroups@vger.kernel.org>; Tue, 16 Jun 2026 10:31:12 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ/UvgowyPnjRe/HKQpFAX9oP+buXhVj1H1RFu9A64BsMS+2BwgCFXFKPedGKpmQ6ewdWca5vomH@vger.kernel.org
X-Gm-Message-State: AOJu0YyCx975rBLNZyrmuZYrtjDN8CGfq1ZAUIO/EhhzviPy6l6X9UfN
	WA6ZJ5/THX3iWfT06qs1BxpdrFPVkqU8K4Lf15I+2Neuzuv9cEurw2COergHPaS08xdVK0G/R+W
	AKQ9B2cTiQYvJi0YNw1qzj2VVFtIyIS4=
X-Received: by 2002:a17:907:c1a:b0:beb:b53d:4839 with SMTP id
 a640c23a62f3a-c05a6bd7018mr44427666b.33.1781631071598; Tue, 16 Jun 2026
 10:31:11 -0700 (PDT)
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
In-Reply-To: <ajC+FNpkVpI4pbBz@yjaykim-PowerEdge-T330>
From: Yosry Ahmed <yosry@kernel.org>
Date: Tue, 16 Jun 2026 10:30:59 -0700
X-Gmail-Original-Message-ID: <CAO9r8zMimM8n54BL1viuX3pYzO=wzQU89LhCF1HW0bAv97ZQtg@mail.gmail.com>
X-Gm-Features: AVVi8CfvlTpa8wwRc_d-snmqbqbbbY8sLFpgryNiKy5mHm820TJFiip5SD6Te9E
Message-ID: <CAO9r8zMimM8n54BL1viuX3pYzO=wzQU89LhCF1HW0bAv97ZQtg@mail.gmail.com>
Subject: Re: [swap tier discussion] Re: [PATCH v3 2/4] mm/zswap: Implement
 proactive writeback
To: YoungJun Park <youngjun.park@lge.com>
Cc: Shakeel Butt <shakeel.butt@linux.dev>, Hao Jia <jiahao.kernel@gmail.com>, 
	Johannes Weiner <hannes@cmpxchg.org>, mhocko@kernel.org, tj@kernel.org, mkoutny@suse.com, 
	roman.gushchin@linux.dev, Nhat Pham <nphamcs@gmail.com>, akpm@linux-foundation.org, 
	chengming.zhou@linux.dev, muchun.song@linux.dev, cgroups@vger.kernel.org, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
	Hao Jia <jiahao1@lixiang.com>, chrisl@kernel.org, kasong@tencent.com, 
	baoquan.he@linux.dev, joshua.hahnjy@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[21];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-17006-lists,cgroups=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:youngjun.park@lge.com,m:shakeel.butt@linux.dev,m:jiahao.kernel@gmail.com,m:hannes@cmpxchg.org,m:mhocko@kernel.org,m:tj@kernel.org,m:mkoutny@suse.com,m:roman.gushchin@linux.dev,m:nphamcs@gmail.com,m:akpm@linux-foundation.org,m:chengming.zhou@linux.dev,m:muchun.song@linux.dev,m:cgroups@vger.kernel.org,m:linux-mm@kvack.org,m:linux-kernel@vger.kernel.org,m:linux-doc@vger.kernel.org,m:jiahao1@lixiang.com,m:chrisl@kernel.org,m:kasong@tencent.com,m:baoquan.he@linux.dev,m:joshua.hahnjy@gmail.com,m:jiahaokernel@gmail.com,m:joshuahahnjy@gmail.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[yosry@kernel.org,cgroups@vger.kernel.org];
	FREEMAIL_CC(0.00)[linux.dev,gmail.com,cmpxchg.org,kernel.org,suse.com,linux-foundation.org,vger.kernel.org,kvack.org,lixiang.com,tencent.com];
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
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,lge.com:email,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: A94C8693504

On Mon, Jun 15, 2026 at 8:08=E2=80=AFPM YoungJun Park <youngjun.park@lge.co=
m> wrote:
>
> ...
> > - "zswap tier only": Only zswap is allowed. Fallback to other swap is
> >   blocked.
> > - "zswap writeback disabled": zswap is allowed, but if zswap_store()
> >   fails, pages can still fall back to other swap devices.
>
> Upon double-checking the code, my previous clarification was wrong.
> You are right. Sorry for the confusion. "zswap tier only" is indeed
> equivalent to "zswap writeback disabled".
> (I'm not sure why I read the code that way...)
>
> As I initially thought, it might be possible to replace the zswap writeba=
ck
> control with the tiering mechanism.
>
> If we need to keep the existing interface, we can integrate or share the
> underlying logic (though the specific details need more thought anyway).
>
> It can be summarized as follows:
>
> - "zswap tier only" + "zswap writeback disable" -> meaningless (noop)
> - "zswap tier only" + "zswap writeback enable" -> meaningless (no writabc=
k backend exist)
> - "zswap tier with other tiers" + "zswap writeback disable" -> uses only =
zswap
>   (can be replaced by "zswap tier only". This code could be intergrated, =
modified or something.)
> - "zswap tier with other tiers" + "zswap writeback enable" -> works as is

Hmm we might want to somehow disable memory.zswap.writeback if tiering
is enabled, to avoid having to deal with this. But I am not sure how
possible this is.

If swap tiering is behind a config option, maybe we can disable
memory.zswap.writeback under that config option? But then if distros
start enabling the config option it might break some users. Not sure
what's the right way to do this, but having both interfaces active at
the same time is annoying.

>
> As mentioned in the previous email, the zswap tier on/off control comes a=
s a
> bonus (though, as you pointed out, we may need to discuss if it's actuall=
y
> needed).
>
> BR,
> Youngjun

