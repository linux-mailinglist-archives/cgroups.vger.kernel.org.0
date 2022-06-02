Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 179D053B093
	for <lists+cgroups@lfdr.de>; Thu,  2 Jun 2022 02:34:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232724AbiFBA33 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 1 Jun 2022 20:29:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232734AbiFBA32 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 1 Jun 2022 20:29:28 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D513B29B11E;
        Wed,  1 Jun 2022 17:29:25 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id q18so3158173pln.12;
        Wed, 01 Jun 2022 17:29:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=cd8OZfkfOfbdrVH9nYcg5+3JeiqoxxNBfwL2one6FPI=;
        b=jnHM3OC9fRgEf/1zuyaXHSXBeile/rBcpDVd8BJSs0VVnbhYPwNj+cWPNmgQAmvHeW
         4iGEMcxNC+qiLljZ8z8i9CJvG5r8NHZhqNXaUcIrZ84DpP51x+Ahhebso1nAqKjD/OTn
         b3uitEK1RVAtJ8oXA9Mjm5zS61EZ7uHPRLfDDeqOHSPjRwvoj63mJd51XZRJLAvEmGp3
         QSj1724wDBVcxczmWh5BVAFAZcgYw0QupcnmzOa25Oyrii6AtIl4Dq+nhwGTL0fpfSrs
         xtjKtGmnYxhc18OuN0W283tCI7OwaZS3UwG99PfIVIXxD7PzY/+AGupJgN9a9Ho1ypod
         yPNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=cd8OZfkfOfbdrVH9nYcg5+3JeiqoxxNBfwL2one6FPI=;
        b=HCGiy9wHg4VMyXIcjSNEEG/daYDFH+rQkWbPk7n+9yxV14loctjutMmiFBMnAwhAdG
         LUQxOsgmrxD3u7DDGQuwC1q5V5X62crrhs7x95tEwrTxmc2q9BwVF8tlojEIkAyqI2Pz
         uPDP9JeNJgVtoJ8MmNE3k1rW5b5dLVbidNw59Ns7IEZ17Gy32PbXcrtb0mYgZBPJRUiw
         bWCI5E2ik590wl7CRIvTDTRl85Vc/QNTsFgUR03Ae7yUTNtJeYd3pUiX7iAS2i7DjrPL
         mNCWmVd8vUBINAkE2C6fvKcja06/fpQkRVkFNrvfcddlS2jCdGZ7qWZJKEXSC2Vakb9l
         VqiQ==
X-Gm-Message-State: AOAM530QQLt/4YQ1ajmhC+5UJCsShq9c2CBZUF5InBqHRdD0p91d/JQx
        ik1GPLbJlBXkcjKRNgQw1lndbE/l4HE=
X-Google-Smtp-Source: ABdhPJy/OY5kakAL8795rBrlP1g3AYMMulcl2yXklUI4QG9O+jN5PFfpNUSu+8TwIszfGsFPEAEdAg==
X-Received: by 2002:a17:902:d4c1:b0:162:dd2:407 with SMTP id o1-20020a170902d4c100b001620dd20407mr2036142plg.15.1654129765268;
        Wed, 01 Jun 2022 17:29:25 -0700 (PDT)
Received: from localhost (2603-800c-1a02-1bae-a7fa-157f-969a-4cde.res6.spectrum.com. [2603:800c:1a02:1bae:a7fa:157f:969a:4cde])
        by smtp.gmail.com with ESMTPSA id p8-20020aa78608000000b0051b9d27091bsm2029418pfn.76.2022.06.01.17.29.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jun 2022 17:29:24 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Wed, 1 Jun 2022 14:29:23 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Tadeusz Struk <tadeusz.struk@linaro.org>
Cc:     Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Bui Quang Minh <minhquangbui99@gmail.com>
Subject: Re: [PATCH 2/2] cgroup: Use separate work structs on css release path
Message-ID: <YpgEY/lJbLidLOhc@slm.duckdns.org>
References: <20220525161455.GA16134@blackbody.suse.cz>
 <Yo7KfEOz92kS2z5Y@blackbook>
 <Yo/DtjEU/kYr190u@slm.duckdns.org>
 <0babd7df-bdef-9edc-3682-1144bc0c2d2b@linaro.org>
 <Ypf0VnKUMiuRgZqT@slm.duckdns.org>
 <1fb4d8d7-ccc0-b020-715e-38c2dfd94c23@linaro.org>
 <Ypf5jpI7dSmpi4W0@slm.duckdns.org>
 <c3bd8e63-7204-f86d-8efa-254db71185fc@linaro.org>
 <Ypf/MpwzByOrSp6A@slm.duckdns.org>
 <416dc60a-f0e5-7d05-1613-3cd0ca415768@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <416dc60a-f0e5-7d05-1613-3cd0ca415768@linaro.org>
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

On Wed, Jun 01, 2022 at 05:26:34PM -0700, Tadeusz Struk wrote:
> Ok the problem is that
> 
> 1. kill_css() triggers css_killed_ref_fn(), which enqueues &css->destroy_work on cgroup_destroy_wq
> 2. Last put_css() calls css_release(), which enqueues &css->destroy_work on cgroup_destroy_wq
> 
> We have two instances of the same work struct enqueued on the same WQ (cgroup_destroy_wq),
> which causes "BUG: corrupted list in insert_work"

#2 shouldn't be happening before kill_ref_fn() is done with the css. If what
you're saying is happening, what's broken is the fact that the refcnt is
reaching 0 prematurely.

> So I think the easiest way to solve this would be to have two separate work_structs,
> one for the killed_ref path and css_release path as in:

If you do that, you'd just be racing the free path against the kill path and
the css might get freed while the kill path is still accessing it.

Thanks.

-- 
tejun
