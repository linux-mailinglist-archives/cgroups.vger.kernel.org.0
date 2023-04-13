Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4EC06E039C
	for <lists+cgroups@lfdr.de>; Thu, 13 Apr 2023 03:22:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229516AbjDMBWW (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 12 Apr 2023 21:22:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbjDMBWW (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 12 Apr 2023 21:22:22 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C3D8CF;
        Wed, 12 Apr 2023 18:22:21 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id 4fb4d7f45d1cf-504eb1155d3so5855438a12.1;
        Wed, 12 Apr 2023 18:22:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681348939; x=1683940939;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=yuLz9iUc1y0EzGD8AvN7Y9hf2MbqyBOWJrZZ7t76bGM=;
        b=Qm1WsHGG7Yawgtzf4UmTBwdzPBribr4bXLa944+d8dBqQyTYUQfDHQZajmMCidQnYP
         xxG5hyrsJ2DK2CdZYveJeig/i6zy/sZrjcBmabkbeSIMyEFp++itkqfydZVNXe1Xwalf
         GwmnvJaELevvy9wCBHSGrGpeZy3su2Ctk+vz0EeQ1emZnnqtL8VPrGgjv+EOD4tVAZKw
         K6KcRffpQddB4a3aHCnM2MLlY4SMpNcrxIF6I/VByUKw7OBIzoCx18lRrzYobBBdisIz
         9efZAtqGXAEit6kb/SQ9r3xk8M9yDb40noKlzK+qv9CqBfC3IYeinDiA16mzgJPo4cEZ
         MlAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681348939; x=1683940939;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yuLz9iUc1y0EzGD8AvN7Y9hf2MbqyBOWJrZZ7t76bGM=;
        b=LHeTI464stjRjhrLgobNmtCK07ZfoRDcS+78P0/1tSvFKQQ6y8yA0CH1udLSuiVlS7
         ppL+9MOMgEtMsS57Zgmxv6h650OW+Me8E05BYXpm2H+ciK0JUomb0N66Nebj/104lvnQ
         V7QLPkau8nW1mSBx+kY+ewB2Fdd3J2GYXxqGlHOs92ysTtPvwji0Im603HoVvAdVSsRf
         heKtXKKR3zkKebXp3s0k39Whz84PCXg411otIUiw4OZ/KfvAwkIj9FTff3HZJdDOC/ZF
         2fWLc8wauGpZB/2hwMtYgBcC0F7CKKI1gvqknnP080NFYTQk85ZfjV2ZISme5DDLawOu
         q8Lw==
X-Gm-Message-State: AAQBX9fKAERSlqE44QWre7mOk74ChOXarYnWsMj0oFkpChKWsCrD/wTy
        r1C1QXNM6f6eY4TatgQjn/uQl3LUkF5xxjS3DLTbrPthuBFenQ==
X-Google-Smtp-Source: AKy350ZCR0yfocrqiPD3KEzhJCl6DyZlu182JEmGvxfQAyWt9sTVsY/SoXRTXbWHu6sO0LksY8uE4weJ/1iG5eFv5RI=
X-Received: by 2002:a05:6402:22f2:b0:506:6a99:ef53 with SMTP id
 dn18-20020a05640222f200b005066a99ef53mr949787edb.2.1681348939015; Wed, 12 Apr
 2023 18:22:19 -0700 (PDT)
MIME-Version: 1.0
From:   Michael Honaker <mchonaker@gmail.com>
Date:   Wed, 12 Apr 2023 21:22:07 -0400
Message-ID: <CAAKLMZ1fM1d4Drw0D2AkEwAG9iFOyT9qboy1REWtwS6Q00BA6Q@mail.gmail.com>
Subject: cgroup: Clarification around usage_in_bytes and its relation to the
 page counter
To:     cgroups@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hello,

This is my first posting to the LKML, so please let me know if this
should be asked
elsewhere or if there is anything else wrong with my email. I'd like
to confirm my understanding on an issue
I've been encountering.

I have been trying to get an accurate measurement of memory usage of a
non-root cgroup, specifically a Kubernetes container, and noticed some
inconsistencies when comparing the
value of `memory.usage_in_bytes` with the information in
`memory.stat`. After further investigation of
the cgroup docs (/admin-guide/cgroups/memory.rst#usage_in_bytes) and
an old LMKL thread ("real meaning
of memory.usage_in_bytes"), I came to the understanding that
`usage_in_bytes` actually shows the value
of the resource counter which is an overestimation due to the counter
being split into per-cpu chunks
for caching, and that the real usage can be calculated from RSS+Cache
gathered from `memory.stat`.
I've created cadvisor issue #3286
(https://github.com/google/cadvisor/issues/3286) which goes into
greater detail on my investigation with examples.

Is the above understanding still correct with the new page counters?
If so, could any memory
allocations be reflected in `usage_in_bytes` but not in `stat` for
child cgroups? I want to ensure I'm not
missing anything by only monitoring the `stat` file.

Thank you for any clarification or corrections.
