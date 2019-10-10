Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E694BD21CB
	for <lists+cgroups@lfdr.de>; Thu, 10 Oct 2019 09:39:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733144AbfJJHiK (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 10 Oct 2019 03:38:10 -0400
Received: from mx2.suse.de ([195.135.220.15]:46604 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1733073AbfJJHd5 (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Thu, 10 Oct 2019 03:33:57 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id A5BF1B169;
        Thu, 10 Oct 2019 07:33:54 +0000 (UTC)
Date:   Thu, 10 Oct 2019 09:19:37 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Yizhuo Zhai <yzhai003@ucr.edu>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        cgroups@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Zhiyun Qian <zhiyunq@cs.ucr.edu>,
        Chengyu Song <csong@cs.ucr.edu>
Subject: Re: Potential NULL pointer deference in mm/memcontrol.c
Message-ID: <20191010071937.GA18412@dhcp22.suse.cz>
References: <CABvMjLRgShsBiod+GVcqirmKeFLN_KfxdDDwGo22YK0wULepwA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABvMjLRgShsBiod+GVcqirmKeFLN_KfxdDDwGo22YK0wULepwA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed 09-10-19 21:56:04, Yizhuo Zhai wrote:
> Hi All:
> mm/memcontrol.c:
> The function mem_cgroup_from_css() could return NULL, but some callers

This is the case only when the memory cgroup controller is disabled
which is a boot time option.

> in this file
> checks the return value but directly dereference it, which seems
> potentially unsafe.
> Such callers include mem_cgroup_hierarchy_read(),
> mem_cgroup_hierarchy_write(), mem_cgroup_read_u64(),
> mem_cgroup_reset(), etc.

And none of those should be ever called under that condition AFAICS.

Thanks!
-- 
Michal Hocko
SUSE Labs
