Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0563265ECB4
	for <lists+cgroups@lfdr.de>; Thu,  5 Jan 2023 14:18:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232698AbjAENRr (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 5 Jan 2023 08:17:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234263AbjAENRW (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 5 Jan 2023 08:17:22 -0500
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE3C45C1E1;
        Thu,  5 Jan 2023 05:17:05 -0800 (PST)
Received: by mail-pl1-x629.google.com with SMTP id c6so6090671pls.4;
        Thu, 05 Jan 2023 05:17:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XHKqH/mTeMAtJX+k1fwhOFwTW56tZzYBJVqR/bzkhlc=;
        b=XkW/T1soWfm4Rl1XX1uhjbNQfx1mx3n00vAID2EM9vtxWbYXinFO4hH0F/Sh76u8Nt
         T+gnK2msfrDFO1KmUccj24rF4UB8vifHeM6vVJGG4BqzWmkF5LR+KlioizvkKNFhtzGI
         DqZ08ByEgPPDNotBdzpS9VmCEyShtWZsvx3n8EAJPOHu1HX5kpNBORHmuWbj2c2tqTYV
         kKkA+xB6Fxx4Jc5iZgdCkvewR5ElvC1Q8mCbRjR5m0aVPDHOhmprl5Z6bpMJhV7aZOd2
         jqwuT8bQYA/2qPzKPL/nYTtz+E24L3VfdAWrshv08AHCMMHGZLUBryatFJX7kP89y92r
         Wa8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XHKqH/mTeMAtJX+k1fwhOFwTW56tZzYBJVqR/bzkhlc=;
        b=OTnm15MrmWvEsb1fHRhF7/EhgHWSnSUPd3G5hi+g8G02IKZK2NB9F+jVNMki++uv3l
         hJBPp7rkIE15AE4m2XnyN3WN/omFDH74iCZsYhGG9QtTgFjY4YdvHQNLjVpI7XCnq/Bv
         gslPwL7Upzm3X9QhR4E9A8oD1va6p31RCt7ji9kFc+sKfMBGz2I8hWeMhZxJgQRs2bf2
         C+Lo1o1Q66iiB6XJyFGBmAKFMgQp053z9PT/VyYoLf+sW8kteOuTa6IyqNgym5chiAoa
         ic9Y9m0mIQAgrDma9EffSidmUB2fqSgwQMEbEaFxsg+2BJzy6N+SJhYJcyhgt0uJau3y
         V5BA==
X-Gm-Message-State: AFqh2kqA52J4xnV0TNSqPeQalVBUQx3NSw0xYBvgriIl/PNssCvitAcB
        TBdJwvuAmPfWPe3vYUCCvdI=
X-Google-Smtp-Source: AMrXdXuI/wFI9NZprHDOZ4C4Pqbm5J8rbYDJ/NE13dBSqovxsPA/Y3l0huJb190MwMO5oSrbIdxjoA==
X-Received: by 2002:a17:902:d491:b0:192:ad82:dc98 with SMTP id c17-20020a170902d49100b00192ad82dc98mr31433592plg.34.1672924625229;
        Thu, 05 Jan 2023 05:17:05 -0800 (PST)
Received: from debian.me (subs02-180-214-232-68.three.co.id. [180.214.232.68])
        by smtp.gmail.com with ESMTPSA id i2-20020a170902c94200b00189618fc2d8sm26053948pla.242.2023.01.05.05.17.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Jan 2023 05:17:04 -0800 (PST)
Received: by debian.me (Postfix, from userid 1000)
        id 9720A1043E8; Thu,  5 Jan 2023 20:16:59 +0700 (WIB)
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     Linux CGroups <cgroups@vger.kernel.org>,
        Linux Documentation <linux-doc@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>
Cc:     Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Michal Hocko <mhocko@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>,
        Shakeel Butt <shakeelb@google.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>
Subject: [PATCH v2 3/9] docs: cgroup-v1: use code block for locking order schema
Date:   Thu,  5 Jan 2023 20:16:28 +0700
Message-Id: <20230105131633.553574-4-bagasdotme@gmail.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230105131633.553574-1-bagasdotme@gmail.com>
References: <20230105131633.553574-1-bagasdotme@gmail.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=903; i=bagasdotme@gmail.com; h=from:subject; bh=IgqigKn9DkjPklU4lRTNbnqTt63GfYY/akiSBYrKIlo=; b=owGbwMvMwCX2bWenZ2ig32LG02pJDMnbzq4XDnK5Z2Dspp/XK6O/hDH/vy9jfrHcT7XO5Wcey2i5 SQp3lLIwiHExyIopskxK5Gs6vctI5EL7WkeYOaxMIEMYuDgFYCICVQz/a/lu5hjddea89ev3r8tRkp XRb02+MnYu/XFlWaNkJntyKyPDAc1vbdt6LNecrSx/q+j+h/XJHfs98c6Fk0yPFO7av6OBHQA=
X-Developer-Key: i=bagasdotme@gmail.com; a=openpgp; fpr=701B806FDCA5D3A58FFB8F7D7C276C64A5E44A1D
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

The locking order schema is a figure (like diagram), which should have
been formatted with literal code block for consistency with other
figures.

Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
---
 Documentation/admin-guide/cgroup-v1/memory.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/admin-guide/cgroup-v1/memory.rst b/Documentation/admin-guide/cgroup-v1/memory.rst
index b0353c40639b7e..2b807fc128c662 100644
--- a/Documentation/admin-guide/cgroup-v1/memory.rst
+++ b/Documentation/admin-guide/cgroup-v1/memory.rst
@@ -287,7 +287,7 @@ When oom event notifier is registered, event will be delivered.
 2.6 Locking
 -----------
 
-Lock order is as follows:
+Lock order is as follows::
 
   Page lock (PG_locked bit of page->flags)
     mm->page_table_lock or split pte_lock
-- 
An old man doll... just what I always wanted! - Clara

