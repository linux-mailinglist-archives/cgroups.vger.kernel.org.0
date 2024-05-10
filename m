Return-Path: <cgroups+bounces-2847-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 28E478C1C88
	for <lists+cgroups@lfdr.de>; Fri, 10 May 2024 04:43:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 608E71C2139C
	for <lists+cgroups@lfdr.de>; Fri, 10 May 2024 02:43:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C11F148837;
	Fri, 10 May 2024 02:43:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KVGoX4Dd"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1A9F5579A;
	Fri, 10 May 2024 02:43:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715309015; cv=none; b=LidnE36AUEGXhLP0LMvfDm88v5vLidhfHgfCHWN5YR8hulFaKs1Ujz+XQSK1maBOWAoY498yyr2S9s4V72rkNh+Yyo5OrKxu8SatWhLJn/Ae+OUQJ047wRG2rANkMVnodH5GJiOBhp+nhsKhLT5shJukuB3txGtlJ1MqBCcf8J8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715309015; c=relaxed/simple;
	bh=h3NjcfgxQkvN6Dm0qeLjtqzQYAbriKkylaDfBSkN64s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=g7SZE3xTqutgtjVfoXIDFaZ1/kXcg4jAmRfRJKWnlCf/hBLd7yqmQt/M9ExYaZQTH6IYr5OtnbLjH1/cFK5dTOFyzBx4Aw7r/R0ZLHfMaiobVwBVjicOVVWbRbS6LRkDex3yOGXJo5BlHu6KeVVTUGzei8Xgn9koNw4pVDyUvG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KVGoX4Dd; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-51f12ccff5eso2040882e87.1;
        Thu, 09 May 2024 19:43:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715309012; x=1715913812; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g8bWLxZ3dWuYmospB5SpCzowfyzVsObI//ksFh6x8MM=;
        b=KVGoX4Dd5Doh9ccJ/9Qk4EPsRZ/jx5xVFsAX4Gu2688Z2F5Et5YZOnpd0D/xpRh7Ln
         rcIzN4Cvgvjw446x5EW3MNnJv9PDsPTFhpFryVTeD882v4xnkQ7XNfpWJz3QGJQOoooB
         p9e0iX0VR7ZHJ5w/xfOReu3076wy2bLKNCCEHGjkI6y75f/pPj2KRdQa/nHsZ6yZQKHg
         KG9l5ci2XZb+Q1tAroPGZ9bhV6qxz8QiM3YLrYAO94lZeAyiFt8ktkcqD+Nfk6pujX0H
         KyoRWTcRErtHqLQSJQ56imViZ+TfOpppAv/xcRz+eNZU5gHE0iPVmupL76BV3G5ox3n5
         xb/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715309012; x=1715913812;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=g8bWLxZ3dWuYmospB5SpCzowfyzVsObI//ksFh6x8MM=;
        b=vMZ7MXZ3Jgq7sqKkmraCzWKNcu2VdDKH3v7cIst3+krbtyANQnn4JXvQMLGT3Zk3/0
         MOa7GZwJWQnAUZhJoGIX3ozy6dPsqiuTYUDisJgLHDdGn99Zek71GdMesTcaMf7dppj4
         IJN8fM3HxLaMk7bpC/rYpDSF8ruFN3A3kEF7GEvz4IssJ44rZbhmsYJEkMYmUTZnUW/q
         GzbKGv9a0/pxikDzb49wpPgMUjnaStHXXmwm1Kc6NCvq9F0mODSzxTDo+/bpe1LElRrt
         3NtzL6JcmMdUIC6w8sdEpUscXK8SWTGjJaIvyhqNZI5Plu8RA1CnP9kV4a14k7xsUD1v
         +/6Q==
