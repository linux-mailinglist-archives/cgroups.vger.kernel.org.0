Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86B3758E427
	for <lists+cgroups@lfdr.de>; Wed, 10 Aug 2022 02:39:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229674AbiHJAjQ (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 9 Aug 2022 20:39:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbiHJAjP (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 9 Aug 2022 20:39:15 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B595D78229
        for <cgroups@vger.kernel.org>; Tue,  9 Aug 2022 17:39:13 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id o5-20020a17090a3d4500b001ef76490983so552890pjf.2
        for <cgroups@vger.kernel.org>; Tue, 09 Aug 2022 17:39:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=ocEP/lNDBd9drcOoXjaUPHob3Xt7j2o+0tElmpQe8kw=;
        b=C4FtFqDtCzEkv0O1zcdw15B+2OlUOBYzsJ+8jzPlnxWMk8K0WhIVNgtDISELPpkpJ2
         jYaoqwljoN9EI4J3bO4++EE1on9SLpz5WlGEUR6bgWI5RVwjrtsfPsfDxnsZwKldlCZ2
         MieUGAwNz+kZh2B6o+2nTjimIuZtE15+bOogRefCzNPBJlEUTtwiVpMlVJlUKBBf4AHa
         KKi3C61McekchJ5Hiw39yXSuof3TPXd+s2vikg6WDtxY9aSvjwNpnjTqr1Z5TR0dbv2n
         m2uCOjT7G57wfLV9G9GywDVNSq2r5MUmW8TkCl4E1Wo0y7qldg/xtiT5TyB+//x1IBHM
         QGhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=ocEP/lNDBd9drcOoXjaUPHob3Xt7j2o+0tElmpQe8kw=;
        b=dkR3rDEx0SGoKAzEWGm55ABpLsKQOMUTjyOqXJS7XXyWdyn4V3GjbnqMaiXnitUEF5
         AWKYgxZUeCwvh3Gi2zj9uElC40y9FSoypiQOQN7+qfsvXL4HxNzYbvIvkk3pvh31+Bbm
         FQGjBV1RP+s/DFZ4oCBhmifYIHK1+f4qAoUvRY5UROxHgxiBxxaOyCuqJvNXWoMhyA+E
         cF07e5fVp3eOYDrrSTYkLGIhJGVaoPrd3mMF3K3B7qXhv8yQT2ECjd8kygf1MLgUWuwf
         4pGKL260V3MN8RumXO2TgPw/BGozfJ8WiPVOU2ajLRrj+Uk/BkQ5cnhEyYVQjVsSgmrE
         ngIA==
X-Gm-Message-State: ACgBeo3Tmrk5Qe8fh3Azp0vQqLairwIck/daiTxn2UU5kPpfdlT1Uq/K
        MkR5QkJ4M9OK/Z1dYa8xppi57w==
X-Google-Smtp-Source: AA6agR7zOnjNmt2AgEFDl138AXCOzdM+LOKWjhhdT+FF/dMSwHtv3sBVTmDQdaR24EyQKBLYLAnnAg==
X-Received: by 2002:a17:90b:4a50:b0:1f4:f1b9:d21f with SMTP id lb16-20020a17090b4a5000b001f4f1b9d21fmr981964pjb.185.1660091953281;
        Tue, 09 Aug 2022 17:39:13 -0700 (PDT)
Received: from [10.4.175.112] ([139.177.225.233])
        by smtp.gmail.com with ESMTPSA id z10-20020aa7990a000000b0052e988c1630sm487753pff.138.2022.08.09.17.39.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Aug 2022 17:39:12 -0700 (PDT)
Message-ID: <fcd0bd39-3049-a279-23e6-a6c02b4680a7@bytedance.com>
Date:   Wed, 10 Aug 2022 08:39:05 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.1.0
Subject: Re: [PATCH v2 09/10] sched/psi: per-cgroup PSI stats
 disable/re-enable interface
Content-Language: en-US
To:     Tejun Heo <tj@kernel.org>
Cc:     hannes@cmpxchg.org, corbet@lwn.net, surenb@google.com,
        mingo@redhat.com, peterz@infradead.org, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        cgroups@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, songmuchun@bytedance.com
References: <20220808110341.15799-1-zhouchengming@bytedance.com>
 <20220808110341.15799-10-zhouchengming@bytedance.com>
 <YvKd6dezPM6UxfD/@slm.duckdns.org>
From:   Chengming Zhou <zhouchengming@bytedance.com>
In-Reply-To: <YvKd6dezPM6UxfD/@slm.duckdns.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 2022/8/10 01:48, Tejun Heo wrote:
> Hello,
> 
> On Mon, Aug 08, 2022 at 07:03:40PM +0800, Chengming Zhou wrote:
>> So this patch introduce a per-cgroup PSI stats disable/re-enable
>> interface "cgroup.psi", which is a read-write single value file that
>> allowed values are "0" and "1", the defaults is "1" so per-cgroup
>> PSI stats is enabled by default.
> 
> Given that the knobs are named {cpu|memory|io}.pressure, I wonder whether
> "cgroup.psi" is the best name. Also, it doesn't convey that it's the
> enable/disable knob. I think it needs a better name.

Yes, "cgroup.psi" is not good. What abort "pressure.enable" or "cgroup.psi_enable"?

Thanks.

