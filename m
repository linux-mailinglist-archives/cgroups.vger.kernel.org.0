Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B7545E87C9
	for <lists+cgroups@lfdr.de>; Sat, 24 Sep 2022 04:57:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229447AbiIXC5q (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 23 Sep 2022 22:57:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232228AbiIXC5p (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 23 Sep 2022 22:57:45 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 695C413FB7E;
        Fri, 23 Sep 2022 19:57:45 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id e68so1777047pfe.1;
        Fri, 23 Sep 2022 19:57:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date;
        bh=Yhr2nrFZk+vd4PavOKiv8NZwpQ0tV9+eXmyqSocKfSs=;
        b=eX0Fjows/Ll90CuZs1R+ARoXMetbxE5UzpodleCQWJ9uAJt6W6kBsdzOTTYm0GenQu
         ffWiiLRJYzYv1w3Z3YqEfkNbBcSDQYWnkU/7BfHxp8TCELFADqY0PxMsTcXg/h+YIK+Y
         LkLH5hqNgFMSFNXbUzuJXwBmpdWbJEmY5T1orZmcLQ0jh8Qww3v3N0sjxCOjOrolFbyn
         7mI7538h4siKdt20Dti9nqDHIns/uPNv9rMIOh3/y3Q3aqxFzjtrqwQIimI1GP3Dw5Gt
         2GOxkxN6fsML5iwinYyT7dJgxg+ody/UTlDLIbxUzeZsMeKL4ZlRkeQjGKT+1Qx4ymWb
         tsXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date;
        bh=Yhr2nrFZk+vd4PavOKiv8NZwpQ0tV9+eXmyqSocKfSs=;
        b=Pj8iO4GYvFOa46LIGNJTUx6AyNreSe5EMWqToT2sZ+avIvEbkHGH2KF70bpXkxtGQq
         FH+tPha10PCClgWVs8wMyeMCFnd8b15Ad9rFWOLFWy8TqA6fKPTYiU/cttCO7yllILXL
         XqiDly2x4eemD3cRd/G4AQ/8sUd9qEdAhgSy1Gx9gyAfdR6CsNvhOUu2DYKdpe6oEma+
         Sm+IRVZCeN56F6xvj5Q2er2EUTeWcfCEOjcxdIyA8ZoF6v9JVr1AIiPJ4APi6C5xRA1P
         4KoBf3PG5KCjD6Wnh8ztVWO1iTX3qSrsWXUsIxoK17EgmbnPFTNVYP2hXaH99+8yuD46
         pRpg==
X-Gm-Message-State: ACrzQf1GKvBX7iitKXphUdOGEgbdWvZGGRZLSRjlKRgilO99sMCUrxKB
        tWVrMki3gN7kVAoiNY7xlWc=
X-Google-Smtp-Source: AMsMyM65W6rRZ+fFGVZrB0s0G4oQo2drJqZsuuw1QDb/7Nzaq5ZzNLAqSKKTp16ETOW3ttTV8/iBjg==
X-Received: by 2002:a65:408b:0:b0:42a:55fb:60b0 with SMTP id t11-20020a65408b000000b0042a55fb60b0mr10279607pgp.431.1663988264839;
        Fri, 23 Sep 2022 19:57:44 -0700 (PDT)
Received: from localhost (2603-800c-1a02-1bae-a7fa-157f-969a-4cde.res6.spectrum.com. [2603:800c:1a02:1bae:a7fa:157f:969a:4cde])
        by smtp.gmail.com with ESMTPSA id 79-20020a630652000000b00429b6e6c539sm6252722pgg.61.2022.09.23.19.57.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Sep 2022 19:57:44 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Fri, 23 Sep 2022 16:57:42 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Elijah Conners <business@elijahpepe.com>
Cc:     axboe <axboe@kernel.dk>, linux-block <linux-block@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        cgroups <cgroups@vger.kernel.org>, josef <josef@toxicpanda.com>,
        asmlsilence <asml.silence@gmail.com>,
        minglei <ming.lei@redhat.com>, bvanassche <bvanassche@acm.org>
Subject: Re: [PATCH] iocost_monitor: reorder BlkgIterator
Message-ID: <Yy5yJsSbrcqkQzth@slm.duckdns.org>
References: <182ef30785e.c6f6f47035469.3423320276766255135@elijahpepe.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <182ef30785e.c6f6f47035469.3423320276766255135@elijahpepe.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue, Aug 30, 2022 at 07:38:27AM -0700, Elijah Conners wrote:
> In order to comply with PEP 8, the first parameter of a class should be
> __init__.
> 
> Signed-off-by: Elijah Conners <business@elijahpepe.com> 

Applied to cgroup/for-6.1.

Thanks.

-- 
tejun
