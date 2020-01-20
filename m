Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7BD97142DDD
	for <lists+cgroups@lfdr.de>; Mon, 20 Jan 2020 15:43:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726885AbgATOmz (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 20 Jan 2020 09:42:55 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:41931 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726819AbgATOmy (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 20 Jan 2020 09:42:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1579531373;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=BQYougp4+VHH4evwtllbxoi9axAUvWpVMA1ll1rXksg=;
        b=DgjA4IL3mTHXE0odCXNx/qcOmrNjBYdU5va5IShreWXJdwB20VTGRBTo0UtHs62dHaGHNy
        mBe/+Vk6Gnlsjd5IbOkUnKLB8V4By316s+T6FrtD3qxpN5Kw7CvbvThAU2tp6vZfl8A2Mz
        vlp/tG5ymaKrZr0IH5iIGlCR1jw0aAA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-377-akDV5IjlMuqHo6s4pqNGKg-1; Mon, 20 Jan 2020 09:42:49 -0500
X-MC-Unique: akDV5IjlMuqHo6s4pqNGKg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id AEC7A107ACC9;
        Mon, 20 Jan 2020 14:42:47 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.43.17.70])
        by smtp.corp.redhat.com (Postfix) with SMTP id D980C7C34A;
        Mon, 20 Jan 2020 14:42:45 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Mon, 20 Jan 2020 15:42:47 +0100 (CET)
Date:   Mon, 20 Jan 2020 15:42:45 +0100
From:   Oleg Nesterov <oleg@redhat.com>
To:     Christian Brauner <christian.brauner@ubuntu.com>
Cc:     linux-api@vger.kernel.org, linux-kernel@vger.kernel.org,
        Tejun Heo <tj@kernel.org>, Li Zefan <lizefan@huawei.com>,
        Johannes Weiner <hannes@cmpxchg.org>, cgroups@vger.kernel.org
Subject: Re: [PATCH v4 1/6] cgroup: unify attach permission checking
Message-ID: <20200120144244.GD30403@redhat.com>
References: <20200117181219.14542-1-christian.brauner@ubuntu.com>
 <20200117181219.14542-2-christian.brauner@ubuntu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200117181219.14542-2-christian.brauner@ubuntu.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

I guess I am totally confused, but...

On 01/17, Christian Brauner wrote:
>
> +static inline bool cgroup_same_domain(const struct cgroup *src_cgrp,
> +				      const struct cgroup *dst_cgrp)
> +{
> +	return src_cgrp->dom_cgrp == dst_cgrp->dom_cgrp;
> +}
> +
> +static int cgroup_attach_permissions(struct cgroup *src_cgrp,
> +				     struct cgroup *dst_cgrp,
> +				     struct super_block *sb, bool thread)
> +{
> +	int ret = 0;
> +
> +	ret = cgroup_procs_write_permission(src_cgrp, dst_cgrp, sb);
> +	if (ret)
> +		return ret;
> +
> +	ret = cgroup_migrate_vet_dst(dst_cgrp);
> +	if (ret)
> +		return ret;
> +
> +	if (thread &&
> +	    !cgroup_same_domain(src_cgrp->dom_cgrp, dst_cgrp->dom_cgrp))
                                        ^^^^^^^^^^          ^^^^^^^^^^

             cgroup_same_domain(src_cgrp, dst_cgrp)

no?

And given that cgroup_same_domain() has no other users, perhaps it can
simply check

	     src_cgrp->dom_cgrp != dst_cgrp->dom_cgrp

?

Oleg.

