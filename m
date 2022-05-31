Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED2BF53963B
	for <lists+cgroups@lfdr.de>; Tue, 31 May 2022 20:24:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347012AbiEaSY2 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 31 May 2022 14:24:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346948AbiEaSY2 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 31 May 2022 14:24:28 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E3887A823;
        Tue, 31 May 2022 11:24:27 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id q12-20020a17090a304c00b001e2d4fb0eb4so3627736pjl.4;
        Tue, 31 May 2022 11:24:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=aASmjf/pnI60SUyA+vo4oipwPmuVquT6UTuMWtth16E=;
        b=b0id0ljyEJ0A/BY68TcNQin8MFxEUP8/YY3UNzivhDGBEenqWTe/+aVQCXUF8mOaFa
         YOO0EU29eTkoKmgRpmqlacunMUw0EUoR6CTK9iZruDkT2J2rlorxz5r6+eLgaMSUcCV6
         ACYvJ+0bZWXhVxPwtNmTgxg5agQ5hhotR0skd6dDH1x2NIpYa+bHadXaCmklo+xSmQAp
         3cDk1C7/OL4VRpAPQwYsTYJbu32wrZ1mfMznQhu3UidlC4xzZpX2Nh5WrtFGjxf5vzbe
         RrU44InIpqTW71q+AT4Tz847CoAO23+wD1Kyri81QgGgK2fYkWGaZSJ1rtR8Hfq55JUh
         JhFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=aASmjf/pnI60SUyA+vo4oipwPmuVquT6UTuMWtth16E=;
        b=zjo2HXkixjWEU8uUWeOOGtul3esGOvjWHOXAh6Qr/nsCmbLRVLFMjx3HRlTxPgm8Uy
         dbNMa3YtEz12SWH/1OAYwx7R7TAnl3HvWilhRdzMdfb3lfoCtqGD1u7VeR3KTEQb5cMA
         zQJZO13hpL0xF4VAknNmcxMY4qIdutOA3Gx8UJSAgyxU8to3Q/3l/cyLM4Unr33VKtc6
         pt1sdSKUE+vOKVstuo3OqQo0p/ZDOwuv0RL/9HHggg7NLOaqvViVakl5IPl9zk7qzBMz
         rqbqvL55/ullGp7UB7kDRBIC8Xi9ou0DOZJNGtwf9SIdFhlQ9cmHentnz0MpFVFulDil
         JeNA==
X-Gm-Message-State: AOAM533S01kH6Xa7poM1mMNvpjcPB1YibjmMBVkLAKAzZNseyidsZLgg
        5ju2vQuIaHj0N0tATqu3dddnbaLq6Gk=
X-Google-Smtp-Source: ABdhPJwzDxVGmi3KE9VGnz8OLz53LiiQxmKtewnPo/T1sRhlbwVNGBuhYNslynstct/hP7p72Zy/FA==
X-Received: by 2002:a17:902:7049:b0:162:962:5b04 with SMTP id h9-20020a170902704900b0016209625b04mr49934617plt.167.1654021466804;
        Tue, 31 May 2022 11:24:26 -0700 (PDT)
Received: from localhost ([2620:10d:c090:400::4:987b])
        by smtp.gmail.com with ESMTPSA id u1-20020a17090282c100b00163fbb2bae5sm2572448plz.209.2022.05.31.11.24.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 May 2022 11:24:26 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Tue, 31 May 2022 08:24:24 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Waiman Long <longman@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, cgroups@vger.kernel.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Ming Lei <ming.lei@redhat.com>
Subject: Re: [PATCH] blk-cgroup: Optimize blkcg_rstat_flush()
Message-ID: <YpZdWNGW1bTGnApp@slm.duckdns.org>
References: <20220531181821.187834-1-longman@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220531181821.187834-1-longman@redhat.com>
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

Hello, Waiman.

On Tue, May 31, 2022 at 02:18:21PM -0400, Waiman Long wrote:
> For a system with many CPUs and block devices, the time to do
> blkcg_rstat_flush() from cgroup_rstat_flush() can be rather long. It
> can be especially problematic as interrupt is disabled during the flush.
> It was reported that it might take seconds in some extreme cases leading
> to hard lockup messages.
> 
> As it is likely that not all the percpu blkg_iostat_set's has been
> updated since the last flush, those stale blkg_iostat_set's don't need
> to be flushed in this case. This patch optimizes blkcg_rstat_flush()
> by checking the current sequence number against the one recorded since
> the last flush and skip the blkg_iostat_set if the sequence number
> hasn't changed. There is a slight chance that it may miss an update
> that is being done in parallel, the new update will just have to wait
> until the next flush.
> 
> Signed-off-by: Waiman Long <longman@redhat.com>
> ---
>  block/blk-cgroup.c | 18 +++++++++++++++---
>  block/blk-cgroup.h |  1 +
>  2 files changed, 16 insertions(+), 3 deletions(-)
> 
> diff --git a/block/blk-cgroup.c b/block/blk-cgroup.c
> index 40161a3f68d0..79b89af61ef2 100644
> --- a/block/blk-cgroup.c
> +++ b/block/blk-cgroup.c
> @@ -864,11 +864,23 @@ static void blkcg_rstat_flush(struct cgroup_subsys_state *css, int cpu)
>  		unsigned long flags;
>  		unsigned int seq;
>  
> +		seq = u64_stats_fetch_begin(&bisc->sync);
> +		/*
> +		 * If the sequence number hasn't been updated since the last
> +		 * flush, we can skip this blkg_iostat_set though we may miss
> +		 * an update that is happening in parallel.
> +		 */
> +		if (seq == bisc->last_seq)
> +			continue;

Is this a sufficient solution? The code assumes that there aren't too many
blkgs for the cgroup, which can be wrong in some cases. Wouldn't it be
better to create a list of updated blkg's per blkcg so that we don't walk
all the dormant ones?

Thanks.

-- 
tejun
