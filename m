Return-Path: <cgroups+bounces-5378-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A2D479B91FB
	for <lists+cgroups@lfdr.de>; Fri,  1 Nov 2024 14:28:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 671DE284D75
	for <lists+cgroups@lfdr.de>; Fri,  1 Nov 2024 13:28:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FA301BC58;
	Fri,  1 Nov 2024 13:28:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="g0Qan6nO"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 157D6179A7
	for <cgroups@vger.kernel.org>; Fri,  1 Nov 2024 13:28:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730467687; cv=none; b=MklFOllLr4DZu1nUC3gt3dgSpw670m6yBp2JnhBUpS5QhoF9mWR2p5mwZGJ9myQXk4kqnxII7uoTG33cNOkNZhKFNEG7eMbngW5bjJM0nUZ+eC22tn6bxI8hMbbQXKCvFDSNvcvVBbEvQeUWHt1mV8BGGDe2ilAqFUhYDet3SU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730467687; c=relaxed/simple;
	bh=aKnunhQNGkbFxu3tpoPPwaFfkOFrxlKJiaYeDYx8j4s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZRvNFXLFjgpimCISs4FyC2KvgrqePkSxHyn78iyEZViYlAlUEqHAAXSgIVuiagk3L/FqHimjThzbbIx/4N6ggluoePu2/9EqGpOW6EXZqDtoqR7B/HjDZHM43y7ricswqMeMy2jK4Obz+YX249uRHR95PisnAfQUSf9nmVQAJAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=g0Qan6nO; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a9acafdb745so335353066b.0
        for <cgroups@vger.kernel.org>; Fri, 01 Nov 2024 06:28:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1730467683; x=1731072483; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Q7IPe6J0XouRhja9jovBmbBp0WbnhwjBFmpnKQuywTw=;
        b=g0Qan6nOOQjd7miTQzQYulvrKqlVR7mbs9U2dQw19ht+MgrqpxoEPJzn26e37BcypX
         zPOnJNCRpWoNfJnv6Fh7E8WbAdBN6Y7yu+8eJFnUgSZHEedVQrne8EReSRnSA9lte9+V
         uqGBg9BncTDwb3O6VOLYqw45O7EPPvKCuUlQovJKSHiSsc+2azPCO9+lMBHXGsqIu5rh
         alb1JBqNujpDUvhCFdfraymCuyet+DYaO7JUUrJegH/bGExRZeUEB89tYkYejDLEPpNB
         MyD/KYAdw+WYorAYmHNW7h+7/xQgnMXcp8MWuNU6AUsdNsexyo177moaMyXsfFyRNbKp
         cyXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730467683; x=1731072483;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q7IPe6J0XouRhja9jovBmbBp0WbnhwjBFmpnKQuywTw=;
        b=K+MCY4YxuuieaThuGkVxONHWN+xH6AQJHTipE9zJ+7Ip21PtLxTh4mWzqZwITIH4/V
         vKv0M1JOU6dMgbI9gcaZF9FgHvKQF8nZhJVUdyMTL+Aqsi0ARlmE6Ajn2BeRjsUWGnmf
         hXSoqbm9HpVTZXBP0LqRW5oE5epKhmQZAd4jG06NC6eWHziARYqXeL/8gO4ISeLtAmtD
         n64yu9pturXd0j3tjx0xkZVv+IU/zKFnYEQIDMZG+kHzMPz9FDJWbYII+ODAh12GzuDS
         3+Nx/0HPu5Ffp50j3nXusrW10SVN2oFQi41vnV3QVy8cOzU+Zd2xGhJD8dwS0JIvjUm5
         7knA==
X-Forwarded-Encrypted: i=1; AJvYcCV5H/M9iLNRIxrdyqmqI/+2OAA6jge69v07+B9XW66CXTQ0k43gV5sakDViF7aQfCQuCFgu7pGF@vger.kernel.org
X-Gm-Message-State: AOJu0YyCoz30ODaJ8bkqGELb713Tyyk61H6e0HLp06GXAu04Bui5NPP+
	fC2omXfR6eyBgC23ZkcuaSWTR9/dhwfh8q+xRwY0TAFFu7u7OF+zBlwylKdZyyg=
