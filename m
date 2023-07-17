Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30260756C9E
	for <lists+cgroups@lfdr.de>; Mon, 17 Jul 2023 20:58:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231455AbjGQS6I (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 17 Jul 2023 14:58:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231698AbjGQS6D (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 17 Jul 2023 14:58:03 -0400
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com [IPv6:2607:f8b0:4864:20::d2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39795186;
        Mon, 17 Jul 2023 11:58:02 -0700 (PDT)
Received: by mail-io1-xd2c.google.com with SMTP id ca18e2360f4ac-783549ef058so272459439f.2;
        Mon, 17 Jul 2023 11:58:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689620281; x=1692212281;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=R8dRbDx5OSxI2KS2h9OabLw4RmAj19B/uXTDt0GaZHU=;
        b=gavjJiyKOJJ91nNIatF2UTY1MOjBA/LN5qn+DvBE1EDa8T2NoqnsMZXv2uo1iq24e2
         9IH7V8sh8o2+DFZj4ze/lqiTegaBY9fD4X/iALxVQhuW07SMmRQTmY/v034iTc1PU98c
         RzzRZl2usbAewfMoSn3QyfhBpw4FcqTUkuYH+1PwX2IKaR1CdzYtW7eRHzo9uVcjXBEg
         w8oLkzy0Mz7niu+EPyCvt9EdQabvlU+flcojaLOAYsID14Zi6hcOcgULkg7aIpmLWGYs
         gzb+jgZsLdkAXNcmJb2382ngichavzupucGljPu7ZkGWp1O5tNCFrZ/ivZJ8yKKHoMmi
         Z+bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689620281; x=1692212281;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=R8dRbDx5OSxI2KS2h9OabLw4RmAj19B/uXTDt0GaZHU=;
        b=JVGeg1ZrRMkVQLIlCGaa/cfOfz9d28kO8BEw5JQAIAz5gcf9t5i7CAmDPf8LqObiJ/
         fr0dPK6T5ep/gaeRGX81iVr+b70ro1x/pdrG+SOfYGDBKbA6uwBnAkKg6yQE71Px+X5L
         SYgRRKgCZUdQszK8Vk/x4+UveNfmiBDCpSFA5lONEZmsZeUjmKgFuW2FbW86Rg7Zj6Cr
         7k/IABniruZ49yi6pCoxcvmFC/TqmcISVJ26fdgAYIUgj6Bd6u9oSxorI9YrWLe8g3TY
         2WoJMYEjmfYWHh3uGO2DwlAhgx4+qPzyhYbnUvZcNoPcFRpoo6ewdf4KECNq9sRXfmjK
         CUFQ==
X-Gm-Message-State: ABy/qLZpDPTwPsJ5W33lLITCJUYf9HifFGvyC0pQQFdE7OJY1fbO277K
        zUDUZ9w69LAyjysn/k67BLo=
X-Google-Smtp-Source: APBJJlHKOzaHbphAogMm1+usqSw7+HOJ3oG5LSDVJP6Zo9dXrSr0XJJbxTeTzadQ/IhlvHuNXGRw0w==
X-Received: by 2002:a6b:fd17:0:b0:783:63d6:4cb with SMTP id c23-20020a6bfd17000000b0078363d604cbmr545637ioi.14.1689620281441;
        Mon, 17 Jul 2023 11:58:01 -0700 (PDT)
Received: from localhost (dhcp-72-235-13-41.hawaiiantel.net. [72.235.13.41])
        by smtp.gmail.com with ESMTPSA id r11-20020a5e8e4b000000b0077e3acd5ea1sm33570ioo.53.2023.07.17.11.58.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Jul 2023 11:58:01 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Mon, 17 Jul 2023 08:57:59 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Jarkko Sakkinen <jarkko@kernel.org>
Cc:     Haitao Huang <haitao.huang@linux.intel.com>,
        dave.hansen@linux.intel.com, linux-kernel@vger.kernel.org,
        linux-sgx@vger.kernel.org, cgroups@vger.kernel.org,
        Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>, vipinsh@google.com,
        kai.huang@intel.com, reinette.chatre@intel.com,
        zhiquan1.li@intel.com, kristen@linux.intel.com
Subject: Re: [PATCH] cgroup/misc: Fix an overflow
Message-ID: <ZLWPN_xyGFrqqJkV@slm.duckdns.org>
References: <20230717184719.85523-1-haitao.huang@linux.intel.com>
 <CU4OCLEHU1S5.359W394902648@seitikki>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CU4OCLEHU1S5.359W394902648@seitikki>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Mon, Jul 17, 2023 at 06:55:32PM +0000, Jarkko Sakkinen wrote:
> On Mon Jul 17, 2023 at 6:47 PM UTC, Haitao Huang wrote:
> > The variable 'new_usage' in misc_cg_try_charge() may overflow if it
> > becomes above INT_MAX. This was observed when I implement the new SGX
> > EPC cgroup[1] as a misc cgroup and test on a platform with large SGX EPC
> > sizes.
> >
> > Change type of new_usage to long from int and check overflow.
> >
> > Fixes: a72232eabdfcf ("cgroup: Add misc cgroup controller")
> > Signed-off-by: Haitao Huang <haitao.huang@linux.intel.com>
> >
> > [1] https://lore.kernel.org/linux-sgx/20230712230202.47929-1-haitao.huang@linux.intel.com/
> > ---
> >  kernel/cgroup/misc.c | 6 +++---
> >  1 file changed, 3 insertions(+), 3 deletions(-)
> >
> > diff --git a/kernel/cgroup/misc.c b/kernel/cgroup/misc.c
> > index fe3e8a0eb7ed..ff9f900981a3 100644
> > --- a/kernel/cgroup/misc.c
> > +++ b/kernel/cgroup/misc.c
> > @@ -143,7 +143,7 @@ int misc_cg_try_charge(enum misc_res_type type, struct misc_cg *cg,
> >  	struct misc_cg *i, *j;
> >  	int ret;
> >  	struct misc_res *res;
> > -	int new_usage;
> > +	long new_usage;
> >  
> >  	if (!(valid_type(type) && cg && READ_ONCE(misc_res_capacity[type])))
> >  		return -EINVAL;
> > @@ -153,10 +153,10 @@ int misc_cg_try_charge(enum misc_res_type type, struct misc_cg *cg,
> >  
> >  	for (i = cg; i; i = parent_misc(i)) {
> >  		res = &i->res[type];
> > -
> 
> This is extra noise in the patch, please remove the change.

Lemme just revert it. Haitao, can you instead make the resource counters and
all related variables explicit 64bit instead?

Thanks.

-- 
tejun
