Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AA900E5084
	for <lists+cgroups@lfdr.de>; Fri, 25 Oct 2019 17:52:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2502313AbfJYPwh (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 25 Oct 2019 11:52:37 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:31001 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2502312AbfJYPwh (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 25 Oct 2019 11:52:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1572018756;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=F7ozuvXk8tbWjQzLtj2DAtfKZtAxllZ50ZDGOJC1UMA=;
        b=LMXmfIOEXDNypkNKKjtmUnCA4AMtml8tRbiROZ6IELmaqR6Y/enwUTxK7Mymn8HI+kflYY
        hIxjPm+azEj4P9q5nM8BUy8fjF3nIqLCMI4UTvLbFfYh23UAAIdb3dqhlJWRVpAj37GRw+
        fVOpXf95DOcWfHmI3IdcbWjyqDCNPsM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-176-pvYGhxm8PWuIUKDEovirTg-1; Fri, 25 Oct 2019 11:52:33 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A6E3E1005500;
        Fri, 25 Oct 2019 15:52:30 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.43.17.44])
        by smtp.corp.redhat.com (Postfix) with SMTP id 1D99F60852;
        Fri, 25 Oct 2019 15:52:26 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Fri, 25 Oct 2019 17:52:29 +0200 (CEST)
Date:   Fri, 25 Oct 2019 17:52:25 +0200
From:   Oleg Nesterov <oleg@redhat.com>
To:     Christian Brauner <christian.brauner@ubuntu.com>
Cc:     Tejun Heo <tj@kernel.org>, dvyukov@google.com,
        Li Zefan <lizefan@huawei.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        akpm@linux-foundation.org, arnd@arndb.de, deepa.kernel@gmail.com,
        ebiederm@xmission.com, elver@google.com, guro@fb.com,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        cgroups@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH cgroup/for-5.5] cgroup: remove
 cgroup_enable_task_cg_lists() optimization
Message-ID: <20191025155224.GC6020@redhat.com>
References: <0000000000003b1e8005956939f1@google.com>
 <20191021142111.GB1339@redhat.com>
 <20191024190351.GD3622521@devbig004.ftw2.facebook.com>
 <20191025125606.GI3622521@devbig004.ftw2.facebook.com>
 <20191025133358.pxpzxkhqc3mboi5x@wittgenstein>
 <20191025141325.GB6020@redhat.com>
 <20191025143224.wtwkkimqq4644iqq@wittgenstein>
MIME-Version: 1.0
In-Reply-To: <20191025143224.wtwkkimqq4644iqq@wittgenstein>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: pvYGhxm8PWuIUKDEovirTg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 10/25, Christian Brauner wrote:
>
> On Fri, Oct 25, 2019 at 04:13:25PM +0200, Oleg Nesterov wrote:
> > Almost every usage of task->flags (load or sore) can be reported as "da=
ta race".
> >=20
> > Say, you do
> >=20
> > =09if (task->flags & PF_KTHREAD)
> >=20
> > while this task does
> >=20
> > =09current->flags |=3D PF_FREEZER_SKIP;
> > =09schedule().
> >=20
> > this is data race.
>=20
> Right, but I thought we agreed on WONTFIX in those scenarios?
> The alternative is to READ_ONCE()/WRITE_ONCE() all of these.

Well, in my opinion this is WONTFIX, but I won't argue if someone
adds _ONCE to all of these. Same for task->state, exit_state, and
more.

Oleg.