X-Forwarded-Encrypted: i=1; AJvYcCU/R50IymvCri1PNYMt12bPnDJ55AnZi5OW4QZcr3NOgNSQ+s8kn8kZLWtxmCoGp+UfEuKaCyjru2QfcMLr9JG1lmh6rD/54lg3Z+Q5kBDmhW1EeVysZB6sphYQAz8mkYvVhzeWOfzGomH7fnu8TEWNqC/e8AimBl9WZQFTWI8Cc8if
X-Gm-Message-State: AOJu0Yxlh5enc1NHtaDJIVAHB8/mEb+GioQeRx/ujoQjTDcUgQfxZbDq
	hpr6WkPMkiGGvnuNRh8pM8IduO54guAEhPe/2xR7GVPFkZuFjG65HMy/DeJvbcfWM5iVDwKsxQp
	h1Eui0qZ0t85n4yI7J7odrwarZhs=
X-Google-Smtp-Source: AGHT+IFhIfznkaEMQqLl9o1NxKnyivv7zGsM19YS4eYwjFwbY47MDQuu4EJX+dXxoZTHgNpQjgXvpatppIweYsGqr2E=
X-Received: by 2002:a19:5e4b:0:b0:515:b8d5:c5b7 with SMTP id
 2adb3069b0e04-522105844c0mr604760e87.56.1715309011548; Thu, 09 May 2024
 19:43:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240509023937.1090421-1-zhaoyang.huang@unisoc.com>
 <20240509023937.1090421-3-zhaoyang.huang@unisoc.com> <Zjw_0UPKvGkPfKFO@casper.infradead.org>
In-Reply-To: <Zjw_0UPKvGkPfKFO@casper.infradead.org>
From: Zhaoyang Huang <huangzhaoyang@gmail.com>
Date: Fri, 10 May 2024 10:43:20 +0800
Message-ID: <CAGWkznGZP3KUBN2M6syrjTmVOdSM0zx23hcJ6+hqE8Drgz2f-A@mail.gmail.com>
Subject: Re: [RFC PATCH 2/2] mm: introduce budgt control in readahead
To: Matthew Wilcox <willy@infradead.org>
Cc: "zhaoyang.huang" <zhaoyang.huang@unisoc.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Jens Axboe <axboe@kernel.dk>, Tejun Heo <tj@kernel.org>, Josef Bacik <josef@toxicpanda.com>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, linux-mm@kvack.org, 
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
	cgroups@vger.kernel.org, steve.kang@unisoc.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 9, 2024 at 11:15=E2=80=AFAM Matthew Wilcox <willy@infradead.org=
> wrote:
>
> On Thu, May 09, 2024 at 10:39:37AM +0800, zhaoyang.huang wrote:
> > -static unsigned long get_next_ra_size(struct file_ra_state *ra,
> > +static unsigned long get_next_ra_size(struct readahead_control *ractl,
> >                                     unsigned long max)
> >  {
> > -     unsigned long cur =3D ra->size;
> > +     unsigned long cur =3D ractl->ra->size;
> > +     struct inode *inode =3D ractl->mapping->host;
> > +     unsigned long budgt =3D inode->i_sb->s_bdev ?
> > +                     blk_throttle_budgt(inode->i_sb->s_bdev) : 0;
>
> You can't do this.  There's no guarantee that the IO is going to
> mapping->host->i_sb->s_bdev.  You'd have to figure out how to ask the
> filesystem to get the bdev for the particular range (eg the fs might
> implement RAID internally).
>
Thanks for the prompt. I did some basic research on soft RAID and
wonder if applying the bps limit on /dev/md0 like below could make
this work.

mdadm -C -v /dev/md0 -l raid0 -n 2 /dev/sd[b-c]1
mount /dev/md0 /mnt/raid0/
echo "/dev/md0 100000" > blkio.throttle.read_bps_device

I didn't find information about 'RAID internally'. Could we set the
limit on the root device(the one used for mount) to manage the whole
partition without caring about where the bio finally goes? Or ask the
user to decide if to use by making sure the device they apply will not
do RAID?

