Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F17671F22F
	for <lists+cgroups@lfdr.de>; Thu,  1 Jun 2023 20:38:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232988AbjFASi1 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 1 Jun 2023 14:38:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232344AbjFASi0 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 1 Jun 2023 14:38:26 -0400
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 139F3197;
        Thu,  1 Jun 2023 11:38:24 -0700 (PDT)
Received: by mail-qt1-x833.google.com with SMTP id d75a77b69052e-3f6b24467deso8925261cf.1;
        Thu, 01 Jun 2023 11:38:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685644703; x=1688236703;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=SzJSGye10y66Z1Cc9RFPHp9tWIbjNHpbJLhF+8yAFeo=;
        b=Cbq9QM48Z6LYiuI0eqBqMNi7B0znBZKapVJt0GVsuDyMvxSqOoOaZQwp2T7lMVU3Zx
         6vyB5naOztqPiso2+220gnQtd5JjVJaDbxaSttSMzTcSWj7SkAmBNaK0txhjVmruGo+/
         +3t+dYZtvMALXnh2JgVqXPKP8guWh5uH9XCkoiW/N5iJCZ6PGIXJJwiRHdmdG3AHwoBp
         qqhA5WQUBLDTM1vLp6buhENr6YcISGoSQ3IIOvGhEYBUDgs4Fl0Ff3uXdG3CNyiYJ8lW
         kRbvXZro2PrOnkACkh0cd0Dlgbld8n02Cm03eJWGZukFomSV8qEO+7S2BoCbecgv/4a0
         SXLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685644703; x=1688236703;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SzJSGye10y66Z1Cc9RFPHp9tWIbjNHpbJLhF+8yAFeo=;
        b=LDlGsl4BP6ueJwLYbEf6I8bJMQo1VYFUifnLzb8iTVlWIFWA/Eey7apCSDJjsuUsBK
         MDCupYTbOHB/SamzHqS+fz/hNnVnnUKg7OBrC51+nyM2Y+0Y5LJ0FETAEFuhifr/b+9B
         Gb1jjc9CKc/VfgiPluOdvNGPy2ChSPYCtuVC22f9KxQ/0ROiTlzxN757tamsNjPvumKf
         dU4ls9Vda8a8MdHkbRYzQwt5KYCg28k2T4vXdWhaPTk/oI8WBuLccK3RbmYaFOMfk0PG
         TyHmop8yA06VRKr5NVuHt+Hdel5RzRCByk3RHZF+PFb+Mjnpnd5vGoyNs0e57dQpzbXp
         ZDkg==
X-Gm-Message-State: AC+VfDwCRo0GG8kRRTiv0vMEZ3gxxOrK9OU5xXvWesupchsvCV2+HSiD
        gqkQ3MeQt1tiaHBNe0ILjjNG60sQXn0=
X-Google-Smtp-Source: ACHHUZ5gbo+qw/W30N9qnWYAcqPQlVEp2ix3dGgsoRU7xMnCUyp7qp2704alYU1ZDDNBeYJGOQhQ0w==
X-Received: by 2002:ac8:5d91:0:b0:3f5:543:4c46 with SMTP id d17-20020ac85d91000000b003f505434c46mr10419890qtx.53.1685644703076;
        Thu, 01 Jun 2023 11:38:23 -0700 (PDT)
Received: from localhost ([2620:10d:c091:500::4:753b])
        by smtp.gmail.com with ESMTPSA id j21-20020ac85f95000000b003f6b8a6fd18sm8053703qta.96.2023.06.01.11.38.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Jun 2023 11:38:22 -0700 (PDT)
From:   Dan Schatzberg <schatzberg.dan@gmail.com>
To:     Tejun Heo <tj@kernel.org>
Cc:     Chris Down <chris@chrisdown.name>,
        Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Jonathan Corbet <corbet@lwn.net>,
        cgroups@vger.kernel.org (open list:CONTROL GROUP (CGROUP)),
        linux-doc@vger.kernel.org (open list:DOCUMENTATION),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] Documentation: Clarify usage of memory limits
Date:   Thu,  1 Jun 2023 11:38:19 -0700
Message-Id: <20230601183820.3839891-1-schatzberg.dan@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

The existing documentation refers to memory.high as the "main mechanism
to control memory usage." This seems incorrect to me - memory.high can
result in reclaim pressure which simply leads to stalls unless some
external component observes and actions on it (e.g. systemd-oomd can be
used for this purpose). While this is feasible, users are unaware of
this interaction and are led to believe that memory.high alone is an
effective mechanism for limiting memory.

The documentation should recommend the use of memory.max as the
effective way to enforce memory limits - it triggers reclaim and results
in OOM kills by itself.

Signed-off-by: Dan Schatzberg <schatzberg.dan@gmail.com>
---
 Documentation/admin-guide/cgroup-v2.rst | 22 ++++++++++------------
 1 file changed, 10 insertions(+), 12 deletions(-)

diff --git a/Documentation/admin-guide/cgroup-v2.rst b/Documentation/admin-guide/cgroup-v2.rst
index f67c0829350b..e592a9364473 100644
--- a/Documentation/admin-guide/cgroup-v2.rst
+++ b/Documentation/admin-guide/cgroup-v2.rst
@@ -1213,23 +1213,25 @@ PAGE_SIZE multiple when read back.
 	A read-write single value file which exists on non-root
 	cgroups.  The default is "max".
 
-	Memory usage throttle limit.  This is the main mechanism to
-	control memory usage of a cgroup.  If a cgroup's usage goes
+	Memory usage throttle limit.  If a cgroup's usage goes
 	over the high boundary, the processes of the cgroup are
 	throttled and put under heavy reclaim pressure.
 
 	Going over the high limit never invokes the OOM killer and
-	under extreme conditions the limit may be breached.
+	under extreme conditions the limit may be breached. The high
+	limit should be used in scenarios where an external process
+	monitors the limited cgroup to alleviate heavy reclaim
+	pressure.
 
   memory.max
 	A read-write single value file which exists on non-root
 	cgroups.  The default is "max".
 
-	Memory usage hard limit.  This is the final protection
-	mechanism.  If a cgroup's memory usage reaches this limit and
-	can't be reduced, the OOM killer is invoked in the cgroup.
-	Under certain circumstances, the usage may go over the limit
-	temporarily.
+	Memory usage hard limit.  This is the main mechanism to limit
+	memory usage of a cgroup.  If a cgroup's memory usage reaches
+	this limit and can't be reduced, the OOM killer is invoked in
+	the cgroup. Under certain circumstances, the usage may go
+	over the limit temporarily.
 
 	In default configuration regular 0-order allocations always
 	succeed unless OOM killer chooses current task as a victim.
@@ -1238,10 +1240,6 @@ PAGE_SIZE multiple when read back.
 	Caller could retry them differently, return into userspace
 	as -ENOMEM or silently ignore in cases like disk readahead.
 
-	This is the ultimate protection mechanism.  As long as the
-	high limit is used and monitored properly, this limit's
-	utility is limited to providing the final safety net.
-
   memory.reclaim
 	A write-only nested-keyed file which exists for all cgroups.
 
-- 
2.34.1

