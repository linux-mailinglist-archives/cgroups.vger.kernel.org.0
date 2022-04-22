Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F43D50BEDC
	for <lists+cgroups@lfdr.de>; Fri, 22 Apr 2022 19:37:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234960AbiDVRkN (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 22 Apr 2022 13:40:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234465AbiDVRkJ (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 22 Apr 2022 13:40:09 -0400
Received: from mail-qv1-xf31.google.com (mail-qv1-xf31.google.com [IPv6:2607:f8b0:4864:20::f31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77478102CC9;
        Fri, 22 Apr 2022 10:37:02 -0700 (PDT)
Received: by mail-qv1-xf31.google.com with SMTP id h13so6562298qvr.2;
        Fri, 22 Apr 2022 10:37:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=DKU0THvM0AAAFGGde2aNgjFZG6FZ7ssd+fvUj/DwIMQ=;
        b=K/BgixKTR8mxCxTSf6PZRZY9qenBEsBPrOrWTMFnU+GRM4Kq/kQT8CO0QaqLcfj7AA
         jSPYbqjomYA2ted96LqLA+nrUMxR3OGR6WZg/8+SQTJKrWeeZv2G9bduWEOATGgJuJYv
         WDgBe1r3RNL3eyrLJipiRM8ffvQqwQIcnverABfRYsJoDN/7z8erz3AqhfeKYuOs5JkX
         0i4OwsTOaqZND5hu9YGu9fB81yLkpxrtbI2uZSIWX8UfzS8CRD0DYgVKoFBdc5TlR9o2
         aqEIrdQBdW+z/97wz5Iz+JOoM/JWpXxrpKbXjE1men6OT/QDTknUi6rIPDVowOAdD694
         cv4A==
X-Gm-Message-State: AOAM532WyXNrlIgbtqKyP81CkMLTOVDadDpfP+qBHVwgDVtpvUdUdmXN
        p4BDD3jSdo1RpCzkW2/5tzY=
X-Google-Smtp-Source: ABdhPJxNy4+0HCpQRUWo/jNoyyub36xXtrCmqyxpPG5Ks8+6SAp8VM90KgNA+xFHSW5EGC6WIsVJ5Q==
X-Received: by 2002:a05:6214:252e:b0:456:1c4e:bbee with SMTP id gg14-20020a056214252e00b004561c4ebbeemr25093qvb.70.1650648858370;
        Fri, 22 Apr 2022 10:34:18 -0700 (PDT)
Received: from localhost (fwdproxy-ash-010.fbsv.net. [2a03:2880:20ff:a::face:b00c])
        by smtp.gmail.com with ESMTPSA id m139-20020a37a391000000b0069e88edfdacsm1188051qke.105.2022.04.22.10.34.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Apr 2022 10:34:18 -0700 (PDT)
From:   David Vernet <void@manifault.com>
To:     tj@kernel.org, lizefan.x@bytedance.com, hannes@cmpxchg.org
Cc:     cgroups@vger.kernel.org, peterz@infradead.org, mingo@redhat.com,
        linux-kernel@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 0/4] cgroup: Introduce cpu controller test suite
Date:   Fri, 22 Apr 2022 10:33:47 -0700
Message-Id: <20220422173349.3394844-1-void@manifault.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

This patchset introduces a new test_cpu.c test suite as part of
tools/testing/selftests/cgroup. test_cpu.c will contain testcases that
validate the cgroup v2 cpu controller.

This patchset only contains testcases that validate cpu.stat and
cpu.weight, but I'm expecting to send further patchsets after this that
also include testcases that validate other knobs such as cpu.max.

Note that checkpatch complains about a missing MAINTAINERS file entry for
[PATCH 1/4], but Roman Gushchin added that entry in a separate patchset:
https://lore.kernel.org/all/20220415000133.3955987-4-roman.gushchin@linux.dev/.

Changelog:
v2:
  - s/cgcpu/cpucg for variable names and test names.
  - Pass struct timespec as part of struct cpu_hog_func_param rather than
    stuffing the whole time as nanoseconds in a single long.

David Vernet (4):
  cgroup: Add new test_cpu.c test suite in cgroup selftests
  cgroup: Add test_cpucg_stats() testcase to cgroup cpu selftests
  cgroup: Add test_cpucg_weight_overprovisioned() testcase
  cgroup: Add test_cpucg_weight_underprovisioned() testcase

 tools/testing/selftests/cgroup/.gitignore    |   1 +
 tools/testing/selftests/cgroup/Makefile      |   2 +
 tools/testing/selftests/cgroup/cgroup_util.c |  12 +
 tools/testing/selftests/cgroup/cgroup_util.h |   4 +
 tools/testing/selftests/cgroup/test_cpu.c    | 446 +++++++++++++++++++
 5 files changed, 465 insertions(+)
 create mode 100644 tools/testing/selftests/cgroup/test_cpu.c

-- 
2.30.2

