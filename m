Return-Path: <cgroups+bounces-10608-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id F38E4BC58FB
	for <lists+cgroups@lfdr.de>; Wed, 08 Oct 2025 17:23:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C48C94E43A5
	for <lists+cgroups@lfdr.de>; Wed,  8 Oct 2025 15:23:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAE0E2F362F;
	Wed,  8 Oct 2025 15:22:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RdHWSsWt"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3F8A2F3607
	for <cgroups@vger.kernel.org>; Wed,  8 Oct 2025 15:22:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759936978; cv=none; b=M5Fg91OIPPS5lcREF1pdNv4wenuWDh0Exs0AT6QTOxJ20C3w0GKExoZPx3mNf0wAArojSXellAU8AS8j5/VIMZHKAafDXiiYAOHGdm8CRilZHWTsHUcuDNT+ENpTougYlt6S/IsrLsqzycrgrA4vFFdQ0iNLvy7iRqH2wsmBXA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759936978; c=relaxed/simple;
	bh=2siM9yREqhk1evwBBV05rvjedon6J208mF1lxh+zAWA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ToRhopvNU/d6vxZjXHnVX4Bao1DbqyJSVCogRhYLIcFJTPLKN5o+yWU96GpFWUd10m4hQrSVXMjDd+Z4wZQ7AnQvDOs0IzZ7fXJPLmU9V1rz6LL8HZf8xCE9r6gyYutzpMxQwzGQPXjFb33NPU1ubsvaT7FwB2ZboALD1aFM3V0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=RdHWSsWt; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-afcb78ead12so1375736466b.1
        for <cgroups@vger.kernel.org>; Wed, 08 Oct 2025 08:22:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1759936975; x=1760541775; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=u8IL1MJVZcL+yeXHblmq6i6BaDGI2XMDGXwWjrVz72g=;
        b=RdHWSsWtcUl3GCRzqjOMvlcnMd8OsFhEz0QnpHvBv4qfuAox8SppXksx/Qc3QEchPu
         2NE2HPM88Pb6Na3iDya8bsWyj1juGEZpVsSO0xNNkQ2fu6jSaOMNeqJjHs+fgXWED9tE
         ANIWfbHByTVhBblhBoeuw7w87EHv4/qLJWS8Sw3O0SzFNr7ZlUDqx4cYTlkNgzPbyVIS
         h1WeqWV6+YnfCEyqap5aXx0GGCWsv+eopCa+DoNZ300pYbtwj+CxYb0fVSS8kBwrKveH
         Tq6sKNFTEnyBZliM27xPgpnEg1sMNWo4CmYc9zORqmQTrB5IcBkGLniygYH4Dqaz/ZXF
         1Y2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759936975; x=1760541775;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=u8IL1MJVZcL+yeXHblmq6i6BaDGI2XMDGXwWjrVz72g=;
        b=v47GLlcPbIqN9nUlFHsPR6QpKfGJZkuOJTkkbZwIC4akKy3R9qPzeVBNdZgYunV4Gs
         yp55QBFBZtseRxzshdPwldRve4TP0VA4GQvjdPIpwccV8HoiXTK38uNWZ1HdDXqt0OCH
         9UcsghxrpOrCR2U1m3Q869Vc283peeaWTEaMgsAk9o8Dlz/zBfZw/hLoUNPWG8UhRs2V
         KQCq/D+yJuhyV3s72aLAsR6I2ukFS2Xpe9Kx3rnmhGzIS/4zgBmUgbEeQOyLfc5PkYjv
         sW39MFEcyRgCfYy2z33gNu+jBV9f1kqwGdoy9Et2qOsFF2Oigy9s71mNuLVSqODVlssU
         kBjg==
X-Forwarded-Encrypted: i=1; AJvYcCU7aV8mePOA7SaWUWopZmSV6bQ10ut+LAP4t1ZGmza0Su82US9Vl/WcmdWEaPtQch3smxK2oUbP@vger.kernel.org
X-Gm-Message-State: AOJu0YwnYP8T27DVKvhTBhXCUcAee+BL+9K1ViAxq3mjy8OJDpds6xpo
	CZxNq2iauTmL/DZAiKvcbK+BzGzOBzwtzaFq0Tv9yn3ANQFm3bdLrSK6J8LTNFDWuPeJ6F05SUF
	W/RXHGovfn5G2nRtRlFt+Td9RPdJ8R4LrWA2hTkyMbQ==
