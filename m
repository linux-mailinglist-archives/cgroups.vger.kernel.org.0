Return-Path: <cgroups+bounces-17148-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id xyGWKMplOWqLrgcAu9opvQ
	(envelope-from <cgroups+bounces-17148-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Mon, 22 Jun 2026 18:41:46 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AA636B1354
	for <lists+cgroups@lfdr.de>; Mon, 22 Jun 2026 18:41:46 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=WRGeQtuc;
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-17148-lists+cgroups=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="cgroups+bounces-17148-lists+cgroups=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 9FFC63021C91
	for <lists+cgroups@lfdr.de>; Mon, 22 Jun 2026 16:41:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 066A4339714;
	Mon, 22 Jun 2026 16:41:42 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89AE2238D52
	for <cgroups@vger.kernel.org>; Mon, 22 Jun 2026 16:41:40 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782146501; cv=pass; b=n772p4POOGE6zN0Z6BTr6JaC152q5+wC1FoIYfca5rifF7g4/gmgh8dwF8s3lKgInkT67FPOvLKz2zeZhndkTQ8oencvxy5l6ZKZDjyS3kVUEcZc9PYvN8e9cyD/ibp0Xc3W7aACW41cQYIrkMda2KOFrGRTl5qa3rslD+OloOs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782146501; c=relaxed/simple;
	bh=oEFJM2xVD+jdJtGhPooMvFbQOOY2K9LW1MgvzB3/sn0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lKtfFQJHWjLkNfTcyRw0SeMZVRThvtEof/QoHH+8NE5Y6csEpY+ZTHAjh8Z+B18095EAfsCAP2Pv4Hb5dxvAf6ZMqg435FVtMXE2Oy4lnWxGqEXonnkJistzwAuqik2pWajEKe2cnb6575XM5mCflS56QViHWrZr8BlgOwCWytg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WRGeQtuc; arc=pass smtp.client-ip=209.85.128.48
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-490b1bbcf3aso30455605e9.1
        for <cgroups@vger.kernel.org>; Mon, 22 Jun 2026 09:41:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782146499; cv=none;
        d=google.com; s=arc-20240605;
        b=b06aLWdKCyUkX5vcYJntZWI/VGeuIndVaeW3X1JByiDJ9W9QzxB51xbOKXmhyJNZMx
         mhm08VDOQWYS5AbHzfaYUaUCiShNEBlIVC40/ugbTe8W3x8nE7q47N9AuV9vfGqZYpD3
         1/xpUrtSCslgn/sZt1iuQvzsh+ItktOD+pTUGwYiSqd0UVuOaPp9OQHo505J5swHC7Hf
         yWCwDyQKdVvmUa+Fm34gHTvkPXAjC4v0eVzsOGH0eb1DhIN1b3psp05D8AS7eLcJggKl
         wdYg9zFjyr4Fv6Nv/HOgGKGFSkEYAmpiri0Xq4a+NOetK2h0w2qeoG5lPA8HQcVyeeZG
         Oqhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=LO4CLyWX1yuYF8Ov//x4PcViKwdSdNNQusnOJRyN6do=;
        fh=DUIE2/dvo5jsKAuwBevbG4jlaAM/BokkdOPqPAsP2Ss=;
        b=CtQuKUNkHi2FKUGvaPm6yzad/h6otneKkU3RiLekfXduY08NmfbmA/7zr6o6dJICPX
         Dw9I2LzlgZcylbrLtkEYAi1E1gCJx9bDu6z7QYgP3kM6Co8rZJ1o2wPR1BqTu9ou3d8m
         xyJGzVonw7Xz4e6rmiRIJugAEHIAhnGzLbqowY3GPcoK6Pnhd8o6GBw8GHQcScHw+w2K
         lmQYGoL7I+MlfsEPvukhAdxaT1cOSpEuOHXGD0jl4XnUr5ztgGV4ihsu4kAa+XRF7MiV
         0sUHGY1UoHLjY4wmQeqO1ykiaehykyFT2M16JdoOwmp43a2B36Huoh9qWH3QFvxeN4n5
         3Gkg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782146499; x=1782751299; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LO4CLyWX1yuYF8Ov//x4PcViKwdSdNNQusnOJRyN6do=;
        b=WRGeQtucLAET+6KsAAE5ssKgAwyFGsGdoBIACUDMI62X6lbQmyewrKl7UpZQwAQb6f
         PrUEvYOewzJRELRBGwZV1HJrTWwtWLnUVI7K+QcrMNac6YKsGb4QUMwT0QLYwvSeKcvQ
         3FI6WIIWvNTuXresOuMagpAnl80Yn43c2bZRmYr8lg0y3W4YbryNxuK2hRv3HTqiLClz
         vB021ssQD1fwd46LZbdg0Nx/sm0VK5HQDohZnzVz57JDCUjFeeqDkAygzx+dSc28KxWS
         eyfGj1g70bPM+OpWq1Jm9B1VkvAcD62S7utr9vuHfRKJ4EHhUgy3sktIn96Re3pLfZji
         Er6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782146499; x=1782751299;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=LO4CLyWX1yuYF8Ov//x4PcViKwdSdNNQusnOJRyN6do=;
        b=fRbe16p30oUm3WlPiap7YxqIPVW1H4oKx374Nyr5+JsXCmpDu9n3nYSIDDxVSqrjUY
         TIy4/fkWUVlqvdg1+K8c2jzLXY5eKtyE26cY01L/ZqzaUaUlVcroj6B69nWBAwok9FJk
         Qf6h9n4PvOzyyXHjYoGgDYY1ltm9OfgMSKG/zzoZbrLf+ic+KR5p6vMfLxEc8j0ApT/9
         lK/NqILiBYYk/g04a4uSI1Io6zlN9vcTNcJa1WsoG/fNb0CalbNTd65GyjmZVUf5dOA3
         jf3nSNc9x6I5TpMtZELUiJ+pz+qoD62EWqmnkLqZHfDjG6pQVpNxK8MppDRlqKJ9LQDe
         +MTw==
X-Forwarded-Encrypted: i=1; AFNElJ9pNFF91+qWqQdAzdQNCBgrR8ATT05gwgkW9u6wrxViFovWMtmZbZDFYZ1FZLm7eriFzpg71lpr@vger.kernel.org
X-Gm-Message-State: AOJu0YyckvPBVKPKwsVSF+OE5NjUHxW+X2jr0paxTaA42HrI/L8vHl/Z
	rsFpOPR0xkYGbr8bV+oj19iWjzRK9ks4i7Ezh2/9uJZMrrXhB+DacQrRk5/UWLnFOGC5/eKh4yy
	PS/CjNsjRXF2TvaWZmtwbHgtBN6fsXYc=
X-Gm-Gg: AfdE7cn+XMRN99OXPyOreZdyvowHCEuEQ66HQOSdFHKwvW3DG5d60ajtwQ57835S5Oj
	sjHcU6w+jKvk22BD/L3O1R96tKSHfBcL3dFwKAl90Z5D/lledb7T5QE0FqQ5HCHfkve7paA/eNN
	TPJSaBZXq3M/syUvm9pHRNBpmfhv+ryEf3x4zIXbgaoS9jkBhRW15ThySFF9jdV+fSHSlfYQSTt
	Gdz67WAutzvpYsTZs4FHxWu9OqgBgLmUYlu52+IxgpOQhEZmA3P4nWQcWy1pWZaumMsVEzdi8/a
	wljGzPl+1sO1o9xk0fhsZcADGdp3
X-Received: by 2002:a05:600c:4f93:b0:492:3e44:214b with SMTP id
 5b1f17b1804b1-4924908ec09mr160471055e9.13.1782146498862; Mon, 22 Jun 2026
 09:41:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260620122751.388770-1-doehyunbaek@gmail.com>
In-Reply-To: <20260620122751.388770-1-doehyunbaek@gmail.com>
From: Nhat Pham <nphamcs@gmail.com>
Date: Mon, 22 Jun 2026 09:41:27 -0700
X-Gm-Features: AVVi8Cd1E9iWuTavN333q7KTJh9z6lMcL3JaeYY8kLllaHZeODJX9lKEfi3XoXA
Message-ID: <CAKEwX=Oe+Oz3h2+jkg=EDszbaM5JaeO3H1dAfXqudskad58N-Q@mail.gmail.com>
Subject: Re: [PATCH] Docs/admin-guide/cgroup-v2: fix memory.stat doc details
To: Doehyun Baek <doehyunbaek@gmail.com>
Cc: Tejun Heo <tj@kernel.org>, Jonathan Corbet <corbet@lwn.net>, Johannes Weiner <hannes@cmpxchg.org>, 
	=?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Shakeel Butt <shakeel.butt@linux.dev>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Yosry Ahmed <yosry@kernel.org>, cgroups@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_RECIPIENTS(0.00)[m:doehyunbaek@gmail.com,m:tj@kernel.org,m:corbet@lwn.net,m:hannes@cmpxchg.org,m:mkoutny@suse.com,m:akpm@linux-foundation.org,m:shakeel.butt@linux.dev,m:roman.gushchin@linux.dev,m:yosry@kernel.org,m:cgroups@vger.kernel.org,m:linux-doc@vger.kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[nphamcs@gmail.com,cgroups@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-17148-lists,cgroups=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nphamcs@gmail.com,cgroups@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[cgroups];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,mail.gmail.com:mid,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 3AA636B1354

On Sat, Jun 20, 2026 at 5:28=E2=80=AFAM Doehyun Baek <doehyunbaek@gmail.com=
> wrote:
>
> Fix minor cgroup v2 memory.stat documentation issues.  Correct the
> vmalloc per-node marker now that vmalloc uses the native NR_VMALLOC node
> stat, and document zswap_incomp as a byte-valued memory amount instead
> of as a page counter.
>
> Fixes: c466412c73c3 ("mm: memcontrol: switch to native NR_VMALLOC vmstat =
counter")
> Fixes: 5ad41a38c364 ("mm: zswap: add per-memcg stat for incompressible pa=
ges")
> Signed-off-by: Doehyun Baek <doehyunbaek@gmail.com>
> -               Number of incompressible pages currently stored in zswap
> +               Amount of memory used by incompressible pages currently s=
tored in zswap
>                 without compression. These pages could not be compressed =
to
>                 a size smaller than PAGE_SIZE, so they are stored as-is.
>

Good catch :)

Reviewed-by: Nhat Pham <nphamcs@gmail.com>

