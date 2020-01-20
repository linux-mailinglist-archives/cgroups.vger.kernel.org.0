Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AAFDC142D3F
	for <lists+cgroups@lfdr.de>; Mon, 20 Jan 2020 15:22:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728890AbgATOWM (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 20 Jan 2020 09:22:12 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:23318 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726942AbgATOWL (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 20 Jan 2020 09:22:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1579530130;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=PWUAb8tz3AF3amrWTTvwK6sWsIt1KM7KTKlRn37IBoI=;
        b=eRlnH9aeOt76BUdwO/+rScKZ6mNtszQ1q2zfn2XRxRu7jqcnCLXV+cwX1MQ1zwiVV5elnu
        E042ve2NAObJq+Ao4oaDuTXHTVuK6GfMpnXri3ZbPgkeyOVywFe10jpG1tkY6lM08kPqv2
        tFq20LSesihwSpLraqy+OXiRuMwmq+Q=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-204-Xfydzjv0MEyD7aQHqD5dgg-1; Mon, 20 Jan 2020 09:22:07 -0500
X-MC-Unique: Xfydzjv0MEyD7aQHqD5dgg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E312C800D5C;
        Mon, 20 Jan 2020 14:22:05 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.43.17.70])
        by smtp.corp.redhat.com (Postfix) with SMTP id E54B460C05;
        Mon, 20 Jan 2020 14:22:03 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Mon, 20 Jan 2020 15:22:05 +0100 (CET)
Date:   Mon, 20 Jan 2020 15:22:03 +0100
From:   Oleg Nesterov <oleg@redhat.com>
To:     Christian Brauner <christian.brauner@ubuntu.com>
Cc:     linux-api@vger.kernel.org, linux-kernel@vger.kernel.org,
        Tejun Heo <tj@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Li Zefan <lizefan@huawei.com>, cgroups@vger.kernel.org
Subject: Re: [PATCH v4 3/6] cgroup: refactor fork helpers
Message-ID: <20200120142202.GC30403@redhat.com>
References: <20200117181219.14542-1-christian.brauner@ubuntu.com>
 <20200117181219.14542-4-christian.brauner@ubuntu.com>
 <20200120140029.GB30403@redhat.com>
 <20200120140452.qyjogmmhyqc3gxon@wittgenstein>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200120140452.qyjogmmhyqc3gxon@wittgenstein>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 01/20, Christian Brauner wrote:
>
> On Mon, Jan 20, 2020 at 03:00:30PM +0100, Oleg Nesterov wrote:
> > This is probably the only patch in series I can understand ;)
> >
> > To me it looks like a good cleanup regardless, but
> >
> > On 01/17, Christian Brauner wrote:
> > >
> > > The patch just passes in the parent task_struct
> >
> > For what? "parent" is always "current", no?
>
> Yes. What exactly are you hinting at? :) Would you prefer that the
> commit message speaks of "current" instead of "parent"?

I meant, I don't understand why did you add the new "parent" arg,
cgroup_xxx_fork() can simply use "current" ?

Oleg.

