Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E8312A9280
	for <lists+cgroups@lfdr.de>; Wed,  4 Sep 2019 21:47:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730206AbfIDTqI (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 4 Sep 2019 15:46:08 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:42388 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730185AbfIDTqI (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 4 Sep 2019 15:46:08 -0400
Received: by mail-qt1-f193.google.com with SMTP id c9so492911qth.9;
        Wed, 04 Sep 2019 12:46:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=TRsIsTqTTaD4KvJ5qqrHTq3GaA09a3g8vTgRyaRa+1g=;
        b=Cy/rW5q/7uBhRpjIRkte/wVsq531S30qrwpCgl8Fl8aWv8B9RYhNXyyRJUdYJFVqZ1
         hQZurp7uO2Ep5E4LHaqNjkNXCVTnByOGz+o/2DwqUkKkljYGXsxPdQu5Upwnr+mCe/Vr
         Dgpu0m62CwYkw9XgXFso9Q5d1PsdjZmqklzoyxyaSzR3Guh1bx2usmf0HSL0D/ZAaHZL
         jMxtBEzmlq/mwV41VVXfRowouGAC/lMkxV+Jq/Ra1kqJbmcyVpk8oFHX0miW/qm2Q1Do
         bqrEjPahv/I/K/sCSnaYdVBmWT4K4rug7ZkIbuuOzvCOF0Xy0I2Mh/YomkF5TTHovzXk
         rFng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references;
        bh=TRsIsTqTTaD4KvJ5qqrHTq3GaA09a3g8vTgRyaRa+1g=;
        b=ULOrx5RkCZ1hEInKFbhbtPzXnkmaHIY94SZLueuzb8JSulXmW/9ubCeU2VD3w/cEGe
         st55rxcHMTd3sQb8Zr9pvksqno0K5QbXZqhSyHax2WdQa9sY2fgUkHpIZC8pxFj+X+Th
         WKz3RXJcK1H32TSzRHxxgbQsqh9QHUV2viZIBs1V5YnKzLfVUY3rF6Qb3AwW6I4MH/et
         kA/V7nr46wh/z9eUM8IRil4l10iQyteMuE5phlc8tYyUsC14hvQT/NUIHX8wCqh8ll0W
         1BWTsVMamKiUKrzRJ51z+1DAxczxwdETmtIx4CFH5ZZlh4MArtA9w3wqEf1V7zt3M6+c
         g6BA==
X-Gm-Message-State: APjAAAUlKqkkWUwDCkla2SZJcuH2cFbSpLidD5Bd12ql6zebQaJlCjpA
        ji7avsX0X7BR6Xawt1P22t0=
X-Google-Smtp-Source: APXvYqxpAqeBUOEQ8CYHvJNOvr4kq5J0rhwF1VSB2xCy2s8AAwMhbesfB2T/fBUPNkojbGTUKjEFTQ==
X-Received: by 2002:ac8:414b:: with SMTP id e11mr41201878qtm.174.1567626366859;
        Wed, 04 Sep 2019 12:46:06 -0700 (PDT)
Received: from localhost ([2620:10d:c091:500::3:33b1])
        by smtp.gmail.com with ESMTPSA id z7sm9114582qka.72.2019.09.04.12.46.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 04 Sep 2019 12:46:06 -0700 (PDT)
From:   Tejun Heo <tj@kernel.org>
To:     axboe@kernel.dk
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@vger.kernel.org, cgroups@vger.kernel.org,
        newella@fb.com, Tejun Heo <tj@kernel.org>
Subject: [PATCH 3/5] iocost_monitor: Always use strings for json values
Date:   Wed,  4 Sep 2019 12:45:54 -0700
Message-Id: <20190904194556.2984857-4-tj@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190904194556.2984857-1-tj@kernel.org>
References: <20190904194556.2984857-1-tj@kernel.org>
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Json has limited accuracy for numbers and can silently truncate 64bit
values, which can be extremely confusing.  Let's consistently use
string encapsulated values for json output.

While at it, convert an unnecesary f-string to str().

Signed-off-by: Tejun Heo <tj@kernel.org>
---
 tools/cgroup/iocost_monitor.py | 40 +++++++++++++++++-----------------
 1 file changed, 20 insertions(+), 20 deletions(-)

diff --git a/tools/cgroup/iocost_monitor.py b/tools/cgroup/iocost_monitor.py
index 2c9445e966d8..8f6b4ac377bd 100644
--- a/tools/cgroup/iocost_monitor.py
+++ b/tools/cgroup/iocost_monitor.py
@@ -111,14 +111,14 @@ autop_names = {
 
     def dict(self, now):
         return { 'device'               : devname,
-                 'timestamp'            : now,
-                 'enabled'              : self.enabled,
-                 'running'              : self.running,
-                 'period_ms'            : self.period_ms,
-                 'period_at'            : self.period_at,
-                 'period_vtime_at'      : self.vperiod_at,
-                 'busy_level'           : self.busy_level,
-                 'vrate_pct'            : self.vrate_pct, }
+                 'timestamp'            : str(now),
+                 'enabled'              : str(int(self.enabled)),
+                 'running'              : str(int(self.running)),
+                 'period_ms'            : str(self.period_ms),
+                 'period_at'            : str(self.period_at),
+                 'period_vtime_at'      : str(self.vperiod_at),
+                 'busy_level'           : str(self.busy_level),
+                 'vrate_pct'            : str(self.vrate_pct), }
 
     def table_preamble_str(self):
         state = ('RUN' if self.running else 'IDLE') if self.enabled else 'OFF'
@@ -171,19 +171,19 @@ autop_names = {
 
     def dict(self, now, path):
         out = { 'cgroup'                : path,
-                'timestamp'             : now,
-                'is_active'             : self.is_active,
-                'weight'                : self.weight,
-                'weight_active'         : self.active,
-                'weight_inuse'          : self.inuse,
-                'hweight_active_pct'    : self.hwa_pct,
-                'hweight_inuse_pct'     : self.hwi_pct,
-                'inflight_pct'          : self.inflight_pct,
-                'use_delay'             : self.use_delay,
-                'delay_ms'              : self.delay_ms,
-                'usage_pct'             : self.usage }
+                'timestamp'             : str(now),
+                'is_active'             : str(int(self.is_active)),
+                'weight'                : str(self.weight),
+                'weight_active'         : str(self.active),
+                'weight_inuse'          : str(self.inuse),
+                'hweight_active_pct'    : str(self.hwa_pct),
+                'hweight_inuse_pct'     : str(self.hwi_pct),
+                'inflight_pct'          : str(self.inflight_pct),
+                'use_delay'             : str(self.use_delay),
+                'delay_ms'              : str(self.delay_ms),
+                'usage_pct'             : str(self.usage) }
         for i in range(len(self.usages)):
-            out[f'usage_pct_{i}'] = f'{self.usages[i]}'
+            out[f'usage_pct_{i}'] = str(self.usages[i])
         return out
 
     def table_row_str(self, path):
-- 
2.17.1

