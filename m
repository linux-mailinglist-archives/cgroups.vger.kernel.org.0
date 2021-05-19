Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 197B7388E8D
	for <lists+cgroups@lfdr.de>; Wed, 19 May 2021 15:02:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230328AbhESNEK (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 19 May 2021 09:04:10 -0400
Received: from mx2.suse.de ([195.135.220.15]:54342 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1344580AbhESNEK (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Wed, 19 May 2021 09:04:10 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1621429369; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=7sb7HjwB7fPx0++dMj/9B9b0asNZublt2Rrsw4OLdEM=;
        b=e0pRHpEmr0ecausFTBJgJXJ+B9iTM3MrhyGwroskLbsCkA5gAKvBwNtJN4fZvwsUFk02cw
        2PwV9h4wVAHx5prtixXUyRZXbE1TSTCSk1lRysbGfqqtTGk+ZJ79A9J4XCdHK0JtonAJfm
        dgd8baxVtJNkdxEUYOtoKH+zGDtuBqs=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id B0842B077;
        Wed, 19 May 2021 13:02:49 +0000 (UTC)
Date:   Wed, 19 May 2021 15:02:48 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Glaive Neo <nglaive@gmail.com>
Cc:     "hannes@cmpxchg.org" <hannes@cmpxchg.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        "shenwenbo@zju.edu.cn" <shenwenbo@zju.edu.cn>,
        cgroups@vger.kernel.org, linux-mm@kvack.org
Subject: Re: Fw: User-controllable memcg-unaccounted objects of time namespace
Message-ID: <YKUMePVUQlOYmVoA@dhcp22.suse.cz>
References: <CAELef9p42mQ5fvde3A7RSRZDNoDPP+VkR_3TJ5OPQYWsSQk07g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAELef9p42mQ5fvde3A7RSRZDNoDPP+VkR_3TJ5OPQYWsSQk07g@mail.gmail.com>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed 19-05-21 19:43:56, Glaive Neo wrote:
> CC reply. Sorry for occupying your time. I was unaware that I had to
> use plain text e-mail to make public mailing list accept it, and I
> omitted these addresses to avoid rejecting notification.

HTML email are often dropped but they shouldn't be used as they make any
sensible communication hard (impossible at times). We also use (and
require) to use in-line replies so that it is clear what you are
actually replying to.

I would also strongly recommend to stick with the email thread. There
are tools to download complete email threads based on message-id in case
you do not have them
(https://people.kernel.org/monsieuricon/introducing-b4-and-patch-attestation).

HTH
-- 
Michal Hocko
SUSE Labs
