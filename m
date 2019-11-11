Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9CC62F76CF
	for <lists+cgroups@lfdr.de>; Mon, 11 Nov 2019 15:44:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726913AbfKKOol (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 11 Nov 2019 09:44:41 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:35229 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726853AbfKKOol (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 11 Nov 2019 09:44:41 -0500
Received: by mail-wm1-f67.google.com with SMTP id 8so13498262wmo.0
        for <cgroups@vger.kernel.org>; Mon, 11 Nov 2019 06:44:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chrisdown.name; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=jpUzAZEpApOMVMIW0Fqf4/xrL7Q7nYI9jKjTWCa/2z8=;
        b=OS76QWxrRsPKqu6mUeCbMb9Joyk0TTB7Vdtx082xBJahs8lh9PNXAOwoS8XFicAgnI
         S/inQqa37xoc1IvkPXcEYEx81Bda9cHzMfpc6CFPjL+XDAaptyTPwCVnrscdIIwD1Bcc
         L8WJGGl/hHN28w0gmLwzm7pWVT5CtEgO2zfj0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=jpUzAZEpApOMVMIW0Fqf4/xrL7Q7nYI9jKjTWCa/2z8=;
        b=LwNtdkyLv7DjFahzje1iA1kTrgQQBSdQK5fsteZ31BZiH4ZrzqfiIEDSdZ0TpBkYXx
         y+Xnpa79d/cWRxSiIMXMsFwS5t7v0EO30IRNrbUtqSkbWEhwq1WXi5IBYn4G6VtBXyl+
         73VNOyI9MrWlqHEOjx9WXCqtRT8RICictF2CttBvIoewCCUQkTyGSd2zVMw6EM9u5TBk
         TQGANFUXiFbD7t5vGXVjG+55Z9Hq9j3O/8624B1bgwYTH0wUPHQJ3Tel3EZ5H8jOF18D
         KR965icTADi/+XTQj2/JdPIzVM2IbXa4+8zLdAt8qI1OCLrDomyRiYrd9MdgD1iTj3dC
         cIEg==
X-Gm-Message-State: APjAAAV5LDapIHlkzobj2/2mk0KFA4wiEx9QV0//k9nLJyPKvRDVtv/Q
        S7zjRmRjyPQJWiuv7NMCA2k5Bw==
X-Google-Smtp-Source: APXvYqwNzJJfn5BWH0Qn+AAZlUvMuNy+Dst6UH30y5ZNHAIU1t3O2wV8umKCGn0kc/pyjW9LijsBXw==
X-Received: by 2002:a1c:7f94:: with SMTP id a142mr19888187wmd.33.1573483479073;
        Mon, 11 Nov 2019 06:44:39 -0800 (PST)
Received: from localhost ([2620:10d:c092:180::1:3e35])
        by smtp.gmail.com with ESMTPSA id p4sm18608305wrx.71.2019.11.11.06.44.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Nov 2019 06:44:38 -0800 (PST)
Date:   Mon, 11 Nov 2019 14:44:38 +0000
From:   Chris Down <chris@chrisdown.name>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        linux-mm@kvack.org, kernel-team@fb.com
Subject: [PATCH] docs: cgroup: mm: Fix spelling of "list"
Message-ID: <20191111144438.GA11327@chrisdown.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Signed-off-by: Chris Down <chris@chrisdown.name>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org
Cc: cgroups@vger.kernel.org
Cc: linux-mm@kvack.org
Cc: kernel-team@fb.com
---
 Documentation/admin-guide/cgroup-v2.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/admin-guide/cgroup-v2.rst b/Documentation/admin-guide/cgroup-v2.rst
index ed9123155e03..0704552ed94f 100644
--- a/Documentation/admin-guide/cgroup-v2.rst
+++ b/Documentation/admin-guide/cgroup-v2.rst
@@ -1335,7 +1335,7 @@ PAGE_SIZE multiple when read back.
 
 	  pgdeactivate
 
-		Amount of pages moved to the inactive LRU lis
+		Amount of pages moved to the inactive LRU list
 
 	  pglazyfree
 
-- 
2.24.0

