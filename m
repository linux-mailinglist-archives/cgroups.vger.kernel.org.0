Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4406452371B
	for <lists+cgroups@lfdr.de>; Wed, 11 May 2022 17:23:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238809AbiEKPXC (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 11 May 2022 11:23:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343532AbiEKPXB (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 11 May 2022 11:23:01 -0400
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EA7A5677F
        for <cgroups@vger.kernel.org>; Wed, 11 May 2022 08:23:00 -0700 (PDT)
Received: by mail-qt1-x832.google.com with SMTP id h3so2234341qtn.4
        for <cgroups@vger.kernel.org>; Wed, 11 May 2022 08:23:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=w9MfWQzcSMrfAB8m54hQ3mQgRCuKTad5K055CRIl8Vo=;
        b=QHywmB7fZKi72sdflTBtW+kFZJRQSuZqWDaMwXqm9WlGt+siby1JuJMbb4mVAD3aS5
         iejYTkI59BMc6y/oIXBVWa/9MeazGxDgdZ6JnQ4acVJEzufjZQsDtznMDuu+1warN0qK
         MYfH0+Of2lno/uFNjSHx3f2rOG+DoVkqmq+h1Yo5O5S0KFbMpMU866O+NGrpTpFVmwIo
         rZFIV/+obJD9S6I2t67nE7tVzhD3t8tjCZrDfcCgTj2X/3gaPOBFQPCIDW6o9dE/fle5
         3WnODSV3b58gj79dPkcuaodpP+ksbzv8GPwBbBm1Po7hU8tSatFR5ZUjnyObXnudlq7S
         4jDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=w9MfWQzcSMrfAB8m54hQ3mQgRCuKTad5K055CRIl8Vo=;
        b=Y72udHvxypQU+8Cu9EOd3GVlj92Kv0UUZIMDVUZApIDOMcJ+GUOoziqPSIprjXBqzZ
         XKvSvoUMHXGduj/Hp6yTAl4vHYavSmJQXHaR7vLQcS5oTGisPfK1YUiweGfERUFdMCxR
         iR/d2+U45CGfDvt09DPhlP0NPLvmzD5lVGPi5J8AA/GX4XpdWuML09OYvDnoydUoLH+X
         SK+TOBl5vwwrsAYiPM211gFB0jjx7UIV3B86NCaKvXaYb88u/X1QJd4+H6OsFiVSAVER
         +Kyjd5TxdXi7vVBO16IHWn1shB6XjxLemRU2/WsY7JaiDee+mmnXyVAlvaDO6ZK05Dk7
         EZow==
X-Gm-Message-State: AOAM533eaHzaBajL3UY4UTaT5LzRZXfSOHYKrjZR2LlGVTyk0FVMXCU9
        fxwaEfd1UN0jiy03kVzxjaO7XQ==
X-Google-Smtp-Source: ABdhPJygx90TKioxIedyEuaaHYWfH4OHP1lN+qlpZAjVyMK6tPk/6Hw911lnpLax7mo7cs7O9mkw+g==
X-Received: by 2002:a05:622a:355:b0:2f3:b955:fa2d with SMTP id r21-20020a05622a035500b002f3b955fa2dmr24143416qtw.132.1652282579247;
        Wed, 11 May 2022 08:22:59 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::1:14fe])
        by smtp.gmail.com with ESMTPSA id bl34-20020a05620a1aa200b0069fc13ce1f3sm1468229qkb.36.2022.05.11.08.22.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 May 2022 08:22:58 -0700 (PDT)
Date:   Wed, 11 May 2022 11:22:58 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Michal Hocko <mhocko@suse.com>, Roman Gushchin <guro@fb.com>,
        Shakeel Butt <shakeelb@google.com>,
        Seth Jennings <sjenning@redhat.com>,
        Dan Streetman <ddstreet@ieee.org>,
        Minchan Kim <minchan@kernel.org>, linux-mm@kvack.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com
Subject: Re: [PATCH v2 3/6] mm: Kconfig: group swap, slab, hotplug and thp
 options into submenus
Message-ID: <YnvU0hwCfQ11P8Ce@cmpxchg.org>
References: <20220510152847.230957-1-hannes@cmpxchg.org>
 <20220510152847.230957-4-hannes@cmpxchg.org>
 <20220510154037.c7916ee9d7de90eedd12f92c@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220510154037.c7916ee9d7de90eedd12f92c@linux-foundation.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue, May 10, 2022 at 03:40:37PM -0700, Andrew Morton wrote:
> On Tue, 10 May 2022 11:28:44 -0400 Johannes Weiner <hannes@cmpxchg.org> wrote:
> 
> > There are several clusters of related config options spread throughout
> > the mostly flat MM submenu. Group them together and put specialization
> > options into further subdirectories to make the MM submenu a bit more
> > organized and easier to navigate.
> 
> Causes
> 
> hp2:/usr/src/25> make allnoconfig

My bad. I'll respin those on top of the others and add allnoconfig
builds to my testing routine. Thanks.
