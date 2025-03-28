Return-Path: <cgroups+bounces-7252-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FC1FA74D00
	for <lists+cgroups@lfdr.de>; Fri, 28 Mar 2025 15:44:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A2E3B188AB10
	for <lists+cgroups@lfdr.de>; Fri, 28 Mar 2025 14:43:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C49851B6D08;
	Fri, 28 Mar 2025 14:42:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="h6MWsw6O"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-ua1-f51.google.com (mail-ua1-f51.google.com [209.85.222.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C607F1B3955
	for <cgroups@vger.kernel.org>; Fri, 28 Mar 2025 14:42:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743172979; cv=none; b=KQThVbXOqFphllxbLzsxoCR2/VxMdEEtFxopxG4VL+Hvkur9jPbBGVd7pmBXER+NuAbAJbthUuG8MrNK15nYKuBms+4VwMyuh9jF1ZLQxOlxMEXUGV/oSRXc4BbVdqNVxYSTr8zr5hFR6YAK8Txf+UvGkfv7bkwJcS+qLRa4P/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743172979; c=relaxed/simple;
	bh=tjAIKgTzm6/MGyLQfjiuIHOp0fmSUV2cxbEbpn84D6Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MU41DTowYV73MNsrvmEMG7Ov+RN+CNGB4v1xpjjT+R7CYcQlxTeM96F2+s3vNz9rVaDg8KpJETo8xG+ynLUz922d9C7q6+FauQ3uh1iqVlG3D772q+30sfMvjWyEMXLGkqivrSTjfkN9jqIFPzKow2Ol05xl47DfHJXNTSh++4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=h6MWsw6O; arc=none smtp.client-ip=209.85.222.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ua1-f51.google.com with SMTP id a1e0cc1a2514c-86cce5dac90so1020261241.0
        for <cgroups@vger.kernel.org>; Fri, 28 Mar 2025 07:42:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1743172976; x=1743777776; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=d6ToKzHT6TF8RQ5+cmvhkhRs8kpZAnpcNS44iZJDBN4=;
        b=h6MWsw6OLcKvHPfdhSUa1cUuFG5eJ+53to9WSwVfn3nQgXOMNN9cRTHMetnBDpWlJW
         l0qNl9hoEPmiOv1y6P+2zxgiTa2JznZwldtZqQoeboGSl0tTS8q9fx5Byew7j5oC4njw
         z1KQheah+DiaEFOooWq5kOCyZy162NNMekhmn6o+/j7o8wmAALfF0sLTZhvFT03oLHco
         uplE6QiR9f8MMsLzUikHuoD8jib4qz9G5YNC0AvnKtn/YBAf3YHcy+XjpKkhpZES4XRm
         lJ5+KSZdMWY/FcrUeyjoQPqz+TsnRle6i9LE1CtZxfT5cBZbfnFue7zGcLggt0gyszbv
         bshA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743172976; x=1743777776;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=d6ToKzHT6TF8RQ5+cmvhkhRs8kpZAnpcNS44iZJDBN4=;
        b=Wj1i0Pb/sfoe9D71SZ0dSq8gld3WY9CIx0f/wvDQrgFEtw/x2tzvi2P7drPiK1dyCk
         G8KtE7pELtovGAgoXFdlEN6JI23vrSnu4415IsDPoQDfQInJ6OXi96pWol6n1qostae2
         1vLpotxgD8+pTpP/87kQtYuBFyT8Gn7N6i/9GI2GKX+dULed/pD9hyN4pflQEQA0TpCv
         hla4lLWPbXo3VbWSrD0H9VK7llLPsMuL/pgzgw82R37VxY3l6kgXPjIvVXjnzxTFyDXg
         7/VJmMMWuO408Roi/heHBALrh6fzzWkt4MWNfHKQNrFxhmtWjmCL0rBtDtPtYh6aKGmp
         mhDQ==
X-Forwarded-Encrypted: i=1; AJvYcCWUx5gN/C8TE6iXnuq1Vcmw+4jh83wUdJ8gxoaBfopl4GwVLEjG/X7koMw59Ke/DxGtVMGeOn88@vger.kernel.org
X-Gm-Message-State: AOJu0Yz73cACPGTp/3TBwV1SL9siqV5hTTv99LFFZVTjsrBehrOc9n3s
	I2A+6z61+uTNFvqMIsDD1xEEPNky5NXJeB2ThivpOJZFzjDUgYxYVBzZHuqPSfmzMTDSbSWoaS/
	1YhLME3xTK9hstqswZcdvm6mbKIxBPPWcbpIV/w==
X-Gm-Gg: ASbGncvAnSC0Hx/PfRldqXJw35mooADYtAePjBG3FL+2RPv+Q9vvzRFCzFq9znaogvR
	f5voI1ktykMGMxZL+IzFqLghuV/okgeqVJO5y/bTBH4UCOJVdwXeYb1mQpk4WiPtNb6kuJIcg+W
	qrRKyM5jOX8/FYVcFk5+OGjlkjeVuYr2mLEofdEVPXbD6c43Od2/Z1wlDrsw==
X-Google-Smtp-Source: AGHT+IF4Hqd0y6tvOBG1L9437crSiShcfp+ae/DQ2Kz7JAQEC4Ms9UYLukhP4MfVCN7OnazqSSf3NmzN1q87oneOTuk=
X-Received: by 2002:a05:6102:149b:b0:4b9:bc52:e050 with SMTP id
 ada2fe7eead31-4c586f1e376mr9399814137.2.1743172976411; Fri, 28 Mar 2025
 07:42:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250326154346.820929475@linuxfoundation.org> <CA+G9fYuY7iX+3=Yn77JjgiDiZAZNcpe0cW-y_M3sazhFN7dGLw@mail.gmail.com>
In-Reply-To: <CA+G9fYuY7iX+3=Yn77JjgiDiZAZNcpe0cW-y_M3sazhFN7dGLw@mail.gmail.com>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Fri, 28 Mar 2025 20:12:45 +0530
X-Gm-Features: AQ5f1Jrr3okkYsKcySxu_-gULq0rRUbR8tw6Cwpyo_vJOfJMTAWnBOuVF6pmc6E
Message-ID: <CA+G9fYtdg6OopeUQWkVmW9CYoprtqzWVTQfaoaY1vUtXKEXD2Q@mail.gmail.com>
Subject: Re: [PATCH 6.6 00/76] 6.6.85-rc2 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, 
	broonie@kernel.org, Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Cgroups <cgroups@vger.kernel.org>, 
	linux-mm <linux-mm@kvack.org>, Shakeel Butt <shakeelb@google.com>
Content-Type: text/plain; charset="UTF-8"

On Fri, 28 Mar 2025 at 17:14, Naresh Kamboju <naresh.kamboju@linaro.org> wrote:
>
> On Wed, 26 Mar 2025 at 21:16, Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
> >
> > This is the start of the stable review cycle for the 6.6.85 release.
> > There are 76 patches in this series, all will be posted as a response
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
> >
> > Responses should be made by Fri, 28 Mar 2025 15:43:33 +0000.
> > Anything received after that time might be too late.
> >
> > The whole patch series can be found in one patch at:
> >         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.6.85-rc2.gz
> > or in the git tree and branch at:
> >         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.6.y
> > and the diffstat can be found below.
> >
> > thanks,
> >
> > greg k-h
>
> Regressions on arm64 devices cpu hotplug tests failed with gcc-13 and
> clang-20 the stable-rc 6.6.85-rc2
>
> These regressions are the same as stable-rc 6.1 cpu hotplug regressions.
>
> First seen on the 6.6.85-rc2
> Good: v6.6.83
> Bad: 6.6.85-rc2

I have reverted this patch and confirms that reported regressions fixed,
  memcg: drain obj stock on cpu hotplug teardown
  commit 9f01b4954490d4ccdbcc2b9be34a9921ceee9cbb upstream.

-  Naresh

