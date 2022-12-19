Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A97B4650713
	for <lists+cgroups@lfdr.de>; Mon, 19 Dec 2022 05:22:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231394AbiLSEWk (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Sun, 18 Dec 2022 23:22:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231290AbiLSEWX (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Sun, 18 Dec 2022 23:22:23 -0500
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 478A864C9;
        Sun, 18 Dec 2022 20:22:22 -0800 (PST)
Received: by mail-pj1-x1033.google.com with SMTP id b13-20020a17090a5a0d00b0021906102d05so7694172pjd.5;
        Sun, 18 Dec 2022 20:22:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rf1ACU1p6R9dNKmN5MUoIBYgA/aDmrGTefWeFw4FNFs=;
        b=VVMSfTlUA9HuhH9vvEonzOiWvAjByqAsh2y6ihUJpOuzLOlRxVdAkLfNeqbgB7+jiV
         d4PUUkwZjROAjnuSiuOXJuaumnRRKMFKmX+3ii+MFBcQEGk7orUj/VXGC5/ZzxMHMMKK
         s/K7XksauWGoqPHEoVii9LOZFwR7B1plzXiad4PktoblqlbNXJhiBBTXFxwNMeYHz/uz
         P6il3KL0zXD/Yyig85v008Cl4r4AWYuO+g4f96/sJXngmDBKIKapc3Vt5HTZdz8Fo96G
         f7r2t+Dg4DytpKegAj6jU2kpEgWAnH9sYDGmaxF4wbwIRicVejpWwdZw0XQ1DirZ28ey
         wl4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rf1ACU1p6R9dNKmN5MUoIBYgA/aDmrGTefWeFw4FNFs=;
        b=5l1B0mzo3gWNV0/eDoOoKBZwjfpIKqD+YPg8OCIo7KVakFX7vzHDFYcfiC+x/636xm
         WcXXVOqIvYXzeZpCkzavo0fRpldO/SXHp7zZLXVCWMxuoU9k5nneafpvkewFBBGLRL+y
         kBYd1tD3Ab7Pm6gAahmL4oiVc/+iHYWTwCPi5EDLrdkzE0+WhV1udZrLfFGewT/nVkpC
         JPETDTJnVHHsiXz808u9KxPPS6POYGPvTnoUBiTqoS7zAgJyYwW5Rr2bDMPohRU+WalV
         cs2qCxIDd81fXtoJq+qqYKIJWVKm3DazpjFFtGvZDNVBqYlQFKlFCPgLSlon11ptoCzO
         La0w==
X-Gm-Message-State: ANoB5pnwgy8p/HPppb1TvbnuG6cg8ZOIWbL/iDnwuFHiMd8f/6PrSGy2
        h9Euv5vPk4DKkrQMKYcU1qw=
X-Google-Smtp-Source: AA0mqf4hJrb1IMUCZfOeuiwBA1GJDdg+PA3U0hxFCMyXPUKIjGvqxIvxN+tzPJNknaNV1Df+ifL/1w==
X-Received: by 2002:a17:902:6bcc:b0:188:5256:bf60 with SMTP id m12-20020a1709026bcc00b001885256bf60mr39973300plt.25.1671423741785;
        Sun, 18 Dec 2022 20:22:21 -0800 (PST)
Received: from debian.me (subs32-116-206-28-20.three.co.id. [116.206.28.20])
        by smtp.gmail.com with ESMTPSA id e10-20020a17090301ca00b00189af02aba4sm5911773plh.3.2022.12.18.20.22.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Dec 2022 20:22:19 -0800 (PST)
Received: by debian.me (Postfix, from userid 1000)
        id 5AC8A104051; Mon, 19 Dec 2022 11:22:13 +0700 (WIB)
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     cgroups@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Linux Memory Management List <linux-mm@kvack.org>
Cc:     Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Michal Hocko <mhocko@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>,
        Shakeel Butt <shakeelb@google.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        kernel test robot <lkp@intel.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Subject: [PATCH 01/10] docs: cgroup-v1: extend underline of section 8
Date:   Mon, 19 Dec 2022 11:22:00 +0700
Message-Id: <20221219042209.22898-2-bagasdotme@gmail.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20221219042209.22898-1-bagasdotme@gmail.com>
References: <20221219042209.22898-1-bagasdotme@gmail.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1318; i=bagasdotme@gmail.com; h=from:subject; bh=0T+nIwJE0sYswok26CNbNxcSAtUv7ROGjQG7VnVQn2o=; b=owGbwMvMwCX2bWenZ2ig32LG02pJDMnzn71NK+ZaFhzc2aXak8LgGWHHYbhsgYtg6swzgg+TxHY0 XvnYUcrCIMbFICumyDIpka/p9C4jkQvtax1h5rAygQxh4OIUgIlkcTIyLJWR8X/FmmKllbdoCVviWs tEk6mP/c6cYhAU2hQbGnFCkuGfdtXiks0XNS6t+VKZce3olRLBlsg6oTkyWwuXXXOxFNvIAAA=
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

kernel test robot and Stephen Rothwell reported htmldocs warning:

Documentation/admin-guide/cgroup-v1/memory.rst:723: WARNING: Title underline too short.

Extend underline in section 8 heading to match the text in order to fix
the warning.

Link: https://lore.kernel.org/linux-doc/202212180030.OzPG7QHL-lkp@intel.com/
Link: https://lore.kernel.org/linux-next/20221218062235.443758ae@canb.auug.org.au/
Fixes: f8bc956f6ea695 ("mm: memcontrol: deprecate charge moving")
Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
---
 Documentation/admin-guide/cgroup-v1/memory.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/admin-guide/cgroup-v1/memory.rst b/Documentation/admin-guide/cgroup-v1/memory.rst
index 87d7877b98ec79..258e45cc3b2db1 100644
--- a/Documentation/admin-guide/cgroup-v1/memory.rst
+++ b/Documentation/admin-guide/cgroup-v1/memory.rst
@@ -720,7 +720,7 @@ NOTE2:
        otherwise the hard limit will take precedence.
 
 8. Move charges at task migration (DEPRECATED!)
-=================================
+===============================================
 
 THIS IS DEPRECATED!
 
-- 
An old man doll... just what I always wanted! - Clara

