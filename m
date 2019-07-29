Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D4FCC7935E
	for <lists+cgroups@lfdr.de>; Mon, 29 Jul 2019 20:48:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726713AbfG2Ssx (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 29 Jul 2019 14:48:53 -0400
Received: from mx2.suse.de ([195.135.220.15]:54776 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725894AbfG2Ssx (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Mon, 29 Jul 2019 14:48:53 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id CB20FAEFD;
        Mon, 29 Jul 2019 18:48:51 +0000 (UTC)
Date:   Mon, 29 Jul 2019 20:48:50 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Yang Shi <shy828301@gmail.com>
Cc:     Konstantin Khlebnikov <khlebnikov@yandex-team.ru>,
        Linux MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        cgroups@vger.kernel.org, Vladimir Davydov <vdavydov.dev@gmail.com>,
        Johannes Weiner <hannes@cmpxchg.org>
Subject: Re: [PATCH RFC] mm/memcontrol: reclaim severe usage over high limit
 in get_user_pages loop
Message-ID: <20190729184850.GH9330@dhcp22.suse.cz>
References: <156431697805.3170.6377599347542228221.stgit@buzz>
 <20190729091738.GF9330@dhcp22.suse.cz>
 <3d6fc779-2081-ba4b-22cf-be701d617bb4@yandex-team.ru>
 <20190729103307.GG9330@dhcp22.suse.cz>
 <CAHbLzkrdj-O2uXwM8ujm90OcgjyR4nAiEbFtRGe7SOoY_fs=BA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHbLzkrdj-O2uXwM8ujm90OcgjyR4nAiEbFtRGe7SOoY_fs=BA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Mon 29-07-19 10:28:43, Yang Shi wrote:
[...]
> I don't worry too much about scale since the scale issue is not unique
> to background reclaim, direct reclaim may run into the same problem.

Just to clarify. By scaling problem I mean 1:1 kswapd thread to memcg.
You can have thousands of memcgs and I do not think we really do want
to create one kswapd for each. Once we have a kswapd thread pool then we
get into a tricky land where a determinism/fairness would be non trivial
to achieve. Direct reclaim, on the other hand is bound by the workload
itself.
-- 
Michal Hocko
SUSE Labs
