Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 811592D4C45
	for <lists+cgroups@lfdr.de>; Wed,  9 Dec 2020 21:56:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731549AbgLIUzG (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 9 Dec 2020 15:55:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729783AbgLIUzF (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 9 Dec 2020 15:55:05 -0500
Received: from mail-qk1-x74a.google.com (mail-qk1-x74a.google.com [IPv6:2607:f8b0:4864:20::74a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E530C061794
        for <cgroups@vger.kernel.org>; Wed,  9 Dec 2020 12:54:25 -0800 (PST)
Received: by mail-qk1-x74a.google.com with SMTP id g5so1809252qke.22
        for <cgroups@vger.kernel.org>; Wed, 09 Dec 2020 12:54:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:to:cc;
        bh=eyAf9tPh5kwa3NPR7RusvbbsQzwJzLjle+w/qgwIjD0=;
        b=Xh+cDnP4DoT5owh0/0HIm4Z8CAhhPYD263reDQNel9C7pyR9gOBxcvWO1X4IndEzBo
         7qit/pbm/xw+nUhXMQHMHo4ZOSnJURBK6g4JlEQGbr9TaCusAVM7X9Vfa0z/dW5DpIBI
         rqMBWuvl00va7X5MtLz55B492M6+6mfoJ9Uk2Fi+pHbJskFwKGDDup9dcxmjXNO/LKVA
         Rh03vIm2GpQtTy9xl6oJJ2JuYoFUe1sdme9kePmiHMD8hAAxZqjYYZUw2qS4/eUfb3Wv
         pulYP0O+TmrLVyxcMzc6hGb24eBry7Icr/iCipBtYKBepUWMk7/TWkK7kFIar6lVMn3x
         zrEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :to:cc;
        bh=eyAf9tPh5kwa3NPR7RusvbbsQzwJzLjle+w/qgwIjD0=;
        b=oe0iJYRqkIqMcm0MhZpgIiFNnLliXdJnWcOjHGBKRaDmXOmC9XX275kYuGc+9wQ+/Y
         8d5mlZlXdW0N+p900SJ5qD7/QeJe7xQbWAS2RNOola/AkkYriVwC949VcF6S5FeZLHvs
         97xDIulFP/f7ywDgsQiX8KHlsPuthX4Tizt5xcNxEV6V1EoTv5s2tEKdeQGy9TuIeIxW
         CejTiAQRFvHQcW0bHzE0K5OUWgcX0nkxfHHkyOBw43hm5CX4AOciUJLTP9ZL0s9lPqwA
         lMYr0IOKjBA87gy+axZRP9c7iYCERY8rfJBFyp+Jss6aaYjqBTuoUGUsi+9ZlEiySqXs
         qZPg==
X-Gm-Message-State: AOAM531+Qpbw6zoNa1iGUnwGQ3vAnHzv8HcvDBtpmX4TpP5KUGfcjg49
        Eb0YE/4azjFR69uRrLTl4OS6YHWTXz5F
X-Google-Smtp-Source: ABdhPJyHiL9v7qyrY0Ac/3Fc8Zm/BX/g/QvBraZOuqkew4GB+ozMmGKuR5pYDHMyzGr7COsym2qO6fKRCDvy
Sender: "vipinsh via sendgmr" <vipinsh@vipinsh.kir.corp.google.com>
X-Received: from vipinsh.kir.corp.google.com ([2620:0:1008:10:1ea0:b8ff:fe75:b885])
 (user=vipinsh job=sendgmr) by 2002:a0c:f74a:: with SMTP id
 e10mr731582qvo.47.1607547264628; Wed, 09 Dec 2020 12:54:24 -0800 (PST)
Date:   Wed,  9 Dec 2020 12:54:11 -0800
Message-Id: <20201209205413.3391139-1-vipinsh@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.29.2.576.ga3fc446d84-goog
Subject: [Patch v3 0/2] cgroup: KVM: New Encryption IDs cgroup controller
From:   Vipin Sharma <vipinsh@google.com>
To:     thomas.lendacky@amd.com, brijesh.singh@amd.com, jon.grimm@amd.com,
        eric.vantassell@amd.com, pbonzini@redhat.com, seanjc@google.com,
        tj@kernel.org, lizefan@huawei.com, hannes@cmpxchg.org,
        frankja@linux.ibm.com, borntraeger@de.ibm.com, corbet@lwn.net
Cc:     joro@8bytes.org, vkuznets@redhat.com, wanpengli@tencent.com,
        jmattson@google.com, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, hpa@zytor.com, gingell@google.com,
        rientjes@google.com, dionnaglaze@google.com, kvm@vger.kernel.org,
        x86@kernel.org, cgroups@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Vipin Sharma <vipinsh@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hello,

This patch adds a new cgroup controller, Encryption IDs, to track and
limit the usage of encryption IDs on a host.

AMD provides Secure Encrypted Virtualization (SEV) and SEV with
Encrypted State (SEV-ES) to encrypt the guest OS's memory using limited
number of Address Space Identifiers (ASIDs).

This limited number of ASIDs creates issues like SEV ASID starvation and
unoptimized scheduling in the cloud infrastucture.

In the RFC patch v1, I provided only SEV cgroup controller but based
on the feedback and discussion it became clear that this cgroup
controller can be extended to be used by Intel's Trusted Domain
Extension (TDX) and s390's protected virtualization Secure Execution IDs
(SEID)

This patch series provides a generic Encryption IDs controller with
tracking support of the SEV ASIDs.

Changes in v3:
- Fixes a build error when CONFIG_CGROUP is disabled.

Changes in v2:
- Changed cgroup name from sev to encryption_ids.
- Replaced SEV specific names in APIs and documentations with generic
  encryption IDs.
- Providing 3 cgroup files per encryption ID type. For example in SEV,
  - encryption_ids.sev.stat (only in the root cgroup directory).
  - encryption_ids.sev.max
  - encryption_ids.sev.current

Thanks
Vipin Sharma

[1] https://lore.kernel.org/lkml/20200922004024.3699923-1-vipinsh@google.com/#r
[2] https://lore.kernel.org/lkml/20201208213531.2626955-1-vipinsh@google.com/

 .../admin-guide/cgroup-v1/encryption_ids.rst  | 108 +++++
 Documentation/admin-guide/cgroup-v2.rst       |  78 +++-
 arch/x86/kvm/svm/sev.c                        |  28 +-
 include/linux/cgroup_subsys.h                 |   4 +
 include/linux/encryption_ids_cgroup.h         |  71 +++
 include/linux/kvm_host.h                      |   4 +
 init/Kconfig                                  |  14 +
 kernel/cgroup/Makefile                        |   1 +
 kernel/cgroup/encryption_ids.c                | 430 ++++++++++++++++++
 9 files changed, 729 insertions(+), 9 deletions(-)
 create mode 100644 Documentation/admin-guide/cgroup-v1/encryption_ids.rst
 create mode 100644 include/linux/encryption_ids_cgroup.h
 create mode 100644 kernel/cgroup/encryption_ids.c

-- 
2.29.2.576.ga3fc446d84-goog

