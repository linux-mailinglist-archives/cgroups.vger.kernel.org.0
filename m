Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FD7E65DF13
	for <lists+cgroups@lfdr.de>; Wed,  4 Jan 2023 22:31:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235429AbjADVbF (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 4 Jan 2023 16:31:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240391AbjADVav (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 4 Jan 2023 16:30:51 -0500
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E98213F64;
        Wed,  4 Jan 2023 13:30:36 -0800 (PST)
Received: by mail-pl1-x62d.google.com with SMTP id 17so37325703pll.0;
        Wed, 04 Jan 2023 13:30:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QUxjPqi8cIjWiZ4wgk9iUZ3U2OAiaNP4OQpT53WV9V4=;
        b=XHg29x/xZNjdTm//dbuc775EIoI9HMgi3iyEYs8SyHdybx5CB84wsv0dt8CY18Rb6+
         n8NNZRGZm0EPHN/tL8w/1pzIx1GCaTryX0QV0R/UI7JrYWTUAr3hJ9Qp2iaYPtOg+Jh3
         QQXIhBzb9qDYiD98zixXkhWfzrJE7RUj7UBTHemmMDjKssASMTxLBNyimWO/IxlX6Qt/
         QEocTqc3A9MZWTqSmLuiUkNXiDDCNW0hU43r/6bkTwpt+uHX7/FZV+cRc5ctkX2YDPo+
         gToPpHWLhdLXOpMYeN/OnEstNepYdbn2ikoN7J3fOEsl9CLGMAKYzCAEXEqPHzd1cFm2
         hzCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QUxjPqi8cIjWiZ4wgk9iUZ3U2OAiaNP4OQpT53WV9V4=;
        b=Q2hyHQqXaMh+wkv+57mC7Jb/0ui3A9Wbjcw8eF39NShtODNRVEZ3S2TJLcXsZNQZ6e
         9TRXSLla/zV4RxO7hbnN+caehH1yHISUhmgCK4ESUgRZlCDerRfhlYB68yIxKCsnTrhd
         FA9wHv1rOnv5rqIpO32QqQokUykAHLGPKzP6EA5NBXx3M2lVMbGZZJ9kefo0pOqfJYRR
         6COVrXQIbMgCgPfZsC9txdZEYbZHaBvk9OgU1clGOldBdWPF5qV5DBKGxae7jlDEmGFS
         YptKGM5i6+hK/WOzXtphdekAnnm9il2iCn0qstZwFCqq2eyVaIP3kSHi3+dTdjR81Snu
         1+Rw==
X-Gm-Message-State: AFqh2kqqp9fQUWIz+L5L2YmKphV5YYTyl8PtqjbReG1If9vDZ1kh9z2r
        1DEdzslIdmkRlBls80VyhFM=
X-Google-Smtp-Source: AMrXdXvfV+Dp6BhUSY78RXOZsV1BB6OX4Lwe5b3z206ag2kVX4WoXI3kxQe7VIec8wieciL5C18zTA==
X-Received: by 2002:a17:90a:c24a:b0:225:f3e6:424e with SMTP id d10-20020a17090ac24a00b00225f3e6424emr35633894pjx.17.1672867835855;
        Wed, 04 Jan 2023 13:30:35 -0800 (PST)
Received: from localhost (2603-800c-1a02-1bae-a7fa-157f-969a-4cde.res6.spectrum.com. [2603:800c:1a02:1bae:a7fa:157f:969a:4cde])
        by smtp.gmail.com with ESMTPSA id om5-20020a17090b3a8500b002192a60e900sm2505pjb.47.2023.01.04.13.30.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Jan 2023 13:30:35 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Wed, 4 Jan 2023 11:30:34 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Yu Kuai <yukuai1@huaweicloud.com>
Cc:     hch@infradead.org, josef@toxicpanda.com, axboe@kernel.dk,
        cgroups@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, yukuai3@huawei.com,
        yi.zhang@huawei.com, yangerkun@huawei.com
Subject: Re: [PATCH -next 1/4] block/rq_qos: move implementions of init/exit
 rq-qos apis to blk-rq-qos.c
Message-ID: <Y7Xv+rtqXQM8gf+A@slm.duckdns.org>
References: <20230104085354.2343590-1-yukuai1@huaweicloud.com>
 <20230104085354.2343590-2-yukuai1@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230104085354.2343590-2-yukuai1@huaweicloud.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed, Jan 04, 2023 at 04:53:51PM +0800, Yu Kuai wrote:
> From: Yu Kuai <yukuai3@huawei.com>
> 
> These init/exit rq-qos apis are super cold path, there is no need to
> inline them to improve performance. This patch also prepare to use a
> global mutex to protect these apis, move these implementions to
> blk-rq-qos.c so that the global mutex won't be exposed. There are no
> functional changes.
> 
> Signed-off-by: Yu Kuai <yukuai3@huawei.com>

Acked-by: Tejun Heo <tj@kernel.org>

Thanks.

-- 
tejun
