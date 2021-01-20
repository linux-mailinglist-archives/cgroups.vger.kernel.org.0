Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8EBCB2FC5A6
	for <lists+cgroups@lfdr.de>; Wed, 20 Jan 2021 01:21:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730890AbhATAU2 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 19 Jan 2021 19:20:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730751AbhATAT7 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 19 Jan 2021 19:19:59 -0500
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7DDAC061795;
        Tue, 19 Jan 2021 16:18:38 -0800 (PST)
Received: by mail-pj1-x102f.google.com with SMTP id lw17so2215539pjb.0;
        Tue, 19 Jan 2021 16:18:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=AdWaVN+/y4nB7k2Y/h5vFo2XQMYLD7PwO6KnTXo1gOs=;
        b=tc1iJDBzwbPdk+USFLGiRAiPsr6L571rZa3SCif6sTOwoQRJRXez/OTOLccvPK3pkU
         5ab1xxV1QurDk1JxI7Yv4IxskuIOSIzpdB8otapSda/VCvcU454FGalL9pPXpv0izXPD
         +HDMlU0j0o0hZNSHAih7DYTeaxiNhRtinyid5QBhYcHuflDF2gECapHYNPkdzmlW/aUq
         +LnQINaUPaw/Li6mThzwPrSUBSV6lZLcsAbu831MVkoRkutl/D6prMiTRVYlY0ySDwDb
         CVTVD+kFdzfOjkdu3DCRgshK+p2MXJCRU428sXP2CXbbVy5CVrRJUAv2feqRw2qdDKJ5
         uQJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=AdWaVN+/y4nB7k2Y/h5vFo2XQMYLD7PwO6KnTXo1gOs=;
        b=YY7FgUBbJLUNYdlAH9CgsC4s19LWDc397JEgxgvKIsW1t3bRwTYMLk0w2e70rysZdM
         TgUMd1xf4uQemVYRAI/e7S5EpX3sQPeDedL6JDNzlDw4y+qaNL6mLlf2Fndvs2nrIuOA
         RXprd0J2ZU14VT9N+KjjQrcjwutdAMAjb0mRYseofvQJN9rgC1O5u055sZviYcmKqU5A
         LL1SpzX5hVC2sO0cUGAGlQFNTuANSIupiMEtqhE3y+Jv+waNUUOtnYYvBNqkJm7kjpF0
         aFnDB021CdMGRshaYV3m/+1yc4LyR4/OKJ81f8eZp5xr7C2NCdeJef22jVVU3gfWarDI
         qM2Q==
X-Gm-Message-State: AOAM5320NiNgF7pMDjOZvK5wuHu9Ox2uZgiacq2oYdcJbfPROzZ78zx3
        TuilxPZvJIKb/resQEzhbjg=
X-Google-Smtp-Source: ABdhPJx9VVeGndW2F1dr9mKWg8iyAVD4T5rpGnvT4t7mC1edQDfhQj0voOPiSNU1LuDrK5weMC63Iw==
X-Received: by 2002:a17:902:a504:b029:da:fbca:d49 with SMTP id s4-20020a170902a504b02900dafbca0d49mr7245035plq.72.1611101918370;
        Tue, 19 Jan 2021 16:18:38 -0800 (PST)
Received: from kir-rhat.lan (c-76-104-243-248.hsd1.wa.comcast.net. [76.104.243.248])
        by smtp.gmail.com with ESMTPSA id y6sm227452pfn.123.2021.01.19.16.18.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Jan 2021 16:18:37 -0800 (PST)
From:   Kir Kolyshkin <kolyshkin@gmail.com>
To:     corbet@lwn.net
Cc:     linux-doc@vger.kernel.org, cgroups@vger.kernel.org,
        Kir Kolyshkin <kolyshkin@gmail.com>
Subject: [PATCH 10/10] docs/admin-guide/cgroup-v2: fix mount opt rendering
Date:   Tue, 19 Jan 2021 16:18:24 -0800
Message-Id: <20210120001824.385168-11-kolyshkin@gmail.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210120001824.385168-1-kolyshkin@gmail.com>
References: <20210120001824.385168-1-kolyshkin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Due to an extra empty line between the option and its description
it is rendered not like in other places.

Remove the empty lines to fix.

Signed-off-by: Kir Kolyshkin <kolyshkin@gmail.com>
---
 Documentation/admin-guide/cgroup-v2.rst | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/Documentation/admin-guide/cgroup-v2.rst b/Documentation/admin-guide/cgroup-v2.rst
index 136902cd0e98..14a7523c46a4 100644
--- a/Documentation/admin-guide/cgroup-v2.rst
+++ b/Documentation/admin-guide/cgroup-v2.rst
@@ -174,7 +174,6 @@ disabling controllers in v1 and make them always available in v2.
 cgroup v2 currently supports the following mount options.
 
   nsdelegate
-
 	Consider cgroup namespaces as delegation boundaries.  This
 	option is system wide and can only be set on mount or modified
 	through remount from the init namespace.  The mount option is
@@ -182,7 +181,6 @@ cgroup v2 currently supports the following mount options.
 	Delegation section for details.
 
   memory_localevents
-
         Only populate memory.events with data for the current cgroup,
         and not any subtrees. This is legacy behaviour, the default
         behaviour without this option is to include subtree counts.
@@ -191,7 +189,6 @@ cgroup v2 currently supports the following mount options.
         option is ignored on non-init namespace mounts.
 
   memory_recursiveprot
-
         Recursively apply memory.min and memory.low protection to
         entire subtrees, without requiring explicit downward
         propagation into leaf cgroups.  This allows protecting entire
-- 
2.29.2

