Return-Path: <cgroups+bounces-6229-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DCC7A15532
	for <lists+cgroups@lfdr.de>; Fri, 17 Jan 2025 18:02:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5240916A293
	for <lists+cgroups@lfdr.de>; Fri, 17 Jan 2025 17:02:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 636E519E7F9;
	Fri, 17 Jan 2025 17:02:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="119J9CVq"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A75AE25A636
	for <cgroups@vger.kernel.org>; Fri, 17 Jan 2025 17:02:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737133360; cv=none; b=HPICp7S3kxLka1wBlD7vcwo/XoXSusqFvAM/EVFRoobrg3/9He8OVhLDA6txYIXx7HX30J7jQa4REMzjxmuMG5rKLrnrQzKCoYuRtOsRLFHSHofhMfyZAkNKvdvuL3DXChuy68hdwNL8AU01mbNPaeTMLxuZ9I+CuMAZb7v6oJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737133360; c=relaxed/simple;
	bh=VOhRlzFLatiwMnMgWUCUofi8FW89XTrIZpSjj6Xqij0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=s7z2oJhj3A1MJKTBWTi3/Rlkf2U0SAVXqbLCJfs1Fz/L938hlx4mAMkxb/LM8sSZsteCYwni499qCTVXZoKpbtXH9pYdG2LKiE9vVir50UWz1iYtnDZapkpuYnnXvgAqx14ZEBIvA4oHFMMBUi4SMifR6koLhWkM2AmGr+Znyyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=119J9CVq; arc=none smtp.client-ip=209.85.219.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-6dcd4f1aaccso33810966d6.2
        for <cgroups@vger.kernel.org>; Fri, 17 Jan 2025 09:02:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1737133357; x=1737738157; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VOhRlzFLatiwMnMgWUCUofi8FW89XTrIZpSjj6Xqij0=;
        b=119J9CVq8HivGUvYOQoDCCwQjO9u8aN0ryvtX+dcTyGg8vsvbTB6cNMX9wwMq/ASb8
         UuRFGNW6fJhOSOGN1D73XuFV5lB+fvfo657DktGHerN7gPg+Ss+LlkM3iHWEgNjxIPTa
         tcaBxgPi2CdbO8oiKccKffch8WaSSNO/prcTm/JT3ud4uoMHpkZRXd4GMnkjZJIHEqgS
         d3JK/sDnlAGCOa2PDLKNXcbAAApAccS2dnDv+CNnfzNtZGtGx/7n5M2Glp0KG3SBSnoL
         cYsf6spgrVVmooHG8CZeGw7E4fEMo8OfgTeFu7IgTHr+gfk6xpdhTwdxp/i7E4cGXO7X
         v9hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737133357; x=1737738157;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VOhRlzFLatiwMnMgWUCUofi8FW89XTrIZpSjj6Xqij0=;
        b=UBO1om5jgkx2T07EspKEV6j7sNUrZQWE6r0vaXUDTX162S7qYLmAksmn02cvGIqz+V
         SZCMqcca7fB+bJKIX6RMh5wEWjgfRdOmVuqujHaRQTBzS/n2egfCCiOZ07MjIDI3a+DT
         eALLAXlsDxd9U6JpSGTmKrLtmF2WXmXlZNCKmLlnWcX5GKRCGzPOjAzHdcqo+5uR2kBE
         kjqujzjnInryPpXbSXJmG6Gw4qfaILyRZWWZHfW0hG+HRGnlfV1eaK5aL+xk3uzlxKGa
         396solyRidHYt4gJyHGD37LOmeWQYvszWB4VtW6by1bFcFl7Vx9Rp1j7UxKrpGMm376F
         xu7A==
X-Forwarded-Encrypted: i=1; AJvYcCVRbyao9WfrkXiYACNLjRDCLSvSHo0nyOpmpfUU/gFTemOuq1g8lc2qB+a7rzfRzSH4K3+uXvOf@vger.kernel.org
X-Gm-Message-State: AOJu0YwnRfhwZT7AcHBQXePvLxcTmp32naC13DDMQjf0jqb+cs+Xtddb
	UPL/jk5kh/az7XeTNdySpp0ly8XZ4BDFmewzwXWrvckGz3M4a4ZtACMzsaQyYarTKx/FEzqaZrM
	g2we2ElvqeYCxz3zPgPX//9a9lJA92gLJ7NXu
X-Gm-Gg: ASbGnctAl3ELYKQi7tSANtddSoLFHu5jCKTc7VTCmbBHMQQD4hOXaqV3XwC21JLizSk
	x+Jlmz31bXrMkuTeeqWXKXIflHEiKiozf6GM=
X-Google-Smtp-Source: AGHT+IHy2OFDrfhYJvKp9ooseej/uVcky7fBAj2fPTm7u2EE2MaqnfwXScOO7uisZqZE31rknNHwGfStLwVGA5D/w0k=
X-Received: by 2002:a05:6214:1cc7:b0:6e1:697c:d9b8 with SMTP id
 6a1803df08f44-6e1b216efb9mr60107866d6.9.1737133355973; Fri, 17 Jan 2025
 09:02:35 -0800 (PST)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250117014645.1673127-1-chenridong@huaweicloud.com>
 <20250117014645.1673127-5-chenridong@huaweicloud.com> <20250117165615.GF182896@cmpxchg.org>
In-Reply-To: <20250117165615.GF182896@cmpxchg.org>
From: Yosry Ahmed <yosryahmed@google.com>
Date: Fri, 17 Jan 2025 09:01:59 -0800
X-Gm-Features: AbW1kvYx_hSht555Bb8ABr_l-VOiTdmK7c_18YD4Qnme2JcEqIgeCXZYh2-x6rk
Message-ID: <CAJD7tkYahASkO+4VkwSL0QnL3fFY4pgvnN84moip4tzLcvQ_yQ@mail.gmail.com>
Subject: Re: [PATCH v3 next 4/5] memcg: factor out stat(event)/stat_local(event_local)
 reading functions
To: Johannes Weiner <hannes@cmpxchg.org>
Cc: Chen Ridong <chenridong@huaweicloud.com>, akpm@linux-foundation.org, 
	mhocko@kernel.org, roman.gushchin@linux.dev, shakeel.butt@linux.dev, 
	muchun.song@linux.dev, davidf@vimeo.com, vbabka@suse.cz, mkoutny@suse.com, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, cgroups@vger.kernel.org, 
	chenridong@huawei.com, wangweiyang2@huawei.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 17, 2025 at 8:56=E2=80=AFAM Johannes Weiner <hannes@cmpxchg.org=
> wrote:
>
> On Fri, Jan 17, 2025 at 01:46:44AM +0000, Chen Ridong wrote:
> > From: Chen Ridong <chenridong@huawei.com>
> >
> > The only difference between 'lruvec_page_state' and
> > 'lruvec_page_state_local' is that they read 'state' and 'state_local',
> > respectively. Factor out an inner functions to make the code more conci=
se.
> > Do the same for reading 'memcg_page_stat' and 'memcg_events'.
> >
> > Signed-off-by: Chen Ridong <chenridong@huawei.com>
>
> bool parameters make for poor readability at the callsites :(
>
> With the next patch moving most of the duplication to memcontrol-v1.c,
> I think it's probably not worth refactoring this.

Arguably the duplication would now be across two different files,
making it more difficult to notice and keep the implementations in
sync.

