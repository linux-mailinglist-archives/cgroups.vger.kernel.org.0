Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 981312F46FE
	for <lists+cgroups@lfdr.de>; Wed, 13 Jan 2021 10:03:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727056AbhAMJA3 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 13 Jan 2021 04:00:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727325AbhAMJA2 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 13 Jan 2021 04:00:28 -0500
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 843D7C061786
        for <cgroups@vger.kernel.org>; Wed, 13 Jan 2021 00:59:48 -0800 (PST)
Received: by mail-pg1-x533.google.com with SMTP id 30so1077084pgr.6
        for <cgroups@vger.kernel.org>; Wed, 13 Jan 2021 00:59:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=khY3b9nNLG3pn8j5ObMad/IKodRFErErRiM9bDM1Hc4=;
        b=m6cG2SZeoQC7z+233pF69aduzYVErPg7kpJnAwKckGrYeox/3cz6OJTflqkC44PiAA
         Ua3Dnyw7IzJqquKUSYJT8KQNhPwx/nBUt+TMamSiADca5useKtiXMpzEHpsr0yAW9muC
         jeANNgo8BBvZTjbXVu0nauEXPnwXC+FSgBVFUQYVJwMwOYOo9saJkLZD6BIkz7JDKVR2
         pLzx/RtBzX8qVvXQ5W1+1ttaxU+EtbysSUCzkXMVGYWcUD+i61vC9rRSD4ttddp5Jesx
         uxlQgYEDUlk/5/yBIopyVL7CSZ2GQ+AMakMnm7G6Dx2eldCI/JXBv3SwktDO5jhdL+ej
         QURA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=khY3b9nNLG3pn8j5ObMad/IKodRFErErRiM9bDM1Hc4=;
        b=AC5HrG3iV3Zu/X88Mr/SC9iMWAXh5MCwsQIIV1oERO/8SwRpkaTf6Rlmt6luX/gwq3
         VbcFXvuajB4ypbXMpWB6hZIfFh/4YAzdwLEhTs/4KUKvih9AsIhdXhEGyEjo8v8YucG9
         dPlgZu+HB4I1sGSgCNPiE7hTT2p5wos2NprMJlpwkFMBKMSdrkHZ9wxo9PVmzQ3s/KmP
         8QD6ju2pomblfrZUpdQkl20SBEFLrmlo34EZxaC22yC1SQsNYWpFAyNNXwv7Ax0z/jEH
         p6rBWtyRzK5fFD5Vpek9QgAr8DJSek+PorxHrfEc0kgDwDHXJIadPsxC1KmE5XUBYAJm
         aaxg==
X-Gm-Message-State: AOAM531qd+SPK9Os2qexADJnMGhyi2rZ3/Oq0CXeS2YQL43yCxkIYqBI
        b4Cf2cM2GIDbsZAOHx+zqs0XVp9PePjIIm0vPw==
X-Google-Smtp-Source: ABdhPJwVWFuNi6dvy6mSyvRbPP0hwlr8Ien7QxybRLxE1DP9YCSVorjq8qfBj9l8qV1Qf5GS6SEOog==
X-Received: by 2002:a65:688a:: with SMTP id e10mr1141158pgt.347.1610528387165;
        Wed, 13 Jan 2021 00:59:47 -0800 (PST)
Received: from [10.85.112.53] ([139.177.225.228])
        by smtp.gmail.com with ESMTPSA id e10sm1738764pgu.42.2021.01.13.00.59.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Jan 2021 00:59:46 -0800 (PST)
Subject: [PATCH v2 2/2] MAINTAINERS: Update my email address
From:   Zefan Li <lizefan.x@bytedance.com>
To:     tj@kernel.org
Cc:     Steve Wahl <steve.wahl@hpe.com>, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <75494a75-a74b-3dba-9846-7f51d805023a@bytedance.com>
Message-ID: <f8fe9c3b-db08-50da-d207-0952be5d2b85@bytedance.com>
Date:   Wed, 13 Jan 2021 16:59:42 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <75494a75-a74b-3dba-9846-7f51d805023a@bytedance.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Signed-off-by: Zefan Li <lizefan.x@bytedance.com>
---
 MAINTAINERS | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 2a01cd3e0a2b..4987d1ce9ac6 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4448,7 +4448,7 @@ F:	include/linux/console*
 
 CONTROL GROUP (CGROUP)
 M:	Tejun Heo <tj@kernel.org>
-M:	Li Zefan <lizefan@huawei.com>
+M:	Zefan Li <lizefan.x@bytedance.com>
 M:	Johannes Weiner <hannes@cmpxchg.org>
 L:	cgroups@vger.kernel.org
 S:	Maintained
@@ -4472,7 +4472,7 @@ F:	block/blk-throttle.c
 F:	include/linux/blk-cgroup.h
 
 CONTROL GROUP - CPUSET
-M:	Li Zefan <lizefan@huawei.com>
+M:	Zefan Li <lizefan.x@bytedance.com>
 L:	cgroups@vger.kernel.org
 S:	Maintained
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup.git
-- 
2.11.0

