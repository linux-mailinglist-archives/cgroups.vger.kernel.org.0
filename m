Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4091E1A6C5D
	for <lists+cgroups@lfdr.de>; Mon, 13 Apr 2020 21:11:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387843AbgDMTLk (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 13 Apr 2020 15:11:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2387811AbgDMTLk (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 13 Apr 2020 15:11:40 -0400
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62DA9C0A3BDC
        for <cgroups@vger.kernel.org>; Mon, 13 Apr 2020 12:11:39 -0700 (PDT)
Received: by mail-qk1-x742.google.com with SMTP id l25so10664075qkk.3
        for <cgroups@vger.kernel.org>; Mon, 13 Apr 2020 12:11:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=+lbubkUGFiM6VzQ+ueHXGQsXYs3AnJsTHepD8DGOyaE=;
        b=eaYLPoyRllFIIJ1rsXYKhFdiz0QqsdX7PAjZtRacsfQZqFUOOFeyjQ7vNX5brDMf82
         Uue5XZO8jlEiz9SQba87q5dC3SUCiD7k3LRm/w/0yX/UkQ2PzmEiC16wNMwL3/s5Fwyw
         HtsKhQjpjwegOtBIZ9HSjQH1YdNlbxSiPuzcLphimp2WqXJpyyvPRUNMWOUk7iixdixj
         Z/pbwzYJv+KRMY04nvZDKbtpp4CoiJ60W/HRsp/sdywWVD2JB6nKyxfHGPu8xDc5+MHT
         vVHbrbYqM5DBhz2tVz/4/rEmbjeV3PWxyENQFvkI4YdOpFxfCbmRFX2dFi+3WAbjEy6x
         19pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=+lbubkUGFiM6VzQ+ueHXGQsXYs3AnJsTHepD8DGOyaE=;
        b=QAUEXP5eNU2vd2nifjjzylojMBspckC4fVtHtKw3lXpb6+Yyyig8mLOJq4fxQovmGu
         XcCUvCGCr8xGMH6NYR0tdhiK2Gx5ziYUKnu1u7rlrJd7pcEiM0dEUkq8Eeee0PlPejZf
         OvhwotasYujjSP0yir/YGLMr8fOtKCPJ2FEwiAjN0bArIhSuUHoISEKdm4erIhdHHqBH
         DHLmAb0EG1p+vADGd4CXmcTDNIwh9qC0gRJNdKPRHmw26NVvrHpheYJW3QrGUqnX32sj
         2NZRDetHXaCehuN8CIfXxFKYnTpN7Cedkdr1BxRbHH1vYLVJlI5FvDKLwfgobvceVY5C
         YpMA==
X-Gm-Message-State: AGi0PubE7gClon9PyiuX3oaAE232RyuCVaRKtkA6hfZ/zNnTVZ+GDdo6
        dNIv3685HEmnXQ/di2jatb1WG+3YKiQ=
X-Google-Smtp-Source: APiQypLnNJ8smZT+QChmfC/ZWvRkkCA+pg4ypBQGWrb47G+Spc86/Me8goNHAQjSvAJtsmuKIFHLmg==
X-Received: by 2002:a37:71c4:: with SMTP id m187mr6447160qkc.4.1586805098466;
        Mon, 13 Apr 2020 12:11:38 -0700 (PDT)
Received: from localhost ([199.96.181.106])
        by smtp.gmail.com with ESMTPSA id d17sm9709606qtb.74.2020.04.13.12.11.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Apr 2020 12:11:37 -0700 (PDT)
Date:   Mon, 13 Apr 2020 15:11:36 -0400
From:   Tejun Heo <tj@kernel.org>
To:     Kenny Ho <y2kenny@gmail.com>
Cc:     Kenny Ho <Kenny.Ho@amd.com>, cgroups@vger.kernel.org,
        dri-devel <dri-devel@lists.freedesktop.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        Alex Deucher <alexander.deucher@amd.com>,
        Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        "Kuehling, Felix" <felix.kuehling@amd.com>,
        "Greathouse, Joseph" <joseph.greathouse@amd.com>, jsparks@cray.com
Subject: Re: [PATCH v2 00/11] new cgroup controller for gpu/drm subsystem
Message-ID: <20200413191136.GI60335@mtj.duckdns.org>
References: <20200226190152.16131-1-Kenny.Ho@amd.com>
 <CAOWid-eyMGZfOyfEQikwCmPnKxx6MnTm17pBvPeNpgKWi0xN-w@mail.gmail.com>
 <20200324184633.GH162390@mtj.duckdns.org>
 <CAOWid-cS-5YkFBLACotkZZCH0RSjHH94_r3VFH8vEPOubzSpPA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOWid-cS-5YkFBLACotkZZCH0RSjHH94_r3VFH8vEPOubzSpPA@mail.gmail.com>
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hello, Kenny.

On Tue, Mar 24, 2020 at 02:49:27PM -0400, Kenny Ho wrote:
> Can you elaborate more on what are the missing pieces?

Sorry about the long delay, but I think we've been going in circles for quite
a while now. Let's try to make it really simple as the first step. How about
something like the following?

* gpu.weight (should it be gpu.compute.weight? idk) - A single number
  per-device weight similar to io.weight, which distributes computation
  resources in work-conserving way.

* gpu.memory.high - A single number per-device on-device memory limit.

The above two, if works well, should already be plenty useful. And my guess is
that getting the above working well will be plenty challenging already even
though it's already excluding work-conserving memory distribution. So, let's
please do that as the first step and see what more would be needed from there.

Thanks.

-- 
tejun
