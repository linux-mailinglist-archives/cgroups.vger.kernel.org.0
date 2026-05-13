Return-Path: <cgroups+bounces-15915-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GE9yA8XkBGohQQIAu9opvQ
	(envelope-from <cgroups+bounces-15915-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Wed, 13 May 2026 22:53:25 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A4FC453AB30
	for <lists+cgroups@lfdr.de>; Wed, 13 May 2026 22:53:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 6B3E3300C308
	for <lists+cgroups@lfdr.de>; Wed, 13 May 2026 20:53:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C797B384CE4;
	Wed, 13 May 2026 20:53:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U7zBPfOl"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD1BF221DB6
	for <cgroups@vger.kernel.org>; Wed, 13 May 2026 20:53:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778705599; cv=pass; b=EabEsNl3ZXOksmSjE2p4er93zXUJkPwQ99aQMhIY2ypn5R8qULW70FcTUZ5k0fhy3XwvXhBQLnAGhT8bpi4GWdLoFe8ZTfv8NCdfBvH1phI5Qf6qNjHAPGZjpLlLoNJPpHRW8jnV0r6dRgR8GTAIxCYx13YH4V517uN3Cj0685I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778705599; c=relaxed/simple;
	bh=X/DDsGtZ0cVyzetyiZE3huiuNEguykSuxbVV06c2O7A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fp/a9Jk3z9QwBGZEwZljJE5eM3K7MLDWQZ13mTXckiiThC3aIsUjTEM7xrBBZ+3im94XV5JHP7HRU+bz3u8QZKUNyhH8HG3TWMM+ClaD8OOlgwUbjTRoiVk9pfaQzlGDpU0lnhS/386GK9LKFKCfDoKAAm3UBmgYEkNg4RSn860=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U7zBPfOl; arc=pass smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-453903ee4adso6271249f8f.3
        for <cgroups@vger.kernel.org>; Wed, 13 May 2026 13:53:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778705596; cv=none;
        d=google.com; s=arc-20240605;
        b=BVZqtjVAsaXkFCFzj0waK1jBdVXNrBQ1b8PZftyr/3Bp/23cLjeCcOxb5GC2Z28vym
         aOb9NmKqyg0A+hrkhe77lrd5/FlPjxcB2xpj93e5/CPOq9QAzVBXj56l/u6XhVOFKU1l
         KBPwAiVc1fM3IJj2CixQ4csVUSJyRFoT4Akze/hisspL/JPyOVSIdgWI3vnqcXUITtaY
         A3swOBS06TOhyZyQVnQBOrdiR6LP04K4JRvTCthzk0A09hbXlLg5objaMXzohKfC8RbM
         VoajkW7IMVN/2pWEJnPX0db4VrxoWBy1OtJUhZZgMLTRDwXv67lP7Cc1lPSyz8qQEkFK
         AMBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=X/DDsGtZ0cVyzetyiZE3huiuNEguykSuxbVV06c2O7A=;
        fh=CnJheDZ6oVMNSAt0F5BfTZsa0AqQnmjGMI5rIgt3Ts4=;
        b=XzPoF9+3IVqZyuGUKkTD8ORyVqTqZMl9OM6kKgBuFaU9jDKZaPVQ6IUuDEvb/AUrZD
         vpCrfRqzm2ni9ZQLChz77SIk8Mkzo5Kq03MAmxojP6FRQU51hqbDR7qzeXmniT/02ZiS
         FErgjHZEb4tZ2HHIeUy0rXAjTflTRwr7ZGT//rvWhL12AL6xYBGDBj91OsFc/L+YuJt0
         Rh61914Lr28VM5iPiEemCuHRqJA5N8epaC7a3sEkd9icLfOj0YPkC8z/fouSqPN0XnaZ
         tY6wcNgEScRtj1HsPmhhJF9J/Y0HdjYnp8ip2zLpMHXlpCGH4kqBwHF2dqODGmIN/93W
         fcBg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778705596; x=1779310396; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X/DDsGtZ0cVyzetyiZE3huiuNEguykSuxbVV06c2O7A=;
        b=U7zBPfOlzIlVig4kMwRnutsvLYrDV5ksZN2I1v4EmUHsHO/beXMRB2SrBdx2lV+pAW
         QXnIuXQ40RguAWxsmqEqiGHbAMCDdPPY3WnboscD7crzIeL7KgWgVu3/0qBLpdRGjO3y
         6zrl5vvhL20Emg3u3sxXPxCyEdm2fcjmPGpV8L5faOCBI+G253PRKYDs5oiZDKpHUKFL
         KQPKZM+sy5h5Df96HmUVo9usFLDc609+8dbPXIUSvq1eYDMqvCOBgm+3YgkwOHV63rE5
         e/kdUHwtO5oBNc5/N6TOHLa3SksnOWB0L4rwM2tUZo2/4hZS/5IWy+Lr8xQFI6XoZNcN
         FRqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778705596; x=1779310396;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=X/DDsGtZ0cVyzetyiZE3huiuNEguykSuxbVV06c2O7A=;
        b=gU9V5RweZucw+xszxV/q9sjVMNEz/PGu6s9/yNshvWZKoitOV1DvIo5JDsMVKifdnB
         Q3DWV4vOiXyQ2pQk1GW6rGGA2DItQq40x/2LVMMH5AHbCTggMjEVmmuQEx3hO2RKEhLK
         10yuaD1Z0I1OKSJTtwNszEKLnzEpvzvmSqR1DVxE8GrkHToTRLDwAZ4bZ010L27iWm2R
         fQmIwE5Om5lv9G11iGTm1xh6YW485H4tIH1+H38Qbk//fGG8aSkxAkmsz++9sEl7HGpk
         0oax75InqVVqQoTMVGvIv1lnkZRvPLQvEH0oiVxyqkT+o0yazYLB51VHXIgYDwYStFh+
         YF7A==
X-Forwarded-Encrypted: i=1; AFNElJ/imou1vSdji1/6bZjQTimGgx5lkH2KKS3YvKvB2ekVt9jpzCVCjCXiZRsxgM51By8IAMF/4ccf@vger.kernel.org
X-Gm-Message-State: AOJu0YyNXln6hci/PVYumO1PiY7XrYmjltPK7MVRskAK/pXiyaZbEWl7
	IgYm0RLOtfU9I6k1gMUIVzEcHWGBRhP2xYLrmF78ZKaRd/UsoqFPkTCG0bBJDtq/Ukk3nzRB96c
	Q1ByZS32A0UOaCpZjuIqF3IPHWk8uih8=
X-Gm-Gg: Acq92OFGMjaoAg2X7xcR2WHlQghmsHMaEmfchKfAxzKdvf/Dki7QEjW/rWF/8ppjczS
	qqrI4ROTme++nj2maN0xiC8v2NeYtH/lVMpiyLnxKGZsHlDrvtPoJqKAgIAkAsWdwWhlgF0/4nu
	1fvXDbxcho4rhjmeB8AM6dw8RscL9bkP8LSnIswGN//hmlbFbkOhn4yao4iA/W/ZB15hm1GHrC/
	WwLpzcIZ7KPCnSNGu7V9xeNwQf6tvp0QwhiKPWwge3GNc5tMKAeNFtNnQhGvQ2TbE1OPy/u6lb6
	wQKLYIWO2PZmKH2yQsJhlTyfEY6V3/aW/6JYh8M=
X-Received: by 2002:a05:6000:26c3:b0:43d:773d:78ff with SMTP id
 ffacd0b85a97d-45c59bd694dmr7681297f8f.27.1778705595867; Wed, 13 May 2026
 13:53:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260511105149.75584-1-jiahao.kernel@gmail.com>
 <20260511105149.75584-3-jiahao.kernel@gmail.com> <CAKEwX=PLFRkfUvZyaYfwBv0QJ-8KAktvZvGA02Hod04H-RsS-Q@mail.gmail.com>
 <CAO9r8zNOPdpJuTmccvQ6ZAVS+tXxp-_ofA765DbnfaUZOPPO-g@mail.gmail.com>
 <12e4784e-2add-d849-7e54-bde8abfa6e78@gmail.com> <CAKEwX=MOixJAUGiwUcMQa0Stvg-mR-MvpDRD8WA4YMtRvnUYTg@mail.gmail.com>
 <6fc7fdf0-368c-5129-038e-623f9db2aa88@gmail.com> <CAO9r8zPvgB-MG2ufmdn4HoS+QEPBAehU9u7fQmYs+47NF-C9aw@mail.gmail.com>
In-Reply-To: <CAO9r8zPvgB-MG2ufmdn4HoS+QEPBAehU9u7fQmYs+47NF-C9aw@mail.gmail.com>
From: Nhat Pham <nphamcs@gmail.com>
Date: Wed, 13 May 2026 13:53:04 -0700
X-Gm-Features: AVHnY4LrLAgY72ojshBcIFy9xP1PEcHOYQ9m7UQfpzDmpcDw6jERR_OF5Wq4Pko
Message-ID: <CAKEwX=OY_nws-vf3VgnD54G205TK2YjkoAwRCyB9jvW=Oz3PpQ@mail.gmail.com>
Subject: Re: [PATCH 2/3] mm/zswap: Implement proactive writeback
To: Yosry Ahmed <yosry@kernel.org>
Cc: Hao Jia <jiahao.kernel@gmail.com>, akpm@linux-foundation.org, tj@kernel.org, 
	hannes@cmpxchg.org, shakeel.butt@linux.dev, mhocko@kernel.org, 
	mkoutny@suse.com, chengming.zhou@linux.dev, muchun.song@linux.dev, 
	roman.gushchin@linux.dev, cgroups@vger.kernel.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
	Hao Jia <jiahao1@lixiang.com>, Alexandre Ghiti <alex@ghiti.fr>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: A4FC453AB30
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-15915-lists,cgroups=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[17];
	FREEMAIL_CC(0.00)[gmail.com,linux-foundation.org,kernel.org,cmpxchg.org,linux.dev,suse.com,vger.kernel.org,kvack.org,lixiang.com,ghiti.fr];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nphamcs@gmail.com,cgroups@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[cgroups];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Action: no action

On Wed, May 13, 2026 at 11:55=E2=80=AFAM Yosry Ahmed <yosry@kernel.org> wro=
te:
>
> > > Zswap objects are organized into LRU and exposed to the shrinker
> > > interface. Echo-ing to memory.reclaim should also offload some zswap
> > > entries, correct? Are there still cold zswap entries that escape this=
,
> > > somehow?
> > >
> >
> > Yes, the memory.reclaim path does drive some zswap writeback, but
> > it is not enough for our case.
> >
> > 1. For a memcg that has reached steady state (a common case being
> > when memory.current is below the policy target), the userspace
> > reclaimer may not invoke memory.reclaim on it for a long time,
> > and so no second-level offloading happens through
> > memory.reclaim. In this state we want
> > memory.zswap.proactive_writeback to write back entries that
> > have sat in zswap past an age threshold, to further reclaim
> > the DRAM still held by the compressed data.
> >
> > 2. Even when memory.reclaim is running, the fraction of zswap
> > residency that ends up reaching the backing swap device is
> > still very small for many of our workloads, and the userspace
> > reclaimer has no way to participate in or control the
> > granularity of zswap writeback. So in our deployment we prefer
> > to leave the zswap shrinker disabled, decouple LRU -> zswap
> > from zswap -> swap, and use a dedicated proactive-writeback
> > interface that lifts the writeback policy into userspace where
> > it can evolve independently of the kernel.
>
> To be honest I see the point of proactively reclaiming compressed
> memory in zswap. If you use memory.reclaim, you are also reclaiming
> hotter memory in the process, and you are not necessarily getting as
> much writeback as you want. The memory in zswap is a more conservative
> choice for proactive reclaim because it's memory that's guaranteed to
> be cold(ish) and not being accessed.
>
> That being said, the interface is not great any way you cut it :/
>
> I don't like the 'memory.zswap.proactive_writeback' name, maybe we can
> stay consistent by doing 'memory.zswap.reclaim', but that just as
> easily reads as "reclaim using zswap". Maybe
> 'memory.zswap.do_writeback' or something, idk.
>
> I also don't like having two proactive reclaim interfaces, so a voice
> in my head wants to tie this into 'memory.reclaim' somehow, but that
> includes adding a pretty specific argument (e.g. 'memory.reclaim
> zswap_writeback_only=3D1'.
>
> I don't like any of these options, and we also need to consider what
> the memcg maintainers think. I see the use case of proactive writeback
> but I am struggling to come up with a clean interface.
>
> I also think we should take the 'age' aspect out of the conversation
> for now, it can be a separate discussion. Well, unless we decide to
> tie it to memory.reclaim. If memory.reclaim broadly supports age-based
> reclaim then zswap writeback can be a natural part of that without
> requiring a specific interface.

Yeah perhaps extending memory.reclaim is best... Sort of analogous to
the way we have swappiness to balance file v.s anon....

