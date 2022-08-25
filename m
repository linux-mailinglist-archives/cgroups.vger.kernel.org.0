Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 453D15A17D5
	for <lists+cgroups@lfdr.de>; Thu, 25 Aug 2022 19:17:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240244AbiHYRRm (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 25 Aug 2022 13:17:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238408AbiHYRRl (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 25 Aug 2022 13:17:41 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 263B5BC12A
        for <cgroups@vger.kernel.org>; Thu, 25 Aug 2022 10:17:38 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id z2so26990706edc.1
        for <cgroups@vger.kernel.org>; Thu, 25 Aug 2022 10:17:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc;
        bh=jwOz4iT2BQeb7Z52GoBXCVE165vQ/PaiB7E4MX3VOzg=;
        b=2g15XhRTJVHl3pGrBt7KYB9tODJZNPuo0RKK7aO0xcfwNYoiDa5gNnl9QhBZgRTZH1
         wzpGaPDTqYX9h4jpDuvgylUNoOT5Lch3EvX7BL7CkVbuyhm4hktsWJUFfLe8tib4v0Gq
         7Mjh3VgV21lcVMlZx06acL/VUPi6ODi2kr4hsmTpzEfwuJdhGtRa+uoNv7nXEudFJyIa
         iA890Pl9xzrBCOFHHrzOlOLMm3xlPiAqK2MFwaQKkmjwrpdkyiGN38v19lF6PONeoSXg
         guMjW7r9YLJwuo6i6gLS8hBFDFsrS2G7IU8PFhcG5seKK+gz7LlbLeq6E7UcbagEEWsK
         LpUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=jwOz4iT2BQeb7Z52GoBXCVE165vQ/PaiB7E4MX3VOzg=;
        b=Kc6YSlFAiBcxtHp6N1XfVmA3+3CpSABfpLs0Zmi5EsJMYmxcTBhjDrYi5KrJ0gd24d
         0hKW4ChqVsGt82N+FUcflZJ02c2h+STIGNOagm8XOLyl5ozqmYTmWCejzLBXxGSjmhos
         o9NsF1yAOtoknxIjOQAAvra5XoRHoUMNv3DazO6PiuXjG6poXf9My2Gz8St8tq+c2lO+
         DiABgSlC6Al8Grb0nD327U1T7i6KF7P7xUkuITrky3S1n8+2Xxeld7ZUSI+UMIq5+1se
         eaQYPO28Mcmva3gj9FJe3GhfNq3KjBNuA10Zmu9UPdEPGm+iGfJSNcaFpIhFL1ukozTU
         2qwg==
X-Gm-Message-State: ACgBeo1DmICRAVyxtH7V1K8UWN3zhjKZgGqi1UFgvBvDpJrH9JkhJu6h
        s61j8lOCXV4qjPKAqh8iw1J/PA==
X-Google-Smtp-Source: AA6agR5P/9xkfx1YPi51kqhMj3rOmY2Bq5S6/Ff26hkK5BgmClbpFYwX6S711CBeYPyYjb/pWEL+Jg==
X-Received: by 2002:aa7:c316:0:b0:447:b517:919e with SMTP id l22-20020aa7c316000000b00447b517919emr3251864edq.175.1661447856379;
        Thu, 25 Aug 2022 10:17:36 -0700 (PDT)
Received: from localhost ([2a02:8070:6389:a4c0:2ca9:6d59:782b:fff3])
        by smtp.gmail.com with ESMTPSA id h3-20020a056402094300b00445e037345csm22904edz.14.2022.08.25.10.17.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Aug 2022 10:17:36 -0700 (PDT)
Date:   Thu, 25 Aug 2022 13:17:35 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Chengming Zhou <zhouchengming@bytedance.com>
Cc:     tj@kernel.org, mkoutny@suse.com, surenb@google.com,
        mingo@redhat.com, peterz@infradead.org, gregkh@linuxfoundation.org,
        corbet@lwn.net, cgroups@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, songmuchun@bytedance.com
Subject: Re: [PATCH v4 07/10] sched/psi: add PSI_IRQ to track IRQ/SOFTIRQ
 pressure
Message-ID: <Yweur4ugxvLbP2L2@cmpxchg.org>
References: <20220825164111.29534-1-zhouchengming@bytedance.com>
 <20220825164111.29534-8-zhouchengming@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220825164111.29534-8-zhouchengming@bytedance.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Fri, Aug 26, 2022 at 12:41:08AM +0800, Chengming Zhou wrote:
> Now PSI already tracked workload pressure stall information for
> CPU, memory and IO. Apart from these, IRQ/SOFTIRQ could have
> obvious impact on some workload productivity, such as web service
> workload.
> 
> When CONFIG_IRQ_TIME_ACCOUNTING, we can get IRQ/SOFTIRQ delta time
> from update_rq_clock_task(), in which we can record that delta
> to CPU curr task's cgroups as PSI_IRQ_FULL status.
> 
> Note we don't use PSI_IRQ_SOME since IRQ/SOFTIRQ always happen in
> the current task on the CPU, make nothing productive could run
> even if it were runnable, so we only use PSI_IRQ_FULL.
> 
> Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>

Acked-by: Johannes Weiner <hannes@cmpxchg.org>
