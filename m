Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC7A11A69ED
	for <lists+cgroups@lfdr.de>; Mon, 13 Apr 2020 18:28:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731564AbgDMQ2T (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 13 Apr 2020 12:28:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1731558AbgDMQ2P (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 13 Apr 2020 12:28:15 -0400
Received: from mail-qv1-xf41.google.com (mail-qv1-xf41.google.com [IPv6:2607:f8b0:4864:20::f41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C65EC0A3BDC;
        Mon, 13 Apr 2020 09:28:15 -0700 (PDT)
Received: by mail-qv1-xf41.google.com with SMTP id da9so625979qvb.3;
        Mon, 13 Apr 2020 09:28:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=oUkkM58FQ7/zwRHxuQQD1SOxcIY68c2GOGKvgkHNmUk=;
        b=iHM4peE0B7c2LWhuK1L8wKWz3xluirMtuEeZzNSpfKtK4vFwAm6fuMwuF7a1rsGGnG
         jXA7Re6osRnNCm00LHi73qpuNxvU2Mc3VWIWT5RQYzUIvTW70xBFsPcB4kV2g7N412U7
         ArFLNIKn/Rd4dIBMgxzoyGZX9Y3v9Cldr9f+6dBGK9UEj13nwKkam0J9+GHfBVCn78kb
         U5YHVVZ4A3QF31vS32j2cDO65OlDuRGhDnRAoh86GlBGLiTa2oUxgAStyEmU0qxm/WGw
         tW9XemwnS8zpHKq039mvCTgkPNHACTb9mGmyqsM9gUdxCgJG51su4SvZEnu0HJvHTyQU
         lvPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=oUkkM58FQ7/zwRHxuQQD1SOxcIY68c2GOGKvgkHNmUk=;
        b=IuEh1lrTwUEmPZyLBiwXeC8bndouoE0sAiC/VJnzs/Kz1rDtW6XrlN9s+ZoQ6hVlgW
         bHJmFHWGZW5KDSOUcSK2jdj11UzaNGYctRn8T/1S7QxFQJ/WSj77GEj5+pCA5F/neXRl
         rUM2whUFY+H90V0GVf1ISOFppHsd3ARqUnR7/9oQ7t6/OntxqxnTI+EwQnCjxFeiLpDc
         eIZXsXv6b24WXGi1RaHZVLBrO2OdKQJIJwG/aNWeEUzAGVr//woNiBJ75rPFCO7PQySZ
         L07jdL3KFDKroB717aqnB7lPvzuowlaGZ1ps+WYVPqc8gwfjEGhQtGG3lW3n/ILns1H8
         aAEw==
X-Gm-Message-State: AGi0Pua3F+iOt8QARWiKG5eFPkwqz9AM+jiyRA30AqfWA58stRYaHgoM
        QbAVFsdnYr02UfJRDJLTHz0isdZRACI=
X-Google-Smtp-Source: APiQypJwvhy7iuOaZ7hP+9n1TUG0oLkMcKs4ryUx9kDY3wfgkyszstXm/7PJfP++9VweLFQL4JMpXg==
X-Received: by 2002:a0c:a122:: with SMTP id d31mr17862921qva.109.1586795294460;
        Mon, 13 Apr 2020 09:28:14 -0700 (PDT)
Received: from localhost ([199.96.181.106])
        by smtp.gmail.com with ESMTPSA id m14sm8698505qkm.82.2020.04.13.09.28.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Apr 2020 09:28:13 -0700 (PDT)
From:   Tejun Heo <tj@kernel.org>
To:     axboe@kernel.dk
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com, cgroups@vger.kernel.org, newella@fb.com,
        josef@toxicpanda.com, asml.silence@gmail.com, ming.lei@redhat.com,
        bvanassche@acm.org, Tejun Heo <tj@kernel.org>
Subject: [PATCH 4/4] iocost_monitor: drop string wrap around numbers when outputting json
Date:   Mon, 13 Apr 2020 12:27:58 -0400
Message-Id: <20200413162758.97252-5-tj@kernel.org>
X-Mailer: git-send-email 2.25.2
In-Reply-To: <20200413162758.97252-1-tj@kernel.org>
References: <20200413162758.97252-1-tj@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Wrapping numbers in strings is used by some to work around bit-width issues in
some enviroments. The problem isn't innate to json and the workaround seems to
cause more integration problems than help. Let's drop the string wrapping.

Signed-off-by: Tejun Heo <tj@kernel.org>
---
 tools/cgroup/iocost_monitor.py | 42 +++++++++++++++++-----------------
 1 file changed, 21 insertions(+), 21 deletions(-)

diff --git a/tools/cgroup/iocost_monitor.py b/tools/cgroup/iocost_monitor.py
index eb2363b868c5..188b3379b9a1 100644
--- a/tools/cgroup/iocost_monitor.py
+++ b/tools/cgroup/iocost_monitor.py
@@ -113,14 +113,14 @@ autop_names = {
 
     def dict(self, now):
         return { 'device'               : devname,
-                 'timestamp'            : str(now),
-                 'enabled'              : str(int(self.enabled)),
-                 'running'              : str(int(self.running)),
-                 'period_ms'            : str(self.period_ms),
-                 'period_at'            : str(self.period_at),
-                 'period_vtime_at'      : str(self.vperiod_at),
-                 'busy_level'           : str(self.busy_level),
-                 'vrate_pct'            : str(self.vrate_pct), }
+                 'timestamp'            : now,
+                 'enabled'              : self.enabled,
+                 'running'              : self.running,
+                 'period_ms'            : self.period_ms,
+                 'period_at'            : self.period_at,
+                 'period_vtime_at'      : self.vperiod_at,
+                 'busy_level'           : self.busy_level,
+                 'vrate_pct'            : self.vrate_pct, }
 
     def table_preamble_str(self):
         state = ('RUN' if self.running else 'IDLE') if self.enabled else 'OFF'
@@ -175,19 +175,19 @@ autop_names = {
 
     def dict(self, now, path):
         out = { 'cgroup'                : path,
-                'timestamp'             : str(now),
-                'is_active'             : str(int(self.is_active)),
-                'weight'                : str(self.weight),
-                'weight_active'         : str(self.active),
-                'weight_inuse'          : str(self.inuse),
-                'hweight_active_pct'    : str(self.hwa_pct),
-                'hweight_inuse_pct'     : str(self.hwi_pct),
-                'inflight_pct'          : str(self.inflight_pct),
-                'debt_ms'               : str(self.debt_ms),
-                'use_delay'             : str(self.use_delay),
-                'delay_ms'              : str(self.delay_ms),
-                'usage_pct'             : str(self.usage),
-                'address'               : str(hex(self.address)) }
+                'timestamp'             : now,
+                'is_active'             : self.is_active,
+                'weight'                : self.weight,
+                'weight_active'         : self.active,
+                'weight_inuse'          : self.inuse,
+                'hweight_active_pct'    : self.hwa_pct,
+                'hweight_inuse_pct'     : self.hwi_pct,
+                'inflight_pct'          : self.inflight_pct,
+                'debt_ms'               : self.debt_ms,
+                'use_delay'             : self.use_delay,
+                'delay_ms'              : self.delay_ms,
+                'usage_pct'             : self.usage,
+                'address'               : self.address }
         for i in range(len(self.usages)):
             out[f'usage_pct_{i}'] = str(self.usages[i])
         return out
-- 
2.25.2

