Return-Path: <cgroups+bounces-13013-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 68188D083F8
	for <lists+cgroups@lfdr.de>; Fri, 09 Jan 2026 10:37:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 50E4830CF7D4
	for <lists+cgroups@lfdr.de>; Fri,  9 Jan 2026 09:31:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C45D03563C8;
	Fri,  9 Jan 2026 09:31:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="E2LN2Okl"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2433332ECB
	for <cgroups@vger.kernel.org>; Fri,  9 Jan 2026 09:31:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767951087; cv=none; b=mW7J2Y2t8rKWqmIorJzcBpeX9mgARqE4scK4FN1BQnyZWaNGw+Lvir4lfXMkHdADMbwqdRcnl4naiUE+ktACH1H1b8BWywL7LvWHSZQRGZq3/x/BLHH6KHD5o7Mop6e3x037ay6exCIGmxZ4b/vOBdpjKzEbsbTU8E0yXuhrkKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767951087; c=relaxed/simple;
	bh=HOUvCNWeC/QU/EutK4DSQdm70DXyuV5GqGuLIHtLRCs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OSg2wPCg4AvgA+M9YnYoDf5+lmy5CARkYrpdDDOXZT+4vQxtKOzPEYJRAlJn2vcEuZOKCZzamD3h6zSpOzAJn/ZFuoADPNC/qohHJYqRQyzEjk9IwcWMrpo2KNeZEuzCS+g7JAIlOPmcwtnDjANoslCpTJFLtFge/0qvf1qgIcM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=E2LN2Okl; arc=none smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-88a26ce6619so40170046d6.3
        for <cgroups@vger.kernel.org>; Fri, 09 Jan 2026 01:31:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1767951085; x=1768555885; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=mHnWhSbgGLtJHz6aBPfGHzXRQNyBXUT1iG+fdLJ00Bc=;
        b=E2LN2OklxhUTYxe+6j9IomTwaGFt4u6zrIA6Aa+MdSMWAEyj5b3BtJ0pjpb29hz85G
         kGz6Y8bJwA8+q/DK5FDo58IQd1gMpHuXQRbuI1Zre3YG3UpuLWwVjCe7YgQDhhFbbcq6
         Vj6VUNLBp/UFH5wCwhYQebaLqARoMRB70J6C7o+ubU/goqs6V6/M2b0NvHsrFAKh4lZf
         A4dMJ2TyszaH0Cy3HFLs9cuvDpUwMplU7cKZQVkr7Nfxe1r9QeqQrKlS0BNsEtjv6Is7
         C09rJyxDqvOrJ4ahdfxq3topIkRUzbKy3n8kZCp8YR8lGE/uUiEqYmcY+sdzJB+5H+i6
         GRIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767951085; x=1768555885;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mHnWhSbgGLtJHz6aBPfGHzXRQNyBXUT1iG+fdLJ00Bc=;
        b=D4ljAjfH18Nwkmf7odSYqEsN2rHOkb/xHjKQbCbPD6v0/BS2XVEEPkfVjqVzsVEWq8
         hRxNvalYEs8XMcnTxA1Ysa3xcw/Ihrpr+7UlYwsyHPiMxSM7xy5RJuxxNdGNWxrRl5bu
         HmqjrruQLoUESb0TZOs1C+1UrsehyeJN1nGHkey7wXzW4T9fsM0lY+NN4KtBAPmSsHYe
         y9wr3UW0h7lxqNdy2HZR0l2Kl4ZiYlqZRGeYIe3BFxj2EVjqRHVWD2mNVO3nipyxdOP1
         dOu94J0LhVyW9o1O0xgeSqXJt8kbxdSvHOLssSoiyE2XLWVjo6CwreJKpzMHvG5jotnL
         DUmQ==
X-Forwarded-Encrypted: i=1; AJvYcCVCeEkrmtApvyGINADsAZov3Wop0lpiQhUMYkwg0oKlNtYpOICLG35uLg53ngneUTj+Q21GEw7E@vger.kernel.org
X-Gm-Message-State: AOJu0YyZNybtLn2Xa2Z1kf44Ueb2EPS+/w+fLrdJR/VmoPRluFdSCjmv
	lDZPvmSOTRL5LVNYiIkKLs0S6vp4AhcGrb4UB4khAR9SA74ddQVGdT28Zx0RS2Ythu6oX+QtjGL
	fwSs0bL3QN4da9bbCqUteUvuVM8tJzdu4wNoLO/qW
