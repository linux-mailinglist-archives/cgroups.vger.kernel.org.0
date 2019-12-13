Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B495F11EB13
	for <lists+cgroups@lfdr.de>; Fri, 13 Dec 2019 20:22:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728455AbfLMTWI (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 13 Dec 2019 14:22:08 -0500
Received: from mail-qk1-f196.google.com ([209.85.222.196]:36212 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728800AbfLMTWH (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 13 Dec 2019 14:22:07 -0500
Received: by mail-qk1-f196.google.com with SMTP id a203so137929qkc.3
        for <cgroups@vger.kernel.org>; Fri, 13 Dec 2019 11:22:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Md8aPp7pWyGuw5IIpUNdRQgPAvuPZuMepp2Ahz2Nx4M=;
        b=wgSZLGRUOXwzFB4dfBnzTeSU23C7S7RRsjtSNusnCzXmKwnqrtYtHchbbxHW6dqapq
         MjghPETHNvKrpaC4P42jqcAt5wpcqzU0OADzTYo1e7xY99FcQTby3wlOrGvEBtpkc3L2
         6G0T1SS8d+6LQjg38Y2yKe6cLvZylqzSJ+aEhVQjCpBshBp3/jeI6QsuKw3DcOyxqTBC
         MsKge1RHa22f8HtCjtNI02qMb+YOCDmCOgVfeMTTv/2eA/4D6h9d1lEZPJxI6dUoIiQa
         sp8jbhVfvh+id58flVOEQZM5L+C5XnCBhhgjSG85RPGD9hI6Pm1nbl37bI40mNck5b3M
         gQpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Md8aPp7pWyGuw5IIpUNdRQgPAvuPZuMepp2Ahz2Nx4M=;
        b=FOaCc1EEzaTzdZXNpaHQr25QNpt+S2h5emH5k/e86rFgPfNlvDUyzstWYCAPjvcymc
         irJQfzW84bNbrIN2GxaFpo15TF1YbiZP9FV5j7WRAQJiQmE+eYOI5mTHizbO8rZn+Smk
         0UJMI7JL3e0k1ViKuAz9fDOmpUqWqGQUBEiscDQFUHexJH0pm/OEkXqs/ueFeLn/+TgN
         z35Q0pKbf+N3gLL6s1Rj8r/9eACtDgTEt0OhAasxs98M2j99Ow+10MY4GgE1cFic/QAX
         bUpWNGZHaR9vPQx0+ImjsIrsm5lOmPw46ZZZMb9m0TfiRBolBY05PDBzxtZT7GdQojeq
         khOQ==
X-Gm-Message-State: APjAAAUBqRYuT/nTPaXuzklchMq+AA/0DIJKpFmMSGeCi2E5lkMwGDR4
        AZav+4/oODHnjzSYpyskNuGVaw==
X-Google-Smtp-Source: APXvYqw3FXp7YEWHaxT92Q3RIcSBkI/2b737GDnuzflnKDpEga0bi1FPxsejP17D7pOITWtyao4ogA==
X-Received: by 2002:ae9:c112:: with SMTP id z18mr6555577qki.145.1576264926538;
        Fri, 13 Dec 2019 11:22:06 -0800 (PST)
Received: from localhost (70.44.39.90.res-cmts.bus.ptd.net. [70.44.39.90])
        by smtp.gmail.com with ESMTPSA id c37sm3735674qta.56.2019.12.13.11.22.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Dec 2019 11:22:05 -0800 (PST)
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Michal Hocko <mhocko@suse.com>, Roman Gushchin <guro@fb.com>,
        Tejun Heo <tj@kernel.org>, linux-mm@kvack.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com
Subject: [PATCH 0/3] mm: memcontrol: recursive memory protection
Date:   Fri, 13 Dec 2019 14:21:55 -0500
Message-Id: <20191213192158.188939-1-hannes@cmpxchg.org>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

The current memory.low (and memory.min) semantics require protection
to be assigned to a cgroup in an untinterrupted chain from the
top-level cgroup all the way to the leaf.

In practice, we want to protect entire cgroup subtrees from each other
(system management software vs. workload), but we would like the VM to
balance memory optimally *within* each subtree, without having to make
explicit weight allocations among individual components. The current
semantics make that impossible.

This patch series extends memory.low/min such that the knobs apply
recursively to the entire subtree. Users can still assign explicit
protection to subgroups, but if they don't, the protection set by the
parent cgroup will be distributed dynamically such that children
compete freely - as if no memory control were enabled inside the
subtree - but enjoy protection from neighboring trees.

Patch #1 fixes an existing bug that can give a cgroup tree more
protection than it should receive as per ancestor configuration.

Patch #2 simplifies and documents the existing code to make it easier
to reason about the changes in the next patch.

Patch #3 finally implements recursive memory protection semantics.

Because of a risk of regressing legacy setups, the new semantics are
hidden behind a cgroup2 mount option, 'memory_recursiveprot'.

More details in patch #3.

 Documentation/admin-guide/cgroup-v2.rst |  11 ++
 include/linux/cgroup-defs.h             |   5 +
 kernel/cgroup/cgroup.c                  |  17 ++-
 mm/memcontrol.c                         | 241 +++++++++++++++++++-----------
 mm/page_counter.c                       |  12 +-
 5 files changed, 190 insertions(+), 96 deletions(-)


