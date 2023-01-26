Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51E5867C51B
	for <lists+cgroups@lfdr.de>; Thu, 26 Jan 2023 08:46:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235843AbjAZHqe (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 26 Jan 2023 02:46:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235859AbjAZHqY (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 26 Jan 2023 02:46:24 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D05166A314;
        Wed, 25 Jan 2023 23:45:55 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 9302421C4F;
        Thu, 26 Jan 2023 07:45:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1674719137; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=nyfyICH/nuaTPIMu2gFSl4YjBW5PkhozqayimXZNZ+M=;
        b=nOpFGD4S/OURsfQXM1js173kpvKGKBzy0EeLOpXOxAzYIbZjud1LGPWcyGCuzPRfv/15rr
        gFZGxHj5K5Asa+oAsIcqDRgvHdi1gPKbeE5F1s5wcpevANvW4xN9xRwUSA7xKzxLfAmSkK
        Va8Nmt8liDThwSi9/UjWWiRx6zUox0A=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 5D2991358A;
        Thu, 26 Jan 2023 07:45:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id x20gE6Ev0mOwHwAAMHmgww
        (envelope-from <mhocko@suse.com>); Thu, 26 Jan 2023 07:45:37 +0000
Date:   Thu, 26 Jan 2023 08:45:36 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Marcelo Tosatti <mtosatti@redhat.com>
Cc:     Leonardo =?iso-8859-1?Q?Br=E1s?= <leobras@redhat.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Shakeel Butt <shakeelb@google.com>,
        Muchun Song <muchun.song@linux.dev>,
        Andrew Morton <akpm@linux-foundation.org>,
        cgroups@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/5] Introduce memcg_stock_pcp remote draining
Message-ID: <Y9IvoDJbLbFcitTc@dhcp22.suse.cz>
References: <20230125073502.743446-1-leobras@redhat.com>
 <Y9DpbVF+JR/G+5Or@dhcp22.suse.cz>
 <9e61ab53e1419a144f774b95230b789244895424.camel@redhat.com>
 <Y9FzSBw10MGXm2TK@tpad>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y9FzSBw10MGXm2TK@tpad>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed 25-01-23 15:22:00, Marcelo Tosatti wrote:
[...]
> Remote draining reduces interruptions whether CPU 
> is marked as isolated or not:
> 
> - Allows isolated CPUs from benefiting of pcp caching.
> - Removes the interruption to non isolated CPUs. See for example 
> 
> https://lkml.org/lkml/2022/6/13/2769

This is talking about page allocato per cpu caches, right? In this patch
we are talking about memcg pcp caches. Are you sure the same applies
here?
-- 
Michal Hocko
SUSE Labs
