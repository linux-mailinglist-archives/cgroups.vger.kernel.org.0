Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0268A64D02D
	for <lists+cgroups@lfdr.de>; Wed, 14 Dec 2022 20:43:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238905AbiLNTnc (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 14 Dec 2022 14:43:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238774AbiLNTnb (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 14 Dec 2022 14:43:31 -0500
Received: from mail-il1-x136.google.com (mail-il1-x136.google.com [IPv6:2607:f8b0:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE45D2A702
        for <cgroups@vger.kernel.org>; Wed, 14 Dec 2022 11:43:29 -0800 (PST)
Received: by mail-il1-x136.google.com with SMTP id i25so7074417ila.8
        for <cgroups@vger.kernel.org>; Wed, 14 Dec 2022 11:43:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2Mo0zxBwzxFipCiGCCwccoKGO7YvtvSURarcs0pMhQI=;
        b=lvENkja2zLcChQJAHLDCQQqh3zlQH8Dsoq55tTl87sB+2c0MjiwdB7LOF6vWIz22Fu
         eCICg9Fj6TfwXA8yG7XYMiaf2z12/uwOtxGbirrVMlhelM9zsuZSiJc0fsCQcVkxIqWi
         RQd2jNWuTv9nWpvqSBjTE6mk9xX/4Ih+TD6DNwKiit6DgH/l7Dbq4AiiFcND0y8/5zYZ
         HcmI74WEhjBHTUZjZl0MFiaX3CzA+Q2HPYKOJGeQA+jYIBNJZTtivM8BtmFfUwTiLPqK
         ov7lyv5b6U8d6dtzpDcDCl9w8rm+uTR3Js1B0DGhRtqpJZkWRzUSkxytnCYJqyMhzm2G
         G9Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2Mo0zxBwzxFipCiGCCwccoKGO7YvtvSURarcs0pMhQI=;
        b=VzsQrBLDizt/NhDKeoJeNQh/fJJlLtL9LbDnAI+TnWUg0RDEGiHyxjyFJVF1Rxfdpe
         h1/WFjQrl5Xp7J5BwdqPUsUOEeKj2y9y7ncx/gsNaFQH0QTTbtBRB/P27Jjb90aGSwwf
         VWIenZAZOuYqPOJBp5+KhY3UG9ApA9gmAlNQfw7RBBpD3s+2y6b24CkYtMVO+tQUEM6i
         +P/xHy+OLuk+D7UBev/OEUFU1zsJ9ESjzQMcxDMcg1pAz76lfRNbLgFACqwCLw0n/ROx
         hmjzeBKn9cFE45hNF+9vy6KNYEMOFV50hVZvKKaUcKa9hbmh/pIU0+BMclRCZXusefsn
         MFdw==
X-Gm-Message-State: ANoB5pld8JqwP0Dqvv3fP3bq1x92o88iBo/FOG2am3gkBenekJwjn0jX
        XrhCpNlhop2t+X3zq3e531X4Hg==
X-Google-Smtp-Source: AA0mqf6WKbG+uIycnikl1gYVo8MJ2Ro9/CeBqRYhcftKzrxuMs24gD/X3ikbzVraxdgzchJF9GRhRA==
X-Received: by 2002:a05:6e02:1a27:b0:304:b2dc:4274 with SMTP id g7-20020a056e021a2700b00304b2dc4274mr2666051ile.3.1671047009066;
        Wed, 14 Dec 2022 11:43:29 -0800 (PST)
Received: from [127.0.0.1] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id u11-20020a02b1cb000000b0038a5b48f3d4sm1980125jah.3.2022.12.14.11.43.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Dec 2022 11:43:28 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     Tejun Heo <tj@kernel.org>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        darklight2357@icloud.com, Josef Bacik <josef@toxicpanda.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        cgroups@vger.kernel.org
In-Reply-To: <Y5TQ5gm3O4HXrXR3@slm.duckdns.org>
References: <Y5TQ5gm3O4HXrXR3@slm.duckdns.org>
Subject: Re: (subset) [PATCH 1/2 block/for-6.2] blk-iolatency: Fix memory leak
 on add_disk() failures
Message-Id: <167104700802.18171.11122547200509229739.b4-ty@kernel.dk>
Date:   Wed, 14 Dec 2022 12:43:28 -0700
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.11.0-dev-50ba3
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org


On Sat, 10 Dec 2022 08:33:10 -1000, Tejun Heo wrote:
> When a gendisk is successfully initialized but add_disk() fails such as when
> a loop device has invalid number of minor device numbers specified,
> blkcg_init_disk() is called during init and then blkcg_exit_disk() during
> error handling. Unfortunately, iolatency gets initialized in the former but
> doesn't get cleaned up in the latter.
> 
> This is because, in non-error cases, the cleanup is performed by
> del_gendisk() calling rq_qos_exit(), the assumption being that rq_qos
> policies, iolatency being one of them, can only be activated once the disk
> is fully registered and visible. That assumption is true for wbt and iocost,
> but not so for iolatency as it gets initialized before add_disk() is called.
> 
> [...]

Applied, thanks!

[1/2] blk-iolatency: Fix memory leak on add_disk() failures
      commit: 813e693023ba10da9e75067780f8378465bf27cc

Best regards,
-- 
Jens Axboe


