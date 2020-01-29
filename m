Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BF58614CB65
	for <lists+cgroups@lfdr.de>; Wed, 29 Jan 2020 14:26:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726632AbgA2N0B (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 29 Jan 2020 08:26:01 -0500
Received: from mx2.suse.de ([195.135.220.15]:53344 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726140AbgA2N0B (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Wed, 29 Jan 2020 08:26:01 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 4A491ACA5;
        Wed, 29 Jan 2020 13:25:59 +0000 (UTC)
Date:   Wed, 29 Jan 2020 14:25:58 +0100
From:   Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>
To:     Christian Brauner <christian.brauner@ubuntu.com>
Cc:     linux-api@vger.kernel.org, linux-kernel@vger.kernel.org,
        Tejun Heo <tj@kernel.org>, Oleg Nesterov <oleg@redhat.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Li Zefan <lizefan@huawei.com>, cgroups@vger.kernel.org
Subject: Re: [PATCH v5 2/6] cgroup: add cgroup_get_from_file() helper
Message-ID: <20200129132557.GB11384@blackbody.suse.cz>
References: <20200121154844.411-1-christian.brauner@ubuntu.com>
 <20200121154844.411-3-christian.brauner@ubuntu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200121154844.411-3-christian.brauner@ubuntu.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue, Jan 21, 2020 at 04:48:40PM +0100, Christian Brauner <christian.brauner@ubuntu.com> wrote:
> Add a helper cgroup_get_from_file(). The helper will be used in
> subsequent patches to retrieve a cgroup while holding a reference to the
> struct file it was taken from.
Acked-by: Michal Koutný <mkoutny@suse.com>
