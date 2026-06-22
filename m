Return-Path: <cgroups+bounces-17151-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id zp+nAG2nOWogwAcAu9opvQ
	(envelope-from <cgroups+bounces-17151-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Mon, 22 Jun 2026 23:21:49 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D92A6B2772
	for <lists+cgroups@lfdr.de>; Mon, 22 Jun 2026 23:21:48 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=oDGq302Y;
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-17151-lists+cgroups=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="cgroups+bounces-17151-lists+cgroups=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 027D23011353
	for <lists+cgroups@lfdr.de>; Mon, 22 Jun 2026 21:21:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F95D365A00;
	Mon, 22 Jun 2026 21:21:46 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4EB73451A7
	for <cgroups@vger.kernel.org>; Mon, 22 Jun 2026 21:21:44 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782163305; cv=none; b=I2xHpeo3OZy4pTw9SIR41ZGmLsP6HpV7XDXpS9n8ZHPB7o8mXyIgPUNoZjqb0TwaSLOkjDHcnJPOcBPjf3AkCwcNV4Y8pX8EFwjIC1D++ov8DfdS3LMxIoBUyx0KVuVitg0bOiNJGZiLwv/ismcGJEOHf8XAzTAR4lc2IRNIuqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782163305; c=relaxed/simple;
	bh=H/cQkfj8UgjSHcR3DnhC+Nybn+nnMxs87TrUehaS2Uc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NIdExHjiIS5klMTVycJVsbx2NkwCdu3nnpKa5NkF+vLZEEDA1BMEMjPDhWroNziur2g5AAdKSTaqedtML1OTV+TGYgOU6sQEj+81tjy1fohxQ6QVTU9Gn9SZkk+2DXuvFmzU7nALQEDT3nufTV6hTi6uU6XzkI4RWyyTKx1HQbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oDGq302Y; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73F111F00A3D
	for <cgroups@vger.kernel.org>; Mon, 22 Jun 2026 21:21:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782163304;
	bh=K7bf6olGmt7hkBO5KYr6/vTauRJAu4wZdDeislSzf3I=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=oDGq302YSkRLLuy53C/krBtehhIgbEsZSUmSNWyOIC2T7z4LjIPKRO5+7mJ731nM5
	 9tmasjHJq6H/neqSlK/SIudeCAux1cuT3QN/HtQBlHk99V5rk3zpAyD3oXKaaBcsjD
	 bQTeQ38HfNocTUgAI9akHEr1SY5CeUkiJf0F0jn+bqaLxCIuu/KMsxPQtWMq9ddfsI
	 SEa46R3prf6YD6If5ZY9/X51ovFGDpAE49chaDD6rblVMBaJUH7WEIJCviMD3P1xTf
	 GIs2+D3Da0gi+JKUdFIIn9hPc8c/qIOtTrHUYaNWOm9yTjWA1y0LKDRhovhdWJWMyh
	 F1r1G0Su/mjkg==
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-697763eeafcso4400295a12.3
        for <cgroups@vger.kernel.org>; Mon, 22 Jun 2026 14:21:44 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ+NHyhf6rV5wAKxOj0o+UlW3skSliZ+ZNO5ysx/MW4S5Jf8Y8VkKYIql9iwvW73UyA4V0OcTMPT@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7gsFZFwxcmPhVFFhLQMDHzOnpahL08xapw1LgBcvY4nqTpbQi
	O5RAxoyw6lN00N9eQgkopixR8LGoM+ijvZPVeATlMdKbO8rfL1fLAiZrDSCbkVYs6pjTf513sGt
	EOPxlUoxbOc5uw0RJosA7hC+fLqAmeRI=
X-Received: by 2002:a17:907:3e0b:b0:c06:c347:e7c7 with SMTP id
 a640c23a62f3a-c097ade1ea5mr842249166b.12.1782163303421; Mon, 22 Jun 2026
 14:21:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260620181635.299364-1-youngjun.park@lge.com> <20260620181635.299364-4-youngjun.park@lge.com>
In-Reply-To: <20260620181635.299364-4-youngjun.park@lge.com>
From: Yosry Ahmed <yosry@kernel.org>
Date: Mon, 22 Jun 2026 14:21:30 -0700
X-Gmail-Original-Message-ID: <CAO9r8zNjyW1rh26vv2vavCM_2-r70EuynU+-7XdEmrBdLL=TkQ@mail.gmail.com>
X-Gm-Features: AVVi8CcxAayH4paap-iXDXhqMrthHES3wd454M-yl11XJLm7VTcI9H0HymmZ1dk
Message-ID: <CAO9r8zNjyW1rh26vv2vavCM_2-r70EuynU+-7XdEmrBdLL=TkQ@mail.gmail.com>
Subject: Re: [PATCH v9 3/6] mm: memcontrol: add interface for swap tier selection
To: Youngjun Park <her0gyugyu@gmail.com>, Shakeel Butt <shakeel.butt@linux.dev>, 
	Joshua Hahn <joshua.hahnjy@gmail.com>
Cc: akpm@linux-foundation.org, chrisl@kernel.org, youngjun.park@lge.com, 
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
	TAGGED_FROM(0.00)[bounces-17151-lists,cgroups=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:her0gyugyu@gmail.com,m:shakeel.butt@linux.dev,m:joshua.hahnjy@gmail.com,m:akpm@linux-foundation.org,m:chrisl@kernel.org,m:youngjun.park@lge.com,m:linux-mm@kvack.org,m:cgroups@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:kasong@tencent.com,m:hannes@cmpxchg.org,m:mhocko@kernel.org,m:roman.gushchin@linux.dev,m:muchun.song@linux.dev,m:shikemeng@huaweicloud.com,m:nphamcs@gmail.com,m:baoquan.he@linux.dev,m:baohua@kernel.org,m:gunho.lee@lge.com,m:taejoon.song@lge.com,m:hyungjun.cho@lge.com,m:mkoutny@suse.com,m:baver.bae@lge.com,m:matia.kim@lge.com,m:joshuahahnjy@gmail.com,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[yosry@kernel.org,cgroups@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[24];
	FREEMAIL_TO(0.00)[gmail.com,linux.dev];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[linux-foundation.org,kernel.org,lge.com,kvack.org,vger.kernel.org,tencent.com,cmpxchg.org,linux.dev,huaweicloud.com,gmail.com,suse.com];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,mail.gmail.com:mid,linux.dev:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 8D92A6B2772

On Sat, Jun 20, 2026 at 11:17=E2=80=AFAM Youngjun Park <her0gyugyu@gmail.co=
m> wrote:
>
> Introduce memory.swap.tiers.max, a flat-keyed file listing each
> tier defined in /sys/kernel/mm/swap/tiers with its state, "max"
> (allowed, the default) or "0" (disabled).  A tier is one bit in the
> cgroup's tier mask, so writing "<tier> max" or "<tier> 0" sets or
> clears that bit.
>
> Since the current use case lacks amount control, it only supports
> "max" (on) and "0" (off). Therefore, it does not track per-tier swap
> usage, relying instead on a fast runtime bitmask check.
>
> We maintain both `mask` and `effective_mask`. The `effective_mask` is
> strictly bounded by the parent (e.g., if a parent is "0", the child's
> effective state is "0" even if its `mask` is "max"). Maintaining this
> separately avoids costly cgroup tree traversals to check ancestors at
> runtime.
>
> Suggested-by: Shakeel Butt <shakeel.butt@linux.dev>
> Suggested-by: Yosry Ahmed <yosry@kernel.org>
> Signed-off-by: Youngjun Park <youngjun.park@lge.com>
> ---
>  Documentation/admin-guide/cgroup-v2.rst |  20 +++++
>  Documentation/mm/swap-tier.rst          |   9 +++
>  include/linux/memcontrol.h              |   5 ++
>  mm/memcontrol.c                         |  67 ++++++++++++++++
>  mm/swap_state.c                         |   5 +-
>  mm/swap_tier.c                          | 102 +++++++++++++++++++++++-
>  mm/swap_tier.h                          |  57 +++++++++++--
>  7 files changed, 255 insertions(+), 10 deletions(-)
>
> diff --git a/Documentation/admin-guide/cgroup-v2.rst b/Documentation/admi=
n-guide/cgroup-v2.rst
> index 6efd0095ed99..4843ffcfd110 100644
> --- a/Documentation/admin-guide/cgroup-v2.rst
> +++ b/Documentation/admin-guide/cgroup-v2.rst
> @@ -1850,6 +1850,26 @@ The following nested keys are defined.
>         Swap usage hard limit.  If a cgroup's swap usage reaches this
>         limit, anonymous memory of the cgroup will not be swapped out.
>
> +  memory.swap.tiers.max
> +       A read-write flat-keyed file which exists on non-root
> +       cgroups.  The default is "max" for every tier.

I wonder what should the default behavior be if memory.swap.max is set
to a value other than "max". Should the limits in
memory.swap.tiers.max auto-scale or remain as "max"? We probably want
to keep the behavior consistent with memory tiering.

Shakeel/Joshua, WDYT?

