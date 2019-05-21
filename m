Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C46492523F
	for <lists+cgroups@lfdr.de>; Tue, 21 May 2019 16:34:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728045AbfEUOeR (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 21 May 2019 10:34:17 -0400
Received: from mx2.suse.de ([195.135.220.15]:38094 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726900AbfEUOeR (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Tue, 21 May 2019 10:34:17 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id E3E03AF3F;
        Tue, 21 May 2019 14:34:15 +0000 (UTC)
Date:   Tue, 21 May 2019 16:34:14 +0200
From:   Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>
To:     Joel Savitz <jsavitz@redhat.com>
Cc:     linux-kernel@vger.kernel.org, Li Zefan <lizefan@huawei.com>,
        Tejun Heo <tj@kernel.org>, Waiman Long <longman@redhat.com>,
        Phil Auld <pauld@redhat.com>, cgroups@vger.kernel.org
Subject: Re: [PATCH v2] cpuset: restore sanity to
 cpuset_cpus_allowed_fallback()
Message-ID: <20190521143414.GJ5307@blackbody.suse.cz>
References: <20190409204003.6428-1-jsavitz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190409204003.6428-1-jsavitz@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue, Apr 09, 2019 at 04:40:03PM -0400, Joel Savitz <jsavitz@redhat.com> wrote:
> 	$ grep Cpus /proc/$$/status
> 	Cpus_allowed:	ff
> 	Cpus_allowed_list:	0-7

(a)
 
> 	$ taskset -p 4 $$
> 	pid 19202's current affinity mask: f
> 	pid 19202's new affinity mask: 4
> 
> 	$ grep Cpus /proc/self/status
> 	Cpus_allowed:	04
> 	Cpus_allowed_list:	2
> 
> 	# echo off > /sys/devices/system/cpu/cpu2/online
> 	$ grep Cpus /proc/$$/status
> 	Cpus_allowed:	0b
> 	Cpus_allowed_list:	0-1,3
I'm confused where this value comes from, I must be missing something.

Joel, is the task in question put into a cpuset with 0xf CPUs only (at
point (a))? Or are the CPUs 4-7 offlined as well?

Thanks,
Michal
