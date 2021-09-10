Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D2EF406FA9
	for <lists+cgroups@lfdr.de>; Fri, 10 Sep 2021 18:29:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229531AbhIJQa4 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 10 Sep 2021 12:30:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbhIJQaz (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 10 Sep 2021 12:30:55 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3DF0C061574;
        Fri, 10 Sep 2021 09:29:44 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id f11-20020a17090aa78b00b0018e98a7cddaso1818187pjq.4;
        Fri, 10 Sep 2021 09:29:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=vdtqoZFv4MiNf9W0UtI32iEhVLYL/ZJOdc/dPw1DUT0=;
        b=mKUglSAtqg5FFG0aE6ZYZRsjNgt0zN0tJdYTnxtOekBzBANig0bDKYPzJjqZ0Ioqwy
         flmnTwEG7eZEPaY40itMixbnaOAaLFbT7ZyMgLWsgbL1nE4729lG466b5abBZaPFyLUW
         xPHNh7bpUKRokfImZI1EfpksGLzp6dCuKDpU/PFvUovJ8MqthjiQwoND5XpJ2N0YtX7g
         /ISPOBz/Ne+rFXxlUHPgFrS9n51wjpaFY2hNMYagYGYwzKWaHzyx76zm1UqJ0JVBVmie
         IDP/3qYSufIqwQMVphqqFW+Z3g4GOBG+p6KDF8r7+3XLI+rsYt1CCkOOECd5hvmGIWeR
         m6Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to;
        bh=vdtqoZFv4MiNf9W0UtI32iEhVLYL/ZJOdc/dPw1DUT0=;
        b=Ras2r57PSTtrf7e6OEsO0RQUTg78fQOqqb9lCMjgXawpwkTOIRJlKxRZJ1gZojR6uZ
         2EvbNqgh46dNMXncFJStAUf0utq7kVDI209OGhsWNtLGT/OiE5a0Na8mzVo1nOVQ9apF
         cLoFw8y2uAXGa8rdGvH9LouiWGNsms9GL8G9OxM5O0YRGKfzqgEYKOvbjvQuiZx9cviy
         7U8zkfraY/YKxiQPO8BQKRgKtpvE1CdaB3yV8ZPx2Czlcqj5AOonoMZLM2+H9hE57VD8
         bWiEs9UrvSPX933ohzKFvdssaRaXHsa8/tT6vFqeUyOz9w5IdD/idXbwEWSkBcWHWqpJ
         iCaQ==
X-Gm-Message-State: AOAM531vt9dy2+ru9vyBIfXZImf2tAbDoJGwmpmISjgAOl6WZwqrk4N4
        nAkb49hOi5JlObff8mCRsdc=
X-Google-Smtp-Source: ABdhPJwJyvEfjrZIYq522afmxJF7TXijqFxAuXFnynfmMEQAUKyqh7P5vjH8QvR/S6cXSa7usNocaw==
X-Received: by 2002:a17:902:7c11:b0:13a:ad7:4cb8 with SMTP id x17-20020a1709027c1100b0013a0ad74cb8mr8200500pll.2.1631291383918;
        Fri, 10 Sep 2021 09:29:43 -0700 (PDT)
Received: from localhost (2603-800c-1a02-1bae-e24f-43ff-fee6-449f.res6.spectrum.com. [2603:800c:1a02:1bae:e24f:43ff:fee6:449f])
        by smtp.gmail.com with ESMTPSA id l10sm5745608pgn.22.2021.09.10.09.29.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Sep 2021 09:29:43 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Fri, 10 Sep 2021 06:29:41 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>
Cc:     "brookxu.cn" <brookxu.cn@gmail.com>,
        Vipin Sharma <vipinsh@google.com>, lizefan.x@bytedance.com,
        hannes@cmpxchg.org, linux-kernel@vger.kernel.org,
        cgroups@vger.kernel.org
Subject: Re: [RFC PATCH 3/3] misc_cgroup: remove error log to avoid log flood
Message-ID: <YTuH9fULTx+pLuuH@slm.duckdns.org>
References: <988f340462a1a3c62b7dc2c64ceb89a4c0a00552.1631077837.git.brookxu@tencent.com>
 <86e89df640f2b4a65dd77bdbab8152fa8e8f5bf1.1631077837.git.brookxu@tencent.com>
 <20210909143720.GA14709@blackbody.suse.cz>
 <CAHVum0ffLr+MsF0O+yEWKcdpR0J0TQx6GdDxeZFZY7utZT8=KA@mail.gmail.com>
 <YTpY0G3+IJYmGbdd@blackbook>
 <478e986c-bc69-62b8-936e-5b075f9270b4@gmail.com>
 <20210910092310.GA18084@blackbody.suse.cz>
 <1679f995-5a6f-11b8-7870-54318db07d0d@gmail.com>
 <20210910153609.GC24156@blackbody.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210910153609.GC24156@blackbody.suse.cz>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hello,

On Fri, Sep 10, 2021 at 05:36:09PM +0200, Michal Koutný wrote:
> If there's a limit on certain level with otherwise unconstrained cgroup
> structure below (a valid config too), the 'fail' counter would help
> determining what the affected cgroup is. Does that make sense to you?

While the desire to make the interface complete is understandable, I don't
think we need to go too far in that direction given that debugging these
configuration issues requires human intervention anyway and providing
overall information is often enough of aid especially for simple controllers
like misc/pid. So, let's stick to something consistent and simple even if
not complete and definitely not name them "fail" even if we add them.

Thanks.

-- 
tejun
