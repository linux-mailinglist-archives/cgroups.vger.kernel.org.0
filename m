Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37A166758E9
	for <lists+cgroups@lfdr.de>; Fri, 20 Jan 2023 16:41:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230232AbjATPlH (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 20 Jan 2023 10:41:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229962AbjATPlE (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 20 Jan 2023 10:41:04 -0500
Received: from mail-il1-x12c.google.com (mail-il1-x12c.google.com [IPv6:2607:f8b0:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06D8880BBC
        for <cgroups@vger.kernel.org>; Fri, 20 Jan 2023 07:40:46 -0800 (PST)
Received: by mail-il1-x12c.google.com with SMTP id a9so2392733ilb.0
        for <cgroups@vger.kernel.org>; Fri, 20 Jan 2023 07:40:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WWZZyEASnVJeDNF1yNLqxhUJXWQQRy8pnWrzIYnrXKE=;
        b=v2V3ahcwOyuebwYuu9dRu7UT8QxS8g94SXGFFKxIyCBqAbk2llyobeFPWj5Awzp1qK
         hyFTDrKlLj0HTzsuVN0Ycdxcns3gvZ7iqlYGkwPE2i5qvSixBE4o0cfm+EEi1B5j0JK6
         ri82Hp2zJUo/yb/sbEGQLhndTz2ilFTLxLp4O1EpOrAyXL/ALrRKupl+oJM1y3NRFE9w
         uKjWYSkQL4ktfGdUg9UY01GzXNAu42C2JMxhoW87zWGYXh3QEyHSrhPd46XOC8A+z9GY
         eDuwuA9oIBHqazOS+DFeQff3wzNLoBTwTZ+LeSOqKS9M1AVp0XJ8FxZuFv7tDnv25Sqq
         3nSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WWZZyEASnVJeDNF1yNLqxhUJXWQQRy8pnWrzIYnrXKE=;
        b=mrUjhKDb5xtr+P6ipxeC2aW7VGouNAoqDvimFI39KZgPBdWiuLs1ZEvwPX/zmr3zVa
         umHJMmU8r1zrpUPJxACXKZ/2i5rmP2uyXhNFPw+CYJaJeF11SJzhCMG3tYRB7qtNdOJj
         Z/3V2JHVp/eQyaf2brZnVFcU4dNDdNn07imkdORtlPy7tc3gxeaIr1rAWEi220JlB4Hj
         AwJjlWupEotvprLHORAPV0SCZCs5nqxK6AujFJLLvnUyzTDnoyDrpXHw70PQSM7WtetK
         uWUer7Ezha5AAU8KWKXCNgB22KNT9UBcbDzjn1tisg81r7QUP3utVb195EvUwS8LOlTQ
         8cvQ==
X-Gm-Message-State: AFqh2kqxw9kLHg4kZk/k0pgB11hA2nuwzQ+P2GFa6Zps1xHdF25gxvan
        T+mpYrOT3KWycouttsAqCNQ3Jqlkh+0MVJIT
X-Google-Smtp-Source: AMrXdXvqr1gf6LsriZhblEuwsV/ojwQoD+SuMayTzyNfyKJSMR0jJ5jvc3wSVt0hqkM81B1PB2EQbw==
X-Received: by 2002:a92:c5d1:0:b0:30d:9eea:e51 with SMTP id s17-20020a92c5d1000000b0030d9eea0e51mr2273147ilt.1.1674229245097;
        Fri, 20 Jan 2023 07:40:45 -0800 (PST)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id b11-20020a02a58b000000b003a60e5a2638sm1886075jam.94.2023.01.20.07.40.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Jan 2023 07:40:44 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     tj@kernel.org, josef@toxicpanda.com,
        Yu Kuai <yukuai1@huaweicloud.com>
Cc:     cgroups@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, yukuai3@huawei.com,
        yi.zhang@huawei.com, yangerkun@huawei.com
In-Reply-To: <20230117070806.3857142-1-yukuai1@huaweicloud.com>
References: <20230117070806.3857142-1-yukuai1@huaweicloud.com>
Subject: Re: [PATCH v4 0/5] blk-iocost: random bugfix
Message-Id: <167422924424.669768.14436700036484270833.b4-ty@kernel.dk>
Date:   Fri, 20 Jan 2023 08:40:44 -0700
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12-dev-78c63
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org


On Tue, 17 Jan 2023 15:08:01 +0800, Yu Kuai wrote:
> changes in v4:
>  - a litter code optimization to make it easier to understand in patch
>  4.
> 
> changes in v3:
>  - move some patches into separate patchset
>  - don't return other error number for match_u64() in patch 1
>  - instead of checking user input separately, set page directly if
>  'bps + IOC_PAGE_SIZE' will overflow.
> 
> [...]

Applied, thanks!

[1/5] blk-iocost: check return value of match_u64()
      commit: 7b6a2c89052bfaf750260691dee29c2e457c0929
[2/5] blk-iocost: don't allow to configure bio based device
      commit: 204a9e1eeb4b72cd260274f14e521162b130a978
[3/5] blk-iocost: read params inside lock in sysfs apis
      commit: 7b810b50390b53c2a81051adce8fcbff3200fc74
[4/5] blk-iocost: fix divide by 0 error in calc_lcoefs()
      commit: 4e952a32301a77faea0d36c540ae16847cf2a8ee
[5/5] blk-iocost: change div64_u64 to DIV64_U64_ROUND_UP in ioc_refresh_params()
      commit: ad5572498be17b800e75bc36f7d810dd3b673802

Best regards,
-- 
Jens Axboe



