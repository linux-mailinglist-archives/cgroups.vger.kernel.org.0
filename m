Return-Path: <cgroups+bounces-573-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CA1F7FA8D8
	for <lists+cgroups@lfdr.de>; Mon, 27 Nov 2023 19:20:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 15073281799
	for <lists+cgroups@lfdr.de>; Mon, 27 Nov 2023 18:20:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B2293C6B9;
	Mon, 27 Nov 2023 18:20:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nEdB9N3j"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85FCB1BE
	for <cgroups@vger.kernel.org>; Mon, 27 Nov 2023 10:20:06 -0800 (PST)
Received: by mail-wm1-x329.google.com with SMTP id 5b1f17b1804b1-40b367a0a12so228295e9.1
        for <cgroups@vger.kernel.org>; Mon, 27 Nov 2023 10:20:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701109205; x=1701714005; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Fa2dZ1fsBMo5kJDdACp6J5U0uIcQdtFHFrG7A9PMYSA=;
        b=nEdB9N3jxkdEEVHkAsIu2sZolH9vc9OFAENOGc9AG5rcfyKwf00rifWm33o11MbJJY
         IXMgNdP4/GExGq7VQ4hWqSZXubE6AFYrOrV7Ue11nmTuo+Na/dFlFZm5k7hj6WzxsuAx
         5kAsVnnFyJPgfAJNsva2/VvFcP2tUn7hXK1pbQBgug5cdV4HV96zJrVh42piP0CVgSQ0
         n1cQ9EFwBAKcJ98GLJMuEx/W514Vz041k+8G5m7okXArdK+D745ljNapIEmkogEqYq5f
         oJyWPTE5+XF6c5VO9+eHkeAhseO2na1LFa4bwA5v2ciTxnD43jMh58B6fFrhIt+Hsqwy
         0wxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701109205; x=1701714005;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Fa2dZ1fsBMo5kJDdACp6J5U0uIcQdtFHFrG7A9PMYSA=;
        b=dVVe87uUXijOByp3M7eckTF/z1vDo5y/uMCrhdI7npUnJ1aPvUGGX2LFwZwRNUB+3O
         twHezup2JQF5rg2FJnXcGNC6rztlyga+oym14AjKxjbPzdRCBctQaYWqk1nX6Dfez80Z
         FreYj0RHSXKMh2TzzlBddNtOS7sS8GfvZPII4SKRimaSvHmd2T1oH7Zek8OzmbTj38dM
         s5ZS5CnEv/E+m01/4FHIkmA7L8tVsSv2GtGSOLDYqmh1ZC7T8x7WtXhsnxzmKLNivFuB
         Nl8KYx19AEXB/VNRROyPi5eacTZhnb1qSxOc08YvOOAVXRxSTLTBlSlnGf5vSGviNfDL
         SJlw==
X-Gm-Message-State: AOJu0Yz424TGP/Wr7DHLHAoMph06hKmtuN2A3j5SRdOeYQHMRT5P3SHO
	dp1yVstXwNC1Xfq6tejxeoFHF8DaeDyUBsmrcUxamQ==
X-Google-Smtp-Source: AGHT+IGt4OpK0H5fdVVr8LMIIAdpLxLFqhGAN6JhuXA/NKvDFJV7zqwg8I0/mdwrfk9CSXjvo50bdFZqKfd8wWKep3I=
X-Received: by 2002:a05:600c:3c83:b0:3f4:fb7:48d4 with SMTP id
 bg3-20020a05600c3c8300b003f40fb748d4mr630841wmb.3.1701109204833; Mon, 27 Nov
 2023 10:20:04 -0800 (PST)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231115162054.2896748-1-timvp@chromium.org> <ZVokO6_4o07FU0xP@slm.duckdns.org>
In-Reply-To: <ZVokO6_4o07FU0xP@slm.duckdns.org>
From: Mark Hasemeyer <markhas@google.com>
Date: Mon, 27 Nov 2023 11:19:52 -0700
Message-ID: <CAP0ea-sSvFGdpqz8Axcjrq=UX0watg=j6iBxd1OkNeKHi_pJ=Q@mail.gmail.com>
Subject: Re: [PATCH] cgroup_freezer: cgroup_freezing: Check if not frozen
To: Tejun Heo <tj@kernel.org>
Cc: Tim Van Patten <timvp@chromium.org>, LKML <linux-kernel@vger.kernel.org>, 
	Tim Van Patten <timvp@google.com>, Johannes Weiner <hannes@cmpxchg.org>, 
	Zefan Li <lizefan.x@bytedance.com>, cgroups@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

> Applied to cgroup/for-6.7-fixes.
>
> Thanks.
>
> --
> tejun

Thanks Tejun!
As this hasn't been merged to Linus's tree yet, do you think you could
Cc: stable@vger.kernel.org?

