Return-Path: <cgroups+bounces-14625-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IBnnFmj2qGkNzwAAu9opvQ
	(envelope-from <cgroups+bounces-14625-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Thu, 05 Mar 2026 04:20:08 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id D1EA820A7B5
	for <lists+cgroups@lfdr.de>; Thu, 05 Mar 2026 04:20:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3A8143012CE8
	for <lists+cgroups@lfdr.de>; Thu,  5 Mar 2026 03:20:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21CF7270540;
	Thu,  5 Mar 2026 03:20:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eHxi2gL6"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B191A26A0C7
	for <cgroups@vger.kernel.org>; Thu,  5 Mar 2026 03:20:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.219.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772680804; cv=pass; b=qV+ZSuRaU1jD0uhsk6r6tyPruklHlJEWpmVJac2L16JAck83GXLTym5vwaDDknRBiD1Xa49F+CleqF36tEIKN41wqhYURAPohgUEpgyUkvHq1bTEzJILxHPo+nBwWEzxoFtSaPycV/bI6KboiwzlxXGFEyFeHsgcIiyWBTsuqrQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772680804; c=relaxed/simple;
	bh=bNxfPghz3a2C6X013utbDw/X+on1R9lRqjkanG4CrHE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Lf+NciMKEOBGpHq+JU5HNvbJvh1fleGvM+vFbnv4Tn44t0cphbRuOA26N/dJ4jWbc4VrYsqir76xPZzPYXYABav25aEQmKB/AFDYifok2c3H02gKgvJnT/s4M/b0jxEpvkm18pcuilzGpwuvhgKCop3lnCLj/nPU/RHaBoUakNA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eHxi2gL6; arc=pass smtp.client-ip=209.85.219.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-89a06bc2f1bso54147186d6.1
        for <cgroups@vger.kernel.org>; Wed, 04 Mar 2026 19:20:03 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772680803; cv=none;
        d=google.com; s=arc-20240605;
        b=HJOiumiyfz1pta++ZeUxN47eE7vIeiWLBJDLsI1xSkSDoAvJia4HKbGiI63El0wzBf
         lv94TgevUP3nERrx4FoTKIXKXUsYbK6FQGEo8HrQjNEjM2ezhZSkiw2Oz4AsE7ZF1fhY
         /0jq9s0omAgqdlBeLmGzHckseCCSJUgPt2P3n0y4MQ39Ci6nK3TS5u11wWrM03tvHYuW
         OT1LPNJ0OSYRv8Lj+bY+MmxFCPtcy1Ky3vJaiGrsh/Zihic3AFZxDTSHPSBAbMFeLQE9
         lGJgqjPxgFg+0b/z75uVjVL/wcGKxqR+CSGSH89cAcJxiIg2LanYrE0MfKz0WdctYUVs
         MLMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=bNxfPghz3a2C6X013utbDw/X+on1R9lRqjkanG4CrHE=;
        fh=T9/uNZosnYNfaKTt8+O/ysAANasLnClPTGdEO8ZwwrE=;
        b=FxNZ+sVDOeCCYQAg2GWXNjGPE3WoOY4GuS+pyP3UqQapClkpBa7Ehu7V52T4T0lXOK
         Bpe/+ffYP6nvq8CSNGwjqIejdKMqfHmmJpG4Nx0YnzbiQDmE3KWLv9WOMUveKwDFSaC3
         Qe+RBGP5i45rZbKqwHKWAjDNdB2XOdsUkw2Y9ACdHEhPMYg67pLFgzBJCYq0PgNscWeF
         cT1Y8XB4NI/sV5yNvOQGW+knJHPYaPMkXO3lLRwDsacbfOpiHRKL+pynnpR4VsrKzX7v
         kD885DChjdYXTOpKvhqZuO2W1r6GRBzzc6n5xSvTeQeRMqsJng+/YXsYVByjpLfnIJ3Y
         sv2A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772680803; x=1773285603; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=bNxfPghz3a2C6X013utbDw/X+on1R9lRqjkanG4CrHE=;
        b=eHxi2gL6yFGj1HnkdiVskuxh4eBT//lzgCDXYBVly/Tb2//gNcX6GoO0cG1ERjNj34
         sXgE6vLKXic2088fpqxqIrW+dX6smFK0FpPPw69KLyDka10xbpNHqIwsCa5XlOAGsr6t
         JE15u4mTo7atgZ/HdfH0oydJg3OTpWCBE1aNSzXQjwxdt3Spk4K4vbvRKRfyWRkwBFGM
         hrxk96sUpRyYpiciD0D7UT6lJOMvxLjkBpagwRz01kH3DW4q6M1PEY6CS4B5cdtTs1Qy
         6Ki13dKtKO33OaFkaD3DeuyucVXLWMDsY53Mfc/sm7XfWlQfCfKSkODO1apo3z7WKVPn
         yzvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772680803; x=1773285603;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bNxfPghz3a2C6X013utbDw/X+on1R9lRqjkanG4CrHE=;
        b=bbFK2FfV5vqNg3JukeBXPy89MhCmLV5ghw40HKXio4ALd6dqA9Q4kAB03VlxgVFzo+
         h1lsb5uVIHEBRkpde7XUlwX+gAyIxoTbl5wOumfkSdWsHyZQ7SyJsEyQuzjsjYPEisyR
         1JXKchFoZZKS1mNFeeq77Cqzawj3ArPlW6+GuQgHGpJDmm/mWxmJ0nnRLAzarfQAdRIE
         PoIsN1TVPH8ZFnm0IkrRPmraF5GlXqbLrGRcVwlBgSa/Z55vb25claLTTuXUvTZ3D3AY
         VbSFYC5yvnJ/EnTY7BnAMs5LiFfbmlr3WUprptRsZxBy874C0Ol+CMbVCv18YFwaEGLz
         qcJA==
X-Forwarded-Encrypted: i=1; AJvYcCXDkzFecS5T2FMs2/AmgBl2bKCFnqRCausFuHYs5BblKTOSUlmKlaVxILqZBTUVAVzKBKL7xNQh@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5Ty3y6uFR9iXkBkZ1uvC7F19FIVE19P57IlzcJZ3L5/6PTkqe
	p69LfP1KiRt7B+cML0WH/85g+4HFhtq78xnf0KwpbOiBM1DmjdxBjG+lRwzPSm/+E7UK4omR4Gv
	d3o7uBxxGKTVbsyG3uEh50lmgo/gijFE=
X-Gm-Gg: ATEYQzzCntg/hE6mqbQ/obAPoyOF1oI3nEw/4S33ArFS2X7qPwv/oLdLJp51u+C0VgR
	byb7zp9lFI7EeUJfPvxuOfFhKFK0hM1y86JzLuSFEcS7kIi2nunHFMZAc2pLR1q/NAPPFQiHbk2
	Qeh3EXR24c6wdeiGI/TtO8jP979BXBWKDEIDp9g79Niafjx38CBBvohbJhqZq4PcAA2rUYsEYdM
	0vL/EzxU3zEfedT9A7aFV/TdduWNe6g0TVznM6otErjWtXHSwgPQyqTc4mMWRhy0tU1tRVhanIp
	FeayZEJBD/jKVYF2wxlG/4P6uwZ00gKAxX18tbPFQmCEIewnxrkTdpdLqxENFmJEbuc=
X-Received: by 2002:ad4:5dc9:0:b0:899:f841:da21 with SMTP id
 6a1803df08f44-89a19cfb95fmr62940486d6.51.1772680802721; Wed, 04 Mar 2026
 19:20:02 -0800 (PST)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260224020854.791201-1-airlied@gmail.com> <20260224020854.791201-8-airlied@gmail.com>
 <ee914ffb-5c3d-4d41-abdb-5ed02db326c6@amd.com> <CAPM=9txUuS-qzA+gX2DvTuYR2OZ79RG86FuDA6czkpuJ_SR6KQ@mail.gmail.com>
 <4fddf319-50c4-40ab-9e36-04d629a8855e@amd.com> <aaWZrTZGsxxjbBYv@linux.dev>
 <8efef755-e429-4cec-bef4-b15b3f9f4632@amd.com> <aaWuoe_CQwbtcxEY@linux.dev>
 <63dccd9c-f2e5-421e-ac3a-a7c13cec9121@amd.com> <CABdmKX0=xPiwXgOHskGkE9Umj5=NrC=7OtngJjrm=mtOZmyzvA@mail.gmail.com>
In-Reply-To: <CABdmKX0=xPiwXgOHskGkE9Umj5=NrC=7OtngJjrm=mtOZmyzvA@mail.gmail.com>
From: Dave Airlie <airlied@gmail.com>
Date: Thu, 5 Mar 2026 13:19:51 +1000
X-Gm-Features: AaiRm529B-v2wzcCVYUJenUOR_2LQm-Zonmnic-n55ff8LsW9WWtwV-PEDAH5Lo
Message-ID: <CAPM=9tycvBguhM6r5ytm9S7D608iZDthHgfY=hxUvSjXLqsZAA@mail.gmail.com>
Subject: Re: [PATCH 07/16] memcg: add support for GPU page counters. (v4)
To: "T.J. Mercier" <tjmercier@google.com>
Cc: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	Shakeel Butt <shakeel.butt@linux.dev>, dri-devel@lists.freedesktop.org, tj@kernel.org, 
	Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Muchun Song <muchun.song@linux.dev>, 
	cgroups@vger.kernel.org, Dave Chinner <david@fromorbit.com>, 
	Waiman Long <longman@redhat.com>, simona@ffwll.ch, 
	Suren Baghdasaryan <surenb@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: D1EA820A7B5
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-14625-lists,cgroups=lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[14];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[airlied@gmail.com,cgroups@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[cgroups];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Action: no action

> Independent of all of that, memcg doesn't really work well for this
> because it's shared memory that can only be attributed to a single
> memcg, and the most common allocator (gralloc) is in a separate
> process and memcg than the processes using the buffers (camera,
> YouTube, etc.). I had a few patches that transferred the ownership of
> buffers to a new memcg when they were sent via Binder, but this used
> the memcg v1 charge moving functionality which is now gone because it
> was so complicated. But that only works if there is one user that
> should be charged for the buffer anyway. What if it is shared by
> multiple applications and services?
>

Usually there is a user intent behind the action that causes the
memory allocation, i.e. user opens camera app, user runs instagram
which opens camera, and uses GPU filters etc.

The charge should be to the application or cgroup that causes the
intent, if multiple applications/services are sharing a buffer, what
is the intent behind how that happens, is there a limit on how to make
more of those shared buffers get allocated, what drives that etc.

If there are truly internal memory allocations like evictions or
underlying shared pages tables then maybe we don't have to account
those to a specific application, but we really want to make sure a
user intentionally cannot cause an application to consume more memory,
so at least for Android I'd try and tie it to user actions and account
to that process.

On desktop Linux, I would say firefox or gtk apps are the intended
users of any compositor allocated buffers (not that we really have
those now I don't think).

if there are caches of allocations that should also be tied into
cgroups, so memory pressure can reclaim them.

Dave.

