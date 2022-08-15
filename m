Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BE965931D0
	for <lists+cgroups@lfdr.de>; Mon, 15 Aug 2022 17:31:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230510AbiHOPbr (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 15 Aug 2022 11:31:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232056AbiHOPbp (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 15 Aug 2022 11:31:45 -0400
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E491DF8B
        for <cgroups@vger.kernel.org>; Mon, 15 Aug 2022 08:31:43 -0700 (PDT)
Received: by mail-qt1-x831.google.com with SMTP id j17so5692621qtp.12
        for <cgroups@vger.kernel.org>; Mon, 15 Aug 2022 08:31:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc;
        bh=kjUsObjVqN3I7az1Kd4dUP6iOhCJ8WK+mdTv5P8AJTs=;
        b=5n/GrNy90njXPlXWQ0a//HP28qQhjYUJxn2CFByPOJoPlz69BGXOZuwsZ57nudHS/R
         vhRQGQw3CC3uHiMNAXJd1MZaUOrEvy1ao4QxZBeUJdDndotInc7d5xoBJyXvy0bQRFtE
         1jGG6iWk9zcJFlQ2wi3uRuVbIGZYDAGksif1hgos5Y9EmfW9NSXSdoALeyofn6nqitMu
         Hb/7E/Pr58V2/Rw5XwylbtyMBCElScJ8X8A9cBwaXjsf79rl4bMyZDFzAd9AS5o88bEw
         Dyx/B+A0zVWp7p0Xtc6ZxxP3t9Z/zXIsFVablL5iCvmSC6voJlbj48Q4+f7TKV0slZwD
         eX3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=kjUsObjVqN3I7az1Kd4dUP6iOhCJ8WK+mdTv5P8AJTs=;
        b=GRXB6eiGJ6CMjDzg4wqtvvXCThqmV/nBA0nqdXXiUHTKApUXuuCRAy5cst2OCMXv3X
         8L3lJpxS0neW6d7kKEzav3N4lQqgZQF5WYIgNnDV+gc6zPcp4DY16rtvp+ho7DCmcPch
         2/uuGvDF5YP9wdym9582QMzpaj1np+6jc9G7nw8EQiO6FoqRsJ/hD3Ch5BRvcFgGTTmx
         Tu8bq0krlSd0sjJi6rtcZdjvnz2FGJgbdaqwENfi6mJ0MLtBx0clJVD4h86mUntIYTYg
         aQyLOKLa5QXwNGlwVcoxX0IlqGcRfhmcmA3OVApoXDkShdrLH75cHJH0pLtKDNTfZUmp
         IEmw==
X-Gm-Message-State: ACgBeo2xZdL8S1GQu+9OmRjW7W0GrBygDaosCzRArPbs/zAFxaSCRCZE
        Rzg4DNIPtwVPHWlW+vv6APH8cH6pjafokA==
X-Google-Smtp-Source: AA6agR7ev7wthew34BfCdF20KvDajqkFwspXEanOzHctXoPfcPMjHy38yX42jh/a9Q2QZSXuguECew==
X-Received: by 2002:a05:622a:103:b0:343:3ce4:c383 with SMTP id u3-20020a05622a010300b003433ce4c383mr14729359qtw.388.1660577502582;
        Mon, 15 Aug 2022 08:31:42 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::a23e])
        by smtp.gmail.com with ESMTPSA id h17-20020ac85e11000000b003430589dd34sm8635614qtx.57.2022.08.15.08.31.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Aug 2022 08:31:42 -0700 (PDT)
Date:   Mon, 15 Aug 2022 11:31:41 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Yosry Ahmed <yosryahmed@google.com>
Cc:     "Li,Liguang" <liliguang@baidu.com>,
        Shakeel Butt <shakeelb@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux-MM <linux-mm@kvack.org>, Cgroups <cgroups@vger.kernel.org>,
        Michal Hocko <mhocko@kernel.org>,
        Muchun Song <songmuchun@bytedance.com>,
        Roman Gushchin <roman.gushchin@linux.dev>
Subject: Re: [PATCH] mm: correctly charge compressed memory to its memcg
Message-ID: <Yvpm3cubIRAqUUJn@cmpxchg.org>
References: <20220811081913.102770-1-liliguang@baidu.com>
 <YvWa9MOQWBICInjO@P9FQF9L96D.corp.robot.car>
 <CALvZod4nnn8BHYqAM4xtcR0Ddo2-Wr8uKm9h_CHWUaXw7g_DCg@mail.gmail.com>
 <CAJD7tkbrCNDMkE8dJDWHiTfi=nJJzrZwepaWb3YioRHMrSEuQA@mail.gmail.com>
 <1704B09B-F758-47DF-BDDE-FEA9AB227E12@baidu.com>
 <CAJD7tkaW7qtaNpc3UHuQAcJAjdjzjmWZCqCMafT-nUES+2QtYg@mail.gmail.com>
 <E0E6FD3B-242B-4187-B4B4-9D4496A5B19A@baidu.com>
 <CAJD7tkYdJrakJGp8XMt49ixZJuf=qpGm=vSxH6G_GWeenk35dQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJD7tkYdJrakJGp8XMt49ixZJuf=qpGm=vSxH6G_GWeenk35dQ@mail.gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Mon, Aug 15, 2022 at 06:46:46AM -0700, Yosry Ahmed wrote:
> Yeah I understand this much, what I don't understand is why we charge
> the zswap memory through objcg (thus tying it to memcg kmem charging)
> rather than directly through memcg.

The charged quantities are smaller than a page, so we have to use the
byte interface.

The byte interface (objcg) was written for slab originally, hence the
link to the kmem option. But note that CONFIG_MEMCG_KMEM is no longer
a user-visible option, and for all intents and purposes a fixed part
of CONFIG_MEMCG.

(There is the SLOB quirk. But I'm not sure anybody uses slob, let
alone slob + memcg.)
