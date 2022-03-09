Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B0A44D387A
	for <lists+cgroups@lfdr.de>; Wed,  9 Mar 2022 19:10:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232708AbiCISLb (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 9 Mar 2022 13:11:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229596AbiCISLb (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 9 Mar 2022 13:11:31 -0500
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 245AE40E42;
        Wed,  9 Mar 2022 10:10:32 -0800 (PST)
Received: by mail-pl1-x630.google.com with SMTP id 9so2662348pll.6;
        Wed, 09 Mar 2022 10:10:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=gwB5ul7ug54L0VuMLgVdXhYXbW5z5+vlezaYRrDt3pk=;
        b=Smg69TaCEAFM4UcbwfjW0Sb6bBoNfiS3bSVBjeqfS1HLAUTS3+ZD9/kstjcPZT8jf+
         ZioEdEM9xhJe2i864YcvhkeqUmhixiqi17hg8awoiQv3+8GzIj/SqZR6beNw+7vdv76O
         UaToexqeCfRPh9+BzsOV5QGOXc/TXlN/bU9FJwH56V4zCpNmI7iuUH9+pqLA/UFy1zsm
         Hv9Ng+D4k/8Sf1gNC5WsxDWOj8FGbr6ad+LoxvumyjVE+6poyRSC7Hurq52udeFAQuP+
         oPWVKX9XM1mSnRnDmKfy+16Ja8HL17kw4cw7A7UlTMaCQuXAKHg98L4uQhZUrt8oOjcT
         hJSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=gwB5ul7ug54L0VuMLgVdXhYXbW5z5+vlezaYRrDt3pk=;
        b=4mSroIESDE0vv4lYV7HpL/WgaiOWt4yFTxwJPuwlYiP8ioTJUxPgMM29ues8ZZWoYt
         iS2IusCyP2fk03Pkm8ZAILYyX+VYeLlENifdjjP4rp2zXVeO5ol22DnuYVy1gR802biu
         ehHfmQGqOvGQI5UDY25cD3O8oK/GpQvkXAWuAZI9P2lE+5QZj58BLhmkWzYuADbiI2sd
         GEXyv1h2wAnJaWcM6GwB2yxwym9Fxhh2ZhXSsuwioc4DTpKG/r53grnUWXwyt3C/TLl3
         Djz6rKmCGERHA4fTXVLEco0ewpxcqXciw7krTt91DNai6naH5Pa89wuyy8s4btlpt4jf
         5olg==
X-Gm-Message-State: AOAM530pP7jL9+Je9++fJs9iLj1XwsjOgyDl1/ypK8kZFkvLNVumgvmc
        DiC4HHiTYuoK2AFTzTqDdxw=
X-Google-Smtp-Source: ABdhPJx07Q/0H+LE4IMZJub5t+Njk4j2aFEG5ihccN0LDsgTelrHKJZw5op8nDLZ4b7cytOcs0tc2w==
X-Received: by 2002:a17:902:ea12:b0:151:dbbd:aeb8 with SMTP id s18-20020a170902ea1200b00151dbbdaeb8mr643100plg.157.1646849431498;
        Wed, 09 Mar 2022 10:10:31 -0800 (PST)
Received: from localhost (2603-800c-1a02-1bae-e24f-43ff-fee6-449f.res6.spectrum.com. [2603:800c:1a02:1bae:e24f:43ff:fee6:449f])
        by smtp.gmail.com with ESMTPSA id j9-20020a056a00130900b004f73df40914sm3846878pfu.82.2022.03.09.10.10.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Mar 2022 10:10:31 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Wed, 9 Mar 2022 08:10:29 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Chengming Zhou <zhouchengming@bytedance.com>
Cc:     lizefan.x@bytedance.com, hannes@cmpxchg.org, peterz@infradead.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        songmuchun@bytedance.com,
        Linux Kernel Functional Testing <lkft@linaro.org>,
        syzbot+16e3f2c77e7c5a0113f9@syzkaller.appspotmail.com,
        Zhouyi Zhou <zhouzhouyi@gmail.com>
Subject: Re: [PATCH linux-next] cgroup: fix suspicious
 rcu_dereference_check() usage warning
Message-ID: <YijtlXG1L0cS/3EL@slm.duckdns.org>
References: <20220305034103.57123-1-zhouchengming@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220305034103.57123-1-zhouchengming@bytedance.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Sat, Mar 05, 2022 at 11:41:03AM +0800, Chengming Zhou wrote:
> task_css_set_check() will use rcu_dereference_check() to check for
> rcu_read_lock_held() on the read-side, which is not true after commit
> dc6e0818bc9a ("sched/cpuacct: Optimize away RCU read lock"). This
> commit drop explicit rcu_read_lock(), change to RCU-sched read-side
> critical section. So fix the RCU warning by adding check for
> rcu_read_lock_sched_held().
> 
> Fixes: dc6e0818bc9a ("sched/cpuacct: Optimize away RCU read lock")
> Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
> Reported-by: syzbot+16e3f2c77e7c5a0113f9@syzkaller.appspotmail.com
> Tested-by: Zhouyi Zhou <zhouzhouyi@gmail.com>
> Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
> ---
>  include/linux/cgroup.h | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/include/linux/cgroup.h b/include/linux/cgroup.h
> index 1e356c222756..0d1ada8968d7 100644
> --- a/include/linux/cgroup.h
> +++ b/include/linux/cgroup.h
> @@ -450,6 +450,7 @@ extern struct mutex cgroup_mutex;
>  extern spinlock_t css_set_lock;
>  #define task_css_set_check(task, __c)					\
>  	rcu_dereference_check((task)->cgroups,				\
> +		rcu_read_lock_sched_held() ||				\
>  		lockdep_is_held(&cgroup_mutex) ||			\
>  		lockdep_is_held(&css_set_lock) ||			\
>  		((task)->flags & PF_EXITING) || (__c))

Acked-by: Tejun Heo <tj@kernel.org>

Thanks.

-- 
tejun
