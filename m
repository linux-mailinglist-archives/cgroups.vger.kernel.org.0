Return-Path: <cgroups+bounces-12240-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 15F0AC9941F
	for <lists+cgroups@lfdr.de>; Mon, 01 Dec 2025 22:50:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id CB5B44E1DF0
	for <lists+cgroups@lfdr.de>; Mon,  1 Dec 2025 21:50:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71DC527FD5A;
	Mon,  1 Dec 2025 21:50:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vmKyM0fb"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C64F12773EE
	for <cgroups@vger.kernel.org>; Mon,  1 Dec 2025 21:50:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764625825; cv=none; b=Pr4PvPwXi6Qe2BRE0ctMelhKJ9M7N57EQO6cyet9d3sAqyXFZU8iOZ0gF1RKq6WnNf2uFuh81o5K4CPv94PWq2G0JjInM503JUiErL4MDrXrMDKiz4t3R2kn2GUR7qT3/HJcSr8JLYCbDCWrSSFEaltGvNBIoIQuijyytJQZfaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764625825; c=relaxed/simple;
	bh=5xI0Wiwoh8fbBvEfYRU3LzFos6dA4cQFp11i8NUqJCk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NzP698d/gefMaSEgzdHRL/+D3YShYqu6wiPbDVux1RwuuQKkfbnCb8N/CVflVZZGzc8M48kEvFF5V8BAbK/+9933eSaUtH2/GsV3Po/hkFPpDDOU/+6zKwhyBAVm6k/YeZlLSCIahCoLn4py5o37Sy6R7QNWhsUcCmssAnZmQiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vmKyM0fb; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-297e13bf404so841575ad.0
        for <cgroups@vger.kernel.org>; Mon, 01 Dec 2025 13:50:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1764625823; x=1765230623; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q2gUPjgy4QIw2gnMHv+tif1esrjSyW7hWgpM3/SSnsU=;
        b=vmKyM0fbFQDVnp51ubgcOSUXfYh33DQBis/iVQ85ZHBgTSwsEmJtKdltm9fadr/h3e
         eqe9dAfGoUdgEMFoqp0NxOIsCLlX7bQFxvp/vStdFUYu/Pd5izbdK4r4H4NV4fyQbHSv
         BH75Iq1JJvQ/5RgiiOv6vBtFPkUmHpEjLh0hpT7/N0bLTHfICDL2/6ZoLHH5+FjmVJGQ
         j7Y2aFkwVetsH3lBjpysvBCKaUnB0/UPQ+V9tYwnl07NHUkxOjXr5DgkjEldywNy4xJd
         iKfwgQY2qy+xgvoUtfSrf4JokWxBHd4x1Jv8ibHdKYE17IyvN6zTruT0DBRuBaKC0VsQ
         BYKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764625823; x=1765230623;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=q2gUPjgy4QIw2gnMHv+tif1esrjSyW7hWgpM3/SSnsU=;
        b=rUXnh3voVMPSnjbBK8iEXMwhqYDBjIW4/CsxzkA4g7H6ir22YJJQuhhuX9hviiA63H
         fwUeZj3uCdD8Q/7AMcFKmwtqGD+4UPKLSK7AcBZKO9rl3Wbeg461+jpo/jEHhBzAJCM/
         B7t954xlUDysGM1EoipGiYvJkV5UesCPXw/MJYz/ae9zJ4BGWFK+yDj77+hXIA/luoxC
         N1wr5iN8IVyrboROsZLj41sFPFJM/lv3yv/qrf23V7Lu6W46/c0lFbVp7Z5C5LSe3Ibq
         AE0fSjJMSPE4rKQuZ35LKzci2bScm9jK7esdxIw3mhcVEb0+PipL2Wf8gIfpDIKo2CZe
         Mshw==
X-Forwarded-Encrypted: i=1; AJvYcCX70w8ufuDWKKtxQ0v5gv/URx8+uJ0L3FEw3+3IslJzzQYxo7H6cQ1onsUs3my+72VPJh7rGBv0@vger.kernel.org
X-Gm-Message-State: AOJu0YxzKk3xooSLYYKTplhUfsoVr4sHjbwrRv8q3Lq0iLPV2NR4gG/N
	8kH7KJdB6c5X+ddttCVIEf3JvztEbLQq85zKSLvVs/8ope3aCYCTLglRB9ctz7nQWaPCP5Mxt66
	wfc1YmMYyfBRKkn9ssVIiZ95i/JQG/UHgoP1V7jP7
