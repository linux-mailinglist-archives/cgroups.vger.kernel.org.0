Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07B45530144
	for <lists+cgroups@lfdr.de>; Sun, 22 May 2022 08:40:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234927AbiEVGh4 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Sun, 22 May 2022 02:37:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232091AbiEVGhv (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Sun, 22 May 2022 02:37:51 -0400
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D6874163C
        for <cgroups@vger.kernel.org>; Sat, 21 May 2022 23:37:50 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id a9so9072712pgv.12
        for <cgroups@vger.kernel.org>; Sat, 21 May 2022 23:37:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ww3nAvlupQzAe15WForrvTUe0x5VHXpHFHGu6B8UAqk=;
        b=0hlZr6B8DnKA9bzHBoPJuI3N0q1Cxa5yWd71jCU7B3Tojl9HOUU6wHR4PdRbt3926z
         PpD0UBUcN4KB8EJzNWlrONVu2XF79Mb0TPZzt/dIniiOGp2rJCglibNMQXQ+A/RSU6Rc
         bmYuSZKGQVZ/C/nDTW+7XeQ3KZPgqd/uXpcV1t8SgG1FqN2j9TGmal5wzxx24mLowb1l
         /UiUu9pXvWMx7UtkUuN2gLwaB+MxIGAajXVqNAzSILYsGx9OE+2KcuJx2a6NQUsAxms5
         rpYLG0Q+Iwna4R2DVnj4xz7A7aRXcBJ0umOpePq3Q5K/YuGiI5xvVIUehHJI8gbZ8d96
         LhKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ww3nAvlupQzAe15WForrvTUe0x5VHXpHFHGu6B8UAqk=;
        b=NpgRUxI2it9bUA7m8FdDz/L7jt29bV1RK2yafP1Qa5vFfqt8nTGDVkzM5hpR8FOcBQ
         wGsh6jlqhoay/0O3EuH1+Ysi69SYGyJpu7yydKeG4o0sx9xPfKxGnQw7w+dKGKFxAlpu
         xe1X4/A/cHAOEHskc5odZOiDU28Obxh87gQgQ8f7zD+GyEW6nz3ueCT94D2jaynykoum
         UzlDZWrb65KZKAO+ym7RkURcWdxGetkGyuKONwuxCBq+m2qvqSLWTr8xg3ePNKe5x3gT
         Z/34VPhEhkvcwNrMTOasfhW7aNBDuYWih2SsExhswX0DiGOnW4sKtDAsVMEX44T+AUlP
         aOVw==
X-Gm-Message-State: AOAM532DArPzYTnqAS3Ba9295M7rU9odRsl9hxMef8nnLXULkglEDAtM
        67nXWGCRtKlTAPATgdnXK0iopQ==
X-Google-Smtp-Source: ABdhPJyIZBcGgFP+4UB+K5yfgjsT0tzgCFbeo9E8vscX0ilcaErCbOnQlu7MK/v16rVc8+9e3lECGA==
X-Received: by 2002:a05:6a00:1805:b0:50d:ee59:b579 with SMTP id y5-20020a056a00180500b0050dee59b579mr18075256pfa.70.1653201469791;
        Sat, 21 May 2022 23:37:49 -0700 (PDT)
Received: from localhost ([139.177.225.234])
        by smtp.gmail.com with ESMTPSA id a3-20020a170902ecc300b0015e8d4eb26dsm2544678plh.183.2022.05.21.23.37.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 May 2022 23:37:49 -0700 (PDT)
Date:   Sun, 22 May 2022 14:37:46 +0800
From:   Muchun Song <songmuchun@bytedance.com>
To:     Vasily Averin <vvs@openvz.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>, kernel@openvz.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Shakeel Butt <shakeelb@google.com>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Michal Hocko <mhocko@suse.com>, cgroups@vger.kernel.org
Subject: Re: [PATCH mm v2 2/9] memcg: enable accounting for kernfs nodes
Message-ID: <YonaOq6jrGygwbcH@FVFYT0MHHV2J.usts.net>
References: <Yn6aL3cO7VdrmHHp@carbon>
 <4f129690-88fe-18f2-2142-b179a804924b@openvz.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4f129690-88fe-18f2-2142-b179a804924b@openvz.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Sat, May 21, 2022 at 07:37:49PM +0300, Vasily Averin wrote:
> kernfs nodes are quite small kernel objects, however there are few
> scenarios where it consumes significant piece of all allocated memory:
> 
> 1) creating a new netdevice allocates ~50Kb of memory, where ~10Kb
>    was allocated for 80+ kernfs nodes.
> 
> 2) cgroupv2 mkdir allocates ~60Kb of memory, ~10Kb of them are kernfs
>    structures.
> 
> 3) Shakeel Butt reports that Google has workloads which create 100s
>    of subcontainers and they have observed high system overhead
>    without memcg accounting of kernfs.
> 
> Usually new kernfs node creates few other objects:
> 
> Allocs  Alloc   Allocation
> number  size
> --------------------------------------------
> 1   +  128      (__kernfs_new_node+0x4d)	kernfs node
> 1   +   88      (__kernfs_iattrs+0x57)		kernfs iattrs
> 1   +   96      (simple_xattr_alloc+0x28)	simple_xattr, can grow over 4Kb
> 1       32      (simple_xattr_set+0x59)
> 1       8       (__kernfs_new_node+0x30)
> 
> '+' -- to be accounted
> 
> This patch enables accounting for kernfs nodes slab cache.
> 
> Signed-off-by: Vasily Averin <vvs@openvz.org>

Reviewed-by: Muchun Song <songmuchun@bytedance.com>
