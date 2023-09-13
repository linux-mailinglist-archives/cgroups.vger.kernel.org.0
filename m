Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D181979F07B
	for <lists+cgroups@lfdr.de>; Wed, 13 Sep 2023 19:38:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229924AbjIMRiJ (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 13 Sep 2023 13:38:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231236AbjIMRiI (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 13 Sep 2023 13:38:08 -0400
Received: from mail-qv1-xf34.google.com (mail-qv1-xf34.google.com [IPv6:2607:f8b0:4864:20::f34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4C01E3
        for <cgroups@vger.kernel.org>; Wed, 13 Sep 2023 10:38:04 -0700 (PDT)
Received: by mail-qv1-xf34.google.com with SMTP id 6a1803df08f44-64914f08c65so565776d6.1
        for <cgroups@vger.kernel.org>; Wed, 13 Sep 2023 10:38:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20230601.gappssmtp.com; s=20230601; t=1694626684; x=1695231484; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=FMB8mr1jou6Rc6ugTyWCVcw7o80clyz1E9xOmdaAf/g=;
        b=kTwi6NX3V/9UWzNvuUpTDpwNW0VyZNo2IExCr5YnmiInC1mQy40SbrCZyC74Foy3E+
         BQiwkLCpcA5Cenolto1lWgjYYgoDbncayWfuOIwkhWn2xQmAoMg+OWzFTUdVhJ9yR24U
         6PVpmgZKa5RNkaZaT3h31KPr6ENVlVDvMFLlFP0rAMCcfrj3eN1hlRPSg1x6e0xIjUgt
         SOvXKcr62/1fY5MGWVvVxifyyICOvC7DIfB6kyg4KXx8HU935fhHFG7RLrT9SVJk4246
         yFNBAjeIfY1/L+UlYjmE4VGuGXJHDCaWFeE08bgYXPu7uetoFeDCVYibPPKBQ1sfi5qP
         rDXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694626684; x=1695231484;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FMB8mr1jou6Rc6ugTyWCVcw7o80clyz1E9xOmdaAf/g=;
        b=vvCN2/hWw8tuOG3CYkFigIQ01RFG1Zh6vALKEajtXyo+3cq88EcdkuAsTpeLbjtqTR
         Oy5pahcyzYWlBwlBuSfLziCR68Xqs4AYfLx2q9Dn4tbLQqYSJ83mVmNCEi2D2et7E4Xt
         1jSmtcSV3H4r3jRJiq+J+lTTD8pRokSA7fssm7cjIB9bCpkqOwWUA/mwGX0KJev5OD2d
         0o8RqqefDabvzKzK/0xKmXbcvBxdbvvPUzi/rtlslxvmQXtWueStX9gZDLznVrLJYOX7
         GxnjrU0AKo+2iB7/Ktcn+K9VAZ2WhCn5Q5rbPpICVE3CH5d88X8Mj4nsi6QZwx2ylZ9J
         Hh0Q==
X-Gm-Message-State: AOJu0Yz6wZ0osHowyykZPRyk6WFIRRysbpoISz7kjJGar/zjMD0weDJP
        GqwO4YgZEgnV9eVUxdPNf/87cw==
X-Google-Smtp-Source: AGHT+IEOZNIjnmaONDw+RYYdhNTLQJe5QV/sjKmIyj9HhVFvHP1lNCA+hxznbQf+EyW13xiyrZY91g==
X-Received: by 2002:a05:6214:4c0d:b0:635:e0dd:db4b with SMTP id qh13-20020a0562144c0d00b00635e0dddb4bmr2786283qvb.37.1694626683942;
        Wed, 13 Sep 2023 10:38:03 -0700 (PDT)
Received: from localhost (2603-7000-0c01-2716-3012-16a2-6bc2-2937.res6.spectrum.com. [2603:7000:c01:2716:3012:16a2:6bc2:2937])
        by smtp.gmail.com with ESMTPSA id h8-20020a05620a10a800b0076dae4753efsm4050120qkk.14.2023.09.13.10.38.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Sep 2023 10:38:03 -0700 (PDT)
Date:   Wed, 13 Sep 2023 13:38:02 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Vern Hao <haoxing990@gmail.com>
Cc:     mhocko@kernel.org, roman.gushchin@linux.dev, shakeelb@google.com,
        akpm@linux-foundation.org, cgroups@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Xin Hao <vernhao@tencent.com>
Subject: Re: [PATCH v3] mm: memcg: add THP swap out info for anonymous reclaim
Message-ID: <20230913173802.GA48476@cmpxchg.org>
References: <20230913164938.16918-1-vernhao@tencent.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230913164938.16918-1-vernhao@tencent.com>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Thu, Sep 14, 2023 at 12:49:37AM +0800, Vern Hao wrote:
> From: Xin Hao <vernhao@tencent.com>
> 
> At present, we support per-memcg reclaim strategy, however we do not
> know the number of transparent huge pages being reclaimed, as we know
> the transparent huge pages need to be splited before reclaim them, and
> they will bring some performance bottleneck effect. for example, when
> two memcg (A & B) are doing reclaim for anonymous pages at same time,
> and 'A' memcg is reclaiming a large number of transparent huge pages, we
> can better analyze that the performance bottleneck will be caused by 'A'
> memcg.  therefore, in order to better analyze such problems, there add
> THP swap out info for per-memcg.
> 
> Suggested-by: Johannes Weiner <hannes@cmpxchg.org>
> Signed-off-by: Xin Hao <vernhao@tencent.com>

Acked-by: Johannes Weiner <hannes@cmpxchg.org>
