Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 493FE65ECB8
	for <lists+cgroups@lfdr.de>; Thu,  5 Jan 2023 14:18:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231520AbjAENRs (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 5 Jan 2023 08:17:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234258AbjAENRW (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 5 Jan 2023 08:17:22 -0500
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B76D5AC61;
        Thu,  5 Jan 2023 05:17:06 -0800 (PST)
Received: by mail-pj1-x102b.google.com with SMTP id j8-20020a17090a3e0800b00225fdd5007fso1988680pjc.2;
        Thu, 05 Jan 2023 05:17:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EUYjmNJNX3EIHXC0Kg1oUFxJ9a1dGF+07OElWAzi70E=;
        b=pEf0tlDI14cg718e2UjLbBPIw6gz58pcBgl/mZqJb17JoDKmf4ebY3uoHvhwaYGc4d
         8//GhUDyynq9lR7EUZ6Jb13SOAUrqpVKd3I8d21JPwfc6OPxpWpQ3e7FAmPPoc503j4S
         Saszua8tfPTYOLVLfysVYmuwwkXPJjRc8sW4V2nJr++VrhuhpD8By2lx30peHyeKkghC
         MUn4aOiX7owa3KzqTQvF1fQL88hv2v21axjD4RoOxUlymmV266wrh+fKvf7Pv32Z7vLr
         lKQwQgQpgQdJ/DCU0VBUNvyV70VCzFBQKoJebskRh4/uNFBWOhqX2wTM8loT+ohIZLAf
         yj3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EUYjmNJNX3EIHXC0Kg1oUFxJ9a1dGF+07OElWAzi70E=;
        b=7m1fiC2fpla59L/zi0+jaHF1x1sNejBYLyVJ+rw3878YMtDEF7uGBGgGZjpkvhUMR9
         uJXDqn2H5GP0Wf4UKHnJRKTx6EcBKDgmanqYZT3a46s4qKw9tuU2weicOi+Cvmm1XN0S
         FHzgR85M89iBI+iiRR7qulDhAdpsaPKUNmmj60WoL/OET/vd/Dq4+w18RA5W6Ds3B6oJ
         m5qJ2FgJnqxC8R/dkpDLe6atTV9sfHdvuQKC0Wgm4JlBpuZ2DpJXGquXxHhfTAbNld3J
         0mWZtMwfCWCy9vIe/tjyI59JONkasBz4rvnDZM6SCgTiq0d1qriPbGfyTVQxLcJU6qaa
         gwVg==
X-Gm-Message-State: AFqh2kpAclPZKtSkp2/GOnNMPuyKIpgJw8Rswuugw7DC2O50zjg+7EXt
        89jjhnv2ccwPd+mHcYghy5o=
X-Google-Smtp-Source: AMrXdXv80mGohLQSKP7xW+IpL76jo1fslPpxki49NJnSCNujtCj69FbgIT810EatTBYqeEsTWpBMLw==
X-Received: by 2002:a17:902:8e81:b0:192:d5dc:c842 with SMTP id bg1-20020a1709028e8100b00192d5dcc842mr11888101plb.44.1672924625628;
        Thu, 05 Jan 2023 05:17:05 -0800 (PST)
Received: from debian.me (subs02-180-214-232-68.three.co.id. [180.214.232.68])
        by smtp.gmail.com with ESMTPSA id t7-20020a1709027fc700b00192d3e7eb8fsm7232005plb.252.2023.01.05.05.17.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Jan 2023 05:17:04 -0800 (PST)
Received: by debian.me (Postfix, from userid 1000)
        id AFE841048CD; Thu,  5 Jan 2023 20:16:59 +0700 (WIB)
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
Subject: [PATCH v2 2/9] docs: cgroup-v1: wrap remaining admonitions in admonition blocks
Date:   Thu,  5 Jan 2023 20:16:27 +0700
Message-Id: <20230105131633.553574-3-bagasdotme@gmail.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230105131633.553574-1-bagasdotme@gmail.com>
References: <20230105131633.553574-1-bagasdotme@gmail.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1148; i=bagasdotme@gmail.com; h=from:subject; bh=lVJicFMEl6ad4fCfED8HKHDv/aSeW7ylfz8qS3An+no=; b=owGbwMvMwCX2bWenZ2ig32LG02pJDMnbzq4vNBYKCd3bmcV9+5uUy0z7o9MXVf7QviLr+cXonYRX St7jjlIWBjEuBlkxRZZJiXxNp3cZiVxoX+sIM4eVCWQIAxenAEzk9CKGf9b/N0rf1hF0ce5oufcnok N88nLxF9U6JlvWFldayGfc9WVkWGDful9O0+7A0yDvRIf/St5zCg7L64uXOU4pVkrT0bXgBgA=
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

Wrap two other admonitions in appropriate blocks in order for readers to
pay more attention to block contents:

  * hint:: for editor's note
  * warning:: for move charges deprecation

Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
---
 Documentation/admin-guide/cgroup-v1/memory.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/admin-guide/cgroup-v1/memory.rst b/Documentation/admin-guide/cgroup-v1/memory.rst
index d0d8c780cb6bd9..b0353c40639b7e 100644
--- a/Documentation/admin-guide/cgroup-v1/memory.rst
+++ b/Documentation/admin-guide/cgroup-v1/memory.rst
@@ -13,7 +13,7 @@ Memory Resource Controller
       memory controller in this document. Do not confuse memory controller
       used here with the memory controller that is used in hardware.
 
-(For editors) In this document:
+.. hint::
       When we mention a cgroup (cgroupfs's directory) with memory controller,
       we call it "memory cgroup". When you see git-log and source code, you'll
       see patch's title and function names tend to use "memcg".
-- 
An old man doll... just what I always wanted! - Clara

