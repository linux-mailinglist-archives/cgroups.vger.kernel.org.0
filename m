Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE7CB40F837
	for <lists+cgroups@lfdr.de>; Fri, 17 Sep 2021 14:44:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236050AbhIQMps (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 17 Sep 2021 08:45:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235213AbhIQMpr (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 17 Sep 2021 08:45:47 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DF9DC061574;
        Fri, 17 Sep 2021 05:44:25 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id 5so6122525plo.5;
        Fri, 17 Sep 2021 05:44:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=EiFaqxi/eMHI447ra+FWT3fM5Oq58Q8AgI3FLcLHOAk=;
        b=lE/hBth4NSTIJYnhOU8/q6QQoji0WAiiMiQlUlzCPKOIEiuWqYCdA76+fB9r00FtqV
         6osBE4goQE2YTrzuignkcFCXu2VjGV4A7zRu/JuA8GzPM7AgzsaEw0HEXeWjnoLWH8BS
         2zrW3Ek2IwTGZCuKgk3Hdjpmo21EZ8mwxXXnQiQuuNQBvaIATtR+TYLFZTU9EJ+Mq/vb
         DChLAY/+A8PVej5zTgHYxg7ksBLoeIBh8mXbkshfrQViBP3Ncxm3/JRLCD4Q7ZiyX+G6
         ecsYLjFNcsqS3HRSmBijqBrDQP7De4FGMNFW5zXWtxC9dBzSDbgapbg/UNvgGgtNVrGF
         +Pyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=EiFaqxi/eMHI447ra+FWT3fM5Oq58Q8AgI3FLcLHOAk=;
        b=CD+tufqCu3a1BnDwK6slnPtzBaETOHcaTyw/ni1uGHxnvuJKLqSkKefLjnX+HLdvFw
         EQK1xmlc56me+UOtS+h6xuIyLgGKbOpdM0r8DM5ErywvTJo6PPh1NduMzTSzCD3eXWIs
         rFhcf5ZTUOkfH04ZNITMZFixVDhm7+rcvItwTWiFyMYpdrq+QDObOvV8znTQZ1xMhujO
         O3tFuNwFZiNijlnJNWON9abbjOMoVtdyf9UHc+7+sUXFWIw8wwRxz22NAtxFTcRttAEz
         xW/LY3FZRLw8Rhn9V37/RKrdI9Qd1ENW9OVFjmUZXH0x++5haWfGmMYGlzksrRWTdx26
         8tyg==
X-Gm-Message-State: AOAM532cKjEeWyBSJ4Z+HtV9T7Qjz+trJtd2gqmI0sgvW/Bgc+1N4NHs
        qm9QAIWjnENmeGjp0mI9zM8=
X-Google-Smtp-Source: ABdhPJww0lTIRQxBF0JHclBT1Y516JTZsbmPq5RYMXx40KmVhGe90WXWR9ouVqdqDDWk/GW+Ex+1Ew==
X-Received: by 2002:a17:90b:78d:: with SMTP id l13mr12250113pjz.239.1631882664814;
        Fri, 17 Sep 2021 05:44:24 -0700 (PDT)
Received: from VM-0-3-centos.localdomain ([101.32.213.191])
        by smtp.gmail.com with ESMTPSA id n185sm6570299pfn.171.2021.09.17.05.44.23
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 17 Sep 2021 05:44:24 -0700 (PDT)
From:   brookxu <brookxu.cn@gmail.com>
To:     tj@kernel.org, lizefan.x@bytedance.com, hannes@cmpxchg.org
Cc:     vipinsh@google.com, mkoutny@suse.com, corbet@lwn.net,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        linux-doc@vger.kernel.org
Subject: [PATCH v4 3/3] docs/cgroup: add entry for misc.events
Date:   Fri, 17 Sep 2021 20:44:16 +0800
Message-Id: <41b702e0e9ae88b5806f4253ed30e2f2c8e70776.1631881726.git.brookxu@tencent.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <3834f917d50a6f19402e179e917ef6a9dde5f64a.1631881726.git.brookxu@tencent.com>
References: <3834f917d50a6f19402e179e917ef6a9dde5f64a.1631881726.git.brookxu@tencent.com>
In-Reply-To: <3834f917d50a6f19402e179e917ef6a9dde5f64a.1631881726.git.brookxu@tencent.com>
References: <3834f917d50a6f19402e179e917ef6a9dde5f64a.1631881726.git.brookxu@tencent.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

From: Chunguang Xu <brookxu@tencent.com>

Added descriptions of misc.events.

Signed-off-by: Chunguang Xu <brookxu@tencent.com>
Reviewed-by: Michal Koutný <mkoutny@suse.com>
---
 Documentation/admin-guide/cgroup-v2.rst | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/Documentation/admin-guide/cgroup-v2.rst b/Documentation/admin-guide/cgroup-v2.rst
index babbe04..e7acc55 100644
--- a/Documentation/admin-guide/cgroup-v2.rst
+++ b/Documentation/admin-guide/cgroup-v2.rst
@@ -2310,6 +2310,16 @@ Miscellaneous controller provides 3 interface files. If two misc resources (res_
         Limits can be set higher than the capacity value in the misc.capacity
         file.
 
+  misc.events
+	A read-only flat-keyed file which exists on non-root cgroups. The
+	following entries are defined. Unless specified otherwise, a value
+	change in this file generates a file modified event. All fields in
+	this file are hierarchical.
+
+	  max
+		The number of times the cgroup's resource usage was
+		about to go over the max boundary.
+
 Migration and Ownership
 ~~~~~~~~~~~~~~~~~~~~~~~
 
-- 
1.8.3.1

