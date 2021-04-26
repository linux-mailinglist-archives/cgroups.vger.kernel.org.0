Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 90B8936AC97
	for <lists+cgroups@lfdr.de>; Mon, 26 Apr 2021 09:01:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232088AbhDZHBR (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 26 Apr 2021 03:01:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232081AbhDZHBL (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 26 Apr 2021 03:01:11 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3173C061574
        for <cgroups@vger.kernel.org>; Mon, 26 Apr 2021 00:00:29 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id t13so2365910pji.4
        for <cgroups@vger.kernel.org>; Mon, 26 Apr 2021 00:00:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=SfF/Z0ScslK5LaLkBhpaNHR++tEupceqm51lspaZqiM=;
        b=0i9nIWEJj9GpgmwDenmDPUoRWsFexvOFaT+BUwCnkkTJB+KggV7EM95SvP/FIHknUT
         OJdeK9AduA5wcmvM8cbrNSN3YxfhLD0Ib9/gHGWwTDLfElVl2TVHo59+PlUjZXwWbKXn
         g34ffK1upYiGkve9TcgSCFheOQoFet00lvgYTSy76AS3IfROqU5uXI8ICbiFPg9jDG4g
         2p9kPKgAc/HLRmNmSrHHyvu8BznKlDrqvvh0eyyB15I2bdRy0CmVsufO9jHXl3LVnQam
         RFh/sPCgsHU7lLUh91NE99fh0cdns99W4GJ+YvzguW4sWEQgMGtMyfqGqoIx0mE7zwqU
         Uo0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=SfF/Z0ScslK5LaLkBhpaNHR++tEupceqm51lspaZqiM=;
        b=exUJfTFlTCyo8DT64SuTqSMZg1ya6CSmd8PUPUL4IhNLbxwggC8Ypmf5Nq7mwtijzo
         win0SPimiZQrMG7Q21e6Q+9qwD3Hkfqve1AViGmWdl6hvrByZtvE8jCKm1uEmH9Qdlh4
         mZeVo3QL3gEniyrYPHNuTeu3EJChfh1kPJF2NS1BJOT7IbZt6nyrKJPvYWVuRWRTC4cv
         sYtiZaD0ncodjn53LYfVKRrq7k55WxNbg/6epFiQ1mv0QPNBqu2FX/Dtjue9HXKSKEfa
         ymL/qdGJ3Z+/lS/Js1z29ofu+J22/2V9qHasXEzhX1UenZPz1hPrXglxgSYKPRnhYtNI
         wb6g==
X-Gm-Message-State: AOAM530AmXj1yEIcFr7CrEk5M78W2GyjpjCYLBmwS2Dnq1hl4HivWLHG
        SZWGpsQAvOVAXa0SAxMnW8aHrQ==
X-Google-Smtp-Source: ABdhPJx+6i48QujB/q23eIBm0/+BBwJrzJlGWxuHq8FnVpASMhOEM1EnDigno4QWiwiJQGVCZ8Um2w==
X-Received: by 2002:a17:90a:2e03:: with SMTP id q3mr15884562pjd.206.1619420429503;
        Mon, 26 Apr 2021 00:00:29 -0700 (PDT)
Received: from C02DV8HUMD6R.bytedance.net ([139.177.225.224])
        by smtp.gmail.com with ESMTPSA id w14sm4535047pfn.3.2021.04.26.00.00.26
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 26 Apr 2021 00:00:29 -0700 (PDT)
From:   Abel Wu <wuyun.abel@bytedance.com>
To:     akpm@linux-foundation.org, lizefan.x@bytedance.com, tj@kernel.org,
        hannes@cmpxchg.org, corbet@lwn.net
Cc:     cgroups@vger.kernel.org, linux-mm@kvack.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Abel Wu <wuyun.abel@bytedance.com>
Subject: [PATCH 3/3] docs/admin-guide/cgroup-v2: add cpuset.mems.migration
Date:   Mon, 26 Apr 2021 14:59:46 +0800
Message-Id: <20210426065946.40491-4-wuyun.abel@bytedance.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210426065946.40491-1-wuyun.abel@bytedance.com>
References: <20210426065946.40491-1-wuyun.abel@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Add docs for new interface cpuset.mems.migration, most of which
are stolen from cpuset(7) manpages.

Signed-off-by: Abel Wu <wuyun.abel@bytedance.com>
---
 Documentation/admin-guide/cgroup-v2.rst | 36 +++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/Documentation/admin-guide/cgroup-v2.rst b/Documentation/admin-guide/cgroup-v2.rst
index b1e81aa8598a..abf6589a390d 100644
--- a/Documentation/admin-guide/cgroup-v2.rst
+++ b/Documentation/admin-guide/cgroup-v2.rst
@@ -2079,6 +2079,42 @@ Cpuset Interface Files
 	Changing the partition state of an invalid partition root to
 	"member" is always allowed even if child cpusets are present.
 
+  cpuset.mems.migration
+	A read-write single value file which exists on non-root
+	cpuset-enabled cgroups.
+
+	Only the following migration modes are defined.
+
+	  ========	==========================================
+	  "none"	migration disabled [default]
+	  "sync"	move pages to cpuset nodes synchronously
+	  "lazy"	move pages to cpuset nodes on second touch
+	  ========	==========================================
+
+	By default, "none" mode is enabled. In this mode, once a page
+	is allocated (given a physical page of main memory) then that
+	page stays on whatever node it was allocated, so long as it
+	remains allocated, even if the cpusets memory placement policy
+	'cpuset.mems' subsequently changes.
+
+	If "sync" mode is enabled in a cpuset, when the 'cpuset.mems'
+	setting is changed, any memory page in use by any process in
+	the cpuset that is on a memory node that is no longer allowed
+	will be migrated to a memory node that is allowed synchronously.
+	The relative placement of a migrated page within the cpuset is
+	preserved during these migration operations if possible.
+
+	The "lazy" mode is almost the same as "sync" mode, except that
+	it doesn't move the pages right away. Instead it sets these
+	pages to protnone, and numa faults triggered by second touching
+	these pages will handle the movement.
+
+	Furthermore, if a process is moved into a cpuset with migration
+	enabled ("sync" or "lazy" enabled), any memory pages it uses
+	that on memory nodes allowed in its previous cpuset, but which
+	are not allowed in its new cpuset, will be migrated to a memory
+	node allowed in the new cpuset.
+
 
 Device controller
 -----------------
-- 
2.31.1

