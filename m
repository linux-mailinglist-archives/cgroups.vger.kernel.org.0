Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE648681822
	for <lists+cgroups@lfdr.de>; Mon, 30 Jan 2023 19:01:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237500AbjA3SBg (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 30 Jan 2023 13:01:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237463AbjA3SBa (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 30 Jan 2023 13:01:30 -0500
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE75C3E616;
        Mon, 30 Jan 2023 10:01:27 -0800 (PST)
Received: by mail-pj1-x1033.google.com with SMTP id e8-20020a17090a9a8800b0022c387f0f93so11271223pjp.3;
        Mon, 30 Jan 2023 10:01:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=I4D1Ztp5PXdnjePzURg65Mwo279xYxNPa3f1/sKE5u4=;
        b=P28ybXbqk2lUQqqrphJjk3zFN2/7Ucbw6CuzRIwJahxQ7K4MRZhALIYagoVDPYFWjO
         2Q51er32H9qfSTZNepRmTyVQVLX0Rm+jkg7cfMgfc0qSjN4hapg6vklx6rESi+CO2fXb
         0BbWtRy04i1kxXbSo2XE+PuSBJ61G5jC1vtiOfX8sFv/VUOtNnOr3pu9UiLNAL1Ee+k5
         purXcAwlBZ7hzw7sq/D5XmM3rA2DXDf+PVaGnP98DKpIv81uKcSpQLxmHPSw9rPWdtm/
         7cGZkdwSqjpQKym7TFguaUgvz5qaW/UdQ8e8z0OatL+23U6Hi50W1eG4ngJa84Iryd0k
         /o/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=I4D1Ztp5PXdnjePzURg65Mwo279xYxNPa3f1/sKE5u4=;
        b=wYQ1HkBLvxeD9QiSDGjc4XAjDGjLWMnXR3Rbp9tRGTgq6/b+GZJOPvSioq1XAqzqpn
         klZ0n95Lg20MG+Fh2Jpszy1GZiUa9Iwi4/E1FifN2dbin7icmSMj35tVlIZYMYsqmnhp
         Yo5DIYSx3VJtZdm8+jRu5FM4PMd0GG+LtUtf1nKoY650ymPXtROxdyxW37e1wLa5YcuO
         QnFUzNI80ezLMEX6h2UNg1SY8Rx5fTy5eaDV80YuIIlRYHEn6mERgdSQmx5MWkl0+7Uo
         Mto88tEk1G1tY+fhfLJmXN5Yh/tRUhmaqiKRULl9Dfsbhwd0hDbz19ttC/dr/z865tR1
         ZhoQ==
X-Gm-Message-State: AO0yUKXJamN66mLBxspFXcp4HkzR6h2OZy7bfUWD76akAX3iV8p6G14L
        BqPVArF0xsdIYPHOBCa3SiE=
X-Google-Smtp-Source: AK7set9Vi/N1eTHHTsLb46fowrg6kZs54hy5jnjNYC/R7hR10XQucmJtGgVjqA8aR7sEEtyjOUQgaA==
X-Received: by 2002:a17:903:2093:b0:192:ef8e:4258 with SMTP id d19-20020a170903209300b00192ef8e4258mr6351497plc.14.1675101686559;
        Mon, 30 Jan 2023 10:01:26 -0800 (PST)
Received: from localhost (2603-800c-1a02-1bae-a7fa-157f-969a-4cde.res6.spectrum.com. [2603:800c:1a02:1bae:a7fa:157f:969a:4cde])
        by smtp.gmail.com with ESMTPSA id ix1-20020a170902f80100b001960e9dd05esm8111845plb.112.2023.01.30.10.01.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Jan 2023 10:01:26 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Mon, 30 Jan 2023 08:01:24 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        Josef Bacik <josef@toxicpanda.com>,
        linux-block@vger.kernel.org, cgroups@vger.kernel.org,
        Andreas Herrmann <aherrmann@suse.de>
Subject: Re: [PATCH 01/15] blk-cgroup: don't defer blkg_free to a workqueue
Message-ID: <Y9gF9DEx8zDKVDTE@slm.duckdns.org>
References: <20230124065716.152286-1-hch@lst.de>
 <20230124065716.152286-2-hch@lst.de>
 <Y9U7TZQtjnMd6snm@T590>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y9U7TZQtjnMd6snm@T590>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Sat, Jan 28, 2023 at 11:12:13PM +0800, Ming Lei wrote:
> On Tue, Jan 24, 2023 at 07:57:01AM +0100, Christoph Hellwig wrote:
> > Now that blk_put_queue can be called from process context, there is no
> 
> s/process/atomic?
> 
> > need for the asynchronous execution.
> > 
> > This effectively reverts commit d578c770c85233af592e54537f93f3831bde7e9a.
> 
> blkg_free() can be called with ->queue_lock, and:
> 
> - del_timer_sync(&tg->service_queue.pending_timer) is called from throtl_pd_free().
> 
> - queue_lock is required by throtl_pending_timer_fn
> 
> So there is deadlock risk if the above commit is reverted.

Ah, good catch. Looks like we'd have to leave this async.

Thanks.

-- 
tejun
