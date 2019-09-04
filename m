Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5E304A9288
	for <lists+cgroups@lfdr.de>; Wed,  4 Sep 2019 21:47:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730232AbfIDTqX (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 4 Sep 2019 15:46:23 -0400
Received: from mail-qt1-f171.google.com ([209.85.160.171]:38247 "EHLO
        mail-qt1-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730310AbfIDTqN (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 4 Sep 2019 15:46:13 -0400
Received: by mail-qt1-f171.google.com with SMTP id b2so22337557qtq.5;
        Wed, 04 Sep 2019 12:46:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=jL4d81pypGq7ODywNqxdQtdPeeIUOLBTqveh64eDASc=;
        b=Z0oBR0eUEqPyun6hEblYCICjdKNvWRr+b29/35hl2k9IPCpnLWYk0YRY/8L5vtThT9
         rqb7sJxaWR3X8K4fC+O5IkrzkOK1cnraVOQlHpbAUryTpGEd8x1V2MF9f4AKzgabbPN4
         RURLEtu/yEDEf+b64CY/JEYDCcpg0DIRHptVcP+sl4fVElmdNupPsKEc1YTszbljredC
         6QJXBlhEqOK2ua2rUmzwgc0UOAFR/+1fjYgDmuwXttlJgNlzx8QdHsY1mQ6Iq345qlJM
         /UXcMmB/pCl4//OeGXfgwloUyMdpYFvINjlHOxBwvbqzG6c++Nio0VNFmvhBGqoSgXN2
         FXyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references;
        bh=jL4d81pypGq7ODywNqxdQtdPeeIUOLBTqveh64eDASc=;
        b=KGVq1t6PfGSA3cCiii1+KgvFKr18TEva/tAjDnPwEtwqeJkmuSUSJaU0v/kfTikWT4
         9foY5q7JVd6itxIbOfFxhu+p0fXpicOHD6/dzuJ/hTi+fdSpJoxRJwOW9oaCA5wWG4Kw
         3arNcom5km4tuaKTnt2sR3UuCbYmHRGOkUcXMfrlkHScaUp0sAx3jL4XbqJONZmpXKXU
         wBytDpeMesyBjAO0+0L0QWPmnVEA3iGeABWVxjt5vmX+m1mGZFzfcPuGjIlZh97Zf258
         WWddOhD/UosPLoja+Qllqd06q+O5qTuMnVVlzCgtVEQb74n4NWa8T8GZGc5T4LASKupy
         wqLg==
X-Gm-Message-State: APjAAAWWJgPxudWG6NSeTWJh3IpMB6QqTORGzHJGGU7uIlzy1x8sxdCx
        slAJOOjcZre9wU+3Ye/zfwM=
X-Google-Smtp-Source: APXvYqy3B8uCoovpU+dggZaKK6MmRowSu3/rxq1PqkkYanMHQXH3mw68IiIC36wBDFPsVTXt4ivzVA==
X-Received: by 2002:a0c:d084:: with SMTP id z4mr17865362qvg.63.1567626371193;
        Wed, 04 Sep 2019 12:46:11 -0700 (PDT)
Received: from localhost ([2620:10d:c091:500::3:33b1])
        by smtp.gmail.com with ESMTPSA id w15sm107958qtt.71.2019.09.04.12.46.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 04 Sep 2019 12:46:10 -0700 (PDT)
From:   Tejun Heo <tj@kernel.org>
To:     axboe@kernel.dk
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@vger.kernel.org, cgroups@vger.kernel.org,
        newella@fb.com, Tejun Heo <tj@kernel.org>
Subject: [PATCH 5/5] iocost_monitor: Report debt
Date:   Wed,  4 Sep 2019 12:45:56 -0700
Message-Id: <20190904194556.2984857-6-tj@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190904194556.2984857-1-tj@kernel.org>
References: <20190904194556.2984857-1-tj@kernel.org>
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Report debt and rename del_ms row to delay for consistency.

Signed-off-by: Tejun Heo <tj@kernel.org>
---
 block/blk-iocost.c             | 6 +++---
 tools/cgroup/iocost_monitor.py | 5 ++++-
 2 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/block/blk-iocost.c b/block/blk-iocost.c
index 6000ce9b10bb..f0c5bfd4b4a8 100644
--- a/block/blk-iocost.c
+++ b/block/blk-iocost.c
@@ -161,9 +161,9 @@
  * https://github.com/osandov/drgn.  The ouput looks like the following.
  *
  *  sdb RUN   per=300ms cur_per=234.218:v203.695 busy= +1 vrate= 62.12%
- *                 active      weight      hweight% inflt% del_ms usages%
- *  test/a              *    50/   50  33.33/ 33.33  27.65  0*041 033:033:033
- *  test/b              *   100/  100  66.67/ 66.67  17.56  0*000 066:079:077
+ *                 active      weight      hweight% inflt% dbt  delay usages%
+ *  test/a              *    50/   50  33.33/ 33.33  27.65   2  0*041 033:033:033
+ *  test/b              *   100/  100  66.67/ 66.67  17.56   0  0*000 066:079:077
  *
  * - per	: Timer period
  * - cur_per	: Internal wall and device vtime clock
diff --git a/tools/cgroup/iocost_monitor.py b/tools/cgroup/iocost_monitor.py
index 5d8bac603ffa..f79b23582a1d 100644
--- a/tools/cgroup/iocost_monitor.py
+++ b/tools/cgroup/iocost_monitor.py
@@ -135,7 +135,7 @@ autop_names = {
 
     def table_header_str(self):
         return f'{"":25} active {"weight":>9} {"hweight%":>13} {"inflt%":>6} ' \
-               f'{"del_ms":>6} {"usages%"}'
+               f'{"dbt":>3} {"delay":>6} {"usages%"}'
 
 class IocgStat:
     def __init__(self, iocg):
@@ -159,6 +159,7 @@ autop_names = {
         else:
             self.inflight_pct = 0
 
+        self.debt_ms = iocg.abs_vdebt.counter.value_() / VTIME_PER_USEC / 1000
         self.use_delay = blkg.use_delay.counter.value_()
         self.delay_ms = blkg.delay_nsec.counter.value_() / 1_000_000
 
@@ -181,6 +182,7 @@ autop_names = {
                 'hweight_active_pct'    : str(self.hwa_pct),
                 'hweight_inuse_pct'     : str(self.hwi_pct),
                 'inflight_pct'          : str(self.inflight_pct),
+                'debt_ms'               : str(self.debt_ms),
                 'use_delay'             : str(self.use_delay),
                 'delay_ms'              : str(self.delay_ms),
                 'usage_pct'             : str(self.usage),
@@ -195,6 +197,7 @@ autop_names = {
               f'{self.inuse:5}/{self.active:5} ' \
               f'{self.hwi_pct:6.2f}/{self.hwa_pct:6.2f} ' \
               f'{self.inflight_pct:6.2f} ' \
+              f'{min(math.ceil(self.debt_ms), 999):3} ' \
               f'{min(self.use_delay, 99):2}*'\
               f'{min(math.ceil(self.delay_ms), 999):03} '
         for u in self.usages:
-- 
2.17.1

