Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE0125974A4
	for <lists+cgroups@lfdr.de>; Wed, 17 Aug 2022 18:59:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240280AbiHQQ7V (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 17 Aug 2022 12:59:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236230AbiHQQ7U (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 17 Aug 2022 12:59:20 -0400
Received: from mail-qv1-xf32.google.com (mail-qv1-xf32.google.com [IPv6:2607:f8b0:4864:20::f32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF1B66B15D
        for <cgroups@vger.kernel.org>; Wed, 17 Aug 2022 09:59:16 -0700 (PDT)
Received: by mail-qv1-xf32.google.com with SMTP id mn10so5749880qvb.10
        for <cgroups@vger.kernel.org>; Wed, 17 Aug 2022 09:59:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc;
        bh=WgHvQWKtUk86nWWmj+kI8ABwb1icz9Fb44Hg1eLDOm8=;
        b=i0SAuQsKmPP0r4pTH16fQeqknam9+o/10fqWW30EL4nCBPXL779fGqyA8NRZNGCTkZ
         WfbnW65WxsqXerYMpkxbiMhm6XM1PI7FxXfeHc4CY06X9K05ptCeoq/IT9/HbNvnea/U
         v5DxsDBjBV5PtsP+Fj+JzUD05XdGBIpOR2Ai+7D+4T+FI+HBBg78Cmu+3KdjMkSykY6N
         3N5FrmiyjnyIbIYn1HBXF8fsk+LuKKXzs+QQCF8s3M9lcUunC/Sdr/XEW62NpNZrdVjh
         mZnWqSfao6avLdINn+/BdQyb/Fn0cRjbRaM67aNVItl7KpD9+4JbAnyEH/EikgTYz7zg
         C1MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=WgHvQWKtUk86nWWmj+kI8ABwb1icz9Fb44Hg1eLDOm8=;
        b=mEt10UyMxalo2B4tUfebJfdUmez6BtTE+6YJgIPZIOHRxkdN+/n1YFG//G3kElyTLy
         6KNxfFbJ4uMaMDUUmjMPKWc0oZIsRS/7uEVUa9gV2Xnej3EjrHwwlf7l1VG56eW2HtXX
         03NsA3jLMHdtkjlu847OF6D1+76Mi6l27z31Lg3HlHOGeVAeRS+0Dv1rI0VekE1hOUlq
         /aLEMcEzwxa+fjBWy4GVVNk0RyYUK7Lb8sE6XQmGaUMqhLEbdLEPirsuibfSrAT74/AH
         mI4/iraZ4OwuD6iDh5TGe91A+c6XmSQ+uCwIH87eS35jNaHawfsSV6W9uTJOKv1OTifW
         pCLw==
X-Gm-Message-State: ACgBeo3EfoHLCrgzX/VngkILYCGxDoaSsZEMggXxgg6l3fEGLrIuFTGH
        a126sb7hxb/Ti/i00ncjbyOjkw==
X-Google-Smtp-Source: AA6agR5ppGaJIEQkG/QhAlbMnaSVK+J/k6DhTeFskAdFZGiYlFMexNJza36kKzQFKqv5WlGrmiznhQ==
X-Received: by 2002:a05:6214:4017:b0:476:6229:bbf8 with SMTP id kd23-20020a056214401700b004766229bbf8mr22888239qvb.14.1660755556120;
        Wed, 17 Aug 2022 09:59:16 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::39e8])
        by smtp.gmail.com with ESMTPSA id c9-20020ac85a89000000b0033aac3da27dsm13876189qtc.19.2022.08.17.09.59.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Aug 2022 09:59:15 -0700 (PDT)
Date:   Wed, 17 Aug 2022 12:59:14 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Michal Hocko <mhocko@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Shakeel Butt <shakeelb@google.com>,
        Muchun Song <songmuchun@bytedance.com>,
        cgroups@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH 6/9] mm/memcontrol: Replace the PREEMPT_RT conditionals
Message-ID: <Yv0eYncQsOUpDZTn@cmpxchg.org>
References: <20220817162703.728679-1-bigeasy@linutronix.de>
 <20220817162703.728679-7-bigeasy@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220817162703.728679-7-bigeasy@linutronix.de>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed, Aug 17, 2022 at 06:27:00PM +0200, Sebastian Andrzej Siewior wrote:
> From: Thomas Gleixner <tglx@linutronix.de>
> 
> Use VM_WARN_ON_IRQS_ENABLED() and preempt_disable/enable_nested() to
> replace the CONFIG_PREEMPT_RT #ifdeffery.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> Cc: Johannes Weiner <hannes@cmpxchg.org>
> Cc: Michal Hocko <mhocko@kernel.org>
> Cc: Roman Gushchin <roman.gushchin@linux.dev>
> Cc: Shakeel Butt <shakeelb@google.com>
> Cc: Muchun Song <songmuchun@bytedance.com>
> Cc: cgroups@vger.kernel.org
> Cc: linux-mm@kvack.org
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

Acked-by: Johannes Weiner <hannes@cmpxchg.org>
