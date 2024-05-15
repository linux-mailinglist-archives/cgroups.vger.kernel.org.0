Return-Path: <cgroups+bounces-2910-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id ABE118C60C9
	for <lists+cgroups@lfdr.de>; Wed, 15 May 2024 08:32:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5F4691F211E6
	for <lists+cgroups@lfdr.de>; Wed, 15 May 2024 06:32:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C309433CC4;
	Wed, 15 May 2024 06:32:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l9gG0Zf0"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 510861E53F;
	Wed, 15 May 2024 06:31:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715754721; cv=none; b=t/RYriT+z0lYN0aRpPIoaKWoQGtdf6WQqrfas+DE2Z5QMf0izuyQAMJZ7FUrBuSMQctbu9vMormwlTxeEDB7la2aKpo2iOc5bpQ57KXBniwVxdtjbm/JUpStXMgAlPxqnaL9Bxma30YIMrylYlsrb15lctFRoL/3kn7Ug1MgGR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715754721; c=relaxed/simple;
	bh=SMe88j30uJlqLy1VfHIE4rYvL+Pl2XRda8aPFrB8pg0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hIsnYtSbPwvKmbyjDyij/sW/UaaT6/AnE1boaVxl/zsda6K6Z58QGt11xh8z6eNGYq5NFJ8G9V6YhZgzfSUAE1SU68voL5E8yMApnUTkpAb0oIcRKItkRlhjxtQNjtVooqzxtvfYf3XliVj3qTzAAGCnyEb/5avQiw0N6RP/cMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l9gG0Zf0; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-5238b5c080cso811553e87.1;
        Tue, 14 May 2024 23:31:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715754717; x=1716359517; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KO/Qnq8uu0A2bAHSPuBz0lil2/aJMgXXAcipsRcH8eU=;
        b=l9gG0Zf0JqRHxzAsIf98ffv7hZlzQA0TQxvBRpgnMCA4iM2FKPQFjdTIpYxzYGvzfy
         1cg+5FjYvp5GFLhf307IiaD3jgpyIhwoAynsLr9A2P4gUO12ZYNM93sS7uCvAT4h3LOF
         HgCwDznA2tp+uQ0E5OKCJpyceRhKBnrJlvIFF+gAJwrg+keSXuqAgq6vJZ45aAWIjmDG
         CdYMjENuCROS4ykt5Xwa4mqfVz89bkaGwt/vId3qt6Zj1HMTSaNJd8F93o0TStJuzCzz
         teXdTlHzRywOsRTEQFdLoulF/8mPD69j77Hn5Mj/oDmsvuAaYCwbXlZvEW8huqXgrbMU
         41lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715754717; x=1716359517;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KO/Qnq8uu0A2bAHSPuBz0lil2/aJMgXXAcipsRcH8eU=;
        b=Yg5DwL9qduKj+eMUDdPiOIzIWwbztsojpfkTZIzKyUlXp+Z926J1qM+UYAnvz13rGA
         ftHy6u9aRlBYKqgAt/rezENvj9Gp7I3iO/JeB6/whUGKfrc4vC5ZGkpg9wv96xyCJr/L
         CyI9t886+L/Y0jhNEYEMYm60dY12dRyBihDsmYdYeUYuJepzwesMiao7d12LtWMXKpuN
         sA+rW7GASiwWtsMnRxAw/4fCOfzlJO5K82D87XKx5tT0Jw5twVSMaZuveVvT3dIi+0zo
         /MIt2UJGN93gBhoqlL18l2D6zMM2mCK7oZzeAK7qfKe/QWxIiUoeBInHnQpUwthnODtn
         lJMA==
X-Forwarded-Encrypted: i=1; AJvYcCVZkuwwHBpNGECGhcoyzMa1rwCvknuOdoO4YNpBYvCnst24DYvE4t+on/J2DV1GNbBaldApUp5pqdwekJJVGaAtOl+3qwlzDjfoPnagoB7SLNZ5MkQBSc1mHKXGh/vnOnpGinU2m3kplJSYAXKHElB5lxdf7xdDyhN3KOfk51RPqRW9
X-Gm-Message-State: AOJu0YxQqdkvsnoiRfSHVjvpKlKcz4G/QWgfSDDRaxO25XMdFYMMM+Gi
	nwQLJ9Y7UeMRtSuK7RAQJsFxSIbC6c43KNse1w3Wfj2HvrLEBhqe31iL/raoatMO4UddpN77Dh+
	ufHPffUKzfLB/fdirlWeR8uw82Wk=
X-Google-Smtp-Source: AGHT+IHoKg0Vu+Ev/OMzjy0UIYtyUIbh89ctl6Q2Uk+JY2wl6Xd+Yslf9XhsdnZpO7qUHzF5fIdfEgEnHzxHsvSQbzc=
X-Received: by 2002:ac2:58e3:0:b0:518:dfed:f021 with SMTP id
 2adb3069b0e04-5220fb749bdmr7624802e87.24.1715754717250; Tue, 14 May 2024
 23:31:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240515012350.1166350-1-zhaoyang.huang@unisoc.com>
 <20240515012350.1166350-3-zhaoyang.huang@unisoc.com> <ZkQ1dsHKVttb7y4_@casper.infradead.org>
In-Reply-To: <ZkQ1dsHKVttb7y4_@casper.infradead.org>
From: Zhaoyang Huang <huangzhaoyang@gmail.com>
Date: Wed, 15 May 2024 14:31:45 +0800
Message-ID: <CAGWkznH1dxyF17cQi+9+0EadoG7_MVUNy8n-svQ7ZjYNaWKYdQ@mail.gmail.com>
Subject: Re: [RFC PATCH 2/2] mm: introduce budgt control in readahead
To: Matthew Wilcox <willy@infradead.org>
Cc: "zhaoyang.huang" <zhaoyang.huang@unisoc.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Jens Axboe <axboe@kernel.dk>, Tejun Heo <tj@kernel.org>, Josef Bacik <josef@toxicpanda.com>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, linux-mm@kvack.org, 
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
	cgroups@vger.kernel.org, steve.kang@unisoc.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 15, 2024 at 12:09=E2=80=AFPM Matthew Wilcox <willy@infradead.or=
g> wrote:
>
> On Wed, May 15, 2024 at 09:23:50AM +0800, zhaoyang.huang wrote:
> > +     unsigned long budgt =3D inode->i_sb->s_bdev ?
> > +                     blk_throttle_budgt(inode->i_sb->s_bdev) : 0;
>
> NAK as previously explained.
ok. But this commit could work by following the configuration of
blk-throttle as long as it works on btrfs with internal RAID on.
Furthermore, this will help the blkcg meet the desired BPS value
perfectly.

