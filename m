Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED64750C537
	for <lists+cgroups@lfdr.de>; Sat, 23 Apr 2022 01:46:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229680AbiDVX0z (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 22 Apr 2022 19:26:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231232AbiDVX0s (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 22 Apr 2022 19:26:48 -0400
Received: from out2.migadu.com (out2.migadu.com [IPv6:2001:41d0:2:aacc::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46EE01044DC;
        Fri, 22 Apr 2022 16:04:23 -0700 (PDT)
Date:   Fri, 22 Apr 2022 16:04:15 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1650668661;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=eyRc0yPN+29xdi/4+xeUBzYJPfwPORZ6hJjRKnqdiww=;
        b=uaqc1QkUHZNZt4aC2yiX1HThiAVJiYL+EOD4N27jmScBUS7pN79qWwsjm7s7NdNzokxpOp
        Od7DFH3byiUuMHSjm66Ms8dBsJG4NwuLfkq45/FYeU1Lcj8x9CQ6q4UtjsfeT/Y6WMHc2A
        8HrFZRLJ9OXxSssElPnBVc6mBdCOPgQ=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Roman Gushchin <roman.gushchin@linux.dev>
To:     David Vernet <void@manifault.com>
Cc:     akpm@linux-foundation.org, tj@kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        cgroups@vger.kernel.org, hannes@cmpxchg.org, mhocko@kernel.org,
        shakeelb@google.com, kernel-team@fb.com
Subject: Re: [PATCH 1/5] cgroups: Refactor children cgroups in memcg tests
Message-ID: <YmM0b+3thMZaXVDb@carbon>
References: <20220422155728.3055914-1-void@manifault.com>
 <20220422155728.3055914-2-void@manifault.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220422155728.3055914-2-void@manifault.com>
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org


On Fri, Apr 22, 2022 at 08:57:25AM -0700, David Vernet wrote:
> In test_memcg_min() and test_memcg_low(), there is an array of four sibling
> cgroups. All but one of these sibling groups does a 50MB allocation, and
> the group that does no allocation is the third of four in the array.  This
> is not a problem per se, but makes it a bit tricky to do some assertions in
> test_memcg_low(), as we want to make assertions on the siblings based on
> whether or not they performed allocations. Having a static index before
> which all groups have performed an allocation makes this cleaner.
> 
> This patch therefore reorders the sibling groups so that the group that
> performs no allocations is the last in the array.

It makes the comment explaining the test just above the test_memcg_min()
function obsolete. Please, fix it too.

Thanks!
