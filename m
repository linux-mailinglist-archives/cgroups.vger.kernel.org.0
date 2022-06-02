Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 715A953B09A
	for <lists+cgroups@lfdr.de>; Thu,  2 Jun 2022 02:34:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232662AbiFBAHT (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 1 Jun 2022 20:07:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232655AbiFBAHS (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 1 Jun 2022 20:07:18 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4329813D09;
        Wed,  1 Jun 2022 17:07:17 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id 137so3300720pgb.5;
        Wed, 01 Jun 2022 17:07:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ae4Em02O4DoW8HqZVWLGSrl5wgz4cCAQSui5vC+qx38=;
        b=SWcH+oItm/XxdIwRq5d7dWi4k8EsrLve4tmhF9StwgkVAeB/ST+4WCb9E2NxUXGT7g
         q8GzCidpe0aYC1tY7l8ZUuV3j01269AWUz6gdiLCMvRT1p3tEmlx+qW0snAnBV5OPGvM
         DXLvnYtjOFtN4WUjBBpXkIykso8QRjUpr72FdUS3296sgzRusW3cir5K4s1OLzUYhfRF
         Pou3Y74c4/+dj9zMDvz0Zgiu/uUCvVLNWgOZqow7iX/ggarDUwyyXCSl/j1RSV5uOUC2
         +1gBSrqQvr/7wPpt4i7OoAuLFKu0wYhBLeQV3POlB/VGAWkw5GU4UB8qeT7IAzJsl6Dq
         tB4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=ae4Em02O4DoW8HqZVWLGSrl5wgz4cCAQSui5vC+qx38=;
        b=g30VzT9eW/lgNgJo4jMIBEr2bX5RLrj3soHu8qOae5Agof0UV1MawfygWBORVI5V0m
         cNeAkJvkECgNKKwlbrXErmiSOC3me5v4ukUNuw3P80+PRoC8Dhmw6kDanXMK4BCyXDDR
         /qcPzDtciLX1aQhZ/NaGWplJ+A2+/8Sm7Omm2R6G5vlYzrijaYWLAhzdM1PPdDx4AlLd
         L1nWU11C5Uu+FBMDCd5y4V854a8D4VpUmKc/ZPUY9do617AEoG1v3GP+YM7ImZDTKwV6
         Nuc1ftKvFF8FWPxomnl+1KQDnYHAcdWKfubdsf98pco/oP5lrJ02WFvZJAR0oRpDwVgT
         Sgfw==
X-Gm-Message-State: AOAM5336QkfjBSl1ukf6G5uzy1ryJcybMBQK88bGcFXTNiGFmhutijcm
        CAdYicc0YxyVixd7JJDcYWw=
X-Google-Smtp-Source: ABdhPJy6xOMPf8p15M2/rSKs6exS5LeZpHnKE5FuTj2qQPclZBdSDUnbDo0tHLslH2+TgTf3r3JBWw==
X-Received: by 2002:a65:6c12:0:b0:3db:8148:308b with SMTP id y18-20020a656c12000000b003db8148308bmr1705470pgu.103.1654128436664;
        Wed, 01 Jun 2022 17:07:16 -0700 (PDT)
Received: from localhost (2603-800c-1a02-1bae-a7fa-157f-969a-4cde.res6.spectrum.com. [2603:800c:1a02:1bae:a7fa:157f:969a:4cde])
        by smtp.gmail.com with ESMTPSA id u2-20020a17090add4200b001cd8e9ea22asm4339602pjv.52.2022.06.01.17.07.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jun 2022 17:07:15 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Wed, 1 Jun 2022 14:07:14 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Tadeusz Struk <tadeusz.struk@linaro.org>
Cc:     Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Bui Quang Minh <minhquangbui99@gmail.com>
Subject: Re: [PATCH 2/2] cgroup: Use separate work structs on css release path
Message-ID: <Ypf/MpwzByOrSp6A@slm.duckdns.org>
References: <20220525151517.8430-1-mkoutny@suse.com>
 <20220525151517.8430-3-mkoutny@suse.com>
 <20220525161455.GA16134@blackbody.suse.cz>
 <Yo7KfEOz92kS2z5Y@blackbook>
 <Yo/DtjEU/kYr190u@slm.duckdns.org>
 <0babd7df-bdef-9edc-3682-1144bc0c2d2b@linaro.org>
 <Ypf0VnKUMiuRgZqT@slm.duckdns.org>
 <1fb4d8d7-ccc0-b020-715e-38c2dfd94c23@linaro.org>
 <Ypf5jpI7dSmpi4W0@slm.duckdns.org>
 <c3bd8e63-7204-f86d-8efa-254db71185fc@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c3bd8e63-7204-f86d-8efa-254db71185fc@linaro.org>
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

On Wed, Jun 01, 2022 at 05:00:44PM -0700, Tadeusz Struk wrote:
> What I'm trying to say is that it's not really a ref imbalance problem.
> I think once the kill_css() has been called on a css, and it is enqueued to be
> killed, we shouldn't call css_put(css) on it anymore outside of the "killed call
> flow path". It will all be handled by the css_killed_ref_fn() function.
> 
> The fact the css_release() is called (via cgroup_kn_unlock()) just after
> kill_css() causes the css->destroy_work to be enqueued twice on the same WQ
> (cgroup_destroy_wq), just with different function. This results in the
> BUG: corrupted list in insert_work issue.

I have a hard time following here. The kill / release paths relationship
isn't that complicated. The kill path is invoked when the percpu_ref's base
ref is killed and holds an extra ref so that it's guaranteed that release
can't happen before the kill path is done with the css. When the final put
happens - whether that's from the kill path or someone else, which often is
the case - the release path triggers. If we have release getting scheduled
while the kill path isn't finished, it is a reference counting problem,
right?

Can you elaborate the exact scenario that you think is happening? Please
feel free to omit the function calls and all that. Just lay out who's doing
what.

Thanks.

-- 
tejun
