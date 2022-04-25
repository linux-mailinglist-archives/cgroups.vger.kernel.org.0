Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0DD450E744
	for <lists+cgroups@lfdr.de>; Mon, 25 Apr 2022 19:29:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231946AbiDYRcF (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 25 Apr 2022 13:32:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244087AbiDYRb7 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 25 Apr 2022 13:31:59 -0400
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E168DF24;
        Mon, 25 Apr 2022 10:28:20 -0700 (PDT)
Received: by mail-pg1-x530.google.com with SMTP id r83so13979120pgr.2;
        Mon, 25 Apr 2022 10:28:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=5PTbB51BgaGPargq7ZsmCLhWUmXSpuGaWJQBYhiIAqM=;
        b=jfEQSXCifXo8CbMxyMkfZLGgdeAPSaigLwoXp5yW++2rRa9M5CmBL6z6FWKIBm47C3
         yVYrHOs7mVmpSyk81b4oQpjc7OsAX6tFMawE2QyyY4izvbg93Q/0KA1MTtMc9DkFe+73
         7WIVoPtDV8EhN1cmZlcpo3cyPw6p/nxOz+v0jVHqdGYvgbr+14qeU/9/VQQaGeEgiM1N
         riZww7vzL9oSM3ttxkEVOFHU8QL0ZRdko+qQecaPJg1SFgGCG/pJGy5aEdH+wzF/z7oU
         0wEASrUuazY1kNpifl7RJudbG3ZnWraPZx00vMM6Wr8gcCpfmZHqE6+wS+7GtLjJSDeN
         1zCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=5PTbB51BgaGPargq7ZsmCLhWUmXSpuGaWJQBYhiIAqM=;
        b=ksf9nNCtZt7EjlhxPBhNR78fm88Ww74sUzWg8gym7t93lcVGvryQ47NFXGTIMXrJ1c
         +gn2GT8Wnldscrj3NzTnslxRnTLamGGC3fWQb+SncNbIZueV1DAOX6h5o2c+x6H7n00W
         hx3W7yXMG/MozBzUiyoKA74P/Ir3K8Owpfr7rTizMqNQu8yLsls9VMFzLLVBR5EoGIMz
         2/wOnqLV7Ym8ixkHj1p3Fxl5YW4u8K7KOhgLw+yFAjOMphS7+hppsk6EUJ3ZKMPFJ/Gd
         eETo0Gck9nWCztTNz/rqHB/kwCscrmIpgTh9xTAijEGswhPoR+EV3HUo4NT1JNckaR/k
         XVQw==
X-Gm-Message-State: AOAM533aDNrio33sr13AymZyzJjWQcqjPpoogIC/tTsnAzEFgCgk8kVs
        r2PiCnGhXeMwqB1IEc7cF8U=
X-Google-Smtp-Source: ABdhPJzp0OXTdEtbjPMuQKZqoINNjlRE/P//qxv4n6F8aMRhihA4BSMVwKVOJqOz8BZUqWs40cRehw==
X-Received: by 2002:a63:7543:0:b0:39d:2965:de66 with SMTP id f3-20020a637543000000b0039d2965de66mr15694812pgn.269.1650907699932;
        Mon, 25 Apr 2022 10:28:19 -0700 (PDT)
Received: from localhost ([2620:10d:c090:400::5:2e9])
        by smtp.gmail.com with ESMTPSA id p42-20020a056a0026ea00b0050ab776f6a2sm12472186pfw.103.2022.04.25.10.28.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Apr 2022 10:28:19 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Mon, 25 Apr 2022 07:28:17 -1000
From:   Tejun Heo <tj@kernel.org>
To:     David Vernet <void@manifault.com>
Cc:     lizefan.x@bytedance.com, hannes@cmpxchg.org,
        cgroups@vger.kernel.org, peterz@infradead.org, mingo@redhat.com,
        linux-kernel@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH 1/5] cgroup: Adding
 test_cpucg_nested_weight_overprovisioned() testcase
Message-ID: <YmbaMZfBJp3Ngd/6@slm.duckdns.org>
References: <20220423123053.2982931-1-void@manifault.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220423123053.2982931-1-void@manifault.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Sat, Apr 23, 2022 at 05:30:50AM -0700, David Vernet wrote:
> The cgroup cpu controller tests in
> tools/testing/selftests/cgroup/test_cpu.c have some testcases that validate
> the expected behavior of setting cpu.weight on cgroups, and then hogging
> CPUs. What is still missing from the suite is a testcase that validates
> nested cgroups. This patch adds test_cpucg_nested_weight_overprovisioned(),
> which validates that a parent's cpu.weight will override its children if
> they overcommit a host, and properly protect any sibling groups of that
> parent.
> 
> Signed-off-by: David Vernet <void@manifault.com>

Applied 1-5 to cgroup/for-5.19.

Thanks.

-- 
tejun
