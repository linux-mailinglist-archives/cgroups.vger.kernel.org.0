Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A4E0618731E
	for <lists+cgroups@lfdr.de>; Mon, 16 Mar 2020 20:13:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732433AbgCPTNq (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 16 Mar 2020 15:13:46 -0400
Received: from mail-qv1-f65.google.com ([209.85.219.65]:45993 "EHLO
        mail-qv1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732298AbgCPTNo (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 16 Mar 2020 15:13:44 -0400
Received: by mail-qv1-f65.google.com with SMTP id h20so5578656qvr.12
        for <cgroups@vger.kernel.org>; Mon, 16 Mar 2020 12:13:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hQ6KfYR9gsZkcfMfYyRVmhCMb80+DstZqdWe5a9vHYQ=;
        b=msdHOOStVPMDS4Mqi0Uw5qYY3xmOx/awlB/N7lszPYI/CkuBwbE2ctj8Cktbsgy/M/
         YhyH+WEXvueDCguQlgjMpZTsrtXUqpZzT4q9I74W0tplZSCZpgZDs5KsIkXdKGwjmhJ3
         WBjoWnH+yLuK/luBrjtZbREo1xGzazEEcK0iuQDrplBar6wkYUFAG5Ry1haIEijIC8G8
         uQGuyulp7IRd8+TMJuwRTO1exTFxEKvHkEyMq5aUs7EPp7zLQo47w7g9vtfod0B5YRBR
         X7M1JBEWs1VgBIR7abel2WyB1OUeuApmBML954516LCrA2QGW1K0r67VmqHE6dz4uglp
         lOJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hQ6KfYR9gsZkcfMfYyRVmhCMb80+DstZqdWe5a9vHYQ=;
        b=fVuxt/DiWwMoQH6QGKXv8ZwGVIUR0ejo5ZIZTtkGhNP3xju7+EaEC0AM+VPis4+U4a
         uU6xfDTxVt24r4PQr8ESy9ne/X9d18mAuk9D+o7+M/2nDr8VAuLcKRdkA18vWRz+363u
         I3FrpI60EVjm/gCSVhk09uN+dWk42O7LoDk3MCoP/3YxGkAh0tA1FbA5PNp71AOtrQX2
         cVcP6YXLZXogppkOkMrZRCRWfsuOmck4n1ujxfhhbLoJ714i24tpskF2fWjPaa6KY6rP
         m0VVtJj/xLVkZrpS293Dwpi/YSKa5fJDDr18AzVgYBtRbSgxQ71ZG5lGwMt6XMBKO1aO
         KKqw==
X-Gm-Message-State: ANhLgQ0AxolSNX6ZrAH/WSNHDFRgYpc0+LI2m/W93kT1kizAbXWOBN0D
        mqbjjSaw0ssjZA4MupY6wbITWw==
X-Google-Smtp-Source: ADFU+vsu45fsRLuBxs5DFRHzUrtDy2+HKc9VZM37d00UZjgBQcoCmiVnyeQgskRuo+XwcMhK0wwgbg==
X-Received: by 2002:a0c:edc5:: with SMTP id i5mr1350832qvr.16.1584386022960;
        Mon, 16 Mar 2020 12:13:42 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::1:f40d])
        by smtp.gmail.com with ESMTPSA id v187sm43025qkc.29.2020.03.16.12.13.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Mar 2020 12:13:42 -0700 (PDT)
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com
Subject: [PATCH 0/3] psi: cpu.pressure cgroup fix & MAINTAINERS update
Date:   Mon, 16 Mar 2020 15:13:30 -0400
Message-Id: <20200316191333.115523-1-hannes@cmpxchg.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hello Peter,

Patch 1 implements the cpu.pressure fix for cgroups we were looking at
recently, 2 is the cgroup hierarchy walk optimization you proposed.

Patch 3 adds a MAINTAINER entry for psi, as at least one person tried
looking for it and couldn't find it.

If they look alright to you, it'd be great to get them into 5.7.

Based on 5.6-rc6.

Thanks

 MAINTAINERS               |  6 +++
 include/linux/psi.h       |  2 +
 include/linux/psi_types.h | 10 ++++-
 kernel/sched/core.c       |  2 +
 kernel/sched/psi.c        | 99 +++++++++++++++++++++++++++++++++------------
 kernel/sched/stats.h      | 21 ++++++++++
 6 files changed, 114 insertions(+), 26 deletions(-)


