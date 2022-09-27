Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F34CC5EB74E
	for <lists+cgroups@lfdr.de>; Tue, 27 Sep 2022 04:00:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229556AbiI0CAL (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 26 Sep 2022 22:00:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbiI0CAK (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 26 Sep 2022 22:00:10 -0400
Received: from out1.migadu.com (out1.migadu.com [IPv6:2001:41d0:2:863f::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EB32326D2;
        Mon, 26 Sep 2022 19:00:09 -0700 (PDT)
Date:   Mon, 26 Sep 2022 19:00:01 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1664244007;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QAUHGYCO/qQ2SwttBy7KnlWgbLVqmhgcIz7g3trZDTk=;
        b=olgkAn++swZM7w/xk8nii6twtgKZ5RPxlL+GEuWv+NNepi4z6oJsHjDrEzDGEZjvSBaIAz
        39Vj7Iw5tRsZLbE1qm+r2kt9UyeLxm71DUvj8c1RKQ8z/RaGpfb1v4jqzkvNVxu9VBtJgd
        8pZ7/DO788og4cRAdQn8VSjdRc9GkUA=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Roman Gushchin <roman.gushchin@linux.dev>
To:     Shakeel Butt <shakeelb@google.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Muchun Song <songmuchun@bytedance.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
        cgroups@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Anatoly Pugachev <matorola@gmail.com>,
        Vasily Averin <vvs@openvz.org>,
        Jakub Kicinski <kuba@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        sparclinux@vger.kernel.org
Subject: Re: [PATCH] Revert "net: set proper memcg for net_init hooks
 allocations"
Message-ID: <YzJZIa8xXYZozvov@P9FQF9L96D>
References: <20220926195931.2497968-1-shakeelb@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220926195931.2497968-1-shakeelb@google.com>
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Mon, Sep 26, 2022 at 07:59:31PM +0000, Shakeel Butt wrote:
> This reverts commit 1d0403d20f6c281cb3d14c5f1db5317caeec48e9.
> 
> Anatoly Pugachev reported that the commit 1d0403d20f6c ("net: set proper
> memcg for net_init hooks allocations") is somehow causing the sparc64
> VMs failed to boot and the VMs boot fine with that patch reverted. So,
> revert the patch for now and later we can debug the issue.
> 
> Reported-by: Anatoly Pugachev <matorola@gmail.com>
> Signed-off-by: Shakeel Butt <shakeelb@google.com>
> Cc: Vasily Averin <vvs@openvz.org>
> Cc: Jakub Kicinski <kuba@kernel.org>
> Cc: Michal Koutný <mkoutny@suse.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Linus Torvalds <torvalds@linux-foundation.org>
> Cc: cgroups@vger.kernel.org
> Cc: sparclinux@vger.kernel.org
> Cc: linux-mm@kvack.org
> Cc: linux-kernel@vger.kernel.org

Acked-by: Roman Gushchin <roman.gushchin@linux.dev>

Thanks, Shakeel!
