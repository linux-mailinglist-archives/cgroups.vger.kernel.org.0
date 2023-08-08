Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9EC8E773706
	for <lists+cgroups@lfdr.de>; Tue,  8 Aug 2023 04:48:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229875AbjHHCsB (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 7 Aug 2023 22:48:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231236AbjHHCry (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 7 Aug 2023 22:47:54 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4085019F;
        Mon,  7 Aug 2023 19:47:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=X6zutb3DGwAyU/hRMIK6avnO6sQpvb4ZOPUfHytZ5UA=; b=hyI3vi0lOI+695fAJ+lMtanUIf
        jNbiQH6cQrWfwqs+wO6PSXIYXN/oMIVddImF2MgMZbjVyU9hSfr5vlLwbS7xFhxKpTaT4Lc/KOESb
        X8sWcp9MgoU+6Jq953HGloDlLtKWq3T2ZsT3xC9Rta/5FM4gWXenA/6mA0P0JnYKD6ZYOyS9ZwV8o
        wC3uFZH9lBm0qPTTD/AhLC496IXhHerUkbSywAgkqH4uX4iP0NdlVdvtUvFZMw3SAyf90st4bIbxl
        jMuzEsjec7vb+Cu7oV49dZxMKJCjhi2cwdG2LZM+oZ40zoa1t4zd2qHEHjEXPMuF/a8gs0v5p5gu1
        Guiq6hrA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qTCl5-00EvVJ-J2; Tue, 08 Aug 2023 02:47:43 +0000
Date:   Tue, 8 Aug 2023 03:47:43 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     xiongwei.song@windriver.com
Cc:     hannes@cmpxchg.org, mhocko@kernel.org, roman.gushchin@linux.dev,
        shakeelb@google.com, muchun.song@linux.dev,
        akpm@linux-foundation.org, cgroups@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/memcontrol: add tips for kmem.slabinfo
Message-ID: <ZNGsz3FC6q/jJ0+Z@casper.infradead.org>
References: <20230808022229.1560559-1-xiongwei.song@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230808022229.1560559-1-xiongwei.song@windriver.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue, Aug 08, 2023 at 10:22:29AM +0800, xiongwei.song@windriver.com wrote:
> From: Xiongwei Song <xiongwei.song@windriver.com>
> 
> No any output from kmem.slabinfo, which is not friendly. Adding
> tips for it.

What happens to tools which look in this file?
