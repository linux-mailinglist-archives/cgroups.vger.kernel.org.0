Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1EBD627EE38
	for <lists+cgroups@lfdr.de>; Wed, 30 Sep 2020 18:04:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730984AbgI3QED (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 30 Sep 2020 12:04:03 -0400
Received: from mx2.suse.de ([195.135.220.15]:51838 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725355AbgI3QED (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Wed, 30 Sep 2020 12:04:03 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1601481842;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=nTUDG960FYM7UmGMMfoADRNhufXM+zoM+0CfxkIAuN4=;
        b=jMw29Cny/jePBucqingAkX8GAPZHCpRNT8+h3vG0c5eM5M5YwQ9spOvuZn0PXZVWjAUztu
        ymXJawkp479YHaR/HuXBOkSttyMsWvQd8EDmzKEvDsjwcd8pYyG+VEB+n/o8ybdwogXWs4
        y6s11IvL47u1aDJcZCCJgEwMgmpp794=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id DD96BAE02;
        Wed, 30 Sep 2020 16:04:01 +0000 (UTC)
Date:   Wed, 30 Sep 2020 18:03:57 +0200
From:   Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>
To:     Jouni Roivas <jouni.roivas@tuxera.com>
Cc:     tj@kernel.org, lizefan@huawei.com, hannes@cmpxchg.org,
        cgroups@vger.kernel.org
Subject: Re: [PATCH] cgroup: Zero sized write should be no-op
Message-ID: <20200930160357.GA25838@blackbody.suse.cz>
References: <20200928131013.3816044-1-jouni.roivas@tuxera.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200928131013.3816044-1-jouni.roivas@tuxera.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hi Jouni.

On Mon, Sep 28, 2020 at 04:10:13PM +0300, Jouni Roivas <jouni.roivas@tuxera.com> wrote:
> Do not report failure on zero sized writes, and handle them as no-op.
This is a user visible change (in the case of a single write(2)), OTOH,
`man write` says:
> If count is zero and fd refers to a file other than a regular file,
> the results are not specified.


> @@ -3682,6 +3700,9 @@ static ssize_t cgroup_file_write(struct kernfs_open_file *of, char *buf,
>  	struct cgroup_subsys_state *css;
>  	int ret;
>  
> +	if (!nbytes)
> +		return 0;
> +
>  	/*
>  	 * If namespaces are delegation boundaries, disallow writes to
>  	 * files in an non-init namespace root from inside the namespace
Shouldn't just this guard be sufficient? 

Michal
