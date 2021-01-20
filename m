Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 31B032FC5B3
	for <lists+cgroups@lfdr.de>; Wed, 20 Jan 2021 01:24:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726594AbhATAVs (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 19 Jan 2021 19:21:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727819AbhATATN (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 19 Jan 2021 19:19:13 -0500
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F551C061575;
        Tue, 19 Jan 2021 16:18:29 -0800 (PST)
Received: by mail-pl1-x633.google.com with SMTP id s15so11511443plr.9;
        Tue, 19 Jan 2021 16:18:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=FQMMF/2jUk+oPAGJT0QPqCY9ZpMVcAq7Q7ndO7jDZtc=;
        b=A/KxEfurUyp8y+7s9StUSf3ir/9EoE/2c4lS5n1+IITvoJo8b3yTx+DDVUl6vNOf04
         36Myvm6/6LlI6Vb9lZmtuzvRetaNBXglRY5umGTeuDe9iJwS1DAabFbaIgfSOz8+TUM3
         MwNUWV5h1Mg4kc0TvYoM8CZylV81Qm5ps2dLqoHkLY8slD8KuYPTbX+5RB4iaP6rZscV
         M/UyrBBwSYeMmuPJfgH1P7qxJRWUHapuWJvtKtqt220WdzJ4CMNDhsBnUYX/w6XlAHeZ
         CXCpSVXyhDjAKtgKrR2JkPL/Sg8WRABGtc2OWiON/xRKfWwo9kNG7QZkDYHwS9AYLJOn
         LGcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=FQMMF/2jUk+oPAGJT0QPqCY9ZpMVcAq7Q7ndO7jDZtc=;
        b=NIKgiAAbUku6ZUQrHx3BDVvIuVA8EBU8qe3WS5GFDmoPBs4DBg6q8OZwmtA8Ey1N+U
         BRiZV8wneInta+68qfsFWegGb4Cn5z4fsIom0JQqA3L8kU/GXmqUlncOvCvLFOS464qq
         95gJCuQleX6JPdfN4I1kjyK5aT2VQGJU/x6GWndr5SO3cvHRPiJVJ9rdpeIINv5E7eB5
         oY4mRBL3rmuiE6tYZ8agl7VkO72Tv1bS8yXayIjVbzEDTA1CIT2662XDt2XmH1bn0FOv
         79QKXu8RUE6rL2eKkBXhd0bd/GTxbSUJiTeDMQ7Tjsyj0Q+9eHoDbRffbI5tZNKS2MsX
         D1Lg==
X-Gm-Message-State: AOAM530RBfzn+JN0w+2IqaXPMt6x9OyZRG2hSd/O+ZnEZ4mqHI90AbxM
        FrWQ52LHv5u5m71L13bC9djOeud+M1lCSg==
X-Google-Smtp-Source: ABdhPJwcUqTK3hFUvP6JMosjoOfZTAE2ZIgww53VBjFm5h/zKHH2xrQsFoUNtQYvO6xMtdsRV94Pdg==
X-Received: by 2002:a17:90a:f988:: with SMTP id cq8mr2446968pjb.71.1611101907979;
        Tue, 19 Jan 2021 16:18:27 -0800 (PST)
Received: from kir-rhat.lan (c-76-104-243-248.hsd1.wa.comcast.net. [76.104.243.248])
        by smtp.gmail.com with ESMTPSA id y6sm227452pfn.123.2021.01.19.16.18.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Jan 2021 16:18:27 -0800 (PST)
From:   Kir Kolyshkin <kolyshkin@gmail.com>
To:     corbet@lwn.net
Cc:     linux-doc@vger.kernel.org, cgroups@vger.kernel.org,
        Kir Kolyshkin <kolyshkin@gmail.com>
Subject: [PATCH 00/10] docs: cgroup nits and fixes
Date:   Tue, 19 Jan 2021 16:18:14 -0800
Message-Id: <20210120001824.385168-1-kolyshkin@gmail.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

These are mostly formatting fixes for a few cases where html
looks plain wrong, plus a couple of added cross-references,
and a typo.

All issues spotted while reading cgroup docs. Results are checked
manually for both html and pdf, using both Sphinx 2.4.4 and 3.2.1
for rendering.

All commits are against docs-next@52042e2db

Kir Kolyshkin (10):
  docs/scheduler/sched-bwc: formatting fix
  docs/scheduler/sched-design-CFS: formatting fix
  docs/scheduler/sched-bwc: fix note rendering
  docs/scheduler/sched-bwc: add proper ref
  docs/scheduler/sched-bwc: note/link cgroup v2
  docs/admin-guide: cgroup-v2: typos and spaces
  docs/admin-guide: cgroup-v2: fix cgroup.type rendering
  doc/admin-guide/cgroup-v2: use tables
  docs/admin-guide/cgroup-v2: nit
  docs/admin-guide/cgroup-v2: fix mount opt rendering

 Documentation/admin-guide/cgroup-v2.rst      | 60 +++++++++++---------
 Documentation/scheduler/sched-bwc.rst        | 18 ++++--
 Documentation/scheduler/sched-design-CFS.rst |  6 +-
 Documentation/scheduler/sched-rt-group.rst   |  2 +
 4 files changed, 50 insertions(+), 36 deletions(-)

-- 
2.29.2

