Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4FC6A198ECA
	for <lists+cgroups@lfdr.de>; Tue, 31 Mar 2020 10:45:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726488AbgCaIpp (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 31 Mar 2020 04:45:45 -0400
Received: from mail-qv1-f68.google.com ([209.85.219.68]:40069 "EHLO
        mail-qv1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726299AbgCaIpp (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 31 Mar 2020 04:45:45 -0400
Received: by mail-qv1-f68.google.com with SMTP id bp12so6427936qvb.7;
        Tue, 31 Mar 2020 01:45:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=WPmHARusSnaiKUVMtU99KCIM8nQK0a64r2bZ1V7If10=;
        b=bec0VgsFpnOofiwh5sjln5uyyX/r/BagIXYaHL+epFhYI7P96lPHazx5+jSe9j1llg
         8X4MWsu5s1rRUAVa7dRe45d9xEXFrhX/WLSKb5YaM5VF7L/+pDknpZXtVGFD+CxV1h6Q
         kjnc4xpEI/2rGqd8VunobqQ2qaNxQVaVfE0Tks9xemW3hJvQ1AMslQU07S4KuyB0Umyl
         woRzMaQo0v3r4JtENx5kVIlJjrsJ1D4Y2hjH78Fysu78MjIQCX+Ulekvs1FFiFJgRPCd
         oJ7wdJp3cqwzvEsygb935Gt9S397kS6ydbV9BDzkvTEkKhaSd8bF06pQNSUUJiHabrOt
         F0EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=WPmHARusSnaiKUVMtU99KCIM8nQK0a64r2bZ1V7If10=;
        b=tstKuUcm4T8k0fekj6tkznARYW9ewtTL0b71QUySd9hofuFZpX/OMTMKTTnUjG9Bmy
         eOqy+mkiXj9Sfm79IkZPMrqK3AYhfyTYuafmoZhy0+xo0XRWOCMrUseb8A2dV8i8VGNf
         0z1wdTA1+pxeJfeOv5jU+9tIuaWuEbEoje3ZFbvJcC774bigfVMvBskec3MTDWbq4/OU
         UGPMNfkZ2drsq+oEbIDvbOLDuZSL3vYLHn1NrDQLBXcGZkxa8sKzSPy8FEVWj0liPf4h
         KRgA7jZJrA1e1jINnm9beCbdo31WnvXyqAev30potdfYrg/DsEXOQo7VZXxXZxPjkTMk
         fdmA==
X-Gm-Message-State: ANhLgQ3SewYsBvQWEyWqG1oxwco6fZdKHk0vS8bWQ5mYx8F604DsgBvM
        aoyHrzQU0JiccYRW7bjM7n6XqYQuXfwbXWcMMGQ=
X-Google-Smtp-Source: ADFU+vtcFvanxEfpz9ho1ceeElm5jK+B9Ire09exrXDJSzoS2anM4XdYgnSXs9JGRfbSdbJLrWxUx7Bm9Yn1R4HGwhg=
X-Received: by 2002:a0c:aee5:: with SMTP id n37mr14869258qvd.173.1585644344479;
 Tue, 31 Mar 2020 01:45:44 -0700 (PDT)
MIME-Version: 1.0
References: <20200327062859.GA12588@192.168.3.9> <20200331082505.GA14655@infradead.org>
In-Reply-To: <20200331082505.GA14655@infradead.org>
From:   Weiping Zhang <zwp10758@gmail.com>
Date:   Tue, 31 Mar 2020 16:45:33 +0800
Message-ID: <CAA70yB5cWESKW600Lwoi8toPaiDtOVH53P8GSou6uukmX5mvgQ@mail.gmail.com>
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
=97=A5=E5=91=A8=E4=BA=8C =E4=B8=8B=E5=8D=884:25=E5=86=99=E9=81=93=EF=BC=9A
>
> On Fri, Mar 27, 2020 at 02:28:59PM +0800, Weiping Zhang wrote:
> > Change-Id: Ibb9caf20616f83e111113ab5c824c05930c0e523
> > Signed-off-by: Weiping Zhang <zhangweiping@didiglobal.com>
>
> This needs a commit description and loose the weird change id.
>
OK, I rewirte commit description, it record the timestamp of issue bio
to the disk driver,
then we can get the delta time in rq_qos_done_bio. It's same as the D2C tim=
e
of blktrace.
> I also think oyu need to fins a way to not bloat the bio even more,
> cgroup is a really bad offender for bio size.
struct request {
    u64 io_start_time_ns;
also record this timestamp, I'll check if we can use it.

Thanks a lot
