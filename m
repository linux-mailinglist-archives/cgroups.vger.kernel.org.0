Return-Path: <cgroups+bounces-15443-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IGyIJ1yy52lZ/QEAu9opvQ
	(envelope-from <cgroups+bounces-15443-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Tue, 21 Apr 2026 19:22:36 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 42DD943DDF4
	for <lists+cgroups@lfdr.de>; Tue, 21 Apr 2026 19:22:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id A4F5530157AC
	for <lists+cgroups@lfdr.de>; Tue, 21 Apr 2026 17:22:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFC032FD1D0;
	Tue, 21 Apr 2026 17:22:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E6GYkV1i"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CF362FD1B5
	for <cgroups@vger.kernel.org>; Tue, 21 Apr 2026 17:22:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776792153; cv=pass; b=ghLorY0GdKP1U8sNiTTx7gqM7/PWHKGuisRuzHwY2kAzjTCZhoLCMJq5rpGoU7ycivN5UEQV/60pCR9J2qHa6Hru8DG7lgx7pRx5Ccxr/mA5Od3kEhKvCf3OSuSlKJRMkqOGyQfY9RalRXQ8Td+eiiuz/WBRBmHcNG4YUG5ditU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776792153; c=relaxed/simple;
	bh=R1MvViSilqEfwzlZBE8S5lO/F0sSfLo5/izkKWhC3Ek=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=em0riPkarjbvxHEISRpAFuoyI4Aj/NXEYY/8yMg8mBQy+qIVCQwzsYuszk1RaCBTGCnDXAickZicspHZ8ZjM+MgpxAdSR4m0IjmTkKkzFwgd+kwhndfkXPDMr5vaOr0t1VNvvraGpByF5EcWBtKun0UkfH0rFq7l2sLmGLNPISE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E6GYkV1i; arc=pass smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-676d8a1835cso650486a12.2
        for <cgroups@vger.kernel.org>; Tue, 21 Apr 2026 10:22:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776792150; cv=none;
        d=google.com; s=arc-20240605;
        b=eG2ob/WEHwEhLgdR0JbVjgXRY66Oh+53Uilj1OsEFY1fWGjAJZz0Ka0DyC+rpQqVGB
         8v43iEZPTusd7IUfKQ1Xz0qo0TjmWDwmJgiYscPlE0L7/X6I6dqEBkYoC2/kFdOOFcxg
         qi6hlwj2UT9HBQ2BG5Ikzg+ZgyrQojujwl6VRCN5nPDoOG6ezTWhhzcHcCzBh/UBjIXw
         0OFxKmLJod/TtSlVVcIc9q5LSIn6Zh57SIsghugBGYivGP9RSen4UgS+MqBgst9kEy8y
         /Kky9MaUrfXte6jzKk9xz1K8D39JRRrAX+ZqS2t8xUDRubdJnCHCGqr4LV/T3IITiTro
         V3Qw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=PcLBr7Pz5JgqfDdLDDrvjpb70+Buqpr5RFGb1YIZQMg=;
        fh=IBss/cWUFEw8prtetxc0J1NXryAZiOxT4WChL6dSMz8=;
        b=TTuRqaf0qBMoD8rBKecfsGmB1fXwHFWGskXmQYv2mzE2GLh6rbBRUE1DDvOriyfT+4
         L2UAWo25urvwsb+lX2j9KabPhBzy1TvgAfZ0WamGpiAR1mUW6am0uonOo8yZ9rY9HBdz
         uyOgHENEbRHg+t1i1/q7sqjcUBKecJ7+NA3Bs/q/Xa9//yzi4CO8omde7aLCBOtz07Fd
         teXyGV7CawkFGRZi7u2r64hXJXT6KTmQQ7FKL3on5QaJrY9yTovTyzAj+R/YG4pSco7k
         lw+PDI9HoWeHIus6lyJq2DTJ1bLCT+M1s+WPHKNF55v0+4ZgcIE9DFIKdoXo3zvdBlL+
         VXiw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776792150; x=1777396950; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PcLBr7Pz5JgqfDdLDDrvjpb70+Buqpr5RFGb1YIZQMg=;
        b=E6GYkV1i1QXaAq0ogi8QGgBB8gGIOai11c1wnltDqwDU8JdhfrtkbikAmq6w+SlD4M
         mgvORoDyqzVcC4y47+OXp/XOfOeHJI+Nto87Y/jEcmQ+MQorA6czJQKBxlxhRQuwAlsd
         dYqNCQKIS0uqYszuH/FYclne0tCmp8DlcE4htOlIrQ7DKo9s0fxX5owCUGRCDJn4tJdL
         U6rZkxky6jUAAcw5luh1iJo480x8tjbgPh9ve5Pp+q02T33AeEiy9LmMWVvmCbcsA5OR
         PQOHWfddSRaa33aUhrD1v+ely3N9AM63JpC+NOMxsJgEAU8SVvK+E7SAaipQZBWyz2KO
         UH+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776792150; x=1777396950;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=PcLBr7Pz5JgqfDdLDDrvjpb70+Buqpr5RFGb1YIZQMg=;
        b=TEqpxKWeFLtaw9eAf2Gwg71LT6uHmRQZsPM+mdDQ/J/M3FuhMIoShNi3r8DL3W+N8Q
         3cpQZmGVkszQ37rM/Q56pf9nIeW6MZ40pX2g3u1zOXcxPFILiuS1I/Sm0DGNiSZ2XIgp
         5vqbGeVP014TC4bVre4Ys2OwkbSLxLIQ5Wy5cLQ9wYL1sVpYIQefCRCCyHtHVvBbLTHa
         HirgDuT1fKqYr68xVY9PAIQvwDd3ssVxbBKktMuBepIpXT7xdHCetkq/M1dePXVSKG8c
         yXoqF8zbMpa8A6/+2oeCJ3DL3WWA/SHgFhlPcVVLZ6RQEah7xj5Jr3MlfnBz1p8LYx48
         lY4g==
X-Forwarded-Encrypted: i=1; AFNElJ8ye5nyLOQuVsk9RuREJX5f/0mZUa5VWxietP/1CMD2A6/OzpMZ8fWQfubNWtuLoEh6LWsQk3j3@vger.kernel.org
X-Gm-Message-State: AOJu0Yzi6F089E+sTLuc5LHfQPvaiu8nNta7VbrbsM8Z5PihxvBJIuRg
	nYR6FeAr9WRZpW+COgvRJA6QepErbpzHWJTanEGXUCUH4Deq1D/Cq7vSqK1gt0qbgLtW87d+8c1
	CVRJ9+KwO/pht4LEIseZTw8Hq9EgCf3Q=
X-Gm-Gg: AeBDiesMPpsDBNK/BvJLMoLdr1lV4AnUerSfXCrJPlhhHvpq1LKddHHNEsEb2FELeQa
	1t+rQNnJnsLMyUDuAGzI+lJtVmjswEE0QfMAxa1cS3iRnnaTKCB7dbFQr4+zvuhJaOsvJ7EJHB1
	qvTKRF7WgIOQIFfZC8cErxjxyDPS6YmA6I1RxjrFJLTeiwX8a3BaPlH+vTsrG7LfX9ApdyCu5VX
	3XTm3XGTv4VscmU3Vm4BhP9knTAxGkrWFQloFy/aTjzgauqhkLW88XN3JEEyUlFSxnZf1x1F9nu
	3MEALmutIOP/a7xvVC16RjGnxBjX2r7tmRE8xPvPnUuOoIrInYs=
X-Received: by 2002:a05:6402:e9a:b0:66e:5662:2121 with SMTP id
 4fb4d7f45d1cf-672bfd97db0mr7797694a12.7.1776792150367; Tue, 21 Apr 2026
 10:22:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260421-swap-table-p4-v3-0-2f23759a76bc@tencent.com>
 <20260421-swap-table-p4-v3-3-2f23759a76bc@tencent.com> <D631DCC9-85F0-4E68-88A0-AD5DE328818E@nvidia.com>
In-Reply-To: <D631DCC9-85F0-4E68-88A0-AD5DE328818E@nvidia.com>
From: Kairui Song <ryncsn@gmail.com>
Date: Wed, 22 Apr 2026 01:21:53 +0800
X-Gm-Features: AQROBzDl5z9C7yRxEIuCYiZdOdIilaUvBCXT_HbOfpgIJfVG6_TY6ZM0pxpis88
Message-ID: <CAMgjq7BDmGWaVWBL+52_c=jgs293bgB+Qe-MafKE7dWZRsmx9A@mail.gmail.com>
Subject: Re: [PATCH v3 03/12] mm/huge_memory: move THP gfp limit helper into header
To: Zi Yan <ziy@nvidia.com>
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>, 
	David Hildenbrand <david@kernel.org>, Baolin Wang <baolin.wang@linux.alibaba.com>, 
	Barry Song <baohua@kernel.org>, Hugh Dickins <hughd@google.com>, Chris Li <chrisl@kernel.org>, 
	Kemeng Shi <shikemeng@huaweicloud.com>, Nhat Pham <nphamcs@gmail.com>, 
	Baoquan He <bhe@redhat.com>, Johannes Weiner <hannes@cmpxchg.org>, 
	Youngjun Park <youngjun.park@lge.com>, Chengming Zhou <chengming.zhou@linux.dev>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Shakeel Butt <shakeel.butt@linux.dev>, 
	Muchun Song <muchun.song@linux.dev>, Qi Zheng <zhengqi.arch@bytedance.com>, 
	linux-kernel@vger.kernel.org, cgroups@vger.kernel.org, 
	Yosry Ahmed <yosry@kernel.org>, Lorenzo Stoakes <ljs@kernel.org>, Dev Jain <dev.jain@arm.com>, 
	Lance Yang <lance.yang@linux.dev>, Michal Hocko <mhocko@suse.com>, Michal Hocko <mhocko@kernel.org>, 
	Suren Baghdasaryan <surenb@google.com>, Axel Rasmussen <axelrasmussen@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-15443-lists,cgroups=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[kvack.org,linux-foundation.org,kernel.org,linux.alibaba.com,google.com,huaweicloud.com,gmail.com,redhat.com,cmpxchg.org,lge.com,linux.dev,bytedance.com,vger.kernel.org,arm.com,suse.com];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[28];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ryncsn@gmail.com,cgroups@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[cgroups];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,tencent.com:email]
