Return-Path: <cgroups+bounces-6522-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E5A03A3257E
	for <lists+cgroups@lfdr.de>; Wed, 12 Feb 2025 12:58:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8AFD2167231
	for <lists+cgroups@lfdr.de>; Wed, 12 Feb 2025 11:58:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1C1320B1FD;
	Wed, 12 Feb 2025 11:58:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="fzxDle9Z"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 658072063E5
	for <cgroups@vger.kernel.org>; Wed, 12 Feb 2025 11:58:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739361498; cv=none; b=ACGOxNxLx2mjMjVXlKlWW/ri9ZvFh+YPlR2QHltoF8JdHJmxJlOCx+O0cVZmJLK+U7fqZXrerT355xfdM1ZARZuP5WOBrFhXJlq31JXdML+CqqZ8mY724mbPFhWUZtn8vuNu+Wdq0Icv6GN2BR5HUjZ0tsRmguYprTxw6bs/nZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739361498; c=relaxed/simple;
	bh=Zr4yGBYQKB2JkRxHIXXJ2oz/3gXI/b3u5EhL7+/O86Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RxccxHzbvRspqgfjKMUBVnpLTnal4voPLYIRy4tKaP7xSZDnFICvO6auyV5fnEFAPQ/0zFJQ8VOFKrq/mhprk0+oYKuTixKrR2/bI2C3blhWM0rAz59bKHLgAPirgo212NcV1yOktejy15U2Gy6kyGtC7XGpcaJiDH5tt35Yuu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=fzxDle9Z; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-5de4f4b0e31so8668704a12.0
        for <cgroups@vger.kernel.org>; Wed, 12 Feb 2025 03:58:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1739361495; x=1739966295; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Me0chvjbJ1pFFLI2sZT0ghALOrQAWMmkakkHmyi7IVI=;
        b=fzxDle9Zwxv9UpqVmDh6UN39iE2L7E4XB1maiNJnvatR9rFpC/OqDguKPhkYrPMoQD
         EVM8cR/xT3uj2z6xlXARrO035aIe1wOcRgN+ezARuQuOkZXgSAWu1bUdbIioNKA35GLa
         yx1kyJlwGJH4TZdtjyKs3SRze/0iCS2ARw5J5K86iDMUEdi8RS3J7bs6ZgPVgheXtGFe
         3xQKCCvtbBXXPaRlv04pJRSZ67bPi8kOLBzcQbrXul2I6oDErCWlByVt3QHpTTQIbB5K
         DzctIxkRGqfvTuvJ8wFjXSAWd/R0nNdcvT6K01lEFsPfdNBrcqWwzl8CJv2M0YTdOsQF
         lwnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739361495; x=1739966295;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Me0chvjbJ1pFFLI2sZT0ghALOrQAWMmkakkHmyi7IVI=;
        b=XyWqk4Z9Q3ohtjFJPCxO4tmSyP/HOVfSYfvjAAZCFSUeRTdjn+gag2KDvJCaAsWUVc
         3+UW8hMySCdKPBGI6nP/6ClIbzY3pUujsMOYhVFHTcly902uEaAs9ZbisbuLnfoMjwrM
         tONU/ujwmONeuwCfKT6Uts03sbXYAq2P21YtNImVIiBqotvqHD7+4LYr1VGYEvblujM/
         rrbRFRGDHo400qbYQnbVL6+VJNaK75Nbx9dw48ljIi91pAaT5lrNYlEs6knYZV1Pf/Xi
         mO5duLaLJOtsxE8pr2/qfuaFy4PT0ogsm/1hvij0/b0CsyNETXCet9X8jHhuFGfCljpf
         rzag==
X-Forwarded-Encrypted: i=1; AJvYcCVKQtnOzm2Jpcw+iZEBAkzohMsME8JP58rjGtYfnFHoaN64wrLcDSsqjH5CKELuCBS+vE68oiS/@vger.kernel.org
X-Gm-Message-State: AOJu0Ywq2Q3fv2OyLRaBcjR2p8sfc+OoK6eX5bYvSkjmlxIPdFBpdhjb
	oEWMU9Bu+M9MpjRvSrDsNhIfJrcjSv1eSYklN5rKBiyilFMCRcULkUOSMnjUtJk=
