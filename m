Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D98E42FC5AE
	for <lists+cgroups@lfdr.de>; Wed, 20 Jan 2021 01:24:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727460AbhATAUn (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 19 Jan 2021 19:20:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730829AbhATAT7 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 19 Jan 2021 19:19:59 -0500
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDDCDC061786;
        Tue, 19 Jan 2021 16:18:35 -0800 (PST)
Received: by mail-pj1-x1035.google.com with SMTP id cq1so1011119pjb.4;
        Tue, 19 Jan 2021 16:18:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=sl4zutZNTqwn4UHJVbcHFIYb+Z0yDoOK+cSVT1ECB74=;
        b=FAHyInT2erztCE+Frd0/kZorfgt3mSLYhqmxotJ/K3i2LDdZRBYoJgcn7tUSgWTfzw
         BM26+JwBeo60N8US3bSpEdk0HWvme3LbqCwswE8pgfQVNmFp0K/f+0uPeGFMA1YtbhRr
         gPtTX0LU8yrS0yBRpSmlqo6gkoqnWv0tZUZSxJAVz1cDeRJLTnAzjMFKQk7ach94mZTv
         IhwMzPZaTfj6atx/BgF2GVQxKZ0ffcHSdL3n2qTskwNnfmnwRR6vjNP5nlcBQ7rgOYAc
         nlk8SUUZW7YU3fxXVhMeCpRj8vUniTNjl6SvKeuslH/OMGYmnKi0irIsPyh6Kfu0ZnOD
         2OaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=sl4zutZNTqwn4UHJVbcHFIYb+Z0yDoOK+cSVT1ECB74=;
        b=K8iVdPZWrtf3Wh43dibG+TjDtxXsomUCCp7V7W5DUTHGDgM1zogn/7wBPkbQK+1pMc
         KwhS7rYF+Xf/N/tKVk0IQC5YbqWd259vZKxhEBHrvxUgGHCCty9dXsryf3EHwSCtUvEZ
         ahQCmoCNUw/UpJvz2aGMWSsoVbTbT2vB20ijguy3OB+SDwlmWDKQ5km4PHqB9dgYc4xP
         krzLuOwpz7jHxz7rITZbt/1g0NX7p7v0ZzMKV/DpINKbdZcJLd/df2EnXwGgQp3kTZpp
         TnJ19bSYzwRP2lzHIeMHq9cHrKtBQy27OTVrrLGbC/Z4ama8Di3ghIUGjhy1bXSs3Id1
         1AqQ==
X-Gm-Message-State: AOAM533nVSI/946+6OyVmf5G6WcI2I4lXBcY/ZdwR20VaxAlVLbED4s0
        E3aIG4jslscJS6h6xW8io7w=
X-Google-Smtp-Source: ABdhPJyViBpgQc/KCmE2lm/MYZNB+KArwT2IPYy4YDHGdGm3XCKd3JPPOLBh/fh4+hW/AfqKCfyKEA==
X-Received: by 2002:a17:90b:1649:: with SMTP id il9mr2396241pjb.62.1611101915382;
        Tue, 19 Jan 2021 16:18:35 -0800 (PST)
Received: from kir-rhat.lan (c-76-104-243-248.hsd1.wa.comcast.net. [76.104.243.248])
        by smtp.gmail.com with ESMTPSA id y6sm227452pfn.123.2021.01.19.16.18.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Jan 2021 16:18:34 -0800 (PST)
From:   Kir Kolyshkin <kolyshkin@gmail.com>
To:     corbet@lwn.net
Cc:     linux-doc@vger.kernel.org, cgroups@vger.kernel.org,
        Kir Kolyshkin <kolyshkin@gmail.com>
Subject: [PATCH 07/10] docs/admin-guide: cgroup-v2: fix cgroup.type rendering
Date:   Tue, 19 Jan 2021 16:18:21 -0800
Message-Id: <20210120001824.385168-8-kolyshkin@gmail.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210120001824.385168-1-kolyshkin@gmail.com>
References: <20210120001824.385168-1-kolyshkin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Due to an extra vertical whitespace, this was not recognised
as a definition list entry, and thus was not rendered like
the rest of cgroupfs files.

Signed-off-by: Kir Kolyshkin <kolyshkin@gmail.com>
---
 Documentation/admin-guide/cgroup-v2.rst | 1 -
 1 file changed, 1 deletion(-)

diff --git a/Documentation/admin-guide/cgroup-v2.rst b/Documentation/admin-guide/cgroup-v2.rst
index 073f976d44ea..c1b6ffc286cf 100644
--- a/Documentation/admin-guide/cgroup-v2.rst
+++ b/Documentation/admin-guide/cgroup-v2.rst
@@ -788,7 +788,6 @@ Core Interface Files
 All cgroup core files are prefixed with "cgroup."
 
   cgroup.type
-
 	A read-write single value file which exists on non-root
 	cgroups.
 
-- 
2.29.2

