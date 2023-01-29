Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D5DD680239
	for <lists+cgroups@lfdr.de>; Sun, 29 Jan 2023 23:21:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235401AbjA2WU6 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Sun, 29 Jan 2023 17:20:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235396AbjA2WU5 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Sun, 29 Jan 2023 17:20:57 -0500
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EA3020691
        for <cgroups@vger.kernel.org>; Sun, 29 Jan 2023 14:20:32 -0800 (PST)
Received: by mail-pl1-x629.google.com with SMTP id v23so9833688plo.1
        for <cgroups@vger.kernel.org>; Sun, 29 Jan 2023 14:20:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PaWOdTWb/BaPcMrfWb0OI2BnQ5NRhvslPHB9PaY2czM=;
        b=bSlmnlpDPVJKHl8Ffvd1webJtnqNaWXDEXWAQNGHj+jalLonYk3eGyf9SeIpq1BOg6
         ZP1JHTvOyuYq0rBU6JKuasQzCF0kqyUlIYxZSeWZdCENAa5OxWXBFJhGwuH6Ca4eDC0E
         2oUU0dR+w+fKBn1TVUAGKuMOufVG3GrRU5E9NI3ASKx0DtMyRwwn0aV77msXgVUFMKcy
         O8JTdKE6cAOpKZBKfS+bxtcSsAP8oghB0pcfpfP+qrE6tFjyzcwnDils1ZYhHKHwkP0o
         BQgJXcT9BEenssOUSVckjG6UwLYw1C986N/6o/DgTJVrw2hbV0nSciHCqpFNh2S7mTBu
         XIoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PaWOdTWb/BaPcMrfWb0OI2BnQ5NRhvslPHB9PaY2czM=;
        b=hRBQf8WdIO49f5vr1xU84no2ABWhmvnutlMWJ8VSeGAKGTKGvmwprJ9c0LhPSE8xCy
         U2vpLMZ7x4GhDhK9U9DutcJ1c5yKKxbbGTHzJ+GT3NfBJk7DIa/NQeowgFa4SWUQOJH/
         R3lw2VcstmE+lZMdzHheNIdg2I/FVNp3K8ZbIfAw872HCvhbyM4W6O2Lj+P18tI7wzNj
         pdbLHWFMPedmVtN8TSq11elu54vPZUdYjjh1LLFGA+z8dlHqkMcAKQtI58yHWJFKqcF6
         rX7/Hn84/51qfyK2N1dra5hb+pTLGkdmhhcbI3dQS0f7rJPpPkz1zOiwhoWG8LABID2l
         LubQ==
X-Gm-Message-State: AFqh2kqjmPe+vrrM09ojo8e0mJUh/RXXhhetOXnsriV8B8HF+EjqSxVA
        GTQ4p1jB9cBR9FWVK/QsLj+31w==
X-Google-Smtp-Source: AMrXdXvAHw97vibrROFpK/kUdk8lNr6QstPYl8Bwstm0UmgWV52Sf0KG6dD81f7+VosrWn1jiWixkQ==
X-Received: by 2002:a17:903:543:b0:192:fa8a:568a with SMTP id jo3-20020a170903054300b00192fa8a568amr11609822plb.2.1675030831334;
        Sun, 29 Jan 2023 14:20:31 -0800 (PST)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id x15-20020a170902ec8f00b001968b529c98sm23603plg.128.2023.01.29.14.20.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Jan 2023 14:20:30 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     tj@kernel.org, hch@lst.de, josef@toxicpanda.com,
        Yu Kuai <yukuai1@huaweicloud.com>
Cc:     cgroups@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, yukuai3@huawei.com,
        yi.zhang@huawei.com, yangerkun@huawei.com
In-Reply-To: <20230119110350.2287325-1-yukuai1@huaweicloud.com>
References: <20230119110350.2287325-1-yukuai1@huaweicloud.com>
Subject: Re: [PATCH -next v3 0/3] blk-cgroup: make sure pd_free_fn() is
 called in order
Message-Id: <167503083019.59803.12005563665423303861.b4-ty@kernel.dk>
Date:   Sun, 29 Jan 2023 15:20:30 -0700
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.0
X-Spam-Status: No, score=1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org


On Thu, 19 Jan 2023 19:03:47 +0800, Yu Kuai wrote:
> Changes in v3:
>  - add ack tag from Tejun for patch 1,2
>  - as suggested by Tejun, update commit message and comments in patch 3
> 
> The problem was found in iocost orignally([1]) that ioc can be freed in
> ioc_pd_free(). And later we found that there are more problem in
> iocost([2]).
> 
> [...]

Applied, thanks!

[1/3] blk-cgroup: dropping parent refcount after pd_free_fn() is done
      commit: c7241babf0855d8a6180cd1743ff0ec34de40b4e
[2/3] blk-cgroup: support to track if policy is online
      commit: dfd6200a095440b663099d8d42f1efb0175a1ce3
[3/3] blk-cgroup: synchronize pd_free_fn() from blkg_free_workfn() and blkcg_deactivate_policy()
      commit: f1c006f1c6850c14040f8337753a63119bba39b9

Best regards,
-- 
Jens Axboe