X-Gm-Gg: ASbGncu3SUUWY+ZmKhf7Om5yhK8Y9ULnyvVFtyIUmdESjYOn0/bXLG0KNKfTWJ5K9dJ
	T5wpIkXIGQqL7e8L24udYOqRuOkEXLHw9ah0W9xKIQ91RjrAol+sPiTl4lQ/8OZN5oBlGzU1zb+
	hkmPqGhKgA7cO5hqYX78QOPJdAoLgYPaK2ZChVQmr7lzvLr/RBR9B6OOn0NxHAy4b1LrA5B5rNN
	yZ0j9sWYXjcrvHybpkIPQ+Npe7FkjBIF94TBSaeBhwVlEn14FTOEZdzP8xOoni7qxSTUtbgkDs5
	UcmCBq8fWhfE1Lk0jTgC+NrqaTxz
X-Google-Smtp-Source: AGHT+IFZ3F6WfAtZKj1YYoqYD9Alxhol5RnT7Ux/XbgtcW0L2oEEJ4Aa1ufzUnzaMa86H/wd3EO7cw==
X-Received: by 2002:a05:6402:2345:b0:5dc:545:40a7 with SMTP id 4fb4d7f45d1cf-5deadd9c9a0mr2372357a12.12.1739361494610;
        Wed, 12 Feb 2025 03:58:14 -0800 (PST)
Received: from localhost (109-81-84-135.rct.o2.cz. [109.81.84.135])
        by smtp.gmail.com with UTF8SMTPSA id 4fb4d7f45d1cf-5de4d250084sm9533100a12.16.2025.02.12.03.58.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Feb 2025 03:58:14 -0800 (PST)
Date: Wed, 12 Feb 2025 12:58:13 +0100
From: Michal Hocko <mhocko@suse.com>
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Chen Ridong <chenridong@huaweicloud.com>, akpm@linux-foundation.org,
	hannes@cmpxchg.org, yosryahmed@google.com, roman.gushchin@linux.dev,
	shakeel.butt@linux.dev, muchun.song@linux.dev, davidf@vimeo.com,
	mkoutny@suse.com, paulmck@kernel.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
	chenridong@huawei.com, wangweiyang2@huawei.com
Subject: Re: [PATCH] mm/oom_kill: revert watchdog reset in global OOM process
Message-ID: <Z6yM1dycm5E7vfT0@tiehlicka>
References: <20250212025707.67009-1-chenridong@huaweicloud.com>
 <Z6xig5sLNpFVFU2T@tiehlicka>
 <d264a73e-966f-4890-9e23-88d476f0fc81@huaweicloud.com>
 <bccc9e06-af8b-4a55-a69c-98596f1c1385@suse.cz>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bccc9e06-af8b-4a55-a69c-98596f1c1385@suse.cz>

On Wed 12-02-25 10:34:06, Vlastimil Babka wrote:
> On 2/12/25 10:19, Chen Ridong wrote:
> > 
> > 
> > On 2025/2/12 16:57, Michal Hocko wrote:
> >> On Wed 12-02-25 02:57:07, Chen Ridong wrote:
> >>> From: Chen Ridong <chenridong@huawei.com>
> >>>
> >>> Unlike memcg OOM, which is relatively common, global OOM events are rare
> >>> and typically indicate that the entire system is under severe memory
> >>> pressure. The commit ade81479c7dd ("memcg: fix soft lockup in the OOM
> >>> process") added the touch_softlockup_watchdog in the global OOM handler to
> >>> suppess the soft lockup issues. However, while this change can suppress
> >>> soft lockup warnings, it does not address RCU stalls, which can still be
> >>> detected and may cause unnecessary disturbances. Simply remove the
> >>> modification from the global OOM handler.
> >>>
> >>> Fixes: ade81479c7dd ("memcg: fix soft lockup in the OOM process")
> >> 
> >> But this is not really fixing anything, is it? While this doesn't
> >> address a potential RCU stall it doesn't address any actual problem.
> >> So why do we want to do this?
> >> 
> > 
> > 
> > [1]
> > https://lore.kernel.org/cgroups/0d9ea655-5c1a-4ba9-9eeb-b45d74cc68d0@huaweicloud.com/
> > 
> > As previously discussed, the work I have done on the global OOM is 'half
> > of the job'. Based on our discussions, I thought that it would be best
> > to abandon this approach for global OOM. Therefore, I am sending this
> > patch to revert the changes.
> > 
> > Or just leave it?
> 
> I suggested that part doesn't need to be in the patch, but if it was merged
> with it, we can just leave it there. Thanks.

Agreed!

-- 
Michal Hocko
SUSE Labs