X-Rspamd-Queue-Id: 42DD943DDF4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Apr 21, 2026 at 9:14=E2=80=AFPM Zi Yan <ziy@nvidia.com> wrote:
>
> On 21 Apr 2026, at 2:16, Kairui Song via B4 Relay wrote:
>
> > From: Kairui Song <kasong@tencent.com>
> >
> > Shmem has some special requirements for THP GFP and has to limit it in
> > certain zones or provide a more lenient fallback.
> >
> > We'll use this helper for generic swap THP allocation, which needs to
> > support shmem. For a typical GFP_HIGHUSER_MOVABLE swap-in, this helper
> > is basically a no-op. But it's necessary for certain shmem users, mostl=
y
> > drivers.
> >
> > No feature change.
> >
> > Signed-off-by: Kairui Song <kasong@tencent.com>
> > ---
> >  include/linux/huge_mm.h | 30 ++++++++++++++++++++++++++++++
> >  mm/shmem.c              | 30 +++---------------------------
> >  2 files changed, 33 insertions(+), 27 deletions(-)
> >
> > diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
> > index 2949e5acff35..ffe5a120eee4 100644
> > --- a/include/linux/huge_mm.h
> > +++ b/include/linux/huge_mm.h
> > @@ -237,6 +237,31 @@ static inline bool thp_vma_suitable_order(struct v=
m_area_struct *vma,
> >       return true;
> >  }
> >
> > +/*
> > + * Make sure huge_gfp is always more limited than limit_gfp.
> > + * Some shmem users want THP allocation to be done less aggressively
> > + * and only in certain zone.
> > + */
> > +static inline gfp_t thp_limit_gfp_mask(gfp_t huge_gfp, gfp_t limit_gfp=
)
>
> Would it be better to rename it to thp_swap_limit_gfp_mask() or something
> more descriptive? I am just worried about misuses in the future due to
> the generic thp prefix.

Good idea, I wasn't sure if this might be helpful for any other user,
but for now naming it more descriptive does help to avoid misuse.

How about thp_shmem_limit_gfp_mask? Ordinary swap is fine with thp
gfp, only shmem is a bit special.

>
> Otherwise, LGTM.
>
> Reviewed-by: Zi Yan <ziy@nvidia.com>

Thanks!

