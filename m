Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B21E5A1F1B
	for <lists+cgroups@lfdr.de>; Fri, 26 Aug 2022 04:48:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233309AbiHZCsS (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 25 Aug 2022 22:48:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229536AbiHZCsQ (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 25 Aug 2022 22:48:16 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0ADAFA3D79;
        Thu, 25 Aug 2022 19:48:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=KrBgq4HD/icun5bFiHHIUQ6IjONVJ/rxTezt7YCnkJE=; b=rGM/UuEBB9L8aI2AUVk+gK2KDP
        fKxnby64zNrqUPb9aKaMfaS7cuuLc+lcTb06Lp8ySc8Vk6/eQFezTahu31Rj544mnXY54mYmNceUr
        ToOTtf4bTziGm77ZUOaOtUzudaP/nprEk4/QNk6+TjGOBYkniPvBz4KV8My/62pnfwDkBJgq1Tm+R
        qOfblZEqiokIpz/hyr5GFpeffd8O7SlMmBm+VXU/i0+6YaJUtQpp81mLwVcrQahbTghA4hpsQZDOV
        lSLKH77yESrNAHC3i6ZOHGaBMgSn8cqhq4WczqKBqF8In3ZxMsV87K0kVmYT7dB1Agh1rwPzsHZSG
        GU6qIVyA==;
Received: from [2601:1c0:6280:3f0::a6b3]
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oRPOG-005OOu-0q; Fri, 26 Aug 2022 02:48:12 +0000
Message-ID: <795c6785-e13e-5322-15b3-60ee2ec24197@infradead.org>
Date:   Thu, 25 Aug 2022 19:48:10 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.2
Subject: Re: [PATCH linux-next] admin-guide: cgroup: fix a typo in description
Content-Language: en-US
To:     cgel.zte@gmail.com, tj@kernel.org
Cc:     lizefan.x@bytedance.com, hannes@cmpxchg.org, corbet@lwn.net,
        cgroups@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        lufengchang <lu.fengchang@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
References: <20220826020552.239407-1-lu.fengchang@zte.com.cn>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20220826020552.239407-1-lu.fengchang@zte.com.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hi,

On 8/25/22 19:05, cgel.zte@gmail.com wrote:
> From: lufengchang <lu.fengchang@zte.com.cn>
> 
> Reported-by: Zeal Robot <zealci@zte.com.cn>
> Signed-off-by: lufengchang <lu.fengchang@zte.com.cn>

Are you sure that it's a typo?

https://en.wikipedia.org/wiki/If_and_only_if

"iff" is commonly used (in math/technical literature)
to mean "if and only if".

> ---
>  Documentation/admin-guide/cgroup-v1/cgroups.rst | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/admin-guide/cgroup-v1/cgroups.rst b/Documentation/admin-guide/cgroup-v1/cgroups.rst
> index b0688011ed06..fa747466e304 100644
> --- a/Documentation/admin-guide/cgroup-v1/cgroups.rst
> +++ b/Documentation/admin-guide/cgroup-v1/cgroups.rst
> @@ -573,7 +573,7 @@ cgroup_for_each_descendant_pre() for details.
>  ``void css_offline(struct cgroup *cgrp);``
>  (cgroup_mutex held by caller)
>  
> -This is the counterpart of css_online() and called iff css_online()
> +This is the counterpart of css_online() and called if css_online()
>  has succeeded on @cgrp. This signifies the beginning of the end of
>  @cgrp. @cgrp is being removed and the subsystem should start dropping
>  all references it's holding on @cgrp. When all references are dropped,

-- 
~Randy
