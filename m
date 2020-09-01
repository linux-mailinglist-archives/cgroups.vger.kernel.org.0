Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 51E87259E90
	for <lists+cgroups@lfdr.de>; Tue,  1 Sep 2020 20:54:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731912AbgIASyc (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 1 Sep 2020 14:54:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731934AbgIASyZ (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 1 Sep 2020 14:54:25 -0400
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 651CEC061244;
        Tue,  1 Sep 2020 11:54:25 -0700 (PDT)
Received: by mail-qk1-x743.google.com with SMTP id v69so1995109qkb.7;
        Tue, 01 Sep 2020 11:54:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=cm+df0jFPyE1zTjCqgFLh2q6gImstDntHA7G0hKbn1c=;
        b=XajDkh8P9KQTJXpi9a5vP6TJ7CkEhXM4INtbnSsTamKj77lttU5yXy9F/WfSWTKkxK
         TH5ddWvVKmWD8wKvRAttyvS3Hgh7AoiRULzZSGWVQvleLF5fH4ms+fK/evyW3FMFqfl4
         B4z5fZo3UOC08McpaqbKgKFmzLEPi7zu/4gvz4qaHXJQPqK/4QI++6MWT5BGL/paChPI
         wY+8Puhdm0BglBfCawCT0Do8mk4x0L1pmSSWJcKpPNEBEOuofB3vh6hoyFBMc0Qe3B2c
         Fm+FWJOo51I2OrqxBjvSla140/ntPH3CsqqFeutrsnj4zy+W5HEkgRYSlMFTxOeFMvqE
         1A+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=cm+df0jFPyE1zTjCqgFLh2q6gImstDntHA7G0hKbn1c=;
        b=tPdi3q/3Vg/+xxW+CEJ/4qotvu+adlPZaPr2IA1olq86BIWDiJxEjp4ER4zcXXs8En
         hREwp6VIEpKnOanVDPmG09PufQD0DN1YXKKW8GON6PFpnaajPm+brDcUY2roqlkuhBc7
         7549HzUPsfElUNheIEuWPCL0LqEuYzcqgE1/DHhkNImipe/esxczHVak7XsUeLTBsX0h
         XPrnav+b7jzVql1xJXH9PE4nfCaTagY3bT2KAdafYdmJyMdnmZHfneWwmcK7xO6zyZrk
         i3lPHnda9RfNh9CdIPflDksCNqEgKvJCX/GgPGHwiAVLMnfuHz0fgIQYlG4hfvoY2j4l
         G5kQ==
X-Gm-Message-State: AOAM530gtNKi0VtUDaFekRpwhf139BGAdDpVi11bCcjPFCa1IVZVVbZB
        CBnoWbPaTtX4QCfeeMu05twagEXtXD2LAg==
X-Google-Smtp-Source: ABdhPJyC1zrmWahk0Un9SvEpY6Bbw4MwTkW6QE19cV+1OyUU/CrIaLlLAJ85naK2tPp7q0zf9GIF9g==
X-Received: by 2002:a37:4c15:: with SMTP id z21mr3170782qka.334.1598986464504;
        Tue, 01 Sep 2020 11:54:24 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::1:a198])
        by smtp.gmail.com with ESMTPSA id p68sm2697824qka.78.2020.09.01.11.54.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Sep 2020 11:54:24 -0700 (PDT)
From:   Tejun Heo <tj@kernel.org>
To:     axboe@kernel.dk
Cc:     linux-block@vger.kernel.org, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@fb.com, newella@fb.com,
        Tejun Heo <tj@kernel.org>
Subject: [PATCH 27/27] blk-iocost: update iocost_monitor.py
Date:   Tue,  1 Sep 2020 14:52:57 -0400
Message-Id: <20200901185257.645114-28-tj@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200901185257.645114-1-tj@kernel.org>
References: <20200901185257.645114-1-tj@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

iocost went through significant internal changes. Update iocost_monitor.py
accordingly.

Signed-off-by: Tejun Heo <tj@kernel.org>
---
 tools/cgroup/iocost_monitor.py | 54 ++++++++++++----------------------
 1 file changed, 19 insertions(+), 35 deletions(-)

diff --git a/tools/cgroup/iocost_monitor.py b/tools/cgroup/iocost_monitor.py
index f4699f9b46ba..c4ff907c078b 100644
--- a/tools/cgroup/iocost_monitor.py
+++ b/tools/cgroup/iocost_monitor.py
@@ -45,8 +45,7 @@ args = parser.parse_args()
     err('The kernel does not have iocost enabled')
 
 IOC_RUNNING     = prog['IOC_RUNNING'].value_()
-NR_USAGE_SLOTS  = prog['NR_USAGE_SLOTS'].value_()
-HWEIGHT_WHOLE   = prog['HWEIGHT_WHOLE'].value_()
+WEIGHT_ONE      = prog['WEIGHT_ONE'].value_()
 VTIME_PER_SEC   = prog['VTIME_PER_SEC'].value_()
 VTIME_PER_USEC  = prog['VTIME_PER_USEC'].value_()
 AUTOP_SSD_FAST  = prog['AUTOP_SSD_FAST'].value_()
