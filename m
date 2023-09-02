Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D312790797
	for <lists+cgroups@lfdr.de>; Sat,  2 Sep 2023 13:32:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352039AbjIBLcg (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Sat, 2 Sep 2023 07:32:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352004AbjIBLcf (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Sat, 2 Sep 2023 07:32:35 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59B8110F4;
        Sat,  2 Sep 2023 04:32:32 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id 5b1f17b1804b1-402c1407139so4586255e9.1;
        Sat, 02 Sep 2023 04:32:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693654351; x=1694259151; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8iUJUPxov9O7zxFefQw4YzTRyz6MbPYWWecwL9vIvnM=;
        b=g9FkVRxIaVqqzJSoWbK4CTrwNeh/oQsNE7WKVNhTwR2PL13PPCmCvtnr4D1L4qnld4
         r54kqdVFva6Z4qnzU9bTjUIl/kDuqRVGbEvBH0AnISJwlm3tNt2d3BuVMOny8RNlsOK4
         ZPj0D1dUgpRnsUUnHyutz2/wyoTtzBpfatNOZFRk4V/+0zKY1EC34VV7LYr7b2f7wi6N
         ZvJCD570pp5qZxEsIE0WFuk7kwSgVEiRcKvkFGjoCsz3T0N1+QMcbm1fIlDi8dNWEf+u
         qSgj0tuT9rW3Uksle010kvQK5t5EJ7x93aSteknzWzJhGsn8W/EGX2N0jmZG8u6fvxGO
         l59w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693654351; x=1694259151;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8iUJUPxov9O7zxFefQw4YzTRyz6MbPYWWecwL9vIvnM=;
        b=Qd56VGbBAFYjy7vUh/bLByS8T1hPz8rceZPlkdFH2icJiKnC2995QByZrvIZjOlYqg
         /s9mdakr9bCkwI+nTPegmTt9nCUAESvqlu/6sVgefiZP9lIlVs2Z7I3IHQGrZDFbGjxR
         VYQOOKrWZNfTzifq4xeoraGeXEINSSBuG68nQXP2ZEnsgjMgf8oLVJOdnxrbWvAjdwRB
         s8EilXQkA9D/nsa4Nt71p2qj0lrypS6I/XevHSc4j30aqBn3CmC176xN9/tdtAYzx1JI
         sHleV/60dPa2MbsQ8cRh3Ob1QsWR0tgQNMsv49T6kpGUvf95oB4XIqe/l+V96843jZ9C
         1M1w==
X-Gm-Message-State: AOJu0YxrejUQD+P50SLzPH3DciluX35fF+PezMOkFPDFeV1Lc0TwEfKd
        squnXVn99tELPOoOJIGF9Lw=
X-Google-Smtp-Source: AGHT+IEksE8aCxWYWYtz9f8hJhASA/oom1urAUAGSWY1ZnDYtHwOpnaM2MoadmcuHWJOdFkt8mBWZQ==
X-Received: by 2002:a05:600c:364c:b0:401:b0f2:88b4 with SMTP id y12-20020a05600c364c00b00401b0f288b4mr3515615wmq.26.1693654350471;
        Sat, 02 Sep 2023 04:32:30 -0700 (PDT)
Received: from debian ([63.135.72.41])
        by smtp.gmail.com with ESMTPSA id m18-20020a7bca52000000b003fe601a7d46sm10868578wml.45.2023.09.02.04.32.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 Sep 2023 04:32:30 -0700 (PDT)
Date:   Sat, 2 Sep 2023 12:32:28 +0100
From:   "Sudip Mukherjee (Codethink)" <sudipm.mukherjee@gmail.com>
To:     Miaohe Lin <linmiaohe@huawei.com>, Tejun Heo <tj@kernel.org>
Cc:     Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        regressions@lists.linux.dev
Subject: mainline build failure due to d1d4ff5d11a5 ("cgroup: put
 cgroup_tryget_css() inside CONFIG_CGROUP_SCHED")
Message-ID: <ZPMdTJ7zwrCkdMTu@debian>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hi All,

The latest mainline kernel branch fails to build mips sb1250_swarm_defconfig with
the error:

kernel/cgroup/cgroup.c: In function 'cgroup_local_stat_show':
kernel/cgroup/cgroup.c:3699:15: error: implicit declaration of function 'cgroup_tryget_css'; did you mean 'cgroup_tryget'? [-Werror=implicit-function-declaration]
 3699 |         css = cgroup_tryget_css(cgrp, ss);
      |               ^~~~~~~~~~~~~~~~~
      |               cgroup_tryget
kernel/cgroup/cgroup.c:3699:13: warning: assignment to 'struct cgroup_subsys_state *' from 'int' makes pointer from integer without a cast [-Wint-conversion]
 3699 |         css = cgroup_tryget_css(cgrp, ss);
      |             ^


git bisect pointed to d1d4ff5d11a5 ("cgroup: put cgroup_tryget_css() inside CONFIG_CGROUP_SCHED").

Reverting the commit has fixed the build failure.

I will be happy to test any patch or provide any extra log if needed.

#regzbot introduced: d1d4ff5d11a5887a9c4cfc00294bc68ba03e7c16

-- 
Regards
Sudip
