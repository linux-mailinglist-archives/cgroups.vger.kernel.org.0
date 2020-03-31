Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E2E87199470
	for <lists+cgroups@lfdr.de>; Tue, 31 Mar 2020 12:57:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730547AbgCaK5C (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 31 Mar 2020 06:57:02 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:45573 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730549AbgCaK5C (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 31 Mar 2020 06:57:02 -0400
Received: by mail-qk1-f196.google.com with SMTP id c145so22413777qke.12;
        Tue, 31 Mar 2020 03:57:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=D4IVQ7JDKhY91r0DBf8xKIDAIEvpogwte6mgLoTb3Oc=;
        b=JfkWb4TT+RcwZGVAEmdXuwffw1dfSxUEjBTdhxma75/CCqNb0D+er5mivvJaJjGP/f
         nzZmBa0fReQdx/vRYCYbYL8WNExei7LxxJ3+VUiJqprPDJE+QUJeLaKcmPyF1Ph+2GLV
         GKOAdUZFS7j8nQwKD9Am+IBe0SGt5rJK2um1HUW01epaPSrjSVSU1tRREn/Rbyi2CYza
         mS0cKkM9E5HARhZxH7ix4FvpdQRAR/X06gn/xxUhcYFy8hEiu8CU2IotM9TqUyc02ujX
         F+HjHjz25LhISTm3rPs0U6d4JmKL8Vhf7PmA4vLYnImRPA8EjrCyQitAFbHhvw9QZzUA
         b4eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=D4IVQ7JDKhY91r0DBf8xKIDAIEvpogwte6mgLoTb3Oc=;
        b=qiZ/UV0GdagjHS1CfTRKEd+zekMw3mIXdyEfg93SDrTzXghVTSmX4ajxdRRwpt8Ny8
         vhvOObG1eA7Tckz3Yg4yrrRUe8bWbC+yOEIRm3gCJAflx9XxngMlEMY0A6xki6csBOYX
         gWSKnTe8JogcgutfPykwBYoFJu8hPBtJ+ARssuyDkuglDt5sVV3QF4jNJbtF2qpqKVA7
         nReZA1F9UFD0A4nrq4SbGV5V8YPfuT/1wkUjQuwABW0LFXwTLs0iUyfKOoHPObmH77nz
         HQmCM1ThqE9nEIn7GlfKO9VeghBhTsq1GcduhrVh7LxhT+XHC10XH3l0mN1+BFIPhnxh
         ZiKw==
X-Gm-Message-State: ANhLgQ39R6/jdJhgxlJ+L3PYD7uBibPoKqQWwHty7lli74gh0Vq/5xGb
        lcfbQHgNvNE7m0+cBUyey2D6BCRaeJ535EDPGb1mR6qWyRA2ZA==
X-Google-Smtp-Source: ADFU+vsJUzQh/HN+3E3pxtBhLIWFfPDM8kvthWg8c+r6LvGrzF4MTuZ7C95fvA5oG5eZv7VVxgH72uevMTfHH2LjPA8=
X-Received: by 2002:a37:8b04:: with SMTP id n4mr4265340qkd.222.1585652220814;
 Tue, 31 Mar 2020 03:57:00 -0700 (PDT)
MIME-Version: 1.0
References: <20200327062859.GA12588@192.168.3.9> <20200331082505.GA14655@infradead.org>
 <CAA70yB5cWESKW600Lwoi8toPaiDtOVH53P8GSou6uukmX5mvgQ@mail.gmail.com> <20200331091644.GB12040@infradead.org>
In-Reply-To: <20200331091644.GB12040@infradead.org>
From:   Weiping Zhang <zwp10758@gmail.com>
Date:   Tue, 31 Mar 2020 18:56:49 +0800
Message-ID: <CAA70yB5JeK0F_N_qcCaBeAUUUU=8TErV9EXONRGDmqkJ8bKRvA@mail.gmail.com>
Subject: Re: [RFC PATCH v2 2/3] bio: track timestamp of submitting bio the
 disk driver
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Jens Axboe <axboe@kernel.dk>, Tejun Heo <tj@kernel.org>,
        linux-block@vger.kernel.org, cgroups@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Christoph Hellwig <hch@infradead.org> =E4=BA=8E2020=E5=B9=B43=E6=9C=8831=E6=
=97=A5=E5=91=A8=E4=BA=8C =E4=B8=8B=E5=8D=885:16=E5=86=99=E9=81=93=EF=BC=9A
>
> On Tue, Mar 31, 2020 at 04:45:33PM +0800, Weiping Zhang wrote:
> > Christoph Hellwig <hch@infradead.org> =E4=BA=8E2020=E5=B9=B43=E6=9C=883=
1=E6=97=A5=E5=91=A8=E4=BA=8C =E4=B8=8B=E5=8D=884:25=E5=86=99=E9=81=93=EF=BC=
=9A
> > >
> > > On Fri, Mar 27, 2020 at 02:28:59PM +0800, Weiping Zhang wrote:
> > > > Change-Id: Ibb9caf20616f83e111113ab5c824c05930c0e523
> > > > Signed-off-by: Weiping Zhang <zhangweiping@didiglobal.com>
> > >
> > > This needs a commit description and loose the weird change id.
> > >
> > OK, I rewirte commit description, it record the timestamp of issue bio
> > to the disk driver,
> > then we can get the delta time in rq_qos_done_bio. It's same as the D2C=
 time
> > of blktrace.
> > > I also think oyu need to fins a way to not bloat the bio even more,
> > > cgroup is a really bad offender for bio size.
> > struct request {
> >     u64 io_start_time_ns;
> > also record this timestamp, I'll check if we can use it.
>
> But except for a few exceptions bios are never issued directly to the
> driver, requests are.  And the few exception (rsxx, umem) probably should
> be rewritten to use requests.  And with generic_{start,end}_io_acct we
> already have helpers to track bio based stats, which we should not
> duplicate just for cgroups.
generic_{start,end}_io_acct and blk_account_io_done,
these two method use the a timeline (part->stamp), but cgroup doesn't have,
so cgroup cann't use these general helper to counting the total io ticks
for read,write and others. Block cgroup use delta =3D now -
bio->bi_issue[issue_time]
to counting total io ticks.

How about move it into the blk-iotrack code, rq_qos_issue will call the
rq_qos_ops.issue,  then if user doesn't enable blk-iotrack, these code
will not be executed.

Thanks