X-Google-Smtp-Source: AGHT+IHjBlIzk1T1OigPtqH0JpYx9GMUyR8/T5/k82f9nEsie8ENm7j2/lVrdgJjpJDhjvnX8HAz9Q==
X-Received: by 2002:a17:907:9714:b0:a9a:ca:4436 with SMTP id a640c23a62f3a-a9e6532ca84mr329527266b.13.1730467683426;
        Fri, 01 Nov 2024 06:28:03 -0700 (PDT)
Received: from localhost (109-81-81-105.rct.o2.cz. [109.81.81.105])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9e565e0969sm178760966b.101.2024.11.01.06.28.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Nov 2024 06:28:03 -0700 (PDT)
Date: Fri, 1 Nov 2024 14:28:02 +0100
From: Michal Hocko <mhocko@suse.com>
To: Stepanov Anatoly <stepanov.anatoly@huawei.com>
Cc: Gutierrez Asier <gutierrez.asier@huawei-partners.com>,
	akpm@linux-foundation.org, david@redhat.com, ryan.roberts@arm.com,
	baohua@kernel.org, willy@infradead.org, peterx@redhat.com,
	hannes@cmpxchg.org, hocko@kernel.org, roman.gushchin@linux.dev,
	shakeel.butt@linux.dev, muchun.song@linux.dev,
	cgroups@vger.kernel.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	alexander.kozhevnikov@huawei-partners.com, guohanjun@huawei.com,
	weiyongjun1@huawei.com, wangkefeng.wang@huawei.com,
	judy.chenhui@huawei.com, yusongping@huawei.com,
	artem.kuzin@huawei.com, kang.sun@huawei.com,
	nikita.panov@huawei-partners.com
Subject: Re: [RFC PATCH 0/3] Cgroup-based THP control
Message-ID: <ZyTXYnbDfGYGuxlt@tiehlicka>
References: <ZyI0LTV2YgC4CGfW@tiehlicka>
 <b74b8995-3d24-47a9-8dff-6e163690621e@huawei-partners.com>
 <ZyJNizBQ-h4feuJe@tiehlicka>
 <d9bde9db-85b3-4efd-8b02-3a520bdcf539@huawei.com>
 <ZyNAxnOqOfYvqxjc@tiehlicka>
 <80d76bad-41d8-4108-ad74-f891e5180e47@huawei.com>
 <ZySEvmfwpT_6N97I@tiehlicka>
 <274e1560-9f6c-4dd9-b27c-2fd0f0c54d03@huawei.com>
 <ZyTUd5wH1T_IJYRL@tiehlicka>
 <5120497d-d60a-4a4b-a39d-9b1dbe89154c@huawei.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5120497d-d60a-4a4b-a39d-9b1dbe89154c@huawei.com>

On Fri 01-11-24 16:24:55, Stepanov Anatoly wrote:
> On 11/1/2024 4:15 PM, Michal Hocko wrote:
> > On Fri 01-11-24 14:54:27, Stepanov Anatoly wrote:
> >> On 11/1/2024 10:35 AM, Michal Hocko wrote:
> >>> On Thu 31-10-24 17:37:12, Stepanov Anatoly wrote:
> >>>> If we consider the inheritance approach (prctl + launcher), it's fine until we need to change
> >>>> THP mode property for several tasks at once, in this case some batch-change approach needed.
> >>>
> >>> I do not follow. How is this any different from a single process? Or do
> >>> you mean to change the mode for an already running process?
> >>>
> >> yes, for already running set of processes
> > 
> 
> > Why is that preferred over setting the policy upfront?
> Setting the policy in advance is fine, as the first step to do.
> But we might not know in advance
> which exact policy is the most beneficial for one set of apps or another.

How do you plan to find that out when the application is running
already?
-- 
Michal Hocko
SUSE Labs

