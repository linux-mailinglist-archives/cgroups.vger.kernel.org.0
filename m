Return-Path: <cgroups+bounces-2848-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F31C8C1CC1
	for <lists+cgroups@lfdr.de>; Fri, 10 May 2024 05:06:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1E4611F22396
	for <lists+cgroups@lfdr.de>; Fri, 10 May 2024 03:06:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AC97148846;
	Fri, 10 May 2024 03:06:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fWDbgxfh"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8827729CE1;
	Fri, 10 May 2024 03:06:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715310389; cv=none; b=GPmnWiP3ZcuaTdXDE/zyrFh6XJ2+cOoM8TOCv+q8fz9Y4HNJ3UX0fxSGyuNdB/LViEqm6SWCYUUFfOAekd9x5eK67h5FhJ4c65sfvRvnlCST3tmr31aAgK6s+KO5+s9MsWk4VL454bM2zJOEjV5A1OjisSmvVI4QDpilVnRrneQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715310389; c=relaxed/simple;
	bh=8xtk44jSOd8araYzrVz2AKcFhCesWZbEvqWPEiUg80I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Kn3tabKTSLycPjjUaLTiFD6VMywmLwNwi475Bi3H3W4NCFruUMXEr2oGPhDA/1Me6JgSCR9xdzObfIFV2T3WnGtehjv/p0oz9jPUJ6SEsn537h37dFe2HnlFbD+IjnNb3thJiab3UNBCBMjKP6QwoiJy1LNDXBR9QqY0SgEOtEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fWDbgxfh; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-51fcb7dc722so1435792e87.1;
        Thu, 09 May 2024 20:06:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715310386; x=1715915186; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OpvuySBIeO4vzs2xHm0aakYIlKfoDjkApIsuTSeBQbM=;
        b=fWDbgxfhhAkT/woi6by21c+ITLZVKI9aoCAxK6gd21ruazKH1sAfjgpDSsxhpOtcSX
         EEX9c+ibb+1dQ2OTxxKe6cQZ6qOUvsWXZa5nzJQu8MGmB7QO1Tjam6tWxGi4BnHMeL58
         wgZMD/M0PeHm3EG+a/nr9VGX25GmTxBxcCTcuC7qgWchbirOywvlBRO3/a4LAQOBvgZ8
         pNNWmcGNkpedgS8DfOEVbMJFAu8xqOiXTVpQDvl/2xOrUzCL9LQ3maFgkub2PDGJLdtm
         LE2y41VzQq9n4W4jfNo5Ws1eNQiJm2yxp3OexsO5IUYLavjazwfD1eW9f24Gac/BCcTG
         9gKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715310386; x=1715915186;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OpvuySBIeO4vzs2xHm0aakYIlKfoDjkApIsuTSeBQbM=;
        b=BVJ3en4mtGo7eS4JKdmCnohMkzVivU/VV+LSnUwU5A+PxjU+jLr1HVDATpjxAeR4vD
         MWX+hkbpPAmgCgOMUeXlnp8cv6QahyzBrAHthfeDDeE5khShW+dGleDiLegqSte5UmpB
         p5W00+9lulkdhG3elp50wT3JF7lNalMkdQYSghGwLJljEAGNYXIBEzZvuFj1uQNoh1DU
         P7eCxE5kvJo+5lWHefLNN/mzxrQ3a+waKZjMJvIHvlJOmkMlKY6BaG99o2QTD/r68gXd
         2d23RyhvfpywlFMnGLfvG0K6//4UPZyVbLT8DWqRIVjgr2QAJKgBNFtLaAEFVo+jCaLo
         eQSw==
X-Forwarded-Encrypted: i=1; AJvYcCWHAkR4evRgC+iXDEm3Dxf5//wsiaG4pO98MbEXrDtqePkttatuwOakH/NgacJBhBaqI0b1+awafItJFFBVJSgSP5vWBBxCm5jYqK90754Z1dgxbmXQPo8WCnVBcmfUAXxDwYxo1ekfYEoJTrWlGZQn17i4KK+SjjdtKczGlBu4SPG9
X-Gm-Message-State: AOJu0YzIFWg1fLg96a5DwmhZ1rO1IqfDObq+n4FtnUOpg+7OHk79NL/V
	EtVmbwGPEmVUqEAcyziWeFnZ0xyMx9NJxFa6Aove7/+yZnoR9+SFys1psx5KQK/Q15gQAfjkEBC
	TD2Jx531+OkHwqiAwuQmfjlJ5wxM=
X-Google-Smtp-Source: AGHT+IFEAo7JXInCUEDzKmhn9ExTdgovAuIzNcL9oD/qeIwarBnvFXlJaxHzph8F5vyLFGOC6JR5iidAyppUu3Me2hs=
X-Received: by 2002:a05:6512:684:b0:51c:590f:4305 with SMTP id
 2adb3069b0e04-5220e3736c2mr404774e87.8.1715310385488; Thu, 09 May 2024
 20:06:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240509023937.1090421-1-zhaoyang.huang@unisoc.com>
 <20240509023937.1090421-3-zhaoyang.huang@unisoc.com> <ZjzEH5fFGHgnqbLj@infradead.org>
In-Reply-To: <ZjzEH5fFGHgnqbLj@infradead.org>
From: Zhaoyang Huang <huangzhaoyang@gmail.com>
Date: Fri, 10 May 2024 11:06:14 +0800
Message-ID: <CAGWkznG4xodugVdbKZCn99UiQT5Z3oHYLhTsvOCoe_VNxUVvnw@mail.gmail.com>
Subject: Re: [RFC PATCH 2/2] mm: introduce budgt control in readahead
To: Christoph Hellwig <hch@infradead.org>
Cc: "zhaoyang.huang" <zhaoyang.huang@unisoc.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Matthew Wilcox <willy@infradead.org>, Jens Axboe <axboe@kernel.dk>, Tejun Heo <tj@kernel.org>, 
	Josef Bacik <josef@toxicpanda.com>, Baolin Wang <baolin.wang@linux.alibaba.com>, linux-mm@kvack.org, 
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
	cgroups@vger.kernel.org, steve.kang@unisoc.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 9, 2024 at 8:40=E2=80=AFPM Christoph Hellwig <hch@infradead.org=
> wrote:
>
> > +     unsigned long budgt =3D inode->i_sb->s_bdev ?
> > +                     blk_throttle_budgt(inode->i_sb->s_bdev) : 0;
>
> The readahead code is used for all file systems, you can't just call
> into block layer code here.
>
ok. I would like to know any suggestions on introducing throttle
budget control into readahead which actually works as a negative
feedback path. IMO, negative feedback is a good methodology which has
been used in scheduler(EAS) and thermal control(IPA) and
memory(MGLRU). I would like to suggest to have a try on have it work
cross the boundary of memory and block layer.

vfs_read / page fault
|
readahead  <---------|
|                               |
aops->readpages    |
|                               |
block_layer------------

