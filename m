Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AAAEC407072
	for <lists+cgroups@lfdr.de>; Fri, 10 Sep 2021 19:19:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229682AbhIJRU5 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 10 Sep 2021 13:20:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229664AbhIJRU5 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 10 Sep 2021 13:20:57 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00F1CC061574;
        Fri, 10 Sep 2021 10:19:46 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id v123so2431559pfb.11;
        Fri, 10 Sep 2021 10:19:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=02ZeBZU29R1KVCqeFtK2ESzdkVxQ2Opf6evacdtFUxc=;
        b=jl8XqBWfp5XyTB7oUD+ZWxcBGzhuAaxwldfYoiqmwmuu7Q0tAtyjae8AMreWOPvW0s
         utgdOKweJtvVQcMTuQ860R6K3q7BZQo0LJTzsQVnaQvtYdiETNccC5381EUxPVRlJlA6
         jPx4X7/7G8WVSG0iCUHBUCEUsDbi4iT0tEMDPmmuyWch7/8OgT3uCyodv2A7qlFXBLY+
         /bM/jU2Uo3q/m02kK2akuucklj/Utk2fFTD5NhE2h9E4qrhZdZ4QKIHqwOTF0lQIjUAL
         kRpdxSfJqTzxYKGCgk3MimG/MHNoTxEHF8ARtzieLsNFAMi8d3kqQYWjgrr4zftGIHr5
         jBog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=02ZeBZU29R1KVCqeFtK2ESzdkVxQ2Opf6evacdtFUxc=;
        b=U3Ll7RlflB9kOdjU1b3Jebch8F1oi2XLEqVCvcFei/d4E7Y08capYJTATvoY66D/6d
         kHBoOnGP/sW05YzLL2OWIGp2XoIg7l1xRBmKQ52YanjKE1VjN2zBgGDk997zin+WTFrT
         0Vz6pRECk/1tdBuZUpQFdqMTafhtBza18vKDCFlVWE/+Gjznpi4XP7doj7BU8zGbNCvk
         AAhB135edg/yLfxYksqKExAoFYsyH3vchOFmZr2IQB1SQgrPsRCd2hjdvx7iUWA0VyVK
         MNnlr/IfGaA0zknuMOzdBZXRXSpQH8Crw0J87FMZBCc3TFgpPzS+1tIFe4bQ0k/tOjWk
         vhYw==
X-Gm-Message-State: AOAM531LkIoDDvNSYusdVh+XinEQSxxxR/aD9iESS2vqIL/cxX2DHYnm
        HzoKHU18FDJhxOH1Y88+cbI=
X-Google-Smtp-Source: ABdhPJyg4fikHCnCyr342MUfOjek1jRcCj4F3IcHyMNGDa8n3FYTHX3jKAcv9ylEqc9Xj0GIZp4vBg==
X-Received: by 2002:a63:4b53:: with SMTP id k19mr8040709pgl.3.1631294385294;
        Fri, 10 Sep 2021 10:19:45 -0700 (PDT)
Received: from localhost (2603-800c-1a02-1bae-e24f-43ff-fee6-449f.res6.spectrum.com. [2603:800c:1a02:1bae:e24f:43ff:fee6:449f])
        by smtp.gmail.com with ESMTPSA id n22sm5455331pff.57.2021.09.10.10.19.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Sep 2021 10:19:44 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Fri, 10 Sep 2021 07:19:43 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Vipin Sharma <vipinsh@google.com>
Cc:     Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
        "brookxu.cn" <brookxu.cn@gmail.com>, lizefan.x@bytedance.com,
        hannes@cmpxchg.org, linux-kernel@vger.kernel.org,
        cgroups@vger.kernel.org
Subject: Re: [RFC PATCH 3/3] misc_cgroup: remove error log to avoid log flood
Message-ID: <YTuTr5Hw4hPIWepd@slm.duckdns.org>
References: <86e89df640f2b4a65dd77bdbab8152fa8e8f5bf1.1631077837.git.brookxu@tencent.com>
 <20210909143720.GA14709@blackbody.suse.cz>
 <CAHVum0ffLr+MsF0O+yEWKcdpR0J0TQx6GdDxeZFZY7utZT8=KA@mail.gmail.com>
 <YTpY0G3+IJYmGbdd@blackbook>
 <478e986c-bc69-62b8-936e-5b075f9270b4@gmail.com>
 <20210910092310.GA18084@blackbody.suse.cz>
 <1679f995-5a6f-11b8-7870-54318db07d0d@gmail.com>
 <20210910153609.GC24156@blackbody.suse.cz>
 <YTuH9fULTx+pLuuH@slm.duckdns.org>
 <CAHVum0ezWW=4x2YgXHhEUFQOkFGBpP+R1Uc-KedHr+r0LGibwA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHVum0ezWW=4x2YgXHhEUFQOkFGBpP+R1Uc-KedHr+r0LGibwA@mail.gmail.com>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hello,

On Fri, Sep 10, 2021 at 10:16:46AM -0700, Vipin Sharma wrote:
> For now, I think we can just have one file, events.local
> (non-hierarchical) which has %s.max type entries. This will tell us
> which cgroup is under pressure and I believe this is helpful.

How about just sticking with hierarchical events? Do you see a lot of
downsides with that compared to .local?

Thanks.

-- 
tejun