@@ -100,7 +99,7 @@ autop_names = {
         self.period_ms = ioc.period_us.value_() / 1_000
         self.period_at = ioc.period_at.value_() / 1_000_000
         self.vperiod_at = ioc.period_at_vtime.value_() / VTIME_PER_SEC
-        self.vrate_pct = ioc.vtime_rate.counter.value_() * 100 / VTIME_PER_USEC
+        self.vrate_pct = ioc.vtime_base_rate.value_() * 100 / VTIME_PER_USEC
         self.busy_level = ioc.busy_level.value_()
         self.autop_idx = ioc.autop_idx.value_()
         self.user_cost_model = ioc.user_cost_model.value_()
@@ -136,7 +135,7 @@ autop_names = {
 
     def table_header_str(self):
         return f'{"":25} active {"weight":>9} {"hweight%":>13} {"inflt%":>6} ' \
-               f'{"dbt":>3} {"delay":>6} {"usages%"}'
+               f'{"debt":>7} {"delay":>7} {"usage%"}'
 
 class IocgStat:
     def __init__(self, iocg):
@@ -144,11 +143,11 @@ autop_names = {
         blkg = iocg.pd.blkg
 
         self.is_active = not list_empty(iocg.active_list.address_of_())
-        self.weight = iocg.weight.value_()
-        self.active = iocg.active.value_()
-        self.inuse = iocg.inuse.value_()
-        self.hwa_pct = iocg.hweight_active.value_() * 100 / HWEIGHT_WHOLE
-        self.hwi_pct = iocg.hweight_inuse.value_() * 100 / HWEIGHT_WHOLE
+        self.weight = iocg.weight.value_() / WEIGHT_ONE
+        self.active = iocg.active.value_() / WEIGHT_ONE
+        self.inuse = iocg.inuse.value_() / WEIGHT_ONE
+        self.hwa_pct = iocg.hweight_active.value_() * 100 / WEIGHT_ONE
+        self.hwi_pct = iocg.hweight_inuse.value_() * 100 / WEIGHT_ONE
         self.address = iocg.value_()
 
         vdone = iocg.done_vtime.counter.value_()
@@ -160,23 +159,13 @@ autop_names = {
         else:
             self.inflight_pct = 0
 
-        # vdebt used to be an atomic64_t and is now u64, support both
-        try:
-            self.debt_ms = iocg.abs_vdebt.counter.value_() / VTIME_PER_USEC / 1000
-        except:
-            self.debt_ms = iocg.abs_vdebt.value_() / VTIME_PER_USEC / 1000
-
-        self.use_delay = blkg.use_delay.counter.value_()
-        self.delay_ms = blkg.delay_nsec.counter.value_() / 1_000_000
-
-        usage_idx = iocg.usage_idx.value_()
-        self.usages = []
-        self.usage = 0
-        for i in range(NR_USAGE_SLOTS):
-            usage = iocg.usages[(usage_idx + 1 + i) % NR_USAGE_SLOTS].value_()
-            upct = usage * 100 / HWEIGHT_WHOLE
-            self.usages.append(upct)
-            self.usage = max(self.usage, upct)
+        self.usage = (100 * iocg.usage_delta_us.value_() /
+                      ioc.period_us.value_()) if self.active else 0
+        self.debt_ms = iocg.abs_vdebt.value_() / VTIME_PER_USEC / 1000
+        if blkg.use_delay.counter.value_() != 0:
+            self.delay_ms = blkg.delay_nsec.counter.value_() / 1_000_000
+        else:
+            self.delay_ms = 0
 
     def dict(self, now, path):
         out = { 'cgroup'                : path,
@@ -189,25 +178,20 @@ autop_names = {
                 'hweight_inuse_pct'     : self.hwi_pct,
                 'inflight_pct'          : self.inflight_pct,
                 'debt_ms'               : self.debt_ms,
-                'use_delay'             : self.use_delay,
                 'delay_ms'              : self.delay_ms,
                 'usage_pct'             : self.usage,
                 'address'               : self.address }
-        for i in range(len(self.usages)):
-            out[f'usage_pct_{i}'] = str(self.usages[i])
         return out
 
     def table_row_str(self, path):
         out = f'{path[-28:]:28} ' \
               f'{"*" if self.is_active else " "} ' \
-              f'{self.inuse:5}/{self.active:5} ' \
+              f'{round(self.inuse):5}/{round(self.active):5} ' \
               f'{self.hwi_pct:6.2f}/{self.hwa_pct:6.2f} ' \
               f'{self.inflight_pct:6.2f} ' \
-              f'{min(math.ceil(self.debt_ms), 999):3} ' \
-              f'{min(self.use_delay, 99):2}*'\
-              f'{min(math.ceil(self.delay_ms), 999):03} '
-        for u in self.usages:
-            out += f'{min(round(u), 999):03d}:'
+              f'{self.debt_ms:7.2f} ' \
+              f'{self.delay_ms:7.2f} '\
+              f'{min(self.usage, 999):6.2f}'
         out = out.rstrip(':')
         return out
 
-- 
2.26.2

