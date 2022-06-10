Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9AC5F545C0E
	for <lists+cgroups@lfdr.de>; Fri, 10 Jun 2022 08:03:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346377AbiFJGDj (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 10 Jun 2022 02:03:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243100AbiFJGDg (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 10 Jun 2022 02:03:36 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F33E86466
        for <cgroups@vger.kernel.org>; Thu,  9 Jun 2022 23:03:31 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id t2so22004344pld.4
        for <cgroups@vger.kernel.org>; Thu, 09 Jun 2022 23:03:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=J1XXW/35XoF6Aq4Yttw/47Ee+SbcRPhL6DUo491eP6M=;
        b=SDnqQnYW4s0VncwzYTXsBRd1NSOJCGawbA0wHY3UJJmP8C4vqtaU8Sko5l9pc1XfUE
         TzINJx/+WTBiweqzUrhE24hnzVoYrjm7F084uiiVkWF8rejMHaFFo3dgYNp8SjwLc/+l
         u8K5SCi8lhaJwlGuVE1VnQkM1dkzAeqMgNB1SBtBt0gni2/EBsJeUzcMT4/EkwZZQeX1
         jDhXRLw+BCGb4gfWqqFOUtYe1UpYvh1amf/ofBXF55QvB4vMMPn8nhFd3AmEc6LTwi4K
         KmFrNHcbRHhNBLpfiR7g5guHDD+ro1d7aO+YvLx2erxMbqzs7EVy1n+Cxc0/+fsO/4je
         32sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=J1XXW/35XoF6Aq4Yttw/47Ee+SbcRPhL6DUo491eP6M=;
        b=uAVqO4fuW6jIHng1DpUGn1iJpjJfTVyw/wdYo7XLlIMwISqanhNZ+zbTZpi7+8hLVJ
         S/cmCSBF+P1jEY+kaN0q+iJHCo6Kfjg66W+Zrj7yoxDz7VZoTUY0/9ZfLTmw1LChX1Dc
         cqL3mZ/VYnj1g4yeo7znpbYbT6M7TWBXv2xkXQJtj+PcAMyKjaJmQH3RJNQAiEUqS8Yc
         iQ4AMkFg/F3O/ZewmwfJhj+4JBrfgNvajzKAJfAzeSMVma5n4hQZ8ltMSGvEqBJu9DZm
         LaZV7y1F+f2cch8jnn4uvdEEh5e1YKLu2ckFheeT8R2impnYYL3NmyTXuopxk+kvR4Bq
         owng==
X-Gm-Message-State: AOAM532wmcCE6NOo4W8doOBnthjW/vjU4ge39Ds/uDytSjJCJxNpRY19
        Raoy1Wn+jtd+avU3/OPzYzTsfQ==
X-Google-Smtp-Source: ABdhPJwxqCOh/+pUmiEDSBr4Yn1dmjT2zUEsvG4ahSPLvUUEQLL2IXfIldHVojebV/BWwXqPs7EWlA==
X-Received: by 2002:a17:90a:6941:b0:1e2:f37a:f889 with SMTP id j1-20020a17090a694100b001e2f37af889mr7256111pjm.160.1654841011573;
        Thu, 09 Jun 2022 23:03:31 -0700 (PDT)
Received: from localhost ([139.177.225.238])
        by smtp.gmail.com with ESMTPSA id iz12-20020a170902ef8c00b00162037fbb68sm17834420plb.215.2022.06.09.23.03.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jun 2022 23:03:31 -0700 (PDT)
Date:   Fri, 10 Jun 2022 14:03:26 +0800
From:   Muchun Song <songmuchun@bytedance.com>
To:     cgel.zte@gmail.com
Cc:     mhocko@kernel.org, roman.gushchin@linux.dev, hannes@cmpxchg.org,
        shakeelb@google.com, akpm@linux-foundation.org,
        cgroups@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Yang Yang <yang.yang29@zte.com.cn>
Subject: Re: [PATCH] mm: memcontrol: reference to
 tools/cgroup/memcg_slabinfo.py
Message-ID: <YqLeriHgZeylhuOZ@FVFYT0MHHV2J.usts.net>
References: <20220610024451.744135-1-yang.yang29@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220610024451.744135-1-yang.yang29@zte.com.cn>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Fri, Jun 10, 2022 at 02:44:52AM +0000, cgel.zte@gmail.com wrote:
> From: Yang Yang <yang.yang29@zte.com.cn>
> 
> There is no slabinfo.py in tools/cgroup, but has memcg_slabinfo.py instead.
> 
> Signed-off-by: Yang Yang <yang.yang29@zte.com.cn>

Reviewed-by: Muchun Song <songmuchun@bytedance.com>

Thanks.
