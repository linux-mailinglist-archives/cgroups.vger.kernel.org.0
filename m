Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E4E9D40592E
	for <lists+cgroups@lfdr.de>; Thu,  9 Sep 2021 16:37:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245620AbhIIOiW (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 9 Sep 2021 10:38:22 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:35240 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242269AbhIIOiO (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 9 Sep 2021 10:38:14 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 127AA223A4;
        Thu,  9 Sep 2021 14:37:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1631198224; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=XkjD8/xyvDQHdHUfoLy2/8tk1jskQyMQBKAq3vWNNNw=;
        b=cGUl4e12Cz7LifcU+dCpN+PO0BFGCuqyMjoxtq4Q+YiKgGXCS2Ui6xTYRabhmIM/bTWJsm
        +g24jV+E2yxs/Pj65vIuaeXCAp9L6FdAid3wIBZ6FnFfZADQllqBWlODlZ+mSf5IkAtWJ2
        fqxrzsrTmRAnZssIOypJQgIzdLJyNr4=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D565C13C53;
        Thu,  9 Sep 2021 14:37:03 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id jDH9Mg8cOmHJOwAAMHmgww
        (envelope-from <mkoutny@suse.com>); Thu, 09 Sep 2021 14:37:03 +0000
Date:   Thu, 9 Sep 2021 16:37:02 +0200
From:   Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>
To:     brookxu <brookxu.cn@gmail.com>
Cc:     tj@kernel.org, lizefan.x@bytedance.com, hannes@cmpxchg.org,
        vipinsh@google.com, linux-kernel@vger.kernel.org,
        cgroups@vger.kernel.org
Subject: Re: [RFC PATCH 1/3] misc_cgroup: introduce misc.events and
 misc_events.local
Message-ID: <20210909143702.GA13761@blackbody.suse.cz>
References: <988f340462a1a3c62b7dc2c64ceb89a4c0a00552.1631077837.git.brookxu@tencent.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <988f340462a1a3c62b7dc2c64ceb89a4c0a00552.1631077837.git.brookxu@tencent.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hello Chunguang.

The new version looks like a good step generally. 

My main remark is that I wouldn't make a distinct v1 and v2 interface,
it's a new controller so I think the v2 could be exposed in both cases
(or in other words, don't create new v1-specific features).

On Wed, Sep 08, 2021 at 01:24:34PM +0800, brookxu <brookxu.cn@gmail.com> wrote:
> Introduce misc.events and misc.events.local to make it easier for
> us to understand the pressure of resources. The main idea comes
> from mem_cgroup.

BTW what are the events you really are interesed in? (See also the
proposal in my reply to 1/3.)

> @@ -171,6 +171,16 @@ int misc_cg_try_charge(enum misc_res_type type, struct misc_cg *cg,
>  	return 0;
>  
>  err_charge:
> +	if (cgroup_subsys_on_dfl(misc_cgrp_subsys)) {
> +		atomic_long_inc(&i->events_local[type]);
> +		cgroup_file_notify(&i->events_local_file);
> +
> +		for (k = i; k; k = parent_misc(k)) {
> +			atomic_long_inc(&k->events[type]);
> +			cgroup_file_notify(&k->events_file);
> +		}
> +	}
> +

No reason to wrap this for the default hierarchy only.

> +static int misc_events_show(struct seq_file *sf, void *v)
> +{
> +	struct misc_cg *cg = css_misc(seq_css(sf));
> +	unsigned long count, i;
> +
> +	for (i = 0; i < MISC_CG_RES_TYPES; i++) {
> +		count = atomic_long_read(&cg->events[i]);
> +		if (READ_ONCE(misc_res_capacity[i]) || count)
> +			seq_printf(sf, "%s %lu\n", misc_res_name[i], count);

More future-proof key would be
			seq_printf(sf, "%s.max %lu\n", misc_res_name[i], count);
or
			seq_printf(sf, "max.%s %lu\n", misc_res_name[i], count);

(Which one is a judgement call but I'd include the "name" of event type too.)

> +static int misc_events_local_show(struct seq_file *sf, void *v)
> +{
> +	struct misc_cg *cg = css_misc(seq_css(sf));
> +	unsigned long count, i;
> +
> +	for (i = 0; i < MISC_CG_RES_TYPES; i++) {
> +		count = atomic_long_read(&cg->events_local[i]);
> +		if (READ_ONCE(misc_res_capacity[i]) || count)
> +			seq_printf(sf, "%s %lu\n", misc_res_name[i], count);

Ditto.

Thanks,
Michal
