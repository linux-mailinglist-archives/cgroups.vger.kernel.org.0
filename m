Return-Path: <cgroups+bounces-2851-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 43FAA8C1EA8
	for <lists+cgroups@lfdr.de>; Fri, 10 May 2024 09:08:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C50CE1F22047
	for <lists+cgroups@lfdr.de>; Fri, 10 May 2024 07:08:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3998A15D5BD;
	Fri, 10 May 2024 07:08:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mif1VYEC"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 667F914F9DB;
	Fri, 10 May 2024 07:08:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715324911; cv=none; b=hwCGeKkhZMMohOzO42vemzQNbdiyssV+8buCtG3BFgzJAO2+tYYe15ZUOzRNdia/QuClxuv0JOmbEWWEtF1XDFrM6aMifkSQL9V59gyvvygu8umHPruAQSgJhChIIYhSlfxNsxwuwGl0DMF79w+tbuLat+MlGpjAmG87dYWqO00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715324911; c=relaxed/simple;
	bh=w5prwPVj6Yc48Ni3OyBglPrfbJeekzkh9RlT7isx9bo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=a922MaJm9GuW1a6nNQwo4XQ7f4WCmY9UzAte6ahCNN2tmq1dBiFM9R1vtm6r+/KUUhIcJTpExWHL2VpDY97QAv3tVjrlVlqDjhTSY6s8wEWce4m8r2zpDI11Uvk1WFR4gnKPVrAcqpqPcDN5O1FUhdT02r0OWbkZk2xT+8+zYHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mif1VYEC; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-2e3e1ad0b19so21631251fa.0;
        Fri, 10 May 2024 00:08:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715324907; x=1715929707; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kQpYhVWiwVE8cmCno40oEMnygIoEgCFHvNbUd5F1nhQ=;
        b=mif1VYEC9vA8bP/MqqMmj9rWCdvrEzcN44+eE9eyVcv0wfZtyaGBXpfFynnbxajAH9
         urYQ7WE3lkhinQXYn+IABOusr1RH9sWfX4Lyerxh2FX3W3/fS9ei9am8ss1SJ7Lj6B5S
         cuKcUmTCSbIX9yU/DqmkbPnijHZMpb4/ilPUejsdf2gAIWmKFqKBrnkPhfKosM1iHnHy
         b+45NvxqkGTwcLKDtWtwxtkgOyG3EC+PG4jcklCENJ6OaoGcFjI4RCOmB2k14Dm7U+pu
         iVEXOVt+taW7AzQCcAUg4mcmpLS9iygcucWzuFlCNv9eBvTquk5Q66Qrb2MFHl4cdppD
         dN+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715324907; x=1715929707;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kQpYhVWiwVE8cmCno40oEMnygIoEgCFHvNbUd5F1nhQ=;
        b=pQqWWPk1oMmRx33X9sWc7tJrZeKO8KUQ7C6Y8e+7zo+o3xnYZ4i17yjdMNg3jACav4
         x0+oRM2JlKvU58xwkRe4z1oFEzZxM9eoDJ4JhHDhj8LfcFCaMO213eoHEih40Jv23hvL
         G4Ai3KNCSTElrtWwAN0YCQQoNHOt6v4/HbSyP22Bw6qV62mPhZJ86Q6AODCYRsyutHxz
         ofD/aTdJ9o9kP+CHgK/oTwewx2c4gXs+lPLuSITC6ZKMpu3WfidFSVfMO4lmKmCqjeqD
         PjgDZ8cSkkXxP7BfCAaIkQR2IwviMwxeizM9ovlzdipydstoD/mGEX5O082eD/jX/5Wv
         jVOw==
