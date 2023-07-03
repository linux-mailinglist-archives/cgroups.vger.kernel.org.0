Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9EB92746335
	for <lists+cgroups@lfdr.de>; Mon,  3 Jul 2023 21:16:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230145AbjGCTQ0 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 3 Jul 2023 15:16:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjGCTQ0 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 3 Jul 2023 15:16:26 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F608E4F
        for <cgroups@vger.kernel.org>; Mon,  3 Jul 2023 12:16:25 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id 98e67ed59e1d1-262e3c597b9so3490753a91.0
        for <cgroups@vger.kernel.org>; Mon, 03 Jul 2023 12:16:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688411784; x=1691003784;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dlgEq4UH4vDTOZrzscCBubu+ZOjeAEIOmPqCH5Q/VA4=;
        b=siqjtbELynGlxxIRUqqlm1qRIIGPI04SUqntEeyZ9DeXx8FwnRhhG/EMMubIceFYt7
         RRc7uebvlYi6FEe+8lMc6vsu5mreNBpTjxbiemcLNzjSRJHa47+8ElZ+ZrFSTMgC8SLF
         BdgsZU43OvuG+VFZfruUNF9AvzzruQwh8EtBS/bwmJpTm/c+JPYvgxaLxxfx8qiu1c3P
         t7b9zQnHnBx/ccB3g1NZG2DjONQLSTNCZOak+814Gk3OIZVIuE9lwn8CK76yHtvRnjf3
         DBGIWj/E2eMuYQAMN1bN26jfh/sw16Py4Qdwr82U39plffa37oiePNcacDwtOPVgGxP4
         Be5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688411784; x=1691003784;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dlgEq4UH4vDTOZrzscCBubu+ZOjeAEIOmPqCH5Q/VA4=;
        b=LnHTX4O1QN/19m3xMesjPgnye9vh1gikmsOl1FxmVghQkWbTpVU3n5sSIdYwiLq9RB
         Ai2W84VJE6QZLJUi7y2OaWYAkCjRajpJhvvmy6h/2UPyTvH28ApxRGUajX9JFnhUoF6j
         5ZNqGml0vvCETGtWCszL1usKr9+kWmA7qJAKefwbLmKdZ1aI/fH2lCGiqCczHrVVf+Ki
         dzz8ktlcJUvndHwl0IZBJCwv3EKnW1WmwC/mL/JfdbFhuASiJRaXMUxZGQap0rnrZ1hX
         wFu6+pQZJWwBWO1to3jV6Ap3Tzqdc5Z+Gaqxze86c6ayptJL7xfjzQU8kNfRy0M8xukd
         d+wQ==
X-Gm-Message-State: ABy/qLaBCy0GBJyx+vfvjCty0zvObkY/ey91/fChu0+BB5d1GYZtk88m
        cwpA9W7iaDUllE9dywXSUvk=
X-Google-Smtp-Source: APBJJlGqXCrlNyt1UNKb5/0hBKYxlCGcww0eRZOrxb28F+xvEtqrl67rC5Npro1ijOVvH/eEUA1PZQ==
X-Received: by 2002:a17:90a:6c06:b0:263:4156:97ec with SMTP id x6-20020a17090a6c0600b00263415697ecmr11464301pjj.34.1688411784312;
        Mon, 03 Jul 2023 12:16:24 -0700 (PDT)
Received: from localhost ([2620:10d:c090:400::5:b0b9])
        by smtp.gmail.com with ESMTPSA id i12-20020a17090aee8c00b00263418c81c5sm9054371pjz.46.2023.07.03.12.16.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Jul 2023 12:16:23 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Mon, 3 Jul 2023 09:16:21 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Sagi Grimberg <sagi@grimberg.me>
Cc:     Ofir Gal <ofir.gal@volumez.com>,
        Chaitanya Kulkarni <chaitanyak@nvidia.com>,
        "hch@lst.de" <hch@lst.de>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        cgroups@vger.kernel.org
Subject: Re: [PATCH] nvmet: allow associating port to a cgroup via configfs
Message-ID: <ZKMehaAF0v-nV1qt@slm.duckdns.org>
References: <20230627100215.1206008-1-ofir.gal@volumez.com>
 <30d03bba-c2e1-7847-f17e-403d4e648228@grimberg.me>
 <90150ffd-ba2d-6528-21b7-7ea493cd2b9a@nvidia.com>
 <79894bd9-03c7-8d27-eb6a-5e1336550449@volumez.com>
 <ab204a2d-9a30-7c90-8afa-fc84c935730f@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ab204a2d-9a30-7c90-8afa-fc84c935730f@grimberg.me>
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

Hello,

On Mon, Jul 03, 2023 at 04:21:40PM +0300, Sagi Grimberg wrote:
> > Thorttiling files and passthru isn't possible with cgroup v1 as well,
> > cgroup v2 broke the abillity to throttle bdevs. The purpose of the patch
> > is to re-enable the broken functionality.
> 
> cgroupv2 didn't break anything, this was never an intended feature of
> the linux nvme target, so it couldn't have been broken. Did anyone
> know that people are doing this with nvmet?

Maybe he's referring to the fact that cgroup1 allowed throttling root
cgroups? Maybe they were throttling from the root cgroup on the client side?

> I'm pretty sure others on the list are treating this as a suggested
> new feature for nvmet. and designing this feature as something that
> is only supported for blkdevs is undersirable.
> 
> > There was an attempt to re-enable the functionality by allowing io
> > throttle on the root cgroup but it's against the cgroup v2 design.
> > Reference:
> > https://lore.kernel.org/r/20220114093000.3323470-1-yukuai3@huawei.com/
> > 
> > A full blown nvmet cgroup controller may be a complete solution, but it
> > may take some time to achieve,
> 
> I don't see any other sane solution here.
> 
> Maybe Tejun/others think differently here?

I'm not necessarily against the idea of enabling subsystems to assign cgroup
membership to entities which aren't processes or threads. It does make sense
for cases where a kernel subsystem is serving multiple classes of users
which aren't processes as here and it's likely that we'd need something
similar for certain memory regions in a limited way (e.g. tmpfs chunk shared
across multiple cgroups).

That said, because we haven't done this before, we haven't figured out how
the API should be like and we definitely want something which can be used in
a similar fashion across the board. Also, cgroup does assume that resources
are always associated with processes or threads, and making this work with
non-task entity would require some generalization there. Maybe the solution
is to always have a tying kthread which serves as a proxy for the resource
but that seems a bit nasty at least on the first thought.

In principle, at least from cgroup POV, I think the idea of being able to
assign cgroup membership to subsystem-specific entities is okay. In
practice, there are quite a few challenges to address.

Thanks.

-- 
tejun
