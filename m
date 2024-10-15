Return-Path: <cgroups+bounces-5123-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EFD499DBD3
	for <lists+cgroups@lfdr.de>; Tue, 15 Oct 2024 03:46:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D77B828268A
	for <lists+cgroups@lfdr.de>; Tue, 15 Oct 2024 01:46:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64C6A13D638;
	Tue, 15 Oct 2024 01:46:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="etfDcGeD"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 670C38468;
	Tue, 15 Oct 2024 01:46:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728956792; cv=none; b=C8uqSvWFFAKxfJflojjnoX92UsQP/WkFU2NGUuX7pMR8NTEdRYjKBrOkBKB5o0Dkuckgw46a2LYSboUP5MsQ2aT6d3ItADMz3j6Ev8xIrCrVsTQ5x6dD4WOiLJXLQTzIALaA69U4zqMZ8ksUkmkvM+Zqe4dbTwI6YvZ0KLAbbeg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728956792; c=relaxed/simple;
	bh=1LOSpeTDcBfNC7lfaD4GUxd3xiGukOwPWLHbATyJKHk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BqYsOB2v5cSI6J50L+Pn3ySERtp9kiKK+aIiE3N5iXjn41V1Od3lQuRwIURXD+/V1qgir/nSn0CnukZI0JxlGrxZywbzDyxe/pt7yrkzjJIA4VORF7rIkGjPXHmWsCA4KnOkXJeIv2Yekk9n+yBTJ5D/kW0JMyJsNTtQFFJE6q4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=etfDcGeD; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-2fb4fa17044so15047281fa.3;
        Mon, 14 Oct 2024 18:46:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728956789; x=1729561589; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1LOSpeTDcBfNC7lfaD4GUxd3xiGukOwPWLHbATyJKHk=;
        b=etfDcGeDrq/mqDltvH7+/mmGwoBpr+ANIsNE3nCGiT09NUtaFuIBvozmY25Iy+UobY
         pHvJdfh++Yeej3hoIIq4r7wZzozwx1d0nc7reJ5naNEIveepITMwfavLM4zoM5rzdvJb
         +1l1k6HPhIhxt//52ZfJ9vik8+rygEktuwvkL4nkeyc9JQDK9h09p5phTsgqssVXnWrV
         P7nhLIfOYLhSwwvQmklwhBwb9ApLYsiyb91S2MQ5htArCkRYk/+l/9TkiTrBxtU5y/qg
         LwyDx2irsG/NmbNNyeMEV0yeIpwfmBEgCZlsjZuMVeAagSHYBRHmCI/eLhE9irXfTb4z
         29nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728956789; x=1729561589;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1LOSpeTDcBfNC7lfaD4GUxd3xiGukOwPWLHbATyJKHk=;
        b=b+pKI9fO3/HuV1lGMW9ZTotryC0EnojxGKjyfsOFPbm2Q01Dy3V5s0IbgpQXVt6a6J
         tdw00nj2E6+vRXypbaXbQyhY4ogoMY17ki4gX6vGbCYrRxVfTVu/R/7dKzGFLnUn6n/I
         echPsj3247IrKXWFV/T8J7g/EaVT5iefZpNisbUdlRsj8PGFfJxIT8xkDPGTGoYvTZI0
         sUdh35FEdu2ZNZIwQA/LxZTgPfQm+XIZt3rZGee5ZlEmPGwdF3FXcGcvpoPvjJRutZKK
         NYQ2E9BHWSknXJb5M1MKMsn+La8FzJT65y6+RjIHiQggFRflsYrCwhdWWQx+g+/AKlKv
         0vng==
X-Forwarded-Encrypted: i=1; AJvYcCVqCX800naZv3Btl0V4DZMsjjJlSUP2TLZDWnumNZG1JPLxQGXJSASh2pFVpy0PqABi0OSwEjPXmVPx4Zn1@vger.kernel.org, AJvYcCWJwo7raCG5kykF8LOSWLuQ+w3whIh++6Pxytoo8d7JeAtXky7uaeUn6XaupAeb1pHFa/9l2Cs2@vger.kernel.org, AJvYcCXEuUkhgh7CLYULR2SRpbZDTyKr1cIAev/pvLZwj53Eneq5MSVcVga/DH5upoqmCWzNDt5LgF8FRT6XNx8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwCCLt6Y5nOx+UUX9ULcVETssPinWrv2VtVZfIaPUfFpmxAbM3X
	lXw6zWpHWRMrWNlGNtJOmzoA8lpaaDzJPjr8cmu3ZLFacjN7fDehugmEme3d3JvzaliJkBZYQKr
	FpuoZg6p++z9Nobwzn4Esugy7D82o8AQcLOc=
X-Google-Smtp-Source: AGHT+IG4go9cTfMsoy7KIZm+tBl9/AfmWuFk/WTV50i1VYxt9hID/QmhVd4Jm6Ik2WNcB3HM63fHGdfPFScPsXcwD8g=
X-Received: by 2002:a05:651c:b13:b0:2fb:597e:28d9 with SMTP id
 38308e7fff4ca-2fb597e2cebmr12254341fa.14.1728956788362; Mon, 14 Oct 2024
 18:46:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241011014724.2199182-1-xiuhong.wang@unisoc.com> <dgfa2ehxmdixfi2fu32b5kjoyfpbd3ew5e6rmzxpcy7crwctaf@st4s4df6nvuo>
In-Reply-To: <dgfa2ehxmdixfi2fu32b5kjoyfpbd3ew5e6rmzxpcy7crwctaf@st4s4df6nvuo>
From: Xiuhong Wang <xiuhong.wang.cn@gmail.com>
Date: Tue, 15 Oct 2024 09:46:17 +0800
Message-ID: <CAOsHCa0wyTtA65mGBB_8YM7vmQyvkTDcwwvELEEMJ5WKu2QNhw@mail.gmail.com>
Subject: Re: [PATCH] Revert "blk-throttle: Fix IO hang for a corner case"
To: =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>
Cc: Xiuhong Wang <xiuhong.wang@unisoc.com>, tj@kernel.org, josef@toxicpanda.com, 
	axboe@kernel.dk, cgroups@vger.kernel.org, linux-block@vger.kernel.org, 
	linux-kernel@vger.kernel.org, niuzhiguo84@gmail.com, ke.wang@unisoc.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Michal,

Remove this patch to make the code clearer and easier to understand.

Michal Koutn=C3=BD <mkoutny@suse.com> =E4=BA=8E2024=E5=B9=B410=E6=9C=8815=
=E6=97=A5=E5=91=A8=E4=BA=8C 00:45=E5=86=99=E9=81=93=EF=BC=9A
>
> Hello.
>
> On Fri, Oct 11, 2024 at 09:47:24AM GMT, Xiuhong Wang <xiuhong.wang@unisoc=
.com> wrote:
> > This reverts commit 5b7048b89745c3c5fb4b3080fb7bced61dba2a2b.
> >
> > The throtl_adjusted_limit function was removed after
> > commit bf20ab538c81 ("blk-throttle: remove
> > CONFIG_BLK_DEV_THROTTLING_LOW"), so the problem of not being
> > able to scale after setting bps or iops to 1 will not occur.
> > So revert this commit that bps/iops can be set to 1.
>
> What is the use case where the difference between 1 or 2 matters?
> (Unless this is meant as a cleanup, then it makes sense to me.)
>
> Thanks
> Michal

