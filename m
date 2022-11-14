Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FB55628C1F
	for <lists+cgroups@lfdr.de>; Mon, 14 Nov 2022 23:31:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237810AbiKNWbG (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 14 Nov 2022 17:31:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237733AbiKNWat (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 14 Nov 2022 17:30:49 -0500
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF76015FE4;
        Mon, 14 Nov 2022 14:30:47 -0800 (PST)
Received: by mail-pj1-x102c.google.com with SMTP id u8-20020a17090a5e4800b002106dcdd4a0so15191988pji.1;
        Mon, 14 Nov 2022 14:30:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PM4Mnl3gIRS9ItgIzisRcghqDI/wvSaorXokGJD69nY=;
        b=aSx1r9EQXkrLCtfhCbTxziyZEymtjJXWd6nQjhTrIVKG/W012vIcbmbmnefGJV2HVH
         N90bNNs58eIYZPh4zdOinuZJQS/U9iS9RLsX9R9UCh1EqFnaTK+GlxwEu+/eXzQkUidp
         iXTcSi/lL6U1+HZBDX7Ox55eXM44KHjf/Bx4UkFkizcCoDi8Kx5RC9v43hAC+AXPODfj
         XgfWR5sXTmr8nlvBHN/tK8FIx4rvy/M65iInCJo+wY70/+YyqBHN1ZRdkgmkwaKqbGSu
         GyA/DSFiuTrCcfnDOJfZbSXXHfX0njjFDBcFUqrHi6Sa2eS+5v+MTgXxf2ft5kcZcS6R
         1iAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PM4Mnl3gIRS9ItgIzisRcghqDI/wvSaorXokGJD69nY=;
        b=gHflr4vtol3tMMkUGQMCZIwqdIS+hx1m6POO3cMH6zGTNabau9+tQFjv8dk79F5t5M
         hSZK6XucPi6iZRUjj9/M1E1Dlkdiqg9TqTVzjhD7SMi3UfRzlAXJeMTsDufw02vWVSTX
         sN+WPM0AYhgWyHurNjZRF2BfszlEV7xtvZjEFebWb+ABF7R+aZZa1cbwGJlPoX/eWJ9z
         UfewJdfo+stup7CAUS745DWvJFGiJGoLrYJzZSvYhAQoBJFwGBQ8EsTt4wffucAAmFqD
         nCvOUK95+/dvzDvZqtI/+JeqhHIl3w8wcQgxaK8W1LTUoB9RlpFGsivuSY397RFa9xXx
         4c0Q==
X-Gm-Message-State: ANoB5pl6U892NclwQT1UBoeKb2cYfdeYq+TWS7E0Wfru3Id82ZFfqXev
        +iPjDD2cGv1nGCE766DvivbuGhfyHkF2Tw==
X-Google-Smtp-Source: AA0mqf5cxDoQo9he/rK73honEj4UVJCpDmPUVk9c6JJCU+r/b+WQIbdqTekbLLOgG39V4ghHBxakiA==
X-Received: by 2002:a17:90a:28c5:b0:20b:16bc:8493 with SMTP id f63-20020a17090a28c500b0020b16bc8493mr15665014pjd.210.1668465047197;
        Mon, 14 Nov 2022 14:30:47 -0800 (PST)
Received: from localhost (2603-800c-1a02-1bae-a7fa-157f-969a-4cde.res6.spectrum.com. [2603:800c:1a02:1bae:a7fa:157f:969a:4cde])
        by smtp.gmail.com with ESMTPSA id mv6-20020a17090b198600b00212e60c7d9csm10231869pjb.41.2022.11.14.14.30.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Nov 2022 14:30:46 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Mon, 14 Nov 2022 12:30:45 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Kristen Carlson Accardi <kristen@linux.intel.com>
Cc:     jarkko@kernel.org, dave.hansen@linux.kernel.org,
        linux-kernel@vger.kernel.org, linux-sgx@vger.kernel.org,
        cgroups@vger.kernel.org, Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>, zhiquan1.li@intel.com
Subject: Re: [PATCH 19/26] cgroup/misc: Expose parent_misc()
Message-ID: <Y3LBlRAWuJXxDLPE@slm.duckdns.org>
References: <20221111183532.3676646-1-kristen@linux.intel.com>
 <20221111183532.3676646-20-kristen@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221111183532.3676646-20-kristen@linux.intel.com>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Fri, Nov 11, 2022 at 10:35:24AM -0800, Kristen Carlson Accardi wrote:
> To manage the SGX EPC memory via the misc controller, the SGX
> driver will need to be able to iterate over the misc cgroup
> hierarchy. Make parent_misc() available for a future patch
> that will utilize it.

Ditto with naming and maybe it'd be easier to make these simple accessors
inline?

Thanks.

-- 
tejun
