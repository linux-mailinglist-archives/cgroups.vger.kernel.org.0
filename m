Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 130B14AE16D
	for <lists+cgroups@lfdr.de>; Tue,  8 Feb 2022 19:49:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1385524AbiBHStT (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 8 Feb 2022 13:49:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1385487AbiBHStN (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 8 Feb 2022 13:49:13 -0500
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3652AC0612B8;
        Tue,  8 Feb 2022 10:49:13 -0800 (PST)
Received: by mail-pl1-x631.google.com with SMTP id 10so147054plj.1;
        Tue, 08 Feb 2022 10:49:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=HzqJzWy6/gVejSAN5h5m+QbHqL8I+Ih3BBbS9yeEwMQ=;
        b=N4MKN8A1dy9x/0fQ3O5ZkWlr8CY4zUnafoD5iZJ2GzR2vHrPtZ9c3Augj8QVTK/AOB
         6/Q0T9TxM0VSWHm37lP2a4E0TiBrzrW1EhYPumJszYBdF7eUpgZwahZdkzXGgG8+uijN
         EmyFn0npWdJy1OTjwf8aZ/+9k7emBiOHVNUqPcClPbMfn2VqEkoBj+u0tEthGor79MHU
         Q+YzcmqT/YYt5W56qTcPGLmXCR1cUCzJMQ48WnZQUTxPcgO02slV04kbISsKtoFvVS58
         LCwvTK7xcTi0/LT7PubbSs8+5waC1a9C1PTTqMm+3ZHp1Zz7rUdlBA27X4l7qSY3SA+s
         X3fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=HzqJzWy6/gVejSAN5h5m+QbHqL8I+Ih3BBbS9yeEwMQ=;
        b=hwvykU9bmAc/p0UI6F9n1Ejt1CydCGSwo4r6zeHykeC9a3PFFxCWHwqT4XNl1fXiKf
         TXfICQVb92wYwEoLIGkH6zs6F3zjtQR/19VgTW3lIxbGYA8LdegUV5J3+Kmz0/8NzOmr
         br5coWkjh1fGYTExJYhS8jGtk6j2uo1F0Xi1fKkK38NL9ktJdrAJkstKcxRKgsA7DnvB
         Qp5ntZk4G41xBrO9igCnLY2MvzSdc/INJ2ZJjhZsBtHxdrAOXeoOghYYggVSbOlR6G5I
         ivebrghptl3lrY+/kZxEm09xZ9aGoF5t9VO6LgFlV6EMJ1XbBT3bKifNGYQZFmtlF2V2
         bxjw==
X-Gm-Message-State: AOAM530kv13r38qx43OTWIZb1/vYAu6uIQbUid4QNZUbaeM1QCviUAe/
        ipZ8S4d23dDa2ydhUKUicb4=
X-Google-Smtp-Source: ABdhPJwX12I2MBOXbiu6oZugVdwTIBUKqfSF8p3wK6Ebq2mwkYOwoYeKHHg4Oha5uOUJ0yedv0L0SQ==
X-Received: by 2002:a17:902:e788:: with SMTP id cp8mr6038172plb.172.1644346152598;
        Tue, 08 Feb 2022 10:49:12 -0800 (PST)
Received: from localhost (2603-800c-1a02-1bae-e24f-43ff-fee6-449f.res6.spectrum.com. [2603:800c:1a02:1bae:e24f:43ff:fee6:449f])
        by smtp.gmail.com with ESMTPSA id kb18sm3983061pjb.30.2022.02.08.10.49.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Feb 2022 10:49:12 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Tue, 8 Feb 2022 08:49:11 -1000
From:   Tejun Heo <tj@kernel.org>
To:     "yukuai (C)" <yukuai3@huawei.com>
Cc:     axboe@kernel.dk, cgroups@vger.kernel.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        yi.zhang@huawei.com
Subject: Re: [PATCH -next] blk-throttle: enable io throttle for root in
 cgroup v2
Message-ID: <YgK7J8TFyFvp/rv1@slm.duckdns.org>
References: <20220114093000.3323470-1-yukuai3@huawei.com>
 <YfGE9L4i7DtNTo08@slm.duckdns.org>
 <235b0757-d322-2b6e-3ab6-ecc8c82f8f1e@huawei.com>
 <Yflr4FzUTWsiLTC/@slm.duckdns.org>
 <32b6949d-60b1-82ce-ae44-1cf089a78276@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <32b6949d-60b1-82ce-ae44-1cf089a78276@huawei.com>
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

On Tue, Feb 08, 2022 at 09:38:33AM +0800, yukuai (C) wrote:
> 3) If we limit iops to 8 for each client from server, client should work
> fine, however, server can receive 64 x 8 = 512 io at most at the same
> time, which might cause too much pressure on the server.(maybe bps is
> more appropriate to explain the high pressure).

I don't follow this part. Why can't the server control however it wanna
control?

Thanks.

-- 
tejun
