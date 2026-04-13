Return-Path: <cgroups+bounces-15244-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id zQKyLWsy3GkoOAkAu9opvQ
	(envelope-from <cgroups+bounces-15244-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Mon, 13 Apr 2026 02:01:47 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 11A0C3E66EA
	for <lists+cgroups@lfdr.de>; Mon, 13 Apr 2026 02:01:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D46FB300CE5A
	for <lists+cgroups@lfdr.de>; Mon, 13 Apr 2026 00:01:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9FDF1E5B64;
	Mon, 13 Apr 2026 00:01:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jneIyFi/"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 567927081A
	for <cgroups@vger.kernel.org>; Mon, 13 Apr 2026 00:01:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776038502; cv=pass; b=AcbBC03ydRTyPN9uruqemejGlxee8FNUu/TA+36me/jjpsl3Gde7M8Wcv2xj2Rgh38Ich/XQa2pNYjEUDeOOG4DXzxEdrcManm30DhSWs6Pk6DD4zqy0hsOIjYN9QdZFuWnToIMQGcLHvH0nzhdVZaU2HR/qAz3lWjqwM3lLgYk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776038502; c=relaxed/simple;
	bh=UykPg2QZhJz+Q7K/cGqnVHVYfJlnDh9z5GuGGnOlWpw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JQcG7AohXvoBJgGYyBWwAlNJcdy8r5oXssq/2DCSZi12/ps1QzNq8jpr6cNze6RGmzGyPpspH/vDxZlds8D8MQt5UAnR+EJudfQ1eAZUvCfyX/p+bkaygKLUg11kSQbL3Pd6PlyN2Hh+v+tdftuObfw0UOksfilc7+HQ32HFW0I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jneIyFi/; arc=pass smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-483487335c2so40667195e9.2
        for <cgroups@vger.kernel.org>; Sun, 12 Apr 2026 17:01:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776038500; cv=none;
        d=google.com; s=arc-20240605;
        b=i/wQzSwIyEwsXSDCsESnZAy1nXQ0IcnEgIOF9hhkXXFfnhjZ3tLihgZ+J86nCEIKjp
         +RVHbEpGFCBvFQ9ZNpWJADz8HIVnpdu/svBYpyhYJWZUCgoknqw3an7Z8Zus5pC0BH7q
         iyhE6kq1Qn4sY8SjZlmHadCe68TNMAEC+9Wx9zYZxaf0wZDGNmYq9nabOkqzeatkpn0r
         T4wzysI+IQzwWh6Ldyp1cANFlOGqbCqEejfYMtUoxfwjWLaV1m43ex35ImzJAJdE1olC
         pGPUruJ5PoglmvWTwTduYX2yr3G2VNOwj3KyjH/qSAmFsfTELKDYRjereEtUUBr47oR6
         Dqhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=q1z381Ofo0rx3mIfahNjA70c0ZuNgM+q7a4xb/dSsI0=;
        fh=sUpS2GtzEI4kHl/cUccoblxzPSlcNpb+DWcl8oD10zQ=;
        b=Y1VozQAjyiKQin6U8O36gROzlSLqsewxfhX5nLolU1tOvAdyj9uMatBl4It5li5Izr
         nSOpWoEh/u2m1NitebPJnzj4lRdi3frIAlbc819UfeWX7DsSpQQYyU+wx792vJ0s+tqG
         GlBM3xWBd38Cadg90hVY45wZyHLoPg6W4uaaoJJN9Tnf5qy01C7sAOAYP6oXfTcEN0JK
         u6I/nfBuHFsGZ1Jzj9R6Cux14hJ70esEhkmvUFQqvsPpF6dH5YYUCGHxg0zomLc1YTU1
         WuSxyaY4PsUaIJ9Nk01KUYKl1VUFxFV2L+Ul6aCYsQCkHNCXfmO7IYRv+4gu0gESEoIc
         QbKQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776038500; x=1776643300; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q1z381Ofo0rx3mIfahNjA70c0ZuNgM+q7a4xb/dSsI0=;
        b=jneIyFi/oPpwB6B4XiVbgXgMumz4+PEZPLcmFMfouDPIDbM1pYjmQgECOydnhQ20of
         cQSFKERxsjlaqzJzsgZ2UjjLzB3LffzDYYvLW1s98ZmJcutG5oH68ojOF1Ru60LSZoDB
         gnPLKLlEs6zLcTf+MBpfUIy1it3p1zx4VsnMKUc501jDjrGYwXBD3H5msXgK4tJeGel2
         d9RANVkS+RpMLyLPasr0f+iMJqXQuxsGYMJ7vz1GWxCOh5E3qvUBs47RyPulsrfvVCaN
         1Vz+QdI5Cbx2+rDVWQ1+KJU01BlgZPrJ+i42inzZGWXvladkGLR7dfq6N0SIUuDXIW83
         0dVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776038500; x=1776643300;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=q1z381Ofo0rx3mIfahNjA70c0ZuNgM+q7a4xb/dSsI0=;
        b=fchqXOus0RoOqOAT9U6mcCtSHZW/BGM4TVTAYWEoIANrUVH8HBDY47aXQomqALX04X
         3U7EAVtxEhDIhKBTkfoxJIZ8pYgDk4jXILwnhPPYhOk3WFfMdrkgYdTWW/BfkIcj0x+r
         SBkDSxpYNagD5ZShr9in45apveyINorG2CiiEoYx7e2eumgG/DE5LqWmdnC2j+FRIWkZ
         jda2IaX2++fmjvmaKE60EN7XE8QfrxSqEcQK4ujjOGf61TU/VUwn+uL7aAuSKC1IgkLA
         8izKM53zNm/rV5/P59hjIkzMSqZoh1C/afOieaVeY4dmbBOrtMDuDKQbW5+8wFXC4SmF
         urEg==
X-Forwarded-Encrypted: i=1; AJvYcCWwECPrqYztO9oZaWJ5pJVqvj6qGMCfy0QKXMN9T9ZphhhSbsmI+EwBWHIrkELsvk7+jlWgiozA@vger.kernel.org
X-Gm-Message-State: AOJu0YyMnGBgPs68lDh7CZNJmb2kpWE+kXf33Znk3Dt7JvzTivhLKuyF
	O3tcsWeyL9f2v94g8xyWEIEvafJRX6CV1A9L3ZLYAktWtVmNcBucbguzPoW4wLe1IeJtQfYvT2T
	Qqr32r+aV9NcmFeMzRGbZHorT1ZN0ktM=
X-Gm-Gg: AeBDietRduLjhcVESsbgzjg4P7GUa40jPikOPXixl2v4HCYTSQshf0avVbpPNJka6TV
	X5hk16UljIhni9zZXh6NSEqXVYD70RzCEPIGfwbhNxcKG59Gu0vAymDBg4+CXH6SkQE2MKcAq1P
	KurIsrjVe6cq8myKYnmNThHbUkFnPXy+HCLPB86KsJw85Dw+ctxHzLVZ1Diopz/lIVJKpdLuC+H
	zgMViHlbk9GKv9Q/z1KJXGYZRXIcP8UArAI+EmifX8FVtCgnjN42kFbGDEMkMfts1NAgkhmth7w
	OSRSAeab4BkWsl4QoAXCW2/woSfQ9Md54p9Kjg==
X-Received: by 2002:a05:600c:c10d:b0:488:ae4e:51a5 with SMTP id
 5b1f17b1804b1-488d683d633mr103247135e9.15.1776038499521; Sun, 12 Apr 2026
 17:01:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260402063714.55124-1-liwang@redhat.com> <20260402063714.55124-9-liwang@redhat.com>
In-Reply-To: <20260402063714.55124-9-liwang@redhat.com>
From: Nhat Pham <nphamcs@gmail.com>
Date: Sun, 12 Apr 2026 17:01:28 -0700
X-Gm-Features: AQROBzCwnFa6eS6aq3Z0ozwi2axh34qQ3NZxuV-fWDi5MSnDHDQiTKyxtwF61fw
Message-ID: <CAKEwX=PWiCcyX03YrZ6GOXK4MEOhos6TrTNMm=047xApqDJhXg@mail.gmail.com>
Subject: Re: [PATCH v6 8/8] selftests/cgroup: test_zswap: wait for
 asynchronous writeback
To: Li Wang <liwang@redhat.com>
Cc: akpm@linux-foundation.org, rppt@kernel.org, david@kernel.org, 
	hannes@cmpxchg.org, yosry@kernel.org, ljs@kernel.org, Liam.Howlett@oracle.com, 
	mhocko@suse.com, shuah@kernel.org, chengming.zhou@linux.dev, 
	longman@redhat.com, linux-mm@kvack.org, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org, cgroups@vger.kernel.org, 
	Michal Hocko <mhocko@kernel.org>, =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>, 
	Muchun Song <muchun.song@linux.dev>, Tejun Heo <tj@kernel.org>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Shakeel Butt <shakeel.butt@linux.dev>, 
	Yosry Ahmed <yosryahmed@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-15244-lists,cgroups=lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[23];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nphamcs@gmail.com,cgroups@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[cgroups];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 11A0C3E66EA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Apr 1, 2026 at 11:38=E2=80=AFPM Li Wang <liwang@redhat.com> wrote:
>
> zswap writeback is asynchronous, but test_zswap.c checks writeback
> counters immediately after reclaim/trigger paths. On some platforms
> (e.g. ppc64le), this can race with background writeback and cause
> spurious failures even when behavior is correct.
>
> Add wait_for_writeback() to poll get_cg_wb_count() with a bounded
> timeout, and use it in:
>
>   test_zswap_writeback_one() when writeback is expected
>   test_no_invasive_cgroup_shrink() for the wb_group check
>
> This keeps the original before/after assertion style while making the
> tests robust against writeback completion latency.
>
> No test behavior change, selftest stability improvement only.
>
> Signed-off-by: Li Wang <liwang@redhat.com>

LGTM.
Acked-by: Nhat Pham <nphamcs@gmail.com>

