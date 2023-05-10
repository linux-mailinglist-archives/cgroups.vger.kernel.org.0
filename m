Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D1A96FD937
	for <lists+cgroups@lfdr.de>; Wed, 10 May 2023 10:26:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236546AbjEJI0H (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 10 May 2023 04:26:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236489AbjEJIZ7 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 10 May 2023 04:25:59 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 289E75595;
        Wed, 10 May 2023 01:25:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 846D363BE4;
        Wed, 10 May 2023 08:25:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3858CC4339B;
        Wed, 10 May 2023 08:25:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1683707156;
        bh=yyuOZPHJUbcP9aRarpv4MRiXOkJWXGAGGyeBIlMq4nc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=0LiSIdWiydHsjiJsZ54H/qYkl8uWEKUlPA1USETAuz4e/hFVQ+Ekx7+/+fUO6lZ8u
         +hp8e+zrKfDfaeUa/gyx6wqCtOsUIwF5TKHQLHhrUvCHv23cDbUCpr3sFqNXY606RL
         WwUdqKEAeBMjRJRVVFULAWqg/156NVs9dBQo2dLY=
Date:   Wed, 10 May 2023 10:25:54 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Yuanchu Xie <yuanchu@google.com>
Cc:     David Hildenbrand <david@redhat.com>,
        "Sudarshan Rajagopalan (QUIC)" <quic_sudaraja@quicinc.com>,
        kai.huang@intel.com, hch@lst.de, jon@nutanix.com,
        SeongJae Park <sj@kernel.org>,
        Shakeel Butt <shakeelb@google.com>,
        Aneesh Kumar K V <aneesh.kumar@linux.ibm.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Muchun Song <muchun.song@linux.dev>,
        Yu Zhao <yuzhao@google.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Yosry Ahmed <yosryahmed@google.com>,
        Vasily Averin <vasily.averin@linux.dev>,
        talumbau <talumbau@google.com>, linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org, linux-mm@kvack.org,
        cgroups@vger.kernel.org
Subject: Re: [RFC PATCH 1/2] mm: multigen-LRU: working set reporting
Message-ID: <2023051016-snarl-fame-9d6b@gregkh>
References: <20230509185419.1088297-1-yuanchu@google.com>
 <20230509185419.1088297-2-yuanchu@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230509185419.1088297-2-yuanchu@google.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed, May 10, 2023 at 02:54:18AM +0800, Yuanchu Xie wrote:
> From: talumbau <talumbau@google.com>

Please fix the name here.

> 
> A single patch to be broken up into multiple patches.

What does this mean?

> - Add working set reporting structure.
> - Add per-node and per-memcg interfaces for working set reporting.
> - Implement working set backend for MGLRU.

Please break it up to be reviewable, otherwise no one will review it.

thanks,

greg k-h
