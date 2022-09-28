Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA6FE5EDCE1
	for <lists+cgroups@lfdr.de>; Wed, 28 Sep 2022 14:36:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233997AbiI1Mg2 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 28 Sep 2022 08:36:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234106AbiI1MgJ (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 28 Sep 2022 08:36:09 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 850AA356CD;
        Wed, 28 Sep 2022 05:35:43 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id e10-20020a05600c4e4a00b003b4eff4ab2cso1129415wmq.4;
        Wed, 28 Sep 2022 05:35:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=hDGLmeg/3H5e1OtBsmLFUKZd98FFvCcHEVJ0xsvxMhM=;
        b=RVu0ef59fpgN3POkCew4+CPhjI2r/eU7f55jOv7S0H68+VbgnWPqOfbGELhS6Vlx8d
         8ARCwXOOHGaGAG7AeavP0QVbHzCavzTtptch7u7fI/G331yBAk80JqSPt2EWIpBh7YuU
         PMwjaklaBHAsype1SI4Kt3pl4lt1nZfgpJankk11I8aeCgdkX39StChW3jwSg2MUE0JP
         fEQl5/6stF4PYpgt1Jfvcmz9+k20Bp92L8NehZN99/GK/eMy70O3UAOoQl9jcpEsQmq2
         rw991OcohUDoGG2fHdyhHjb51NUMUQoZwLE0Sc4kKOSG8Z2OIH3lycZjHnJXkoEvxWsT
         E1qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=hDGLmeg/3H5e1OtBsmLFUKZd98FFvCcHEVJ0xsvxMhM=;
        b=KuK6eWHbX1YwQvDST7EkzGun/wqCa/sBWNk2o7SfBxPTaiwofIL/3HRhIWieRhPNcz
         fGXskpbqbWxd1xuHVkgtUBy/fp2Ytm8AVCaDqa/Qo2aSKo1Cplo40svj+N33Dfq+k8+Y
         kp0njgyBPFTDiGOL1KQ6WCVl7DbhLqIsetFpNN01Sao4Kt7cHYQWvKy+N4J1jwTn7ykF
         OvxZ3U556cMBfYWvGJQewnrZ9AmlsAH1viRru94stIXM9lPcxN80FGwyhCPO6dKTSlId
         m2G74sw0XFL0v266MoeMi0PB+yD5/QhCL3E9e0WtOPVMvOAYs5WlMuxSPCzPZdVmK8Mx
         xujg==
X-Gm-Message-State: ACrzQf3c66e1Iv+3+Cry118CpxTDhxmSoN2zVGrGgsKYRNYsPrA5H39G
        0HZKjgGvTiiu1Dji4eqKWff69GJgIg0DOOd1pYk=
X-Google-Smtp-Source: AMsMyM4CJY3K9qndmYOtCN/qBSz/mzPUwHP0eq64RNnQhsHSii+iU5TB0IqzJw8H6hh526xY9VRzo5a+lXECJ1UdOck=
X-Received: by 2002:a7b:c389:0:b0:3b4:a67a:2ef7 with SMTP id
 s9-20020a7bc389000000b003b4a67a2ef7mr6602270wmj.180.1664368541230; Wed, 28
 Sep 2022 05:35:41 -0700 (PDT)
MIME-Version: 1.0
References: <20220926195931.2497968-1-shakeelb@google.com>
In-Reply-To: <20220926195931.2497968-1-shakeelb@google.com>
From:   Anatoly Pugachev <matorola@gmail.com>
Date:   Wed, 28 Sep 2022 15:35:29 +0300
Message-ID: <CADxRZqys7222fYUj-0--RsR+L4s0TyJr6Wa6EeoaXMBZcNkLeQ@mail.gmail.com>
Subject: Re: [PATCH] Revert "net: set proper memcg for net_init hooks allocations"
To:     Shakeel Butt <shakeelb@google.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Muchun Song <songmuchun@bytedance.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>,
        cgroups@vger.kernel.org, linux-mm <linux-mm@kvack.org>,
        Linux Kernel list <linux-kernel@vger.kernel.org>,
        Vasily Averin <vvs@openvz.org>,
        Jakub Kicinski <kuba@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Sparc kernel list <sparclinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Mon, Sep 26, 2022 at 11:00 PM Shakeel Butt <shakeelb@google.com> wrote:
>
> This reverts commit 1d0403d20f6c281cb3d14c5f1db5317caeec48e9.
>
> Anatoly Pugachev reported that the commit 1d0403d20f6c ("net: set proper
> memcg for net_init hooks allocations") is somehow causing the sparc64
> VMs failed to boot and the VMs boot fine with that patch reverted. So,
> revert the patch for now and later we can debug the issue.

Tested-by: Anatoly Pugachev <matorola@gmail.com>
