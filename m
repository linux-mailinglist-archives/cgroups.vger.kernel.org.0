Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77D8C50EE5A
	for <lists+cgroups@lfdr.de>; Tue, 26 Apr 2022 03:56:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235070AbiDZB7X (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 25 Apr 2022 21:59:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229834AbiDZB7X (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 25 Apr 2022 21:59:23 -0400
Received: from out1.migadu.com (out1.migadu.com [IPv6:2001:41d0:2:863f::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB9C46FA0B;
        Mon, 25 Apr 2022 18:56:17 -0700 (PDT)
Date:   Mon, 25 Apr 2022 18:56:08 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1650938176;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=eknS5mZjx4pi0PW50DuACc81xMEJlhElzkFotI9xECI=;
        b=Zy5KwFrskWKcY3bLKvYR+K/romXFvT8ubAkmxpL922s/9KYhDYlCYyxcYgBNWmO6yRbAyC
        IFVV3DYFHNBmr/F90mhh7Pla2zpFxQqPYO7rgaZdV6JsTx9RICKkLRnpAIprEhvq78S2W5
        GPndu/sXoZVZyLWfyONdz6s6ipZHESo=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Roman Gushchin <roman.gushchin@linux.dev>
To:     David Vernet <void@manifault.com>
Cc:     akpm@linux-foundation.org, tj@kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        cgroups@vger.kernel.org, hannes@cmpxchg.org, mhocko@kernel.org,
        shakeelb@google.com, kernel-team@fb.com
Subject: Re: [PATCH v2 1/5] cgroups: Refactor children cgroups in memcg tests
Message-ID: <YmdROKOEfiP1rk8q@carbon>
References: <20220423155619.3669555-1-void@manifault.com>
 <20220423155619.3669555-2-void@manifault.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220423155619.3669555-2-void@manifault.com>
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Sat, Apr 23, 2022 at 08:56:17AM -0700, David Vernet wrote:
> In test_memcg_min() and test_memcg_low(), there is an array of four sibling
> cgroups. All but one of these sibling groups does a 50MB allocation, and
> the group that does no allocation is the third of four in the array.  This
> is not a problem per se, but makes it a bit tricky to do some assertions in
> test_memcg_low(), as we want to make assertions on the siblings based on
> whether or not they performed allocations. Having a static index before
> which all groups have performed an allocation makes this cleaner.
> 
> This patch therefore reorders the sibling groups so that the group that
> performs no allocations is the last in the array. A follow-on patch will
> leverage this to fix a bug in the test that incorrectly asserts that a
> sibling group that had performed an allocation, but only had protection
> from its parent, will not observe any memory.events.low events during
> reclaim.
> 
> Signed-off-by: David Vernet <void@manifault.com>

Acked-by: Roman Gushchin <roman.gushchin@linux.dev>

Thanks!
