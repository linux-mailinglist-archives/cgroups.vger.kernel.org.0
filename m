Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C70725B0885
	for <lists+cgroups@lfdr.de>; Wed,  7 Sep 2022 17:26:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229676AbiIGP0N (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 7 Sep 2022 11:26:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229695AbiIGP0M (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 7 Sep 2022 11:26:12 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A21F312742;
        Wed,  7 Sep 2022 08:26:11 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id z187so14964433pfb.12;
        Wed, 07 Sep 2022 08:26:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date;
        bh=T6N91VXL3P8JDR20lw0om2klLL1DyAPfzo9iAd40Kjg=;
        b=K8P5YEaVd5+q3A8nyGjz9haRwLkLdQ+3gkZT7IJhCoE9Z+aDbjvnVaJy3IpbnK+4Id
         Tpxl2i7/GxiWvlli2vFfE7Ztdv8G5GRIbcWSFH25XSFKKNEWuyJ6AQ5DguaKT7l/2mSI
         ZDskeA/7IG6yx76IgwlZRdc3SsNYF2GeoboK3BZxyQ0ZhEqj6tjBzrraJI8rORFGu3Ou
         8wOLposlrWgOCaQjVL71crILG+qiz94TwejqdrmGgiZ3Aa4YF6/rlCdLnOr50W0B2NWZ
         fLofVTge7UqV6obw9NLTxpzwdxdrWtMUGXkXGaV7x019QsbiXbGAhPsME/qXNJHoOHbA
         +/Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date;
        bh=T6N91VXL3P8JDR20lw0om2klLL1DyAPfzo9iAd40Kjg=;
        b=tvsdHMlrbTB8zQBtFg/bMCaoNPToDC/9q5BmMhK2wf+LdWfwZp06JjhNUst+09Mqc8
         CVoCkcvXDSMs8DZZVUQNAEUXwpl1HpzYtwepOmxFB9YnQ4/QHfUkCeCN/JWASjNOqY7+
         Ut7qf+uW+VHQDCCZsbEH0P6OsLDkhCq9JdY8lCgl0zngZzrzgGWE1g6swmV+kMZqEX43
         a/luNY13oO6QOBrAAtRIIUkUjacysVbAe4UsJ4YYwcqc2cqThbzhlFzV+eQp5UkD4UUX
         dNchX0PB5r6PANRwCKonGW0gPV+sGS5SaLWiojIuIWwDpJrQ7nE5dSQyGuDl4T0HO3Yy
         hCvA==
X-Gm-Message-State: ACgBeo3+5RNkIvs3XJR17ibruHnqViLnfJNBM74hrgP55KUczydvSgiZ
        fHjlsQj1Wm3BsYzl8r4Yl7g=
X-Google-Smtp-Source: AA6agR4tl43GZYvunN36ftktUwWbipKnbvYHV2gfLiaXyPYbOh83fwEBmn1Apv+RIzqkQnhEqF59fA==
X-Received: by 2002:a65:6d13:0:b0:41d:7380:e9cc with SMTP id bf19-20020a656d13000000b0041d7380e9ccmr3907155pgb.153.1662564370905;
        Wed, 07 Sep 2022 08:26:10 -0700 (PDT)
Received: from localhost (2603-800c-1a02-1bae-a7fa-157f-969a-4cde.res6.spectrum.com. [2603:800c:1a02:1bae:a7fa:157f:969a:4cde])
        by smtp.gmail.com with ESMTPSA id e7-20020a63db07000000b0041a67913d5bsm10797834pgg.71.2022.09.07.08.26.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Sep 2022 08:26:10 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Wed, 7 Sep 2022 05:26:09 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Zhongkun He <hezhongkun.hzk@bytedance.com>
Cc:     lizefan.x@bytedance.com, hannes@cmpxchg.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [Phishing Risk] Re: [Phishing Risk] [External] Re: [PATCH]
 cgroup/cpuset: Add a new isolated mems.policy type.
Message-ID: <Yxi4EYxMaPNkL+of@slm.duckdns.org>
References: <20220902063303.1057-1-hezhongkun.hzk@bytedance.com>
 <YxT/liaotbiOod51@slm.duckdns.org>
 <c05bdeac-b354-0ac7-3233-27f8e5cbb38a@bytedance.com>
 <YxeBGeOaQxvlPLzo@slm.duckdns.org>
 <d323bd95-476b-0901-855e-14c8796d1b23@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d323bd95-476b-0901-855e-14c8796d1b23@bytedance.com>
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

Hello,

On Wed, Sep 07, 2022 at 08:06:30PM +0800, Zhongkun He wrote:
> It would be better if one process had a way to dynamically modify the
> mempolicy of another process. But unfortunately there is no interface or
> system call to do that in userspace.

If you need to change the properties dynamically, I suggest adding this as a
dynamic per-process interface first. That's more generic and useful for more
cases.

Thanks.

-- 
tejun
