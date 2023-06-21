Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FC3B739235
	for <lists+cgroups@lfdr.de>; Thu, 22 Jun 2023 00:06:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229682AbjFUWF6 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 21 Jun 2023 18:05:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbjFUWF5 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 21 Jun 2023 18:05:57 -0400
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com [IPv6:2607:f8b0:4864:20::d2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7B4110CE;
        Wed, 21 Jun 2023 15:05:56 -0700 (PDT)
Received: by mail-io1-xd2e.google.com with SMTP id ca18e2360f4ac-77e35128efdso172507439f.1;
        Wed, 21 Jun 2023 15:05:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687385156; x=1689977156;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=1hF4dAVFDAMGVp+Y09Z0Lab7Zc0WkcRinzpiiIGzUs8=;
        b=RZdjBlnOJEvcG/Y3K8ZI01UT3N8hTQc0Aji+3t3Grs+Dsmzfht3GhgkQlFcD8jfsam
         AisAu6MjUUbU3jpCdeVAauA08WKcAcUV7p6EFewLB2//fOPqs+/Z/YUtljoYjjIIiQAw
         +1rGGe623UT6BFJ+1a7YHmiq/aKiGjOA39T99EViEOCZFstoq4P2px4wRV+c3tz3FxUH
         0pHH8v2tqL5gCM2c2wcQginKgPGEZrSqS+dGyOrMsg8c12ZHEZOI6UBsNWtDsZshr11u
         zo17IG7VjsfNtmdng/OrwsFaXGG89YiZ8d4VwHgekk2faJbd2xRi/L7K7qQRGeN/WEEy
         o3qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687385156; x=1689977156;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1hF4dAVFDAMGVp+Y09Z0Lab7Zc0WkcRinzpiiIGzUs8=;
        b=HemjCS0tOxlYjiVYL89DD0waJqFFzlLI2DTnV/wsESd++rYxCtLwbYkggxad6+qaNT
         4a53t/NanOmPJZXn6WwfvmPWLEzLAHSoi50idoMV8e/1PQRqByYdbtGebYTjEP2MBlDn
         VCWhRW6EdZEzx3+srRW/VZjaXOUQ3iyIOAUxh7vQb38s6qLVoAUHLEUSvfaRCHAgnbqv
         JUtpobmKjT4JvK+amx/A8G59oBes/ALCclfLOOTnxPGR7tUSuvOBJnVMniDTDkQRGxUu
         SLrXCpzE/+yTFwi0W9fULFkTNpN/3soS0zWqntv6p4g1rs/OsyDisC1qfwV/G9pZyY6n
         yQDw==
X-Gm-Message-State: AC+VfDxJUcLHZxy8NIFg2GBYSJLHI0OltGYA1fxZK3lZOfMByy3umNK5
        JVPaI7WymNwtLnGcDEBknP4=
X-Google-Smtp-Source: ACHHUZ69YNtNMlokXWSO/cXDMLi+cdvtjD6xUPfPaaFUQhKdkT1i7Gbu53870ovv6kUWF9kcRY49yQ==
X-Received: by 2002:a5e:880b:0:b0:774:7a6d:8760 with SMTP id l11-20020a5e880b000000b007747a6d8760mr8205170ioj.17.1687385155964;
        Wed, 21 Jun 2023 15:05:55 -0700 (PDT)
Received: from localhost (dhcp-72-235-13-41.hawaiiantel.net. [72.235.13.41])
        by smtp.gmail.com with ESMTPSA id f7-20020a056638022700b0042880470872sm253859jaq.126.2023.06.21.15.05.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jun 2023 15:05:55 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Wed, 21 Jun 2023 12:05:53 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, cgroups@vger.kernel.org
Subject: [GIT PULL] cgroup: Fixes for v6.4-rc7
Message-ID: <ZJN0Qa--_aBSJ_K3@slm.duckdns.org>
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

The following changes since commit 5647e53f7856bb39dae781fe26aa65a699e2fc9f:

  cgroup: Documentation: Clarify usage of memory limits (2023-06-05 14:08:12 -1000)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup.git/ cgroup-for-6.4-rc7-fixes

for you to fetch changes up to 6f363f5aa845561f7ea496d8b1175e3204470486:

  cgroup: Do not corrupt task iteration when rebinding subsystem (2023-06-12 07:21:57 -1000)

----------------------------------------------------------------
cgroup: Fixes for v6.4-rc7

It's late but here are two bug fixes. Both fix problems which can be severe
but are very confined in scope. The risk to most use cases should be
minimal.

* Fix for an old bug which triggers if a cgroup subsystem is remounted to a
  different hierarchy while someone is reading its cgroup.procs/tasks file.
  The risk is pretty low given how seldom cgroup subsystems are moved across
  hierarchies.

* We moved cpus_read_lock() outside of cgroup internal locks a while ago but
  forgot to update the legacy_freezer leading to lockdep triggers. Fixed.

----------------------------------------------------------------
Tetsuo Handa (1):
      cgroup,freezer: hold cpu_hotplug_lock before freezer_mutex in freezer_css_{online,offline}()

Xiu Jianfeng (1):
      cgroup: Do not corrupt task iteration when rebinding subsystem

 kernel/cgroup/cgroup.c         | 20 +++++++++++++++++---
 kernel/cgroup/legacy_freezer.c |  8 ++++++--
 2 files changed, 23 insertions(+), 5 deletions(-)

-- 
tejun
