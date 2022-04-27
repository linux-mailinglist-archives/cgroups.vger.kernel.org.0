Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8191F511CDD
	for <lists+cgroups@lfdr.de>; Wed, 27 Apr 2022 20:33:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243555AbiD0RCS (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 27 Apr 2022 13:02:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243741AbiD0RCP (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 27 Apr 2022 13:02:15 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09F92580CA;
        Wed, 27 Apr 2022 09:58:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 11BD661DEB;
        Wed, 27 Apr 2022 16:58:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE41BC385A9;
        Wed, 27 Apr 2022 16:58:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651078736;
        bh=FmfW5mMXWhX2Mi+Sbzj2wt7tROQxvWHwctYg2Qae4Bs=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=kJEVq7HesLGTQJq0kIoH1ndsPmZ40qDReAmWZS3ti4uUl2G/kn9RMhEPqshgxYuMF
         lGJaIqTtcb4mcnCDfdf/OonSC6z2Af/PcKHGWs98w32UM1488iy1uz+ZNYkWwRKJa6
         b+D7b6pS34Y6LmzCkItPYwixCmyXYgCoCyUF/FsOsl6rXGCVi2pR60nKFZZWOS5mXC
         CevsIgWlc1zSpToivy+avqALh9jYDmynXs7DtjEErefOuq0UZ1/xaFJMGTqJ3GQ8pa
         b5DVuBoD+dssYoLYK2Hfdmz9EE5QREy9P5CNDR9GAtoh18aG/O8Bx0Z4rzDpM5zw+Z
         Iyd+tjZb5I7tg==
Date:   Wed, 27 Apr 2022 09:58:54 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Vasily Averin <vvs@openvz.org>
Cc:     Roman Gushchin <roman.gushchin@linux.dev>,
        Vlastimil Babka <vbabka@suse.cz>,
        Shakeel Butt <shakeelb@google.com>, kernel@openvz.org,
        linux-kernel@vger.kernel.org, Michal Hocko <mhocko@suse.com>,
        cgroups@vger.kernel.org, netdev@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>,
        Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH] memcg: enable accounting for veth queues
Message-ID: <20220427095854.79554fab@kernel.org>
In-Reply-To: <1c338b99-8133-6126-2ff2-94a4d3f26451@openvz.org>
References: <1c338b99-8133-6126-2ff2-94a4d3f26451@openvz.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed, 27 Apr 2022 13:34:29 +0300 Vasily Averin wrote:
> Subject: [PATCH] memcg: enable accounting for veth queues

This is a pure networking patch, right? The prefix should be "net: ",
I think.

> veth netdevice defines own rx queues and allocates array containing
> up to 4095 ~750-bytes-long 'struct veth_rq' elements. Such allocation
> is quite huge and should be accounted to memcg.
> 
> Signed-off-by: Vasily Averin <vvs@openvz.org>
