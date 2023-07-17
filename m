Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 747E4756C56
	for <lists+cgroups@lfdr.de>; Mon, 17 Jul 2023 20:44:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229583AbjGQSou (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 17 Jul 2023 14:44:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229870AbjGQSou (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 17 Jul 2023 14:44:50 -0400
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com [IPv6:2607:f8b0:4864:20::d2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEE949D;
        Mon, 17 Jul 2023 11:44:48 -0700 (PDT)
Received: by mail-io1-xd2e.google.com with SMTP id ca18e2360f4ac-78363cc070aso271777539f.1;
        Mon, 17 Jul 2023 11:44:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689619488; x=1692211488;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WnUsVHtWOhbBc6SqMYJ3oA4XGwTAbIDV93qcCN9I8QI=;
        b=sWvLA6CgADJ/Pb2Z/tcxN22e+YnTrODv/utZE95TV2bUYwj0iERCCE7NL9bd0QiX70
         PzZqiCDCFHWtQnnIZJMXkud0LsPma9s2YcLkKwlmBcSmT40Dh092DDpN3GLFa1S+Oly8
         KWWLlHkPHKETyKwqnDU5HU3x2PTa1040FcOFeOshBlSI7xR//SYr61eBN/lNz+FaeAK9
         EqOxsB50Ztj16BB1iY5eiY+yIaf7PkY3y4kS+2SAcdkro6Nrd66aqlZWt1pAH61+/2ck
         EjL1oPUiuL+j5JVeeI+oZIc/BSRIWouGhGXdl/Rzqb98ngcAvL6MpFomvf5ZRv6EETIC
         vayA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689619488; x=1692211488;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WnUsVHtWOhbBc6SqMYJ3oA4XGwTAbIDV93qcCN9I8QI=;
        b=jQgFCmPMvr7UGTNFFFyjIEbcbuP+Ai9uO63IpZ6eIG3Q6woZc7QlxLB+nkEcH2gVzQ
         ZHOZE+TCsyOE2qruY6PS7pR1O6QMffULOWGYJ0mANDTE2cEjXi0FFWtbNyXa20FymdV1
         nsAxwZp8qnl6pqLbUsebSBGOJQkmwwMRXOCALiAboENhXSOKPUqeCCmMSdJOJxddKe4b
         2UWTctvsCZ1BBq/SRR76GlgvhbLPcux/wNwZrfI0IksYuw/ZR03ezx6p9ZhcTB6KiaFG
         lYQOuR2hkOOHn1qOfschZFgqFgjczG2OksR8lkYL1GDSOA3Ry/41Sv/NWq3Oo4UbbcjE
         kN5w==
X-Gm-Message-State: ABy/qLZTNcMoAGYBV/ktpSbBrYvN7VqZQKqMru60kjbh3u+SxRqGsx37
        p2mR7pikGvkM+aBKrTUyMgk=
X-Google-Smtp-Source: APBJJlFhJr4kbNbftUy7hgED+VwAoJbpMjB0yKZLSRYvROLLBPzIpvP+WXK3eSZze6+UpjS+8jz1HQ==
X-Received: by 2002:a5e:a719:0:b0:785:cb8d:f1c5 with SMTP id b25-20020a5ea719000000b00785cb8df1c5mr534928iod.12.1689619488067;
        Mon, 17 Jul 2023 11:44:48 -0700 (PDT)
Received: from localhost (dhcp-72-235-13-41.hawaiiantel.net. [72.235.13.41])
        by smtp.gmail.com with ESMTPSA id q19-20020a02c8d3000000b0042b35e163besm14365jao.88.2023.07.17.11.44.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Jul 2023 11:44:47 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Mon, 17 Jul 2023 08:44:46 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Kamalesh Babulal <kamalesh.babulal@oracle.com>
Cc:     Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Tom Hromatka <tom.hromatka@oracle.com>,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cgroup: remove cgrp->kn check in css_populate_dir()
Message-ID: <ZLWMHgssvfK-nQXR@slm.duckdns.org>
References: <20230717143923.1781747-1-kamalesh.babulal@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230717143923.1781747-1-kamalesh.babulal@oracle.com>
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

On Mon, Jul 17, 2023 at 08:09:23PM +0530, Kamalesh Babulal wrote:
> cgroup_create() creates cgrp and assigns the kernfs_node to cgrp->kn,
> then cgroup_mkdir() populates base and csses cft file by calling
> css_populate_dir() and cgroup_apply_control_enable() with a valid
> cgrp->kn. Check for NULL cgrp->kn, will always be false, remove it.
> 
> Signed-off-by: Kamalesh Babulal <kamalesh.babulal@oracle.com>

Applied to cgroup/for-6.6.

Thanks.

-- 
tejun
