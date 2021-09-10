Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 26FCE40709B
	for <lists+cgroups@lfdr.de>; Fri, 10 Sep 2021 19:37:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230489AbhIJRi6 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 10 Sep 2021 13:38:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230440AbhIJRi5 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 10 Sep 2021 13:38:57 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74031C061574;
        Fri, 10 Sep 2021 10:37:46 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id j6so2179007pfa.4;
        Fri, 10 Sep 2021 10:37:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=jL2YbilCduyWVuLH2nyWGfZ9AabnwMlBBSRytcjIHVA=;
        b=GgBEAjpyJudHJW1qXwmNtoQyZEkoV+deBT9s3t6hEcqTihdSKoJEvrP13wsSDQ40hA
         ZSn9iYRFxbjcu5jnWG7iujvujUDDXs82ys+0QLYnpH+D6ghZYdSu8ylk8Y1Y/WpKTavC
         c35/jfw/5cwmI20noQzrqxpRY0lENcALsrDY/AzTB13OSLbkpo4sABmnANkk6ZmJ9IbK
         9duYffwM7wGLWyZVdbP+krzQNNtgcKbnU+lq2GUdwb4iN8lhAQVjg2psAPXZ3Rnzab5U
         OB2j8Q2RUw1tqPt7uR4orpTvMBtmwroHwH4E4SniulU6kgOgJoZO8zc1moR3Vy52Sqn3
         4dLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=jL2YbilCduyWVuLH2nyWGfZ9AabnwMlBBSRytcjIHVA=;
        b=5KmHih7wvnOnvlaFXOhb6fYdlkc8Jnt0QRzMG2JTp9Enmif7AQTuJYvClREBWjoVjD
         ziqE9sFUlbvnKBCmv5ij5FOPoiZbNjNfBTKLCk7xPP8/pSIC72H6aY0F15f8drV4l4hZ
         FvasT7CSPNjsoMIk7nfhvDMEjH00T3NS1gOP96wgAPDJzSjR66fmOp2Qeu1nSDN80ShK
         gLWCA6RWHbsyhtTlzW/yGcvLAwmsePYmzUsWZW/TMtpa+QyFG3ryB1yk+VKAdqflUyFR
         auJsbBkC+D7VQpGdnpEV+yVjPBBN/qeub0CTRHNxM1ye+OJ3ccZie+UYRr59E946FngG
         UBjw==
X-Gm-Message-State: AOAM530WZ+zOH5/sbtHFIzh3fNE/vF61v1LCJYiSq253iH1aOQNX9OMo
        63zb58dCURiaCWwBHSoMdXE=
X-Google-Smtp-Source: ABdhPJy5yItH1fYG9jOhsOPwY97ij9yRuH3XG0IVVG0R6TASUN1cCGQDdhHUVpz6ETbhv+lWeHxGFA==
X-Received: by 2002:a62:7802:0:b0:3f3:7300:a602 with SMTP id t2-20020a627802000000b003f37300a602mr9150817pfc.52.1631295465697;
        Fri, 10 Sep 2021 10:37:45 -0700 (PDT)
Received: from localhost (2603-800c-1a02-1bae-e24f-43ff-fee6-449f.res6.spectrum.com. [2603:800c:1a02:1bae:e24f:43ff:fee6:449f])
        by smtp.gmail.com with ESMTPSA id j25sm4513671pff.34.2021.09.10.10.37.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Sep 2021 10:37:45 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Fri, 10 Sep 2021 07:37:44 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Vipin Sharma <vipinsh@google.com>
Cc:     Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
        "brookxu.cn" <brookxu.cn@gmail.com>, lizefan.x@bytedance.com,
        hannes@cmpxchg.org, linux-kernel@vger.kernel.org,
        cgroups@vger.kernel.org
Subject: Re: [RFC PATCH 3/3] misc_cgroup: remove error log to avoid log flood
Message-ID: <YTuX6Cpv1kg+DHmJ@slm.duckdns.org>
References: <CAHVum0ffLr+MsF0O+yEWKcdpR0J0TQx6GdDxeZFZY7utZT8=KA@mail.gmail.com>
 <YTpY0G3+IJYmGbdd@blackbook>
 <478e986c-bc69-62b8-936e-5b075f9270b4@gmail.com>
 <20210910092310.GA18084@blackbody.suse.cz>
 <1679f995-5a6f-11b8-7870-54318db07d0d@gmail.com>
 <20210910153609.GC24156@blackbody.suse.cz>
 <YTuH9fULTx+pLuuH@slm.duckdns.org>
 <CAHVum0ezWW=4x2YgXHhEUFQOkFGBpP+R1Uc-KedHr+r0LGibwA@mail.gmail.com>
 <YTuTr5Hw4hPIWepd@slm.duckdns.org>
 <CAHVum0e+68df7b_e0RoCGgA1h_SLdTt9t2MZ0VgA9afPW9iEvg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHVum0e+68df7b_e0RoCGgA1h_SLdTt9t2MZ0VgA9afPW9iEvg@mail.gmail.com>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hello,

On Fri, Sep 10, 2021 at 10:31:02AM -0700, Vipin Sharma wrote:
> I don't have a strong aversion to hierarchical events only as well if
> that is more suited for the cgroup v2 style.

It's not a hard requirement but I'd prefer hierarchical over local unless
there are strong reasons against doing so.

Thanks.

-- 
tejun
