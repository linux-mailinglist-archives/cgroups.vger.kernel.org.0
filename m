Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A1B05367D2E
	for <lists+cgroups@lfdr.de>; Thu, 22 Apr 2021 11:06:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235339AbhDVJHA (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 22 Apr 2021 05:07:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232896AbhDVJG7 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 22 Apr 2021 05:06:59 -0400
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F07AC06174A
        for <cgroups@vger.kernel.org>; Thu, 22 Apr 2021 02:06:24 -0700 (PDT)
Received: by mail-pg1-x52d.google.com with SMTP id d10so32363443pgf.12
        for <cgroups@vger.kernel.org>; Thu, 22 Apr 2021 02:06:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=SfF/Z0ScslK5LaLkBhpaNHR++tEupceqm51lspaZqiM=;
        b=DDJ1gaaHVhTnJEYif/PYB82fh8uyWeB0mKRq575+v9VXDwnUsvR0QZrLWnxhvjzeKP
         GBvaClcBVchRRh34BoRsfFf/JWIhLmVsBHRGBlfCpxnj3LFsc9mZ9E16wl3fhjnx0PwI
         YML3XbmzkG6cmYHj4FydNXJewHjMOjfmq9jPXRqt05Ktm5GVHcWQQJxN7gRVaN01chh7
         VlB5G0U1VIGpRexa5T40CJpjITNHl/c/2zMpH5u3Smlih3z8dkCcp0EnuCh3ymT06htv
         dsBv1yoDXNEaPYqKFMIKnRDUmHgudqSxqy8zkT1AR5nLtXTOW/0Gf+G6hEN5rC3/u7t7
         Kb5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=SfF/Z0ScslK5LaLkBhpaNHR++tEupceqm51lspaZqiM=;
        b=ZdtqFmWzvwKcTdrlC3jlPu8xRsOqih3JTZOD0JhE7h3XHXdpSmWLExmZTx9FpRlE2V
         1tLczSJMGiU5NnsazOXs2fuc/Obd17iYl6u7UmZ1IMd8KybKgS2O0ZImCvMmSyjQ5vOg
         zI4WAna5s0YeY9oRiMNLNVVmeIFpgkDQLFVhQwKZkY9XTPIqDSIYhhqjbrMYkKt6pzvd
         uk+/ihHZRAJDbzn3RnVE8T4qo2HueQT2dyeecJogNehNh7WWKX11q/U7ZcY51WC+DMtE
         efxFYWO8OFBS5EuptvsJJbBWkLFUDy+AUXcSKAW/QPcguKb4f9yf0Smeu1+aDw6VbrcI
         StUQ==
X-Gm-Message-State: AOAM531wKjuUzat+gtQhoIpO0WbEHq3aLMpaho0iMWBbiChFbNOhmWgZ
        VbS5V9OJeuNYzoFk7Fi3IGZ0FQ==
X-Google-Smtp-Source: ABdhPJxIjtKJshdj00uAYNjGJ/vZ/LJ4kTMFy2Md31l7tYMpW1iId+EC+yEwM0P1TWU1YGqa6vJfgw==
X-Received: by 2002:a65:6704:: with SMTP id u4mr2499719pgf.169.1619082384007;
        Thu, 22 Apr 2021 02:06:24 -0700 (PDT)
Received: from C02DV8HUMD6R.bytedance.net ([139.177.225.240])
        by smtp.gmail.com with ESMTPSA id x2sm1514348pfu.77.2021.04.22.02.06.21
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 22 Apr 2021 02:06:23 -0700 (PDT)
From:   Abel Wu <wuyun.abel@bytedance.com>
To:     akpm@linux-foundation.org, lizefan.x@bytedance.com, tj@kernel.org,
        hannes@cmpxchg.org, corbet@lwn.net
Cc:     cgroups@vger.kernel.org, linux-mm@kvack.org
Subject: [PATCH 3/3] docs/admin-guide/cgroup-v2: add cpuset.mems.migration
Date:   Thu, 22 Apr 2021 17:06:08 +0800
Message-Id: <20210422090608.7160-4-wuyun.abel@bytedance.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210422090608.7160-1-wuyun.abel@bytedance.com>
References: <20210422090608.7160-1-wuyun.abel@bytedance.com>
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

