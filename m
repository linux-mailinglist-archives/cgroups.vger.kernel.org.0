Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 699EE7C7A54
	for <lists+cgroups@lfdr.de>; Fri, 13 Oct 2023 01:20:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443081AbjJLXU4 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 12 Oct 2023 19:20:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1443053AbjJLXU4 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 12 Oct 2023 19:20:56 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81021A9;
        Thu, 12 Oct 2023 16:20:55 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id d2e1a72fcca58-694ed84c981so1227176b3a.3;
        Thu, 12 Oct 2023 16:20:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697152855; x=1697757655; darn=vger.kernel.org;
        h=content-transfer-encoding:content-disposition:mime-version
         :message-id:subject:cc:to:from:date:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GpidU1IUEyr6Ej9BBMyDiz4G7BRIDkpiKmkXFmvBZzE=;
        b=Uoj90UIbQczVJBsXgyhvo+XZCBbyDhe/rbGwsf7q3a0zmh7/1ULq6LGhq5ovLSo3pK
         //Bmq4q5XQlzjWGNxfGc9aTHUbvs8DGrvn2H/mHaCMeLVpTXnWYcfxTxsAgtz+XzKqIm
         i5kMHyjmwYQT9WNcTiCqE9T4lFTlI339jLCgs5T2kvescYLpUBvb1PbWUJYlMBdH84I3
         mi3sr8VJSyM8FCFvT2vdEwjy1JZP9ZHy3E3cleTltv3R+KegpN/j9sEwlMX0ZTupueGW
         Z86vmxSvYm0yt7PIwCe03qVUblsBMpdbOKY5gv6JHyKTITljp/c14WKDG2XSKo3z2J9A
         crTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697152855; x=1697757655;
        h=content-transfer-encoding:content-disposition:mime-version
         :message-id:subject:cc:to:from:date:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=GpidU1IUEyr6Ej9BBMyDiz4G7BRIDkpiKmkXFmvBZzE=;
        b=BFwpTNWlUsqL9MVzAmMxLorDyZXrb9QYxMDsvQZ9EY6HmLvWue7MzhWyi5WMu7MX6m
         c+aWGq96znn3LCBH9VnL51Vz9QxSX8eeGV5zuWNK526qopljaInJT8cLxRMOIgZBREjQ
         gEkPfh+i4R4/giuj6emR16P6afaFZKrW0lknNru6SZA6C9Kks8CI7tQwoVw5gu9jIkiC
         SGlNkW1b/x+m2IuHwO2Op8brSvgHJX/bnu+7HPkWGYjKQwVpmPoGTJWOsGrjVu/sP7ls
         5Yoy3vJSdLe0SrjZG0udcTUdmHBLPpRq0Z3ApsBsW0VAOwwbsUYCRATZ4Y4vN4yPl6l7
         Emmw==
X-Gm-Message-State: AOJu0Yy3GIC4MhvD1ezaGyzmEe4PTV308DX75VaQH6C5Tj/fq1kb8wr9
        /JMcSMTdExOh/Mn3DBp2EjmcB0Q5H453YQ==
X-Google-Smtp-Source: AGHT+IHjPrptHGABQfvX00jAkTWKp+VkHe1scqpGwymKTaG/OxJux37xCKfdQP53EhtcczNWnAUOCw==
X-Received: by 2002:a05:6a20:3942:b0:14b:8023:33c8 with SMTP id r2-20020a056a20394200b0014b802333c8mr27596722pzg.2.1697152854820;
        Thu, 12 Oct 2023 16:20:54 -0700 (PDT)
Received: from localhost (dhcp-72-235-13-41.hawaiiantel.net. [72.235.13.41])
        by smtp.gmail.com with ESMTPSA id c4-20020a170902724400b001c72c07c9d9sm2496035pll.308.2023.10.12.16.20.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Oct 2023 16:20:54 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Thu, 12 Oct 2023 13:20:53 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, cgroups@vger.kernel.org
Subject: [GIT PULL] Cgroup fixes for v6.6-rc5
Message-ID: <ZSh_Vf5whzHV-H1S@slm.duckdns.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

The following changes since commit 94f6f0550c625fab1f373bb86a6669b45e9748b3:

  Linux 6.6-rc5 (2023-10-08 13:49:43 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup.git/ tags/cgroup-for-6.6-rc5-fixes

for you to fetch changes up to 13cc9ee8f8ed58e563294d87d74a62006be40f21:

  cgroup: Fix incorrect css_set_rwsem reference in comment (2023-10-12 07:22:56 -1000)

----------------------------------------------------------------
cgroup: Fixes for v6.6-rc5

- In cgroup1, the `tasks` file could have duplicate pids which can trigger a
  warning in seq_file. Fix it by removing duplicate items after sorting.

- Comment update.

----------------------------------------------------------------
Michal Koutný (1):
      cgroup: Remove duplicates in cgroup v1 tasks file

Waiman Long (1):
      cgroup: Fix incorrect css_set_rwsem reference in comment

 include/linux/cgroup-defs.h | 2 +-
 kernel/cgroup/cgroup-v1.c   | 5 ++---
 2 files changed, 3 insertions(+), 4 deletions(-)

-- 
tejun