X-Gm-Gg: AY/fxX4M18BnfnG8eUgUT53t3FjcsPd65uh41qyOSi+Y1WVeBbAQNMLiKaaaZdwL6Db
	CVrPHckRypKBlcxr/jSBL2a0hoQxTgP0Nprk+kMA3eG7IRrg6CNYDOFIx6Ek4oYd5WU0PHL/rG8
	kywWsStAirnAhgBOf8zynz1B6W2UlO9uf1fRFuqzrLC36kkS1j0Ce+GL3lgIqYdir/D/gKgtBNO
	qFWyb4A8b7SLoHbJq4P6rl9GJJKfgbnCX5r26WsAkgCITSuCoYB2slnnEcTnw2gzaoB2ys=
X-Google-Smtp-Source: AGHT+IFuFRZsFV/d44doIWgLvsMS/CZDqe4Cye+eagGw1hb+ysMh9BDNkivJ6fQHv4v5oqRYdhbNmI5coNvj7Pn6Sz0=
X-Received: by 2002:a05:6214:485:b0:888:8088:209e with SMTP id
 6a1803df08f44-890841a3ab6mr123084486d6.16.1767951084728; Fri, 09 Jan 2026
 01:31:24 -0800 (PST)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260105080230.13171-1-harry.yoo@oracle.com> <20260105080230.13171-2-harry.yoo@oracle.com>
 <CAG_fn=XCx9-uYOhRQXTde7ud=H9kwM_Sf3ZjHQd9hfYDspzeOA@mail.gmail.com> <aWBfZ4ga9HQ8L8KM@hyeyoo>
In-Reply-To: <aWBfZ4ga9HQ8L8KM@hyeyoo>
From: Alexander Potapenko <glider@google.com>
Date: Fri, 9 Jan 2026 10:30:47 +0100
X-Gm-Features: AZwV_Qj86V__IEzdz2ouZQE2ozn-rnAWTPpJPtDCUGLbUdOgH8MfcTAHgVsMofI
Message-ID: <CAG_fn=Wyw-fGGQ802A1cUpkHHTnZi5gN7wZzRaF1s31SPOpC9g@mail.gmail.com>
Subject: Re: [PATCH V5 1/8] mm/slab: use unsigned long for orig_size to ensure
 proper metadata align
To: Harry Yoo <harry.yoo@oracle.com>
Cc: akpm@linux-foundation.org, vbabka@suse.cz, andreyknvl@gmail.com, 
	cl@gentwo.org, dvyukov@google.com, hannes@cmpxchg.org, linux-mm@kvack.org, 
	mhocko@kernel.org, muchun.song@linux.dev, rientjes@google.com, 
	roman.gushchin@linux.dev, ryabinin.a.a@gmail.com, shakeel.butt@linux.dev, 
	surenb@google.com, vincenzo.frascino@arm.com, yeoreum.yun@arm.com, 
	tytso@mit.edu, adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org, 
	linux-kernel@vger.kernel.org, cgroups@vger.kernel.org, hao.li@linux.dev, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

> > Instead of calculating the offset of the original size in several
> > places, should we maybe introduce a function that returns a pointer to
> > it?
>
> Good point.
>
> The calculation of various metadata offset (including the original size)
> is repeated in several places, and perhaps it's worth cleaning up,
> something like this:
>
> enum {
>   FREE_POINTER_OFFSET,
>   ALLOC_TRACK_OFFSET,
>   FREE_TRACK_OFFSET,
>   ORIG_SIZE_OFFSET,
>   KASAN_ALLOC_META_OFFSET,
>   OBJ_EXT_OFFSET,
>   FINAL_ALIGNMENT_PADDING_OFFSET,
>   ...
> };
>
> orig_size = *(unsigned long *)get_metadata_ptr(p, ORIG_SIZE_OFFSET);

An alternative would be to declare a struct containing all the
metadata fields and use offsetof() (or simply do a cast and access the
fields via the struct pointer)

