Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F122D142EE8
	for <lists+cgroups@lfdr.de>; Mon, 20 Jan 2020 16:39:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728935AbgATPjl (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 20 Jan 2020 10:39:41 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:53389 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726819AbgATPjk (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 20 Jan 2020 10:39:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1579534779;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=PlTLiw4VTkftWvjolml/QIq+8aGtfq5D8y4S3zLmz20=;
        b=AvFF6f0puOM1GFlpluPvNNDWJCxdtT9s1Aj64zU2CMm+NT7LoMF9VU+FmjFH5aqxOMkyrA
        ak4Cvo5D3k7tmDV/z600rz320g+iUUhtYOwN/hyx9tGbZygWTQmEqqJutpZot8FpdYD1vT
        h1DmOgPm/UtEoJfuIahPQfVyGs2v4ic=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-7-2D3ksJljMAut7XwYC7qowg-1; Mon, 20 Jan 2020 10:39:36 -0500
X-MC-Unique: 2D3ksJljMAut7XwYC7qowg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0C3F4107ACC5;
        Mon, 20 Jan 2020 15:39:34 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.43.17.70])
        by smtp.corp.redhat.com (Postfix) with SMTP id 733BD5C290;
        Mon, 20 Jan 2020 15:39:31 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Mon, 20 Jan 2020 16:39:33 +0100 (CET)
Date:   Mon, 20 Jan 2020 16:39:30 +0100
From:   Oleg Nesterov <oleg@redhat.com>
To:     Christian Brauner <christian.brauner@ubuntu.com>
Cc:     linux-api@vger.kernel.org, linux-kernel@vger.kernel.org,
        Tejun Heo <tj@kernel.org>, Ingo Molnar <mingo@redhat.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Li Zefan <lizefan@huawei.com>,
        Peter Zijlstra <peterz@infradead.org>, cgroups@vger.kernel.org
Subject: Re: [PATCH v4 5/6] clone3: allow spawning processes into cgroups
Message-ID: <20200120153930.GE30403@redhat.com>
References: <20200117181219.14542-1-christian.brauner@ubuntu.com>
 <20200117181219.14542-6-christian.brauner@ubuntu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200117181219.14542-6-christian.brauner@ubuntu.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 01/17, Christian Brauner wrote:
>
> +static int cgroup_css_set_fork(struct task_struct *parent,
> +			       struct kernel_clone_args *kargs)
...
> +	kargs->cset = find_css_set(cset, dst_cgrp);
> +	if (!kargs->cset) {
> +		ret = -ENOMEM;
> +		goto err;
> +	}
> +
> +	if (cgroup_is_dead(dst_cgrp)) {
> +		ret = -ENODEV;
> +		goto err;
                ^^^^^^^^

this looks wrong... don't we need put_css_set(kargs->cset) before "goto err" ?

Oleg.