X-Gm-Gg: ASbGncv0tBUrA9WSbOzZ6eH12l+ghbO0/ORGHSehyjmD6kgGxXu+CjQZDMxu79ctO3m
	CRWa9eALC7D1ZLMaq2GKFHk3AZ+hf/nONWocm3mjUM21Po50fFxSLSp+8qGnsL5BcGvT1b6mQsU
	NlpZf/m/uRtmae65smed85RwHUeHAF4d4e2Y9hKZzzLOpnqBGTfTSfsaa2+iM3rIZwf9gFY96FJ
	f0dHzVBHvo18BfiwGfG6+4zgAtOzczMj0pjvg5VLbLly9hOcjDrxNatq871ovjHb/wM2c/3Yre4
	hhYUAhrvMBYzT3cj2nK2GEKlBWMn0gbD4nEl
X-Google-Smtp-Source: AGHT+IFZrEBPEwSxzhOmS8uuG96bGPRRU+0NJa8p5/NRXXSDZscDNgunlTkO6XNKQNHp0JAq8PbHUoSf8DvZ+St2LU4=
X-Received: by 2002:a05:7022:248e:b0:11a:b4dc:7773 with SMTP id
 a92af1059eb24-11de93cd604mr5101c88.12.1764625822731; Mon, 01 Dec 2025
 13:50:22 -0800 (PST)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1761658310.git.zhengqi.arch@bytedance.com>
 <cdcedd284f5706c557bb6f53858b8c2ac2815ecb.1761658311.git.zhengqi.arch@bytedance.com>
 <aScFNZjGficdjnvD@hyeyoo> <d94fe146-5cc6-4aa2-bd7f-8ca2a12e5457@linux.dev>
In-Reply-To: <d94fe146-5cc6-4aa2-bd7f-8ca2a12e5457@linux.dev>
From: Yuanchu Xie <yuanchu@google.com>
Date: Mon, 1 Dec 2025 15:50:05 -0600
X-Gm-Features: AWmQ_bmucHH7PjZPrG-zr0XHjjK8BpYhPNCrv2p7J9Sx_HpipEbnRaKoMz7jOFg
Message-ID: <CAJj2-QHu3u1RQpkBw8uV9P+-xop+bJvxt+s-ZB_cj=u6ia+tbg@mail.gmail.com>
Subject: Re: [PATCH v1 23/26] mm: vmscan: prepare for reparenting MGLRU folios
To: Qi Zheng <qi.zheng@linux.dev>
Cc: Harry Yoo <harry.yoo@oracle.com>, hannes@cmpxchg.org, hughd@google.com, 
	mhocko@suse.com, roman.gushchin@linux.dev, shakeel.butt@linux.dev, 
	muchun.song@linux.dev, david@redhat.com, lorenzo.stoakes@oracle.com, 
	ziy@nvidia.com, imran.f.khan@oracle.com, kamalesh.babulal@oracle.com, 
	axelrasmussen@google.com, weixugc@google.com, akpm@linux-foundation.org, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, cgroups@vger.kernel.org, 
	Qi Zheng <zhengqi.arch@bytedance.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 1, 2025 at 9:41=E2=80=AFAM Qi Zheng <qi.zheng@linux.dev> wrote:
> > Warning 1) Here we increment max_seq but we skip updating mm_state->seq=
.
> > (try_to_inc_max_seq() iterates the mm list and update mm_state->seq aft=
er
> > an iteration, but since we directly call inc_max_seq(), we don't update=
 it)
> >
> > When mm_state->seq is more than one generation behind walk->seq, a warn=
ing is
> > triggered in iterate_mm_list():
> >
> >          VM_WARN_ON_ONCE(mm_state->seq + 1 < walk->max_seq);
>
> The mm_state->seq is just to record the completion of a full traversal
> of mm_list. If we simply delete this warning, it may cause this judgment
> in iterate_mm_list to become invalid:
>
>          if (walk->seq <=3D mm_state->seq)
>                 goto done;
>
> So it seems we can manually increase mm_state->seq during reparenting to
> avoid this warning.
Agreed, don't get rid of the warning as this check is supposed to make
stale walkers exit early.

>
> However, we cannot directly call iterate_mm_list_nowalk() because we do
> not want to reset mm_state->head and mm_state->tail to NULL. Otherwise,
> we wouldn't be able to continue iterating over the mm_list.
>

From the original posting:
> Of course, the same generation has different meanings in the parent and
> child memcg, this will cause confusion in the hot and cold information of
> folios. But other than that, this method is simple enough, the lru size
> is correct, and there is no need to consider some concurrency issues (suc=
h
> as lru_gen_del_folio()).
One way to solve this is to map generations based on
lrugen->timestamp, but of course this runs into the reading
folio->flags issue you described. I think the current method is a good
compromise, but the splicing of generations doesn't much make semantic
sense. It would be good to leave a comment somewhere in
__lru_gen_reparent_memcg to note this weirdness.

