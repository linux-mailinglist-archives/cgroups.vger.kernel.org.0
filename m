Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24E2650ADB8
	for <lists+cgroups@lfdr.de>; Fri, 22 Apr 2022 04:23:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443312AbiDVCZ7 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 21 Apr 2022 22:25:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1443317AbiDVCZ6 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 21 Apr 2022 22:25:58 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3ECD34B1D3
        for <cgroups@vger.kernel.org>; Thu, 21 Apr 2022 19:23:07 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id q1so6577048plx.13
        for <cgroups@vger.kernel.org>; Thu, 21 Apr 2022 19:23:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=/r6xw+gj3ZTku8Ban2Ty+342ukm24iTASQaEDp2KNQM=;
        b=Ib8b5bLDkA26LrA6dCcYGi19rtQ+3Mrl6DdFt3V0pfQltiTIh6katrX1tWJQA7hCPd
         41Ga7W4SB7elDpM08p0ULKc3OfwLM6N4aOwQPVAfvEhJnVZiiNDQYp9a+gv/dEQ/GO75
         C/Y0//i7ekOZj7Xi+eB06n63ANAWPwLyckiVSNQynddV6XvJSIcaiYOEP2mvAmjIZKyu
         BvnD/t/fseEXFrc45GU4xVEBEun6biSDbiELpy+XpCabvEPJ4OUYK+VQM/XB0NiUytoC
         Wno6y/lSbCTrO5OY4/A7HcRrEmE8XfnxzYt8dHvQa7pcRY2iAgGWzRo1ydNtrNOaZ8XH
         1SUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=/r6xw+gj3ZTku8Ban2Ty+342ukm24iTASQaEDp2KNQM=;
        b=mqJUP9BY8GFQmbEYtk4lpmMzeqA3SqvaIlhueyDUhU5LWT+xTiNWlslDTO3j/KECtb
         ayK4pqxCF7HMVWWTIcIKmY+ffnq8dNX7+B6gnoLoNoM4sBL1Mg27CQN+Nq0BAjZtNhNT
         FBDevclS2Fp5Rc/gU+uirHYke26KuBGrY2C7AUh4Pfea3exAfxsgSxIZmQ9sXVJtgBnV
         jBCJ0uVF2vnfKwO/sACmyVfw+Y9fk/3L6A4/z57j+C8LuFvmaxSdhCsi+/oiCHbFATR0
         dagQODipqXA7Scc5njviiaAjUS7hiV/4SxqMftea9eIyJpWBLzQGTi34NVjfNCNA+t/v
         SmVA==
X-Gm-Message-State: AOAM533q6gqkIhLbSAHhOU9UtwEZgDzOMk9ADT6VtAN5s9Lt+gOBjvKh
        muXdPrwgj3vI5S4apvrhMoKo5g==
X-Google-Smtp-Source: ABdhPJx8bN1zOvSNsoELmBDe7+fKr70if1BlvjKWBht+eNDqttt5xN3LauEEFhE86vFppa150f4cBA==
X-Received: by 2002:a17:902:8214:b0:158:b5c2:1d02 with SMTP id x20-20020a170902821400b00158b5c21d02mr2189234pln.27.1650594186815;
        Thu, 21 Apr 2022 19:23:06 -0700 (PDT)
Received: from localhost ([139.177.225.255])
        by smtp.gmail.com with ESMTPSA id cp19-20020a056a00349300b0050a890c8c16sm453057pfb.19.2022.04.21.19.23.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Apr 2022 19:23:06 -0700 (PDT)
Date:   Fri, 22 Apr 2022 10:23:02 +0800
From:   Muchun Song <songmuchun@bytedance.com>
To:     Lu Jialin <lujialin4@huawei.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Shakeel Butt <shakeelb@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        Yang Shi <shy828301@gmail.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Wang Weiyang <wangweiyang2@huawei.com>,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH -next] mm/memcontrol.c: make cgroup_memory_noswap static
Message-ID: <YmIRhikdGutx6TeE@FVFYT0MHHV2J.usts.net>
References: <20220421124736.62180-1-lujialin4@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220421124736.62180-1-lujialin4@huawei.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Thu, Apr 21, 2022 at 08:47:36PM +0800, Lu Jialin wrote:
> cgroup_memory_noswap is only used in mm/memcontrol.c, therefore just make
> it static, and remove export in include/linux/memcontrol.h
> 
> Signed-off-by: Lu Jialin <lujialin4@huawei.com>

Reviewed-by: Muchun Song <songmuchun@bytedance.com>

Thanks.
