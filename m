Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 546CF9A0E2
	for <lists+cgroups@lfdr.de>; Thu, 22 Aug 2019 22:13:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731991AbfHVUMD (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 22 Aug 2019 16:12:03 -0400
Received: from mx2.suse.de ([195.135.220.15]:50104 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729746AbfHVUMD (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Thu, 22 Aug 2019 16:12:03 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id BC096AE86;
        Thu, 22 Aug 2019 20:12:01 +0000 (UTC)
Date:   Thu, 22 Aug 2019 22:12:00 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Yizhuo Zhai <yzhai003@ucr.edu>
Cc:     Chengyu Song <csong@cs.ucr.edu>, Zhiyun Qian <zhiyunq@cs.ucr.edu>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        cgroups@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/memcg: return value of the function
 mem_cgroup_from_css() is not checked
Message-ID: <20190822201200.GP12785@dhcp22.suse.cz>
References: <20190822062210.18649-1-yzhai003@ucr.edu>
 <20190822070550.GA12785@dhcp22.suse.cz>
 <CABvMjLRCt4gC3GKzBehGppxfyMOb6OGQwW-6Yu_+MbMp5tN3tg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABvMjLRCt4gC3GKzBehGppxfyMOb6OGQwW-6Yu_+MbMp5tN3tg@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Thu 22-08-19 13:07:17, Yizhuo Zhai wrote:
> This will happen if variable "wb->memcg_css" is NULL. This case is reported
> by our analysis tool.

Does your tool report the particular call path and conditions when that
happen? Or is it just a "it mignt happen" kinda thing?

> Since the function mem_cgroup_wb_domain() is visible to the global, we
> cannot control caller's behavior.

I am sorry but I do not understand what is this supposed to mean.
-- 
Michal Hocko
SUSE Labs
