Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A2E36A9284
	for <lists+cgroups@lfdr.de>; Wed,  4 Sep 2019 21:47:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730286AbfIDTqM (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 4 Sep 2019 15:46:12 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:37153 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730232AbfIDTqK (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 4 Sep 2019 15:46:10 -0400
Received: by mail-qk1-f196.google.com with SMTP id s14so20854706qkm.4;
        Wed, 04 Sep 2019 12:46:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=iI9MwVhDc7RAqkPvomtO9iKQGF6mvrirQ+L7ZaA22N4=;
        b=vIyNi+SSpBFV02XHRcFiU9QGtz6rnHbfRIsKoGrthXgk0sdQVAXBI+WeCYlcYrFY9B
         eB9CTcGogSly1Aa92JWc/hMa04vsKdDocBNkcfP0pLj2rSC8LLgDtQUbDRGEwqQhTug2
         s7kNEpY6sjbPd42tv/iLO2VKb9Ks5j3Ly2zqsmuMsCwGPQsLyfBeTS7tHJAtlJZmdiAn
         yhEHs5pEysE9NGXmG2R+48Rfw/qZrPT2MPxCKQ25clVabwpMfcxR6YguiXsPC4UdSapl
         ZR2cwgxvYBXFRQvjqYtfi7msm+LLM5x5SaD/dKpAi4YgZS4uQu6Y2qF5oC5vRTOQwZU6
         wE0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references;
        bh=iI9MwVhDc7RAqkPvomtO9iKQGF6mvrirQ+L7ZaA22N4=;
        b=YrANn/Lou+wYLhzcbrWkEGeA1n3kmQ7i8rEwWcRF+fdWX2mamz0dnM06UbjaNmUe1b
         81L7sGD7njiS0uF/lu7e8/SrUZU7m0iR4YWDD6XXh54WodjC+Xm9vpt3Q6Ny6qwt8Unb
         JCAIKg8HBBSKslUvy4ymknRcatNQArT+h/vQwf8X00NsKRYsVDspzkpwDMFq7//j5JW2
         PimuxqWkifVhSAMzGWukUNuN4Vcrm9tiJebYxqKBrvhCOEQsjdQeBtXemezDSAYa8yqt
         klAOEOhipIXLm/fUqJE74HJJjeVvaCDftyKuslFCgdBIzLVrVscXCSztMtmlqvalPlCZ
         BEKA==
X-Gm-Message-State: APjAAAU1pgYg5Dpw4adQrZr0gCpOZXqaHvgmyqE1qgxLNsP3TM5Lf5C8
        i0AkayCAmCmQp1biHltTruE=
X-Google-Smtp-Source: APXvYqxmmaj1DbMhYCY30sd/yTDtXcWZVCbrlR37ssZllxSIxdbtRX+bARbUlfZQSD6KbztFYRVASg==
X-Received: by 2002:a37:afc6:: with SMTP id y189mr41691870qke.7.1567626369152;
        Wed, 04 Sep 2019 12:46:09 -0700 (PDT)
Received: from localhost ([2620:10d:c091:500::3:33b1])
        by smtp.gmail.com with ESMTPSA id b4sm7798573qkd.121.2019.09.04.12.46.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 04 Sep 2019 12:46:08 -0700 (PDT)
From:   Tejun Heo <tj@kernel.org>
To:     axboe@kernel.dk
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@vger.kernel.org, cgroups@vger.kernel.org,
        newella@fb.com, Tejun Heo <tj@kernel.org>
Subject: [PATCH 4/5] iocost_monitor: Report more info with higher accuracy
Date:   Wed,  4 Sep 2019 12:45:55 -0700
Message-Id: <20190904194556.2984857-5-tj@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190904194556.2984857-1-tj@kernel.org>
References: <20190904194556.2984857-1-tj@kernel.org>
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

When outputting json:

* Don't truncate numbers.

* Report address of iocg to ease drilling down further.

When outputting table:

* Use math.ceil() for delay_ms so that small delays don't read as 0.

Signed-off-by: Tejun Heo <tj@kernel.org>
---
 tools/cgroup/iocost_monitor.py | 18 +++++++++++-------
 1 file changed, 11 insertions(+), 7 deletions(-)

diff --git a/tools/cgroup/iocost_monitor.py b/tools/cgroup/iocost_monitor.py
index 8f6b4ac377bd..5d8bac603ffa 100644
--- a/tools/cgroup/iocost_monitor.py
+++ b/tools/cgroup/iocost_monitor.py
@@ -13,6 +13,7 @@ import sys
 import re
 import time
 import json
+import math
 
 import drgn
 from drgn import container_of
@@ -95,7 +96,7 @@ autop_names = {
 
         self.enabled = ioc.enabled.value_()
         self.running = ioc.running.value_() == IOC_RUNNING
-        self.period_ms = round(ioc.period_us.value_() / 1_000)
+        self.period_ms = ioc.period_us.value_() / 1_000
         self.period_at = ioc.period_at.value_() / 1_000_000
         self.vperiod_at = ioc.period_at_vtime.value_() / VTIME_PER_SEC
         self.vrate_pct = ioc.vtime_rate.counter.value_() * 100 / VTIME_PER_USEC
@@ -147,6 +148,7 @@ autop_names = {
         self.inuse = iocg.inuse.value_()
         self.hwa_pct = iocg.hweight_active.value_() * 100 / HWEIGHT_WHOLE
         self.hwi_pct = iocg.hweight_inuse.value_() * 100 / HWEIGHT_WHOLE
+        self.address = iocg.value_()
 
         vdone = iocg.done_vtime.counter.value_()
         vtime = iocg.vtime.counter.value_()
@@ -157,15 +159,15 @@ autop_names = {
         else:
             self.inflight_pct = 0
 
-        self.use_delay = min(blkg.use_delay.counter.value_(), 99)
-        self.delay_ms = min(round(blkg.delay_nsec.counter.value_() / 1_000_000), 999)
+        self.use_delay = blkg.use_delay.counter.value_()
+        self.delay_ms = blkg.delay_nsec.counter.value_() / 1_000_000
 
         usage_idx = iocg.usage_idx.value_()
         self.usages = []
         self.usage = 0
         for i in range(NR_USAGE_SLOTS):
             usage = iocg.usages[(usage_idx + i) % NR_USAGE_SLOTS].value_()
-            upct = min(usage * 100 / HWEIGHT_WHOLE, 999)
+            upct = usage * 100 / HWEIGHT_WHOLE
             self.usages.append(upct)
             self.usage = max(self.usage, upct)
 
@@ -181,7 +183,8 @@ autop_names = {
                 'inflight_pct'          : str(self.inflight_pct),
                 'use_delay'             : str(self.use_delay),
                 'delay_ms'              : str(self.delay_ms),
-                'usage_pct'             : str(self.usage) }
+                'usage_pct'             : str(self.usage),
+                'address'               : str(hex(self.address)) }
         for i in range(len(self.usages)):
             out[f'usage_pct_{i}'] = str(self.usages[i])
         return out
@@ -192,9 +195,10 @@ autop_names = {
               f'{self.inuse:5}/{self.active:5} ' \
               f'{self.hwi_pct:6.2f}/{self.hwa_pct:6.2f} ' \
               f'{self.inflight_pct:6.2f} ' \
-              f'{self.use_delay:2}*{self.delay_ms:03} '
+              f'{min(self.use_delay, 99):2}*'\
+              f'{min(math.ceil(self.delay_ms), 999):03} '
         for u in self.usages:
-            out += f'{round(u):03d}:'
+            out += f'{min(round(u), 999):03d}:'
         out = out.rstrip(':')
         return out
 
-- 
2.17.1

