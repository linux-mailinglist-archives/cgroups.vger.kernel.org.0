Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBAD94EC36A
	for <lists+cgroups@lfdr.de>; Wed, 30 Mar 2022 14:28:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235019AbiC3MT7 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 30 Mar 2022 08:19:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346961AbiC3MSt (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 30 Mar 2022 08:18:49 -0400
Received: from mail-qv1-xf2f.google.com (mail-qv1-xf2f.google.com [IPv6:2607:f8b0:4864:20::f2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D264B62A22
        for <cgroups@vger.kernel.org>; Wed, 30 Mar 2022 05:08:51 -0700 (PDT)
Received: by mail-qv1-xf2f.google.com with SMTP id hu11so16644385qvb.7
        for <cgroups@vger.kernel.org>; Wed, 30 Mar 2022 05:08:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=3I4Wbaw8kW2EJmKRBW9VuujWkyfUQDWPpToJHWZ1Qxw=;
        b=kJ787gVx9QHZo7fifirsTebaVbsgM8uMPI7864OsHOZ3EgMFvXCs3vCmHRRw3xcQBH
         Wcl5CxrShaHSDA7OgMLJTtUwQ3CyvHjey7usvwz80QYsP82N3F9hQ2yg+qwJnmRIV/+i
         83uwETu83rMHK6xuRJWxOtHE8OwXGCpMp8iKb9EDLjwvlJrBxhPVfHZ2u6dr/vPs6KgY
         KUbLkeFACeDgEZuSdhxqxJiMwoEUuW94gtay9eXCBTPgUOrs86Ii6/oFZuzfJWHYxYcx
         HpjqHXQUK7V9lmwpZd32YuBkVIRpuvfVpQNnNBgWNQiE5p8TXRvyN+SPZ4DA+iYSXq/F
         R6dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=3I4Wbaw8kW2EJmKRBW9VuujWkyfUQDWPpToJHWZ1Qxw=;
        b=WQ2yVGta6kDhBun99V+0XJ3YK/FD5gg6K9d2wMro3DpFSdZhVDvuSk03NseSmU+fGK
         /VNUX+6c2MS5qo3dwfkmOY8QPKLB+h77g9lb4+FX2g8GCyVmWeSRn03faut6FLM7CCOA
         QuUp+ixATAb/NCLqtyaEAtDg/kcVB/n6PFVj/FKde8xUwaq1rsDDtUo0bB1Zb4XDf1Jx
         1C+FQrETknW5LgBE6Yd2Hi6CWYmvsaSghlhLuyPA9JVn0raEzENz8Zg7vNWxR8ZoLhy2
         gPzo3G5/nsZJXeOuE7eSFqR+X7VjZhF3EiHhyDwC6hYuzwqIxvB8SY7Y+d3rR2ucwupd
         bYuQ==
X-Gm-Message-State: AOAM530amvR5OsjMQJsjYpW8VlxTnoyC3DqBMHP1PL61fnwIuxS4jlkY
        S5wmOs2b7E9h7x5i7LL4XpgeMJVVgZkzJg==
X-Google-Smtp-Source: ABdhPJxQ5GtdkgLZRI4tYvPBcPf+sTQnvXOjMUtTeUBepE+a89PiOOraOPQYhzBTcxUkuKOFwqSG9Q==
X-Received: by 2002:a05:6214:1bcd:b0:441:4b9d:e3cf with SMTP id m13-20020a0562141bcd00b004414b9de3cfmr31168449qvc.120.1648642130962;
        Wed, 30 Mar 2022 05:08:50 -0700 (PDT)
Received: from localhost (cpe-98-15-154-102.hvc.res.rr.com. [98.15.154.102])
        by smtp.gmail.com with ESMTPSA id h6-20020ac85e06000000b002e1e8a98abbsm17854314qtx.41.2022.03.30.05.08.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Mar 2022 05:08:50 -0700 (PDT)
Date:   Wed, 30 Mar 2022 08:08:49 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Wei Yang <richard.weiyang@gmail.com>
Cc:     mhocko@kernel.org, vdavydov.dev@gmail.com,
        akpm@linux-foundation.org, cgroups@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH 2/3] mm/memcg: set pos to prev unconditionally
Message-ID: <YkRIUbEGHVIbVRNO@cmpxchg.org>
References: <20220225003437.12620-1-richard.weiyang@gmail.com>
 <20220225003437.12620-3-richard.weiyang@gmail.com>
 <YkNUZYrSHPjJ1XOb@cmpxchg.org>
 <20220330004750.fx4jr4bnehz4ynpf@master>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220330004750.fx4jr4bnehz4ynpf@master>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed, Mar 30, 2022 at 12:47:50AM +0000, Wei Yang wrote:
> Something like this?
> 
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index eed9916cdce5..5d433b79ba47 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -1005,9 +1005,6 @@ struct mem_cgroup *mem_cgroup_iter(struct mem_cgroup *root,
>  	if (!root)
>  		root = root_mem_cgroup;
>  
> -	if (prev && !reclaim)
> -		pos = prev;
> -
>  	rcu_read_lock();
>  
>  	if (reclaim) {
> @@ -1033,6 +1030,8 @@ struct mem_cgroup *mem_cgroup_iter(struct mem_cgroup *root,
>  			 */
>  			(void)cmpxchg(&iter->position, pos, NULL);
>  		}
> +	} else if (prev) {
> +		pos = prev;
>  	}
>  
>  	if (pos)

Yep!
