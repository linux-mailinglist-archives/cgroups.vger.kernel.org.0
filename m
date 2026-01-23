Return-Path: <cgroups+bounces-13405-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oLmECBKRc2l0xAAAu9opvQ
	(envelope-from <cgroups+bounces-13405-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Fri, 23 Jan 2026 16:17:38 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B32877AE4
	for <lists+cgroups@lfdr.de>; Fri, 23 Jan 2026 16:17:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2700E308036F
	for <lists+cgroups@lfdr.de>; Fri, 23 Jan 2026 15:06:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FC4728935A;
	Fri, 23 Jan 2026 15:06:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jk7Rht8B"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF8182FF155
	for <cgroups@vger.kernel.org>; Fri, 23 Jan 2026 15:06:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769180784; cv=pass; b=MZ5y4/06DVa6ZEiga8ORPOznSiuV7vQIn7O5Rk9wk/SVCLp0+RlN/2DeUzb9M2mZaFTjBFqphKWuaNiTQNYYe7w8MpLW91arYm5wtMtF3oUC7wQ1g+ZeJpah6kpyu4Of1TTnbpc0Vht1CO9+B7ao6xukH2Jq1IKyHldBeQP0Gl4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769180784; c=relaxed/simple;
	bh=bp32oonDOnHjCeFAW0yoNz/PodFJngfVEV3gIrxsHTI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pyXDjCnO92qEayIGvASrtPXBW42DQ27a9S+tIdAlo+vnRy79klSU4yuzX7jTJQRfwmCsNwuj/M5YAtR8/NsFRq4DJS8P72Y3zF3w1RerVmt0N/iARgYb//d37nrNGQ8Eo5EQuIS+RYyXyUrAiRlpKpY0jm771x0yca5IrlGOSyg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jk7Rht8B; arc=pass smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-598f8136a24so2709748e87.3
        for <cgroups@vger.kernel.org>; Fri, 23 Jan 2026 07:06:22 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769180780; cv=none;
        d=google.com; s=arc-20240605;
        b=RZ2lzOEajQ5fFaWcmGUX7r1wKKnTnx6dJXtkZEttU8K50PKRsTwQ8gdMi4A5WKhajH
         EvEH7G2ewK30TFJxl3Zy8S9ogsPIiFjaGunFrB02Gn/XE2vjeACkAD3nsjXj70uZ4la1
         UXEMNlXlmpvo80Oj66nujJWwSk7NJBbApCAE7RHwwXCmADKz5yCshAt6Q2sGBvdKOJug
         P0DKb49EHoqD++owSdjwnPOQQPRgURaTdEM2/gTbwMvp+0Pcc1bt4wsc86+JZEgcn7Ih
         8V6NL+mKepu5KtwPyD+6abCi3p6fdsQCLSL8spMC+7ooN/LOqyhvRXMvXfQZth1SlfzC
         bJ/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=bp32oonDOnHjCeFAW0yoNz/PodFJngfVEV3gIrxsHTI=;
        fh=mcBoSvU5d5pkGCf8+rxLJ/CTOdtEEBNDOcYIo5odaWo=;
        b=UsSMooA8VxVH5cWpag9c/ZbjxjJgUIx8jnaP3Zp+Qgjh8ZA/91CugI4SnkXET1O9rQ
         rNfohyQeBPe+MLpQG8/7TSOPSXECWb0oLLv4n8b1GHEUa63WFtbp8tbL2WBjqcfdTTUi
         BP2T5/hbSnZq1mBn2VgA898BWJT99ZY2Xw6n90Z9CLQP2l3YUpdi5LC5vK+nZq3APxLx
         kx3M8vjbd/zCQWoMolh9jrrCXM9nOOOV/v34c/vMN7dier2PAKSHSoEzAa/4uON5B3e3
         NUJMwVWrpJvlKFuuMkxRpIOZ2K/e69sOOaU5LyUzI1cPoJb9xwWS+muo2MxayQdjd+Et
         msLA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769180780; x=1769785580; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bp32oonDOnHjCeFAW0yoNz/PodFJngfVEV3gIrxsHTI=;
        b=jk7Rht8BZTH+V7s07HZd/Gn1LtWUmbTRE88KEsJIzsyOqHk+y5Nh91nR9sUgo7jYId
         MxO2G9VfL9LTDl8l1uGqpyAyQ6J///3UymA9TkwGTeRGL9C+hn62wauQKAwv1+SP9B2k
         YTp8yRVaBFYhu2jiVg0asNJ76y0uG7lV5jzn4Bb/WQ2Nx5QvBflFWLbLLaHJ1nXXMvtA
         RKeTRGWmuwvjaTPFrBHOAc/jJeP04rh3RhzNbeWEiKMWpCfOFUWjv7YagBPIdrftB0Jp
         gJCBMyvvOzw9cXHxiyHm/WB8gWra3KZKBKFWUOdcN7fkK78DA/ZVEcCeKmxLmdeHHhHt
         wbRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769180780; x=1769785580;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=bp32oonDOnHjCeFAW0yoNz/PodFJngfVEV3gIrxsHTI=;
        b=otebWvB/bUkwa9NTF3hlphVdzHd5DeBkbEGuBquLSB5kz19G5Yw+S+pmlQQJf2o6+b
         tyuhpdGjfrseOVivukFKVBcvWo+o8Fvk+6NChRMFeBZ3GzLnGmCz5WKbHsSHrnunMgyG
         5OjOV9mhS13D7ycQdn4fqISPUswMHZQK2QtF2u0WYI6hicRcq49+d0/ytqwYUJ7+YzCt
         ET0Qa3f6hjij2yBq6w+5pDD054DzUkob+16H0UPOANC/PvA7zaMkMaOwNq/ExyFFfunR
         cuj/bwqWJJV1z3HZPUYHGTcoR2R7EgF+xw4IeCUsRlTFAladQpYEFeaVRbAlKIxMTOXu
         zdlQ==
X-Forwarded-Encrypted: i=1; AJvYcCXq6ZA8iyUkn7fZGrwQztGL7D4K0cyqzrDIHdPyII85iiCwrJywjOUj8ImrxTxI+CCkwW60Nla4@vger.kernel.org
X-Gm-Message-State: AOJu0YzwR+VWtDC5QPAwcrAgikaydGe7mxXsLJbmKNamnFIZ2Dr3+DVT
	iFggMoW+NLPD0yYIBhCdF4oNiaH9MTfpzp2MGJ8Wb7XZpokl+vDHdcHvp80cO/NW9XOVWW+bYni
	nfGE9WiHEmmVvtPRxcIClduHSiMSCo4yhXVBmp3irjA==
X-Gm-Gg: AZuq6aLWayc9UmNSj0FYdn445Q57Z0k36s5iVxHIsf4NSf/CHl519LQi1+Oa8iHoK8P
	A6FQkiJrmpvYkjcN5r5hkxklz5lPK/GIqOrJBqbRnwPyEA81++RFVP6aMVRk1lEsF4YOnl69xRX
	+OPgybfemPjAZKmRc4NHFqQvSn81a3KhvtXBjkDWxEe3zIBwgQeK395m/HSOaZsloz0FL6K2iaq
	8jOi1qBLZplT9vAPOK+2TjjJIS2Z0b0X90J0ylPWDZvWE5ntU5WBgU1QDfepP1pEHrghw==
X-Received: by 2002:a05:6512:39c4:b0:59d:de87:dda6 with SMTP id
 2adb3069b0e04-59de48fe58fmr1261220e87.11.1769180779674; Fri, 23 Jan 2026
 07:06:19 -0800 (PST)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260122114242.72139-1-wujianyue000@gmail.com>
 <20260123150108.43443-1-wujianyue000@gmail.com> <20260123150108.43443-2-wujianyue000@gmail.com>
In-Reply-To: <20260123150108.43443-2-wujianyue000@gmail.com>
From: Jianyue Wu <wujianyue000@gmail.com>
Date: Fri, 23 Jan 2026 23:06:07 +0800
X-Gm-Features: AZwV_Qim9akAoBLCRpH-EQVL5a8WyN8bKa0p8a8c1vBamrGpm1kjsQOy5v7Q3zc
Message-ID: <CAJxJ_jjn0i9pEOTXJUS=WTLAde-6-YwdQyijHvZ16nXpmQ2JNw@mail.gmail.com>
Subject: Re: [PATCH v4 1/1] mm: optimize stat output for 11% sys time reduce
To: akpm@linux-foundation.org
Cc: shakeel.butt@linux.dev, hannes@cmpxchg.org, mhocko@kernel.org, 
	roman.gushchin@linux.dev, muchun.song@linux.dev, linux-mm@kvack.org, 
	cgroups@vger.kernel.org, linux-kernel@vger.kernel.org, inwardvessel@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[linux.dev,cmpxchg.org,kernel.org,kvack.org,vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-13405-lists,cgroups=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[wujianyue000@gmail.com,cgroups@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	RCPT_COUNT_SEVEN(0.00)[10];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 6B32877AE4
X-Rspamd-Action: no action

On Fri, Jan 23, 2026 at 11:01=E2=80=AFPM Jianyue Wu <wujianyue000@gmail.com=
> wrote:
>
> Replace seq_buf_printf() calls in memcg stat formatting with a
> lightweight helper function and replace seq_printf() in numa stat
> output with direct seq operations to avoid printf format parsing
> overhead.
Seems I still need to add optimization for memcg_numa_stat_show(), though
the change there looks a bit complex, otherwise it didn't get enough perf g=
ain..

