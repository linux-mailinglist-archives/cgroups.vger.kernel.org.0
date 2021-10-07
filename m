Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 81DFC424EF6
	for <lists+cgroups@lfdr.de>; Thu,  7 Oct 2021 10:13:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232589AbhJGIPS (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 7 Oct 2021 04:15:18 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:51582 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233489AbhJGIPS (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 7 Oct 2021 04:15:18 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id DE2F51FF45;
        Thu,  7 Oct 2021 08:13:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1633594403; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=6kWPeAL5YdhKOgGiPm0d0ACf2LYS8mjdOECzh1wZutw=;
        b=SwzZDw98grNFIGy/1P65glPZG+dWl9idjalCyIqFu2qTCnRYtiatBwG3vqjPjLctW7ORql
        bbPf5k2lOY29DT+MUNU+fq9PAEA84G+KTQyuqB8/VUKqtedYbR7SCDZvfnMWKXc+lh2BIp
        /VEESlmkT/m7HLy9D2jbyCv3z5reyvE=
Received: from suse.cz (unknown [10.100.201.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id AD7C2A3B83;
        Thu,  7 Oct 2021 08:13:23 +0000 (UTC)
Date:   Thu, 7 Oct 2021 10:13:23 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Vasily Averin <vvs@virtuozzo.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Cgroups <cgroups@vger.kernel.org>, Linux MM <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        kernel@openvz.org
Subject: Re: memcg memory accounting in vmalloc is broken
Message-ID: <YV6sIz5UjfbhRyHN@dhcp22.suse.cz>
References: <b3c232ff-d9dc-4304-629f-22cc95df1e2e@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b3c232ff-d9dc-4304-629f-22cc95df1e2e@virtuozzo.com>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Thu 07-10-21 11:04:40, Vasily Averin wrote:
> vmalloc was switched to __alloc_pages_bulk but it does not account the memory to memcg.
> 
> Is it known issue perhaps?

No, I think this was just overlooked. Definitely doesn't look
intentional to me.
-- 
Michal Hocko
SUSE Labs
