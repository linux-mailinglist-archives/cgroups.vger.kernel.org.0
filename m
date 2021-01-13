Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE7C42F46E1
	for <lists+cgroups@lfdr.de>; Wed, 13 Jan 2021 09:52:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726908AbhAMIuh (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 13 Jan 2021 03:50:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726863AbhAMIuh (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 13 Jan 2021 03:50:37 -0500
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49234C061575
        for <cgroups@vger.kernel.org>; Wed, 13 Jan 2021 00:49:57 -0800 (PST)
Received: by mail-pg1-x531.google.com with SMTP id 15so1059445pgx.7
        for <cgroups@vger.kernel.org>; Wed, 13 Jan 2021 00:49:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-transfer-encoding;
        bh=GmUxp2i9/ls4jbfKHAxa1rq9T2F6H/PzjNNAVFN28no=;
        b=Qx2TyElpWLNjYbk8m/+90E+AZnuXQ8WXuUpuX0eAPizIX/Mha1z7a6K6YofaVUWg2h
         T84cFo3H+Uv8POrtug45HUfPwwklSnYZ/LiHWEZiqg9ldhfOmuLzTlucKSEbeIxnJUtr
         em2v8fCzERnyXk1MMX0DirsvwWS1XOx4DdsQBZZIn2ERNBmMZx/qJ/GAlRHn/9Gv90hb
         NODDr/qA/2D/GlN6OzzmEbNrGqN9TsGu3EIHwXTF2ZyL95xdwHPqilukdQfz+VsFvrBb
         FeyBhtFHm5/UXuqzzS7kXPScpPwWYYJSfyl6qmT0YyQbX8+yWMlvW+9LS4HEp+AE2BtY
         UpjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-transfer-encoding;
        bh=GmUxp2i9/ls4jbfKHAxa1rq9T2F6H/PzjNNAVFN28no=;
        b=srb0AAmXaWP4d3WNQh84dOdMOTAH+uLEjtkiaE4MyYQv6fboohNBUtNVEaIW8oTLGb
         7OhMdXEME3QkpfarmzHUW1qHRBgfxreqwPOpJOLuR2Un/xq1LBHOJkjbN+2RO3sZhJnb
         WUUL/F5k8qwKcKuWGkb68gkDRWiqIMDtzH+XBkpwjE5wR0DFV51uWPxS5FZpOyFK9EXd
         57775sIChccgGs0nI0S3DRw+HCh1fGN8H5nj1jim9eSDSThGY6igSQt50YvnCNPlpOEi
         2ENYT9HZRtrQPPCuiWMe1hi56jKNIPxb/ge+fzZ0jWzTbHJHlaEG6N/QmWnkDyjoYZH7
         BiMg==
X-Gm-Message-State: AOAM5317hbPVKYdNQYFASzuSNVdF/7jqAzZRF2xzplxx0r6Y5iBOhI/c
        2lTqungqt/2s+k4Cuw2yopkj
X-Google-Smtp-Source: ABdhPJxp3EzdAAWpaHecQI2slXdclU8NBh50djNkVWJcuOamcVSQtVVNZIIysP17CnP+MP/jbURwpw==
X-Received: by 2002:a63:4d59:: with SMTP id n25mr1126715pgl.122.1610527796885;
        Wed, 13 Jan 2021 00:49:56 -0800 (PST)
Received: from [10.85.112.53] ([139.177.225.228])
        by smtp.gmail.com with ESMTPSA id q23sm1736420pgm.89.2021.01.13.00.49.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Jan 2021 00:49:56 -0800 (PST)
To:     tj@kernel.org
Cc:     Steve Wahl <steve.wahl@hpe.com>, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org
From:   Zefan Li <lizefan.x@bytedance.com>
Subject: [PATCH 1/2] MAINTAINERS: Remove stale URLs for cpuset
Message-ID: <75494a75-a74b-3dba-9846-7f51d805023a@bytedance.com>
Date:   Wed, 13 Jan 2021 16:49:51 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.6.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Those URLs are no longer accessable.

Reported-by: Steve Wahl <steve.wahl@hpe.com>
Signed-off-by: Zefan Li <lizefan.x@bytedance.com>
---
 MAINTAINERS | 2 --
 1 file changed, 2 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 546aa66428c9..89140540aa8d 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4494,8 +4494,6 @@ CONTROL GROUP - CPUSET
 M:	Li Zefan <lizefan@huawei.com>
 L:	cgroups@vger.kernel.org
 S:	Maintained
-W:	http://www.bullopensource.org/cpuset/
-W:	http://oss.sgi.com/projects/cpusets/
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup.git
 F:	Documentation/admin-guide/cgroup-v1/cpusets.rst
 F:	include/linux/cpuset.h
-- 
2.25.1

