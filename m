Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD934756C7D
	for <lists+cgroups@lfdr.de>; Mon, 17 Jul 2023 20:51:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229993AbjGQSvp (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 17 Jul 2023 14:51:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229974AbjGQSvo (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 17 Jul 2023 14:51:44 -0400
Received: from mail-il1-x130.google.com (mail-il1-x130.google.com [IPv6:2607:f8b0:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93CF399;
        Mon, 17 Jul 2023 11:51:42 -0700 (PDT)
Received: by mail-il1-x130.google.com with SMTP id e9e14a558f8ab-345f4a3ff76so26854495ab.2;
        Mon, 17 Jul 2023 11:51:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689619902; x=1692211902;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jAlFdhdYimT7TnDfeJ0lD67idJ1017L3UN8Mf00CzHI=;
        b=ED+Djowc/2dcO/tE9axqFc9b4Hjf+ViIX4s7d5D7pjvK1iWZfrjCWS6eMWepFGnc2A
         OiqqVO9dlfjFQXKsVX9cG7py+y6+JafDVDhRNiKNAin1agC3Bt3jvN1MGjLFOcCCok97
         qo3IZkDLh7at2TsXebl4uUAwQlbV3eZDF1JIohTInR63rLLc8I6LhdR2Vzczjj5Yv1Pt
         TpIrmmUwNXD+PmlOmV6GRX+BxxVLNBSTV/dtkIyOEDxSVdFoeJpbwF7/EH7gfTmF9STn
         6SCpIRFjuxYHYV1GUWBsTQIkn9/X05A74eDB8drJInQsPX4VrLNPPXSV9bhatuePiG5O
         7DzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689619902; x=1692211902;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jAlFdhdYimT7TnDfeJ0lD67idJ1017L3UN8Mf00CzHI=;
        b=hUaq/Go/74hIATqFJctwIxgiy3sCY0/Q1xfpvYubKqCyIHYbDRo7DqodZpGgFrRPy0
         nPFWt920vn4Pq35iqZp1fudX/55N3QEKM8EkWZSWluYAdhY/zuPp04sQ1is6B+lw1qPF
         I6ChvPdXU0iFwDrqG4Q+mBs0dTzqylhAVpcyhLMT8Hk3oURJTj8BkF4x+KndYRqga1oB
         WzdS/VShqDZdpux9sQiKhFQ+mEAnXr+TZOHcHDx/DyvdjC+AZ6uFmOH+9BWqJgEfSRLP
         jVy8UGLxNm+VRDYGFCaCrVxrnXXyQ9DOngLtgXsE5QhY8qNOX9B1SeaCsgLi+Tzm0VKr
         QuSQ==
X-Gm-Message-State: ABy/qLZD0fY+bAq9VjeBAL7nk6mVUbIAr11XbBCR0rHUjbhYuaIGcU1i
        rsOIlAa8sdjDwH5kbCNEKbk=
X-Google-Smtp-Source: APBJJlG2P8xagCoC8KHHLnRI6FzA+c8SlylyNZsoif+ix6xTYqV2X1Nwu7Tn8DGcA/30UfHXbxWvZQ==
X-Received: by 2002:a92:c568:0:b0:346:776:bd23 with SMTP id b8-20020a92c568000000b003460776bd23mr574857ilj.5.1689619901778;
        Mon, 17 Jul 2023 11:51:41 -0700 (PDT)
Received: from localhost (dhcp-72-235-13-41.hawaiiantel.net. [72.235.13.41])
        by smtp.gmail.com with ESMTPSA id k3-20020a92c9c3000000b003421231fb8csm120719ilq.74.2023.07.17.11.51.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Jul 2023 11:51:41 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Mon, 17 Jul 2023 08:51:39 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Haitao Huang <haitao.huang@linux.intel.com>
Cc:     jarkko@kernel.org, dave.hansen@linux.intel.com,
        linux-kernel@vger.kernel.org, linux-sgx@vger.kernel.org,
        cgroups@vger.kernel.org, Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>, vipinsh@google.com,
        kai.huang@intel.com, reinette.chatre@intel.com,
        zhiquan1.li@intel.com, kristen@linux.intel.com
Subject: Re: [PATCH] cgroup/misc: Fix an overflow
Message-ID: <ZLWNu4IeehNVO1nh@slm.duckdns.org>
References: <20230717184719.85523-1-haitao.huang@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230717184719.85523-1-haitao.huang@linux.intel.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Mon, Jul 17, 2023 at 11:47:19AM -0700, Haitao Huang wrote:
> The variable 'new_usage' in misc_cg_try_charge() may overflow if it
> becomes above INT_MAX. This was observed when I implement the new SGX
> EPC cgroup[1] as a misc cgroup and test on a platform with large SGX EPC
> sizes.
> 
> Change type of new_usage to long from int and check overflow.
> -	int new_usage;
> +	long new_usage;
>  
>  	if (!(valid_type(type) && cg && READ_ONCE(misc_res_capacity[type])))
>  		return -EINVAL;
> @@ -153,10 +153,10 @@ int misc_cg_try_charge(enum misc_res_type type, struct misc_cg *cg,
>  
>  	for (i = cg; i; i = parent_misc(i)) {
>  		res = &i->res[type];
> -
>  		new_usage = atomic_long_add_return(amount, &res->usage);
>  		if (new_usage > READ_ONCE(res->max) ||
> -		    new_usage > READ_ONCE(misc_res_capacity[type])) {
> +		    new_usage > READ_ONCE(misc_res_capacity[type]) ||
> +		    new_usage < 0) {

Applying to cgroup/for-6.6 (as none of the current users are affected by
this) but I think the right thing to do here is using explicit 64bit types
(s64 or u64) for the resource counters rather than depending on the long
width.

Thanks.

-- 
tejun
