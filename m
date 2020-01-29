Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4C0BB14CB62
	for <lists+cgroups@lfdr.de>; Wed, 29 Jan 2020 14:25:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726186AbgA2NZt (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 29 Jan 2020 08:25:49 -0500
Received: from mx2.suse.de ([195.135.220.15]:53220 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726140AbgA2NZs (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Wed, 29 Jan 2020 08:25:48 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id A5101AC46;
        Wed, 29 Jan 2020 13:25:46 +0000 (UTC)
Date:   Wed, 29 Jan 2020 14:25:41 +0100
From:   Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>
To:     Christian Brauner <christian.brauner@ubuntu.com>
Cc:     linux-api@vger.kernel.org, linux-kernel@vger.kernel.org,
        Tejun Heo <tj@kernel.org>, Oleg Nesterov <oleg@redhat.com>,
        Li Zefan <lizefan@huawei.com>,
        Johannes Weiner <hannes@cmpxchg.org>, cgroups@vger.kernel.org
Subject: Re: [PATCH v5 1/6] cgroup: unify attach permission checking
Message-ID: <20200129132540.GA11384@blackbody.suse.cz>
References: <20200121154844.411-1-christian.brauner@ubuntu.com>
 <20200121154844.411-2-christian.brauner@ubuntu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200121154844.411-2-christian.brauner@ubuntu.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue, Jan 21, 2020 at 04:48:39PM +0100, Christian Brauner <christian.brauner@ubuntu.com> wrote:
> +static int cgroup_attach_permissions(struct cgroup *src_cgrp,
> +				     struct cgroup *dst_cgrp,
> +				     struct super_block *sb, bool thread)
I suggest inverting the logic of the last argument to make it consistent
with other functions that use threadgroup argument for similar
distinction.

Apart from that
Acked-by: Michal Koutný <mkoutny@suse.com>
