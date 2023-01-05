Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB7D965F3B7
	for <lists+cgroups@lfdr.de>; Thu,  5 Jan 2023 19:33:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234891AbjAESdN (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 5 Jan 2023 13:33:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234934AbjAEScw (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 5 Jan 2023 13:32:52 -0500
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 395B7564CE;
        Thu,  5 Jan 2023 10:32:52 -0800 (PST)
Received: by mail-pf1-x42a.google.com with SMTP id 124so25988311pfy.0;
        Thu, 05 Jan 2023 10:32:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3EeGNF5xHs7sa7n7ZiCZflKuJGwYRLGHpWxAaRy01+4=;
        b=kUNN2cTNsj/b/55vlzGN+y0U6V9ZyiXDdNzPzxqqj9oo7Roqr6UEJ9qqTk4+6j9f6J
         61L1iPQS88OfzaJZVuayJzm9pl15tC+jOmAMCU6JQ9HkKFBgNhmiUUk0uAShnufjANDU
         h2oM3xF4cdvftyhjsNPxRRhbXwTgx2vG0CXsHgbL4vV0H1PdHs9WbBba1QEa2HgxZb+L
         MhkW5xMVcx/d2Nd0jBJO7HWSNJrMEoRw2RurqciPBx+C5S58cfqdp5vONRlraL165Wnz
         kerx6YfAoBdwHqJwzwtaqmeUfK8oupeAI/vT400AbrbpGSWyOqpGhTZUbbl5BxEhYV51
         NlXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3EeGNF5xHs7sa7n7ZiCZflKuJGwYRLGHpWxAaRy01+4=;
        b=beOcg/EGpprM7B4BSxfbTnGSwEzckk19Bq6Lb56m510rWmHFhxxqOHhUHIwdm7npp9
         6NXb5TD8vf6o24i+/OlsIvpkYFHpPcpazILcSjCp/KGQREDY1tpqopxgEmzknBb4ydzU
         ipBShUx4wvjYKyDXrGZ9kmNZgE1oa9h+uTtxO+jaWktwJmYsmo/vyY/cb9SsfQcqi+hh
         f0xnTSDe6uzZ1O5i2qE41KORVBbPYm6J08ucOv8Qb9VAJFaS6STAgk8eBPDQmGiu5qct
         JeQF6OmVZfAOw/tzyTFfbtxB7E5+BFBtkH6egRQRPI3nrb5gFx8PVTQGW27EpUoDmCt3
         qE+w==
X-Gm-Message-State: AFqh2kqiXbUNs2BAS0TUS40uS72LumqQtOxwOHqUjFeSvQ9luZEV1a6I
        LDasKUqasbg1OuWf4CEntjw=
X-Google-Smtp-Source: AMrXdXvpY+Q3vWOoS5G6f7NeF7ydpL/GRO+5dXR0bQpac8gQ8f78efxbU5ssTcyu6aGKcUzm1HnNEQ==
X-Received: by 2002:a05:6a00:26e8:b0:583:3d0a:4c34 with SMTP id p40-20020a056a0026e800b005833d0a4c34mr624379pfw.4.1672943571536;
        Thu, 05 Jan 2023 10:32:51 -0800 (PST)
Received: from localhost (2603-800c-1a02-1bae-a7fa-157f-969a-4cde.res6.spectrum.com. [2603:800c:1a02:1bae:a7fa:157f:969a:4cde])
        by smtp.gmail.com with ESMTPSA id n184-20020a6227c1000000b005832c23f33fsm1642897pfn.15.2023.01.05.10.32.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Jan 2023 10:32:51 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Thu, 5 Jan 2023 08:32:49 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Yu Kuai <yukuai1@huaweicloud.com>
Cc:     hch@infradead.org, josef@toxicpanda.com, axboe@kernel.dk,
        cgroups@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, yi.zhang@huawei.com,
        "yukuai (C)" <yukuai3@huawei.com>
Subject: Re: [PATCH v2 1/2] blk-iocost: add refcounting for iocg
Message-ID: <Y7cX0SJ0y6+EIY5Q@slm.duckdns.org>
References: <20221227125502.541931-1-yukuai1@huaweicloud.com>
 <20221227125502.541931-2-yukuai1@huaweicloud.com>
 <Y7XzUee5Bq+DoIC1@slm.duckdns.org>
 <c63ee2ad-23d5-3be0-c731-28494398b391@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c63ee2ad-23d5-3be0-c731-28494398b391@huaweicloud.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Thu, Jan 05, 2023 at 09:14:07AM +0800, Yu Kuai wrote:
> 1) is related to blkg, while 2) is not, hence refcnting from blkg can't
> fix the problem. refcnting from blkcg_policy_data should be ok, but I
> see that bfq already has the similar refcnting, while other policy
> doesn't require such refcnting.

Hmm... taking a step back, wouldn't this be solved by moving the first part
of ioc_pd_free() to pd_offline_fn()? The ordering is strictly defined there,
right?

Thanks.

--
tejun
