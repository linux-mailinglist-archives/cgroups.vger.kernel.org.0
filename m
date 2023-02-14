Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3139696F5E
	for <lists+cgroups@lfdr.de>; Tue, 14 Feb 2023 22:25:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229933AbjBNVZE (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 14 Feb 2023 16:25:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232975AbjBNVY5 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 14 Feb 2023 16:24:57 -0500
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com [IPv6:2607:f8b0:4864:20::d2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55AE4301AA
        for <cgroups@vger.kernel.org>; Tue, 14 Feb 2023 13:24:40 -0800 (PST)
Received: by mail-io1-xd2b.google.com with SMTP id d16so6364531ioz.12
        for <cgroups@vger.kernel.org>; Tue, 14 Feb 2023 13:24:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MX/2U0qYb3miU8ugNFw4fmPtYLQym+1ZkvFlchf7Fsk=;
        b=o0cBXrctIG0/VVG6AanOILi6i4olxBWvLbiD3ix7XrjyUo+/eMB4tkcevgZkqr0eNI
         VUETZSob1FK/k2+k/ZxsvahEkExSs8P6wtKGsVj9/WxPefFh14EqyEPHSPDEIc1nGvtT
         prNg71bIjXUCwlaJnDitdYlUuI50DT9zRkcBjJfMQZ2uq9YrFzN5Id4j3Egi9sW3I/hj
         HNLuxxG+2UUDrSQ0g15ewhK4sOlvJcvBOi12UuABTDK6xKrtRbBArVymKVEwj8tpS2YB
         QTdDdtfgn8Vmgj7Is82hfwYRhmTa2sohB0rp7woi4HZ+TOQieQ7PaCuJcabc2kbUxdOx
         EnKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MX/2U0qYb3miU8ugNFw4fmPtYLQym+1ZkvFlchf7Fsk=;
        b=CkwW8vrhTz1qvp6R8pHBgDL1i1kVKBcZmQDq1q4fJdHVqd7NxMUk6womVyRKbHMH4y
         qwEaqb4pKG1FlxffD76FH9ZsYERH9OYA1tICE/QteVjoZqMrKCqhl+Aa0T87qIySXf3F
         vIXTSn0lNXE5r1DU44aq6fkDMOeBv0bfLXBSZh065ArggZ15wDQG3F75maOw9Ng43Uqx
         IpTXCoHZC2bO1mGtDlXMBw0b73Ta161jZfkxbMSp+YUDLgKUAeJYK7IBmvtWbqPM0V98
         yTBb4Moo7tR2CLNu7tvSd8WIFiOTDVcSluTbKyEuFiYicl0efyiMi0wpwlZ3M/AwvSgx
         pm1Q==
X-Gm-Message-State: AO0yUKVzIq59MBKA/JTBXT2I5x7KbHHFG63q5aXW1QV2DmvxKOz6zFQX
        T53T89xKAJ2ZWk3WtJhQhJjKHQ==
X-Google-Smtp-Source: AK7set8RFmTB5Wq3ljqKSW3lyV8pAMnRyNSaD9XPr9bwrByGiQNdRAor0Aum/E46BazdA1FReKIAAA==
X-Received: by 2002:a05:6602:4149:b0:707:d0c0:1bd6 with SMTP id bv9-20020a056602414900b00707d0c01bd6mr157864iob.1.1676409879570;
        Tue, 14 Feb 2023 13:24:39 -0800 (PST)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id n23-20020a02a917000000b0037477c3d04asm4969537jam.130.2023.02.14.13.24.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Feb 2023 13:24:39 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     Tejun Heo <tj@kernel.org>, Josef Bacik <josef@toxicpanda.com>,
        Christoph Hellwig <hch@lst.de>
Cc:     Ming Lei <ming.lei@redhat.com>, cgroups@vger.kernel.org,
        linux-block@vger.kernel.org
In-Reply-To: <20230214183308.1658775-2-hch@lst.de>
References: <20230214183308.1658775-1-hch@lst.de>
 <20230214183308.1658775-2-hch@lst.de>
Subject: Re: [PATCH 1/5] Revert "blk-cgroup: move the cgroup information to
 struct gendisk"
Message-Id: <167640987873.61344.17492950909127302009.b4-ty@kernel.dk>
Date:   Tue, 14 Feb 2023 14:24:38 -0700
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.0
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org


On Tue, 14 Feb 2023 19:33:04 +0100, Christoph Hellwig wrote:
> This reverts commit 3f13ab7c80fdb0ada86a8e3e818960bc1ccbaa59 as a patch
> it depends on caused a few problems.
> 
> 

Applied, thanks!

[1/5] Revert "blk-cgroup: move the cgroup information to struct gendisk"
      commit: 1231039db31cf0703996d0b1797c2702e25a110a
[2/5] Revert "blk-cgroup: delay calling blkcg_exit_disk until disk_release"
      commit: b4e94f9c2c0822265a6942741d270aa16d229331
[3/5] Revert "blk-cgroup: delay blk-cgroup initialization until add_disk"
      commit: b6553bef8cdc2983943f60edb8dc5e49361ebb3b
[4/5] Revert "blk-cgroup: pass a gendisk to blkg_lookup"
      commit: 9a9c261e6b5512e0b8d9ae9b1c1746c743a15a48
[5/5] Revert "blk-cgroup: pin the gendisk in struct blkcg_gq"
      commit: a06377c5d01eeeaa52ad979b62c3c72efcc3eff0

Best regards,
-- 
Jens Axboe



