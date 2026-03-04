Return-Path: <cgroups+bounces-14611-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WP8aH7tmqGl3uQAAu9opvQ
	(envelope-from <cgroups+bounces-14611-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Wed, 04 Mar 2026 18:07:07 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id DFBD8204DAE
	for <lists+cgroups@lfdr.de>; Wed, 04 Mar 2026 18:07:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3A4F4309E3E1
	for <lists+cgroups@lfdr.de>; Wed,  4 Mar 2026 16:50:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 451ED374E6D;
	Wed,  4 Mar 2026 16:50:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NGDTc8wO"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4199372ECB
	for <cgroups@vger.kernel.org>; Wed,  4 Mar 2026 16:50:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772643012; cv=pass; b=hn71m6KlE08+XXwKX1Z6o6ubf6yMa7SXFqI2PlXiVcOJ+F35iD2WUjujfQGgKWj6KlpmOW1YITGuB3OGzNDW0K0ala4j0aLYOTkwDsvROetvSdBYRpK1BpYQ42O2LGxh21b+ic48kloYCQZ/IuvHUxZM46UVGSM1PmqXTlqCmqA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772643012; c=relaxed/simple;
	bh=Z1zD8QHceRSWIPCX+II2vnEJtglFCb1KDWPWlkJAE68=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=miGFyQVkrgGuXBg+UEEgWWvFb4MLSZJfR1JK8zt+MLpMDX67be2kHWa/kNu+O+tI93wEnvun3J868iqVILQ81Z42QdOmzIMTtpPkIhgknPZiHkmy6QvicSybFoAwb8Bvj3sjULpABV6dnjFxuoma8lFQgs5y+kb1Zzs8j+a8FZg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NGDTc8wO; arc=pass smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-439c9bdc1eeso842228f8f.3
        for <cgroups@vger.kernel.org>; Wed, 04 Mar 2026 08:50:10 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772643009; cv=none;
        d=google.com; s=arc-20240605;
        b=WfoCn5qH1UGGiEdoC2mqx1LBRMMZhkK4l6GsGLDfyM8DbXUkCHThWdh6UI6zbvZ31K
         xvALxRZYXtvsxy3hpz69spz/EFA01JoHXAxjRwXyNNV6Da+mIcydnSIKD7wy4WGhKdrl
         goVwgEmTA0EaOlcWAy9+LnS71pQVnb/36BOz0S65UpxbEZ+cp8FM1BKjA4iivvdrXB1J
         TSTt4bPdkSzlXFr0bwtx9U71PqO0uuwKlwiTkTykiVJx5+sFUhvxlPAWYgwhC4D80Lom
         AUr74ne6FdbUv4RzYB/ulqRRGXlvAz4WZVZU75oQIBEuakEf4idZ7rvpn8FeKM6KMGVf
         tSMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Z1zD8QHceRSWIPCX+II2vnEJtglFCb1KDWPWlkJAE68=;
        fh=brVfo+Lfky2LRVguhN6ka16QEukBDa5BrhILbMQyd4I=;
        b=imhXYSKohKqG3ie9jXUDA0spGT4Cpu6f/jdPGZMc3JJ3FJn3adtn/SQ07O2v0C5bn0
         +9SRNBYH7/g/LtJ0LLnwKWYv6vUbiY+tqzAcQ9qHLfvK6Ondx95VAqCwupYt2et20bNM
         yCdAnJcYemXOXxsu0Ybhx/bh7KCfF+czs1z61s21C+nOMrk3EDcMN8JM3TUol9CjrB/A
         /MkIX7SEwMHbqZWym0uIB8U+TGew/8u/b/lRPHgaiTBpVlg14r7X1THRPUkun2LgKrSz
         N9x7u1xHc6+jKyBQv5BlE/V8zOtxSYww5RL3ePrgRipSZg5sPkpAPP3PvOSy96ITqgTO
         1XJg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772643009; x=1773247809; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z1zD8QHceRSWIPCX+II2vnEJtglFCb1KDWPWlkJAE68=;
        b=NGDTc8wO3cAXsk50gW76yfmmV/WRbk75Za65ssYtGK8o3o8n9WLZwYxt+3IUhYVAjk
         4xgB5T+SaI7KPrgjHfGFpVU+PRaVFjl8otzBa6K0r9/UlKqrxH0bnd0/Kg/X+SYp881J
         yB32EUKYTa5kCNKfGFw8oxPdzzJWDOqWF804Uw5WgE9XvLgG4xiqslvclkyxXQpjsawp
         iOi+d2nMNIJV/c79bts9mbD230rq1pIz7IixYPU0xZ93z/Pz3R3mnTvvEvQwlpK5+5l9
         daF8bT65slgQXIDonJCt7B1wp5nU4n94begx9ABZsYfl6DRM1KvLvPg6qC+LheN3iboB
         U19w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772643009; x=1773247809;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Z1zD8QHceRSWIPCX+II2vnEJtglFCb1KDWPWlkJAE68=;
        b=HIfV4iHftd9004eM38y6Usdn3S1qQ0b2An8PKafyN8EizcV5sVGbwUlu+iX3t7y50m
         dN9CNd1rq+uyGmuMN4y6O/TvSpJa3fD1mUYNx+sMzUH5FN6IWsC9ZMcPopROP5AeKLSU
         8mNidBZtSlEfGujwpIIJi+Q6xDnPRfs2HUkxHQovxn9qnpgpRLbaj73YzJVsc0yM23Hv
         nklWrcS7EA907dBFdyax2OP4gHc0qVzDA/ftmp5n2WPzz9GM2C066tdFrHhHdfbvzdTq
         Nh+MoCQerhgeP6zkFQtj1Rp5nUAhZwsuNV1bBbxMOFpfPiYU/2cIwKz42bLQbFFqyV2X
         H9+A==
X-Forwarded-Encrypted: i=1; AJvYcCX2KZ5yXE1ymHuazM1xxsV56NboL98qnHVGsKKg/KQXVxbbKhIDs3WXfH7WEX4fsE/IM1QA+MZA@vger.kernel.org
X-Gm-Message-State: AOJu0YxCeFdv4UkEMCPAz0D/dO14X/KiISiWl/9vN9Rx2bZuoi07l6Eu
	F1gg4oSOSg8pH2UP7MeNa1toCathVfek034Rg1dGT295tfnJTdQLBFozkHKDldjjolL4yFsGgal
	hAK1Mj01/fLaBCMOsncgUJxBA+9WBjDs=
X-Gm-Gg: ATEYQzzZ2p3daEq+P9n8BkmmyRi9bwzS1oeL4kkV9iovX8o52ZlxsY3FL/jE43kKBEu
	jlxgMElZF2srtK+WHW8x23osTxViL/TaeJmVEmwmZYSEhFRZ1LZm91jIxOOHJxvz+P9pzg7XrUR
	JF+jy53KNEdCVthandccIRO9Tnbte8Fj41s4Hr/b5KZmKS2xIefB828jId8tSfWXkBnS7WFux9G
	N6eksLBFP9HoEFfFyVP+eCAEDFJt3PHxYv8WiazOYJQDcSZzdde/aXfXy6FsfUs1axjyKRFmqSd
	cEcGtlMyQ0vc7+7QtWW0dLKwNjC/LIwTjC/8GZ8=
X-Received: by 2002:a05:6000:144f:b0:439:b564:7a6c with SMTP id
 ffacd0b85a97d-439c7f6a2c9mr4935603f8f.4.1772643008765; Wed, 04 Mar 2026
 08:50:08 -0800 (PST)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAO9r8zOFS7zU-eGkErcjud=DW0t00_WqNqCzq_QDf061dOsYSQ@mail.gmail.com>
 <20260304151120.3512645-1-joshua.hahnjy@gmail.com> <CAO9r8zOJ5bkJzptM7+8V2G00dHuycAEAF4CDcaR1YMk0kWyktA@mail.gmail.com>
 <CAKEwX=ObFWm6cKbi4hL8JLDKui3MsRu-JpEFohBdkqHFY9tVfA@mail.gmail.com> <CAO9r8zMbU8ikA4jAUyOvvorsm3L4UD2X-KVcGyQaKwTZ0nV1Qw@mail.gmail.com>
In-Reply-To: <CAO9r8zMbU8ikA4jAUyOvvorsm3L4UD2X-KVcGyQaKwTZ0nV1Qw@mail.gmail.com>
From: Nhat Pham <nphamcs@gmail.com>
Date: Wed, 4 Mar 2026 08:49:57 -0800
X-Gm-Features: AaiRm51ko9kVS8IjAoCAT_NvsIsy1-qAXevpqNGzCEvGG_N_B6mgqJbBAi3r5s8
Message-ID: <CAKEwX=OqW07O0nQqauTaJEwThVQxZJjbiLEpOuQtSp9+Dv6y1A@mail.gmail.com>
Subject: Re: [PATCH 6/8] mm/zsmalloc, zswap: Handle objcg charging and
 lifetime in zsmalloc
To: Yosry Ahmed <yosry@kernel.org>
Cc: Joshua Hahn <joshua.hahnjy@gmail.com>, Minchan Kim <minchan@kernel.org>, 
	Sergey Senozhatsky <senozhatsky@chromium.org>, Johannes Weiner <hannes@cmpxchg.org>, 
	Yosry Ahmed <yosry.ahmed@linux.dev>, Nhat Pham <hoangnhat.pham@linux.dev>, 
	Chengming Zhou <chengming.zhou@linux.dev>, Michal Hocko <mhocko@kernel.org>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Shakeel Butt <shakeel.butt@linux.dev>, 
	Muchun Song <muchun.song@linux.dev>, Andrew Morton <akpm@linux-foundation.org>, 
	cgroups@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: DFBD8204DAE
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-14611-lists,cgroups=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[17];
	FREEMAIL_CC(0.00)[gmail.com,kernel.org,chromium.org,cmpxchg.org,linux.dev,linux-foundation.org,vger.kernel.org,kvack.org,meta.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nphamcs@gmail.com,cgroups@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[cgroups];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,mail.gmail.com:mid]
X-Rspamd-Action: no action

On Wed, Mar 4, 2026 at 8:46=E2=80=AFAM Yosry Ahmed <yosry@kernel.org> wrote=
:
>
> > > AFAICT the only zswap-specific part is the actual stat indexes, what
> > > if these are parameterized at the zsmalloc pool level? AFAICT zswap
> > > and zram will never share a pool.
> >
> > TBH, if we were to start from scratch, these should be zsmalloc
> > counters not zswap counters. Only zsmalloc knows about the memory
> > placement and real memory consumption (i.e taking into account
> > intra-slot wasted space) - this information is abstracted away from
> > all of the callers.
>
> I agree, but we cannot change the zswap stats now that we added them.
> Keep in mind that when they were added zsmalloc was not the only
> backend.
>
> > And if/when zram supports cgroup tracking, memory
> > used by zswap and memory used by zram is indistinguishable, no?
>
> It is distinguishable as long as they use different zsmalloc pools, I
> don't see why we'd need to share a pool.
>
> > Anyway, Joshua, do you think this is doable? Seems promising to me,
> > but idk if it will be clean to implement or not.
>
> Not sure what you mean here? Changing the stats to be zsmalloc-based?
> IIUC we can't do this without breaking userspace.

No I meant your proposal haha. Sorry for being confusing - probably
need more caffeine :)

