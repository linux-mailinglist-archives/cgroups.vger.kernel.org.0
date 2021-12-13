Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 28DE6472014
	for <lists+cgroups@lfdr.de>; Mon, 13 Dec 2021 05:42:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231657AbhLMEmj (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Sun, 12 Dec 2021 23:42:39 -0500
Received: from relay027.a.hostedemail.com ([64.99.140.27]:16806 "EHLO
        relay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S229990AbhLMEmi (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Sun, 12 Dec 2021 23:42:38 -0500
X-Greylist: delayed 583 seconds by postgrey-1.27 at vger.kernel.org; Sun, 12 Dec 2021 23:42:38 EST
Received: from omf15.hostedemail.com (a10.router.float.18 [10.200.18.1])
        by unirelay10.hostedemail.com (Postfix) with ESMTP id 1DC4F1C1;
        Mon, 13 Dec 2021 04:32:54 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf15.hostedemail.com (Postfix) with ESMTPA id 374971B;
        Mon, 13 Dec 2021 04:32:45 +0000 (UTC)
Message-ID: <43728285a4d61331f6ba64812c21346ab6b3b0b3.camel@perches.com>
Subject: Re: [PATCH] cgroup: check the return value of kstrdup()
From:   Joe Perches <joe@perches.com>
To:     Xiaoke Wang <xkernel.wang@foxmail.com>, tj@kernel.org,
        lizefan.x@bytedance.com, hannes@cmpxchg.org
Cc:     cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Sun, 12 Dec 2021 20:32:44 -0800
In-Reply-To: <tencent_6410A5887F4B906866965C000E7A8AA3F007@qq.com>
References: <tencent_6410A5887F4B906866965C000E7A8AA3F007@qq.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.40.4-1ubuntu2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: rspamout07
X-Rspamd-Queue-Id: 374971B
X-Spam-Status: No, score=-1.03
X-Stat-Signature: fwmxg3g1jd76tis7zsnf6ir11n4gqfg6
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX181vR+oTOXvyW/ZHggfRzhfhd2OC+93nxU=
X-HE-Tag: 1639369965-582274
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Mon, 2021-12-13 at 11:30 +0800, Xiaoke Wang wrote:
> kstrdup() returns NULL when some internal memory errors happen, it is
> better to check the return value of it so to catch the memory error in
> time.
[]
> diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
[]
> @@ -2228,6 +2228,9 @@ static int cpuset_init_fs_context(struct fs_context *fc)
>  	struct cgroup_fs_context *ctx;
>  	int err;
>  
> +	if (!agent)
> +		return -ENOMEM;
> +

Did you read all the other code that uses this?
Does it matter if it's NULL?
Why is it created with kstrdup in the first place?
Why should agent be anything other than const char *?
If it's const char * it shouldn't need to be used with
kstrdup/kfree.


