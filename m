Return-Path: <cgroups+bounces-15778-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wD/PCGczAmrSowEAu9opvQ
	(envelope-from <cgroups+bounces-15778-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Mon, 11 May 2026 21:52:07 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5738D51543F
	for <lists+cgroups@lfdr.de>; Mon, 11 May 2026 21:52:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 22E12301226E
	for <lists+cgroups@lfdr.de>; Mon, 11 May 2026 19:49:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CE9337DE9C;
	Mon, 11 May 2026 19:49:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FIoCoOjr"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79C5337C909
	for <cgroups@vger.kernel.org>; Mon, 11 May 2026 19:49:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778528991; cv=pass; b=ClHgoNuUd2erYFykcKU239iiZ/1GjwjFvbiql+49K3Y89RzUPFZl1rv0C9H4PDEJQJlH/19ozZT1+sfPSLpzOnCImN6aEhwpua1BXSjO5q35qdqm9/gc+UMomMTM6mWXyBK1gIz+hTMCszGTjMGlfCY+eLpNdAYkCpGtxPSnbAY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778528991; c=relaxed/simple;
	bh=sLtCkaQgWPkzthxnv5qVsmODrG8dD2rCKuHgHNedMWA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kkGQvu8d26Xh6uPejBI8wTeciF1W/nGR3YK0bD82N51YODt9P6/HgCkLLnmDnbrkmKw7itU687N7rlp7K0glnmiXd3VynxO2fbJa5nJFEMuqZxZ9W2OtxSVsqQq0DZ4nTPY52PPphorqAfKI1RmdStjqrMuGxIPbWLeYNX6I27s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FIoCoOjr; arc=pass smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4891e86fabeso55614345e9.1
        for <cgroups@vger.kernel.org>; Mon, 11 May 2026 12:49:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778528989; cv=none;
        d=google.com; s=arc-20240605;
        b=D6UNA34N23ic42hHMWek2PtAUkwAHHB82PKxXkEBTwz7tkyMNqDuGMrCWsMpLWZRxR
         5LV/dp2RJ54GBn2mdci4IOdI6e9nKKcr/tD8s6IN5YJn+g5prG91b3cqajnD/QdgZ7wS
         mp/BIZ/kkL8AkuWkRTYRSCpw8EJIKF1lNcF2SJIBiwifi4ET7Otja8EYz6LtpRe7LWsA
         sUyOfaf9u3YLVh/GAak8I2qkSnb+q+e2rNKjyHVqR0U7WRa9C39dBOEZV7YTMbFigenP
         KL4PFDg/zDI5cKUCNsthLZ9S8wTyCk6Ugq03Yt7n2J9C5AE7eUblPTIchbNgNHjmTIOM
         Ji5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=sLtCkaQgWPkzthxnv5qVsmODrG8dD2rCKuHgHNedMWA=;
        fh=Ib6s/8Es6fnXOY51KzQ/X5D1jNUA+HPg8B7wOI8KFDI=;
        b=Ov5aVpEdeuXf6nA3v7iXN4hU1kFytx8sxsjpUXnB+2uIFuUYTUNhL3MC7kZOwriqvS
         HD39xl1kWnGueb0F7iD1Jz/+7SgM1G2G08MpnUu8Qa/usQkeokK+cp+qjwOthDNRfd76
         p57Gc1lSo/1dhjDx2pMb1UnoNhOeduNxtgZcLr8+mxlMIvuaO/z61p0/S4dNHDb70uT2
         EmKzClWX2DwsPHx0RXgCdZRt7C505XPph8iXcjGeqT31o7VGmqv11Yb86vYxqCurT4CY
         HK96fojMkCdBvMMru+f2I3inx3ltWEIqbeQGru8V9Xq72ztdvqGgTYnyljh5PmAteTCO
         x7bg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778528989; x=1779133789; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sLtCkaQgWPkzthxnv5qVsmODrG8dD2rCKuHgHNedMWA=;
        b=FIoCoOjr8Et2NPOK9rRdh1tWUQPmTeIkK1J+12uMnv6VO8S1vcjpHVNAo6pWtWGCIX
         FkrMrzLLYOorTMg1TQO65AOg2D2vfr0GBynwgqqjU31kqieQHjEobqHI1v/mFW0Vgmjn
         ocYxZXBbOpbUgAs5+mFWBlVkjLVRZfxb0JsEVLB3ycIgYN57bgURZMp+CvOwSPhyUXNN
         jCOwHhy6BjNvlbTH2SNYBThPrBaiuBaY/lasoZSYXzdlSA86eUBL17LGxo9crPNzhKAe
         6HzPSHRCmAAHDrr33dOAgb3kPYTuCaGqcE9KdKhqWUDmu3uXRqs9c4RQP9bsUVBEkNGv
         fzdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778528989; x=1779133789;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=sLtCkaQgWPkzthxnv5qVsmODrG8dD2rCKuHgHNedMWA=;
        b=Sk8oy/ODGftr8++ZKLWpxCLmp29WI2KbY8YZ6MIE56V442QEK5LnajK7znk/g8CArD
         +I0YgQfnkT3NcBt57P34YbiYI795/g7fGiwIJmdU2Eh6w4X4b50dg/JgjrgCJ4kE8vmO
         xyOt6ydg3D07nZ4Ux6CpWYFGi0v8HJv9GEo2mjzfwexBtR3pppthncuOl45bywQNLyGh
         fP15GxX50OktLRQ4qnuJTXyNbEMQsKyi/DKJvl5DFLShl5c3/yUGH6G1cw7Vh0nk3UyD
         2UEcH+667fDPo6c9ccHHLTLTSDZwCF3q0z3dVOuUyoyZX2E8Mqn8sOyN8AZJDZXde6pb
         8faw==
X-Forwarded-Encrypted: i=1; AFNElJ8HixIzM7bBj7Dq0+yfYBwBCktrMF3g16yR/ZEGr/faY2zWN9FQjhRMnYPh3ac0Y4RSK00QW2YF@vger.kernel.org
X-Gm-Message-State: AOJu0YyWXQzxSDQVVpeISWEi+ZysnEPD0qbB6gkaz387AfJVf8wrBPw2
	uIDY4iOi80hORovn5kJ5YA1Wryth6rwQiHTBYUs+W3N23XZbxWWgHcTg3SgOIBP5Ey3bpp11F8y
	J/frVeRTWwvnGNpVbYBK2h8yiqo5Lt68=
X-Gm-Gg: Acq92OEsAMP8W84K+YPuGLLz098I16yCParV+CV7rdRlpVGOXkegkTjkvpJxFnYyKx7
	He4LWmsxjESbWyiUqX/92N4+DOEwGpPGK7oE1ZCNK/GyL0e8EpRCyuZottryn7Ze6gx3xE8PG6P
	QekW0hvB9NNq7P1dcXi0mLzVgMY5NIJn7P/OuwpzgrKGBlXv9rEsUZNh77mi3w5DSu7OgUO2lYz
	BVlTuV9NxzDB/xPD59wUWOdnuAlqoRQUFlIw3INtMspT2FZrpTH+I/O+f5CRxSwR++PKqvjQrfs
	Ju2pfhR8uspItERKKxDDGP0Lu+Xo8NhK/A/bSXE=
X-Received: by 2002:a05:600c:811a:b0:483:7903:c3b1 with SMTP id
 5b1f17b1804b1-48e51f35d0emr397154915e9.20.1778528988744; Mon, 11 May 2026
 12:49:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260511105149.75584-1-jiahao.kernel@gmail.com> <20260511105149.75584-3-jiahao.kernel@gmail.com>
In-Reply-To: <20260511105149.75584-3-jiahao.kernel@gmail.com>
From: Nhat Pham <nphamcs@gmail.com>
Date: Mon, 11 May 2026 12:49:37 -0700
X-Gm-Features: AVHnY4I9GBoH8u6REGeCnHXPx0lUVTypdoFFrsJzoLRc-jRCyv8oiTQYgsYV84I
Message-ID: <CAKEwX=PLFRkfUvZyaYfwBv0QJ-8KAktvZvGA02Hod04H-RsS-Q@mail.gmail.com>
Subject: Re: [PATCH 2/3] mm/zswap: Implement proactive writeback
To: Hao Jia <jiahao.kernel@gmail.com>
Cc: akpm@linux-foundation.org, tj@kernel.org, hannes@cmpxchg.org, 
	shakeel.butt@linux.dev, mhocko@kernel.org, yosry@kernel.org, mkoutny@suse.com, 
	chengming.zhou@linux.dev, muchun.song@linux.dev, roman.gushchin@linux.dev, 
	cgroups@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org, Hao Jia <jiahao1@lixiang.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 5738D51543F
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-15778-lists,cgroups=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[16];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nphamcs@gmail.com,cgroups@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[cgroups];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,lixiang.com:email,mail.gmail.com:mid]
X-Rspamd-Action: no action

On Mon, May 11, 2026 at 3:52=E2=80=AFAM Hao Jia <jiahao.kernel@gmail.com> w=
rote:
>
> From: Hao Jia <jiahao1@lixiang.com>
>
> Zswap currently writes back pages to backing swap devices reactively,
> triggered either by memory pressure via the shrinker or by the pool
> reaching its size limit. This reactive approach offers no precise
> control over when writeback happens, which can disturb latency-sensitive
> workloads, and it cannot direct writeback at a specific memory cgroup.
> However, there are scenarios where users might want to proactively
> write back cold pages from zswap to the backing swap device, for
> example, to free up memory for other applications or to prepare for
> upcoming memory-intensive workloads.
>
> Therefore, implement a proactive writeback mechanism for zswap by
> adding a new cgroup interface file memory.zswap.proactive_writeback
> within the memory controller.


We already have memory.reclaim, no? Would that not work to create
headroom generally for your use case? Is there a reason why we are
treating zswap memory as special here?

