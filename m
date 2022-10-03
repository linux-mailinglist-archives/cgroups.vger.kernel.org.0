Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1059E5F34A5
	for <lists+cgroups@lfdr.de>; Mon,  3 Oct 2022 19:37:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229594AbiJCRhk (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 3 Oct 2022 13:37:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229774AbiJCRhN (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 3 Oct 2022 13:37:13 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE2013C8CE;
        Mon,  3 Oct 2022 10:36:53 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id w2so10826377pfb.0;
        Mon, 03 Oct 2022 10:36:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date;
        bh=5L++ta1CEKG7cNirpHCVz8TWx+DYjvecQkSUPMV2bHg=;
        b=lTWWoEoXEzxpuxxTJ3loP+njbF5t/rALzsK3NCjNS0BMDeQgm4X9ZNI/RxAfvH5z3G
         MpyC7/pIViafioL12ImcN7/XnBPCrAuVHfvK/WNf3APtv6JGTBvdfIecRwahKQTlmXZk
         pWASBgGnLNZCxMV2Umj2EioGHEM5HWXKTOWEaLYIZqVg968cTiU6+CpMzYOPfk2Th3pX
         rjQaUwGL1XipGw1LaJvq61i/O9gXnIQULcXVq7k2CDrsg2vhE9RGyGp9x5C1HfOpgMoT
         Mq1qE0bCafvetOV9rtbK5XbYs8ZV8cna/GZYew8+T/84t3NzoJYLc8+a0v+Z7A9CQjdi
         u+KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date;
        bh=5L++ta1CEKG7cNirpHCVz8TWx+DYjvecQkSUPMV2bHg=;
        b=WgVJ2t2yJ7k4lIAnXx3/3+Xf4kerSN7fSr+Hab+Z44j+5jk3G1UwFU2W2DZqJJdf/j
         MIVpx1ANL/VhPzXtBLBuNu4FbQysKDTG0cV7fA6GWJLaOkOQn0XLE3ocFclo13Qw7Oi7
         MRezlRuNJ6SpSqrFY8TI7wSSfS4qkXFz4ptQZKasDOspuWYeo9fa32vhj+TYn6yFvE4h
         Ch/t7fXinJPt3wLBxD5io3wufwJsb1mw0JJQSIrk6XmDzYTpvGEWmQrM2tuBKhItYHlW
         nSOaTnfngPpjPvWVJn8/ri6wbpT69tJ/xjyfSX/vISAQaLKk0k2SOEek6jPMEbfCYoui
         C7lg==
X-Gm-Message-State: ACrzQf2pyXm+HxhFHlisXLU+2SmEBh6ebKxlDiHW2iRYyEchnmImqDTg
        SHFz85JE5cMYPrc2ytw2fVQ=
X-Google-Smtp-Source: AMsMyM5VYaw/wEq1dHgRHkiGNIIPJLa1R4UZnpq5WWjBRMyPd8T2bLkog07jP6Q/g3c1i3cFYQETMw==
X-Received: by 2002:a05:6a00:2495:b0:55f:1b48:5df with SMTP id c21-20020a056a00249500b0055f1b4805dfmr13579472pfv.43.1664818613266;
        Mon, 03 Oct 2022 10:36:53 -0700 (PDT)
Received: from localhost ([2620:10d:c090:400::5:cb45])
        by smtp.gmail.com with ESMTPSA id j16-20020a170902da9000b00176c6738d13sm7523463plx.169.2022.10.03.10.36.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Oct 2022 10:36:52 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Mon, 3 Oct 2022 07:36:50 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Waiman Long <longman@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, cgroups@vger.kernel.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Ming Lei <ming.lei@redhat.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>
Subject: Re: [PATCH v7 1/3] llist: Add a lock-less list variant terminated by
 a sentinel node
Message-ID: <YzsdsjlMMDFwLOzR@slm.duckdns.org>
References: <20221003154459.207538-1-longman@redhat.com>
 <20221003154459.207538-2-longman@redhat.com>
 <YzsQZPONIJRgtf3o@slm.duckdns.org>
 <006ebc52-ab37-442a-9ba3-e7b8dff53fab@redhat.com>
 <YzsUgY4CC0SH8Sl2@slm.duckdns.org>
 <8008933b-4a28-19e5-02db-ef1d07eaf952@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8008933b-4a28-19e5-02db-ef1d07eaf952@redhat.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hello,

On Mon, Oct 03, 2022 at 01:32:49PM -0400, Waiman Long wrote:
> What my current thinking is to make llist works with both NULL and sentinel
> terminated lockless list. Users who wish to use the sentinel terminated
> version will have to use special sentinel version of LLIST_HEAD() macro and
> llist_del_all() and __llist_del_all() functions. In this way, I don't need
> to touch an existing users of llist while minimizing code redundancy. What
> do you think?

Wouldn't that be more error-prone in the long term? I'd just bite the bullet
and convert the empty tests. It is a hassle to find them but given that it's
just the head node testing, it hopefully wouldn't be too bad.

Thanks.

-- 
tejun
