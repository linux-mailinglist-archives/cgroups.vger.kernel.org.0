Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14CA94C2404
	for <lists+cgroups@lfdr.de>; Thu, 24 Feb 2022 07:24:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230303AbiBXGY3 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 24 Feb 2022 01:24:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229632AbiBXGY2 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 24 Feb 2022 01:24:28 -0500
Received: from out0.migadu.com (out0.migadu.com [IPv6:2001:41d0:2:267::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FA4A269A9E;
        Wed, 23 Feb 2022 22:23:59 -0800 (PST)
Date:   Wed, 23 Feb 2022 22:23:50 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1645683837;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=UfRRB507FAUwLF7B8DKy+7SBrgyByqWpyw8Xby+hOGM=;
        b=n6eTh83r0CWizVsvF7N1ipejbpvEP1n8J91rFEO+0RA514Yy5K1PxocEngDR20DAM4tnV0
        t8qv1t1WBUxTWxzQ0VjU74QkH0L5hYXtqeC+3zoU1MkGlVKmqcAeXrxrrHqjmIbAyDoR/1
        s5m7nDHHMcpiCuHYTpnPoTESF8i9O7s=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Roman Gushchin <roman.gushchin@linux.dev>
To:     Shakeel Butt <shakeelb@google.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        cgroups@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] MAINTAINERS: add myself as a memcg co-maintainer as well
Message-ID: <YhckdjLpfkGPo+ch@carbon.DHCP.thefacebook.com>
References: <20220224060148.4092228-1-shakeelb@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220224060148.4092228-1-shakeelb@google.com>
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed, Feb 23, 2022 at 10:01:48PM -0800, Shakeel Butt wrote:
> I have been contributing and reviewing to the memcg codebase for last
> couple of years. So, making it official.
> 
> Signed-off-by: Shakeel Butt <shakeelb@google.com>
> Cc: Johannes Weiner <hannes@cmpxchg.org>
> Cc: Michal Hocko <mhocko@kernel.org>
> Cc: Roman Gushchin <roman.gushchin@linux.dev>

Acked-by: Roman Gushchin <roman.gushchin@linux.dev>

It was always a pleasure to work with you, Shakeel.
Looking for more...

Thanks!