X-Forwarded-Encrypted: i=1; AJvYcCV1CxC64ql0Up6XFoBrn2AKFv2jHa98BNq3huEIu1U2zAPy+rUmI6kUHGJJMqU/r/v1M4bC2e4ro4MkXUfUzwM9EoPsQaiwFxv6zJqe+EhlM3R/SvRtUgnCW93b28UOnIg5X0UA5pedEtQIEOyplMHNW9eiO1wULhl/RmU5p3QVlmzO
X-Gm-Message-State: AOJu0YwcjC6pEWE9Niuujap0DYO0Gi15ec2F4BTfROQ/rsiBfD8csYX8
	RTQr+UQ2/RZTI/yj2eVjg2/mMcNe2wW1U8aLIReMXOPgKu1YgPFMGzGJaDkiqruIYMjXqkE0N/T
	qjO7f6aKfMqmJnLb/CSl81nCOvxSDoA==
X-Google-Smtp-Source: AGHT+IHOZth7N0KOc57ZvmrChBT08+2DaHHt8hsfG1urm59128I1YZ+hCNdlQAGG18kUtdLjuDrukcvmGv0T1jIhxQ0=
X-Received: by 2002:ac2:4c85:0:b0:51d:1c86:a274 with SMTP id
 2adb3069b0e04-5221017775amr973568e87.34.1715324907267; Fri, 10 May 2024
 00:08:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240509023937.1090421-1-zhaoyang.huang@unisoc.com>
 <20240509023937.1090421-3-zhaoyang.huang@unisoc.com> <ZjzEH5fFGHgnqbLj@infradead.org>
 <CAGWkznG4xodugVdbKZCn99UiQT5Z3oHYLhTsvOCoe_VNxUVvnw@mail.gmail.com> <Zj2fEo_YiW7NeDT8@casper.infradead.org>
In-Reply-To: <Zj2fEo_YiW7NeDT8@casper.infradead.org>
From: Zhaoyang Huang <huangzhaoyang@gmail.com>
Date: Fri, 10 May 2024 15:08:16 +0800
Message-ID: <CAGWkznFa9zQy5XzYeinG-xFEGKUPcxLL6bRNQaGa9Wo-tM0vWg@mail.gmail.com>
Subject: Re: [RFC PATCH 2/2] mm: introduce budgt control in readahead
To: Matthew Wilcox <willy@infradead.org>
Cc: Christoph Hellwig <hch@infradead.org>, "zhaoyang.huang" <zhaoyang.huang@unisoc.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Jens Axboe <axboe@kernel.dk>, Tejun Heo <tj@kernel.org>, 
	Josef Bacik <josef@toxicpanda.com>, Baolin Wang <baolin.wang@linux.alibaba.com>, linux-mm@kvack.org, 
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
	cgroups@vger.kernel.org, steve.kang@unisoc.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 10, 2024 at 12:14=E2=80=AFPM Matthew Wilcox <willy@infradead.or=
g> wrote:
>
> On Fri, May 10, 2024 at 11:06:14AM +0800, Zhaoyang Huang wrote:
> > On Thu, May 9, 2024 at 8:40=E2=80=AFPM Christoph Hellwig <hch@infradead=
.org> wrote:
> > >
> > > > +     unsigned long budgt =3D inode->i_sb->s_bdev ?
> > > > +                     blk_throttle_budgt(inode->i_sb->s_bdev) : 0;
> > >
> > > The readahead code is used for all file systems, you can't just call
> > > into block layer code here.
> > >
> > ok. I would like to know any suggestions on introducing throttle
> > budget control into readahead which actually works as a negative
> > feedback path. IMO, negative feedback is a good methodology which has
> > been used in scheduler(EAS) and thermal control(IPA) and
> > memory(MGLRU). I would like to suggest to have a try on have it work
> > cross the boundary of memory and block layer.
> >
> > vfs_read / page fault
> > |
> > readahead  <---------|
> > |                               |
> > aops->readpages    |
> > |                               |
> > block_layer------------
>
> what you could do is have blk-throttle fail bios that are tagged as
> readahead if we've hit the threshold?
Actually, blk throttle will postpone the over-size bio's launch by
adding it to the throttle group's private queue which this idea aims
at. The delay here could be avoidable by some means to have the bio
meet the max ability of the throttle blkcg. Furthermore, we may get a
totally non over-sized readahead mechanism if we do this well.

