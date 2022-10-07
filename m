Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3EBC45F7BB4
	for <lists+cgroups@lfdr.de>; Fri,  7 Oct 2022 18:42:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229997AbiJGQmn (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 7 Oct 2022 12:42:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229959AbiJGQml (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 7 Oct 2022 12:42:41 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B57F62EF2C;
        Fri,  7 Oct 2022 09:42:39 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id y136so5378890pfb.3;
        Fri, 07 Oct 2022 09:42:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fA1J69IyWYywuIZwnnz1658skPrHk8H2Q+rOTxQzfzE=;
        b=k+qp9uDMOFGiGON2UPmJRKZE/BvPXoOPduPRhrl7Ps84MwHynpX37QTHG9NKD7ypxF
         5eagL9mQsDCbbA2dON00lEtk0HuCuiKHGhtO8qjMaxYv7njE6HVIi7Mc8hmwcFFwcydk
         2vkIMR/gyFZ9HFaKBnDYIe2dKhHQGYlRRnf1WHOmyLr4QzrqPw6hS85oHPAGkGmAa6Zr
         iJ8Nw0mDG5ghKocfk6VMQknNsLHDG+z8D7vxjACLuD6xiDMQEAKg74L/81fp3+jquQuL
         Bfr3H6McidxN+yDJ71R8A7WeKpb7p4ECBq+VUlmSUGlLxm4o1lqSJ8DAuRnYz6Eb0zJN
         Bqjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fA1J69IyWYywuIZwnnz1658skPrHk8H2Q+rOTxQzfzE=;
        b=wBay6brpd+H7V1DaVa4FSj7WVNWfnpvenKWjg1H07loc/4YipTp+5dFHJ2JpWg6fDM
         7nS8X4Ga6buUWSShXxo+B3kijgN4jcRn34lWq3jmXbmNorerpmqIh1eBjyQNhCNqKkb4
         qWsqFgOglcxvKH7ZzdKVFXFCwiuHAIMHqyiUZSvXw2GFWOawxE3RmtMi5C3qnbmKJqvv
         YOlSHtDjcfD7GW5WW2XIa0ph7jAW6L9dQsaN/aQiGjf251HX5T2pIjacRBNxhPNnyQQe
         72FP1Imh4FvprdQ9pgvF6g6UfAIhRSCUZdAykxJPRgVq8LOmnEhS1VTmv7Ou/K87nnHm
         vZvQ==
X-Gm-Message-State: ACrzQf2/yWBx+llhLMTCcrv7wEPiy9Fe1JsAwn+h1P4bN/mXePj2mH2g
        l9GR+Lk1HZ3Orohkb6xuSq1/xhuEAa6Hiw==
X-Google-Smtp-Source: AMsMyM7hdNUZHpkRc78ZuIAhBKZ0CXnaOnZhejXYYRTKJJI0hTXMo7fCRPG2Vn4X9HmpK3fMcCu2zQ==
X-Received: by 2002:a65:6a12:0:b0:445:84f6:676a with SMTP id m18-20020a656a12000000b0044584f6676amr5310941pgu.40.1665160958734;
        Fri, 07 Oct 2022 09:42:38 -0700 (PDT)
Received: from localhost (2603-800c-1a02-1bae-a7fa-157f-969a-4cde.res6.spectrum.com. [2603:800c:1a02:1bae:a7fa:157f:969a:4cde])
        by smtp.gmail.com with ESMTPSA id l12-20020a170903244c00b00174fa8cbf31sm1705099pls.303.2022.10.07.09.42.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Oct 2022 09:42:37 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Fri, 7 Oct 2022 06:42:36 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Kristen Carlson Accardi <kristen@linux.intel.com>
Cc:     Dave Hansen <dave.hansen@intel.com>, linux-kernel@vger.kernel.org,
        linux-sgx@vger.kernel.org, cgroups@vger.kernel.org,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Shakeel Butt <shakeelb@google.com>,
        Muchun Song <songmuchun@bytedance.com>
Subject: Re: [RFC PATCH 00/20] Add Cgroup support for SGX EPC memory
Message-ID: <Y0BW/GkfXG99+41O@slm.duckdns.org>
References: <20220922171057.1236139-1-kristen@linux.intel.com>
 <YyyeSVSk/lWdo/W4@slm.duckdns.org>
 <4b8605533e5deade739249bfb341ab9c06d56a1e.camel@linux.intel.com>
 <YyyykUJQtYbPVctn@slm.duckdns.org>
 <7ff6d114-a6cc-e3c5-5edb-8ac0e527d8a9@intel.com>
 <Yy5KwnRTbFjmKE9X@slm.duckdns.org>
 <0f42e11434b264e555559cab626c1828a9eae09f.camel@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0f42e11434b264e555559cab626c1828a9eae09f.camel@linux.intel.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hello, Kristen.

On Fri, Oct 07, 2022 at 09:39:40AM -0700, Kristen Carlson Accardi wrote:
...
> With the misc controller, i haven't been able to find a way to easily
> react to a change in the max value. Am I missing something?

There isn't currently but it should be possible to add per-key notifiers,
right?

Thanks.

-- 
tejun
