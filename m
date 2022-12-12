Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E4CC6498EC
	for <lists+cgroups@lfdr.de>; Mon, 12 Dec 2022 07:22:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231264AbiLLGWV (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 12 Dec 2022 01:22:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229726AbiLLGWS (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 12 Dec 2022 01:22:18 -0500
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A99EBB1FC;
        Sun, 11 Dec 2022 22:22:17 -0800 (PST)
Received: by mail-pj1-x1034.google.com with SMTP id u15-20020a17090a3fcf00b002191825cf02so11085014pjm.2;
        Sun, 11 Dec 2022 22:22:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=HCii+srz2iaNbP8AXqiOvVaT1PGofZlpv2hPExSpMSA=;
        b=ipIM1jnyyvBEgUwCO1zi9dfHJYO5Xbl/UnjywWopciH/0/URRDOxmphlBjQitN8NEI
         qwFyxECCcFvdCQlK5fqS0+QLWYNBAQSdhCKK1H5CrmnhtYfVKcHvPE+D9xwrCrjnH59Z
         iBTLNsQCz28I+w8Nz/MeNAj0PdP1FCPTbhqCLqYwXsaYo8q0BP6Z0PC8kIlcgz7GdzS4
         4WbGZCJ/hZRSoE/RoovaSLkcSnPjXvLFJGrAAKkoZOCOhk/SzBysY/jRMPoLQLNpZX7Z
         dNBfuT75CLsj8KbqudFcBfFZls8c+/5tiA55z0SCf/vhQVtlRbWt3Ch5zCYIV7vZONP9
         eJyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HCii+srz2iaNbP8AXqiOvVaT1PGofZlpv2hPExSpMSA=;
        b=qaNODE46lCeH6+QeaxdZ0kpxsbwCHhfCp0Kl4tlNvuoeCJovgfsqP97PF83XYCrpP3
         /1cdMiDvSTZ0f8PISIPaXQW1Y8WJBQ1nem0VBKcpQzFezmh+GKhtSv+wv1qhvcYTZARf
         l0RmYrnnDMtdW0ZzgYj6iO31ToRQHvS7GSFpqLGe8a+JnXSkqvGqAhI9CnfcAiJswC+9
         3H+OF58R/PN0twWh/UjQlElRbLPwTkIS4lJOb5OvkHzrPT4i74yY8NnE9SnQXC16kWi8
         m+Xy61vXF+0bUOsX+CtF/MTr8nmAMvon4vVSWHZcgDAJBzsLAmjSKa+cyd2TAhY1M8Ix
         f9lQ==
X-Gm-Message-State: ANoB5pmMWsircMOLOIj9TLShWtS2SbwuGELGl8sVDkPUxrh696XJ8zdj
        Al/o1TvTjnRn+06s6AZamRAoOAirCEiE8Q==
X-Google-Smtp-Source: AA0mqf6cGl0DnxKB15HGOwU+aV8FOE4WlWGsgHo/HLwrP7DbmRK0Cv57Fenhkvpu7h92T/3bp/aBzA==
X-Received: by 2002:a05:6a20:d398:b0:9d:efbf:6621 with SMTP id iq24-20020a056a20d39800b0009defbf6621mr19837485pzb.47.1670826136973;
        Sun, 11 Dec 2022 22:22:16 -0800 (PST)
Received: from localhost ([2620:10d:c090:400::5:9159])
        by smtp.gmail.com with ESMTPSA id u82-20020a627955000000b00571cdbd0771sm4946021pfc.102.2022.12.11.22.22.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Dec 2022 22:22:15 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Sun, 11 Dec 2022 20:22:14 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, cgroups@vger.kernel.org
Subject: [GIT PULL] cgroup changes for v6.2-rc1
Message-ID: <Y5bIlstHSdB7FOID@slm.duckdns.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

The following changes since commit 79a818b5087393d5a4cb356d4545d02f55bf1a2f:

  blkcg: Update MAINTAINERS entry (2022-10-17 09:27:18 -1000)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup.git/ tags/cgroup-for-6.2

for you to fetch changes up to 674b745e22b3caae48ad20422795eefd3f832a7b:

  cgroup: remove rcu_read_lock()/rcu_read_unlock() in critical section of spin_lock_irq() (2022-11-23 07:16:38 -1000)

----------------------------------------------------------------
cgroup changes for v6.2-rc1

Nothing too interesting.

* Add CONFIG_DEBUG_GROUP_REF which makes cgroup refcnt operations kprobable.

* A couple cpuset optimizations.

* Other misc changes including doc and test updates.

----------------------------------------------------------------
Breno Leitao (1):
      kselftest/cgroup: Fix gathering number of CPUs

Kamalesh Babulal (2):
      kselftest/cgroup: Add cleanup() to test_cpuset_prs.sh
      cgroup/cpuset: Improve cpuset_css_alloc() description

Ran Tian (1):
      cgroup: remove rcu_read_lock()/rcu_read_unlock() in critical section of spin_lock_irq()

Tejun Heo (2):
      cgroup: Implement DEBUG_CGROUP_REF
      cgroup: cgroup refcnt functions should be exported when CONFIG_DEBUG_CGROUP_REF

Waiman Long (2):
      cgroup/cpuset: Skip spread flags update on v2
      cgroup/cpuset: Optimize cpuset_attach() on v2

 include/linux/cgroup.h                            | 98 +++--------------------
 include/linux/cgroup_refcnt.h                     | 96 ++++++++++++++++++++++
 kernel/cgroup/cgroup.c                            |  8 +-
 kernel/cgroup/cpuset.c                            | 48 ++++++++---
 lib/Kconfig.debug                                 | 10 +++
 tools/testing/selftests/cgroup/test_cpuset_prs.sh | 19 ++++-
 6 files changed, 181 insertions(+), 98 deletions(-)
 create mode 100644 include/linux/cgroup_refcnt.h

-- 
tejun