X-Gm-Gg: ASbGncvm5FQP2ZAS74Pk1QEuY29Q2gvJxlkC1k41Et2z02IBZ53z4Oy62IwHmaKfJv2
	BzbuFXt6aKRPcUDHGCsTOgrmtvMaVw8+UYjArFcmRaNF0Wx9oCBty74oTTtnI8U+qTmfbJ7wRrb
	+fmVFyl2WKhoJCPIUeITDCZzoMTXoXof8OcyZnTvcvFGaGKqAy++56TidA3gZp+Gm8nPoWFqdrD
	1GQTU3X+Y2y1FRNbepNYKvcBTm0LPxzAccQnfAzMNH+zKcfmULD9Kkv3dMZwy5L
X-Google-Smtp-Source: AGHT+IEv9slRsfR5X3TXspH/uXKr0CnvgtVOqHiGOTJdOEngGu5NvMTv0CV3ST5SsNBcsjOejLZBA905vSFz/HXp7oo=
X-Received: by 2002:a17:907:9404:b0:b07:c1df:875 with SMTP id
 a640c23a62f3a-b50acc2f5camr471007566b.56.1759936975069; Wed, 08 Oct 2025
 08:22:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251006104652.630431579@infradead.org> <20251006105453.648473106@infradead.org>
 <CAKfTPtCC3QF5DBn0u2zpYgaCWcoP2nXcvyKMf-aGomoH08NPbA@mail.gmail.com> <20251008135830.GW4067720@noisy.programming.kicks-ass.net>
In-Reply-To: <20251008135830.GW4067720@noisy.programming.kicks-ass.net>
From: Vincent Guittot <vincent.guittot@linaro.org>
Date: Wed, 8 Oct 2025 17:22:42 +0200
X-Gm-Features: AS18NWCMZ89A2Uc8OjuCKIj0t-GYofpct9xdmPVvK_SHfZZWp3n4tWEOwjGeIvE
Message-ID: <CAKfTPtDG9Fz8o1TVPe3w2eNA+Smhmq2utSA_c6X4GJJgt_dAJA@mail.gmail.com>
Subject: Re: [RFC][PATCH 2/3] sched: Add support to pick functions to take rf
To: Peter Zijlstra <peterz@infradead.org>
Cc: tj@kernel.org, linux-kernel@vger.kernel.org, mingo@kernel.org, 
	juri.lelli@redhat.com, dietmar.eggemann@arm.com, rostedt@goodmis.org, 
	bsegall@google.com, mgorman@suse.de, vschneid@redhat.com, longman@redhat.com, 
	hannes@cmpxchg.org, mkoutny@suse.com, void@manifault.com, arighi@nvidia.com, 
	changwoo@igalia.com, cgroups@vger.kernel.org, sched-ext@lists.linux.dev, 
	liuwenfang@honor.com, tglx@linutronix.de, 
	Joel Fernandes <joelagnelf@nvidia.com>
Content-Type: text/plain; charset="UTF-8"

On Wed, 8 Oct 2025 at 15:58, Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Wed, Oct 08, 2025 at 03:16:58PM +0200, Vincent Guittot wrote:
>
> > > +static struct task_struct *
> > > +fair_server_pick_task(struct sched_dl_entity *dl_se, struct rq_flags *rf)
> > >  {
> > > -       return pick_next_task_fair(rq, prev, NULL);
> >
> > The special case of a NULL rf pointer is used to skip
> > sched_balance_newidle() at the end of pick_next_task_fair() in the
> > pick_next_task() slo path when prev_balance has already it. This means
> > that it will be called twice if prev is not a fair task.
>
> Oh right. I suppose we can simply remove balance_fair.

That was the option that I also had in mind but this will change from
current behavior and I'm afraid that sched_ext people will complain.
Currently, if prev is sched_ext, we don't call higher class.balance()
which includes the fair class balance_fair->sched_balance_newidle.  If
we now always call sched_balance_newidle() at the end
pick_next_task_fair(), we will try to pull a fair task at each
schedule between sched_ext tasks

>
> > While reviewing this series, I also noticed an older issue that we
> > have with check pelt lost idle time [1]
> > [1] https://lore.kernel.org/all/20251008131214.3759798-1-vincent.guittot@linaro.org/
>
> Let me go have a look.

