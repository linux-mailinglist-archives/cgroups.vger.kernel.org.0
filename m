Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF0182FC5B0
	for <lists+cgroups@lfdr.de>; Wed, 20 Jan 2021 01:24:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728588AbhATAUq (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 19 Jan 2021 19:20:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727340AbhATATN (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 19 Jan 2021 19:19:13 -0500
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8357AC061757;
        Tue, 19 Jan 2021 16:18:29 -0800 (PST)
Received: by mail-pj1-x102c.google.com with SMTP id m5so999287pjv.5;
        Tue, 19 Jan 2021 16:18:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=XkdryAomM5az2Ze2NYd09JWowO5YjJiadHr5mNXL5/M=;
        b=VP75uQaycjsESHMeLXbRrDjAb4Cqt4odG4boanj7vRVeuesb49E/ZOheLGtFdgZ6Pu
         UutaIeCpF3tfV5s4Unrs4qhoGgGw5i53G2fwKFquvwnELcK35WEbs9fgdW8Z+sBJs/9u
         5BjHCtcOu34bzeflTDxfKz6MItwT0b0RZIfSu4Vrs7r27ZS3NMTJkQczKfJEtXCui6o9
         wiZKGBq45p/Wg2Xr3EytZu4fCxpmcZC7n7e6QTCO8qkYY191T+j1XsyaMv1syZYJveOo
         lpORo4531azB5pI6wvGY5Q1+TN91vTf/dOCL+GnRy67TRZauS4tEBgcdj4+tH6rB9N06
         56vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XkdryAomM5az2Ze2NYd09JWowO5YjJiadHr5mNXL5/M=;
        b=uINl2BlnD70jdUMcSGnauMppd+sGMhO2ay6TzdPKhOfk3OGBvAqZwsDqXqy3CBOUE/
         XgPOp2FjJS7Z+BaBz1mzKU3JE2Tx0kYeRbDRHzQYeGJuFoEWMZS0t3DVT9ju3JIkuTch
         +eiPTyMinevJlyYpJD/+dqz0IV6MLcoBzwLOvg5OXTkw19DZIS+CMYQmbwGBhHzEXp+1
         YvPaSCFgQomaUkGTtq4tJ0fLrjGSE1D8Zm4VqXpHHkW2iBYIgFyOCoPk5mb2fP68K1gB
         GlY74JZnOR7nUD2oZJtEtMfti8L2albLMbY0lbEN6p5/mK8UQMEFC1ilsemZsNcIdcn6
         HpDA==
X-Gm-Message-State: AOAM530t60UHS3Ko9D22tXY63LvHqeYlpKloV/L1FIR1nSceRkq2uUL4
        2+Cn6KL++Ue076dXLvUysBI=
X-Google-Smtp-Source: ABdhPJwyW/RNAVzMZRdDgaNH8MphIG5lP+W8tDu2F9TXiy9jwUqS0Ehx+189bru27loSC19Gv8cjFA==
X-Received: by 2002:a17:902:14f:b029:de:c703:3045 with SMTP id 73-20020a170902014fb02900dec7033045mr4916098plb.14.1611101909051;
        Tue, 19 Jan 2021 16:18:29 -0800 (PST)
Received: from kir-rhat.lan (c-76-104-243-248.hsd1.wa.comcast.net. [76.104.243.248])
        by smtp.gmail.com with ESMTPSA id y6sm227452pfn.123.2021.01.19.16.18.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Jan 2021 16:18:28 -0800 (PST)
From:   Kir Kolyshkin <kolyshkin@gmail.com>
To:     corbet@lwn.net
Cc:     linux-doc@vger.kernel.org, cgroups@vger.kernel.org,
        Kir Kolyshkin <kolyshkin@gmail.com>
Subject: [PATCH 01/10] docs/scheduler/sched-bwc: formatting fix
Date:   Tue, 19 Jan 2021 16:18:15 -0800
Message-Id: <20210120001824.385168-2-kolyshkin@gmail.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210120001824.385168-1-kolyshkin@gmail.com>
References: <20210120001824.385168-1-kolyshkin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Since commit d6a3b247627a3 these three lines are merged into one by the
RST processor, making it hard to read. Use bullet points to separate
the entries, like it's done in other similar places.

Signed-off-by: Kir Kolyshkin <kolyshkin@gmail.com>
---
 Documentation/scheduler/sched-bwc.rst | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/Documentation/scheduler/sched-bwc.rst b/Documentation/scheduler/sched-bwc.rst
index 9801d6b284b1..4af4ee1f3600 100644
--- a/Documentation/scheduler/sched-bwc.rst
+++ b/Documentation/scheduler/sched-bwc.rst
@@ -25,9 +25,10 @@ Management
 ----------
 Quota and period are managed within the cpu subsystem via cgroupfs.
 
-cpu.cfs_quota_us: the total available run-time within a period (in microseconds)
-cpu.cfs_period_us: the length of a period (in microseconds)
-cpu.stat: exports throttling statistics [explained further below]
+- cpu.cfs_quota_us: the total available run-time within a period (in
+  microseconds)
+- cpu.cfs_period_us: the length of a period (in microseconds)
+- cpu.stat: exports throttling statistics [explained further below]
 
 The default values are::
 
-- 
2.29.2

