Return-Path: <cgroups+bounces-16483-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KJf3IK0qG2ra/ggAu9opvQ
	(envelope-from <cgroups+bounces-16483-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Sat, 30 May 2026 20:21:33 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B78261190F
	for <lists+cgroups@lfdr.de>; Sat, 30 May 2026 20:21:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 8EF06301481E
	for <lists+cgroups@lfdr.de>; Sat, 30 May 2026 18:21:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA83C21B191;
	Sat, 30 May 2026 18:21:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iGvAp/8p"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CC962E7390
	for <cgroups@vger.kernel.org>; Sat, 30 May 2026 18:21:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780165287; cv=pass; b=g2Xwa5jNJbySAdLCzfY1s/XWiyPG+flWJOe8ZhQetGUc/LfrwYszPxxKfJlUwbB+j7ReYhB3/703GTAr+YfVG322w0y2FQ6sZ63Duqkf5A6of1x5aOAHF5n325+Y0ymWPidEuV4rL3kRhod6nE9zZZ4IIHWaLhnnNZHDyDOzK9k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780165287; c=relaxed/simple;
	bh=6dIrMXrak+yO+S1TQBaFPv2j0o2mLOVL9o6Gl4G7Rrk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RpzSZxkmqn8thfgolF12DgooTMC+RQwDcHyEW42vrtw1d46hJRMQhx0WkIGZkOKH5KpB/91JTXOA36b+spiFUdU18wUV5tBDm4lr1CrKipl3hrnpOhPQCYPIum+TXPJf9QHZ5r6HOAJshQuNzknBxvhezpmHzN054EGZE0WrOQY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iGvAp/8p; arc=pass smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4906869f0cbso76481395e9.1
        for <cgroups@vger.kernel.org>; Sat, 30 May 2026 11:21:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780165285; cv=none;
        d=google.com; s=arc-20240605;
        b=kkLxw9aCKgBhrwwy1MHFXL5S2CI3WN/iKfuCe3X+3Mms96vSFgQMI/48uOrxq9PmDi
         BfhgqNdL7RnBhIgqVzYzni2lltjsq8B3rbaGMGsG8H2s4EZVIZVlmClZkmuS6DdVprTb
         uFIHk/U+vPZ0nMp2X8S5gJWuyPU8/Mj4DuFoL9AX36FMYLpnFmdYeljjZ/ikvfAQIx+3
         B8gMaDI8KegGvFPaxYRNIMvMxKnNFg3E8OaV5t4rGuX0z9eGMu+KVYSCE9WD1sGjdQjQ
         7wTEow4Zi69M226/St+t+5cQgXGFlKjuNOtjFA4I4Q2wb6FJyQz+MGZh2i0rtoYEVMIO
         P14Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Sjq61YPS+2EWRhm8mek9VpsMrYhJ4U81YWVgXn/kVH0=;
        fh=1hGq9T2QWJcO/35DKXXJgAKT7EMGL2Q9cUgl298H9rM=;
        b=HDeT9mt5OtJ8mquEHG7bhB4E82OPSSPMdsYcSnTfJz6wLt+2W/83EdM8piz4+dbBrV
         ZMgdKz+S8LvNik58LFsZvewncR9UH3Tvl60OsLSC0p62Efi8nqk8tc2LPEnzHnyiDLcY
         6i2LowO2PLggxbPqwV9iYQyy43SgZ8vAn4X5lmH+w4JnLsrW+ATV1ziskqxFwEZROvW/
         KXzOnrgUoo7PjCl/g6lpTTniBfmKk/poO8Sjtq2nTdcOkbcP0f2H/QnbsLX21E4xEIZ5
         bzpJYgutBlvkPiqjXVXUKrROoeb3/KjlmA0hVV+cSxcF+MZ5YGOZN/422vb00IUg/QXE
         GLuw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780165285; x=1780770085; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Sjq61YPS+2EWRhm8mek9VpsMrYhJ4U81YWVgXn/kVH0=;
        b=iGvAp/8ppjPjSk9jIY5zGDoM+mS/2o16LvVENI5h+qPP979mjLBEWNw9HiRQm0QvSU
         iMF+NQxGZMuBDp2tP/zgs5BC23N8td8g47iau2cRUMQx8Rk8K8pxvDYvuT7vVSMx4qRJ
         CZUBwTfO+BKvnxntufFQ/cHfj/qcF+deqtwT/NwncL3u+SUS8zOarpmE2BN+7s+iFosm
         FBqO3QA9r8qdPI0Flo9LwaDvnGv5zi69asNxFXunmAnsNVguRDNb258Bq/Dc9jcdldfK
         /azCpaIvIpN633F23DbjTMLk78F4XMiMP7ND32OCh0l29IdruXtLVaNknJzB6aSFqag7
         q23A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780165285; x=1780770085;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Sjq61YPS+2EWRhm8mek9VpsMrYhJ4U81YWVgXn/kVH0=;
        b=qF2c4FJUX1FKdnmKj5qJM8kEq16hdbE6G9MYC6AqzlQvWK/S2Y9NpOqz4LgHoyF5y+
         +q6ud+SexPCanP2r8mFu11l2iWQaPdm2bzJe1BBa+OfgdZs2iEmWHrI22rcj+NiTSTp7
         8V8FYW/lAc8l3eMMNnGsGZqdm0+T274MN9xApnfraMlGEuJNTG6cXdqyXpAo0Bj9UxiZ
         X2+KXbn0T8hRmuxO9Emvt6P72g8C7fwimQXb6UX94p/klMr4BcDbuOg5TwBRw7nNz67I
         nVln8E7056hgRWFmb7groNRvu/Q64c8yvjqYNVxDwCDEZaPAWNaIYQ9gX3VgH0uznbkZ
         NMWQ==
X-Forwarded-Encrypted: i=1; AFNElJ98hilFyvDkeeaxRDwtmQc1RaePLS5EBg8sPTIoybmr3JtLmFGf+oYSgd4Pqes6wTvTm+Fg1O7s@vger.kernel.org
X-Gm-Message-State: AOJu0YzkGIgH2Zp94oj6+TSPMo/p9QDkIQB5piIYUwaIs8FuyFuTFASg
	SqcmMMO4WmOPpg9qyDDTO39t0sAvOfS/QRJlRTzdXA+V995fgydEujhTVSN7ZMaqNM/ARFVCJqj
	aTJ2alVNMsd2aNK8TS4ggkXe+ToTZCv8=
X-Gm-Gg: Acq92OEOoYsstCrFHXy0INIT6UgvEV7owEKphwAyowTO9DrO/aygouzhkzGcwX8v5jX
	7AE2em9jzKo/2Zy41KV4qN9hdjeRA/ZA0YjoDfwatbbvBbE9L1ccu+wUAl77cTTXm0bSjf9q/bo
	5S1bt8fu4+LMXakIteIX3DqI2ND5oSqgXIq9ne+9ZNfnhZ/ZRJfpV/MpHapTNS+ZpCbGPchEqaL
	rDIUVgLiJFy9wTw6qzwGoE1svj1sSfJ+i/JqId2qu8FKqlSbbmiYxgTfFIM9tFoaG19K/83fjS7
	GVXOWhZwloMGtsC4QODBOj5cSDBpJpVfCC/RYvGJTNP0xOXcKQ==
X-Received: by 2002:a05:600c:630e:b0:490:a2fd:e1e5 with SMTP id
 5b1f17b1804b1-490a2fde21dmr70218225e9.17.1780165284839; Sat, 30 May 2026
 11:21:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260527062247.3440692-1-youngjun.park@lge.com>
 <20260527062247.3440692-5-youngjun.park@lge.com> <CAKEwX=O-_OZ8x0UC96a_k+0eZfAE+mWMWDdn68uy1LHRq=JC0w@mail.gmail.com>
In-Reply-To: <CAKEwX=O-_OZ8x0UC96a_k+0eZfAE+mWMWDdn68uy1LHRq=JC0w@mail.gmail.com>
From: Nhat Pham <nphamcs@gmail.com>
Date: Sat, 30 May 2026 11:21:12 -0700
X-Gm-Features: AVHnY4KNVzosVVQicpkWlglXC22bvDfqtlOtZii0IsLLSrbEukjjd4dfH_fUg50
Message-ID: <CAKEwX=N2XcMHN1jatppOk6wnmz-Shab5XMtTtzgYOzRvU_6YFw@mail.gmail.com>
Subject: Re: [PATCH v7 4/4] mm: swap: filter swap allocation by memcg tier mask
To: Youngjun Park <youngjun.park@lge.com>
Cc: akpm@linux-foundation.org, chrisl@kernel.org, linux-mm@kvack.org, 
	cgroups@vger.kernel.org, linux-kernel@vger.kernel.org, kasong@tencent.com, 
	hannes@cmpxchg.org, mhocko@kernel.org, roman.gushchin@linux.dev, 
	shakeel.butt@linux.dev, muchun.song@linux.dev, shikemeng@huaweicloud.com, 
	baoquan.he@linux.dev, baohua@kernel.org, gunho.lee@lge.com, 
	taejoon.song@lge.com, hyungjun.cho@lge.com, mkoutny@suse.com, 
	baver.bae@lge.com, matia.kim@lge.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-16483-lists,cgroups=lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[21];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nphamcs@gmail.com,cgroups@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[cgroups];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 2B78261190F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sat, May 30, 2026 at 10:51=E2=80=AFAM Nhat Pham <nphamcs@gmail.com> wrot=
e:
>
>
> How expensive is it to add per-cpu caching for each device :(

to clarify - a percpu_swap_cluster per si for every si.

>

... or for each tier (assuming devices in each tier share the same
performance characteristics, and could be used interchangeably?).

Basically:

struct percpu_swap_cluster {
    struct swap_info_struct *si[MAX_SWAPTIER][SWAP_NR_ORDERS];
    unsigned long offset[MAX_SWAPTIER][SWAP_NR_ORDERS];
    local_lock_t lock;
};

Seems like 4 is the default number of tier right? So the extra
overhead is just (nr cpu) * 10 * 3 * (sizeof(unsigned long) +
sizeof(*ptr)) or wev?

