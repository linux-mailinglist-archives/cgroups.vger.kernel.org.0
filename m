Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33E2E6BF4E1
	for <lists+cgroups@lfdr.de>; Fri, 17 Mar 2023 23:08:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229958AbjCQWI1 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 17 Mar 2023 18:08:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229602AbjCQWI0 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 17 Mar 2023 18:08:26 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B58B632535;
        Fri, 17 Mar 2023 15:08:25 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id h8so6732486plf.10;
        Fri, 17 Mar 2023 15:08:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679090905;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fktUgeNKHeEQ2v/T0Wiw60L+0FDNv0kxizcb8obLG8Y=;
        b=IDX20rndKJ/Uot2engpvKciEKywc2wk8AMwLKStBF/6eWM6GHrrs8U6/QnbXnzelbx
         wZLaNbY5SoxasFx5NbRja1hPTBWBhoXXKwYOdvApjN7QFhIMRAdgz3Z3/W3rn82qckTu
         pyxnBRSi9sF/dagYAgxiBbhdafEVBXTcHbxp50Jr5rAe2y+zug697tFeposkyQjLVenZ
         EJxK16UryRJELe/QqPprPtZHW81+52OmQbKHjmdik6h0ZLaJzk+kqK39k7y6R36pue3Z
         JGcryL4Zu8A9yh0mEv1um1VL29cD+wcoIJdeNQteIVhjAiFj4HaMOC3aNKhv18Qc2V81
         Rc2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679090905;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fktUgeNKHeEQ2v/T0Wiw60L+0FDNv0kxizcb8obLG8Y=;
        b=obeLAnjI7WoAPnDxoG1CEOLRHDjxd/lOuPH5FJS9aDA9+RHRebFjRcYz+xo7ZCeGqK
         Dmq8cdSeU53jlllZ1n7DbV/E98iRBkoxya2AwTL6lPWaqsJnZDijzzxsjOV6DrG+Yio4
         6V6T5SDN7dmIq2XGnyGF8uGgIt7foP3Y7gwd34dM2kPGsHSmNMJit6B+a+9QOf/iPTsc
         G/g6iiozKIPIheWu3E579H//Qb2mN6CPDLSGiZi1v/hMiOcf9D9tPAksJxl7dXAFFGh8
         mHtyc+RGkoTAD/W+bTAfXRyTTZOgpTB7qGwEX3elsFj/wGPjgfviMked6DbSJI99eSSW
         RFXA==
X-Gm-Message-State: AO0yUKX24lrYrSL44PXP6qdQAAyEuc7ykmiL8hW3NLEP0X91k2Jk1nYh
        A7nFA2oJzEVfy/Vte1KwkFA=
X-Google-Smtp-Source: AK7set+BLQ3LqTsURK64gj4GKMB71NsladoXXAi5ZySIyttRc4fpgdesLRLDZg5NELQgMQmP9PMjMw==
X-Received: by 2002:a17:902:d50f:b0:19c:eaab:653d with SMTP id b15-20020a170902d50f00b0019ceaab653dmr5118710plg.15.1679090905009;
        Fri, 17 Mar 2023 15:08:25 -0700 (PDT)
Received: from localhost (2603-800c-1a02-1bae-a7fa-157f-969a-4cde.res6.spectrum.com. [2603:800c:1a02:1bae:a7fa:157f:969a:4cde])
        by smtp.gmail.com with ESMTPSA id jo6-20020a170903054600b0019bd934434esm2010731plb.53.2023.03.17.15.08.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Mar 2023 15:08:24 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Fri, 17 Mar 2023 12:08:23 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Kamalesh Babulal <kamalesh.babulal@oracle.com>
Cc:     Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Christian Brauner <brauner@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Tom Hromatka <tom.hromatka@oracle.com>,
        cgroups@vger.kernel.org, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cgroup: bpf: use cgroup_lock()/cgroup_unlock() wrappers
Message-ID: <ZBTk15bE2CH8L8bD@slm.duckdns.org>
References: <20230303095310.238553-1-kamalesh.babulal@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230303095310.238553-1-kamalesh.babulal@oracle.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Fri, Mar 03, 2023 at 03:23:10PM +0530, Kamalesh Babulal wrote:
> Replace mutex_[un]lock() with cgroup_[un]lock() wrappers to stay
> consistent across cgroup core and other subsystem code, while
> operating on the cgroup_mutex.
> 
> Signed-off-by: Kamalesh Babulal <kamalesh.babulal@oracle.com>

Applied to cgroup/for-6.4.

Thanks.

-- 
tejun
