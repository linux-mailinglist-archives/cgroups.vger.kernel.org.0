Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6C3E50BF26
	for <lists+cgroups@lfdr.de>; Fri, 22 Apr 2022 20:01:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229450AbiDVSBB (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 22 Apr 2022 14:01:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236621AbiDVR7e (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 22 Apr 2022 13:59:34 -0400
Received: from mail-vs1-xe36.google.com (mail-vs1-xe36.google.com [IPv6:2607:f8b0:4864:20::e36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2274107834;
        Fri, 22 Apr 2022 10:56:40 -0700 (PDT)
Received: by mail-vs1-xe36.google.com with SMTP id t202so8134591vst.8;
        Fri, 22 Apr 2022 10:56:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=XxZBZ3stUkdhVW/utSJpsv4jrMoNhjVNY7NCi5QPbWU=;
        b=EeMR2o3WC1it+xKaAE3UcnjfygI28wLy1fn4KUlwq5rUdHXA3ogqmv0vTwBr0/yoz6
         cDJzg1rfj241iv+2uzC/BYGGmTQnKA/47HSG40F4e3rn8DO/sTGjGLJRZKBNYcdc4SkJ
         VkxKM+/h5DcmnfD6wJ5B5PusUoozoXv2HxITbZos6wYa396jYdGaTuZm1sAUBzw7DwuF
         Vdb4koyAer9x2qkiNcMLqPOqC1r2BHVTFWFhhbVE4d70XYAPKDtci9NNSWGC9H/laxad
         B6pBvpciftuPkCUfsnr9UwtkqOowG6+yMOVvJAiLds17XVWjt2On7Tg7vNK/gpJ5LN5I
         UWqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=XxZBZ3stUkdhVW/utSJpsv4jrMoNhjVNY7NCi5QPbWU=;
        b=aVXQ8yM1rBzkIVZ9Ky8Lnso/IHhpxBsMw5VqZsdJrgiIc8HB0CSc1ioYp8RpA8bRW8
         YCyzf2VElRrwN/ECc1OYr8NmxCjuUlp6TlaZZqjnumf7/OShAJTZkugZpjgr6qhembjC
         YH0t3GbQl6gSjr6t5a9Wm+PMJkmE1UUTpwt8XHQ1wc9DefL2M/cep1T6oLtkGSj08Pt0
         6/JzbSgcNT3jIfz36nn7fLFEmdvXtaRfXt5K8CYebOXETNFOxahNMzi4dcouqvgtzLFq
         Ih7+rYmVv+X5sXQYbdfli8/XBXeTcvHerieVjMXADmiU21B+oeqV2T+rzHewLY+UhQ2L
         xFeA==
X-Gm-Message-State: AOAM532PfPjb0rboW2yAG4cpEZgEX6QiqgBGEAQyUO2OfB++ryq7jKtx
        49QSlG15ygTrqcyqnoMnqvtvtCS/wWA=
X-Google-Smtp-Source: ABdhPJyo1Iq8/URCKrCCXfDfGEQSCogorOh8Sewv54X7ETtbR5vNrqWaSBhLNZmp149jqYMLD9zdlA==
X-Received: by 2002:a05:6a00:2405:b0:4e1:5008:adcc with SMTP id z5-20020a056a00240500b004e15008adccmr6135265pfh.35.1650649719093;
        Fri, 22 Apr 2022 10:48:39 -0700 (PDT)
Received: from localhost ([2620:10d:c090:400::5:b5ae])
        by smtp.gmail.com with ESMTPSA id x71-20020a62864a000000b0050ad2c24a39sm3358336pfd.205.2022.04.22.10.48.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Apr 2022 10:48:38 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Fri, 22 Apr 2022 07:48:36 -1000
From:   Tejun Heo <tj@kernel.org>
To:     David Vernet <void@manifault.com>
Cc:     lizefan.x@bytedance.com, hannes@cmpxchg.org,
        cgroups@vger.kernel.org, peterz@infradead.org, mingo@redhat.com,
        linux-kernel@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH 0/4] cgroup: Introduce cpu controller test suite
Message-ID: <YmLqdIiXdpQqcPTd@slm.duckdns.org>
References: <20220422173349.3394844-1-void@manifault.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220422173349.3394844-1-void@manifault.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hello, David.

On Fri, Apr 22, 2022 at 10:33:47AM -0700, David Vernet wrote:
> This patchset introduces a new test_cpu.c test suite as part of
> tools/testing/selftests/cgroup. test_cpu.c will contain testcases that
> validate the cgroup v2 cpu controller.
> 
> This patchset only contains testcases that validate cpu.stat and
> cpu.weight, but I'm expecting to send further patchsets after this that
> also include testcases that validate other knobs such as cpu.max.
> 
> Note that checkpatch complains about a missing MAINTAINERS file entry for
> [PATCH 1/4], but Roman Gushchin added that entry in a separate patchset:
> https://lore.kernel.org/all/20220415000133.3955987-4-roman.gushchin@linux.dev/.

Looks great to me. Thanks for adding the much needed selftests. Peter, if
you're okay with it, imma route it through the cgroup tree.

Thanks.

-- 
tejun
