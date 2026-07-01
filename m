Return-Path: <cgroups+bounces-17420-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id NnR5IlpQRWrT+QoAu9opvQ
	(envelope-from <cgroups+bounces-17420-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Wed, 01 Jul 2026 19:37:30 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DA1176F0646
	for <lists+cgroups@lfdr.de>; Wed, 01 Jul 2026 19:37:29 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=hRJtPj5B;
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-17420-lists+cgroups=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="cgroups+bounces-17420-lists+cgroups=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id BCACE3016484
	for <lists+cgroups@lfdr.de>; Wed,  1 Jul 2026 17:37:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7D824BC03B;
	Wed,  1 Jul 2026 17:37:27 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 523004BC007
	for <cgroups@vger.kernel.org>; Wed,  1 Jul 2026 17:37:25 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782927447; cv=pass; b=tvUxJ8x157Xi0KUVSWAuqjY35AdzFWmqseN0xvodXFVut5U1oZnK3+Yv7Y22RVWT1VNACQQHzqeoQhtjmACz9YVzUCE51rxPRx4eeI5C95TsKUyODF0gRKbTAqCLRMdm/7zSMgE8XU4Wtr8A+rGiPHIVBDhQjA7dTkrz9R5B9YY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782927447; c=relaxed/simple;
	bh=a9ZoocRq7w/lEDtlqj4ZXkRMHd6EejBd6UH2Q4pzHiA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bH8/9hAiXjVIZq8lGqcIcPXefH9TLfH8dCJKmP/fw2p3za57qf7AwvhVMHhm6+pL+CwLkrWNlC4Jf3xDCxIA20cTg7vmsKAivYDu9stM/lAFwE+5uLtAAvVMAcWFtHyPhXLRYtv4y0AqEF//GL3eKVG4iHXRcMVKIVzpVfTftGg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hRJtPj5B; arc=pass smtp.client-ip=209.85.128.52
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-493be1b9564so7572655e9.2
        for <cgroups@vger.kernel.org>; Wed, 01 Jul 2026 10:37:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782927444; cv=none;
        d=google.com; s=arc-20260327;
        b=i9GZYszp4C48WwOlY+mDhindtQ7HMeIW4/UFTAyWFW+1NagRSpiSJ9cxYEaWgLIp4O
         WMX7KMo24tjYJRR8AWefPB0JIYkYkbO8guGbn2Q3YfRgL0FRHkH3IDX+uvQxgUF6TUfz
         RYOPEIUt9vZOYv3m+1sFQXN7yc48RaU4zeL9HOvY/ptyg1jOwPsnnQw6tyE3/SFwhRbY
         wFMmEHXefVmd5G7gv2yY/p/jBvhh3SsYS4uEx7tmXbYIo9l8quF5CJHKqygknx+3QxbN
         iAxoi/cmF0JS6cGGAvOBi835FbK9cd19O1j+3M4U/2niOOAz8vcipwLa1Ypg399B8Krl
         uqtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=D09WX3fDR+aS4AC+tTDSMISse/qU3FNHoR5AIw8MW8M=;
        fh=6uii8rID6AorI8j299MFyo3hLQx17lYI5y5kXpq48uE=;
        b=UueqltLYNOt2givz3l/BnhEdPGlFgLVQVwNv3nli3AYG93SqGZTl1kk4q9FAwKoUnU
         +FhOfDcicgraliABX9j6DK96TMQ3Yol3Ut2dZZ8MyLqJtkomNctnDqwpjPGAPxuE/Esi
         LTVIkCABcwowzDS4zchKbdDMBwYGZUhydFd6KfYgcmDNu0va9ra7EHOI4jUFlxgvWd/S
         8OzGjCh9OYGQ5asGN1jfTU1OwUGie1iFIC49LWswzAQihSrRPQMNo2cXnI6WKuEi4HTK
         5u5iwwufkekMo5y8u+5YvIrcf1hlGiGtaPPewzIAtbeR+tWICL3l5VaKM+PlyDKjJPDl
         e+Qg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782927444; x=1783532244; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D09WX3fDR+aS4AC+tTDSMISse/qU3FNHoR5AIw8MW8M=;
        b=hRJtPj5BG9nKUrde1nEJww4lfxvSISqCL7kKL1CHmGVQyyppOW31iXUccYJGLsRdZd
         1Xoajcm4fmx9vQBttfYhIV2o1oLM3xKeOm8HwBWyC7lD6FJpssi3wzSn4OhvykhGSkV0
         xE9pVn+gpttM3o8bgJ3lRZ4gzZaSMM6eO7begBdsUiPKOZA9IdNbc8B3H08JOP/YGnNN
         SZx6n/TH0s0LiaeD8aYkl8N4L2K3HlErXFR366bn2daoLCyI3VaHMSSTyh+WBAIDkGSm
         yhRxgLI8HB9E7ssanuzc9U5fN4WVMHW+JELLS5ulpEm43YLgEQ+LOrTOPkgndRKpoir+
         GhVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782927444; x=1783532244;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=D09WX3fDR+aS4AC+tTDSMISse/qU3FNHoR5AIw8MW8M=;
        b=T1+UF3y26zrFLP6PxIs3bXcKCURhIJUiCAgPITjInFhc1TG539EGLFoeWkuicKvhwH
         5KeOUQCYLpYX7fycUSPv03b3qKZIrUndjBHM291rbZoE+DXNK/NyGIc1VP7SgfSHdnm7
         zidNkayOzhnciblb3SRwpebf8mOl8fF4fX5R6OaTTUDRV6Duch37TqS7PhmoTeyDerHl
         xbD1zeg3ZSPTAdcSZE/gjB9Wo2CRFGypadZrtg/j5cv72f6aOHvSbVbKTTpGdHdMxE1n
         EL6NbQa4mMXJ2evJuIr2azRCQPVmj5QGtO7TpgEPnYjYnXZh+SNCUX8xJJy4jte5XUmx
         d8sw==
X-Forwarded-Encrypted: i=1; AFNElJ8ijmvb2Jiv8r9AfkNca2KUBPHTU/xwL3VRCGDBClbDPPIo9AEmHNQLB6N3iXKB3DX5W+UPfppj@vger.kernel.org
X-Gm-Message-State: AOJu0YzmN0YxHqecgBBSS1CSD3cJh0olTX07+ZRKg/fBvJOiblw1K/1o
	/v8zB+wFOpwQUGyTe4tLkuLBKfP66KD9BVwJtX9IoPpK2LxtEIzUc+60Sh24tTtf44IObQRn4Px
	/Q3ZlZ/a2W2A5TYShmpczh3DaXtz/qQ8=
X-Gm-Gg: AfdE7clP/aLdZKhAAOF4jDj3GjqQtbw9Z34CGbMHRwTWL09iWyj2IVX3HKEtl0qqnQs
	bEQG/VMVmmyvwUyB27Z7j6L/w7yNP4coOJfwAG+q6WiLq6pwFuY02ZAtWnLYh941BMISEGx46d1
	lhqXG3tNyS35iFQ2Z6gFLipHBzweHURXt5ySYd+6LSnOZZjuPscgJg5vhMXoepZl3yWYv8wDbRD
	LMUqUH83RoANDigvKSt1lpdUKxT+FNysIk4w8JJ1sC/YcetnIap0dX34KM0E8NgnUR1fKjkZjJA
	SUOAo/LULZVf0lzKLpuP7UrOE1wX
X-Received: by 2002:a05:600c:4e4c:b0:493:b2c1:b2f8 with SMTP id
 5b1f17b1804b1-493c3cd568fmr29279035e9.4.1782927443456; Wed, 01 Jul 2026
 10:37:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260630100832.107062-1-jiayuan.chen@linux.dev> <eb3a62d5-5fff-4da5-a211-860ef0d4aec2@linux.dev>
In-Reply-To: <eb3a62d5-5fff-4da5-a211-860ef0d4aec2@linux.dev>
From: Nhat Pham <nphamcs@gmail.com>
Date: Wed, 1 Jul 2026 10:37:12 -0700
X-Gm-Features: AVVi8CeLOF-foergKkfJRWxxCORizHYveGUtTsIGiHyTBqYnPLxUB6T6yfmq35Y
Message-ID: <CAKEwX=NF9nHTwXp2zFz1AY2nhEbBK1fE1Z4tMbtNbnK-zcEGGw@mail.gmail.com>
Subject: Re: [PATCH] mm: memcg: reset zswap settings in css_reset
To: Jiayuan Chen <jiayuan.chen@linux.dev>
Cc: linux-mm@kvack.org, Jiayuan Chen <jiayuan.chen@shopee.com>, 
	Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Shakeel Butt <shakeel.butt@linux.dev>, 
	Muchun Song <muchun.song@linux.dev>, Andrew Morton <akpm@linux-foundation.org>, 
	cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-17420-lists,cgroups=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:jiayuan.chen@linux.dev,m:linux-mm@kvack.org,m:jiayuan.chen@shopee.com,m:hannes@cmpxchg.org,m:mhocko@kernel.org,m:roman.gushchin@linux.dev,m:shakeel.butt@linux.dev,m:muchun.song@linux.dev,m:akpm@linux-foundation.org,m:cgroups@vger.kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[nphamcs@gmail.com,cgroups@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nphamcs@gmail.com,cgroups@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	TAGGED_RCPT(0.00)[cgroups];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sashiko.dev:url,vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,mail.gmail.com:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: DA1176F0646

On Tue, Jun 30, 2026 at 3:44=E2=80=AFAM Jiayuan Chen <jiayuan.chen@linux.de=
v> wrote:
>
>
> On 6/30/26 6:08 PM, Jiayuan Chen wrote:
\>
>
> https://sashiko.dev/#/patchset/20260630100832.107062-1-jiayuan.chen%40lin=
ux.dev
>
> Ai is right...
>
>
> Also I'm thinking that should we add a helper instead of using open code
> in css_alloc and  css_reset ?

Hmm idk, seems a bit much to add a helper for this single use?

