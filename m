Return-Path: <cgroups+bounces-338-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BEC67E92B9
	for <lists+cgroups@lfdr.de>; Sun, 12 Nov 2023 21:38:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 47F901C20336
	for <lists+cgroups@lfdr.de>; Sun, 12 Nov 2023 20:38:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0A7018640;
	Sun, 12 Nov 2023 20:38:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SeWyFddc"
X-Original-To: cgroups@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40A891863E
	for <cgroups@vger.kernel.org>; Sun, 12 Nov 2023 20:38:20 +0000 (UTC)
Received: from mail-qv1-xf2b.google.com (mail-qv1-xf2b.google.com [IPv6:2607:f8b0:4864:20::f2b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 504F31BEC;
	Sun, 12 Nov 2023 12:38:19 -0800 (PST)
Received: by mail-qv1-xf2b.google.com with SMTP id 6a1803df08f44-66fa16092c0so24230676d6.0;
        Sun, 12 Nov 2023 12:38:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699821498; x=1700426298; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6YztxOL1r/fnKaUwBDzI6/qa/Ai7h1WY5G4jeElcAzw=;
        b=SeWyFddc5C6ZQfWCOE6jpjt44dxEczX56Cp90mMJdfIAaRpkl5B5ExmIGOSteziEU5
         TPcuaxhySjf9b6cV7u7Vai1lZ4GivItbALReofj5CiPnjvPS9aTRRVK/SnT0VAzo5XSD
         H0wSlbV9Gb8JZl4fBSR/YVk7TPUb7L4aK/Ol1kk1ad/zB2TkezvemGpO9dBqyMLxVKHS
         3k+mak+T9DfFbM9gBOEPuzN1InNtsYfCtMUtoCDyBHe6Mp9GKcPMCyPANqCgZSyaUdMh
         bQoz7fxCLGIzsRbWwck6i3Abbrl91ODTxXwd0D+MF+ZWOITk9P5kniJbuP8h3Fmowxm8
         lCMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699821498; x=1700426298;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6YztxOL1r/fnKaUwBDzI6/qa/Ai7h1WY5G4jeElcAzw=;
        b=NSgcSVd5QoPJjkpo5ZZD0f3znUgnqA4SXbhl3cyXsMn80VcMniIiTb00hWpmOBdIcf
         VTbO3qiljz+wlqJicoCenBfdw9YFKDwHI3xie5YfUzNBk/jWCBYt8nfcV0AxtM83oIk1
         8eiJiwxR2+Jtc1LB032zSpFqAt7BHOGSRmoemafo1uYWvGYZJSWZEXjLoC9Jbo+nCsue
         73UnR9dEYGmth1uFhW6+7K1Hbfl0SFkDyqm1uAV/9nfTY8696Q8yQsgKAprnITQ4R8FB
         3J9uaig/TCTQPFY0La9TON3+UssQctA2EG83urWM3x5j/zgyUA4ONO9WFqWe1fZwlTyn
         wtqw==
X-Gm-Message-State: AOJu0YxGPwxAFGdlr4IIbdJ4vUcGToGuSCUB3Ky09xZ31khyUc5dAicp
	VrV0TmVZ3CGHpKDQ3/nFeDI=
X-Google-Smtp-Source: AGHT+IGs5uzQNsy8dAyelpniyvgTA/dFx1GFzoBnbdFUnNl8n2tb7aZwz5JLw71uKRant/cErWKjZw==
X-Received: by 2002:a0c:c58d:0:b0:66d:4a22:d7cd with SMTP id a13-20020a0cc58d000000b0066d4a22d7cdmr5381678qvj.60.1699821498368;
        Sun, 12 Nov 2023 12:38:18 -0800 (PST)
Received: from localhost ([164.86.0.75])
        by smtp.gmail.com with ESMTPSA id bo9-20020a05621414a900b0065b02eaeee7sm1491349qvb.83.2023.11.12.12.38.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Nov 2023 12:38:18 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date: Sun, 12 Nov 2023 14:38:10 -0600
From: Tejun Heo <tj@kernel.org>
To: Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>
Cc: Intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
	cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
	Johannes Weiner <hannes@cmpxchg.org>,
	Zefan Li <lizefan.x@bytedance.com>,
	Dave Airlie <airlied@redhat.com>,
	Daniel Vetter <daniel.vetter@ffwll.ch>,
	Rob Clark <robdclark@chromium.org>,
	=?iso-8859-1?Q?St=E9phane?= Marchesin <marcheu@chromium.org>,
	"T . J . Mercier" <tjmercier@google.com>, Kenny.Ho@amd.com,
	Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
	Brian Welty <brian.welty@intel.com>,
	Tvrtko Ursulin <tvrtko.ursulin@intel.com>
Subject: Re: [RFC v6 0/8] DRM scheduling cgroup controller
Message-ID: <ZVE3shwiRbUQyAqs@mtj.duckdns.org>
References: <20231024160727.282960-1-tvrtko.ursulin@linux.intel.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231024160727.282960-1-tvrtko.ursulin@linux.intel.com>

Hello,

From cgroup POV, it generally looks fine to me. As before, I'm really
curious whether this is something other non-intel drivers can get behind.
Just one nit.

On Tue, Oct 24, 2023 at 05:07:19PM +0100, Tvrtko Ursulin wrote:
>  * Allowing per DRM card configuration and queries is deliberatly left out but
>    it is compatible in principle with the current proposal.
> 
>    Where today we have, for drm.weight:
> 
>    100
> 
>    We can later extend with:
> 
>    100
>    card0 80
>    card1 20
>
>    Similarly for drm.stat:
> 
>    usage_usec 1000
>    card0.usage_usec 500
>    card1.usage_usec 500

These dont't match what blkcg is doing. Please use nested keyed format
instead.

Thanks.

-- 
tejun

