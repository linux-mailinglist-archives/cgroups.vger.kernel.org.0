Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D0D059EC44
	for <lists+cgroups@lfdr.de>; Tue, 23 Aug 2022 21:26:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231587AbiHWT0W (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 23 Aug 2022 15:26:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231635AbiHWT0F (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 23 Aug 2022 15:26:05 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CF5813DBA4;
        Tue, 23 Aug 2022 11:12:15 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id r14-20020a17090a4dce00b001faa76931beso18027129pjl.1;
        Tue, 23 Aug 2022 11:12:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :from:to:cc;
        bh=w6Y6IjnB/7GXBq23acV5syGhC64cBXwxU4OuyhZd8CQ=;
        b=IaP7cFBpGcNi3/hhyxFebsnvxJsMy54QTl7EkiYLgJCebOU1/sY6ya+8Jj7s9gc5zJ
         m96Jd0oUB9ii7t+kjHWa0AYbqnMm5HXw9j51y4fR0GTSjpmruV6mcpR1pH2bNOo7Eh9J
         1+m93Urk2CcVD+dQQvvEOgbAJqBAErrzKbUqYPqCFKfnC9JQXmYBIYNVyoJZVAbB6LO2
         5fvVxUuzhxJTX2ZCcqC78LL+jJzs7uc6dP6iwGIMRwK76xIIh3W8VDmSaT8p0QyXPYzZ
         WxnHrnIHJWsGCnNde81/z4kR2sB4563gvDfugD+mJi4dvRasMOT9T+3eMQq+GiKhQ+Kp
         xOkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :x-gm-message-state:from:to:cc;
        bh=w6Y6IjnB/7GXBq23acV5syGhC64cBXwxU4OuyhZd8CQ=;
        b=bY7IFJWo7EOkjQAhMK4xYCvW/Fi12t7Wl7B5zuFElR4MXyNlSqrcrNCxry+TEVvLW/
         MNrGKzJCd/NxPrwy1uZzN6Zez4KBNyor1WAxbIlqZxqrMvuAiI6I2pEmkGg6SYPZBkQC
         +BEqSlDVH8YHoyzUNDCWp0i+fvFYlMZpl3NWI48E6YO6N5ck1qqPuh2iYb9rMAlo92kM
         2Jq+PhrF3W9nBe4ca+72QGQR948pfGXbJceBvLuQWGQyH473CkhrMun4aSdFnaUzjQq/
         MXiK3/UNaYWVsbMBrUP2wI7BsDZpz1TIquRYSbBrcg62FFDrBY8/PA0oHsxauor3X3+C
         2IOQ==
X-Gm-Message-State: ACgBeo2ML8rxxKuFNqRishtP5+5BMWieVKOAEDXTZe8kmtXxxJ5ajs+L
        9p97UkG7Fxp+S7SLkKR/Svk=
X-Google-Smtp-Source: AA6agR5OMzXPWSEia1ICuDVxlmd5kDRtjxcPzDjzeIQnJSzFFes7fZNXVlt3vyVCqQga04y7fD0YmQ==
X-Received: by 2002:a17:902:d712:b0:172:e2f8:7f02 with SMTP id w18-20020a170902d71200b00172e2f87f02mr11541384ply.26.1661278334213;
        Tue, 23 Aug 2022 11:12:14 -0700 (PDT)
Received: from localhost ([2620:10d:c090:400::5:90fa])
        by smtp.gmail.com with ESMTPSA id l9-20020a170902f68900b0016be96e07d1sm10712480plg.121.2022.08.23.11.12.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Aug 2022 11:12:13 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Tue, 23 Aug 2022 08:12:12 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Jing-Ting Wu <Jing-Ting.Wu@mediatek.com>
Cc:     Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
        Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Jonathan.JMChen@mediatek.com, Lixiong.Liu@mediatek.com,
        wsd_upstream@mediatek.com, Wenju.Xu@mediatek.com,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: Re: [PATCH 1/1] cgroup: Fix race condition at rebind_subsystems()
Message-ID: <YwUYfNEVIOyQXP8d@slm.duckdns.org>
References: <20220823054148.29346-1-Jing-Ting.Wu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220823054148.29346-1-Jing-Ting.Wu@mediatek.com>
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

On Tue, Aug 23, 2022 at 01:41:46PM +0800, Jing-Ting Wu wrote:
> Root cause:
> The rebind_subsystems() is no lock held when move css object from A
> list to B list,then let B's head be treated as css node at
> list_for_each_entry_rcu().
> 
> Solution:
> Add grace period before invalidating the removed rstat_css_node.
> 
> Reported-by: Jing-Ting Wu <jing-ting.wu@mediatek.com>
> Suggested-by: Michal Koutný <mkoutny@suse.com>
> Signed-off-by: Jing-Ting Wu <jing-ting.wu@mediatek.com>
> Tested-by: Jing-Ting Wu <jing-ting.wu@mediatek.com>
> Link: https://lore.kernel.org/linux-arm-kernel/d8f0bc5e2fb6ed259f9334c83279b4c011283c41.camel@mediatek.com/T/

Applied to cgroup/for-6.0-fixes w/ stable tag added.

Thanks.

-- 
tejun
