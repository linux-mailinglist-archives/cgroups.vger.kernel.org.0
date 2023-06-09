Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CBF8728CBF
	for <lists+cgroups@lfdr.de>; Fri,  9 Jun 2023 03:01:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229482AbjFIBBX (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 8 Jun 2023 21:01:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbjFIBBW (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 8 Jun 2023 21:01:22 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B4E81FDF;
        Thu,  8 Jun 2023 18:01:19 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id 98e67ed59e1d1-2568befcf1dso238933a91.0;
        Thu, 08 Jun 2023 18:01:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686272479; x=1688864479;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=7GcNSL4DrLjjHO/zit5UTBbLm7yHWLP5ztae1gnlGWI=;
        b=sAbLNpHAex02mYVvqOt0plUdK9fvvXTixE5yY+9UVIKnYDA4KyfHRNzYP5e51ZXjpD
         IRajIjbDtwqdwuejkKxnKBQi5WTnYesmsuuwqL7Wxz3ZNYw+t005Z7pRGnKYeAMzDUDI
         yDkUtMbboAGfgcL58wyahkFax3e1p+cqMwbfCgn0vRzT9BLmmo8fyniuvX1OUwSPgyUy
         1EhlzRhHSUJwImMdOImUMDLW2WaEqWreK2/GDZIoaN64FL/cExhsveE1joZuN+8P9V5w
         Viwzcmm7FaP0z0pKfZPWkf4lHe9ZLTx98CKiSr+D99SFflxRhpgHv5DTAgc2433ibv6+
         FjTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686272479; x=1688864479;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7GcNSL4DrLjjHO/zit5UTBbLm7yHWLP5ztae1gnlGWI=;
        b=O5Iai3dRgRz2+NnlqCTC2Et7QPzfRWcITSv3H63LWq1gQ3Q50nLrGBtpNCrwr3HsP9
         II0OTDedf5acUxB7Z6C0GNXB2NyKfFmmDVbxp2kPb1DFGoRvjMqtubtinwrtKNbeIrc6
         YfhBSkbLzhe5BlIdnUU8TSSYp0QvxqZLFLj3ZOMk0vT9HTjxDgkzvE8nG2SJ8G68akHU
         6zBfEnS604dLYE9hdlUCozIJtiD0Z5Wt5ctfPSz48WKy+yobksAd0JeXCiCxcX/qh94S
         qlSobWege5cYXqM1GlpG4E433Lt8WJ/HZziJoPP/F82CLlKtO4K+bKyb2zVQ9DMhIDwD
         rZeA==
X-Gm-Message-State: AC+VfDxyhgQXo0Zd2CO0L6JWvF05RUEa00zxq2qaSValRH2o4hfNL8hC
        MNusJMXtyT3JLn1Pr1hSA98=
X-Google-Smtp-Source: ACHHUZ6jjOlH808x2cK2fy3GrlUPPHFpDPjJG7DxzWDCWN4FKlIUvdVYp8hLGainLYut0IJwqR4VuA==
X-Received: by 2002:a17:90a:d382:b0:244:d441:8f68 with SMTP id q2-20020a17090ad38200b00244d4418f68mr4457367pju.16.1686272478352;
        Thu, 08 Jun 2023 18:01:18 -0700 (PDT)
Received: from localhost (dhcp-72-235-13-41.hawaiiantel.net. [72.235.13.41])
        by smtp.gmail.com with ESMTPSA id e6-20020a656886000000b00543ad78e3bdsm1635848pgt.16.2023.06.08.18.01.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Jun 2023 18:01:17 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Thu, 8 Jun 2023 15:01:18 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, cgroups@vger.kernel.org
Subject: [GIT PULL] cgroup fixes for v6.4-rc5
Message-ID: <ZIJ53jQAPxEXF-iu@slm.duckdns.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
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

The following changes since commit 44c026a73be8038f03dbdeef028b642880cf1511:

  Linux 6.4-rc3 (2023-05-21 14:05:48 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup.git/ tags/cgroup-for-6.4-rc5-fixes

for you to fetch changes up to 5647e53f7856bb39dae781fe26aa65a699e2fc9f:

  cgroup: Documentation: Clarify usage of memory limits (2023-06-05 14:08:12 -1000)

----------------------------------------------------------------
cgroup: Fixes for v6.4-rc5

* Fix css_set reference leaks on fork failures.

* Fix CPU hotplug locking in cgroup_transfer_tasks() which is used by
  cgroup1 cpuset.

* Doc update.

----------------------------------------------------------------
Dan Schatzberg (1):
      cgroup: Documentation: Clarify usage of memory limits

John Sperbeck (1):
      cgroup: always put cset in cgroup_css_set_put_fork

Qi Zheng (1):
      cgroup: fix missing cpus_read_{lock,unlock}() in cgroup_transfer_tasks()

 Documentation/admin-guide/cgroup-v2.rst | 22 ++++++++++------------
 kernel/cgroup/cgroup-v1.c               |  4 ++--
 kernel/cgroup/cgroup.c                  | 17 ++++++++---------
 3 files changed, 20 insertions(+), 23 deletions(-)
