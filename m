Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B589F353880
	for <lists+cgroups@lfdr.de>; Sun,  4 Apr 2021 16:52:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229902AbhDDOwH (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Sun, 4 Apr 2021 10:52:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229788AbhDDOwH (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Sun, 4 Apr 2021 10:52:07 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5B12C061756
        for <cgroups@vger.kernel.org>; Sun,  4 Apr 2021 07:52:01 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id t20so4528931plr.13
        for <cgroups@vger.kernel.org>; Sun, 04 Apr 2021 07:52:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=H5jofbm8j2utH1mZKQBvpAx1voU9P5mgvMVABgwERu0=;
        b=KR8OK7X6eJDauTOYhwmJ2tn8j1RG2NJcqskR+M0/kuHa32tVrtgS8/HMJyMo0FBsz/
         EscfbrHoFM8ckHPBDAV1lHbLH45VXMYe2Kx1AAcCk1BUDb+DhZ+SWfexD5Q9uajJ9lLD
         FI0fCUbRImM+UIEv15Iaw3hvxuksXBEDNTuSsByiyP7+9VA8Wjem3FiFkK+Ouj19JK/Q
         m+NSOXNUk5xBdYYECSMg7qqE5ZzaCkEs9LGqiCMBcPvfYvTv/MkzTRMSuwyn8jTRMh2G
         AXbsqeJaXF+jS0ot0i+pAMNx9Rw43aIvfkw4NIU3OUI3icBRHYETej1ySap1eONzuLZp
         9jMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=H5jofbm8j2utH1mZKQBvpAx1voU9P5mgvMVABgwERu0=;
        b=XTg1Qe704LtG+NYq9wBkVPvx5umNdvvaNabQo+s7/liiA6CA/P1/ja7xcRFrj+bQAJ
         jdOlz7qE96HsO27PMHYuq0lCjcYEaBBKhtNmea2QHgjaIU+tLjWci2wVn6vPZqmTk05n
         qNZdBQToLqELCa0BqMXM0hyyIkFHEA1uPVv4NH5wQBccedkqaE6dN7X/6z+/TrgWYe67
         0R1533M1qUQ45lxy+4hlfUQlaM38ws/B8s9XzmO658XrxLiTLqF5H/AHvfwEAJ1SFn3s
         JtJgeYcBZvukCCSZIaUYP8O2jXXUbUhyTIqxkC0EEBCDfTA7ddRWIJu78Tdng/ZAXQCr
         2SBA==
X-Gm-Message-State: AOAM533IyMXQBawFYedIjGFC7U5RyMFKJae4WP5MakKefqwnMb2dDXPU
        cl/LIy0jSAZtCMTynQvKoB4=
X-Google-Smtp-Source: ABdhPJxZ+f31ymk71Q9UoFRoq072eg5c7yd1cEG8dHvZ+hW1B6dfxTny5nGj7f4LaV1/dj/+6PL3Rw==
X-Received: by 2002:a17:902:ce86:b029:e6:b1f6:3c5c with SMTP id f6-20020a170902ce86b02900e6b1f63c5cmr20738165plg.13.1617547921246;
        Sun, 04 Apr 2021 07:52:01 -0700 (PDT)
Received: from localhost.localdomain ([203.205.141.39])
        by smtp.gmail.com with ESMTPSA id d2sm12723208pgp.47.2021.04.04.07.51.58
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 04 Apr 2021 07:52:00 -0700 (PDT)
From:   yulei.kernel@gmail.com
X-Google-Original-From: yuleixzhang@tencent.com
To:     tj@kernel.org, lizefan.x@bytedance.com, hannes@cmpxchg.org,
        christian@brauner.io
Cc:     cgroups@vger.kernel.org, benbjiang@tencent.com,
        kernellwp@gmail.com, lihaiwei.kernel@gmail.com,
        linussli@tencent.com, herberthbli@tencent.com,
        lennychen@tencent.com, allanyuliu@tencent.com,
        Yulei Zhang <yuleixzhang@tencent.com>
Subject: [RFC 0/1] Introduce new attribute "priority" to control group
Date:   Sun,  4 Apr 2021 22:51:53 +0800
Message-Id: <cover.1617355387.git.yuleixzhang@tencent.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

From: Yulei Zhang <yuleixzhang@tencent.com>

This patch is the init patch of a series which we want to present the idea
of prioritized tasks management. As the cloud computing introduces intricate
configurations to provide customized infrasturctures and friendly user
experiences, in order to maximum utilization of sources and improve the
efficiency of arrangement, we add the new attribute "priority" to control
group, which could be used as graded factor by subssystems to manipulate
the behaviors of processes.

Base on the order of priority, we could apply different resource configuration
strategies, sometimes it will be more accuracy instead of fine tuning in each
subsystem. And of course to set fundamental rules, for example, high priority
cgroups could seize the resource from cgroups with lower priority all the time.

The default value of "priority" is set to 0 which means the highest
priority, and the totally levels of priority is defined by
CGROUP_PRIORITY_MAX. Each subsystem could register callback to receive the
priority change notification for their own purposes. 

We would like to send out the corresponding features in the coming weeks,
which are relaying on the priority settings. For example, the prioritized
oom, memory reclaiming and cpu schedule strategy.

Lei Chen (1):
  cgroup: add support for cgroup priority

 include/linux/cgroup-defs.h |  2 +
 include/linux/cgroup.h      |  2 +
 kernel/cgroup/cgroup.c      | 90 +++++++++++++++++++++++++++++++++++++
 3 files changed, 94 insertions(+)

-- 
2.28.0

