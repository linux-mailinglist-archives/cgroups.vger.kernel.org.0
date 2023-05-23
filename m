Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76E3470E36B
	for <lists+cgroups@lfdr.de>; Tue, 23 May 2023 19:46:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238065AbjEWROL (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 23 May 2023 13:14:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238044AbjEWROD (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 23 May 2023 13:14:03 -0400
Received: from mail-il1-x12f.google.com (mail-il1-x12f.google.com [IPv6:2607:f8b0:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B9A4185
        for <cgroups@vger.kernel.org>; Tue, 23 May 2023 10:14:01 -0700 (PDT)
Received: by mail-il1-x12f.google.com with SMTP id e9e14a558f8ab-339fca7da2aso760745ab.0
        for <cgroups@vger.kernel.org>; Tue, 23 May 2023 10:14:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20221208.gappssmtp.com; s=20221208; t=1684862041; x=1687454041;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qmWtJOzNztkpnf4UzHCczQhsDx+hgxiMe2XgRqYyHhI=;
        b=rQvy6TSK+wfTlo0HdARvbSVdkvmZoky53LQfz6I/sHZSh/vam08zvcWX8BKFq35rPJ
         FiOXal8syvG9pEP0WTv6iW7eSanhHy7ABqS8itvydZ8rH14nwiDgZz79SGNg3RH3bQj8
         WTmLv9HJ2uOAsK7i88YATrsiJwt/hKCRYYVxQMA7/a3MuM4g4yafCnt36kQlOjL/VWPH
         6o5dMj0POMwamomezMYNOxNy841T05ufNRwMDpAkAYeEwREsLkqobJ+hg8+fwPBm4nOe
         u6quTE5qyRblQsMAa260HpGZ0iO2Y0Wue1iugiodj3bo6gNKl8rdK5sY8KOYxSKugSqK
         REMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684862041; x=1687454041;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qmWtJOzNztkpnf4UzHCczQhsDx+hgxiMe2XgRqYyHhI=;
        b=CbhQ+rVEbLFVIUsNBdSMkCdEczQQ6rRC58F1xQEXbP1tMfJTlRcMlYY0DMxdi7ZoIM
         P5vhwrGHwqsi7E1rTe7d4QxTb3PUTrU0V4Fpy8iR2rBbRaNACCED6LFX+yCaR1Qtei7O
         5zZULCr4jnV5zxTbV658/AccRBsAqu9J2tbiPXzoTz4B+Lmo99ofmRvHhG1ti+7y2XwB
         TRKWuYFvv/iX7QYL4RpwduVpBkRJVAEOdcTADdp76nwjFak3DOgpqUElVpmFl3GHJX1/
         4hfY8nWYQikaQDEj6UWhxXLEOxpacMW3LjNfGMdrfbJYJxTt3V84ugrWcjXQj8vTdCje
         FKOw==
X-Gm-Message-State: AC+VfDxGbUDSfRy5+szq71dwrIniF6bqUYGn9JYd5BNUTrFBWGHwuqMz
        8PddlG1SfIJj74MarrUuDe59Dw==
X-Google-Smtp-Source: ACHHUZ484Klt0h0DdDR9++SF2ilwYFPu1B4JHU4ETiLnEdiOPsAptOMMT7O5wPaxS3A/GWCCiNI72w==
X-Received: by 2002:a6b:b70c:0:b0:774:80fc:11a9 with SMTP id h12-20020a6bb70c000000b0077480fc11a9mr1794870iof.1.1684862041070;
        Tue, 23 May 2023 10:14:01 -0700 (PDT)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id u7-20020a02aa87000000b00411a1373aa5sm2524580jai.155.2023.05.23.10.13.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 May 2023 10:14:00 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     tj@kernel.org, hch@lst.de, josef@toxicpanda.com,
        Yu Kuai <yukuai1@huaweicloud.com>
Cc:     cgroups@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, yukuai3@huawei.com,
        yi.zhang@huawei.com, yangerkun@huawei.com
In-Reply-To: <20230414084008.2085155-1-yukuai1@huaweicloud.com>
References: <20230414084008.2085155-1-yukuai1@huaweicloud.com>
Subject: Re: [PATCH for-6.4/block] block/rq_qos: protect rq_qos apis with a
 new lock
Message-Id: <168486203985.398377.17593981162726402548.b4-ty@kernel.dk>
Date:   Tue, 23 May 2023 11:13:59 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-00303
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org


On Fri, 14 Apr 2023 16:40:08 +0800, Yu Kuai wrote:
> commit 50e34d78815e ("block: disable the elevator int del_gendisk")
> move rq_qos_exit() from disk_release() to del_gendisk(), this will
> introduce some problems:
> 
> 1) If rq_qos_add() is triggered by enabling iocost/iolatency through
>    cgroupfs, then it can concurrent with del_gendisk(), it's not safe to
>    write 'q->rq_qos' concurrently.
> 
> [...]

Applied, thanks!

[1/1] block/rq_qos: protect rq_qos apis with a new lock
      commit: a13bd91be22318768d55470cbc0b0f4488ef9edf

Best regards,
-- 
Jens Axboe



